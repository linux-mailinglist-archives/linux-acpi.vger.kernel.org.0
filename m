Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D2726A371
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Sep 2020 12:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgIOKpq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Sep 2020 06:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgIOKn5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Sep 2020 06:43:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56E0C06178A;
        Tue, 15 Sep 2020 03:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ww+8+f29UThP3VzHThfXkwodAndD/WG4c0ho1R/aaxE=; b=PIzaub4oY69we/Pk0FNrQiLcQ5
        HUJ4xb9pQVaharBMU9Xqnu88a3EoI1ghgwgdAW9ybzpL4TUszGcxFw9jMnJh2B/1nCuobc9BwFV90
        rQ7T6dZNimgR687YH7M88a5C2DEn/x10eVRjVYla81bM+rmNtvksvAAC3QT8tLuM7qj8V0r7fX3rk
        VT/0IUvqzF22iWsSCrm5Cq2CO1BE9DvfeE6j6gArN2Bq9ZzWIrGRhBcklKbx581Q+gAmbrfyJ5br4
        mUMkp4O8HusizMKoH6UGUA0sHt3xqsw3FLNM6OW/6rfYilFj3ofiwlG2w/YgjAW4Rb31EUTFL87zk
        fWkhrYWg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kI8R5-0006v7-7n; Tue, 15 Sep 2020 10:43:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AE4E43059C6;
        Tue, 15 Sep 2020 12:43:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9B736214EDD4E; Tue, 15 Sep 2020 12:43:40 +0200 (CEST)
Message-ID: <20200915103806.479637218@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 15 Sep 2020 12:32:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     rjw@rjwysocki.net, bp@alien8.de
Cc:     x86@kernel.org, tony.luck@intel.com, lenb@kernel.org,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        ulf.hansson@linaro.org, paulmck@kernel.org, tglx@linutronix.de,
        naresh.kamboju@linaro.org, peterz@infradead.org
Subject: [RFC][PATCH 4/4] acpi: Take over RCU-idle for C3-BM idle
References: <20200915103157.345404192@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The C3 BusMaster idle code takes lock in a number of places, some deep
inside the ACPI code. Instead of wrapping it all in RCU_NONIDLE, have
the driver take over RCU-idle duty and avoid flipping RCU state back
and forth a lot.

( by marking 'C3 && bm_check' as RCU_IDLE, we _must_ call enter_bm() for
  that combination, otherwise we'll loose RCU-idle, this requires
  shuffling some code around )

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/acpi/processor_idle.c |   69 +++++++++++++++++++++++++++++-------------
 1 file changed, 49 insertions(+), 20 deletions(-)

--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -558,22 +558,43 @@ static DEFINE_RAW_SPINLOCK(c3_lock);
 
 /**
  * acpi_idle_enter_bm - enters C3 with proper BM handling
+ * @drv: cpuidle driver
  * @pr: Target processor
  * @cx: Target state context
+ * @index: index of target state
  */
-static void acpi_idle_enter_bm(struct acpi_processor *pr,
-			       struct acpi_processor_cx *cx)
+static int acpi_idle_enter_bm(struct cpuidle_driver *drv,
+			       struct acpi_processor *pr,
+			       struct acpi_processor_cx *cx,
+			       int index)
 {
+	static struct acpi_processor_cx safe_cx = {
+		.entry_method = ACPI_CSTATE_HALT,
+	};
+
 	/*
 	 * disable bus master
 	 * bm_check implies we need ARB_DIS
 	 * bm_control implies whether we can do ARB_DIS
 	 *
-	 * That leaves a case where bm_check is set and bm_control is
-	 * not set. In that case we cannot do much, we enter C3
-	 * without doing anything.
+	 * That leaves a case where bm_check is set and bm_control is not set.
+	 * In that case we cannot do much, we enter C3 without doing anything.
 	 */
-	if (pr->flags.bm_control) {
+	bool dis_bm = pr->flags.bm_control;
+
+	/* If we can skip BM, demote to a safe state. */
+	if (!cx->bm_sts_skip && acpi_idle_bm_check()) {
+		dis_bm = false;
+		index = drv->safe_state_index;
+		if (index >= 0) {
+			cx = this_cpu_read(acpi_cstate[index]);
+		} else {
+			cx = &safe_cx;
+			index = -EBUSY;
+		}
+	}
+
+	if (dis_bm) {
 		raw_spin_lock(&c3_lock);
 		c3_cpu_count++;
 		/* Disable bus master arbitration when all CPUs are in C3 */
@@ -582,15 +603,21 @@ static void acpi_idle_enter_bm(struct ac
 		raw_spin_unlock(&c3_lock);
 	}
 
+	rcu_idle_enter();
+
 	acpi_idle_do_entry(cx);
 
+	rcu_idle_exit();
+
 	/* Re-enable bus master arbitration */
-	if (pr->flags.bm_control) {
+	if (dis_bm) {
 		raw_spin_lock(&c3_lock);
 		acpi_write_bit_register(ACPI_BITREG_ARB_DISABLE, 0);
 		c3_cpu_count--;
 		raw_spin_unlock(&c3_lock);
 	}
+
+	return index;
 }
 
 static int acpi_idle_enter(struct cpuidle_device *dev,
@@ -604,20 +631,13 @@ static int acpi_idle_enter(struct cpuidl
 		return -EINVAL;
 
 	if (cx->type != ACPI_STATE_C1) {
+		if (cx->type == ACPI_STATE_C3 && pr->flags.bm_check)
+			return acpi_idle_enter_bm(drv, pr, cx, index);
+
+		/* C2 to C1 demotion. */
 		if (acpi_idle_fallback_to_c1(pr) && num_online_cpus() > 1) {
 			index = ACPI_IDLE_STATE_START;
 			cx = per_cpu(acpi_cstate[index], dev->cpu);
-		} else if (cx->type == ACPI_STATE_C3 && pr->flags.bm_check) {
-			if (cx->bm_sts_skip || !acpi_idle_bm_check()) {
-				acpi_idle_enter_bm(pr, cx);
-				return index;
-			} else if (drv->safe_state_index >= 0) {
-				index = drv->safe_state_index;
-				cx = per_cpu(acpi_cstate[index], dev->cpu);
-			} else {
-				acpi_safe_halt();
-				return -EBUSY;
-			}
 		}
 	}
 
@@ -641,7 +661,13 @@ static int acpi_idle_enter_s2idle(struct
 			return 0;
 
 		if (pr->flags.bm_check) {
-			acpi_idle_enter_bm(pr, cx);
+			u8 bm_sts_skip = cx->bm_sts_skip;
+
+			/* Don't check BM_STS, do an unconditional ARB_DIS for S2IDLE */
+			cx->bm_sts_skip = 1;
+			acpi_idle_enter_bm(drv, pr, cx, index);
+			cx->bm_sts_skip = bm_sts_skip;
+
 			return 0;
 		} else {
 			ACPI_FLUSH_CPU_CACHE();
@@ -674,8 +700,11 @@ static int acpi_processor_setup_cpuidle_
 		if (lapic_timer_needs_broadcast(pr, cx))
 			state->flags |= CPUIDLE_FLAG_TIMER_STOP;
 
-		if (cx->type == ACPI_STATE_C3)
+		if (cx->type == ACPI_STATE_C3) {
 			state->flags |= CPUIDLE_FLAG_TLB_FLUSHED;
+			if (pr->flags.bm_check)
+				state->flags |= CPUIDLE_FLAG_RCU_IDLE;
+		}
 
 		count++;
 		if (count == CPUIDLE_STATE_MAX)


