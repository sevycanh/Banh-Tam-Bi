const Order = require("../models/Order");
const OrderDetail = require("../models/OrderDetail");
const Product = require("../models/Product");
const User = require("../models/User");
const {
  multipleMongooseToObject,
  mongooseToObject,
} = require("../util/mongoose");
module.exports = {
  getCart: (req, res) => {
    let products;
    try {
      const cookies = req.cookies.products;
      if (cookies) {
        if (typeof localStorage === "undefined" || localStorage === null) {
          var LocalStorage = require("node-localstorage").LocalStorage;
          localStorage = new LocalStorage("./scratch");
        }
        const token = localStorage.getItem("token");

        products = JSON.parse(cookies);
        const getProductInfo = async () => {
          const cartProducts = [];
          for (const product of products) {
            const productInfo = await getProductsByProductId(product.productId);
            if (productInfo) {
              productInfo._doc.quantity = product.quantity;
              cartProducts.push(productInfo);
            }
          }
          return cartProducts;
        };

        Promise.all([
          getProductInfo(),
          User.findOne({ _id: req.data.id }),
        ]).then(([cartProducts, user]) => {
          res.render("payment/cart", {
            cartProducts: multipleMongooseToObject(cartProducts),
            user: mongooseToObject(user),
            token: token,
            data: {
              isAdmin:
                req.data && req.data.isAdmin !== undefined
                  ? req.data.isAdmin
                  : -1,
              id: req.data && req.data.id !== undefined ? req.data.id : -1,
            },
          });
        });
        // getProductInfo()
        //   .then((cartProducts) => {
        //     res.render("payment/cart", {
        //       cartProducts: multipleMongooseToObject(cartProducts),
        //       data: {
        //         isAdmin:
        //           req.data && req.data.isAdmin !== undefined
        //             ? req.data.isAdmin
        //             : -1,
        //         id: req.data && req.data.id !== undefined ? req.data.id : -1,
        //       },
        //     });
        //   })
        //   .catch((error) => {
        //     res.status(500).json({ error: "Đã xảy ra lỗi khi xử lý giỏ hàng" });
        //   });
      } else {
        res.render("payment/cart", {
          data: {
            isAdmin:
              req.data && req.data.isAdmin !== undefined
                ? req.data.isAdmin
                : -1,
            id: req.data && req.data.id !== undefined ? req.data.id : -1,
          },
        });
      }
    } catch (error) {
      res.status(500).json(error);
      // res.render("payment/cart", {
      //   data: {
      //     isAdmin:
      //       req.data && req.data.isAdmin !== undefined ? req.data.isAdmin : -1,
      //     id: req.data && req.data.id !== undefined ? req.data.id : -1,
      //   },
      // });
    }
  },

  createOrder: async (req, res) => {
    const newOrder = new Order(req.body.order);
    try {
      const order = await newOrder.save();
      if (order) {
        const newOrderDetail = new OrderDetail({
          orderId: order._doc._id,
          products: req.body.products,
        });
        const orderDetail = await newOrderDetail.save();
        if (orderDetail) {
          res.status(201).json({
            message: "Created Order",
          });
        } else {
          res.status(500).json({
            message: "Create Fail OrderDetail",
          });
        }
      } else {
        res.status(500).json({
          message: "Create Fail Order",
        });
      }
    } catch (error) {
      res.status(500).json(error);
    }
  },
};

const getProductsByProductId = async (productId) => {
  try {
    const product = await Product.findOne({ _id: productId });
    return product;
  } catch (error) {
    console.error("Lỗi khi lấy sản phẩm");
    return null;
  }
};

// const calculateDistance = async () => {
//   try {
//     const apiKey = process.env.GOOGLE_API_KEY;
//     const deliveryAddress =
//       "111 Đ. Trần Bình Trọng, Phường 2, Quận 5, Hồ Chí Minh, Vietnam";
//     const vendorAddress =
//       "344 Tên Lửa, Bình Trị Đông B, Bình Tân, Hồ Chí Minh 70000, Vietnam";
//     const apiUrl = `https://maps.googleapis.com/maps/api/distancematrix/json?destinations=${vendorAddress}&origins=${deliveryAddress}&units=imperial&key=${apiKey}`;

//     const res = await axios.get(apiUrl);
//     console.log(res.data);
//   } catch (error) {
//     console.log(error);
//   }
// };
