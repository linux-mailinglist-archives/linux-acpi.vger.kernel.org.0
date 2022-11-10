Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C7462437C
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Nov 2022 14:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiKJNpN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Nov 2022 08:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiKJNpM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Nov 2022 08:45:12 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EE633FBA7
        for <linux-acpi@vger.kernel.org>; Thu, 10 Nov 2022 05:45:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16A92D6E;
        Thu, 10 Nov 2022 05:45:17 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 061D53F703;
        Thu, 10 Nov 2022 05:45:09 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v2 2/2] arm64: Add architecture specific ACPI FFH Opregion callbacks
Date:   Thu, 10 Nov 2022 13:45:05 +0000
Message-Id: <20221110134505.1375955-3-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221110134505.1375955-1-sudeep.holla@arm.com>
References: <20221110134505.1375955-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

FFH Operation Region space can be used to trigger SMC or HVC calls,
using the Arm SMC Calling Convention (SMCCC). The choice of conduit
(SMC or HVC) is based on what the kernel choose based on PSCI as with
any other users of SMCCC within the kernel.

Function identifiers only in the SMCCC SiP Service, OEM Service and FF-A
specific call range are allowed in FFH Opregions.

Offset can be either 0(32 bit calling convention) or 1(64 bit calling
convention). The length must be set with the range applicable based
on the value of the offset.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
Hi Will,

Catalin had acked the changes to be routed via PM tree for last or the
one previous merge window. Since we were waiting for ACPICA changes, it
was not merged. Now that ACPICA changes are queued(via PM tree), I will
ask Rafael to take these patches now. Just thought I will let you know
since you are handling upcoming merge window and I do see few ACPI related
changes there. I don't see any conflict with this, so it should be fine.

Please let me know if you are fine with that and ack is an add-on :).

Regards,
Sudeep

 arch/arm64/kernel/acpi.c | 104 +++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/acpi.c | 106 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index a5a256e3f9fe..378453faa87e 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -13,6 +13,7 @@
 #define pr_fmt(fmt) "ACPI: " fmt
 
 #include <linux/acpi.h>
+#include <linux/arm-smccc.h>
 #include <linux/cpumask.h>
 #include <linux/efi.h>
 #include <linux/efi-bgrt.h>
@@ -411,3 +412,108 @@ void arch_reserve_mem_area(acpi_physical_address addr, size_t size)
 {
 	memblock_mark_nomap(addr, size);
 }
+
+#ifdef CONFIG_ACPI_FFH
+/*
+ * Implements ARM64 specific callbacks to support ACPI FFH Operation Region as
+ * specified in https://developer.arm.com/docs/den0048/latest
+ */
+struct acpi_ffh_data {
+	struct acpi_ffh_info info;
+	void (*invoke_ffh_fn)(unsigned long a0, unsigned long a1,
+			      unsigned long a2, unsigned long a3,
+			      unsigned long a4, unsigned long a5,
+			      unsigned long a6, unsigned long a7,
+			      struct arm_smccc_res *args,
+			      struct arm_smccc_quirk *res);
+	void (*invoke_ffh64_fn)(const struct arm_smccc_1_2_regs *args,
+				struct arm_smccc_1_2_regs *res);
+};
+
+int acpi_ffh_address_space_arch_setup(void *handler_ctxt, void **region_ctxt)
+{
+	enum arm_smccc_conduit conduit;
+	struct acpi_ffh_data *ffh_ctxt;
+
+	ffh_ctxt = kzalloc(sizeof(*ffh_ctxt), GFP_KERNEL);
+	if (!ffh_ctxt)
+		return -ENOMEM;
+
+	if (arm_smccc_get_version() < ARM_SMCCC_VERSION_1_2)
+		return -EOPNOTSUPP;
+
+	conduit = arm_smccc_1_1_get_conduit();
+	if (conduit == SMCCC_CONDUIT_NONE) {
+		pr_err("%s: invalid SMCCC conduit\n", __func__);
+		return -EOPNOTSUPP;
+	}
+
+	if (conduit == SMCCC_CONDUIT_SMC) {
+		ffh_ctxt->invoke_ffh_fn = __arm_smccc_smc;
+		ffh_ctxt->invoke_ffh64_fn = arm_smccc_1_2_smc;
+	} else {
+		ffh_ctxt->invoke_ffh_fn = __arm_smccc_hvc;
+		ffh_ctxt->invoke_ffh64_fn = arm_smccc_1_2_hvc;
+	}
+
+	memcpy(ffh_ctxt, handler_ctxt, sizeof(ffh_ctxt->info));
+
+	*region_ctxt = ffh_ctxt;
+	return AE_OK;
+}
+
+static bool acpi_ffh_smccc_owner_allowed(u32 fid)
+{
+	int owner = ARM_SMCCC_OWNER_NUM(fid);
+
+	if (owner == ARM_SMCCC_OWNER_STANDARD ||
+	    owner == ARM_SMCCC_OWNER_SIP || owner == ARM_SMCCC_OWNER_OEM)
+		return true;
+
+	return false;
+}
+
+int acpi_ffh_address_space_arch_handler(acpi_integer *value, void *region_context)
+{
+	int ret = 0;
+	struct acpi_ffh_data *ffh_ctxt = region_context;
+
+	if (ffh_ctxt->info.offset == 0) {
+		/* SMC/HVC 32bit call */
+		struct arm_smccc_res res;
+		u32 a[8] = { 0 }, *ptr = (u32 *)value;
+
+		if (!ARM_SMCCC_IS_FAST_CALL(*ptr) || ARM_SMCCC_IS_64(*ptr) ||
+		    !acpi_ffh_smccc_owner_allowed(*ptr) ||
+		    ffh_ctxt->info.length > 32) {
+			ret = AE_ERROR;
+		} else {
+			int idx, len = ffh_ctxt->info.length >> 2;
+
+			for (idx = 0; idx < len; idx++)
+				a[idx] = *(ptr + idx);
+
+			ffh_ctxt->invoke_ffh_fn(a[0], a[1], a[2], a[3], a[4],
+						a[5], a[6], a[7], &res, NULL);
+			memcpy(value, &res, sizeof(res));
+		}
+
+	} else if (ffh_ctxt->info.offset == 1) {
+		/* SMC/HVC 64bit call */
+		struct arm_smccc_1_2_regs *r = (struct arm_smccc_1_2_regs *)value;
+
+		if (!ARM_SMCCC_IS_FAST_CALL(r->a0) || !ARM_SMCCC_IS_64(r->a0) ||
+		    !acpi_ffh_smccc_owner_allowed(r->a0) ||
+		    ffh_ctxt->info.length > sizeof(*r)) {
+			ret = AE_ERROR;
+		} else {
+			ffh_ctxt->invoke_ffh64_fn(r, r);
+			memcpy(value, r, ffh_ctxt->info.length);
+		}
+	} else {
+		ret = AE_ERROR;
+	}
+
+	return ret;
+}
+#endif /* CONFIG_ACPI_FFH */
-- 
2.38.1

