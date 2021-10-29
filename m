Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D7D440395
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Oct 2021 21:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhJ2TyX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 Oct 2021 15:54:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:59702 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230216AbhJ2TyX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 29 Oct 2021 15:54:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10152"; a="254325385"
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="254325385"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 12:51:54 -0700
X-IronPort-AV: E=Sophos;i="5.87,193,1631602800"; 
   d="scan'208";a="574791750"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2021 12:51:54 -0700
Subject: [PATCH 5/6] cxl/test: Mock acpi_table_parse_cedt()
From:   Dan Williams <dan.j.williams@intel.com>
To:     rafael.j.wysocki@intel.com
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Date:   Fri, 29 Oct 2021 12:51:53 -0700
Message-ID: <163553711363.2509508.17428994087868269952.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <163553708697.2509508.16523059414830959692.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <163553708697.2509508.16523059414830959692.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Now that cxl_acpi has been converted to use the core ACPI CEDT sub-table
parser, update cxl_test to inject CFMWS and CHBS data directly into
cxl_acpi's handlers.

Cc: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c            |    2 +
 tools/testing/cxl/Kbuild      |    3 +-
 tools/testing/cxl/test/cxl.c  |   68 ++++++++++++++++++++++++++++-------------
 tools/testing/cxl/test/mock.c |   30 +++++-------------
 tools/testing/cxl/test/mock.h |    6 ++--
 5 files changed, 61 insertions(+), 48 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 7820082a2746..91e4072e7649 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -283,6 +283,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 }
 
 struct cxl_chbs_context {
+	struct device *dev;
 	unsigned long long uid;
 	resource_size_t chbcr;
 };
@@ -327,6 +328,7 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 	}
 
 	ctx = (struct cxl_chbs_context) {
+		.dev = host,
 		.uid = uid,
 	};
 	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbcr, &ctx);
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 86deba8308a1..1acdf2fc31c5 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
+ldflags-y += --wrap=acpi_table_parse_cedt
 ldflags-y += --wrap=is_acpi_device_node
-ldflags-y += --wrap=acpi_get_table
-ldflags-y += --wrap=acpi_put_table
 ldflags-y += --wrap=acpi_evaluate_integer
 ldflags-y += --wrap=acpi_pci_find_root
 ldflags-y += --wrap=pci_walk_bus
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index cb32f9e27d5d..736d99006fb7 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -182,6 +182,13 @@ static struct {
 	},
 };
 
