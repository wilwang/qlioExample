-- get transaction via id
create table transactionData
  on select get from "http://localhost:4000/transactiondata?tqid={^tqid}"
  resultset '';

-- get components via transid
create table componentData
  on select get from "http://localhost:4000/componentdata?transid={^transid}"
  resultset '';

-- servicestack binding error
create table chatham.transaction
  on select get from "http://bisapi08:5017/transactions/655305&format=json"
  resultset '';

-- A table to find products
create table eBay.FindProducts
  on select get from "http://open.api.ebay.com/shopping?callname=FindProducts&appid={^apikey}&responseencoding=JSON&version=725&QueryKeywords={^QueryKeywords}&MaxEntries={max}&ProductSort=Popularity&AvailableItemsOnly=true&siteid={siteid}"
    using defaults max = "5", apikey = "{config.eBay.apikey}", sideid = 0
    resultset 'Product';
 
-- A table to get product details
create table eBay.ProductDetails
  on select get from "http://open.api.ebay.com/shopping?callname=FindProducts&appid={^apikey}&responseencoding=JSON&version=725&siteid={siteid}&ProductID.type={^ProductType}&ProductID.Value={^ProductID}"
    using defaults apikey = "{config.eBay.apikey}", sideid = 0
    resultset 'Product';
 
-- A table to get product reviews
create table eBay.ProductReviews
  on select get from "http://open.api.ebay.com/shopping?callname=FindReviewsAndGuides&ProductID.Value={#^ProductID}&ProductID.type={^ProductType}&appid={^apikey}&responseencoding=JSON&version=745&siteid={siteid}"
     using defaults apikey = "{config.eBay.apikey}", sideid = 0;