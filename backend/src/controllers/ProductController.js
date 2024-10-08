const Product = require("../models/Product");
const {
  multipleMongooseToObject,
  mongooseToObject,
} = require("../util/mongoose");

module.exports = {
  getAllProduct: async (req, res) => {
    try {
      const pageSize = 6;
      const page = req.query.page || 1;

      const skipProducts = (page - 1) * pageSize;

      const products = await Product.find().skip(skipProducts).limit(pageSize);
      const productsSortDeleted = await Product.countDocumentsWithDeleted({
        deleted: true,
      });
      const totalProduct = await Product.countDocuments({});

      res.render("product/get", {
        data: {
          isAdmin: true,
          id: req.data && req.data.id !== undefined ? req.data.id : -1,
        },
        products: multipleMongooseToObject(products),
        productsSortDeleted,
        totalProducts: totalProduct,
        totalPage: Math.ceil(totalProduct / pageSize),
      });
    } catch (error) {
      res.status(500).json("Lỗi get all product");
    }
  },

  createProductPage: (req, res) => {
    res.render("product/create", {
      data: {
        isAdmin: true,
        id: req.data && req.data.id !== undefined ? req.data.id : -1,
      },
    });
  },

  createProduct: async (req, res) => {
    const newProduct = new Product(req.body);
    try {
      await newProduct.save();
      res.redirect("/products");
    } catch (error) {
      res.status(500).json("Lỗi tạo sản phẩm");
    }
  },

  stopSellingProduct: (req, res) => {
    Product.delete({ _id: req.params.id })
      .then(() => res.redirect("back"))
      .catch(() => res.status(500).json("Lỗi dừng bán sản phẩm"));
  },

  getTrash: (req, res) => {
    Product.findWithDeleted({ deleted: true })
      .then((products) =>
        res.render("product/trash", {
          data: {
            isAdmin: true,
            id: req.data && req.data.id !== undefined ? req.data.id : -1,
          },
          products: multipleMongooseToObject(products),
        })
      )
      .catch(() => res.status(500).json("Lỗi lấy sản phẩm dừng bán"));
  },

  restoreProduct: (req, res) => {
    Product.restore({ _id: req.params.id })
      .then(() => res.redirect("back"))
      .catch(() => res.status(500).json("Lỗi restore sản phẩm"));
  },

  destroyProduct: (req, res) => {
    Product.deleteOne({ _id: req.params.id })
      .then(() => res.redirect("back"))
      .catch(() => res.status(500).json("Lỗi xóa sản phẩm"));
  },

  editPage: (req, res) => {
    Product.findOne({ _id: req.params.id }).then((product) =>
      res.render("product/update", {
        data: {
          isAdmin: true,
          id: req.data && req.data.id !== undefined ? req.data.id : -1,
        },
        product: mongooseToObject(product),
      })
    );
  },

  editProduct: (req, res) => {
    Product.updateOne({ _id: req.params.id }, req.body)
      .then(() => res.redirect("/products"))
      .catch(() => res.status(500).json("Lỗi sửa sản phẩm"));
  },

  stopProductsIsChecked: (req, res) => {
    Product.delete({ _id: { $in: req.body.productsIds } })
      .then(() => res.redirect("back"))
      .catch(() => res.status(500).json("Lỗi dừng bán các sản phẩm đã chọn"));
  },

  resumeProductsIsChecked: (req, res) => {
    Product.restore({ _id: { $in: req.body.productsIds } })
      .then(() => res.redirect("back"))
      .catch(() => res.status(500).json("Lỗi dừng bán các sản phẩm đã chọn"));
  },

  getMonChinh: (req, res) => {
    getProductsByCategoryId(req, res, "1");
  },

  getMonPhu: (req, res) => {
    getProductsByCategoryId(req, res, "2");
  },

  getNuocUong: (req, res) => {
    getProductsByCategoryId(req, res, "3");
  },

  showInfoProduct: (req, res) => {
    Product.findOne({ slug: req.params.slug })
      .then((product) => {
        res.render("product/show", {
          product: mongooseToObject(product),
          data: {
            isAdmin:
              req.data && req.data.isAdmin !== undefined
                ? req.data.isAdmin
                : -1,
            id: req.data && req.data.id !== undefined ? req.data.id : -1,
          },
        });
      })
      .catch(() => res.status(500).json("Lỗi show thông tin sản phẩm"));
  },

  searchProduct: (req, res) => {
    const pageSize = 6;
    const page = req.query.page || 1;

    const skipProducts = (page - 1) * pageSize;
    Product.find({
      name: { $regex: req.params.key, $options: "i" },
      deleted: false,
    })
      .skip(skipProducts)
      .limit(pageSize)
      .then((products) => {
        return res.status(200).json(products);
      })
      .catch((err) => {
        return res.status(500).json(err);
      });
  },
};

const getProductsByCategoryId = (req, res, categoryId) => {
  const pageSize = 6;
  const page = req.query.page || 1;

  const skipProducts = (page - 1) * pageSize;
  Product.find({ categoryId: categoryId, deleted: false })
    .skip(skipProducts)
    .limit(pageSize)
    .then((products) => {
      return res.status(200).json(products);
    })
    .catch(() => {
      return res.status(500).json("Lỗi lấy sản phẩm");
    });
};
