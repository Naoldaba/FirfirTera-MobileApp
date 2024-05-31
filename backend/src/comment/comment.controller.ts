import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
  Put,
} from '@nestjs/common';
import { CommentService } from './comment.service';
import { Comment } from 'src/schemas/comment.schema';
@Controller()
export class CommentController {
  constructor(private commentService: CommentService) {}

  @Get('comments/:recipeId')
  async getComments(@Param('recipeId') recipeId: string): Promise<Comment[]> {
    return this.commentService.getComments(recipeId);
  }

  @Post('comments/:recipeId')
  async createComment(
    @Param('recipeId') recipeId: string,
    @Body('comment') comment: string,
    @Body('userId') userId: string,
  ): Promise<Comment> {
    return this.commentService.createComment(recipeId, comment, userId);
  }

  @Delete('comments/:commentId')
  async deleteComment(@Param('commentId') commentId: string): Promise<Comment> {
    return this.commentService.deleteComment(commentId);
  }

  @Patch('comments/:commentId')
  async updateComment(
    @Param('commentId') commentId: string,
    @Body('comment') text: string,
  ): Promise<Comment> {
    return this.commentService.updateComment(commentId, text);
  }
}
