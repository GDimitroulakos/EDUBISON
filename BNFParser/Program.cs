using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BNFParser {
    class Program {
        static void Main(string[] args) {
            BNFParserFacade test = new BNFParserFacade();
            test.LoadFiles(@".\..\..\Testbench");
            test.Parse();
        }
    }
}
