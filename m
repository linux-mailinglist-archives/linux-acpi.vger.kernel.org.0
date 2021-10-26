Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44DFB43ADBB
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Oct 2021 10:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbhJZID3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Oct 2021 04:03:29 -0400
Received: from esa12.hc1455-7.c3s2.iphmx.com ([139.138.37.100]:22909 "EHLO
        esa12.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232068AbhJZIDQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Oct 2021 04:03:16 -0400
X-Greylist: delayed 445 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Oct 2021 04:03:11 EDT
IronPort-SDR: nV8hI6SuojD0UHrDzJJyyOX+sZt1C7HNyO1cX+yiFWoqurhDMtLm+bZBgGqdXJuHW/CH1v+EwR
 H7LviDCpbJNxUIh4WVKEHN5BOv5eKE1C+/1ggTHLwJxE/ftT7L/UKrdNdXJX1h5xyCc437h5vs
 D2Lye/CDmCZlXVFcWUEVBAfdJhzCZNl6TEZKx8xCssM0BcEIBhXSdRh4JgweNyOR/y+eYx7D1e
 TuIu3tpRxOz9RblrBg9qNKZey9FCUzBTTWJJmAeSKelNGSblR0k2IcZXT61b7q0gxLw+GhO9XX
 l5zslQQMBOioqIY3CyO3l8Ch
X-IronPort-AV: E=McAfee;i="6200,9189,10148"; a="29985614"
X-IronPort-AV: E=Sophos;i="5.87,182,1631545200"; 
   d="scan'208";a="29985614"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP; 26 Oct 2021 16:53:15 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 62692F30E3;
        Tue, 26 Oct 2021 16:53:14 +0900 (JST)
Received: from oym-om2.fujitsu.com (oym-om2.o.css.fujitsu.com [10.85.58.162])
        by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 3DD6ABDB66;
        Tue, 26 Oct 2021 16:53:12 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om2.fujitsu.com (Postfix) with ESMTP id 1832840108E53;
        Tue, 26 Oct 2021 16:53:12 +0900 (JST)
From:   Shuuichirou Ishii <ishii.shuuichir@fujitsu.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, robert.moore@intel.com,
        erik.kaneda@intel.com, rafael.j.wysocki@intel.com, devel@acpica.org
Cc:     ishii.shuuichir@fujitsu.com
Subject: [PATCH] ACPI: Add AEST in ACPI Table Definitions
Date:   Tue, 26 Oct 2021 16:52:57 +0900
Message-Id: <20211026075257.3785036-1-ishii.shuuichir@fujitsu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When We added AEST using the Upgrading ACPI tables via initrd function,
the kernel could not recognize the AEST, so We added AEST the ACPI table
definition.

Signed-off-by: Shuuichirou Ishii <ishii.shuuichir@fujitsu.com>
---
 drivers/acpi/tables.c | 2 +-
 include/acpi/actbl2.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index f9383736fa0f..ab0fb4c33e07 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -499,7 +499,7 @@ static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst = {
 	ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
 	ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
 	ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
-	ACPI_SIG_NHLT };
+	ACPI_SIG_NHLT, ACPI_SIG_AEST };
 
 #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
 
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index a47b32a5cbde..b586e40d4b86 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -48,6 +48,7 @@
 #define ACPI_SIG_SDEV           "SDEV"	/* Secure Devices table */
 #define ACPI_SIG_NHLT           "NHLT"	/* Non-HDAudio Link Table */
 #define ACPI_SIG_SVKL           "SVKL"	/* Storage Volume Key Location Table */
+#define ACPI_SIG_AEST           "AEST" /* Arm Error Source Table */
 
 /*
  * All tables must be byte-packed to match the ACPI specification, since
-- 
2.27.0

