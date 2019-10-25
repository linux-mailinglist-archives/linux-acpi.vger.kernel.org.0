Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB41E5632
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2019 23:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfJYVyx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Oct 2019 17:54:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:27339 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbfJYVyx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 25 Oct 2019 17:54:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 14:54:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,230,1569308400"; 
   d="scan'208";a="201936045"
Received: from sibelius.jf.intel.com ([10.54.75.23])
  by orsmga003.jf.intel.com with ESMTP; 25 Oct 2019 14:54:51 -0700
From:   Erik Schmauss <erik.schmauss@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com,
        Erik Schmauss <erik.schmauss@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH v2 06/12] ACPICA: utilities: add flag to only display data when dumping buffers
Date:   Fri, 25 Oct 2019 14:36:54 -0700
Message-Id: <20191025213700.14685-7-erik.schmauss@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025213700.14685-1-erik.schmauss@intel.com>
References: <20191025213700.14685-1-erik.schmauss@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit fb18935fcf940c5854a055975c6b9ee31f0e1a5a

Link: https://github.com/acpica/acpica/commit/fb18935f
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acutils.h  |  9 +++---
 drivers/acpi/acpica/utbuffer.c | 52 +++++++++++++++++++---------------
 2 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 601808be86d1..5fb50634e08e 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -142,10 +142,11 @@ struct acpi_pkg_info {
 
 /* acpi_ut_dump_buffer */
 
-#define DB_BYTE_DISPLAY     1
-#define DB_WORD_DISPLAY     2
-#define DB_DWORD_DISPLAY    4
-#define DB_QWORD_DISPLAY    8
+#define DB_BYTE_DISPLAY      0x01
+#define DB_WORD_DISPLAY      0x02
+#define DB_DWORD_DISPLAY     0x04
+#define DB_QWORD_DISPLAY     0x08
+#define DB_DISPLAY_DATA_ONLY 0x10
 
 /*
  * utascii - ASCII utilities
diff --git a/drivers/acpi/acpica/utbuffer.c b/drivers/acpi/acpica/utbuffer.c
index 61db9967ebe4..db897af1de05 100644
--- a/drivers/acpi/acpica/utbuffer.c
+++ b/drivers/acpi/acpica/utbuffer.c
@@ -37,7 +37,9 @@ void acpi_ut_dump_buffer(u8 *buffer, u32 count, u32 display, u32 base_offset)
 	u32 j;
 	u32 temp32;
 	u8 buf_char;
+	u32 display_data_only = display & DB_DISPLAY_DATA_ONLY;
 
+	display &= ~DB_DISPLAY_DATA_ONLY;
 	if (!buffer) {
 		acpi_os_printf("Null Buffer Pointer in DumpBuffer!\n");
 		return;
@@ -53,7 +55,9 @@ void acpi_ut_dump_buffer(u8 *buffer, u32 count, u32 display, u32 base_offset)
 
 		/* Print current offset */
 
-		acpi_os_printf("%8.4X: ", (base_offset + i));
+		if (!display_data_only) {
+			acpi_os_printf("%8.4X: ", (base_offset + i));
+		}
 
 		/* Print 16 hex chars */
 
@@ -109,32 +113,34 @@ void acpi_ut_dump_buffer(u8 *buffer, u32 count, u32 display, u32 base_offset)
 		 * Print the ASCII equivalent characters but watch out for the bad
 		 * unprintable ones (printable chars are 0x20 through 0x7E)
 		 */
-		acpi_os_printf(" ");
-		for (j = 0; j < 16; j++) {
-			if (i + j >= count) {
-				acpi_os_printf("\n");
-				return;
+		if (!display_data_only) {
+			acpi_os_printf(" ");
+			for (j = 0; j < 16; j++) {
+				if (i + j >= count) {
+					acpi_os_printf("\n");
+					return;
+				}
+
+				/*
+				 * Add comment characters so rest of line is ignored when
+				 * compiled
+				 */
+				if (j == 0) {
+					acpi_os_printf("// ");
+				}
+
+				buf_char = buffer[(acpi_size)i + j];
+				if (isprint(buf_char)) {
+					acpi_os_printf("%c", buf_char);
+				} else {
+					acpi_os_printf(".");
+				}
 			}
 
-			/*
-			 * Add comment characters so rest of line is ignored when
-			 * compiled
-			 */
-			if (j == 0) {
-				acpi_os_printf("// ");
-			}
+			/* Done with that line. */
 
-			buf_char = buffer[(acpi_size)i + j];
-			if (isprint(buf_char)) {
-				acpi_os_printf("%c", buf_char);
-			} else {
-				acpi_os_printf(".");
-			}
+			acpi_os_printf("\n");
 		}
-
-		/* Done with that line. */
-
-		acpi_os_printf("\n");
 		i += 16;
 	}
 
-- 
2.21.0

