//
//  FavoritosCollectionViewController.swift
//  Favoritos
//
//  Created by Victor Hugo Vázquez Riojas on 3/25/17.
//  Copyright © 2017 Victor Hugo Vázquez Riojas. All rights reserved.
//

import UIKit

private let reuseIdentifier = "FavoritoCell"


class FavoritosCollectionViewController: UICollectionViewController {
    var favoritos: NSArray?
    
    @IBAction func agregarTapped(sender: AnyObject) {
        
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.registerClass(FavoritoCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        //collectionView!.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        collectionView!.collectionViewLayout = layout
        cargarFavoritos()
       

        // Do any additional setup after loading the view.
    }

    /*func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.size.width - 12 * 3) / 2, height: 160.0)
    }*/
    
    
    private func cargarFavoritos(){
        favoritos = DBManager._instance.consultarFavoritos("FavoritosEntity")
        if favoritos != nil {
            self.collectionView!.reloadData()
        } else{
            showMsj("No existe información para mostrar")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return (favoritos?.count)!
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let favoritoItem  = favoritos![indexPath.row] as! Favoritos
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! FavoritoCollectionViewCell
        cell.imgView?.image = NSURL(string: "http://lorempixel.com/110/110/").flatMap { NSData(contentsOfURL: $0) }.flatMap { UIImage(data: $0) }!
        cell.tituloLabel?.text = favoritoItem.titulo
        cell.importeLabel?.text = "$ \(Int(favoritoItem.importe!))"
        // Configure the cell
        return cell
    }

    @IBAction func exitToFavoritos(segue: UIStoryboardSegue){
        cargarFavoritos()
        self.collectionView?.reloadData()
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let favorito: Favoritos = favoritos![indexPath.row] as! Favoritos
        showAlert(favorito)
    }
    
    func showAlert(favorito: Favoritos)
    {
        let ac:UIAlertController = UIAlertController(title: "Confirma tu recarga", message: "\(favorito.titulo!) \n\n $ \(Int(favorito.importe!)) MXN \n *\(favorito.categoria!.uppercaseString)* " , preferredStyle: .Alert )
        let aca = UIAlertAction(title: "Cancelar", style: .Default, handler: nil)
        let acb = UIAlertAction(title: "Confirmar", style: .Default, handler: nil)
        ac.addAction(aca)
        ac.addAction(acb)
        self.presentViewController(ac, animated: true, completion: nil)
    }
    
    func showMsj(mensaje: NSString)
    {
        let ac:UIAlertController = UIAlertController(title: "AVISO", message: mensaje as String, preferredStyle: .Alert )
        let aac  = UIAlertAction(title: "OK", style: .Default, handler: nil)
        ac.addAction(aac)
        self.presentViewController(ac, animated: true, completion: nil)
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = UIScreen.mainScreen().bounds.size.width
        return CGSize(width: ((width / 2) - 15)   , height: 160)
    }
 
    // Actualiza el layout actual en función de la orientación de la pantalla
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        self.collectionView?.collectionViewLayout.invalidateLayout()
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }
 
    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
     */

}
