﻿using BusinessObject.Models;
using Microsoft.EntityFrameworkCore;

namespace DataAccess.ProductRepository
{
    public class ProductRepository : IProductRepository, IDisposable
    {
        private readonly MiniStoreContext context = new MiniStoreContext();

        public void Dispose()
        {
            context?.Dispose();
        }

        public void DeleteById(int id)
        {
            var product = context.Products.FirstOrDefault(p => p.Id == id);
            if (product != null)
            {
                product.IsDeleted = true;
                context.SaveChanges();
            }
        }

        public IEnumerable<Product> GetAll()
        {
            return context.Products.Where(p => p.IsDeleted == false).Include(p => p.ProductImages).Include(p => p.Category).ToList();
        }

        public Product? GetById(int id)
        {
            return context.Products.Include(p => p.ProductImages).Include(p => p.Category).FirstOrDefault(p => p.Id == id);
        }

        public Product? Save(Product entity)
        {
            var productSaved = context.Products.Add(entity);
            context.SaveChanges();
            return productSaved.Entity;
        }

        public void Update(Product entity)
        {
            var images = context.ProductImages.Where(p => p.ProductId == entity.Id).ToList();
            context.ProductImages.RemoveRange(images);
            context.Products.Update(entity);
            context.SaveChanges();
        }
    }
}
