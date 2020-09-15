Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2046B26A363
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Sep 2020 12:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgIOKo0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Sep 2020 06:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgIOKoG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Sep 2020 06:44:06 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA91C06178B;
        Tue, 15 Sep 2020 03:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=k8OJ3LBTy7ZYlXue2CjZpOH2bHs7RL6MvRpNpTjIcbE=; b=wZb27JSiyu5tgLC8O7nVMw8HLw
        l4iBFnzeCisEHqyRBlc3fsbYf4gTe+bBIPAOtAD2lfoTevdEAIEKU6TmeAgMSHyfDZhQJ8xBn796w
        LxaimyshQMlMgIOUMAZCE8pPMC9nIUwtvYnw53r55n3hofLvFNeZUb4gK4tAo2aplsNXrm528X22/
        fd1qGF5yG/m4TLA9jCGFxgoPjp/ntni+9sOItFF9U1OCpi4KJwJcNTRTQ8Ktb7bayLjt0uSxn6hDA
        9CyJIBDfTBYdpiDc9MXjyK5eOE+Z7C6SlLHHf6ENkhTu8DHLuO55ce6y3CsUkqZTO+Hj4gp1KkXst
        z75EGaPw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kI8R6-0007mK-MV; Tue, 15 Sep 2020 10:43:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B36CA3060F2;
        Tue, 15 Sep 2020 12:43:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 97E1B214EDD4F; Tue, 15 Sep 2020 12:43:40 +0200 (CEST)
Message-ID: <20200915103806.411374792@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 15 Sep 2020 12:32:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     rjw@rjwysocki.net, bp@alien8.de
Cc:     x86@kernel.org, tony.luck@intel.com, lenb@kernel.org,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        ulf.hansson@linaro.org, paulmck@kernel.org, tglx@linutronix.de,
        naresh.kamboju@linaro.org, peterz@infradead.org
Subject: [RFC][PATCH 3/4] cpuidle: Allow cpuidle drivers to take over RCU-idle
References: <20200915103157.345404192@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some drivers have to do significant work, some of which relies on RCU
still being active. Instead of using RCU_NONIDLE in the drivers and
flipping RCU back on, allow drivers to take over RCU-idle duty.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/cpuidle/cpuidle.c |   15 ++++++++++-----
 include/linux/cpuidle.h   |    1 +
 2 files changed, 11 insertions(+), 5 deletions(-)

--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -138,6 +138,7 @@ static void enter_s2idle_proper(struct c
 				struct cpuidle_device *dev, int index)
 {
 	ktime_t time_start, time_end;
+	struct cpuidle_state *target_state = &drv->states[index];
 
 	time_start = ns_to_ktime(local_clock());
 
@@ -153,8 +154,9 @@ static void enter_s2idle_proper(struct c
 	 * suspended is generally unsafe.
 	 */
 	stop_critical_timings();
-	rcu_idle_enter();
-	drv->states[index].enter_s2idle(dev, drv, index);
+	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
+		rcu_idle_enter();
+	target_state->enter_s2idle(dev, drv, index);
 	if (WARN_ON_ONCE(!irqs_disabled()))
 		local_irq_disable();
 	/*
@@ -162,7 +164,8 @@ static void enter_s2idle_proper(struct c
 	 * first CPU executing it calls functions containing RCU read-side
 	 * critical sections, so tell RCU about that.
 	 */
-	rcu_idle_exit();
+	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
+		rcu_idle_exit();
 	tick_unfreeze();
 	start_critical_timings();
 
@@ -239,9 +242,11 @@ int cpuidle_enter_state(struct cpuidle_d
 	time_start = ns_to_ktime(local_clock());
 
 	stop_critical_timings();
-	rcu_idle_enter();
+	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
+		rcu_idle_enter();
 	entered_state = target_state->enter(dev, drv, index);
-	rcu_idle_exit();
+	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
+		rcu_idle_exit();
 	start_critical_timings();
 
 	sched_clock_idle_wakeup_event();
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -82,6 +82,7 @@ struct cpuidle_state {
 #define CPUIDLE_FLAG_UNUSABLE		BIT(3) /* avoid using this state */
 #define CPUIDLE_FLAG_OFF		BIT(4) /* disable this state by default */
 #define CPUIDLE_FLAG_TLB_FLUSHED	BIT(5) /* idle-state flushes TLBs */
+#define CPUIDLE_FLAG_RCU_IDLE		BIT(6) /* idle-state takes care of RCU */
 
 struct cpuidle_device_kobj;
 struct cpuidle_state_kobj;


