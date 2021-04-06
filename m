Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60111355443
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Apr 2021 14:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbhDFMvG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Apr 2021 08:51:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49259 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243340AbhDFMvF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Apr 2021 08:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617713457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LqmvLDyPcw5HvzsN9d3OA/0ZQ4y65craa/qJjjsW6V4=;
        b=J1f+XdMcOjzhbbGG/A0EllbQmjEIxAcoG1rK5ETrV2SYPfzV3Rc0ZxWIshIvNW7C9EP7A3
        skoFNiQbgY2owtUO7wESsES14IatzaiUlIDkAIERtxzECFkAySmRSp5c3uwP45WVCBXRvg
        L5ijqTVUwIQkQwO/BsUvtS7RqLQ+kpk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-LOHyKUCXMviH3Vb_XtLnIg-1; Tue, 06 Apr 2021 08:50:53 -0400
X-MC-Unique: LOHyKUCXMviH3Vb_XtLnIg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DDB5800D53;
        Tue,  6 Apr 2021 12:50:51 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.194.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8478860C4A;
        Tue,  6 Apr 2021 12:50:48 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     x86@kernel.org, Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, stable@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: processor: Fix build when CONFIG_ACPI_PROCESSOR=m
Date:   Tue,  6 Apr 2021 14:50:47 +0200
Message-Id: <20210406125047.547501-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Commit 8cdddd182bd7 ("ACPI: processor: Fix CPU0 wakeup in
acpi_idle_play_dead()") tried to fix CPU0 hotplug breakage by copying
wakeup_cpu0() + start_cpu0() logic from hlt_play_dead()//mwait_play_dead()
into acpi_idle_play_dead(). The problem is that these functions are not
exported to modules so when CONFIG_ACPI_PROCESSOR=m build fails.

The issue could've been fixed by exporting both wakeup_cpu0()/start_cpu0()
(the later from assembly) but it seems putting the whole pattern into a
new function and exporting it instead is better.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 8cdddd182bd7 ("CPI: processor: Fix CPU0 wakeup in acpi_idle_play_dead()")
Cc: <stable@vger.kernel.org> # 5.10+
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/smp.h    |  2 +-
 arch/x86/kernel/smpboot.c     | 15 ++++++++++-----
 drivers/acpi/processor_idle.c |  3 +--
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 57ef2094af93..6f79deb1f970 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -132,7 +132,7 @@ void native_play_dead(void);
 void play_dead_common(void);
 void wbinvd_on_cpu(int cpu);
 int wbinvd_on_all_cpus(void);
-bool wakeup_cpu0(void);
+void wakeup_cpu0_if_needed(void);
 
 void native_smp_send_reschedule(int cpu);
 void native_send_call_func_ipi(const struct cpumask *mask);
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index f877150a91da..9547d870ee27 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1659,7 +1659,7 @@ void play_dead_common(void)
 	local_irq_disable();
 }
 
-bool wakeup_cpu0(void)
+static bool wakeup_cpu0(void)
 {
 	if (smp_processor_id() == 0 && enable_start_cpu0)
 		return true;
@@ -1667,6 +1667,13 @@ bool wakeup_cpu0(void)
 	return false;
 }
 
+void wakeup_cpu0_if_needed(void)
+{
+	if (wakeup_cpu0())
+		start_cpu0();
+}
+EXPORT_SYMBOL_GPL(wakeup_cpu0_if_needed);
+
 /*
  * We need to flush the caches before going to sleep, lest we have
  * dirty data in our caches when we come back up.
@@ -1737,8 +1744,7 @@ static inline void mwait_play_dead(void)
 		/*
 		 * If NMI wants to wake up CPU0, start CPU0.
 		 */
-		if (wakeup_cpu0())
-			start_cpu0();
+		wakeup_cpu0_if_needed();
 	}
 }
 
@@ -1752,8 +1758,7 @@ void hlt_play_dead(void)
 		/*
 		 * If NMI wants to wake up CPU0, start CPU0.
 		 */
-		if (wakeup_cpu0())
-			start_cpu0();
+		wakeup_cpu0_if_needed();
 	}
 }
 
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 768a6b4d2368..de15116b754a 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -545,8 +545,7 @@ static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
 
 #if defined(CONFIG_X86) && defined(CONFIG_HOTPLUG_CPU)
 		/* If NMI wants to wake up CPU0, start CPU0. */
-		if (wakeup_cpu0())
-			start_cpu0();
+		wakeup_cpu0_if_needed();
 #endif
 	}
 
-- 
2.30.2

