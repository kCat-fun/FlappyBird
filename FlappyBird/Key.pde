public class Key {
    private boolean[] stateAlphabet;
    private boolean[] stateNumber;
    private HashMap<String, Boolean> stateSymbol;
    private boolean stateController;
    private int stateBpm;

    Key() {
        stateAlphabet = new boolean['Z'-'A'+1];
        for (int i=0; i<stateAlphabet.length; i++) {
            stateAlphabet[i] = false;
        }

        stateNumber = new boolean['9'-'0'+1];
        for (int i=0; i<stateNumber.length; i++) {
            stateNumber[i] = false;
        }

        stateSymbol = new HashMap<String, Boolean>() {
            {
                put("LEFT", false);
                put("RIGHT", false);
                put("UP", false);
                put("DOWN", false);
                put("SPACE", false);
                put("ENTER", false);
                put("SHIFT", false);
            }
        };

        stateController = false;
        stateBpm = -1;
    }

    public void keyPressed() {
        if (isAlphabet(key)) {
            stateAlphabet[keyCode-'A'] = true;
        } else if (isNumber(key)) {
            stateNumber[keyCode-'0'] = true;
        } else if (getKeySymbol(key, keyCode) != null) {
            stateSymbol.replace(getKeySymbol(key, keyCode), true);
        }
    }

    public void keyReleased() {
        if (isAlphabet(key)) {
            stateAlphabet[keyCode-'A'] = false;
        } else if (isNumber(key)) {
            stateNumber[keyCode-'0'] = false;
        } else if (getKeySymbol(key, keyCode) != null) {
            stateSymbol.replace(getKeySymbol(key, keyCode), false);
        }
    }

    public boolean getStateAlphabetNumber(char c) {
        if (isAlphabet(c)) {
            return stateAlphabet[c-'A'];
        } else if (isNumber(c)) {
            return stateNumber[c-'0'];
        }

        println("Error:", c, "key state is not found.");
        throw new RuntimeException();
    }

    public boolean getStateSymbol(String s) {
        if (stateSymbol.containsKey(s)) {
            return stateSymbol.get(s);
        }

        println("Error:", s, "key state is not found.");
        throw new RuntimeException();
    }

    public void setStateSensor(float[] arr) {
        if (arr.length == 2) {
            stateController = (arr[0] <= 0);
            stateBpm = int(arr[1]);
        }
    }

    public boolean getStateController() {
        return stateController;
    }

    public int getStateBpm() {
        return stateBpm;
    }

    private boolean isAlphabet(int c) {
        return ('a'<=c && c<= 'z') || ('A'<=c && c<='Z');
    }

    private boolean isNumber(int c) {
        return '0'<=c && c<= '9';
    }

    private String getKeySymbol(char c, int code) {
        switch(code) {
        case LEFT:
            return "LEFT";
        case RIGHT:
            return "RIGHT";
        case UP:
            return "UP";
        case DOWN:
            return "DOWN";
        case SHIFT:
            return "SHIFT";
        }
        switch(c) {
        case ' ':
            return "SPACE";
        case ENTER:
            return "ENTER";
        }

        return null;
    }
}
