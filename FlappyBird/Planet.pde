public class Planet {
    PImage img;
    PVector pos;
    PVector vec;
    final static int SIZE = 450;

    Planet(PImage img, int x, int y) {
        this.img = img;
        this.img.resize(SIZE, SIZE);
        pos = new PVector(x, y);
        vec = new PVector(-app.gameSpeed, 0);
    }

    public void draw() {
        push();
        update();
        image(img, pos.x-SIZE/2, pos.y-SIZE/2);
        pop();
    }

    private void update() {
        vec.x = -app.gameSpeed;
        pos.add(vec);
    }

    public void setPos(float x, float y) {
        pos.x = x;
        pos.y = y;
    }

    public void setImage(PImage img) {
        this.img = img;
        this.img.resize(SIZE, SIZE);
    }

    public boolean isEnd() {
        return (pos.x+SIZE/2 < 0);
    }
    
    public boolean isHit(float x, float  y, int r) {
        return dist(x, y, pos.x, pos.y) < SIZE/2+r;
    }
}
