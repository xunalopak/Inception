<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** Database username */
define( 'DB_USER', 'rchampli' );

/** Database password */
define( 'DB_PASSWORD', 'inception' );

/** Database hostname */
define( 'DB_HOST', 'mariadb' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '2{Q9Yp5T/4GNm`bF,s=v^Sk~iOyDaP=!|EGD}%#ftgJ!<VCF{O,23J#&Xi+STSD~');
define('SECURE_AUTH_KEY',  'g|OuE>9j:qO/4utp/x5n)ZP`4D[2SkG{HA tyk0gaBs*)6hkkFBX3#lYwYLDaVi!');
define('LOGGED_IN_KEY',    'wo>?(+E623_MxL|/Ag+]u+@PANI|{L=OeS0cp8PZHv>]M1]>H`H]|J[lJLW%adx&');
define('NONCE_KEY',        'BwHI3CKOqf}[+w(n1LGVkKe6frB}t<s0T|jD<@s+pXEy?{-rU-JfpE5)iN(VNZY-');
define('AUTH_SALT',        ']hNBj^7Ej_@W5inMa_iyd{f80E/F.C+`Knv(Tz,%Ud-hfm]Qcoz#4]Cs*p>n1)2v');
define('SECURE_AUTH_SALT', '%==aT!eKqD+2X#cXct|g3G_+|c${^bzQn2,~{c4DhYy)b}~Vh^KCDt|+.$n~{k3 ');
define('LOGGED_IN_SALT',   '6o>78fcxU{y~BEt!O]z{#Z4RD<>f&qLL`r1Acz/`}7x/%-FqD55wbg3&-tnQg8yn');
define('NONCE_SALT',       ')Ww76uhf6u5{2)Ia/vWTWZF%hMq8=N|dl@!R:uBA)YF-|G d S[-#xbOUl][Rq|E');

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';