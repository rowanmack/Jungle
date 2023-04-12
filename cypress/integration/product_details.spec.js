describe("product page testing", () => {
  beforeEach(() => {
    cy.visit("/");
  });

  it("Should open a product page when clicked", () => {
    cy.get(".products article").should("be.visible").first().click();
    cy.url().should("include", "/products/");
  });

});