# my_awesome_namer

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
#   m y _ a w e s o m e _ n a m e r 
 
 

create table if not exists public.dogs (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  image_url text not null,
  profile_url text not null,
  birth_date text,
  age text,
  breed text,
  gender text,
  weight text,
  height text,
  location text,
  created_at timestamp with time zone default timezone('utc'::text, now())
);

create table if not exists public.breeds (
  id uuid primary key default gen_random_uuid(),
  name text not null
);

-- Enable Row Level Security
alter table breeds enable row level security;

-- Create a policy to allow read access to everyone (e.g., anon role)
create policy "Allow read access to breeds"
  on breeds
  for select
  using (true);




create table contacts (
  id uuid primary key default gen_random_uuid(),
  anrede text not null,
  vorname text not null,
  name text not null,
  email text not null,
  telefonnummer text not null,
  created_at timestamp with time zone default timezone('utc'::text, now())
);


ALTER TABLE contacts ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow insert for all"
ON contacts
FOR INSERT
TO public
WITH CHECK (true);


-- Allow insert if the user is authenticated and inserting their own user_id
CREATE POLICY "Allow insert for own user_id"
ON user_dogs
FOR INSERT
USING (auth.uid() = user_id);



CREATE POLICY "Allow anonymous inserts"
ON user_dogs
FOR INSERT
TO anon
WITH CHECK (
  true  -- or add conditions below
);

CREATE POLICY "Allow anonymous deletes"
ON user_dogs
FOR DELETE
TO anon
USING (true);



SELECT * FROM pg_policies WHERE tablename = 'user_dogs';

