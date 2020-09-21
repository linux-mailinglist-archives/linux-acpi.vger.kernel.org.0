Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E4C27214C
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Sep 2020 12:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgIUKhy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Sep 2020 06:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgIUKhv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Sep 2020 06:37:51 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315C7C061755;
        Mon, 21 Sep 2020 03:37:51 -0700 (PDT)
Received: from zn.tnic (p200300ec2f07e300a1766583a478f392.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:e300:a176:6583:a478:f392])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D80851EC03C9;
        Mon, 21 Sep 2020 12:37:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600684667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=in/bybOnAIhAdt8FQ8tWtig4T4/V4JAt7w3WooCITpM=;
        b=T9CXOlxoQCHIOVk3J5RboDd29f68vxB/C2aSm2tOFNyC5MonwkiSZ0E4BWcGMgIUTpaop7
        QnG30Ps/uMuZ/e+7qsWAbMS0UD3lNJQgAoEU9YNjR2Wlk5JdKJ9PFH9ihrj0lhM0Wr6QUi
        OHqh4RDlxnPsDC1FYlUrAD7doxbHcjc=
Date:   Mon, 21 Sep 2020 12:37:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sven Joachim <svenjoac@gmx.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net,
        x86@kernel.org, tony.luck@intel.com, lenb@kernel.org,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        ulf.hansson@linaro.org, paulmck@kernel.org, tglx@linutronix.de,
        naresh.kamboju@linaro.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH] rcu/tree: Export rcu_idle_{enter,exit} to module
Message-ID: <20200921103741.GC5901@zn.tnic>
References: <20200915103157.345404192@infradead.org>
 <20200915103806.479637218@infradead.org>
 <87wo0npk72.fsf@turtle.gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wo0npk72.fsf@turtle.gmx.de>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Lemme add whatever get_maintainer spits, to Cc.

On Mon, Sep 21, 2020 at 11:12:33AM +0200, Sven Joachim wrote:
> On 2020-09-15 12:32 +0200, Peter Zijlstra wrote:
> 
> > The C3 BusMaster idle code takes lock in a number of places, some deep
> > inside the ACPI code. Instead of wrapping it all in RCU_NONIDLE, have
> > the driver take over RCU-idle duty and avoid flipping RCU state back
> > and forth a lot.
> >
> > ( by marking 'C3 && bm_check' as RCU_IDLE, we _must_ call enter_bm() for
> >   that combination, otherwise we'll loose RCU-idle, this requires
> >   shuffling some code around )
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> I got modpost errors in 5.9-rc6 after this patch:
> 
> ERROR: modpost: "rcu_idle_enter" [drivers/acpi/processor.ko] undefined!
> ERROR: modpost: "rcu_idle_exit" [drivers/acpi/processor.ko] undefined!
> 
> Reverting commit 1fecfdbb7acc made them go away.  Notably my
> configuration had CONFIG_ACPI_PROCESSOR=m,  changing that
> to CONFIG_ACPI_PROCESSOR=y let the build succeed as well.

I guess this. Running randconfigs on it for a while, to see what else
breaks.

---
From: Borislav Petkov <bp@suse.de>
Date: Mon, 21 Sep 2020 12:31:36 +0200

Fix this link error:

  ERROR: modpost: "rcu_idle_enter" [drivers/acpi/processor.ko] undefined!
  ERROR: modpost: "rcu_idle_exit" [drivers/acpi/processor.ko] undefined!

when CONFIG_ACPI_PROCESSOR is built as module. PeterZ says that in light
of ARM needing those soon too, they should simply be exported.

Fixes: 1fecfdbb7acc ("ACPI: processor: Take over RCU-idle for C3-BM idle")
Reported-by: Sven Joachim <svenjoac@gmx.de>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 kernel/rcu/tree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8ce77d9ac716..f78ee759af9c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -673,6 +673,7 @@ void rcu_idle_enter(void)
 	lockdep_assert_irqs_disabled();
 	rcu_eqs_enter(false);
 }
+EXPORT_SYMBOL_GPL(rcu_idle_enter);
 
 #ifdef CONFIG_NO_HZ_FULL
 /**
@@ -886,6 +887,7 @@ void rcu_idle_exit(void)
 	rcu_eqs_exit(false);
 	local_irq_restore(flags);
 }
+EXPORT_SYMBOL_GPL(rcu_idle_exit);
 
 #ifdef CONFIG_NO_HZ_FULL
 /**
-- 
2.21.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
