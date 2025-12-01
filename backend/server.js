import express from "express";
import dotenv from "dotenv";
import cors from "cors";
import connectDB from "./config/db.js";
import contactRoutes from "./routes/contacts.js";

dotenv.config();
const app = express();

// Middleware (ORDER IMPORTANT)
app.use(cors());
app.use(express.json());  
app.use(express.urlencoded({ extended: true })); // NEW - fixes empty body issue

// Debug logger (to check what backend receives)
app.use((req, res, next) => {
  console.log("Request:", req.method, req.url);
  console.log("Body:", req.body);
  next();
});

// DB Connection
connectDB();

// Routes
app.use("/api/contacts", contactRoutes);

app.get("/", (req, res) => {
  res.send("Contact API is Running...");
});

const PORT = process.env.PORT || 5000;

app.listen(PORT, () => {
  console.log(`Server Running on Port ${PORT}`);
});
