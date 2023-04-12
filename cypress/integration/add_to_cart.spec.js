describe("add to cart testing", () => {
  beforeEach(() => {
    cy.visit("/");
  });

  it("Should add a product to the cart", () => {
    cy.get(".products article")
      .first()
      .find(".btn")
      .click({ force: true });
      
    cy.get(".navbar .nav-link").last().contains("My Cart (1)");
  });

});