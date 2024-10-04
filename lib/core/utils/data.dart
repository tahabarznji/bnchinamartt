// Map<String, dynamic> currentUser = {
//   "username": "Shadyar",
//   "email": "shadyar@gmail.com",
//   "password": "12121212",
//   "discount": 0,
// };

List<Map<String, dynamic>> coubons = [
  {
    "code": "2314",
    "discount": 20,
  },
  {
    "code": "2114",
    "discount": 30,
  },
  {
    "code": "1114",
    "discount": 100,
  },
  {
    "code": "2333",
    "discount": 5,
  },
  {
    "code": "2364",
    "discount": 25,
  },
];

// List<Map<String, dynamic>> accounts = [
//   {
//     "username": "Shadyar",
//     "email": "shadyar@gmail.com",
//     "password": "12121212",
//     "discount": 0,
//   },
//   {
//     "username": "Aren",
//     "email": "aren@gmail.com",
//     "password": "12121212",
//     "discount": 0,
//   },
//   {
//     "username": "Hevar",
//     "email": "hevar@gmail.com",
//     "password": "12121212",
//     "discount": 0,
//   },
//   {
//     "username": "Arkan",
//     "email": "arkan@gmail.com",
//     "password": "12121212",
//     "discount": 0,
//   },
// ];

List<Map<String, dynamic>> basketProducts = [
  {
    "name": "Banana",
    "imgPath": "assets/images/products/banana.png",
    "details": "Food Details",
    "price": 1500,
    "category": "Fruits",
    "isTrending": true,
    "quantity": 1,
    "totalPrice": 1500,
  },
];

List<Map<String, dynamic>> orders = [];

List<Map<String, dynamic>> categories = [
  {
    "name": "Milk",
    "imgPath": "assets/images/categories/milk.png",
    "discount": 20,
    "isTop": false,
  },
  {
    "name": "Coffee",
    "imgPath": "assets/images/categories/coffee.png",
    "discount": 30,
    "isTop": false,
  },
  {
    "name": "Meat",
    "imgPath": "assets/images/categories/meat.png",
    "discount": 20,
    "isTop": true,
  },
  {
    "name": "Drinks",
    "imgPath": "assets/images/categories/drinks.png",
    "discount": 20,
    "isTop": false,
  },
  {
    "name": "Fruits",
    "imgPath": "assets/images/categories/fruits.png",
    "discount": 15,
    "isTop": true,
  },
  {
    "name": "Greens",
    "imgPath": "assets/images/categories/greens.png",
    "discount": 20,
    "isTop": true,
  },
  {
    "name": "Snacks",
    "imgPath": "assets/images/categories/snacks.png",
    "discount": 10,
    "isTop": true,
  },
  {
    "name": "Protein",
    "imgPath": "assets/images/categories/protein.png",
    "discount": 25,
    "isTop": false,
  },
  {
    "name": "Bread",
    "imgPath": "assets/images/categories/bread.png",
    "discount": 15,
    "isTop": false,
  },
  {
    "name": "Seafood",
    "imgPath": "assets/images/categories/seafood.png",
    "discount": 18,
    "isTop": false,
  },
];

List<Map<String, dynamic>> products = [
  {
    "name": "Watermelon",
    "imgPath": "assets/images/products/watermelon.png",
    "details": "Food Details",
    "price": 1500,
    "category": "Fruits",
    "isTrending": true,
  },
  {
    "name": "Chips",
    "imgPath": "assets/images/products/chips.png",
    "details": "Food Details",
    "price": 1500,
    "category": "Snacks",
    "isTrending": true,
  },
  {
    "name": "Coffee",
    "imgPath": "assets/images/products/coffee.png",
    "details": "Food Details",
    "price": 1500,
    "category": "Coffee",
    "isTrending": true,
  },
  {
    "name": "Milk",
    "imgPath": "assets/images/products/milk.png",
    "details": "Food Details",
    "price": 1500,
    "category": "Milk",
    "isTrending": true,
  },
  {
    "name": "Neutonic",
    "imgPath": "assets/images/products/neutonic.png",
    "details": "Food Details",
    "price": 1500,
    "category": "Drinks",
    "isTrending": true,
  },
  {
    "name": "Pepsi",
    "imgPath": "assets/images/products/pepsi.png",
    "details": "Food Details",
    "price": 1500,
    "category": "Drinks",
    "isTrending": true,
  },
  {
    "name": "Redbull",
    "imgPath": "assets/images/products/redbull.png",
    "details": "Food Details",
    "price": 1500,
    "category": "Drinks",
    "isTrending": true,
  },
  {
    "name": "Kinder",
    "imgPath": "assets/images/products/kinder.png",
    "details": "Snack Details",
    "price": 1500,
    "category": "Snacks",
    "isTrending": true,
  },
  {
    "name": "Banana",
    "imgPath": "assets/images/products/banana.png",
    "details": "Food Details",
    "price": 1500,
    "category": "Fruits",
    "isTrending": true,
  },
  {
    "name": "Broccoli",
    "imgPath": "assets/images/products/broccoli.png",
    "details": "Food Details",
    "price": 1500,
    "category": "Greens",
    "isTrending": true,
  },
  {
    "name": "Lemon",
    "imgPath": "assets/images/products/lemon.png",
    "details": "Food Details",
    "price": 1500,
    "category": "Fruits",
    "isTrending": true,
  },
  {
    "name": "Orange",
    "imgPath": "assets/images/products/orange.png",
    "details": "Food Details",
    "price": 1500,
    "category": "Fruits",
    "isTrending": true,
  },
  {
    "name": "Yogurt",
    "imgPath": "assets/images/products/yogurt.png",
    "details": "Beverage Details",
    "price": 1500,
    "category": "Milk",
    "isTrending": false,
  },
  {
    "name": "Salmon",
    "imgPath": "assets/images/products/salmon.png",
    "details": "Seafood Details",
    "price": 1500,
    "category": "Seafood",
    "isTrending": false,
  },
  {
    "name": "Apple",
    "imgPath": "assets/images/products/apple.png",
    "details": "Food Details",
    "price": 1500,
    "category": "Fruits",
    "isTrending": false,
  },
];