+struct acpi_cedt_cfmws *mock_cfmws[4] = {
+	[0] = &mock_cedt.cfmws0.cfmws,
+	[1] = &mock_cedt.cfmws1.cfmws,
+	[2] = &mock_cedt.cfmws2.cfmws,
+	[3] = &mock_cedt.cfmws3.cfmws,
+};
+
 struct cxl_mock_res {
 	struct list_head list;
 	struct range range;
@@ -232,12 +239,6 @@ static struct cxl_mock_res *alloc_mock_res(resource_size_t size)
 
 static int populate_cedt(void)
 {
-	struct acpi_cedt_cfmws *cfmws[4] = {
-		[0] = &mock_cedt.cfmws0.cfmws,
-		[1] = &mock_cedt.cfmws1.cfmws,
-		[2] = &mock_cedt.cfmws2.cfmws,
-		[3] = &mock_cedt.cfmws3.cfmws,
-	};
 	struct cxl_mock_res *res;
 	int i;
 
@@ -257,8 +258,8 @@ static int populate_cedt(void)
 		chbs->length = size;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(cfmws); i++) {
-		struct acpi_cedt_cfmws *window = cfmws[i];
+	for (i = 0; i < ARRAY_SIZE(mock_cfmws); i++) {
+		struct acpi_cedt_cfmws *window = mock_cfmws[i];
 
 		res = alloc_mock_res(window->window_size);
 		if (!res)
@@ -269,21 +270,44 @@ static int populate_cedt(void)
 	return 0;
 }
 
-static acpi_status mock_acpi_get_table(char *signature, u32 instance,
-				       struct acpi_table_header **out_table)
+/*
+ * WARNING, this hack assumes the format of 'struct
+ * cxl_cfmws_context' and 'struct cxl_chbs_context' share the property that
+ * the first struct member is the device being probed by the cxl_acpi
+ * driver.
+ */
+struct cxl_cedt_context {
+	struct device *dev;
+};
+
+static int mock_acpi_table_parse_cedt(enum acpi_cedt_type id,
+				      acpi_tbl_entry_handler_arg handler_arg,
+				      void *arg)
 {
-	if (instance < U32_MAX || strcmp(signature, ACPI_SIG_CEDT) != 0)
-		return acpi_get_table(signature, instance, out_table);
+	struct cxl_cedt_context *ctx = arg;
+	struct device *dev = ctx->dev;
+	union acpi_subtable_headers *h;
+	unsigned long end;
+	int i;
 
-	*out_table = (struct acpi_table_header *) &mock_cedt;
-	return AE_OK;
-}
+	if (dev != &cxl_acpi->dev)
+		return acpi_table_parse_cedt(id, handler_arg, arg);
 
-static void mock_acpi_put_table(struct acpi_table_header *table)
-{
-	if (table == (struct acpi_table_header *) &mock_cedt)
-		return;
-	acpi_put_table(table);
+	if (id == ACPI_CEDT_TYPE_CHBS)
+		for (i = 0; i < ARRAY_SIZE(mock_cedt.chbs); i++) {
+			h = (union acpi_subtable_headers *)&mock_cedt.chbs[i];
+			end = (unsigned long)&mock_cedt.chbs[i + 1];
+			handler_arg(h, arg, end);
+		}
+
+	if (id == ACPI_CEDT_TYPE_CFMWS)
+		for (i = 0; i < ARRAY_SIZE(mock_cfmws); i++) {
+			h = (union acpi_subtable_headers *) mock_cfmws[i];
+			end = (unsigned long) h + mock_cfmws[i]->header.length;
+			handler_arg(h, arg, end);
+		}
+
+	return 0;
 }
 
 static bool is_mock_bridge(struct device *dev)
@@ -388,8 +412,7 @@ static struct cxl_mock_ops cxl_mock_ops = {
 	.is_mock_port = is_mock_port,
 	.is_mock_dev = is_mock_dev,
 	.mock_port = mock_cxl_root_port,
-	.acpi_get_table = mock_acpi_get_table,
-	.acpi_put_table = mock_acpi_put_table,
+	.acpi_table_parse_cedt = mock_acpi_table_parse_cedt,
 	.acpi_evaluate_integer = mock_acpi_evaluate_integer,
 	.acpi_pci_find_root = mock_acpi_pci_find_root,
 	.list = LIST_HEAD_INIT(cxl_mock_ops.list),
@@ -574,3 +597,4 @@ static __exit void cxl_test_exit(void)
 module_init(cxl_test_init);
 module_exit(cxl_test_exit);
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(ACPI);
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index b8c108abcf07..17408f892df4 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -58,36 +58,23 @@ bool __wrap_is_acpi_device_node(const struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL(__wrap_is_acpi_device_node);
 
-acpi_status __wrap_acpi_get_table(char *signature, u32 instance,
-				  struct acpi_table_header **out_table)
+int __wrap_acpi_table_parse_cedt(enum acpi_cedt_type id,
+				 acpi_tbl_entry_handler_arg handler_arg,
+				 void *arg)
 {
-	int index;
+	int index, rc;
 	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
-	acpi_status status;
 
 	if (ops)
-		status = ops->acpi_get_table(signature, instance, out_table);
+		rc = ops->acpi_table_parse_cedt(id, handler_arg, arg);
 	else
-		status = acpi_get_table(signature, instance, out_table);
+		rc = acpi_table_parse_cedt(id, handler_arg, arg);
 
 	put_cxl_mock_ops(index);
 
-	return status;
-}
-EXPORT_SYMBOL(__wrap_acpi_get_table);
-
-void __wrap_acpi_put_table(struct acpi_table_header *table)
-{
-	int index;
-	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
-
-	if (ops)
-		ops->acpi_put_table(table);
-	else
-		acpi_put_table(table);
-	put_cxl_mock_ops(index);
+	return rc;
 }
-EXPORT_SYMBOL(__wrap_acpi_put_table);
+EXPORT_SYMBOL_NS_GPL(__wrap_acpi_table_parse_cedt, ACPI);
 
 acpi_status __wrap_acpi_evaluate_integer(acpi_handle handle,
 					 acpi_string pathname,
@@ -169,3 +156,4 @@ __wrap_nvdimm_bus_register(struct device *dev,
 EXPORT_SYMBOL_GPL(__wrap_nvdimm_bus_register);
 
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(ACPI);
diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
index 805a94cb3fbe..15ed0fd877e4 100644
--- a/tools/testing/cxl/test/mock.h
+++ b/tools/testing/cxl/test/mock.h
@@ -6,9 +6,9 @@
 struct cxl_mock_ops {
 	struct list_head list;
 	bool (*is_mock_adev)(struct acpi_device *dev);
-	acpi_status (*acpi_get_table)(char *signature, u32 instance,
-				      struct acpi_table_header **out_table);
-	void (*acpi_put_table)(struct acpi_table_header *table);
+	int (*acpi_table_parse_cedt)(enum acpi_cedt_type id,
+				     acpi_tbl_entry_handler_arg handler_arg,
+				     void *arg);
 	bool (*is_mock_bridge)(struct device *dev);
 	acpi_status (*acpi_evaluate_integer)(acpi_handle handle,
 					     acpi_string pathname,

