import js.html.StorageEvent;
import js.Browser;
import js.html.Document;
import js.html.Storage;

class JsApi {
    public function Get(key: String) {

    }

	public function Set(key: String, value: String) {
		Browser.window.localStorage.setItem(key, value);
    }
}