Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB1B6E3BDA
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Oct 2019 21:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392924AbfJXTNp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Oct 2019 15:13:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:56947 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390839AbfJXTNp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 24 Oct 2019 15:13:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 12:13:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,225,1569308400"; 
   d="scan'208";a="188686272"
Received: from sibelius.jf.intel.com ([10.54.75.23])
  by orsmga007.jf.intel.com with ESMTP; 24 Oct 2019 12:13:43 -0700
From:   Erik Schmauss <erik.schmauss@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 04/12] ACPICA: Add new external interface, acpi_unload_table
Date:   Thu, 24 Oct 2019 11:55:48 -0700
Message-Id: <20191024185556.4606-5-erik.schmauss@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191024185556.4606-1-erik.schmauss@intel.com>
References: <20191024185556.4606-1-erik.schmauss@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit c69369cd9cf0134e1aac516e97d612947daa8dc2

Unload a table via the table_index.

Link: https://github.com/acpica/acpica/commit/c69369cd
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/tbxfload.c | 32 ++++++++++++++++++++++++++++++++
 include/acpi/acpixf.h          |  3 +++
 2 files changed, 35 insertions(+)

diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index 86f1693f6d29..ce86e7945e90 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -390,3 +390,35 @@ acpi_status acpi_unload_parent_table(acpi_handle object)
 }
 
 ACPI_EXPORT_SYMBOL(acpi_unload_parent_table)
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_unload_table
+ *
+ * PARAMETERS:  table_index         - Index as returned by acpi_load_table
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Via the table_index representing an SSDT or OEMx table, unloads
+ *              the table and deletes all namespace objects associated with
+ *              that table. Unloading of the DSDT is not allowed.
+ *              Note: Mainly intended to support hotplug removal of SSDTs.
+ *
+ ******************************************************************************/
+acpi_status acpi_unload_table(u32 table_index)
+{
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE(acpi_unload_table);
+
+	if (table_index == 1) {
+
+		/* table_index==1 means DSDT is the owner. DSDT cannot be unloaded */
+
+		return_ACPI_STATUS(AE_TYPE);
+	}
+
+	status = acpi_tb_unload_table(table_index);
+	return_ACPI_STATUS(status);
+}
+
+ACPI_EXPORT_SYMBOL(acpi_unload_table)
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index e5e041413581..109b2f14b6c6 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -460,6 +460,9 @@ ACPI_EXTERNAL_RETURN_STATUS(acpi_status ACPI_INIT_FUNCTION
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			    acpi_load_table(struct acpi_table_header *table))
 
+ACPI_EXTERNAL_RETURN_STATUS(acpi_status
+			    acpi_unload_table(u32 table_index))
+
 ACPI_EXTERNAL_RETURN_STATUS(acpi_status
 			    acpi_unload_parent_table(acpi_handle object))
 
-- 
2.21.0

