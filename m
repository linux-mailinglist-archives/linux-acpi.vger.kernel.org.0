Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1AA3CA061
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jul 2021 16:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236876AbhGOOTX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Jul 2021 10:19:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:60029 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236344AbhGOOTW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 15 Jul 2021 10:19:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="210366765"
X-IronPort-AV: E=Sophos;i="5.84,242,1620716400"; 
   d="scan'208";a="210366765"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 07:16:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,242,1620716400"; 
   d="scan'208";a="413657783"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 15 Jul 2021 07:16:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EBE15262; Thu, 15 Jul 2021 17:16:54 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 1/2] ACPI: configfs: Use sysfs_emit() in "show" functions
Date:   Thu, 15 Jul 2021 17:16:50 +0300
Message-Id: <20210715141651.82325-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The sysfs_emit() function was introduced to make it less ambiguous
which function is preferred when writing to the output buffer in
a "show" callback [1].

Convert the GPIO library sysfs interface from sprintf() to sysfs_emit()
accordingly, as the latter is aware of the PAGE_SIZE buffer and correctly
returns the number of bytes written into the buffer.

No functional change intended.

[1] Documentation/filesystems/sysfs.rst

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/acpi_configfs.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpi_configfs.c b/drivers/acpi/acpi_configfs.c
index 76b83b181356..6e6ef8a1f447 100644
--- a/drivers/acpi/acpi_configfs.c
+++ b/drivers/acpi/acpi_configfs.c
@@ -103,7 +103,7 @@ static ssize_t acpi_table_signature_show(struct config_item *cfg, char *str)
 	if (!h)
 		return -EINVAL;
 
-	return sprintf(str, "%.*s\n", ACPI_NAMESEG_SIZE, h->signature);
+	return sysfs_emit(str, "%.*s\n", ACPI_NAMESEG_SIZE, h->signature);
 }
 
 static ssize_t acpi_table_length_show(struct config_item *cfg, char *str)
@@ -113,7 +113,7 @@ static ssize_t acpi_table_length_show(struct config_item *cfg, char *str)
 	if (!h)
 		return -EINVAL;
 
-	return sprintf(str, "%d\n", h->length);
+	return sysfs_emit(str, "%d\n", h->length);
 }
 
 static ssize_t acpi_table_revision_show(struct config_item *cfg, char *str)
@@ -123,7 +123,7 @@ static ssize_t acpi_table_revision_show(struct config_item *cfg, char *str)
 	if (!h)
 		return -EINVAL;
 
-	return sprintf(str, "%d\n", h->revision);
+	return sysfs_emit(str, "%d\n", h->revision);
 }
 
 static ssize_t acpi_table_oem_id_show(struct config_item *cfg, char *str)
@@ -133,7 +133,7 @@ static ssize_t acpi_table_oem_id_show(struct config_item *cfg, char *str)
 	if (!h)
 		return -EINVAL;
 
-	return sprintf(str, "%.*s\n", ACPI_OEM_ID_SIZE, h->oem_id);
+	return sysfs_emit(str, "%.*s\n", ACPI_OEM_ID_SIZE, h->oem_id);
 }
 
 static ssize_t acpi_table_oem_table_id_show(struct config_item *cfg, char *str)
@@ -143,7 +143,7 @@ static ssize_t acpi_table_oem_table_id_show(struct config_item *cfg, char *str)
 	if (!h)
 		return -EINVAL;
 
-	return sprintf(str, "%.*s\n", ACPI_OEM_TABLE_ID_SIZE, h->oem_table_id);
+	return sysfs_emit(str, "%.*s\n", ACPI_OEM_TABLE_ID_SIZE, h->oem_table_id);
 }
 
 static ssize_t acpi_table_oem_revision_show(struct config_item *cfg, char *str)
@@ -153,7 +153,7 @@ static ssize_t acpi_table_oem_revision_show(struct config_item *cfg, char *str)
 	if (!h)
 		return -EINVAL;
 
-	return sprintf(str, "%d\n", h->oem_revision);
+	return sysfs_emit(str, "%d\n", h->oem_revision);
 }
 
 static ssize_t acpi_table_asl_compiler_id_show(struct config_item *cfg,
@@ -164,7 +164,7 @@ static ssize_t acpi_table_asl_compiler_id_show(struct config_item *cfg,
 	if (!h)
 		return -EINVAL;
 
-	return sprintf(str, "%.*s\n", ACPI_NAMESEG_SIZE, h->asl_compiler_id);
+	return sysfs_emit(str, "%.*s\n", ACPI_NAMESEG_SIZE, h->asl_compiler_id);
 }
 
 static ssize_t acpi_table_asl_compiler_revision_show(struct config_item *cfg,
@@ -175,7 +175,7 @@ static ssize_t acpi_table_asl_compiler_revision_show(struct config_item *cfg,
 	if (!h)
 		return -EINVAL;
 
-	return sprintf(str, "%d\n", h->asl_compiler_revision);
+	return sysfs_emit(str, "%d\n", h->asl_compiler_revision);
 }
 
 CONFIGFS_ATTR_RO(acpi_table_, signature);
-- 
2.30.2

