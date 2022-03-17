Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F4E4DC86F
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Mar 2022 15:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbiCQOOD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Mar 2022 10:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbiCQOOD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Mar 2022 10:14:03 -0400
X-Greylist: delayed 543 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Mar 2022 07:12:46 PDT
Received: from srv1.home.kabele.me (unknown [IPv6:2a02:768:2704:8c1a:3eec:efff:fe00:2ce4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1C421FE563
        for <linux-acpi@vger.kernel.org>; Thu, 17 Mar 2022 07:12:46 -0700 (PDT)
Received: from srv1.home.kabele.me (localhost [IPv6:::1])
        by srv1.home.kabele.me (Postfix) with ESMTP id 490C9168FA3;
        Thu, 17 Mar 2022 15:03:59 +0100 (CET)
Received: from localhost ([2a01:c22:8dfa:1400:beea:2810:7764:7afc])
        by srv1.home.kabele.me with ESMTPSA
        id gtgvD88/M2Iz8zMAnmUwTQ
        (envelope-from <vit@kabele.me>); Thu, 17 Mar 2022 15:03:59 +0100
Date:   Thu, 17 Mar 2022 15:03:54 +0100
From:   Vit Kabele <vit@kabele.me>
To:     platform-driver-x86@kernel.org
Cc:     vit@kabele.me, r.marek@assembler.cz, devel@acpica.org,
        mingo@redhat.com, robert.moore@intel.com, linux-kernel@kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH 1/3] platform/x86: Check validity of EBDA pointer in mpparse.c
Message-ID: <YjM/yphbAQHxJIxg@czspare1-lap.sysgo.cz>
Mail-Followup-To: platform-driver-x86@kernel.org, r.marek@assembler.cz,
        devel@acpica.org, mingo@redhat.com, robert.moore@intel.com,
        linux-kernel@kernel.org, linux-acpi@vger.kernel.org
References: <cover.1647525033.git.vit@kabele.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1647525033.git.vit@kabele.me>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The pointer to EBDA area is retrieved from a word at 0x40e in BDA.
In case that the memory there is not initialized and contains garbage,
it might happen that the kernel touches memory above 640K.

This may cause unwanted reads from VGA memory which may not be decoded,
or even present when running under virtualization.

This patch adds sanity check for the EBDA pointer retrieved from the memory
so that scanning EBDA does not leave the low memory.

Signed-off-by: Vit Kabele <vit@kabele.me>
Reviewed-by: Rudolf Marek <r.marek@assembler.cz>
---
 arch/x86/include/asm/bios_ebda.h |  3 +++
 arch/x86/kernel/ebda.c           |  3 ---
 arch/x86/kernel/mpparse.c        | 12 +++++++++++-
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/bios_ebda.h b/arch/x86/include/asm/bios_ebda.h
index 4d5a17e2febe..c3133c01d5b7 100644
--- a/arch/x86/include/asm/bios_ebda.h
+++ b/arch/x86/include/asm/bios_ebda.h
@@ -4,6 +4,9 @@
 
 #include <asm/io.h>
 
+#define BIOS_START_MIN		0x20000U	/* 128K, less than this is insane */
+#define BIOS_START_MAX		0x9f000U	/* 640K, absolute maximum */
+
 /*
  * Returns physical address of EBDA.  Returns 0 if there is no EBDA.
  */
diff --git a/arch/x86/kernel/ebda.c b/arch/x86/kernel/ebda.c
index 38e7d597b660..86c0801fc3ce 100644
--- a/arch/x86/kernel/ebda.c
+++ b/arch/x86/kernel/ebda.c
@@ -50,9 +50,6 @@
 
 #define BIOS_RAM_SIZE_KB_PTR	0x413
 
-#define BIOS_START_MIN		0x20000U	/* 128K, less than this is insane */
-#define BIOS_START_MAX		0x9f000U	/* 640K, absolute maximum */
-
 void __init reserve_bios_regions(void)
 {
 	unsigned int bios_start, ebda_start;
diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index fed721f90116..6bba0744d32d 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -633,7 +633,17 @@ void __init default_find_smp_config(void)
 	 */
 
 	address = get_bios_ebda();
-	if (address)
+
+	/* Check that the EBDA address is sane and the get_bios_ebda() did not
+	 * return just garbage from memory.
+	 * The upper bound is considered valid if it points below 1K before
+	 * end of the lower memory (i.e. 639K). The EBDA can be smaller
+	 * than 1K in which case the pointer will point above 639K but that
+	 * case is handled in step 2) above, and we don't need to adjust scan
+	 * size to not bump into the memory above 640K.
+	 */
+	if (address >= BIOS_START_MIN &&
+	    address < 639 * 0x400)
 		smp_scan_config(address, 0x400);
 }
 
-- 
2.30.2

