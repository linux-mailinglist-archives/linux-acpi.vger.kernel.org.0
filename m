Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0478F26A374
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Sep 2020 12:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgIOKqB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Sep 2020 06:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgIOKn5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Sep 2020 06:43:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC2AC061788;
        Tue, 15 Sep 2020 03:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=mRb05QRhEgX5DGrRuAZaR2rGnerDrceJein4gsxe/Oc=; b=bpANDfAqLOkvapnR4e8RYeRGLJ
        K14vHjTl8QL0w6Xcm3ZFmf4Tdafh1Wc9Mo7zsHtdzLbO1fGYwsSNmy0XpgBbx3PDD5SDdv4EoyC6U
        Q9mMIZIfHIBTTGsB0KdkWx1DN7TUa5VRolyCJI5xWwZ5QFSLcS0S9yRyS7gk3uohejGjJvukkNWWt
        QyXSNJWvKj+WIyQ3jWKEIG3rgQy477DzRYEAMLw9TSJCCiYxWWGEcG1A4Z02Pzz4CUtDYz/qUyqry
        NAovZHIMbwOcby9iY3WKAVOGWKNtWAViAZBrjT6qXOfMTcpvBWkz6H3BPsrkNWRRm46m2shVRGfgg
        NJti/h/w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kI8R3-0006uk-Jk; Tue, 15 Sep 2020 10:43:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B452E30705A;
        Tue, 15 Sep 2020 12:43:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9249A214EDD4D; Tue, 15 Sep 2020 12:43:40 +0200 (CEST)
Message-ID: <20200915103806.348668768@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 15 Sep 2020 12:31:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     rjw@rjwysocki.net, bp@alien8.de
Cc:     x86@kernel.org, tony.luck@intel.com, lenb@kernel.org,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        ulf.hansson@linaro.org, paulmck@kernel.org, tglx@linutronix.de,
        naresh.kamboju@linaro.org, peterz@infradead.org
Subject: [RFC][PATCH 2/4] acpi: Use CPUIDLE_FLAG_TLB_FLUSHED
References: <20200915103157.345404192@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Make acpi_processor_idle() use the generic TLB flushing code.
This again removes RCU usage after rcu_idle_enter().

(XXX make every C3 invalidate TLBs, not just C3-BM)

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/ia64/include/asm/acpi.h  |    2 --
 arch/x86/include/asm/acpi.h   |    2 --
 drivers/acpi/processor_idle.c |   10 +++++-----
 3 files changed, 5 insertions(+), 9 deletions(-)

--- a/arch/ia64/include/asm/acpi.h
+++ b/arch/ia64/include/asm/acpi.h
@@ -74,8 +74,6 @@ static inline void arch_acpi_set_pdc_bit
 	buf[2] |= ACPI_PDC_EST_CAPABILITY_SMP;
 }
 
-#define acpi_unlazy_tlb(x)
-
 #ifdef CONFIG_ACPI_NUMA
 extern cpumask_t early_cpu_possible_map;
 #define for_each_possible_early_cpu(cpu)  \
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -159,8 +159,6 @@ static inline u64 x86_default_get_root_p
 extern int x86_acpi_numa_init(void);
 #endif /* CONFIG_ACPI_NUMA */
 
-#define acpi_unlazy_tlb(x)	leave_mm(x)
-
 #ifdef CONFIG_ACPI_APEI
 static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
 {
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -565,8 +565,6 @@ static DEFINE_RAW_SPINLOCK(c3_lock);
 static void acpi_idle_enter_bm(struct acpi_processor *pr,
 			       struct acpi_processor_cx *cx)
 {
-	acpi_unlazy_tlb(smp_processor_id());
-
 	/*
 	 * disable bus master
 	 * bm_check implies we need ARB_DIS
@@ -666,6 +664,7 @@ static int acpi_processor_setup_cpuidle_
 		max_cstate = 1;
 
 	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER && i <= max_cstate; i++) {
+		state = &acpi_idle_driver.states[count];
 		cx = &pr->power.states[i];
 
 		if (!cx->valid)
@@ -673,10 +672,11 @@ static int acpi_processor_setup_cpuidle_
 
 		per_cpu(acpi_cstate[count], dev->cpu) = cx;
 
-		if (lapic_timer_needs_broadcast(pr, cx)) {
-			state = &acpi_idle_driver.states[count];
+		if (lapic_timer_needs_broadcast(pr, cx))
 			state->flags |= CPUIDLE_FLAG_TIMER_STOP;
-		}
+
+		if (cx->type == ACPI_STATE_C3)
+			state->flags |= CPUIDLE_FLAG_TLB_FLUSHED;
 
 		count++;
 		if (count == CPUIDLE_STATE_MAX)


