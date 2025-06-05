Return-Path: <linux-acpi+bounces-14152-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D4BACF29A
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 17:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6B54174A31
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 15:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD1C1CAA82;
	Thu,  5 Jun 2025 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="qSH1k1Bt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83EA1CCB40;
	Thu,  5 Jun 2025 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749136195; cv=none; b=iCZvl0SHR6HGVnK7Cqw1MrH3egO1WVEXwjwtmogLc3Nz600uGlgUcSUelGgY895aE5kOQD9+fA2ev/PVVZRownEmdBPyEvfm1VfcsPQJQ74JXFoOg19LiZJz5xpCRKwZ6GIgwMzmJXUAz5jrUoxh3iRfqk/VSv5r5Ab7ClFKq/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749136195; c=relaxed/simple;
	bh=5w6Yv93zAQ3ErcgdTrPiDO9Q9Wfrs45HpAf7J5N0gZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s9jeeM+0BV2LpBdI7T3+50OT127mbC+6zze6e641ohyQt09xgP6c53FaJS2llUWgClBgl0v274quT9LjIX9npW0GkNlFkjhueF+FoMF9Rgb0lR6EoemuY22m4J4THyO3lEbEe+ezLHFGHmH69yERNna937QXdX9GEZ4Yfi/jBG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=qSH1k1Bt; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 29D2566C036;
	Thu,  5 Jun 2025 17:09:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1749136184;
	bh=5w6Yv93zAQ3ErcgdTrPiDO9Q9Wfrs45HpAf7J5N0gZQ=;
	h=From:Subject:Date;
	b=qSH1k1BtkumQjRlAiVzukEKaymWbwSyIEpgjTJCKwbbWza9OEwLmY60+XkKsJH/yi
	 0eChstEywNEVUS5+ZcCor3NJkdVZxYWwedkT4EnfaDFc9WwPayV/zO1qhCbaU4CW9Z
	 2YwyJRFpzW+v0vHX7daAFV0kVPMH4kBfPzRB833qY3U20izZP7DPnF7v8+qZHyk3rC
	 FM6RwjMcgrStNBR79iBAOTFmLToLPd/QbiXb5UqpH25bF3N86pgbMd4am7m35Uir/s
	 Gl47N9xeatvxdHmtOYVRp3BrMGzadQyqAWCr8aKT0HqTChfLq4NQRz5mVL2JV8vv95
	 UnQEwyMZnDjKg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: x86 Maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Linux ACPI <linux-acpi@vger.kernel.org>
Subject:
 [PATCH v1 5/5] Reapply "x86/smp: Eliminate mwait_play_dead_cpuid_hint()"
Date: Thu, 05 Jun 2025 17:09:35 +0200
Message-ID: <7813065.EvYhyI6sBW@rjwysocki.net>
In-Reply-To: <2226957.irdbgypaU6@rjwysocki.net>
References: <2226957.irdbgypaU6@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 5.63.189.50
X-CLIENT-HOSTNAME: 5.63.189.50
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: dmFkZTEzSEGzZ/ONVrWENr6vcXfS3S2jicISDIUk4t6WJg+Zjj/tMsiKrH6p/W9hVn65rDd2JKDd5uTYEHknKQT2r7pOoqF3rdVD5yhK7Rprhh7g9Zvcj23lpp2rY7UCLtUpLjrE40L5kP2ENOt7F7JFMQrsU0BxCSyD9ImwCg/5uHKqloLfTfX1B6buKhq24d5iBCDj1fuCRg5EDPCCcGoXCAG/xJ8DxnVxdLMqNeA6Murrcf5yV2bVSf0qD3cTb1ZGJEaagT8ZwEZw1hwmHq4GBUTZA/geTkMBRKK8IMyXCx4LjU27eYT2E9Bi7kPkpz1heTPAWpmaTKgTxzYdBmQllqRTl/Yl2mbTQxvwrPd3I7zV7RAKW8lL8zC1Qqzv74Nqlxzwid9Qnd2k+6vzP8M8lTjbI3EUY48Qn0InRxGMdT0mI6F/wpdr91v91Wod4Xt1EmxclbwDJX2Is1vMQRh2U2mZLIDQN0M9sNrj+X3o5zkShMz+j9Z0XGTwte4UyGTpMainqH1zLPnxQEI/Cs8t6faBMja0m/aGPSYG7PZDZ0JZ8/fORk3jqIccuBkwbYmzOXwKB1kP9qI0b1DCJzVBeBsHtWzitHFlQ9cMDPKTooa6zSw9QtOGbQS78UXLSL9r4vruh1z2hDnMKDwCCPHN4KlkDj1wHu+122qK3UBoDbQH+w
X-DCC--Metrics: v370.home.net.pl 1024; Body=12 Fuz1=12 Fuz2=12

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Revert commit 70523f335734 ("Revert "x86/smp: Eliminate
mwait_play_dead_cpuid_hint()"") to reapply the changes from commit
96040f7273e2 ("x86/smp: Eliminate mwait_play_dead_cpuid_hint()")
reverted by it.

