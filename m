Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10FD615F66C
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2020 20:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388080AbgBNTI3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Feb 2020 14:08:29 -0500
Received: from mga02.intel.com ([134.134.136.20]:26795 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387995AbgBNTI3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Feb 2020 14:08:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 11:08:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,441,1574150400"; 
   d="scan'208";a="227702891"
Received: from sibelius.jf.intel.com ([10.54.75.38])
  by orsmga008.jf.intel.com with ESMTP; 14 Feb 2020 11:08:24 -0800
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 02/10] ACPICA: ASL-ASL+ converter: make root file a parameter for cv_init_file_tree
Date:   Fri, 14 Feb 2020 10:47:56 -0800
Message-Id: <20200214184804.15114-3-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200214184804.15114-1-erik.kaneda@intel.com>
References: <20200214184804.15114-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit 5d160cc86cca440eac7055f981e48bc14d4eb9f7

This decouples cv_init_file_tree from acpi_gbl_output_file and allows
it to be called independently of acpi_os_redirect_output()

Link: https://github.com/acpica/acpica/commit/5d160cc8
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acconvert.h | 2 +-
 drivers/acpi/acpica/acmacros.h  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/acconvert.h b/drivers/acpi/acpica/acconvert.h
index 9eca93656116..cf85d66da6e7 100644
--- a/drivers/acpi/acpica/acconvert.h
+++ b/drivers/acpi/acpica/acconvert.h
@@ -65,7 +65,7 @@ void cg_write_aml_comment(union acpi_parse_object *op);
 /*
  * cvparser
  */
-void cv_init_file_tree(struct acpi_table_header *table);
+void cv_init_file_tree(struct acpi_table_header *table, FILE * root_file);
 
 void cv_clear_op_comments(union acpi_parse_object *op);
 
diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index 87d06c963a60..168904ba3086 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -477,7 +477,7 @@
 #define ASL_CV_PRINT_ONE_COMMENT(a,b,c,d) cv_print_one_comment_type (a,b,c,d);
 #define ASL_CV_PRINT_ONE_COMMENT_LIST(a,b) cv_print_one_comment_list (a,b);
 #define ASL_CV_FILE_HAS_SWITCHED(a)       cv_file_has_switched(a)
-#define ASL_CV_INIT_FILETREE(a)      cv_init_file_tree(a);
+#define ASL_CV_INIT_FILETREE(a,b)      cv_init_file_tree(a,b);
 
 #else
 
@@ -492,7 +492,7 @@
 #define ASL_CV_PRINT_ONE_COMMENT(a,b,c,d)
 #define ASL_CV_PRINT_ONE_COMMENT_LIST(a,b)
 #define ASL_CV_FILE_HAS_SWITCHED(a)       0
-#define ASL_CV_INIT_FILETREE(a)
+#define ASL_CV_INIT_FILETREE(a,b)
 
 #endif
 
-- 
2.21.0

