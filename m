Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89116E8287
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Apr 2023 22:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjDSUVr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 Apr 2023 16:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjDSUVq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Apr 2023 16:21:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125A05FD5;
        Wed, 19 Apr 2023 13:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681935704; x=1713471704;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S2Lklte3PJofGULU9yOhUBnj/tnR93laUIUy6Uea7RY=;
  b=SKZjOR6Ru/eydmI5VXEPsIQV05s8C7SqhMSdT1Ir0czSCDL7/mps7oAh
   YsQuUMqaE6gqawdsCXFUQYLx6Z8tURrC7f/57Ulf7n815Xbw/DGCW7o+s
   wsIrwMBW91sgBncR9I8dq4TVKNx97kOAddm/eCvIDpcBBqwj4QKkgNirw
   M08PuNxlT4Zdf6y+8aTxdG2XtN8RiDGdrHmIzZq/iITnnAS6C+GDBPYka
   PVcQ++DZVrGkNby9qngInIP0Sb104uExpP7wH5Lunv/0E0QaTMmlSdPxT
   iCH6XsaA8cdSNYb2FNz7O5O6b/UR+MJ/9pjThlJdga0vWmyWst7qc549t
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="431831653"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="431831653"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 13:21:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="722081851"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="722081851"
Received: from jdgarvey-mobl.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.179.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 13:21:43 -0700
Subject: [PATCH v4 07/23] cxl: Add callback to parse the SSLBIS subtable from
 CDAT
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Wed, 19 Apr 2023 13:21:43 -0700
Message-ID: <168193570345.1178687.2383268813534307968.stgit@djiang5-mobl3>
In-Reply-To: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Provide a callback to parse the Switched Scoped Latency and Bandwidth
Information Structure (DSLBIS) in the CDAT structures. The SSLBIS
contains the bandwidth and latency information that's tied to the
CLX switch that the data table has been read from. The extracted
values are indexed by the downstream port id. It is possible
the downstream port id is 0xffff which is a wildcard value for any
port id.

