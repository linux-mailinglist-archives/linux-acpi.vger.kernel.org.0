Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97AA62F6B6
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Nov 2022 15:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241108AbiKROBE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Nov 2022 09:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240540AbiKROBD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Nov 2022 09:01:03 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1CD073BA8
        for <linux-acpi@vger.kernel.org>; Fri, 18 Nov 2022 06:01:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24DD723A;
        Fri, 18 Nov 2022 06:01:09 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 191483F587;
        Fri, 18 Nov 2022 06:01:01 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-acpi@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jose Marinho <jose.marinho@arm.com>
Subject: [PATCH -next] ACPI: bus: Fix the _OSC capability check for FFH OpRegion
Date:   Fri, 18 Nov 2022 14:00:59 +0000
Message-Id: <20221118140059.614302-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

As per the ACPI specification(vide section Platform-Wide OSPM Capabilities)
the OSPM must set this bit to indicate support for the usage of Functional
Fixed Hardware (FFixedHW) Operation Regions rather than the firmware as
expected in the code.

Update the check accordingly to reflect the requirement as stated in the
specification.

Reported-by: Jose Marinho <jose.marinho@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/bus.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

Hi Rafael,

Sorry for this, but looks like I clearly missed to noticed this change
in the process of evolution of FFH OpRegions support. I had platform with
buggy/prototype firmware(must be from the initial code-first proposal)
and failed to catch this earlier. Thanks to Jose for identifying this.

Regards,
Sudeep

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 245fb0828e47..2b9eac7e7777 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -300,8 +300,6 @@ EXPORT_SYMBOL_GPL(osc_sb_native_usb4_support_confirmed);
 
 bool osc_sb_cppc2_support_acked;
 
-bool osc_sb_ffh_opregion_support_confirmed;
-
 static u8 sb_uuid_str[] = "0811B06E-4A27-44F9-8D60-3CBBC22E7B48";
 static void acpi_bus_osc_negotiate_platform_control(void)
 {
@@ -325,6 +323,8 @@ static void acpi_bus_osc_negotiate_platform_control(void)
 	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PCLPI_SUPPORT;
 	if (IS_ENABLED(CONFIG_ACPI_PRMT))
 		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PRM_SUPPORT;
+	if (IS_ENABLED(CONFIG_ACPI_FFH))
+		capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_FFH_OPR_SUPPORT;
 
 #ifdef CONFIG_ARM64
 	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_GENERIC_INITIATOR_SUPPORT;
@@ -385,8 +385,6 @@ static void acpi_bus_osc_negotiate_platform_control(void)
 			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_NATIVE_USB4_SUPPORT;
 		osc_cpc_flexible_adr_space_confirmed =
 			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_CPC_FLEXIBLE_ADR_SPACE;
-		osc_sb_ffh_opregion_support_confirmed =
-			capbuf_ret[OSC_SUPPORT_DWORD] & OSC_SB_FFH_OPR_SUPPORT;
 	}
 
 	kfree(context.ret.pointer);
@@ -1412,8 +1410,7 @@ static int __init acpi_init(void)
 		disable_acpi();
 		return result;
 	}
-	if (osc_sb_ffh_opregion_support_confirmed)
-		acpi_init_ffh();
+	acpi_init_ffh();
 
 	pci_mmcfg_late_init();
 	acpi_iort_init();
-- 
2.38.1

