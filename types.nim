import pkg/sunny

type
  Header* = object
    major* {.json: "version_major,required".}: uint8
    minor* {.json: "version_minor,required".}: uint8
    patch* {.json: "version_patch,required".}: uint8
    # Could be replaced with an enum?
    status* {.json: "version_status,required".}: string
    # Same as above
    build* {.json: "version_build,required".}: string
    fullName* {.json: "version_full_name,required".}: string

  BuildConfigurationKind* = enum
    Float32 = "float_32", Float64 = "float_64", Double32 = "double_32", Double64 = "double_64",

  ClassSize* = object
    name* {.json: "name,required".}: string
    size* {.json: "size,required".}: uint8

  ClassSizes* = object
    configuration* {.json: "build_configuration,required".}: BuildConfigurationKind
    classes*: seq[ClassSize]

  ClassMemberOffset* = object
    name* {.json: "member,required".}: string
    offset* {.json: "offset,required".}: uint8
    meta* {.json: "meta,required".}: string

  ClassOffset* = object
    name* {.json: "name,required".}: string
    members* {.json: "members,required".}: seq[ClassMemberOffset]

  ClassOffsets* = object
    configuration* {.json: "build_configuration,required".}: BuildConfigurationKind
    classes* {.json: "classes,required".}: seq[ClassOffset]

  GdEnum* = object
    name* {.json: "name,required".}: string
    bitfield* {.json: "is_bitfield".}: bool
    values* {.json: "values,required".}: seq[tuple[name: string, value: int64]]

  Argument* = object
    name* {.json: "name,required".}: string
    typ* {.json: "type,required".}: string
    default* {.json: "default_value".}: string

  UtilityFunction* = object
    name* {.json: "name,required".}: string
    returnType* {.json: "return_type".}: string
    category* {.json: "category,required".}: string
    vararg* {.json: "is_vararg,required".}: bool
    hash* {.json: "hash,required".}: int64
    arguments* {.json: "arguments,".}: seq[Argument]

  Operator* = object
    rightType* {.json: "right_type".}: string
    returnType* {.json: "return_type".}: string

  Constructor* = object
    index* {.json: "index,required".}: int32
    arguments*: seq[Argument]

  BuiltinMethod* = object
    name* {.json: "name,required".}: string
    returnType* {.json: "return_type".}: string
    category* {.json: "category".}: string
    vararg* {.json: "is_vararg,required".}: bool
    isConst* {.json: "is_const,required".}: bool
    isStatic* {.json: "is_static,required".}: bool
    hash* {.json: "hash,required".}: int64
    arguments* {.json: "arguments,".}: seq[Argument]

  ClassMember* = object
    name* {.json: "name,required".}: string
    typ* {.json: "type,required".}: string

  BuiltinConstant* = object
    name* {.json: "name,required".}: string
    typ* {.json: "type,required".}: string
    value* {.json: "value,required".}: string

  BuiltinClass* = object
    name* {.json: "name,required".}: string
    indexingReturnType* {.json: "indexing_return_type,".}: string
    keyed* {.json: "is_keyed,required".}: bool
    members* {.json: "members".}: seq[ClassMember]
    constants* {.json: "constants".}: seq[BuiltinConstant]
    enums* {.json: "enums".}: seq[GdEnum]
    operators* {.json: "operators".}: seq[Operator]
    methods* {.json: "methods".}: seq[BuiltinMethod]
    constructors* {.json: "constructors".}: seq[Constructor]
    destructor* {.json: "has_destructor,required".}: bool

  ReturnValue* = object
    typ* {.json: "type,required".}: string
    meta* {.json: "meta".}: string

  Method* = object
    name* {.json: "name,required".}: string
    returnValue* {.json: "return_value".}: ReturnValue
    category* {.json: "category".}: string
    vararg* {.json: "is_vararg,required".}: bool
    isConst* {.json: "is_const,required".}: bool
    isStatic* {.json: "is_static,required".}: bool
    virtual* {.json: "is_virtual,required".}: bool
    hash* {.json: "hash".}: int64
    hashCompatibility* {.json: "hash_compatibility".}: seq[int64]
    arguments* {.json: "arguments,".}: seq[Argument]

  Property* = object
    typ* {.json: "type,required".}: string
    name* {.json: "name,required".}: string
    setter* {.json: "setter".}: string
    getter* {.json: "getter".}: string

  Constant* = object
    name* {.json: "name,required".}: string
    value* {.json: "value,required".}: int

  Class* = object
    name* {.json: "name,required".}: string
    refcounted* {.json: "is_refcounted,required".}: bool
    instantiable* {.json: "is_instantiable,required".}: bool
    inherits* {.json: "inherits".}: string
    apiType* {.json: "api_type,required".}: string
    #indexingReturnType* {.json: "indexing_return_type,".}: string
    members* {.json: "members".}: seq[ClassMember]
    constants* {.json: "constants".}: seq[Constant]
    enums* {.json: "enums".}: seq[GdEnum]
    operators* {.json: "operators".}: seq[Operator]
    methods* {.json: "methods".}: seq[Method]
    properties* {.json: "properties".}: seq[Property]
    constructors* {.json: "constructors".}: seq[Constructor]

  GDExtApi* = object
    header* {.json: "header,required".}: Header
    builtinClassSizes* {.json: "builtin_class_sizes,required".}: seq[ClassSizes]
    builtinClassOffsets* {.json: "builtin_class_member_offsets,required".}: seq[ClassOffsets]
    # Not sure what this is supposed to store since it's empty
    globalConstants* {.json: "global_constants,required".}: seq[string]
    enums* {.json: "global_enums,required".}: seq[GdEnum]
    utilityFunctions* {.json: "utility_functions,required".}: seq[UtilityFunction]
    builtinClasses* {.json: "builtin_classes,required".}: seq[BuiltinClass]
    classes* {.json: "classes,required".}: seq[Class]