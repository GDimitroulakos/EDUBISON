using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Antlr4.Runtime;
using Antlr4.Runtime.Tree;

namespace BNFParser {
    public class BNFParserFacade {
        private List<string> m_inputFiles = new List<string>();

        public BNFParserFacade() {
        }

        public void LoadFiles(string directory) {
            m_inputFiles = Directory.GetFiles(directory,"*.y").ToList();
        }

        public void Parse() {
            foreach (string s in m_inputFiles) {
                StreamReader str = new StreamReader(s);
                AntlrInputStream ANTLRstr = new AntlrInputStream(str);
                BNFLexer lexer = new BNFLexer(ANTLRstr);
                CommonTokenStream tokens = new CommonTokenStream(lexer);
                BNFParser parser = new BNFParser(tokens);
                lexer.Mode(BNFLexer.DECLARATIONS);
                IParseTree tree = parser.compileUnit();
                Console.WriteLine(tree.ToStringTree());
            }
        }
    }
}
