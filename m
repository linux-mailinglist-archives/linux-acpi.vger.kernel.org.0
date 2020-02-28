Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26B70173ED1
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2020 18:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbgB1Rs3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 28 Feb 2020 12:48:29 -0500
Received: from foss.arm.com ([217.140.110.172]:42080 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgB1Rs3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 28 Feb 2020 12:48:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3DA8FEC;
        Fri, 28 Feb 2020 09:48:28 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10AD13F7B4;
        Fri, 28 Feb 2020 09:48:26 -0800 (PST)
From:   James Morse <james.morse@arm.com>
To:     linux-mm@kvack.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tyler Baicar <tyler@amperecomputing.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH 1/3] mm/memory-failure: Add memory_failure_queue_kick()
Date:   Fri, 28 Feb 2020 17:48:15 +0000
Message-Id: <20200228174817.74278-2-james.morse@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200228174817.74278-1-james.morse@arm.com>
References: <20200228174817.74278-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The GHES code calls memory_failure_queue() from IRQ context to schedule
work on the current CPU so that memory_failure() can sleep.

For synchronous memory errors the arch code needs to know any signals
that memory_failure() will trigger are pending before it returns to
user-space, possibly when exiting from the IRQ.

Add a helper to kick the memory failure queue, to ensure the scheduled
work has happened. This has to be called from process context, so may
have been migrated from the original cpu. Pass the cpu the work was
queued on.

Change memory_failure_work_func() to permit being called on the 'wrong'
cpu.

Signed-off-by: James Morse <james.morse@arm.com>
---
 include/linux/mm.h  |  1 +
 mm/memory-failure.c | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 52269e56c514..389460de3ee6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2806,6 +2806,7 @@ enum mf_flags {
 };
 extern int memory_failure(unsigned long pfn, int flags);
 extern void memory_failure_queue(unsigned long pfn, int flags);
+extern void memory_failure_queue_kick(int cpu);
 extern int unpoison_memory(unsigned long pfn);
 extern int get_hwpoison_page(struct page *page);
 #define put_hwpoison_page(page)	put_page(page)
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 41c634f45d45..afdf1fd5ef9c 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1468,7 +1468,7 @@ static void memory_failure_work_func(struct work_struct *work)
 	unsigned long proc_flags;
 	int gotten;
 
-	mf_cpu = this_cpu_ptr(&memory_failure_cpu);
+	mf_cpu = container_of(work, struct memory_failure_cpu, work);
 	for (;;) {
 		spin_lock_irqsave(&mf_cpu->lock, proc_flags);
 		gotten = kfifo_get(&mf_cpu->fifo, &entry);
@@ -1482,6 +1482,19 @@ static void memory_failure_work_func(struct work_struct *work)
 	}
 }
 
+/*
+ * Process memory_failure work queued on the specified CPU.
+ * Used to avoid return-to-userspace racing with the memory_failure workqueue.
+ */
+void memory_failure_queue_kick(int cpu)
+{
+	struct memory_failure_cpu *mf_cpu;
+
+	mf_cpu = &per_cpu(memory_failure_cpu, cpu);
+	cancel_work_sync(&mf_cpu->work);
+	memory_failure_work_func(&mf_cpu->work);
+}
+
 static int __init memory_failure_init(void)
 {
 	struct memory_failure_cpu *mf_cpu;
-- 
2.24.1

