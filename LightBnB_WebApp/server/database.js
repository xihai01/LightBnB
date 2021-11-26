const properties = require('./json/properties.json');
const users = require('./json/users.json');
const { Pool } = require('pg');

//connect to our db
const pool = new Pool({
  user: 'vagrant',
  password: '123',
  host: 'localhost',
  database: 'lightbnb'
});

/// Users

/**
 * Get a single user from the database given their email.
 * @param {String} email The email of the user.
 * @return {Promise<{}>} A promise to the user.
 */
const getUserWithEmail = function(email) {
  const query = `
  SELECT *
  FROM users
  WHERE email = $1;
  `;
  const values = [email];
  return pool
    .query(query, values)
    .then(res => {
      return Promise.resolve(res.rows[0]);
    })
    .catch(err => {
      return Promise.reject(err);
    });
/*   let user;
  for (const userId in users) {
    user = users[userId];
    if (user.email.toLowerCase() === email.toLowerCase()) {
      break;
    } else {
      user = null;
    }
  }
  return Promise.resolve(user); */
}
exports.getUserWithEmail = getUserWithEmail;

/**
 * Get a single user from the database given their id.
 * @param {string} id The id of the user.
 * @return {Promise<{}>} A promise to the user.
 */
const getUserWithId = function(id) {
  const query = `
  SELECT *
  FROM users
  WHERE id = $1;
  `;
  const values = [id];
  return pool
    .query(query, values)
    .then(res => {
      return Promise.resolve(res.rows[0]);
    })
    .catch(err => {
      return Promise.reject(err);
    });
  //return Promise.resolve(users[id]);
}
exports.getUserWithId = getUserWithId;


/**
 * Add a new user to the database.
 * @param {{name: string, password: string, email: string}} user
 * @return {Promise<{}>} A promise to the user.
 */
const addUser =  function(user) {
  const query = `
  INSERT INTO users (name, email, password)
  VALUES ($1, $2, $3) RETURNING *;
  `;
  const values = [user.name, user.email, user.password];
  return pool
    .query(query, values)
    .then(res => {
      return Promise.resolve(res.rows[0]);
    })
    .catch(err => {
      return Promise.reject(err);
    });
  /*   const userId = Object.keys(users).length + 1;
  user.id = userId;
  users[userId] = user;
  return Promise.resolve(user); */
}
exports.addUser = addUser;

/// Reservations

/**
 * Get all reservations for a single user.
 * @param {string} guest_id The id of the user.
 * @return {Promise<[{}]>} A promise to the reservations.
 */
const getAllReservations = function(guest_id, limit = 10) {
  const query = `
  SELECT reservations.*, properties.*, AVG(property_reviews.rating) as average_rating
  FROM properties
  JOIN property_reviews ON property_reviews.property_id = properties.id
  JOIN reservations ON reservations.property_id = properties.id
  WHERE reservations.guest_id = $1 AND reservations.end_date < now()::date
  GROUP BY reservations.id, properties.id
  ORDER BY reservations.start_date
  LIMIT $2;
  `;
  const values = [guest_id, limit];
  return pool
    .query(query, values)
    .then(res => {
      return Promise.resolve(res.rows);
    })
    .catch(err => {
      return Promise.reject(err);
    });
  //return getAllProperties(null, 2);
}
exports.getAllReservations = getAllReservations;

/// Properties

/**
 * Get all properties.
 * @param {{}} options An object containing query options.
 * @param {*} limit The number of results to return.
 * @return {Promise<[{}]>}  A promise to the properties.
 */
