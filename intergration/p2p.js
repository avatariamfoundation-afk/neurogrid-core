const Libp2p = require('libp2p');
const TCP = require('libp2p-tcp');
const { NOISE } = require('libp2p-noise');
const MPLEX = require('libp2p-mplex');
const config = require('../config/app');

async function startP2PNode() {
  const libp2p = await Libp2p.create({
    addresses: { listen: [`/ip4/0.0.0.0/tcp/${config.p2pPort}`] },
    modules: {
      transport: [TCP],
      connEncryption: [NOISE],
      streamMuxer: [MPLEX],
    },
  });

  await libp2p.start();
  console.log(`P2P node started on port ${config.p2pPort}`);

  libp2p.handle('/neurogrid/1.0.0', async ({ stream }) => {
    console.log('Received P2P message');
    // Implement message handling logic here
  });

  return libp2p;
}

module.exports = { startP2PNode };
