public class FibonacciGenerator {
    public static void main(String[] arguments) throws Exception {
        Thread.sleep(1000);
        long number = (long) (10000000000d * (1d + Math.random()));
        if (arguments.length > 0) {
            number = Integer.valueOf(arguments[0]);
        }
        System.out.println(calculate(number));
    }

    private static int calculate(long number) {
        if (number < 1) {
            return 0;
        }
        int previous = 0;
        int current = 1;
        for (long i = 0; i < number; i++) {
            int buffer = current;
            current = Integer.sum(previous, current);
            previous = buffer;
        }
        return current;
    }
}
