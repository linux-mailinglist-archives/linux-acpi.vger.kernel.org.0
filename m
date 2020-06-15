Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A881F8CC3
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jun 2020 05:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgFOD7w (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 14 Jun 2020 23:59:52 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42882 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727971AbgFOD7v (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 14 Jun 2020 23:59:51 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4D451C1DDD8136562A35;
        Mon, 15 Jun 2020 11:59:41 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Mon, 15 Jun 2020
 11:59:33 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kernel-hardening@lists.openwall.com>,
        Jason Yan <yanaijie@huawei.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] ACPI: Eliminate usage of uninitialized_var() macro
Date:   Mon, 15 Jun 2020 12:00:47 +0800
Message-ID: <20200615040047.3535543-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This is an effort to eliminate the uninitialized_var() macro[1].

The use of this macro is the wrong solution because it forces off ANY
analysis by the compiler for a given variable. It even masks "unused
variable" warnings.

Quoted from Linus[2]:

"It's a horrible thing to use, in that it adds extra cruft to the
source code, and then shuts up a compiler warning (even the _reliable_
warnings from gcc)."

The gcc option "-Wmaybe-uninitialized" has been disabled and this change
will not produce any warnnings even with "make W=1".

[1] https://github.com/KSPP/linux/issues/81
[2] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/

Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/acpi/acpi_pad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index e7dc0133f817..6cc4c92d9ff9 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -88,7 +88,7 @@ static void round_robin_cpu(unsigned int tsk_index)
 	cpumask_var_t tmp;
 	int cpu;
 	unsigned long min_weight = -1;
-	unsigned long uninitialized_var(preferred_cpu);
+	unsigned long preferred_cpu;
 
 	if (!alloc_cpumask_var(&tmp, GFP_KERNEL))
 		return;
-- 
2.25.4

