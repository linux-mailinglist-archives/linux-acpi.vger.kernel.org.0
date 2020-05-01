Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823191C1AC2
	for <lists+linux-acpi@lfdr.de>; Fri,  1 May 2020 18:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgEAQqC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 May 2020 12:46:02 -0400
Received: from foss.arm.com ([217.140.110.172]:43758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728896AbgEAQqB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 1 May 2020 12:46:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB59431B;
        Fri,  1 May 2020 09:46:00 -0700 (PDT)
Received: from melchizedek.cambridge.arm.com (melchizedek.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0797F3F305;
        Fri,  1 May 2020 09:45:58 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-mm@kvack.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tyler Baicar <tyler@amperecomputing.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH v2 1/3] mm/memory-failure: Add memory_failure_queue_kick()
Date:   Fri,  1 May 2020 17:45:41 +0100
Message-Id: <20200501164543.24423-2-james.morse@arm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200501164543.24423-1-james.morse@arm.com>
References: <20200501164543.24423-1-james.morse@arm.com>
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
Tested-by: Tyler Baicar <baicar@os.amperecomputing.com>
---
 include/linux/mm.h  |  1 +
 mm/memory-failure.c | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5a323422d783..c606dbbfa5e1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3012,6 +3012,7 @@ enum mf_flags {
 };
 extern int memory_failure(unsigned long pfn, int flags);
 extern void memory_failure_queue(unsigned long pfn, int flags);
+extern void memory_failure_queue_kick(int cpu);
 extern int unpoison_memory(unsigned long pfn);
 extern int get_hwpoison_page(struct page *page);
 #define put_hwpoison_page(page)	put_page(page)
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a96364be8ab4..c4afb407bf0f 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1493,7 +1493,7 @@ static void memory_failure_work_func(struct work_struct *work)
 	unsigned long proc_flags;
 	int gotten;
 
-	mf_cpu = this_cpu_ptr(&memory_failure_cpu);
+	mf_cpu = container_of(work, struct memory_failure_cpu, work);
 	for (;;) {
 		spin_lock_irqsave(&mf_cpu->lock, proc_flags);
 		gotten = kfifo_get(&mf_cpu->fifo, &entry);
@@ -1507,6 +1507,19 @@ static void memory_failure_work_func(struct work_struct *work)
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
2.26.1

