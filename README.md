#  Apple Global Sales Intelligence Platform

## Introduction

Ce projet consiste à construire une plateforme moderne d’analyse de données en utilisant les technologies Microsoft Azure.
L’objectif est d’ingérer, traiter, modéliser et visualiser les données des ventes mondiales d’Apple afin d’aider à la prise de décision stratégique.

La plateforme simule une architecture réelle utilisée par les entreprises pour analyser les performances commerciales à l’échelle internationale.

---

## Problème Business

La société ElectroTrend, une entreprise internationale de distribution de produits technologiques, souhaite centraliser ses données de ventes mondiales afin de répondre à des questions stratégiques :

* Quel pays génère le plus de revenus ?
* Quel canal de vente est le plus performant ?
* Les remises augmentent-elles le volume des ventes ?
* Quel segment client est le plus rentable ?
* Quelles sont les tendances saisonnières des ventes ?

---

## Objectifs du projet

Les principaux objectifs sont :

* Construire une architecture cloud scalable
* Mettre en place un pipeline d’ingestion automatique
* Concevoir un Data Warehouse analytique
* Calculer des KPIs métiers
* Créer des dashboards interactifs

---

## Stack Technologique

### ☁️ Cloud et Plateforme Data

* Microsoft Azure

### 💾 Stockage des données

*  Azure Blob Storage

### 🔄 Intégration des données

* Azure Data Factory

### 🏢 Data Warehouse

* Azure Synapse Analytics

### 🔐 Gouvernance des données

* Azure Purview

### 📊 Business Intelligence

* Power BI

### 🤝 Outils collaboratifs

* GitHub
* Jira

---

## Architecture du Pipeline de Données

Le pipeline suit une architecture en couches :
![azure architecture](https://drive.google.com/uc?export=view&id=1oXyJ-vTIZdIVQpboOFlaIrodOPJkxmLC)
---

## Description du Dataset

Dataset : Apple Global Product Sales Dataset

Caractéristiques :

* 11 500 transactions
* 47 pays
* 514+ villes
* 43 produits
* 27 attributs
* Période : 2022 – 2024

Le dataset contient des informations sur les produits, canaux de vente, remises et segments clients.

---

## Conception du Data Warehouse

Le modèle analytique suit un schéma en étoile (**Star Schema**).

### Table de Faits

**Fact_Sales**
Contient les métriques quantitatives :

* Revenus
* Quantité vendue
* Remises

### Tables de Dimensions

* Dim_Date
* Dim_Product
* Dim_Geography
* Dim_Channel
* Dim_CustomerSegment

Cette structure permet d’exécuter efficacement les requêtes analytiques.

---

## KPIs Business

* Revenu total
* Total des unités vendues
* Remise moyenne
* Taux de retour
* Revenu par région
* Performance par canal
* Croissance annuelle des revenus

---

## Dashboard Power BI

Le dashboard interactif contient :

* Distribution mondiale des revenus
* Analyse des ventes par pays
* Performance des canaux
* Comparaison des catégories de produits
* Impact des remises
* Rentabilité des segments clients

---

## Structure du Repository

```
Azure-data-fill-stack/
│
├── data/
│   └── appleglobalsales_dataset.csv
│
├── architecture/
│   └── architecture-diagram.png
│
├── pipelines/
│   └── datafactory-pipeline.json
│
├── sql/
│   └── datawarehouse-schema.sql
│
├── dashboard/
│   └── powerbi-dashboard.pbix
│
├── documentation/
│   └── azure-services-study.pdf
│
└── README.md
```

---

## Insights Métiers

La plateforme permet :

* Identifier les marchés les plus rentables
* Analyser l’efficacité des remises
* Suivre les taux de retour produits
* Comparer les performances des canaux
* Étudier les tendances saisonnières

---

## Planning du Projet

Durée : 3 Mars → 13 Mars

Projet réalisé dans le cadre d’une formation en data analytics.

---

## Conclusion

Ce projet démontre comment le cloud computing peut être utilisé pour construire des solutions analytiques modernes.
Les services Azure permettent de transformer les données brutes en insights décisionnels exploitables.


