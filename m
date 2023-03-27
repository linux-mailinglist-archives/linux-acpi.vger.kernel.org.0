Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351E16CB0DE
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Mar 2023 23:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjC0Vo5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Mar 2023 17:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjC0Vos (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Mar 2023 17:44:48 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080D81FF2;
        Mon, 27 Mar 2023 14:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679953488; x=1711489488;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yww4IVyJADF6fVSvA6jcZGyhvDlSeOXKLJGlMtUZj2Y=;
  b=cHF38lUs5+Hsq894G26/MeIp0E+Ab+cu5y6Bt2eYI9hRME2uCKCXuTl1
   uxRmFN7whQltrj/b9h90GR6xNzhAQbnHWKuAnBlGu9y2Y9jiDTIE4jyD5
   vhNqpE2ivwviFcYTNzhwVibzDnuZbkSP45QacIK/5NrTGyGfYGrHAlixk
   2Hf3R56LnVv/CHoQCYxBuaDAFCDP58emvK8TY1sfwKi117QEBpX7Q7ExF
   Gb1rXaecBNZpmROrJ+XlJ0L3e+WGPdx++w/uDVhDNABTMFbYK9OL9baoN
   ILBZvP5vpyhzMXuFE8N2k6MBCV7Lx2pkJrUvVLnNKmmJgEe0XJwQyVzx9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="339120650"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="339120650"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 14:44:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="677116237"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="677116237"
Received: from spal2-desk3.gar.corp.intel.com (HELO [192.168.1.177]) ([10.212.91.66])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 14:44:46 -0700
Subject: [PATCH v2 07/21] cxl: Add callback to parse the SSLBIS subtable from
 CDAT
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de
Date:   Mon, 27 Mar 2023 14:44:45 -0700
Message-ID: <167995348596.2857312.14405653084102194066.stgit@djiang5-mobl3>
In-Reply-To: <167995336797.2857312.539473939839316778.stgit@djiang5-mobl3>
References: <167995336797.2857312.539473939839316778.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
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

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/cdat.c |   76 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/port.c |    5 +++
 drivers/cxl/cxl.h       |    1 +
 drivers/cxl/cxlpci.h    |   24 +++++++++++++++
 drivers/cxl/port.c      |    6 ++++
 5 files changed, 112 insertions(+)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 0e88973e9f38..0e7a4f74fcf8 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -165,3 +165,79 @@ int cxl_dslbis_parse_entry(struct cdat_entry_header *header, void *arg)
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dslbis_parse_entry, CXL);
+
+int cxl_sslbis_parse_entry(struct cdat_entry_header *header, void *arg)
+{
+	struct cdat_sslbis *sslbis = (struct cdat_sslbis *)header;
+	struct xarray *sslbis_xa = (struct xarray *)arg;
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
+		struct sslbis_entry *sentry;
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
+		sentry = xa_load(sslbis_xa, dsp_id);
+		if (xa_is_err(sentry))
+			return xa_err(sentry);
+		if (!sentry) {
+			sentry = kzalloc(sizeof(*sentry), GFP_KERNEL);
+			if (!sentry)
+				return -ENOMEM;
+		}
+
+		rc = check_mul_overflow(le64_to_cpu(sslbis->entry_base_unit),
+					le16_to_cpu(sslbe->value), &val);
+		if (unlikely(rc))
+			pr_warn("SSLBIS value overflowed!\n");
+
+		sentry->qos[sslbis->data_type] = val;
+		rc = xa_insert(sslbis_xa, dsp_id, sentry, GFP_KERNEL);
+		if (rc < 0 && rc != -EBUSY) {
+			kfree(sentry);
+			return rc;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_sslbis_parse_entry, CXL);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 5ec48dddb2f9..a61f9395a209 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -518,6 +518,7 @@ static void cxl_ep_remove(struct cxl_port *port, struct cxl_ep *ep)
 static void cxl_port_release(struct device *dev)
 {
 	struct cxl_port *port = to_cxl_port(dev);
+	struct sslbis_entry *sentry;
 	unsigned long index;
 	struct cxl_ep *ep;
 
@@ -526,6 +527,9 @@ static void cxl_port_release(struct device *dev)
 	xa_destroy(&port->endpoints);
 	xa_destroy(&port->dports);
 	xa_destroy(&port->regions);
+	xa_for_each(&port->cdat.sslbis_xa, index, sentry)
+		kfree(sentry);
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
index 9d0e22fe72c0..50ac74f66cbd 100644
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
index 1429de49e0c4..1c9e8b078369 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -121,6 +121,10 @@ struct dsmas_entry {
 	u64 qos[HMAT_SLLBIS_DATA_TYPE_MAX];
 };
 
+struct sslbis_entry {
+	u64 qos[HMAT_SLLBIS_DATA_TYPE_MAX];
+};
+
 /* Sub-table 0: Device Scoped Memory Affinity Structure (DSMAS) */
 struct cdat_dsmas {
 	struct cdat_entry_header hdr;
@@ -148,6 +152,25 @@ struct cdat_dslbis {
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
@@ -169,4 +192,5 @@ int cxl_##x##_parse_entry(struct cdat_entry_header *header, void *arg)
 
 cxl_parse_entry(dsmas);
 cxl_parse_entry(dslbis);
+cxl_parse_entry(sslbis);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 6f2b327f7128..7839e0244d0d 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -163,6 +163,12 @@ static int cxl_port_probe(struct device *dev)
 			}
 
 			dsmas_list_destroy(&dsmas_list);
+		} else {
+			rc = cdat_table_parse_sslbis(port->cdat.table,
+						     cxl_sslbis_parse_entry,
+						     (void *)&port->cdat.sslbis_xa);
+			if (rc <= 0)
+				dev_warn(dev, "Failed to parse SSLBIS: %d\n", rc);
 		}
 	}
 


