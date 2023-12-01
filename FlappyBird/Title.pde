class Title implements Tab {
    KButton button;
    
    Title() {
        button = new KButton(this, "start", width/2-150, (2*height)/3, 300, 100, 5);
        button.set.label("START", 20);
    }
    
    public void setup() {
        button.visible(true);
    }
    
    public void close() {
        button.visible(false);
    }
    
    public void draw() {
        push();
        textSize(50);
        textAlign(CENTER, CENTER);
        fill(255);
        text("Interactive", width/2, 150);
        text("Flappy Bird", width/2, 225);
        pop();
    }
    
    public void start() {
        app.setPage(1);
    }
    
    public void mousePressed() {
        
    }
}
