const express = require('express');
const ProductController = require('../controllers/ProductController');
const {verifyAdmin} = require('../middleware/verifyToken');
const { verifyForHeader } = require('../middleware/authen');
const router = express.Router();

router.put("/:id", verifyAdmin, ProductController.editProduct)
router.get("/:id/edit", verifyAdmin, ProductController.editPage)

router.delete("/:id/destroy", verifyAdmin, ProductController.destroyProduct)
router.patch("/:id/restore", verifyAdmin, ProductController.restoreProduct)
router.get("/trash", verifyAdmin, ProductController.getTrash)

router.get("/create", verifyAdmin, ProductController.createProductPage)
router.post("/create", verifyAdmin, ProductController.createProduct)

router.delete("/:id", verifyAdmin, ProductController.stopSellingProduct)
//stop product is checked
router.post("/stop-selling-products", verifyAdmin, ProductController.stopProductsIsChecked)
router.post("/resume-selling-products", verifyAdmin, ProductController.resumeProductsIsChecked)

router.get("/mon-chinh",  ProductController.getMonChinh)
router.get("/mon-phu", ProductController.getMonPhu)
router.get("/nuoc-uong", ProductController.getNuocUong)
router.get("/:slug", ProductController.showInfoProduct)

router.get("/search/:key", ProductController.searchProduct)

router.get("/", verifyAdmin, ProductController.getAllProduct)

module.exports = router;