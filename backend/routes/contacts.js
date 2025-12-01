import express from "express";
import Contact from "../models/Contact.js";

const router = express.Router();

// Get all contacts
router.get("/", async (req, res) => {
  try {
    const contacts = await Contact.find().sort({ createdAt: -1 });
    res.json(contacts);
  } catch (error) {
    res.status(500).json({ message: "Server Error" });
  }
});

// Get contact by ID
router.get("/:id", async (req, res) => {
  try {
    const contact = await Contact.findById(req.params.id);
    if (!contact) return res.status(404).json({ message: "Not Found" });

    res.json(contact);
  } catch (error) {
    res.status(500).json({ message: "Server Error" });
  }
});

// Add new contact
router.post("/", async (req, res) => {
  try {
    const { name, phone, email } = req.body;

    if (!name || !phone)
      return res.status(400).json({ message: "Name & Phone required" });

    const newContact = new Contact({ name, phone, email });
    await newContact.save();

    res.status(201).json(newContact);
  } catch (error) {
    res.status(500).json({ message: "Server Error" });
  }
});

// Update contact
router.put("/:id", async (req, res) => {
  try {
    const updated = await Contact.findByIdAndUpdate(
      req.params.id,
      req.body,
      { new: true }
    );

    if (!updated) return res.status(404).json({ message: "Not Found" });

    res.json(updated);
  } catch (error) {
    res.status(500).json({ message: "Server Error" });
  }
});

// Delete contact
router.delete("/:id", async (req, res) => {
  try {
    const deleted = await Contact.findByIdAndDelete(req.params.id);

    if (!deleted) return res.status(404).json({ message: "Not Found" });

    res.json({ message: "Contact Deleted Successfully" });
  } catch (error) {
    res.status(500).json({ message: "Server Error" });
  }
});

export default router;
