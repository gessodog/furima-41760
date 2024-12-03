function count (){
  const itemPrice = document.getElementById("item-price");
  itemPrice.addEventListener("input", () => {
    const countTax = Math.floor(itemPrice.value * 0.1);
    const countProfit = itemPrice.value - countTax;
    const addTaxPrice = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit");
    addTaxPrice.innerHTML = `${countTax}`;
    profit.innerHTML = `${countProfit}`;
  });
};

window.addEventListener('turbo:load', count);
window.addEventListener('turbo:render',count);