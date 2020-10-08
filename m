Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B80286D1D
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Oct 2020 05:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgJHDWC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Oct 2020 23:22:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:29857 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727449AbgJHDWA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Oct 2020 23:22:00 -0400
IronPort-SDR: 0a7TT12NTsb8mmkH4MyXqgjbuintjRmN8gDfpX7BSz5whbcBywVDV/rtVZKdnxLVbgVcqXPrKI
 gsWmgoJ0MFyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="162613638"
X-IronPort-AV: E=Sophos;i="5.77,349,1596524400"; 
   d="scan'208";a="162613638"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 20:22:00 -0700
IronPort-SDR: /BnFkEI4EHlolZ67fD72LjtSkCZ6K/+uQfVuPE6wa1c3t43JKhnA/S9Lz1kYgEAf/GKkzURGJ5
 7iVwsATbFRdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,349,1596524400"; 
   d="scan'208";a="355229335"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by orsmga007.jf.intel.com with ESMTP; 07 Oct 2020 20:22:00 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Colin Ian King <colin.king@canonical.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 3/9] ACPICA: Tree-wide: fix various typos and spelling mistakes
Date:   Wed,  7 Oct 2020 19:53:57 -0700
Message-Id: <20201008025403.2401736-4-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201008025403.2401736-1-erik.kaneda@intel.com>
References: <20201008025403.2401736-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

ACPICA commit 6648a6ac8410813bcfedb5c8345259dd155ea851

Fix spelling issues found using the codespell checker

Link: https://github.com/acpica/acpica/commit/6648a6ac
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 drivers/acpi/acpica/dbinput.c                            | 2 +-
 drivers/acpi/acpica/nsxfobj.c                            | 3 ++-
 include/acpi/acconfig.h                                  | 2 +-
 tools/power/acpi/os_specific/service_layers/oslinuxtbl.c | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/dbinput.c b/drivers/acpi/acpica/dbinput.c
index ee6a1b77af3f..568d1b0b1f5d 100644
--- a/drivers/acpi/acpica/dbinput.c
+++ b/drivers/acpi/acpica/dbinput.c
@@ -436,7 +436,7 @@ static void acpi_db_display_help(char *command)
 		acpi_os_printf("\n");
 
 	} else {
-		/* Display help for all commands that match the subtring */
+		/* Display help for all commands that match the substring */
 
 		acpi_db_display_command_info(command, TRUE);
 	}
diff --git a/drivers/acpi/acpica/nsxfobj.c b/drivers/acpi/acpica/nsxfobj.c
index c022bef263e5..324269481160 100644
--- a/drivers/acpi/acpica/nsxfobj.c
+++ b/drivers/acpi/acpica/nsxfobj.c
@@ -24,7 +24,8 @@ ACPI_MODULE_NAME("nsxfobj")
  *
  * RETURN:      Status
  *
- * DESCRIPTION: This routine returns the type associatd with a particular handle
+ * DESCRIPTION: This routine returns the type associated with a particular
+ *              handle
  *
  ******************************************************************************/
 acpi_status acpi_get_type(acpi_handle handle, acpi_object_type *ret_type)
diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
index 5940a3c68a96..a225eff499c8 100644
--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -121,7 +121,7 @@
  *
  *****************************************************************************/
 
-/* Method info (in WALK_STATE), containing local variables and argumetns */
+/* Method info (in WALK_STATE), containing local variables and arguments */
 
 #define ACPI_METHOD_NUM_LOCALS          8
 #define ACPI_METHOD_MAX_LOCAL           7
diff --git a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
index dd38c2b2e1b4..11c5046dce16 100644
--- a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
+++ b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
@@ -110,7 +110,7 @@ u32 gbl_table_count = 0;
  *
  * RETURN:      Status; Converted from errno.
  *
- * DESCRIPTION: Get last errno and conver it to acpi_status.
+ * DESCRIPTION: Get last errno and convert it to acpi_status.
  *
  *****************************************************************************/
 
-- 
2.25.1

