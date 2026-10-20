-- Run this once in Supabase → SQL Editor → New query → Run.
create table if not exists public.weeks (
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  week_id text not null,
  monday date not null,
  cells jsonb not null default '{}'::jsonb,
  notes jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now(),
  primary key (user_id, week_id)
);

alter table public.weeks enable row level security;

create policy "Read own weeks"   on public.weeks for select using (auth.uid() = user_id);
create policy "Add own weeks"    on public.weeks for insert with check (auth.uid() = user_id);
create policy "Change own weeks" on public.weeks for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "Delete own weeks" on public.weeks for delete using (auth.uid() = user_id);
