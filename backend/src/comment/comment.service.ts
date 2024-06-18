import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Comment } from 'src/schemas/comment.schema';

@Injectable()
export class CommentService {
  constructor(
    @InjectModel(Comment.name)
    private commentModel: Model<Comment>,
  ) {}

  async getComments(recipeId: string): Promise<Comment[]> {
    const comments = await this.commentModel.find({ recipeId });
    return comments;
  }
  async updateComment(commentId: string, text: string): Promise<Comment> {
    const this_comment = await this.commentModel.findById(
      commentId
    );
    if(text){
      this_comment.text=text;
    }
    await this_comment.save(); 
    return this_comment;
  }
  async deleteComment(commentId: string): Promise<Comment> {
    const comment = await this.commentModel.findByIdAndDelete(commentId);
    console.log('hereee')
    if (!comment) {
      throw new NotFoundException('comment not found!');
    }
    console.log('hereee 2222')
    return comment;
  }
  async createComment(
    recipeId: string,
    comment: string,
    user_inf: string,
  ): Promise<Comment> {
    const newComment = await this.commentModel.create({
      recipeId: recipeId,
      text: comment,
      user_inf: user_inf,
    });

    return newComment;
  }
}
