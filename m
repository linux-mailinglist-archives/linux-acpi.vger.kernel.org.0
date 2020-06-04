Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D2D1EECCD
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jun 2020 23:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgFDVId (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Jun 2020 17:08:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:13291 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725952AbgFDVId (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 4 Jun 2020 17:08:33 -0400
IronPort-SDR: WoIzks2nZT+UaN/O6r1gJuami01LwyismMTzAVVJpF+HOOA831fakSt+Gby1fln4PD78LWJNyT
 d/o6YMd8dAfg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2020 14:08:32 -0700
IronPort-SDR: b2/lZ/CYo9tqpFAe1ugHNC3g2hwQDx7YsPD5N9bpqE5HLM8jtT38yAygsmRAYjLV+EGbhfXZ6c
 PcNnn+MysR2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,472,1583222400"; 
   d="scan'208";a="287510449"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by orsmga002.jf.intel.com with ESMTP; 04 Jun 2020 14:08:32 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 1/3] ACPICA: acpidump: Removed dead code from oslinuxtbl.c
Date:   Thu,  4 Jun 2020 13:44:19 -0700
Message-Id: <20200604204421.592003-2-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200604204421.592003-1-erik.kaneda@intel.com>
References: <20200604204421.592003-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA BZ 1119.

ACPICA commit 4d938d048790983b8b4252b0f4aeec59dabb476c

Link: https://github.com/acpica/acpica/commit/4d938d04
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 .../acpi/os_specific/service_layers/oslinuxtbl.c      | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
index 5aaddc79adf7..dd38c2b2e1b4 100644
--- a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
+++ b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
@@ -35,7 +35,7 @@ static acpi_status osl_add_table_to_list(char *signature, u32 instance);
 static acpi_status
 osl_read_table_from_file(char *filename,
 			 acpi_size file_offset,
-			 char *signature, struct acpi_table_header **table);
+			 struct acpi_table_header **table);
 
 static acpi_status
 osl_map_table(acpi_size address,
@@ -1184,8 +1184,6 @@ osl_table_name_from_file(char *filename, char *signature, u32 *instance)
  *
  * PARAMETERS:  filename            - File that contains the desired table
  *              file_offset         - Offset of the table in file
- *              signature           - Optional ACPI Signature for desired table.
- *                                    A null terminated 4-character string.
  *              table               - Where a pointer to the table is returned
  *
  * RETURN:      Status; Table buffer is returned if AE_OK.
@@ -1197,7 +1195,7 @@ osl_table_name_from_file(char *filename, char *signature, u32 *instance)
 static acpi_status
 osl_read_table_from_file(char *filename,
 			 acpi_size file_offset,
-			 char *signature, struct acpi_table_header **table)
+			 struct acpi_table_header **table)
 {
 	FILE *table_file;
 	struct acpi_table_header header;
@@ -1225,6 +1223,8 @@ osl_read_table_from_file(char *filename,
 		goto exit;
 	}
 
+#ifdef ACPI_OBSOLETE_FUNCTIONS
+
 	/* If signature is specified, it must match the table */
 
 	if (signature) {
@@ -1244,6 +1244,7 @@ osl_read_table_from_file(char *filename,
 			goto exit;
 		}
 	}
+#endif
 
 	table_length = ap_get_table_length(&header);
 	if (table_length == 0) {
@@ -1366,7 +1367,7 @@ osl_get_customized_table(char *pathname,
 	/* There is no physical address saved for customized tables, use zero */
 
 	*address = 0;
-	status = osl_read_table_from_file(table_filename, 0, NULL, table);
+	status = osl_read_table_from_file(table_filename, 0, table);
 
 	return (status);
 }
-- 
2.25.1

