#include <stdio.h>

int main() {
    int pairs;
    int value_1, value_2;
    int i;

    printf("data:\n");
    scanf("%d", &pairs);

    int array[pairs];

    for (i = 0; i < pairs; i++) {
        scanf("%d %d", &value_1, &value_2);
        array[i] = value_1 < value_2 ? value_1 : value_2;
    }

    printf("\n");
    printf("answer:\n");

    for (i = 0; i < pairs; i++) {
        printf("%d ", array[i]);
    }
    printf("\n");
}
