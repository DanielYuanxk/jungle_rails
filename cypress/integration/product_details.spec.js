describe("Product Details", () => {
  beforeEach(() => {
    cy.visit("/");
  });

  it("Navigates to a product detail page", () => {
    cy.get(".product-link").first().click();
    cy.contains("in stock");
  });
});
