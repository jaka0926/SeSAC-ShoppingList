//
//  TableViewController.swift
//  SeSAC-Assignment-9
//
//  Created by Jaka on 2024-05-26.
//

import UIKit


struct Row {
    let label: String
    var checked: Bool
    var favorite: Bool
}

class TableViewController: UITableViewController {

    
    @IBOutlet var textFieldBg: UIView!
    @IBOutlet var textField: UITextField!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var UIView: UITableView!
    
    var list = [Row(label: "최신 맥북 구매", checked: false, favorite: false),
                Row(label: "삼겹살 10인분", checked: false, favorite: false),
                Row(label: "다이소에서 HDMI 캐이블 사기", checked: false, favorite: false),
                Row(label: "강아지", checked: false, favorite: false)]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.placeholder = "무엇을 구매하실 건가요?"
        textField.returnKeyType = .done
        textField.enablesReturnKeyAutomatically = true
        textFieldBg.backgroundColor = .systemGray6
        textFieldBg.layer.cornerRadius = 15
        
        addButton.backgroundColor = .systemGray5
        addButton.setTitle("추가", for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        addButton.layer.cornerRadius = 15
        
        UIView.keyboardDismissMode = .onDrag
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "starter") as! TableViewCell
        
        let data = list[indexPath.row]
        
        cell.backgroundColor = .systemGray6
        cell.layer.cornerRadius = 15
        cell.rowLabel.text = data.label
        
        let image1 = UIImage(systemName: data.checked ? "checkmark.circle.fill" : "checkmark.circle")
        let image2 = UIImage(systemName: data.favorite ? "star.fill" : "star")
        
        cell.checkButton.setImage(image1, for: .normal)
        cell.favoriteButton.setImage(image2, for: .normal)
        cell.checkButton.addTarget(self, action: #selector(checkButtonClicked), for: .touchUpInside)
        cell.favoriteButton.addTarget(self, action: #selector(favoriteButtonClicked), for: .touchUpInside)
        cell.checkButton.tintColor = .black
        cell.favoriteButton.tintColor = .black
        cell.checkButton.tag = indexPath.row
        cell.favoriteButton.tag = indexPath.row
        
        return cell
    }

    func showAlert(title: String?, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    @IBAction func addButtonClicked(_ sender: UIButton) {
        
        if textField.text?.isEmpty == true {
            return
        }
        
        guard let text = textField.text, text.count > 1 else {
            showAlert(title: "두글자 이상 입력하세요", message: "")
            
            return
        }
        
        list.append(Row(label: textField.text!, checked: false, favorite: false))
        
        textField.text = ""
        view.endEditing(true)
        //데이터와 뷰는 따로 놀기 때문에, 데이터가 달라지면 부를 다시 갱신해주어야 한다.
        tableView.reloadData()
    }
    
    
    @IBAction func keyboardDismiss(_ sender: UITextField) {
        view.endEditing(true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        list.remove(at: indexPath.row)
        tableView.reloadData()
        print(indexPath.row)
    }
    
    @objc func checkButtonClicked(_ sender: UIButton) {
        list[sender.tag].checked.toggle()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
    }
    
    @objc func favoriteButtonClicked(_ sender: UIButton) {
        list[sender.tag].favorite.toggle()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
    }
}
