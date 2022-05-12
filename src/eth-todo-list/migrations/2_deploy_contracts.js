// const TodoList = artifacts.require("./TodoList.sol");
// const CharityList = artifacts.require("./CharityList.sol");
const Poll = artifacts.require("./Poll.sol");

module.exports = function (deployer) {
  deployer.deploy(Poll);
};
// module.exports = function (deployer, network, addresses) {
//   deployer.deploy();
// };
