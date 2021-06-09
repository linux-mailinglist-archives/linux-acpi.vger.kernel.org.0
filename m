Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6923A110D
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Jun 2021 12:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238832AbhFIK1G (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Jun 2021 06:27:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:47641 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238822AbhFIK1G (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 9 Jun 2021 06:27:06 -0400
IronPort-SDR: zRrbbFV58PTAJEcHoquBtn8PVtEFwHNT+q652+pMzBjI7KW14fyfuqUC6xfGgkath4G20UTxjQ
 8gnTTamPhOAA==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="192154739"
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="192154739"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 03:25:11 -0700
IronPort-SDR: mhy+8fgd+HumPls7i32+BhTYoLGGvVR2x/uQG82C4E1G1dOjK4G6GjP0IxOSRyzZ3oW9kga1Xa
 2scmnjihQPpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="440798060"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 09 Jun 2021 03:25:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 1485F147; Wed,  9 Jun 2021 13:25:33 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Mario Limonciello <mario.limonciello@outlook.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2] ACPI: Pass the same capabilities to the _OSC regardless of the query flag
Date:   Wed,  9 Jun 2021 13:25:33 +0300
Message-Id: <20210609102533.6565-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Commit 719e1f561afb ("ACPI: Execute platform _OSC also with query bit
clear") makes acpi_bus_osc_negotiate_platform_control() not only query
the platforms capabilities but it also commits the result back to the
firmware to report which capabilities are supported by the OS back to
the firmware

On certain systems the BIOS loads SSDT tables dynamically based on the
capabilities the OS claims to support. However, on these systems the
_OSC actually clears some of the bits (under certain conditions) so what
happens is that now when we call the _OSC twice the second time we pass
the cleared values and that results errors like below to appear on the
system log:

  ACPI BIOS Error (bug): Could not resolve symbol [\_PR.PR00._CPC], AE_NOT_FOUND (20210105/psargs-330)
  ACPI Error: Aborting method \_PR.PR01._CPC due to previous error (AE_NOT_FOUND) (20210105/psparse-529)

In addition the ACPI 6.4 spec says following [1]:

  If the OS declares support of a feature in the Support Field in one
  call to _OSC, then it must preserve the set state of that bit
  (declaring support for that feature) in all subsequent calls.

Based on the above we can fix the issue by passing the same set of
capabilities to the platform wide _OSC in both calls regardless of the
query flag.

While there drop the context.ret.length checks which were wrong to begin
with (as the length is number of bytes not elements). This is already
checked in acpi_run_osc() that also returns an error in that case.

Includes fixes by Hans de Goede.

[1] https://uefi.org/specs/ACPI/6.4/06_Device_Configuration/Device_Configuration.html#sequence-of-osc-calls

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=213023
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1963717
Fixes: 719e1f561afb ("ACPI: Execute platform _OSC also with query bit clear")
Cc: Mario Limonciello <mario.limonciello@outlook.com>
cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
Changes from v1:

 - Include fixup suggested by Hans

Was not sure how to attribute that so I just mention it in the commit log
for now. Please let me know if there is more standard way :)

 drivers/acpi/bus.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index be7da23fad76..a4bd673934c0 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -330,32 +330,21 @@ static void acpi_bus_osc_negotiate_platform_control(void)
 	if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
 		return;
 
-	capbuf_ret = context.ret.pointer;
-	if (context.ret.length <= OSC_SUPPORT_DWORD) {
-		kfree(context.ret.pointer);
-		return;
-	}
+	kfree(context.ret.pointer);
 
-	/*
-	 * Now run _OSC again with query flag clear and with the caps
-	 * supported by both the OS and the platform.
-	 */
+	/* Now run _OSC again with query flag clear */
 	capbuf[OSC_QUERY_DWORD] = 0;
-	capbuf[OSC_SUPPORT_DWORD] = capbuf_ret[OSC_SUPPORT_DWORD];
-	kfree(context.ret.pointer);
 
 	if (ACPI_FAILURE(acpi_run_osc(handle, &context)))
 		return;
 
 	capbuf_ret = context.ret.pointer;
-	if (context.ret.length > OSC_SUPPORT_DWORD) {
-		osc_sb_apei_support_acked =
-			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_APEI_SUPPORT;
-		osc_pc_lpi_support_confirmed =
-			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_PCLPI_SUPPORT;
-		osc_sb_native_usb4_support_confirmed =
-			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_NATIVE_USB4_SUPPORT;
-	}
+	osc_sb_apei_support_acked =
+		capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_APEI_SUPPORT;
+	osc_pc_lpi_support_confirmed =
+		capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_PCLPI_SUPPORT;
+	osc_sb_native_usb4_support_confirmed =
+		capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_NATIVE_USB4_SUPPORT;
 
 	kfree(context.ret.pointer);
 }
-- 
2.30.2

