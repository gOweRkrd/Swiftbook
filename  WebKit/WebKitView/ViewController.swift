import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlTextField.delegate = self
        webView.navigationDelegate = self
        
        let homePage = "https://www.apple.com"
        let url = URL(string: homePage)
        let request = URLRequest(url: url!)

        
        webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func forwardButtonTapped(_ sender: Any) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    

}

extension ViewController: UITextFieldDelegate, WKNavigationDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let urlString = textField.text!
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        webView.load(request)
        
        textField.resignFirstResponder()
        
        return true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        urlTextField.text = webView.url?.absoluteString
        
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
    
}














