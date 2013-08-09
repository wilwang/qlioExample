return select t.Id as TransactionId, 
  t.Crn as Crn, 
    t.TransactionQuoteId as TranQuoteId, 
    t.Product as Product, 
    c.Id as ComponentId,
    c.ComponentyType as ComponentType,
    c.EffectiveDate as EffectiveDate,
    c.MaturityDate as MaturityDate
from transactionData as t, componentData as c 
where t.Id = c.transid 
and t.tqid=435212
via route '/transactioncomponent' using method get;