Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E5F61E9A1
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Nov 2022 04:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiKGDaZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 6 Nov 2022 22:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiKGDaY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Nov 2022 22:30:24 -0500
X-Greylist: delayed 1186 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Nov 2022 19:30:21 PST
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA5CDFC8
        for <linux-acpi@vger.kernel.org>; Sun,  6 Nov 2022 19:30:21 -0800 (PST)
X-ASG-Debug-ID: 1667790601-086e23532769b20001-I98ny2
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx1.zhaoxin.com with ESMTP id E2xKyaNV8BoQDAPn (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 07 Nov 2022 11:10:01 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Mon, 7 Nov
 2022 11:10:00 +0800
Received: from tony-HX002EA0.zhaoxin.com (10.32.64.2) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Mon, 7 Nov
 2022 11:09:57 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
To:     <rafael@kernel.org>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <CobeChen@zhaoxin.com>,
        <TimGuo@zhaoxin.com>, <LindaChai@zhaoxin.com>, <LeoLiu@zhaoxin.com>
Subject: [PATCH] x86/acpi/cstate: Optimize ARB_DISABLE on Centaur CPUs
Date:   Mon, 7 Nov 2022 11:09:56 +0800
X-ASG-Orig-Subj: [PATCH] x86/acpi/cstate: Optimize ARB_DISABLE on Centaur CPUs
Message-ID: <1667790596-4223-1-git-send-email-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.32.64.2]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1667790601
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1973
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.101960
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On all recent Centaur platforms, ARB_DISABLE is handled by PMU
automatically while entering C3 type state. No need for OS to
issue the ARB_DISABLE, so set bm_control to zero to indicate that.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/kernel/acpi/cstate.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index 7945eae..da71679 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -52,17 +52,25 @@ void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
 	if (c->x86_vendor == X86_VENDOR_INTEL &&
 	    (c->x86 > 0xf || (c->x86 == 6 && c->x86_model >= 0x0f)))
 			flags->bm_control = 0;
-	/*
-	 * For all recent Centaur CPUs, the ucode will make sure that each
-	 * core can keep cache coherence with each other while entering C3
-	 * type state. So, set bm_check to 1 to indicate that the kernel
-	 * doesn't need to execute a cache flush operation (WBINVD) when
-	 * entering C3 type state.
-	 */
+
 	if (c->x86_vendor == X86_VENDOR_CENTAUR) {
 		if (c->x86 > 6 || (c->x86 == 6 && c->x86_model == 0x0f &&
-		    c->x86_stepping >= 0x0e))
-			flags->bm_check = 1;
+		    c->x86_stepping >= 0x0e)) {
+			/*
+			 * For all recent Centaur CPUs, the ucode will make sure that each
+			 * core can keep cache coherence with each other while entering C3
+			 * type state. So, set bm_check to 1 to indicate that the kernel
+			 * doesn't need to execute a cache flush operation (WBINVD) when
+			 * entering C3 type state.
+			 */
+			flags->bm_check = 1;
+			/*
+			 * For all recent Zhaoxin platforms, ARB_DISABLE is a nop.
+			 * Set bm_control to zero to indicate that ARB_DISABLE is
+			 * not required while entering C3 type state.
+			 */
+			flags->bm_control = 0;
+		}
 	}
 
 	if (c->x86_vendor == X86_VENDOR_ZHAOXIN) {
-- 
2.7.4

