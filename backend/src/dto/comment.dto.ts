import { IsNotEmpty } from 'class-validator';

export class CreateCommentDto {
  @IsNotEmpty()
  recipeId: string;

  @IsNotEmpty()
  comment: string;

  @IsNotEmpty()
  userId: string;
}
