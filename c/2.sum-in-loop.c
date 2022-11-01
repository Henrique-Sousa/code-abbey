#include <stdio.h>

int main() {
    int amount;
    int value;
    int sum = 0;
    int i;

    printf("input data:\n");
    scanf("%d", &amount);

    for (i = 0; i < amount; i++) {
        scanf("%d", &value);
        sum += value;    
    }

    printf("\n");
    printf("answer:\n");
    printf("%d\n", sum);
}
