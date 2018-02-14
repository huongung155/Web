/**
 * Created by huong on 12/24/2017.
 */
var faker = require("faker");
var companyName = faker.company.companyName();
var price = faker.commerce.price();

console.log("==================");
console.log("WELCOME TO MY SHOP");
console.log("==================");
for(var i = 0; i <  10; i++){
    console.log(companyName + " - $" + price);
    companyName = faker.company.companyName();
    price = faker.commerce.price();
}