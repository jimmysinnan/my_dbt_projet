# 🚴‍♂️ Local Bike – Data Self‑Service - De Fivetran - BigQuery → DBT → Power BI

### 🎯 Contexte

Local Bike, une entreprise de distribution de vélos implantée sur trois magasins, souhaitait passer d’un reporting manuel à une solution automatisée et unifiée d’analyse.
L’objectif : gagner en visibilité sur les ventes, les stocks et le parcours client pour mieux piloter la performance commerciale et anticiper les besoins opérationnels.

### 🧩 Problématique & Solution

#### 🧠 Problème identifié
Une chaîne de magasins de vélos (3 sites) manque de visibilité sur les ventes, les stocks et les parcours clients.
L’entreprise disposait de données éparses et non structurées, rendant complexe l’analyse globale de son activité. Les rapports étaient chronophages et souvent obsolètes au moment de leur consultation.
#### 💡 Solution déployée
- Centralisation des données dans Google BigQuery.
- Modélisation et transformation via DBT (ETL/ELT automatisé).
- Mise en place de tests pour fiabiliser les modèles et assurer la cohérence des indicateurs.
- Restitution visuelle à travers un dashboard interactif Power BI, facilitant l’exploration et la prise de décision.
#### ⚙️ Stack technique
| Outil               | Rôle principal                                     |
| ------------------- | -------------------------------------------------- |
| **Google BigQuery** | Stockage et requêtes SQL sur données brutes        |
| **DBT**             | Transformation, documentation et tests automatisés |
| **Power BI**        | Visualisation et partage des indicateurs           |
| **GitHub CI/CD**    | Versionning et intégration continue                |
| **SQL**             | Requêtes analytiques et modélisation               |


### 🧭 Objectifs du projet

#### 1️⃣ Définir les axes d’analyse 
- Identifier les leviers d’optimisation pour l’équipe opérationnelle.
- Fournir des insights permettant d’améliorer les ventes et maximiser le revenu.

#### 2️⃣ Structurer et modéliser les données
- Mettre en place des tests automatisés et une documentation lisible sur chaque modèle clé.
- Faciliter la maintenance et la collaboration via GitHub.

#### 3️⃣ Garantir la qualité et la transparence
- Ajouter des tests et une documentation complète, en particulier pour
les modèles qui seront connectés aux tableaux de bord.

#### 4️⃣ Valoriser la donnée par la visualisation
- Héberger le projet sur GitHub pour permettre les peer‑reviews et le partage des insights.
- Concevoir des dashboards interactifs sous Power BI

### 📈 Résultats obtenus
- Automatisation complète du reporting manuel
- Accès en temps réel aux KPIs clés (ventes, marges, stocks, conversion).
- Standardisation des sources et gain de temps significatif pour les équipes métiers.

