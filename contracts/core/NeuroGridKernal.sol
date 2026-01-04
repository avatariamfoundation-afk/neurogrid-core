enum GridState {
    Init,
    Active,
    Paused,
    Sunset
}
GridState public gridState;
modifier onlyActive() {
    require(gridState == GridState.Active, "Grid not active");
    _;
}
Lifecycle Functions

activateGrid()

pauseGrid()

sunsetGrid()

Each must:

emit events

be admin-gated

event GridActivated();
event GridPaused();
event GridSunset();

uint256[50] private __gap;
