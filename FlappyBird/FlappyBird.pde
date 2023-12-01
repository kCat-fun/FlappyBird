import processing.serial.*;

Serial port;

KBSetup kbSetup;
FileIO fileIO;
App app;
Key keys;

// コントローラーを使用する場合はtrueにしてください。
final boolean IS_CONTROLLER = false; 

void setup() {
    size(600, 750);
    if(IS_CONTROLLER) {
        // COMポートは適宜設定してください。
        port = new Serial(this, "COM", 9600);
    }
    delay(1000);
    textFont(createFont("Courier New", 50));
    kbSetup = new KBSetup(this);
    keys = new Key();
    fileIO = new FileIO();
    app = new App();
}

void draw() {
    app.draw();
}

void keyPressed() {
    keys.keyPressed();
}

void keyReleased() {
    keys.keyReleased();
}

void mousePressed() {
    app.mousePressed();
}
