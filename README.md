# EMA Shop Solar

Application mobile professionnelle de gestion et de commerce d'installations solaires, développée avec Flutter en respectant les principes de la **Clean Architecture**.

## 🚀 Stack Technique & Architecture

* **Architecture :** Clean Architecture (Séparation en couches : `domain`, `data`, `presentation`)
* **Gestion d'état :** Flutter Riverpod
* **Navigation :** GoRouter (avec gestion des routes dynamiques)
* **Backend & API :** Supabase (Base de données en ligne et authentification)
* **Stockage Local :** Hive (Mise en cache locale et gestion du mode hors-ligne)

## 📁 Structure du Projet

```text
lib/
│
├── core/             # Configuration globale (routes, thèmes, constantes)
├── features/         # Fonctionnalités modulaires (ex: products, profile)
│   ├── data/         # Sources de données (local avec Hive, remote avec Supabase) & Repositories implémentés
│   ├── domain/       # Entités métiers, interfaces de repositories et use cases
│   └── presentation/ # Écrans, widgets et providers Riverpod
└── main.dart         # Point d'entrée de l'application