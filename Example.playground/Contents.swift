import Foundation
import UIKit
import PlaygroundSupport
import Eureka
import RichTextRow


let lorem = "<div><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sullae consulatum? Poterat autem inpune; <i>ALIO MODO</i>. Duo Reges: constructio interrete. </p>" +

"<p>Falli igitur possumus. An eiusdem modi? Perge porro; Nemo igitur esse beatus potest. Maximus dolor, inquit, brevis est. Sint modo partes vitae beatae. </p>" +

"<p><u>Iam contemni non poteris.</u> Quid autem habent admirationis, cum prope accesseris? <b>Collige omnia, quae soletis: Praesidium amicorum.</b> Honesta oratio, Socratica, Platonis etiam. Quid censes in Latino fore? Tu quidem reddes; <b>Illi enim inter se dissentiunt.</b> </p>" +

"<p>Erat enim Polemonis. Quis hoc dicit? <b>Conferam tecum, quam cuique verso rem subicias;</b> Erat enim Polemonis. Beatum, inquit. Iam enim adesse poterit. </p>" +

"<p>Est, ut dicis, inquit; <b>Istic sum, inquit.</b> Qui convenit? Age, inquies, ista parva sunt. Certe, nisi voluptatem tanti aestimaretis. </p>" +

"</div>"

let lorem2 = "<div><h1>Quid, quod res alia tota est?</h1>" +

"<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. <mark>Duo Reges: constructio interrete.</mark> Rationis enim perfectio est virtus; At hoc in eo M. Minime vero, inquit ille, consentit. </p>" +

"<blockquote cite='http://loripsum.net'> Cum autem paulum firmitatis accessit, et animo utuntur et sensibus conitunturque, ut sese erigant, et manibus utuntur et eos agnoscunt, a quibus educantur.</blockquote>" +

"<pre>Octavium, Marci filium, familiarem meum, confici vidi, nec vero semel nec ad breve tempus, sed et saepe et plane diu. Quis enim est, qui non videat haec esse in natura rerum tria?</pre>" +

"<p>Sed ille, ut dixi, vitiose. <code>Haeret in salebra.</code> In schola desinis. Negare non possum. Et quidem, inquit, vehementer errat; Nihil ad rem! Ne sit sane; </p>" +

"<ol><li>Ergo illi intellegunt quid Epicurus dicat, ego non intellego?</li> <li>Atque ab isto capite fluere necesse est omnem rationem bonorum et malorum.</li> <li>Intrandum est igitur in rerum naturam et penitus quid ea postulet pervidendum;</li> <li>Ille enim occurrentia nescio quae comminiscebatur;</li> <li>Vitiosum est enim in dividendo partem in genere numerare.</li> <li>Nam memini etiam quae nolo, oblivisci non possum quae volo.</li></ol>" +
"<ul> <li>Scio enim esse quosdam, qui quavis lingua philosophari possint;</li> <li>Terram, mihi crede, ea lanx et maria deprimet.</li> </ul>" +
"<dl> <dt><dfn>Quod totum contra est.</dfn></dt> <dd>Hoc enim constituto in philosophia constituta sunt omnia.</dd> <dt><dfn>Efficiens dici potest.</dfn></dt> <dd>Qui autem de summo bono dissentit de tota philosophiae ratione dissentit.</dd> <dt><dfn>Stoicos roga.</dfn></dt> <dd>Videsne quam sit magna dissensio?</dd></dl>" +

"</div>"

class MyForm: FormViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ RichTextRow("lorem") {
            $0.title = "Placeholder"
            $0.value = lorem
        } <<< RichTextRow("lorem2") {
            $0.title = "Placeholder"
            $0.value = lorem2
        }
    }
}

PlaygroundPage.current.liveView = MyForm()
