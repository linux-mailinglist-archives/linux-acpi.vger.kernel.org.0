Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6B0173ED0
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2020 18:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbgB1Rs0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 28 Feb 2020 12:48:26 -0500
Received: from foss.arm.com ([217.140.110.172]:42054 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgB1Rs0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 28 Feb 2020 12:48:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15C0031B;
        Fri, 28 Feb 2020 09:48:25 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3543E3F7B4;
        Fri, 28 Feb 2020 09:48:23 -0800 (PST)
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
Subject: [PATCH 0/3] ACPI / APEI: Kick the memory_failure() queue for synchronous errors
Date:   Fri, 28 Feb 2020 17:48:14 +0000
Message-Id: <20200228174817.74278-1-james.morse@arm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello!

These are the remaining patches from the SDEI series[0] that fix
a race between memory_failure() and user-space re-triggering the error
in ghes.c.


ghes_handle_memory_failure() calls memory_failure_queue() from
IRQ context to schedule memory_failure()s work as it needs to sleep.
Once the GHES machinery returns from the IRQ, it may return to user-space
before memory_failure() runs.

If the error that kicked all this off is specific to user-space, e.g. a
load from corrupted memory, we may find ourselves taking the error
again. If the user-space task is scheduled out, and memory_failure() runs,
the same user-space task may be scheduled in on another CPU, which could
also take the same error.

These lead to exaggerated error counters, which may cause some threshold
to be reached early.

This can happen with any error that causes a Synchronous External Abort
on arm64. I can't see why the same wouldn't happen with a machine-check
handled firmware first on x86.


This series adds a memory_failure_queue_kick() helper to
memory-failure.c, and calls it as task-work before returning to
user-space.


Currently arm64 papers over this problem by ignoring ghes_notify_sea()'s
return code as it knows there is still work to do. arm64 generates its
own signal to user-space, which means the first task to discover an
error will always be killed, even if the error was later handled.
(which is no improvement on the no-RAS behaviour)

As a final piece, arm64 can try to process the irq work queued by
ghes_notify_sea() while its still in the external abort handler. A succesfull
return value here now means the memory_failure() work will be done before we
return to user-space, we no longer need to generate our own signal.
This lets the original task survive the error if memory_failure() can
recover the corrupted memory.

Based on v5.6-rc2. I'm afraid it touches three different trees.
$subject says ACPI as that is where the bulk of the diffstat is.

This series may conflict in arm64 with a series from Mark Rutland to
cleanup the daif/PMR toggling.


This would be v9 of these patches, but after a year I figure I should
start the numbering again. I've dropped any collected tags.

Known issues:
 * arm64's apei_claim_sea() may unwittingly re-enable debug if it takes
   an external-abort from debug context. Patch 3 makes this worse
   instead of fixing it. The fix would make use of helpers from Mark R's
   series.


Thanks,

James


[0] https://lore.kernel.org/linux-arm-kernel/20190129184902.102850-1-james.morse@arm.com/
[1] https://lore.kernel.org/linux-acpi/1506516620-20033-3-git-send-email-xiexiuqi@huawei.com/

James Morse (3):
  mm/memory-failure: Add memory_failure_queue_kick()
  ACPI / APEI: Kick the memory_failure() queue for synchronous errors
  arm64: acpi: Make apei_claim_sea() synchronise with APEI's irq work

 arch/arm64/kernel/acpi.c | 25 +++++++++++++++
 arch/arm64/mm/fault.c    | 12 ++++---
 drivers/acpi/apei/ghes.c | 68 +++++++++++++++++++++++++++++++++-------
 include/acpi/ghes.h      |  3 ++
 include/linux/mm.h       |  1 +
 mm/memory-failure.c      | 15 ++++++++-
 6 files changed, 107 insertions(+), 17 deletions(-)

-- 
2.24.1

