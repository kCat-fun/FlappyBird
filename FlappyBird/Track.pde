public class Track {
    private ArrayList<PVector> points;
    final int TRACK_W = 2;

    Track() {
        points = new ArrayList<PVector>();
    }

    public void draw() {
        update();
        push();
        noStroke();
        stroke(200, 200, 100);
        strokeWeight(TRACK_W);
        for (int i=0; i<points.size()-1; i++) {
            PVector p1 = points.get(i);
            PVector p2 = points.get(i+1);
            line(p1.x, p1.y, p2.x, p2.y);
        }
        pop();
    }

    public void addPoint(float x, float y) {
        points.add(new PVector(x, y));
    }

    private void update() {
        if (points.size() <= 0) return;
        
        for (int i=0; i<points.size(); i++) {
            PVector p = points.get(i);
            points.set(i, new PVector(p.x - 3, p.y));
            if(p.x < 0) {
                 points.remove(i);   
                 i--;
            }
        }
    }
}
