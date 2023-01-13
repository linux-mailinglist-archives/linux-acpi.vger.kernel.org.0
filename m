Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0520766A1A7
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jan 2023 19:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbjAMSNy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Jan 2023 13:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjAMSNN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Jan 2023 13:13:13 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74256A702B;
        Fri, 13 Jan 2023 10:05:16 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08C72176C;
        Fri, 13 Jan 2023 10:05:04 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 01F653F67D;
        Fri, 13 Jan 2023 10:04:19 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mhiramat@kernel.org, ndesaulniers@google.com,
        ojeda@kernel.org, peterz@infradead.org, rafael.j.wysocki@intel.com,
        revest@chromium.org, robert.moore@intel.com, rostedt@goodmis.org,
        will@kernel.org
Subject: [PATCH v2 6/8] arm64: patching: Add aarch64_insn_write_literal_u64()
Date:   Fri, 13 Jan 2023 18:03:53 +0000
Message-Id: <20230113180355.2930042-7-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230113180355.2930042-1-mark.rutland@arm.com>
References: <20230113180355.2930042-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In subsequent patches we'll need to atomically write to a
naturally-aligned 64-bit literal embedded within the kernel text.

Add a helper for this. For consistency with other text patching code we
use copy_to_kernel_nofault(), which is atomic for naturally-aligned
accesses up to 64-bits.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Florent Revest <revest@chromium.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/patching.h |  2 ++
 arch/arm64/kernel/patching.c      | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm64/include/asm/patching.h b/arch/arm64/include/asm/patching.h
index 6bf5adc56295..68908b82b168 100644
--- a/arch/arm64/include/asm/patching.h
+++ b/arch/arm64/include/asm/patching.h
@@ -7,6 +7,8 @@
 int aarch64_insn_read(void *addr, u32 *insnp);
 int aarch64_insn_write(void *addr, u32 insn);
 
+int aarch64_insn_write_literal_u64(void *addr, u64 val);
+
 int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
 int aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt);
 
diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
index 33e0fabc0b79..b4835f6d594b 100644
--- a/arch/arm64/kernel/patching.c
+++ b/arch/arm64/kernel/patching.c
@@ -88,6 +88,23 @@ int __kprobes aarch64_insn_write(void *addr, u32 insn)
 	return __aarch64_insn_write(addr, cpu_to_le32(insn));
 }
 
+noinstr int aarch64_insn_write_literal_u64(void *addr, u64 val)
+{
+	u64 *waddr;
+	unsigned long flags;
+	int ret;
+
+	raw_spin_lock_irqsave(&patch_lock, flags);
+	waddr = patch_map(addr, FIX_TEXT_POKE0);
+
+	ret = copy_to_kernel_nofault(waddr, &val, sizeof(val));
+
+	patch_unmap(FIX_TEXT_POKE0);
+	raw_spin_unlock_irqrestore(&patch_lock, flags);
+
+	return ret;
+}
+
 int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
 {
 	u32 *tp = addr;
-- 
2.30.2

