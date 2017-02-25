import dlangui, std.stdio, std.conv, std.format, std.bigint, fibonacci;

mixin APP_ENTRY_POINT;

extern (C) int UIAppMain(string[] args) {
	Window window = Platform.instance.createWindow("Fibonacci calculator", null);

	auto layout = parseML(q{
		VerticalLayout {
			margins: 10
			padding: 10
			backgroundColor: "#CCE5F6"
			TextWidget {
				text: "F(n) - Fibonacci calculator"; fontSize: 250%
			}
			TextWidget {
				text: "One number calculating"
			}
			HorizontalLayout {
				padding: 20
				TextWidget {
					text: "n ="
				}
				EditLine { id: "editNum"; text: "5" }
				Button {
					id: "btnCalc"; text: "Calc"
				}
			}
			TextWidget {
				padding: 20
				id: "textResult"
			}
			TextWidget {
				text: "Multiple calculating"
			}
			HorizontalLayout {
				TextWidget { text: "from" }
				EditLine { id: "editFirstNum"; text: "6" }
				TextWidget { text: "to" }
				EditLine { id: "editSecondNum"; text: "12" }
				Button { id: "btnCalcMultiple"; text: "Calc" }
			}
			TextWidget {
				id: "textList"
			}
		}
	});

	auto editNum = layout.childById("editNum");
	auto resText = layout.childById("textResult");
	auto btnCalc = layout.childById("btnCalc");
	auto textResult = layout.childById("textResult");
	auto editFirstNum = layout.childById("editFirstNum");
	auto editSecondNum = layout.childById("editSecondNum");
	auto btnCalcMultiple = layout.childById("btnCalcMultiple");
	auto textList = layout.childById("textList");

	btnCalc.click = delegate(Widget src) {
		scope(failure) {
			window.showMessageBox("Error"d, "Input is not suitable"d);
			return false;
		}
		int num = to!int(editNum.text);
		writeln(num);
		textResult.text = to!dstring(fibonacci.fibonacci(to!int(editNum.text)));
		return true;
	};
	btnCalcMultiple.click = delegate(Widget src) {
		scope(failure) {
			window.showMessageBox("Error"d, "Input is not suitable"d);
			return false;
		}
		int n = to!int(editFirstNum.text);
		int k = to!int(editSecondNum.text);
		BigInt[] result = fibonacci.fibonacciList(n, k);

		string text = to!string(result);
		text ~= format(" from %s to %s", n, k);
		textList.text = to!dstring(text);

		return true;
	};

	/*string list;
	int k = 15;
	for (int i = 0; i <= k; i++) {
		list ~= to!string(fibonacci.fibonacci(i));
		if (i != k) list ~= ", ";
		else list ~= format(" from 0 to %s", k);
	}
	textList.text = to!dstring(list);
	*/

	writeln(fibonacci.fibonacciList(2, 8));
	window.mainWidget = layout;
	window.show();

	return Platform.instance.enterMessageLoop();
}

unittest {
	BigInt[] correct = to!(BigInt[])([0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181, 6765, 10946]);
	BigInt[] result = fibonacciList(0, to!int(correct.length-1));
	assert(correct == result);
}