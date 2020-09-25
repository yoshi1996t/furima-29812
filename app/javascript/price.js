function price() {
  const itemPrice = document.getElementById("item-price");
  const addTax = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

    itemPrice.addEventListener("keypress", () => {
      const value = itemPrice.value;

      if(300 <= value && value <= 9999999){
        let tax = value * 0.1
        let benefit = value - tax
      // debugger
        addTax.textContent = tax;
        profit.textContent = benefit;
        
    } else {
        let tax = '0';
        let benefit = '0';
        addTax.textContent = tax;
        profit.textContent = benefit;
      }
  });

}
window.addEventListener("load", price);

