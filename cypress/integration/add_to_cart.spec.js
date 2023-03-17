describe("Add to Cart", () => {
  beforeEach(() => {
    cy.visit("/");
  });

  it("should increase the cart count when adding a product to the cart", () => {
    // Get the initial cart count
    cy.get(".nav-link")
      .contains("My Cart")
      .invoke("text")
      .then((initialCartText) => {
        const initialCartCount = parseInt(initialCartText.match(/\d+/)[0]);

        // Click on the first 'Add to Cart' button
        cy.get('button.btn:contains("Add")')
          .first()
          .scrollIntoView()
          .click({ force: true });

        // Check that the cart count has increased by 1
        cy.get(".nav-link")
          .contains("My Cart")
          .invoke("text")
          .then((updatedCartText) => {
            const updatedCartCount = parseInt(updatedCartText.match(/\d+/)[0]);
            expect(updatedCartCount).to.equal(initialCartCount + 1);
          });
      });
  });
});
