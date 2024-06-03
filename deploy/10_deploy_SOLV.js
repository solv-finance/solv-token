const colors = require('colors');

module.exports = async ({ getNamedAccounts, deployments, network }) => {
  const { deployer } = await getNamedAccounts();
  const { deploy } = deployments;

  const instance = await deploy('SOLV', {
    contract: 'SOLV',
    from: deployer,
    args: [ deployer ],
    deterministicDeployment: ethers.encodeBytes32String("SOLV"),
    log: true,
  });
  console.log(` INFO: ${colors.yellow(`SOLV`)} deployed at ${colors.green(instance.address)} on ${colors.red(network.name)}`);
};

module.exports.tags = ['SOLV']
