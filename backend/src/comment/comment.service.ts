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

  // it accept recipe id and return the array of comment object from recipy comment property
  async getComments(recipeId: string): Promise<Comment[]> {
    const comments = await this.commentModel.find({ recipeId }).populate({
      path: 'userId',
      model: 'User',
      select: 'firstName lastName image _id',
    });
    return comments;
  }
  // it accept commentId and comment property called text and return the updated comment objext
  async updateComment(commentId: string, text: string): Promise<Comment> {
    const comment = await this.commentModel.findByIdAndUpdate(
      commentId,
      { text: text },
      { new: true },
    );

    return comment;
  }
  // it accept commentId and return the deleted comment object
  async deleteComment(commentId: string): Promise<Comment> {
    const comment = await this.commentModel.findByIdAndDelete(commentId);
    if (!comment) {
      throw new NotFoundException('comment not found!');
    }
    return comment;
  }
  // it accept recipeId and comment object and return the created comment object
  async createComment(
    recipeId: string,
    comment: string,
    userId: string,
  ): Promise<Comment> {
    const newComment = await this.commentModel.create({
      recipeId: recipeId,
      text: comment,
      userId: userId,
    });

    return newComment;
  }
}
