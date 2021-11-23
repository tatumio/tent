const {
  ethers,
  upgrades,
} = require('hardhat');

async function main () {
  // Deploying
  const Tent = await ethers.getContractFactory('Tent');
  const Goldax = await ethers.getContractFactory('Goldax');
  const EurTent = await ethers.getContractFactory('EurTent');
  const tent = await upgrades.deployProxy(Tent, [
    'Tent', 'TNT',
  ]);
  await tent.deployed();
  console.log(tent.deployTransaction.creates);
  await tent.renounceRole('0x9f2df0fed2c77648de5860a4cc508cd0818c85b8b8a1ab4ceeef8d981c8956a6', '0x80d8bac9a6901698b3749fe336bbd1385c1f98f2');
  await tent.renounceRole('0x65d7a28e3265b37a6474929f336521b332c1681b933f6cb9f3376673440d862a', '0x80d8bac9a6901698b3749fe336bbd1385c1f98f2');
  const goldax = await upgrades.deployProxy(Goldax, [
    'Goldax', 'GLDX',
  ]);
  await goldax.deployed();
  console.log(goldax.deployTransaction.creates);
  await goldax.renounceRole('0x9f2df0fed2c77648de5860a4cc508cd0818c85b8b8a1ab4ceeef8d981c8956a6', '0x80d8bac9a6901698b3749fe336bbd1385c1f98f2');
  await goldax.renounceRole('0x65d7a28e3265b37a6474929f336521b332c1681b933f6cb9f3376673440d862a', '0x80d8bac9a6901698b3749fe336bbd1385c1f98f2');

  const eurTent = await upgrades.deployProxy(EurTent, [
    'EurTent', 'ETNT',
  ]);
  await eurTent.deployed();
  console.log(eurTent.deployTransaction.creates);
  await eurTent.mint('0x12F87F7793fACd5A7C07204db194CF2F4891C799', '0xfafafafaddddd');
  await eurTent.renounceRole('0x9f2df0fed2c77648de5860a4cc508cd0818c85b8b8a1ab4ceeef8d981c8956a6', '0x80d8bac9a6901698b3749fe336bbd1385c1f98f2');
  await eurTent.renounceRole('0x65d7a28e3265b37a6474929f336521b332c1681b933f6cb9f3376673440d862a', '0x80d8bac9a6901698b3749fe336bbd1385c1f98f2');
}

main();
