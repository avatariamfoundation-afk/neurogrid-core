// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./NeuroGridKernel.sol";

/**
 * @title ComputeRegistry
 * @author NeuroGrid
 * @notice Registry and coordination layer for off-chain compute providers.
 *
 * PURPOSE
 * -------
 * This contract tracks authorized compute nodes (AI agents, inference
 * workers, research compute providers) that interact with NeuroGrid.
 *
 * It does NOT:
 * - execute computation
 * - store biomedical data
 * - handle payments directly
 *
 * It DOES:
 * - register compute providers
 * - manage activation / deactivation
 * - emit verifiable on-chain receipts for compute execution
 *
 * SECURITY MODEL
 * --------------
 * - Kernel enforces global lifecycle state
 * - Registry enforces provider authorization
 * - Off-chain systems listen to emitted events
 */

contract ComputeRegistry {

    /*//////////////////////////////////////////////////////////////
                                ERRORS
    //////////////////////////////////////////////////////////////*/

    error NotAdmin();
    error NotKernelActive();
    error AlreadyRegistered();
    error NotRegistered();
    error ProviderInactive();
    error ZeroAddress();

    /*//////////////////////////////////////////////////////////////
                                EVENTS
    //////////////////////////////////////////////////////////////*/

    event ProviderRegistered(address indexed provider, string metadataURI);
    event ProviderDeactivated(address indexed provider);
    event ProviderReactivated(address indexed provider);

    event ComputeReceipt(
        address indexed provider,
        bytes32 indexed jobId,
        bytes32 indexed resultHash,
        uint256 timestamp
    );

    /*//////////////////////////////////////////////////////////////
                                STRUCTS
    //////////////////////////////////////////////////////////////*/

    struct Provider {
        bool registered;
        bool active;
        uint256 registeredAt;
        string metadataURI; // IPFS / Arweave / HTTPS descriptor
    }

    /*//////////////////////////////////////////////////////////////
                            STORAGE VARIABLES
    //////////////////////////////////////////////////////////////*/

    /// @notice NeuroGrid kernel reference
    NeuroGridKernel public immutable kernel;

    /// @notice Admin authority (mirrors kernel admin)
    address public admin;

    /// @notice Mapping of compute providers
    mapping(address => Provider) public providers;

    /// @notice Total registered providers
    uint256 public providerCount;

    /*//////////////////////////////////////////////////////////////
                                MODIFIERS
    //////////////////////////////////////////////////////////////*/

    modifier onlyAdmin() {
        if (msg.sender != admin) revert NotAdmin();
        _;
    }

    modifier kernelActive() {
        if (!kernel.isActive()) revert NotKernelActive();
        _;
    }

    modifier providerExists(address provider) {
        if (!providers[provider].registered) revert NotRegistered();
        _;
    }

    modifier providerIsActive(address provider) {
        if (!providers[provider].active) revert ProviderInactive();
        _;
    }

    /*//////////////////////////////////////////////////////////////
                                CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(address kernelAddress) {
        if (kernelAddress == address(0)) revert ZeroAddress();

        kernel = NeuroGridKernel(kernelAddress);
        admin = kernel.admin();
    }

    /*//////////////////////////////////////////////////////////////
                        PROVIDER MANAGEMENT
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Register a new compute provider.
     * @param provider Address of the compute node / agent
     * @param metadataURI Off-chain descriptor (capabilities, versioning, etc.)
     */
    function registerProvider(
        address provider,
        string calldata metadataURI
    ) external onlyAdmin kernelActive {
        if (provider == address(0)) revert ZeroAddress();
        if (providers[provider].registered) revert AlreadyRegistered();

        providers[provider] = Provider({
            registered: true,
            active: true,
            registeredAt: block.timestamp,
            metadataURI: metadataURI
        });

        providerCount += 1;

        emit ProviderRegistered(provider, metadataURI);
    }

    /**
     * @notice Deactivate a compute provider.
     */
    function deactivateProvider(address provider)
        external
        onlyAdmin
        providerExists(provider)
    {
        providers[provider].active = false;
        emit ProviderDeactivated(provider);
    }

    /**
     * @notice Reactivate a compute provider.
     */
    function reactivateProvider(address provider)
        external
        onlyAdmin
        providerExists(provider)
    {
        providers[provider].active = true;
        emit ProviderReactivated(provider);
    }

    /*//////////////////////////////////////////////////////////////
                        COMPUTE RECEIPTS
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Emit a verifiable compute receipt.
     * @dev Called by active compute providers after job completion.
     *
     * @param jobId Unique identifier for the compute task
     * @param resultHash Hash of result artifact (model output, proof, etc.)
     */
    function emitComputeReceipt(
        bytes32 jobId,
        bytes32 resultHash
    )
        external
        kernelActive
        providerExists(msg.sender)
        providerIsActive(msg.sender)
    {
        emit ComputeReceipt(
            msg.sender,
            jobId,
            resultHash,
            block.timestamp
        );
    }

    /*//////////////////////////////////////////////////////////////
                        ADMIN SYNC
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Sync admin with Kernel admin.
     * @dev Callable after governance upgrades Kernel admin.
     */
    function syncAdmin() external {
        admin = kernel.admin();
    }

    /*//////////////////////////////////////////////////////////////
                        VIEW HELPERS
    //////////////////////////////////////////////////////////////*/

    function isProviderActive(address provider) external view returns (bool) {
        return providers[provider].registered && providers[provider].active;
    }

    /*//////////////////////////////////////////////////////////////
                        STORAGE GAP (UPGRADE SAFETY)
    //////////////////////////////////////////////////////////////*/

    uint256[50] private __gap;
}
