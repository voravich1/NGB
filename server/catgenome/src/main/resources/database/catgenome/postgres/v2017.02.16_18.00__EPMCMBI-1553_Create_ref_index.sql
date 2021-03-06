ALTER TABLE CATGENOME.REFERENCE_GENOME
  ADD INDEX_ID BIGINT NULL;

ALTER TABLE CATGENOME.REFERENCE_GENOME
  ADD CONSTRAINT REFERENCE_GENOME_BIOLOGICAL_DATA_ITEM_BIO_DATA_ITEM_ID_fk
FOREIGN KEY (INDEX_ID) REFERENCES CATGENOME.BIOLOGICAL_DATA_ITEM (BIO_DATA_ITEM_ID);

INSERT INTO CATGENOME.BIOLOGICAL_DATA_ITEM (bio_data_item_id, name, type, path, format, created_by, created_date, bucket_id)
VALUES (nextval('catgenome.s_biological_data_item'), 'Dummy Ref index', 1, '', -1, 42, CURRENT_TIMESTAMP, NULL);

UPDATE catgenome.REFERENCE_GENOME
SET INDEX_ID = (SELECT BIO_DATA_ITEM_ID
                FROM CATGENOME.BIOLOGICAL_DATA_ITEM
                WHERE CATGENOME.BIOLOGICAL_DATA_ITEM.NAME = 'Dummy Ref index')
WHERE BIO_DATA_ITEM_ID IN
      (
        SELECT BIO_DATA_ITEM_ID
        FROM CATGENOME.BIOLOGICAL_DATA_ITEM
        WHERE FORMAT = 1
      );

ALTER TABLE catgenome.reference_genome ALTER COLUMN index_id SET NOT NULL;