const getAllProperties = function(options, limit = 10) {
  //store the query string and params
  let mainQuery = `SELECT properties.*, AVG(property_reviews.rating) as average_rating
    FROM properties
    JOIN property_reviews ON property_reviews.property_id = properties.id
    `;
  /*   WHERE city LIKE '%Vancouver%'
    HAVING AVG(property_reviews.rating) >= 4
     */
    let query1 = ''; //hold WHERE
    let query2 = `GROUP BY properties.id`;
    let query3 = ''; //hold HAVING
    let query4 = `ORDER BY cost_per_night
    LIMIT $1;
    `;
  //mainQuery = query1 + query2 + query3 + query4
console.log(options);
  let params = [limit];
  //use conditionals to check options
  //filter by owner_id if exists
  if (options.owner_id) {
    params.push(options.owner_id);
    query1 += `WHERE owner_id = $${params.length}`;
  }
  //filter by city if it exists
  if (options.city) {
    params.push(`%${options.city}%`);
    query1 += `WHERE city LIKE $${params.length}`;
  }
  //filter by minimum_price_per_night
  if (options.minimum_price_per_night) {
    params.push(options.minimum_price_per_night * 100);
    //check if this is the first WHERE clause
    if (params.length === 2) {
      query1 += `WHERE cost_per_night >= $${params.length}`;
    }
    query1 += `AND cost_per_night >= $${params.length}`;
  }
  //filter by maximum price
  if (options.maximum_price_per_night) {
    params.push(options.maximum_price_per_night * 100);
    if (params.length === 2) {
      query1 += `WHERE cost_per_night <= $${params.length}`;
    }
    query1 += `AND cost_per_night <= $${params.length}`;
  }
  //filter by minimum rating
  if (options.minimum_rating) {
    params.push(options.minimum_rating);
    query3 += `HAVING AVG(property_reviews.rating) >= $${params.length}`;
  }
  //print out query string and params
  mainQuery += ' ' + query1 + ' ' + query2 + ' ' + query3 + ' ' + query4;
  console.log(mainQuery, params);

  return pool
    .query(mainQuery, params)
    .then(res => {
      return Promise.resolve(res.rows);
    })
    .catch(err => {
      return Promise.reject(err);
    });
  //pool.query
  /* const query = `
    SELECT *
    FROM properties
    LIMIT $1;`;
  const values = [limit];
  return pool
    .query(query, values)
    .then(res => {
      return res.rows;
    })
    .catch(err => {
      console.log(err.message);
    }); */
/*   const limitedProperties = {};
  for (let i = 1; i <= limit; i++) {
    limitedProperties[i] = properties[i];
  }
  return Promise.resolve(limitedProperties); */
}
exports.getAllProperties = getAllProperties;


/**
 * Add a property to the database
 * @param {{}} property An object containing all of the property details.
 * @return {Promise<{}>} A promise to the property.
 */
const addProperty = function(property) {
  const query = `
  INSERT INTO properties (
    title,
    description,
    owner_id,
    cover_photo_url,
    thumbnail_photo_url,
    cost_per_night,
    parking_spaces,
    number_of_bathrooms,
    number_of_bedrooms,
    province,
    city,
    country,
    street,
    post_code)
  VALUES (
    $1,
    $2,
    $3,
    $4,
    $5,
    $6,
    $7,
    $8,
    $9,
    $10,
    $11,
    $12,
    $13,
    $14
  ) RETURNING *;
  `;
  const values = [];

  property.title ? values.push(property.title) : values.push('title');
  values.push(property.description);
  values.push(property.owner_id);
  property.cover_photo_url ? values.push(property.cover_photo_url) : values.push('insert cover photo');
  property.thumbnail_photo_url ? values.push(property.thumbnail_photo_url) : values.push('insert thumbnail photo');
  values.push(property.cost_per_night);
  values.push(property.parking_spaces);
  values.push(property.number_of_bathrooms);
  values.push(property.number_of_bedrooms);
  property.province ? values.push(property.province) : values.push('Province');
  property.city ? values.push(property.city) : values.push('City');
  property.country ? values.push(property.country) : values.push('Country');
  property.street ? values.push(property.street) : values.push('Street');
  property.post_code ? values.push(property.post_code) : values.push('Post Code');

  console.log(query, values);
  return pool
    .query(query, values)
    .then(res => {
      return Promise.resolve(res.rows);
    })
    .catch(err => {
      return Promise.reject(err);
    });
/*   const propertyId = Object.keys(properties).length + 1;
  property.id = propertyId;
  properties[propertyId] = property;
  return Promise.resolve(property); */
}
exports.addProperty = addProperty;
