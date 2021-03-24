Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6397347C7D
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Mar 2021 16:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236565AbhCXPXZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Mar 2021 11:23:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57205 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236644AbhCXPW7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 24 Mar 2021 11:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616599379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9vmQn4NIrUk8xJdGGejNzI5lmYgeNFGUq43EqQoEUhA=;
        b=J0+nJEAbPhqkWU3c7dGWTs6imgT/NPwyAnWC7uqct2+OOhk1nZzq3h1SXN4O+gLuHysJ1U
        0gO88eoEcJWwNAkTlgado8lT97g8xGw4LJgf03bqn4xX0jhwDBUqS3u5D/3lS1nRAtw+wr
        m/AnpEP2RcRDmWMZn5EcRxWCCmFVm4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-7gABUynXOzW75-OE2il27A-1; Wed, 24 Mar 2021 11:22:54 -0400
X-MC-Unique: 7gABUynXOzW75-OE2il27A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CF57884D97;
        Wed, 24 Mar 2021 15:22:24 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C49E6E169;
        Wed, 24 Mar 2021 15:22:20 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-acpi@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Al Stone <ahs3@redhat.com>, Zhang Rui <rui.zhang@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: processor: Fix CPU0 wakeup in acpi_idle_play_dead()
Date:   Wed, 24 Mar 2021 16:22:19 +0100
Message-Id: <20210324152219.1456012-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Commit 496121c02127 ("ACPI: processor: idle: Allow probing on platforms
with one ACPI C-state") broke CPU0 hotplug on certain systems, e.g.
I'm observing the following on AWS Nitro (e.g r5b.xlarge but other
instance types are affected as well):

 # echo 0 > /sys/devices/system/cpu/cpu0/online
 # echo 1 > /sys/devices/system/cpu/cpu0/online
 <10 seconds delay>
 -bash: echo: write error: Input/output error

In fact, the above mentioned commit only revealed the problem and did
not introduce it. On x86, to wakeup CPU an NMI is being used and
hlt_play_dead()/mwait_play_dead() loops are prepared to handle it:

	/*
	 * If NMI wants to wake up CPU0, start CPU0.
	 */
	if (wakeup_cpu0())
		start_cpu0();

cpuidle_play_dead() -> acpi_idle_play_dead() (which is now being called on
systems where it wasn't called before the above mentioned commit) serves
the same purpose but it doesn't have a path for CPU0. What happens now on
wakeup is:
- NMI is sent to CPU0
- wakeup_cpu0_nmi() works as expected
- we get back to while (1) loop in acpi_idle_play_dead()
- safe_halt() puts CPU0 to sleep again.

The straightforward/minimal fix is add the special handling for CPU0 on x86
and that's what the patch is doing.

Fixes: 496121c02127 ("ACPI: processor: idle: Allow probing on platforms with one ACPI C-state")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/smp.h    | 1 +
 arch/x86/kernel/smpboot.c     | 2 +-
 drivers/acpi/processor_idle.c | 7 +++++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index c0538f82c9a2..57ef2094af93 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -132,6 +132,7 @@ void native_play_dead(void);
 void play_dead_common(void);
 void wbinvd_on_cpu(int cpu);
 int wbinvd_on_all_cpus(void);
+bool wakeup_cpu0(void);
 
 void native_smp_send_reschedule(int cpu);
 void native_send_call_func_ipi(const struct cpumask *mask);
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 02813a7f3a7c..f877150a91da 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1659,7 +1659,7 @@ void play_dead_common(void)
 	local_irq_disable();
 }
 
-static bool wakeup_cpu0(void)
+bool wakeup_cpu0(void)
 {
 	if (smp_processor_id() == 0 && enable_start_cpu0)
 		return true;
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index d93e400940a3..eb1101b16c08 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -29,6 +29,7 @@
  */
 #ifdef CONFIG_X86
 #include <asm/apic.h>
+#include <asm/cpu.h>
 #endif
 
 #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
@@ -541,6 +542,12 @@ static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
 			wait_for_freeze();
 		} else
 			return -ENODEV;
+
+#ifdef CONFIG_X86
+		/* If NMI wants to wake up CPU0, start CPU0. */
+		if (wakeup_cpu0())
+			start_cpu0();
+#endif
 	}
 
 	/* Never reached */
-- 
2.30.2

