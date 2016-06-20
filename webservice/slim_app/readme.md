ApiVMC
=======

ApiVMC Slim framework created using the MVC pattern.


Getting Started
---------------
1. Get or download the project
2. Install it using Composer

Folder System
---------------
* lib/
    * Config.php (Class to store with config variables)
    * Core.php (Singleton PDO connection to the DB)   
* models/
* public/
* routers/
	* name.router.php (routes by functionalities)
* templates/

### lib/

Here we have the core classes of the connection with the DB

### models/

Add the model classes here.
We are using PDO for the Database.

Example of class:

Stuff.php

```php
class Stuff {

    protected $core;

    function __construct() {
        $this->core = Core::getInstance();
    }

    // Get all stuff
    public function getAllStuff() {
        $r = array();

        $sql = "SELECT * FROM stuff";
        $stmt = $this->core->dbh->prepare($sql);

        if ($stmt->execute()) {
            $r = $stmt->fetchAll(\PDO::FETCH_ASSOC);
        } else {
            $r = 0;
        }
        return $r;
    }
}
```

### public/

All the public files:
* Images, CSS and JS files
* index.php

### routers/

All the files with the routes. Each file contents the routes of an specific functionality.
It is very important that the names of the files inside this folder follow this pattern: name.router.php

Example of router file:

stuff.router.php

```php
// Get stuff
$app->get('/stuff', function () use ($app) {
    echo 'This is a GET route';
});

//Create user
$app->post('/stuff', function () use ($app) {
    echo 'This is a POST route';
});

// PUT route
$app->put('/stuff', function () {
    echo 'This is a PUT route';
});

// DELETE route
$app->delete('/stuff', function () {
    echo 'This is a DELETE route';
});
```

