query.SQL.Text := 'INSERT INTO Each_Stock_Owned'+
                    '(Stock_Code, Stock_Name, Tran_Date, Buy_Sell, '+
                     'Price_Per_Share, Num_Shares, Trans_Fee) '+
                    'VALUES (:sc, :sn, :td, :bs, :pps, :ns, :tf)';
query.ParamByName('sc').AsString := Stock_Code;
query.ParamByName('sn').AsString := Stock_Name;
query.ParamByName('td').AsString := Tran_Date;
query.ParamByName('bs').AsString := Buy_Sell;
query.ParamByName('pps').AsString := Price_Per_Share;
query.ParamByName('ns').AsString := Num_Shares;
query.ParamByName('tf').AsString := Trans_Fee;
query.ExecSQL;