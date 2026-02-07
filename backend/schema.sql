-- Enable UUID extension
create extension if not exists "uuid-ossp";

-- USERS Table
create table public.users (
  id uuid references auth.users not null primary key,
  email text,
  username text,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- INTAKE LOGS Table
create table public.intake_logs (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references public.users(id) on delete cascade not null,
  cverage_name text not null,
  caffeine_amount_mg float not null,
  timestamp timestamp with time zone not null,
  synced_at timestamp with time zone default timezone('utc'::text, now())
);

-- BIOMETRICS Table
create table public.biometrics (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references public.users(id) on delete cascade not null,
  heart_rate_bpm int,
  activity_level text, -- 'resting', 'active', etc.
  timestamp timestamp with time zone not null
);

-- RLS Policies (Row Level Security)
alter table public.users enable row level security;
alter table public.intake_logs enable row level security;
alter table public.biometrics enable row level security;

-- Policy: Users can only see their own data
create policy "Users can view own data" on public.users
  for select using (auth.uid() = id);

create policy "Users can insert own data" on public.intake_logs
  for insert with check (auth.uid() = user_id);

create policy "Users can select own data" on public.intake_logs
  for select using (auth.uid() = user_id);

create policy "Users can insert own biometrics" on public.biometrics
  for insert with check (auth.uid() = user_id);

create policy "Users can select own biometrics" on public.biometrics
  for select using (auth.uid() = user_id);