Previously, these changes caused idle power to rise on systems booting
with "nosmt" in the kernel command line because they effectively caused
"dead" SMT siblings to remain in idle state C1 after executing the HLT
instruction, which prevented the processor from reaching package idle
states deeper than PC2 going forward.

Now, the "dead" SMT siblings are rescanned after initializing a proper
cpuidle driver for the processor (either intel_idle or ACPI idle), at
which point they are able to enter a sufficiently deep idle state
in native_play_dead() via cpuidle, so the code changes in question can
be reapplied.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/kernel/smpboot.c |   54 +++++-----------------------------------------
 1 file changed, 7 insertions(+), 47 deletions(-)

--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1238,6 +1238,10 @@
 	local_irq_disable();
 }
 
+/*
+ * We need to flush the caches before going to sleep, lest we have
+ * dirty data in our caches when we come back up.
+ */
 void __noreturn mwait_play_dead(unsigned int eax_hint)
 {
 	struct mwait_cpu_dead *md = this_cpu_ptr(&mwait_cpu_dead);
@@ -1284,50 +1288,6 @@
 }
 
 /*
- * We need to flush the caches before going to sleep, lest we have
- * dirty data in our caches when we come back up.
- */
-static inline void mwait_play_dead_cpuid_hint(void)
-{
-	unsigned int eax, ebx, ecx, edx;
-	unsigned int highest_cstate = 0;
-	unsigned int highest_subcstate = 0;
-	int i;
-
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
-	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
-		return;
-	if (!this_cpu_has(X86_FEATURE_MWAIT))
-		return;
-	if (!this_cpu_has(X86_FEATURE_CLFLUSH))
-		return;
-
-	eax = CPUID_LEAF_MWAIT;
-	ecx = 0;
-	native_cpuid(&eax, &ebx, &ecx, &edx);
-
-	/*
-	 * eax will be 0 if EDX enumeration is not valid.
-	 * Initialized below to cstate, sub_cstate value when EDX is valid.
-	 */
-	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED)) {
-		eax = 0;
-	} else {
-		edx >>= MWAIT_SUBSTATE_SIZE;
-		for (i = 0; i < 7 && edx; i++, edx >>= MWAIT_SUBSTATE_SIZE) {
-			if (edx & MWAIT_SUBSTATE_MASK) {
-				highest_cstate = i;
-				highest_subcstate = edx & MWAIT_SUBSTATE_MASK;
-			}
-		}
-		eax = (highest_cstate << MWAIT_SUBSTATE_SIZE) |
-			(highest_subcstate - 1);
-	}
-
-	mwait_play_dead(eax);
-}
-
-/*
  * Kick all "offline" CPUs out of mwait on kexec(). See comment in
  * mwait_play_dead().
  */
@@ -1377,9 +1337,9 @@
 	play_dead_common();
 	tboot_shutdown(TB_SHUTDOWN_WFS);
 
-	mwait_play_dead_cpuid_hint();
-	if (cpuidle_play_dead())
-		hlt_play_dead();
+	/* Below returns only on error. */
+	cpuidle_play_dead();
+	hlt_play_dead();
 }
 
 #else /* ... !CONFIG_HOTPLUG_CPU */




