import { type Request, type Response } from 'express'
import { sendResponse } from './auxiliar.functions'
import { pool } from '../db/db'

// -- Add new user
// INSERT INTO usuarios (documento_identidad, nombre, correo_institucional, telefono, direccion, tipo_usuario, contrasena)
// VALUES ('123456789', 'Juan Perez', 'juanperez@universidad.edu.co', '555-1234', 'Calle 123 #45-67', 'Administrativo', 'contrasena123');
// INSERT INTO programa_academico (nombre)
// VALUES ('Ingeniería de Sistemas');
const addNewProgram = async (req: Request, res: Response): Promise<void> => {
  try {
    const { nombrePrograma } = req.body
    const [rows] = await pool.query(
      'INSERT INTO programa_academico (nombre) VALUES (?)',
      [nombrePrograma]
    )
    console.log(rows)
    sendResponse(res, 200, 'Program successfully added', null, {
      id: (rows as any).insertId,
      nombre: nombrePrograma
    })
  } catch (error) {
    sendResponse(res, 500, 'Failed to add program', error)
  }
}
// const addNewUser = async (req: Request, res: Response): Promise<void> => {
//   try {
//     const [rows] = await pool.query('SELECT * FROM employee');
//     sendResponse(res, 200, 'User successfully added', null, rows);
//   } catch (error) {
//     return sendResponse(res, 500, 'Failed to add user', error);
//   }
// };
// SELECT * FROM usuarios WHERE documento_identidad = '123456789' AND contrasena = 'contrasena123';
const login = async (req: Request, res: Response): Promise<void> => {
  try {
    const id = req.params.id

    const [rows] = await pool.query(
      'SELECT * FROM usuarios WHERE documento_identidad = ?',
      [id]
    )
    sendResponse(res, 200, 'User found', null, rows)
  } catch (error) {
    sendResponse(res, 500, 'Not found', error)
  }
}

// const getEmployee = async (req, res) => {
//   try {
//     const { id } = req.params;
//     const [rows] = await pool.query("SELECT * FROM employee WHERE id = ?", [
//       id,
//     ]);

//     if (rows.length <= 0) {
//       return res.status(404).json({ message: "Employee not found" });
//     }

//     res.json(rows[0]);
//   } catch (error) {
//     return res.status(500).json({ message: "Something goes wrong" });
//   }
// };

// const deleteEmployee = async (req, res) => {
//   try {
//     const { id } = req.params;
//     const [rows] = await pool.query("DELETE FROM employee WHERE id = ?", [id]);

//     if (rows.affectedRows <= 0) {
//       return res.status(404).json({ message: "Employee not found" });
//     }

//     res.sendStatus(204);
//   } catch (error) {
//     return res.status(500).json({ message: "Something goes wrong" });
//   }
// };

// const createEmployee = async (req, res) => {
//   try {
//     const { name, salary } = req.body;
//     const [rows] = await pool.query(
//       "INSERT INTO employee (name, salary) VALUES (?, ?)",
//       [name, salary]
//     );
//     res.status(201).json({ id: rows.insertId, name, salary });
//   } catch (error) {
//     return res.status(500).json({ message: "Something goes wrong" });
//   }
// };

// const updateEmployee = async (req, res) => {
//   try {
//     const { id } = req.params;
//     const { name, salary } = req.body;

//     const [result] = await pool.query(
//       "UPDATE employee SET name = IFNULL(?, name), salary = IFNULL(?, salary) WHERE id = ?",
//       [name, salary, id]
//     );

//     if (result.affectedRows === 0)
//       return res.status(404).json({ message: "Employee not found" });

//     const [rows] = await pool.query("SELECT * FROM employee WHERE id = ?", [
//       id,
//     ]);

//     res.json(rows[0]);
//   } catch (error) {
//     return res.status(500).json({ message: "Something goes wrong" });
//   }

export { addNewProgram, login }
