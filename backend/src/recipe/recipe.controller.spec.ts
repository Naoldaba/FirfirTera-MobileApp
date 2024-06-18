import { Test, TestingModule } from "@nestjs/testing";
import { RecipeController } from "./recipe.controller";
import { RecipeService } from "./recipe.service";
import { getModelToken } from "@nestjs/mongoose";
import { Category, Recipe } from "../schemas/recipe.schema";
import { NotFoundException } from "@nestjs/common";
import { Model } from "mongoose";
import { UploadService } from "../Upload/upload.service";

describe("RecipeController", () => {
  let controller: RecipeController;
  let service: RecipeService;

  const realRecipeData: Recipe = {
    name: "Spaghetti Bolognese",
    description: "Classic Italian pasta dish",
    cookTime: 30,
    people: 4,
    ingredients: ["Spaghetti", "Tomato Sauce", "Ground Beef"],
    steps: ["Boil water", "Cook spaghetti", "Prepare Bolognese sauce"],
    fasting: "false",
    type: Category.DINNER,
    image: "https://example.com/spaghetti-bolognese.jpg",
    cook_id: "someCookId",
  };

  const mockRecipeModel = {
    find: jest.fn().mockResolvedValueOnce([realRecipeData]),
    getSingleRecipe: jest.fn(),
    getRecipesByCookId: jest.fn(),
    getFasting: jest.fn(),
    getByType: jest.fn(),
    deleteById: jest.fn(),
  };

  const mockUploadModel = {
    uploadFile: jest.fn,
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [RecipeController],
      providers: [
        RecipeService,
        UploadService,
        {
          provide: getModelToken(Recipe.name),
          useValue: mockRecipeModel,
        },
      ],
    }).compile();

    controller = module.get<RecipeController>(RecipeController);
    service = module.get<RecipeService>(RecipeService);
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  it("should be defined", () => {
    expect(controller).toBeDefined();
  });

  describe("getAllRecipes", () => {
    it("should return an array of recipes", async () => {
      const result = await controller.getAllRecipes();
      expect(result).toEqual([realRecipeData]);
    });
  });

  describe("search", () => {
    it("should return recipes based on the provided query", async () => {
      const mockQuery = { name: "ndjfd" };
      const mockRecipes: Recipe[] = [realRecipeData];

      jest.spyOn(service, "find").mockResolvedValueOnce(mockRecipes);

      const result = await controller.search(mockQuery);

      expect(service.find).toHaveBeenCalledWith(mockQuery);

      expect(result).toEqual(mockRecipes);
    });
  });

  describe("getSingleRecipe", () => {
    it("should return a recipe when a valid ID is provided", async () => {
      const mockRecipeId = "validRecipeId";
      const mockRecipe: Recipe = realRecipeData;

      jest.spyOn(service, "getSingleRecipe").mockResolvedValueOnce(mockRecipe);

      const result = await service.getSingleRecipe(mockRecipeId);

      expect(service.getSingleRecipe).toHaveBeenCalledWith(mockRecipeId);

      expect(result).toEqual(mockRecipe);
    });

    it("should throw NotFoundException when an invalid ID is provided", async () => {
      const mockInvalidRecipeId = "invalidRecipeId";

      jest
        .spyOn(service, "getSingleRecipe")
        .mockRejectedValueOnce(new NotFoundException());

      await expect(
        service.getSingleRecipe(mockInvalidRecipeId)
      ).rejects.toThrowError(NotFoundException);

      expect(service.getSingleRecipe).toHaveBeenCalledWith(mockInvalidRecipeId);
    });
  });

  describe("getRecipesByCookId", () => {
    it("should return recipes when a valid cook ID is provided", async () => {
      const mockCookId = "validCookId";
      const mockRecipes: Recipe[] = [realRecipeData];

      jest
        .spyOn(service, "getRecipesByCookId")
        .mockResolvedValueOnce(mockRecipes);

      const result = await controller.getRecipesByCookId(mockCookId);

      expect(service.getRecipesByCookId).toHaveBeenCalledWith(mockCookId);

      expect(result).toEqual(mockRecipes);
    });

    it("should throw NotFoundException when no recipes found for the cook ID", async () => {
      const mockInvalidCookId = "invalidCookId";

      jest
        .spyOn(service, "getRecipesByCookId")
        .mockRejectedValueOnce(new NotFoundException());

      await expect(
        controller.getRecipesByCookId(mockInvalidCookId)
      ).rejects.toThrowError(NotFoundException);

      expect(service.getRecipesByCookId).toHaveBeenCalledWith(
        mockInvalidCookId
      );
    });
  });

  describe("getFasting", () => {
    it("should return recipes when fasting is true", async () => {
      const mockFasting = "true";
      const mockRecipes: Recipe[] = [realRecipeData];

      jest.spyOn(service, "getFasting").mockResolvedValueOnce(mockRecipes);

      const result = await controller.getFasting(mockFasting);

      expect(service.getFasting).toHaveBeenCalledWith(mockFasting);

      expect(result).toEqual(mockRecipes);
    });

    it("should throw NotFoundException when no recipes found for fasting", async () => {
      const mockFasting = "invalidType";

      jest
        .spyOn(service, "getByType")
        .mockRejectedValueOnce(new NotFoundException());

      await expect(controller.getFasting(mockFasting)).rejects.toThrowError(
        NotFoundException
      );

      expect(service.getByType).toHaveBeenCalledWith(mockFasting);
    });

    it("should throw NotFoundException when no recipes found for the type", async () => {
      const mockFasting = "invalidType";

      jest
        .spyOn(service, "getByType")
        .mockRejectedValueOnce(new NotFoundException());

      await expect(controller.getFasting(mockFasting)).rejects.toThrowError(
        NotFoundException
      );

      expect(service.getByType).toHaveBeenCalledWith(mockFasting);
    });
  });
});
