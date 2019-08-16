Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C68790A94
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Aug 2019 23:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfHPV6h (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Aug 2019 17:58:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:56323 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727753AbfHPV6h (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 16 Aug 2019 17:58:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 14:58:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,394,1559545200"; 
   d="scan'208";a="206381394"
Received: from bartok.jf.intel.com ([10.54.75.137])
  by fmsmga002.fm.intel.com with ESMTP; 16 Aug 2019 14:58:33 -0700
From:   Erik Schmauss <erik.schmauss@intel.com>
To:     rjw@rjwysocki.net, linux-acpi@vger.kernel.org
Cc:     Jung-uk Kim <jkim@free_BSD.org>,
        Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 7/9] ACPICA: Differentiate Windows 8.1 from Windows 8.
Date:   Fri, 16 Aug 2019 14:43:26 -0700
Message-Id: <20190816214328.3900-8-erik.schmauss@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190816214328.3900-1-erik.schmauss@intel.com>
References: <20190816214328.3900-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Jung-uk Kim <jkim@free_BSD.org>

ACPICA commit 66db7b38f61e63f11e48a0ea993d92b12e0a17ca

Link: https://github.com/acpica/acpica/commit/66db7b38
Signed-off-by: Jung-uk Kim <jkim@free_BSD.org>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 drivers/acpi/acpica/utosi.c |  2 +-
 include/acpi/actypes.h      | 13 +++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/utosi.c b/drivers/acpi/acpica/utosi.c
index 688c61a90725..fc09d234fe62 100644
--- a/drivers/acpi/acpica/utosi.c
+++ b/drivers/acpi/acpica/utosi.c
@@ -65,7 +65,7 @@ static struct acpi_interface_info acpi_default_supported_interfaces[] = {
 	{"Windows 2006 SP2", NULL, 0, ACPI_OSI_WIN_VISTA_SP2},	/* Windows Vista SP2 - Added 09/2010 */
 	{"Windows 2009", NULL, 0, ACPI_OSI_WIN_7},	/* Windows 7 and Server 2008 R2 - Added 09/2009 */
 	{"Windows 2012", NULL, 0, ACPI_OSI_WIN_8},	/* Windows 8 and Server 2012 - Added 08/2012 */
-	{"Windows 2013", NULL, 0, ACPI_OSI_WIN_8},	/* Windows 8.1 and Server 2012 R2 - Added 01/2014 */
+	{"Windows 2013", NULL, 0, ACPI_OSI_WIN_8_1},	/* Windows 8.1 and Server 2012 R2 - Added 01/2014 */
 	{"Windows 2015", NULL, 0, ACPI_OSI_WIN_10},	/* Windows 10 - Added 03/2015 */
 	{"Windows 2016", NULL, 0, ACPI_OSI_WIN_10_RS1},	/* Windows 10 version 1607 - Added 12/2017 */
 	{"Windows 2017", NULL, 0, ACPI_OSI_WIN_10_RS2},	/* Windows 10 version 1703 - Added 12/2017 */
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index f52c83eaedc4..10c10b9d18ae 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -1265,12 +1265,13 @@ typedef enum {
 #define ACPI_OSI_WIN_VISTA_SP2          0x0A
 #define ACPI_OSI_WIN_7                  0x0B
 #define ACPI_OSI_WIN_8                  0x0C
-#define ACPI_OSI_WIN_10                 0x0D
-#define ACPI_OSI_WIN_10_RS1             0x0E
-#define ACPI_OSI_WIN_10_RS2             0x0F
-#define ACPI_OSI_WIN_10_RS3             0x10
-#define ACPI_OSI_WIN_10_RS4             0x11
-#define ACPI_OSI_WIN_10_RS5             0x12
+#define ACPI_OSI_WIN_8_1                0x0D
+#define ACPI_OSI_WIN_10                 0x0E
+#define ACPI_OSI_WIN_10_RS1             0x0F
+#define ACPI_OSI_WIN_10_RS2             0x10
+#define ACPI_OSI_WIN_10_RS3             0x11
+#define ACPI_OSI_WIN_10_RS4             0x12
+#define ACPI_OSI_WIN_10_RS5             0x13
 
 /* Definitions of getopt */
 
-- 
2.17.2

