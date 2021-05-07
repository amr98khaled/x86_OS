void caller_function()
{
    callee_function(0xabcd);
}

int callee_function(int arg)
{
    return arg;
}
