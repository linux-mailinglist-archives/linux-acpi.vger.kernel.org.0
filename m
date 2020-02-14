Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF61415F66E
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2020 20:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388122AbgBNTI3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Feb 2020 14:08:29 -0500
Received: from mga02.intel.com ([134.134.136.20]:26798 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388107AbgBNTI3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Feb 2020 14:08:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 11:08:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,441,1574150400"; 
   d="scan'208";a="227702890"
Received: from sibelius.jf.intel.com ([10.54.75.38])
  by orsmga008.jf.intel.com with ESMTP; 14 Feb 2020 11:08:24 -0800
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 01/10] ACPICA: ASL-ASL+ converter: remove function parameters from cv_init_file_tree ()
Date:   Fri, 14 Feb 2020 10:47:55 -0800
Message-Id: <20200214184804.15114-2-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200214184804.15114-1-erik.kaneda@intel.com>
References: <20200214184804.15114-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit 3ba6fa55a4a32d8b6fc28f9f285506ea0e359296

These parameters can be computed inside of the function from the
Table parameter.

Link: https://github.com/acpica/acpica/commit/3ba6fa55
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acconvert.h | 4 +---
 drivers/acpi/acpica/acmacros.h  | 4 ++--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/acconvert.h b/drivers/acpi/acpica/acconvert.h
index ede4b9cc9e85..9eca93656116 100644
--- a/drivers/acpi/acpica/acconvert.h
+++ b/drivers/acpi/acpica/acconvert.h
@@ -65,9 +65,7 @@ void cg_write_aml_comment(union acpi_parse_object *op);
 /*
  * cvparser
  */
-void
-cv_init_file_tree(struct acpi_table_header *table,
-		  u8 *aml_start, u32 aml_length);
+void cv_init_file_tree(struct acpi_table_header *table);
 
 void cv_clear_op_comments(union acpi_parse_object *op);
 
diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index 2269e10bc21b..87d06c963a60 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -477,7 +477,7 @@
 #define ASL_CV_PRINT_ONE_COMMENT(a,b,c,d) cv_print_one_comment_type (a,b,c,d);
 #define ASL_CV_PRINT_ONE_COMMENT_LIST(a,b) cv_print_one_comment_list (a,b);
 #define ASL_CV_FILE_HAS_SWITCHED(a)       cv_file_has_switched(a)
-#define ASL_CV_INIT_FILETREE(a,b,c)      cv_init_file_tree(a,b,c);
+#define ASL_CV_INIT_FILETREE(a)      cv_init_file_tree(a);
 
 #else
 
@@ -492,7 +492,7 @@
 #define ASL_CV_PRINT_ONE_COMMENT(a,b,c,d)
 #define ASL_CV_PRINT_ONE_COMMENT_LIST(a,b)
 #define ASL_CV_FILE_HAS_SWITCHED(a)       0
-#define ASL_CV_INIT_FILETREE(a,b,c)
+#define ASL_CV_INIT_FILETREE(a)
 
 #endif
 
-- 
2.21.0

