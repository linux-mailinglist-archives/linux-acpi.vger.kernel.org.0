Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E2926A366
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Sep 2020 12:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgIOKo3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Sep 2020 06:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgIOKoH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Sep 2020 06:44:07 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAE8C06178C;
        Tue, 15 Sep 2020 03:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ppSQUOpE02c8Naaz+T4DUk8II1mP6aR5xHXHK1TOwZg=; b=FoIo/T2bPOlpyEqDB81v+CHi3d
        vkcM6PkwqA5k3WYoZ1qPUwpPk3ohTrs+rs3AkEWfvJZSTiJIYbT90GANjfPwx0zUujxd+sd/FJY+l
        CCly9MLsbCsHp8lHTByYGh4Wo+KDFVSjjr8/eBf+GzZ4TghJWeAx5XavyYAfAxD+UERUOEEr5OQpn
        cdQPN7seqyeK/QShtvo5a2cBeYwMTTq5t7A9oh2Qooi9uoJlpJAnxaQr5AnquzHAUdpV5CtkBeX1+
        lBVusKyD280P+zROmq+pqRTXRzyRjbAjKFsAlMDUtS8TuFlgI0C7+3cvR/kC6WSlMdG07OB8fGWmp
        +G6sK31g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kI8R6-0007lG-0q; Tue, 15 Sep 2020 10:43:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B52FD3075F1;
        Tue, 15 Sep 2020 12:43:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 90069214EDD49; Tue, 15 Sep 2020 12:43:40 +0200 (CEST)
Message-ID: <20200915103806.280265587@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 15 Sep 2020 12:31:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     rjw@rjwysocki.net, bp@alien8.de
Cc:     x86@kernel.org, tony.luck@intel.com, lenb@kernel.org,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        ulf.hansson@linaro.org, paulmck@kernel.org, tglx@linutronix.de,
        naresh.kamboju@linaro.org, peterz@infradead.org
Subject: [RFC][PATCH 1/4] acpi: Use CPUIDLE_FLAG_TIMER_STOP
References: <20200915103157.345404192@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Make acpi_processor_idle use the common broadcast code, there's no
reason not to. This also removes some RCU usage after
rcu_idle_enter().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/acpi/processor_idle.c |   49 +++++++++++++-----------------------------
 1 file changed, 16 insertions(+), 33 deletions(-)

--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -161,18 +161,10 @@ static void lapic_timer_propagate_broadc
 }
 
 /* Power(C) State timer broadcast control */
-static void lapic_timer_state_broadcast(struct acpi_processor *pr,
-				       struct acpi_processor_cx *cx,
-				       int broadcast)
-{
-	int state = cx - pr->power.states;
-
-	if (state >= pr->power.timer_broadcast_on_state) {
-		if (broadcast)
-			tick_broadcast_enter();
-		else
-			tick_broadcast_exit();
-	}
+static bool lapic_timer_needs_broadcast(struct acpi_processor *pr,
+					struct acpi_processor_cx *cx)
+{
+	return cx - pr->power.states >= pr->power.timer_broadcast_on_state;
 }
 
 #else
@@ -180,9 +172,9 @@ static void lapic_timer_state_broadcast(
 static void lapic_timer_check_state(int state, struct acpi_processor *pr,
 				   struct acpi_processor_cx *cstate) { }
 static void lapic_timer_propagate_broadcast(struct acpi_processor *pr) { }
-static void lapic_timer_state_broadcast(struct acpi_processor *pr,
-				       struct acpi_processor_cx *cx,
-				       int broadcast)
+
+static bool lapic_timer_needs_broadcast(struct acpi_processor *pr,
+					struct acpi_processor_cx *cx)
 {
 }
 
@@ -568,21 +560,13 @@ static DEFINE_RAW_SPINLOCK(c3_lock);
  * acpi_idle_enter_bm - enters C3 with proper BM handling
  * @pr: Target processor
  * @cx: Target state context
- * @timer_bc: Whether or not to change timer mode to broadcast
  */
 static void acpi_idle_enter_bm(struct acpi_processor *pr,
-			       struct acpi_processor_cx *cx, bool timer_bc)
+			       struct acpi_processor_cx *cx)
 {
 	acpi_unlazy_tlb(smp_processor_id());
 
 	/*
-	 * Must be done before busmaster disable as we might need to
-	 * access HPET !
-	 */
-	if (timer_bc)
-		lapic_timer_state_broadcast(pr, cx, 1);
-
-	/*
 	 * disable bus master
 	 * bm_check implies we need ARB_DIS
 	 * bm_control implies whether we can do ARB_DIS
@@ -609,9 +593,6 @@ static void acpi_idle_enter_bm(struct ac
 		c3_cpu_count--;
 		raw_spin_unlock(&c3_lock);
 	}
-
-	if (timer_bc)
-		lapic_timer_state_broadcast(pr, cx, 0);
 }
 
 static int acpi_idle_enter(struct cpuidle_device *dev,
@@ -630,7 +611,7 @@ static int acpi_idle_enter(struct cpuidl
 			cx = per_cpu(acpi_cstate[index], dev->cpu);
 		} else if (cx->type == ACPI_STATE_C3 && pr->flags.bm_check) {
 			if (cx->bm_sts_skip || !acpi_idle_bm_check()) {
-				acpi_idle_enter_bm(pr, cx, true);
+				acpi_idle_enter_bm(pr, cx);
 				return index;
 			} else if (drv->safe_state_index >= 0) {
 				index = drv->safe_state_index;
@@ -642,15 +623,11 @@ static int acpi_idle_enter(struct cpuidl
 		}
 	}
 
-	lapic_timer_state_broadcast(pr, cx, 1);
-
 	if (cx->type == ACPI_STATE_C3)
 		ACPI_FLUSH_CPU_CACHE();
 
 	acpi_idle_do_entry(cx);
 
-	lapic_timer_state_broadcast(pr, cx, 0);
-
 	return index;
 }
 
@@ -666,7 +643,7 @@ static int acpi_idle_enter_s2idle(struct
 			return 0;
 
 		if (pr->flags.bm_check) {
-			acpi_idle_enter_bm(pr, cx, false);
+			acpi_idle_enter_bm(pr, cx);
 			return 0;
 		} else {
 			ACPI_FLUSH_CPU_CACHE();
@@ -682,6 +659,7 @@ static int acpi_processor_setup_cpuidle_
 {
 	int i, count = ACPI_IDLE_STATE_START;
 	struct acpi_processor_cx *cx;
+	struct cpuidle_state *state;
 
 	if (max_cstate == 0)
 		max_cstate = 1;
@@ -694,6 +672,11 @@ static int acpi_processor_setup_cpuidle_
 
 		per_cpu(acpi_cstate[count], dev->cpu) = cx;
 
+		if (lapic_timer_needs_broadcast(pr, cx)) {
+			state = &acpi_idle_driver.states[count];
+			state->flags |= CPUIDLE_FLAG_TIMER_STOP;
+		}
+
 		count++;
 		if (count == CPUIDLE_STATE_MAX)
 			break;


