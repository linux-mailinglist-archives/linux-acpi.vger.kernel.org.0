Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D1C3CA063
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jul 2021 16:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236344AbhGOOTY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Jul 2021 10:19:24 -0400
Received: from mga09.intel.com ([134.134.136.24]:52349 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237203AbhGOOTX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 15 Jul 2021 10:19:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="210541335"
X-IronPort-AV: E=Sophos;i="5.84,242,1620716400"; 
   d="scan'208";a="210541335"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 07:16:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,242,1620716400"; 
   d="scan'208";a="655753816"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 15 Jul 2021 07:16:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B7D012CB; Thu, 15 Jul 2021 17:16:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 2/2] ACPI: configfs: Make get_header() to return error pointer
Date:   Thu, 15 Jul 2021 17:16:51 +0300
Message-Id: <20210715141651.82325-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715141651.82325-1-andriy.shevchenko@linux.intel.com>
References: <20210715141651.82325-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Instead of duplicating error codes here and there,
make get_header() to return error pointer.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/acpi_configfs.c | 38 ++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/acpi_configfs.c b/drivers/acpi/acpi_configfs.c
index 6e6ef8a1f447..c970792b11a4 100644
--- a/drivers/acpi/acpi_configfs.c
+++ b/drivers/acpi/acpi_configfs.c
@@ -70,7 +70,7 @@ static inline struct acpi_table_header *get_header(struct config_item *cfg)
 	if (!table->header)
 		pr_err("table not loaded\n");
 
-	return table->header;
+	return table->header ?: ERR_PTR(-EINVAL);
 }
 
 static ssize_t acpi_table_aml_read(struct config_item *cfg,
@@ -78,8 +78,8 @@ static ssize_t acpi_table_aml_read(struct config_item *cfg,
 {
 	struct acpi_table_header *h = get_header(cfg);
 
-	if (!h)
-		return -EINVAL;
+	if (IS_ERR(h))
+		return PTR_ERR(h);
 
 	if (data)
 		memcpy(data, h, h->length);
@@ -100,8 +100,8 @@ static ssize_t acpi_table_signature_show(struct config_item *cfg, char *str)
 {
 	struct acpi_table_header *h = get_header(cfg);
 
-	if (!h)
-		return -EINVAL;
+	if (IS_ERR(h))
+		return PTR_ERR(h);
 
 	return sysfs_emit(str, "%.*s\n", ACPI_NAMESEG_SIZE, h->signature);
 }
@@ -110,8 +110,8 @@ static ssize_t acpi_table_length_show(struct config_item *cfg, char *str)
 {
 	struct acpi_table_header *h = get_header(cfg);
 
-	if (!h)
-		return -EINVAL;
+	if (IS_ERR(h))
+		return PTR_ERR(h);
 
 	return sysfs_emit(str, "%d\n", h->length);
 }
@@ -120,8 +120,8 @@ static ssize_t acpi_table_revision_show(struct config_item *cfg, char *str)
 {
 	struct acpi_table_header *h = get_header(cfg);
 
-	if (!h)
-		return -EINVAL;
+	if (IS_ERR(h))
+		return PTR_ERR(h);
 
 	return sysfs_emit(str, "%d\n", h->revision);
 }
@@ -130,8 +130,8 @@ static ssize_t acpi_table_oem_id_show(struct config_item *cfg, char *str)
 {
 	struct acpi_table_header *h = get_header(cfg);
 
-	if (!h)
-		return -EINVAL;
+	if (IS_ERR(h))
+		return PTR_ERR(h);
 
 	return sysfs_emit(str, "%.*s\n", ACPI_OEM_ID_SIZE, h->oem_id);
 }
@@ -140,8 +140,8 @@ static ssize_t acpi_table_oem_table_id_show(struct config_item *cfg, char *str)
 {
 	struct acpi_table_header *h = get_header(cfg);
 
-	if (!h)
-		return -EINVAL;
+	if (IS_ERR(h))
+		return PTR_ERR(h);
 
 	return sysfs_emit(str, "%.*s\n", ACPI_OEM_TABLE_ID_SIZE, h->oem_table_id);
 }
@@ -150,8 +150,8 @@ static ssize_t acpi_table_oem_revision_show(struct config_item *cfg, char *str)
 {
 	struct acpi_table_header *h = get_header(cfg);
 
-	if (!h)
-		return -EINVAL;
+	if (IS_ERR(h))
+		return PTR_ERR(h);
 
 	return sysfs_emit(str, "%d\n", h->oem_revision);
 }
@@ -161,8 +161,8 @@ static ssize_t acpi_table_asl_compiler_id_show(struct config_item *cfg,
 {
 	struct acpi_table_header *h = get_header(cfg);
 
-	if (!h)
-		return -EINVAL;
+	if (IS_ERR(h))
+		return PTR_ERR(h);
 
 	return sysfs_emit(str, "%.*s\n", ACPI_NAMESEG_SIZE, h->asl_compiler_id);
 }
@@ -172,8 +172,8 @@ static ssize_t acpi_table_asl_compiler_revision_show(struct config_item *cfg,
 {
 	struct acpi_table_header *h = get_header(cfg);
 
-	if (!h)
-		return -EINVAL;
+	if (IS_ERR(h))
+		return PTR_ERR(h);
 
 	return sysfs_emit(str, "%d\n", h->asl_compiler_revision);
 }
-- 
2.30.2

