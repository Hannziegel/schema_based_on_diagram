CREATE DATABASE clinic_db;

CREATE TABLE "patients"(
    "id" INTEGER NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "date_of_birth" DATE NOT NULL,
   );

ALTER TABLE
    "patients" ADD PRIMARY KEY("id");

CREATE TABLE "medical_histories"(
    "id" INTEGER NOT NULL,
    "admitted_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "patient_id" INTEGER  NOT NULL  REFERENCES patients(id),
    "status" VARCHAR(255) NOT NULL,
    );
ALTER TABLE
    "medical_histories" ADD PRIMARY KEY("id");
CREATE TABLE "invoices"(
    "id" INTEGER NOT NULL,
    "total_amount" INTEGER NOT NULL,
    "generated_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "payed_at" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "medical_history_id" INTEGER NOT NULL REFERENCES medical_histories(id),
);
ALTER TABLE
    "invoices" ADD PRIMARY KEY("id");
CREATE TABLE "invoice_items"(
    "id" INTEGER NOT NULL,
    "unit_price" DECIMAL(8, 2) NOT NULL,
    "quantity" INTEGER NOT NULL,
    "total_price" DECIMAL(8, 2) NOT NULL,
    "invoice_id" INTEGER NOT NULL REFERENCES invoices(id),
    "treatment_id" INTEGER NOT NULL REFERENCES treatments(id),
    PRIMARY KEY (id)
);

CREATE TABLE diagnosis(
      treat_id INTEGER NOT NULL  REFERENCES treatments(id),
      med_hist_id INTEGER NOT NULL   REFERENCES medical_histories(id),
      PRIMARY KEY( treat_id, med_hist_id)
);

CREATE TABLE "treatments"(
    "id" INTEGER NOT NULL,
    "type" VARCHAR(255) NOT NULL,
    "name" VARCHAR(255) NOT NULL
);

ALTER TABLE "treatments" ADD PRIMARY KEY("id");

ALTER TABLE "medical_histories" ADD CONSTRAINT "medical_histories_patient_id_foreign" FOREIGN KEY("patient_id") REFERENCES "patients"("id");

ALTER TABLE "invoice_items" ADD CONSTRAINT "invoice_items_treatment_id_foreign" FOREIGN KEY("treatment_id") REFERENCES "treatments"("id");

ALTER TABLE "invoice_items" ADD CONSTRAINT "invoice_items_invoice_id_foreign" FOREIGN KEY("invoice_id") REFERENCES "invoices"("id");

ALTER TABLE "invoices" ADD CONSTRAINT "invoices_medical_history_id_foreign" FOREIGN KEY("medical_history_id") REFERENCES "medical_histories"("id");

CREATE INDEX index_invoice_medic_history_invoice ON invoices(medical_history_id);

CREATE INDEX index_id_patient_medic_history ON medical_histories(patient_id);

CREATE INDEX index_invoice_items_id ON invoice_items(invoice_id);

CREATE INDEX index_treatment_id ON invoice_items(treatment_id);

CREATE INDEX index_medic_history_prescribed_treatments ON prescribed_treatments(medical_history_id);

CREATE INDEX index_treatments_id_pres_treat  ON prescribed_treatments(treatments_id);
