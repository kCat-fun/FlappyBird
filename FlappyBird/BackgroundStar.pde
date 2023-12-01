public class BackgroundStar {
    private final int NUM = 100;
    private Point[] points;

    BackgroundStar() {
        points = new Point[NUM];
        for (int i =0; i<NUM; i++) {
            points[i] = new Point(random(width), random(height), floor(random(2)));
        }
    }

    public void draw() {
        push();
        background(0);
        noStroke();
        for (Point p : points) {
            p.draw();
            p.update();
        }
        pop();
    }

    public void setup() {
    }

    protected class Point {
        PVector pos;
        int d;
        color c;
        float spped;

        Point(float x, float y, int type) {
            pos = new PVector(x, y);
            if (type == 0) {
                d = 1;
                c = color(230, 230, 255);
            } else {
                d = 2;
                c = color(255, 240, 220);
            }
        }

        void draw() {
            fill(c);
            circle(pos.x, pos.y, d);
        }

        void update() {
            pos.x -= d*0.1 * app.gameSpeed*2;
            if(pos.x < 0) {
                pos.x = width;
                pos.y = random(height);
            }
        }
    }
}
