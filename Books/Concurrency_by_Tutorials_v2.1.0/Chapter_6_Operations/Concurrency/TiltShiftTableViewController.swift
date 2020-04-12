import UIKit

class TiltShiftTableViewController: UITableViewController {
  private let context = CIContext()
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "normal", for: indexPath) as! PhotoCell
    
    let image = UIImage(named: "\(indexPath.row).png")!
    print("Filtering")
    let op = TiltShiftOperation(image: image)
    op.start()
    cell.display(image: op.outputImage)
    print("Done")
    
    return cell
  }
}
