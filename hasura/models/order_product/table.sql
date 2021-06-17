/* TABLE */
CREATE TABLE "order_product" (
    id int GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    created_at timestamptz DEFAULT now() NOT NULL,
    updated_at timestamptz DEFAULT now() NOT NULL,
    order_id int NOT NULL,
    product_id int NOT NULL,
    quantity int NOT NULL
);

COMMENT ON TABLE "order_product" IS 'A product belonging to a customer order, along with a quantity';


/* FOREIGN KEYS */
ALTER TABLE ONLY public.order_product
    ADD CONSTRAINT order_id_fkey FOREIGN KEY (order_id) REFERENCES public.order (id);

ALTER TABLE ONLY public.order_product
    ADD CONSTRAINT product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product (id);


/* TRIGGERS */
CREATE TRIGGER set_order_product_updated_at
    BEFORE UPDATE ON public.order_product
    FOR EACH ROW
    EXECUTE FUNCTION public.set_current_timestamp_updated_at ();