Coherent Device Attribute Table 1.03 2.1 Switched Scoped Latency
and Bandwidth Information Structure (DSLBIS)

Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v3:
- Add spec section in commit header (Alison)
- Move CDAT parse to cxl_switch_port_probe()
- Use 'struct node_hmem_attrs'
---
 drivers/cxl/core/cdat.c |   76 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/port.c |    5 +++
 drivers/cxl/cxl.h       |    1 +
 drivers/cxl/cxlpci.h    |   20 ++++++++++++
 drivers/cxl/port.c      |   14 ++++++++-
 5 files changed, 115 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index e8b9bb99dfdf..ec3420dddf27 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -192,3 +192,79 @@ int cxl_dslbis_parse_entry(struct cdat_entry_header *header, void *arg)
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dslbis_parse_entry, CXL);
+
+int cxl_sslbis_parse_entry(struct cdat_entry_header *header, void *arg)
+{
+	struct cdat_sslbis *sslbis = (struct cdat_sslbis *)header;
+	struct xarray *sslbis_xa = arg;
+	int remain, entries, i;
+
+	remain = sslbis->hdr.length - sizeof(*sslbis);
+	if (!remain || remain % sizeof(struct sslbis_sslbe)) {
+		pr_warn("Malformed SSLBIS table length: (%u)\n",
+			sslbis->hdr.length);
+		return -EINVAL;
+	}
+
+	/* Unrecognized data type, we can skip */
+	if (sslbis->data_type >= HMAT_SLLBIS_DATA_TYPE_MAX)
+		return 0;
+
+	entries = remain / sizeof(*sslbis);
+
+	for (i = 0; i < entries; i++) {
+		struct sslbis_sslbe *sslbe = &sslbis->sslbe[i];
+		u16 x = le16_to_cpu(sslbe->port_x_id);
+		u16 y = le16_to_cpu(sslbe->port_y_id);
+		struct node_hmem_attrs *hmem_attrs;
+		u16 dsp_id;
+		u64 val;
+		int rc;
+
+		switch (x) {
+		case SSLBIS_US_PORT:
+			dsp_id = y;
+			break;
+		case SSLBIS_ANY_PORT:
+			switch (y) {
+			case SSLBIS_US_PORT:
+				dsp_id = x;
+				break;
+			case SSLBIS_ANY_PORT:
+				dsp_id = SSLBIS_ANY_PORT;
+				break;
+			default:
+				dsp_id = y;
+				break;
+			}
+			break;
+		default:
+			dsp_id = x;
+			break;
+		}
+
+		hmem_attrs = xa_load(sslbis_xa, dsp_id);
+		if (xa_is_err(hmem_attrs))
+			return xa_err(hmem_attrs);
+		if (!hmem_attrs) {
+			hmem_attrs = kzalloc(sizeof(*hmem_attrs), GFP_KERNEL);
+			if (!hmem_attrs)
+				return -ENOMEM;
+		}
+
+		rc = check_mul_overflow(le64_to_cpu(sslbis->entry_base_unit),
+					le16_to_cpu(sslbe->value), &val);
+		if (unlikely(rc))
+			pr_warn("SSLBIS value overflowed!\n");
+
+		cxl_hmem_attrs_set(hmem_attrs, sslbis->data_type, val);
+		rc = xa_insert(sslbis_xa, dsp_id, hmem_attrs, GFP_KERNEL);
+		if (rc < 0 && rc != -EBUSY) {
+			kfree(hmem_attrs);
+			return rc;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_sslbis_parse_entry, CXL);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 024d4178f557..3fedbabac1af 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -518,6 +518,7 @@ static void cxl_ep_remove(struct cxl_port *port, struct cxl_ep *ep)
 static void cxl_port_release(struct device *dev)
 {
 	struct cxl_port *port = to_cxl_port(dev);
+	struct node_hmem_attrs *hmem_attrs;
 	unsigned long index;
 	struct cxl_ep *ep;
 
@@ -526,6 +527,9 @@ static void cxl_port_release(struct device *dev)
 	xa_destroy(&port->endpoints);
 	xa_destroy(&port->dports);
 	xa_destroy(&port->regions);
+	xa_for_each(&port->cdat.sslbis_xa, index, hmem_attrs)
+		kfree(hmem_attrs);
+	xa_destroy(&port->cdat.sslbis_xa);
 	ida_free(&cxl_port_ida, port->id);
 	kfree(port);
 }
@@ -684,6 +688,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
 	xa_init(&port->dports);
 	xa_init(&port->endpoints);
 	xa_init(&port->regions);
+	xa_init(&port->cdat.sslbis_xa);
 
 	device_initialize(dev);
 	lockdep_set_class_and_subclass(&dev->mutex, &cxl_port_key, port->depth);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 18ca25c7e527..318aa051f65a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -581,6 +581,7 @@ struct cxl_port {
 	struct cxl_cdat {
 		void *table;
 		size_t length;
+		struct xarray sslbis_xa;
 	} cdat;
 	bool cdat_available;
 };
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 0f36fb23055c..1bca1c0e4b40 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -148,6 +148,25 @@ struct cdat_dslbis {
 #define DSLBIS_MEM_MASK		GENMASK(3, 0)
 #define DSLBIS_MEM_MEMORY	0
 
+struct sslbis_sslbe {
+	__le16 port_x_id;
+	__le16 port_y_id;
+	__le16 value;	/* latency or bandwidth */
+	__le16 reserved;
+} __packed;
+
+/* Sub-table 5: Switch Scoped Latency and Bandwidth Information Structure (SSLBIS) */
+struct cdat_sslbis {
+	struct cdat_entry_header hdr;
+	u8 data_type;
+	u8 reserved[3];
+	__le64 entry_base_unit;
+	struct sslbis_sslbe sslbe[];
+} __packed;
+
+#define SSLBIS_US_PORT		0x0100
+#define SSLBIS_ANY_PORT		0xffff
+
 int devm_cxl_port_enumerate_dports(struct cxl_port *port);
 struct cxl_dev_state;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
@@ -169,4 +188,5 @@ int cxl_##x##_parse_entry(struct cdat_entry_header *header, void *arg)
 
 cxl_parse_entry(dsmas);
 cxl_parse_entry(dslbis);
+cxl_parse_entry(sslbis);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index ab584b83010d..2d5b9ba13429 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -83,7 +83,19 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 	if (IS_ERR(cxlhdm))
 		return PTR_ERR(cxlhdm);
 
-	return devm_cxl_enumerate_decoders(cxlhdm, NULL);
+	rc = devm_cxl_enumerate_decoders(cxlhdm, NULL);
+	if (rc < 0)
+		return rc;
+
+	if (port->cdat.table) {
+		rc = cdat_table_parse_sslbis(port->cdat.table,
+					     cxl_sslbis_parse_entry,
+					     (void *)&port->cdat.sslbis_xa);
+		if (rc <= 0)
+			dev_warn(&port->dev, "Failed to parse SSLBIS: %d\n", rc);
+	}
+
+	return 0;
 }
 
 static int cxl_endpoint_port_probe(struct cxl_port *port)


