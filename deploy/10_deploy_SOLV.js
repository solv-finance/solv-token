const colors = require('colors');

module.exports = async ({ getNamedAccounts, deployments, network }) => {
  const { deployer } = await getNamedAccounts();
  const { deploy } = deployments;
  const initHolders = {
    'sepolia': deployer,
    'mainnet': '0x8749b13fe36C72B745F948f91Fb2Ffec3B63bf75',
  }

  const instance = await deploy('SOLV', {
    contract: 'SOLV',
    from: deployer,
    args: [ initHolders[network.name] ],
    deterministicDeployment: ethers.encodeBytes32String("SOLV"),
    log: true,
  });
  console.log(` INFO: ${colors.yellow(`SOLV`)} deployed at ${colors.green(instance.address)} on ${colors.red(network.name)}`);
};

module.exports.tags = ['SOLV']
