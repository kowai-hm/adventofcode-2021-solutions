#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

const int size = 5;
	
int** new_board() 
{
	int** board = malloc(sizeof(int*) * size);
	for(int i = 0; i < size; i++) {
		board[i] = (int *) malloc(sizeof(int) * size);
	}
	return board;
}

bool has_board_winned(int** board)
{
	// Parcours simultané puisque plateau carré
	for(int i = 0; i < size; i++)
	{
		bool has_winned_row = true;
		bool has_winned_column = true;
		for(int j = 0; j < size && (has_winned_row || has_winned_column); j++)
		{
			if(board[i][j] != -1)
			{
				has_winned_row = false;
			}
			if(board[j][i] != -1)
			{
				has_winned_column = false;
			}
		}
		if(has_winned_row || has_winned_column)
		{
			return true;
		}
	}
	return false;
}

int final_score(int** board, int number)
{
	int sum = 0;
	for(int i = 0; i < size; i++)
	{
		for(int j = 0; j < size; j++) 
		{
			if(board[i][j] != -1)
			{
				sum += board[i][j];
			}
		}
	}
	return sum*number;
}

void mark_board(int** board, int number)
{
	for(int i = 0; i < size; i++)
	{
		for(int j = 0; j < size; j++) 
		{
			if(board[i][j] == number)
			{
				board[i][j] = -1;  // aucune valeur négative dans le bingo, on peut marquer infailliblement avec
			}
		}
	}
}

int main()
{	
	FILE* file = fopen("input.txt", "r");
	char line[512];
	char* token;

	//Récupération des nombres aléatoires
	int* random_numbers = NULL;
	int random_numbers_size = 0;
	
	fgets(line, sizeof(line), file);
	token = strtok(line, ",");
	while(token) 
	{
		random_numbers = realloc(random_numbers, ++random_numbers_size * sizeof *random_numbers);
		random_numbers[random_numbers_size-1] = atoi(token);
		token = strtok(NULL, ",");
	}
	
	//Skip de la ligne intermédiaire entre les nombres et les tableaux
	fgets(line, sizeof(line), file);
	
	//Récupération des plateaux
	int*** boards = NULL;
	int boards_size = 0;
	int** board = new_board();
	
	int row_cursor = 0;
	while(fgets(line, sizeof(line), file))
	{
		if(strlen(line) == 1) 
		{
			boards = realloc(boards, ++boards_size * sizeof *boards);
			boards[boards_size-1] = board;
			board = new_board();
			row_cursor = 0;
		}
		else
		{
			int column_cursor = -1;
			token = strtok(line, " ");
			while(token) 
			{
				board[row_cursor][++column_cursor] = atoi(token);
				token = strtok(NULL, " ");
			}
			row_cursor++;
		}
	}
	boards = realloc(boards, ++boards_size * sizeof *boards);
	boards[boards_size-1] = board;
	
	//Détermination du gagnant
	for(int i = 0; i < random_numbers_size; i++)
	{
		int random_number = random_numbers[i];
		for(int j = 0; j < boards_size; j++)
		{
			mark_board(boards[j], random_number);
			if(has_board_winned(boards[j]))
			{
				printf("Score du plateau gagnant = %i\n", final_score(boards[j], random_number));
				fclose(file);
				free(random_numbers);
				free(boards);
				return 0;
			}
		}
	}
}