Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8AC30434F
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 17:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391332AbhAZP7e (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Jan 2021 10:59:34 -0500
Received: from mga12.intel.com ([192.55.52.136]:8773 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404398AbhAZP7Q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Jan 2021 10:59:16 -0500
IronPort-SDR: /9B17KPWgeKddBnpiNAA0yfPzYx6IdumXBYYiRHmrXh4gd8rXlSOSA7p5W46AV4jKeoKLp7eWc
 ghSeAq1DY99Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="159097256"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="159097256"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 07:57:27 -0800
IronPort-SDR: BDQjXphgcuUODvQYURSRw8HXhmoiH5TskUs/6ZflevEMn5dB9XXP87TLDiX1V7wbks79oUR+10
 uLll+fB9D5Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="574085209"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 26 Jan 2021 07:57:25 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 46E77288; Tue, 26 Jan 2021 17:57:24 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-usb@vger.kernel.org
Cc:     Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <mario.limonciello@dell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christian Kellner <christian@kellner.me>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 4/6] ACPI: Execute platform _OSC also with query bit clear
Date:   Tue, 26 Jan 2021 18:57:21 +0300
Message-Id: <20210126155723.9388-5-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126155723.9388-1-mika.westerberg@linux.intel.com>
References: <20210126155723.9388-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Mario Limonciello <mario.limonciello@dell.com>

The platform _OSC can change the hardware state when query bit is not
set. According to ACPI spec it is recommended that the OS runs _OSC with
query bit set until the platform does not mask any of the capabilities.
Then it should run it with query bit clear in order to actually commit
the changes. At the moment Linux only runs the _OSC with query bit set
and this is going to cause problems with the USB4 CM (Connection
Manager) switch that is going to commit the switch only when the OS
requests control over the feature.

For this reason modify the _OSC support so that we first execute it with
query bit set, then use the returned valu as base of the features we
want to control and run the _OSC again with query bit clear.

Also rename the function to better match what it does.

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/bus.c | 43 +++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 1682f8b454a2..ca7c7b2bf56e 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -282,9 +282,9 @@ bool osc_pc_lpi_support_confirmed;
 EXPORT_SYMBOL_GPL(osc_pc_lpi_support_confirmed);
 
 static u8 sb_uuid_str[] = "0811B06E-4A27-44F9-8D60-3CBBC22E7B48";
-static void acpi_bus_osc_support(void)
+static void acpi_bus_osc_negotiate_platform_control(void)
 {
-	u32 capbuf[2];
+	u32 capbuf[2], *capbuf_ret;
 	struct acpi_osc_context context = {
 		.uuid_str = sb_uuid_str,
 		.rev = 1,
@@ -321,17 +321,36 @@ static void acpi_bus_osc_support(void)
 		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_APEI_SUPPORT;
 	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
 		return;
-	if (ACPI_SUCCESS(acpi_run_osc(handle, &context))) {
-		u32 *capbuf_ret = context.ret.pointer;
-		if (context.ret.length > OSC_SUPPORT_DWORD) {
-			osc_sb_apei_support_acked =
-				capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_APEI_SUPPORT;
-			osc_pc_lpi_support_confirmed =
-				capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_PCLPI_SUPPORT;
-		}
+
+	if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
+		return;
+
+	capbuf_ret = context.ret.pointer;
+	if (context.ret.length <= OSC_SUPPORT_DWORD) {
 		kfree(context.ret.pointer);
+		return;
 	}
-	/* do we need to check other returned cap? Sounds no */
+
+	/*
+	 * Now run _OSC again with query flag clean and with the caps
+	 * both platform and OS supports.
+	 */
+	capbuf[OSC_QUERY_DWORD] = 0;
+	capbuf[OSC_SUPPORT_DWORD] = capbuf_ret[OSC_SUPPORT_DWORD];
+	kfree(context.ret.pointer);
+
+	if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
+		return;
+
+	capbuf_ret = context.ret.pointer;
+	if (context.ret.length > OSC_SUPPORT_DWORD) {
+		osc_sb_apei_support_acked =
+			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_APEI_SUPPORT;
+		osc_pc_lpi_support_confirmed =
+			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_PCLPI_SUPPORT;
+	}
+
+	kfree(context.ret.pointer);
 }
 
 /* --------------------------------------------------------------------------
@@ -1168,7 +1187,7 @@ static int __init acpi_bus_init(void)
 	 * _OSC method may exist in module level code,
 	 * so it must be run after ACPI_FULL_INITIALIZATION
 	 */
-	acpi_bus_osc_support();
+	acpi_bus_osc_negotiate_platform_control();
 
 	/*
 	 * _PDC control method may load dynamic SSDT tables,
-- 
2.29.2

