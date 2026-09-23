Yes. In Flutter, **`Navigator.pushNamed()`** and **`Navigator.pop()`** can both pass data between screens, but they do it in different directions:

* `pushNamed()` → send data **to the new screen**
* `pop()` → send data **back to the previous screen**

## 1. Send data with `Navigator.pushNamed()`

Suppose you have a list of users and want to send a `userId` to a details page.

### First screen

```dart
Navigator.pushNamed(
  context,
  '/details',
  arguments: 25,
);
```

Here, `25` is the data you're sending.

### Receive it in the second screen

You can get the arguments using `ModalRoute`:

```dart
class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      appBar: AppBar(
        title: Text('User $userId'),
      ),
      body: Center(
        child: Text('User ID: $userId'),
      ),
    );
  }
}
```

So the flow is:

```text
Screen A
   |
   | pushNamed(arguments: 25)
   ↓
Screen B
   |
   | ModalRoute...arguments
   ↓
   25
```

---

# 2. Send multiple values

You don't have to send only one value. You can send a `Map`:

```dart
Navigator.pushNamed(
  context,
  '/details',
  arguments: {
    'id': 25,
    'name': 'Hashimi',
    'age': 18,
  },
);
```

Then receive them:

```dart
final args = ModalRoute.of(context)!.settings.arguments
    as Map<String, dynamic>;

final id = args['id'];
final name = args['name'];
final age = args['age'];
```

For example:

```dart
Text('ID: $id'),
Text('Name: $name'),
Text('Age: $age'),
```

---

# 3. Send data back with `Navigator.pop()`

This is extremely useful.

Imagine:

```text
Home Screen
     ↓
Select Color Screen
     ↓
User selects "Blue"
     ↓
pop("Blue")
     ↓
Home Screen receives "Blue"
```

### Second screen

```dart
Navigator.pop(context, 'Blue');
```

The `'Blue'` is the value you're returning.

### First screen

You need to `await` the navigation:

```dart
final result = await Navigator.pushNamed(
  context,
  '/select-color',
);

print(result);
```

Output:

```text
Blue
```

You can then use it:

```dart
final result = await Navigator.pushNamed(
  context,
  '/select-color',
);

if (result != null) {
  print('Selected color: $result');
}
```

---

# 4. `pushNamed()` → `pop()` together

This is probably the most important pattern to remember.

### Screen A

```dart
Future<void> selectColor() async {
  final result = await Navigator.pushNamed(
    context,
    '/select-color',
  );

  print('Result: $result');
}
```

### Screen B

```dart
ElevatedButton(
  onPressed: () {
    Navigator.pop(context, 'Blue');
  },
  child: const Text('Select Blue'),
)
```

When the button is clicked:

```dart
Navigator.pop(context, 'Blue');
```

returns `'Blue'` to:

```dart
final result = await Navigator.pushNamed(...);
```

---

# 5. You can send objects too

For example, suppose you have:

```dart
class User {
  final int id;
  final String name;

  User(this.id, this.name);
}
```

You can send a `User`:

```dart
final user = User(10, 'Hashimi');

Navigator.pushNamed(
  context,
  '/details',
  arguments: user,
);
```

Receive it:

```dart
final user = ModalRoute.of(context)!.settings.arguments as User;

print(user.id);
print(user.name);
```

And you can also return objects with `pop()`:

```dart
Navigator.pop(
  context,
  User(10, 'Hashimi'),
);
```

Then:

```dart
final User? result = await Navigator.pushNamed(
  context,
  '/select-user',
) as User?;

if (result != null) {
  print(result.name);
}
```

---

## 6. Don't forget route registration

If you're using `pushNamed`, your route needs to be registered:

```dart
MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => const HomePage(),
    '/details': (context) => const DetailsPage(),
    '/select-color': (context) => const SelectColorPage(),
  },
);
```

---

## The pattern to memorize

### Send **forward**

```dart
Navigator.pushNamed(
  context,
  '/page',
  arguments: data,
);
```

Receive:

```dart
final data = ModalRoute.of(context)!.settings.arguments;
```

### Send **backward**

From the second page:

```dart
Navigator.pop(context, data);
```

Receive on the first page:

```dart
final data = await Navigator.pushNamed(
  context,
  '/page',
);
```

So conceptually:

```text
        arguments
A ──────────────────→ B
                      │
                      │ result
                      ↓
A ←────────────────── B
        Navigator.pop()
```

If you're building your Flutter app now, **`pushNamed + arguments + pop(result)`** is a good pattern to understand before moving to more advanced navigation such as `go_router`.
