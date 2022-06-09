//
//  ViewControllerHistorico.swift
//  MeuCofrinho
//
//  Created by ALUNO on 08/06/22.
//

import UIKit

class ViewControllerHistorico: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    
    var id: Int64 = 0
    var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    func carregar(id: Int64){
        self.id = id
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let arrHistorico = SQLiteDatabase().getobs(pid: self.id)
     
        return arrHistorico.count
        }
        
        // make a cell for each cell index path
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! ViewControllerHistoricoCell
                    
                   
            
            let arrHistorico = SQLiteDatabase().getobs(pid: self.id)
            
            let value = arrHistorico[indexPath.row].value
            let obs = arrHistorico[indexPath.row].obs
            
            self.index += 1
            
            cell.lblval.text = String(value)
            cell.lblobs.text = obs
            
            
          
            
            return cell
        }
    
    
        
        // MARK: - UICollectionViewDelegate protocol
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            // handle tap events
            print("You selected cell #\(indexPath.item)!")
        }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
