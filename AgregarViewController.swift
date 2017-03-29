//
//  AgregarViewController.swift
//  Favoritos
//
//  Created by Victor Hugo Vázquez Riojas on 3/20/17.
//  Copyright © 2017 Victor Hugo Vázquez Riojas. All rights reserved.
//

import UIKit


class AgregarViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var categorias: NSArray?
    var nombre: String?
    var categoria: String?
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var categoriaPicker: UIPickerView!
    @IBOutlet weak var importeText: UITextField!
    @IBOutlet weak var impoStepper: UIStepper!
    @IBAction func importeStepper(sender: AnyObject) {
        importeText.text = "$ \(Int(impoStepper.value))"
    }
    @IBAction func btnCrear(sender: AnyObject) {
        nombre = txtNombre.text!
        if (!validar(nombre!)) {
            showAlert("Ingresa un nombre válido")
            return
        }
        if (categoria == nil) {
            showAlert("Selecciona una categoría")
            return
        }
        
        if (Int(impoStepper.value) == 0){
            showAlert("Selecciona un importe")
            return
        }
        
        if guardarFavorito(categoria!, importe: Int(impoStepper.value), titulo: nombre!) {
            performSegueWithIdentifier("exitToFavoritosOnSuccess", sender: self)
        } else {
            showAlert("Se produjó un error al guardar, intente nuevamente")
        }
    }
    
    func validar(elTexto: String) -> Bool{
        if elTexto.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) != "" {
            return true
        } else {
            return false
        }
        
    }
    
    
    func showAlert(mensaje: NSString)
    {
        let ac:UIAlertController = UIAlertController(title: "ERROR", message: mensaje as String, preferredStyle: .Alert )
        let aac  = UIAlertAction(title: "OK", style: .Default, handler: nil)
        ac.addAction(aac)
        self.presentViewController(ac, animated: true, completion: nil)
    }
    
    func guardarFavorito(categoria: String, importe: NSNumber, titulo: String)-> Bool{
        return DBManager._instance.guardarFavorito("FavoritosEntity", categoria: categoria, importe: importe, titulo: titulo)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let archivo = NSBundle.mainBundle().pathForResource("Categorias", ofType: "plist")
        self.categorias = NSArray(contentsOfFile: archivo!)
        self.categoriaPicker.dataSource = self
        self.categoriaPicker.delegate = self
        self.importeStepper(self)
        // Do any additional setup after loading the view.
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (categorias?.count)!
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (categorias![row] as! String)
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoria = (categorias![row] as! String)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.txtNombre.resignFirstResponder()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
