#include <node.h>
#include "addon.h"

using namespace v8;

void Add(const FunctionCallbackInfo<Value>& args) {
  Isolate* isolate = args.GetIsolate();

  int a = args[0]->NumberValue();
  int b = args[1]->NumberValue();

  Local<Number> num = Number::New(isolate, add(a, b));

  args.GetReturnValue().Set(num);
}

void Init(Local<Object> exports) {
  NODE_SET_METHOD(exports, "add", Add);
}

NODE_MODULE(addon, Init)
