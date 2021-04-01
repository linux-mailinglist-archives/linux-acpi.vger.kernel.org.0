Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E59350CBD
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Apr 2021 04:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbhDACj6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 31 Mar 2021 22:39:58 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15839 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbhDACj1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Mar 2021 22:39:27 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F9nQR2NFKz93g8;
        Thu,  1 Apr 2021 10:37:19 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Thu, 1 Apr 2021
 10:39:17 +0800
From:   Shixin Liu <liushixin2@huawei.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Shixin Liu <liushixin2@huawei.com>
Subject: [PATCH -next] ACPI: processor: Fix a prepocessor warning
Date:   Thu, 1 Apr 2021 10:39:00 +0800
Message-ID: <20210401023900.3114325-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When compiling with defconfig on x86_64, I got a warning:

drivers/acpi/processor_idle.c: In function ‘acpi_idle_play_dead’:
drivers/acpi/processor_idle.c:542:15: warning: extra tokens at end of #ifdef directive
  542 | #ifdef defined(CONFIG_X86) && defined(CONFIG_HOTPLUG_CPU)
      |

Fixes: bc5706eaeae0 ("ACPI: processor: Fix CPU0 wakeup in acpi_idle_play_dead()")
Signed-off-by: Shixin Liu <liushixin2@huawei.com>
---
 drivers/acpi/processor_idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 19fb28a8005b..0925b1477230 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -539,7 +539,7 @@ static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
 		} else
 			return -ENODEV;
 
-#ifdef defined(CONFIG_X86) && defined(CONFIG_HOTPLUG_CPU)
+#if defined(CONFIG_X86) && defined(CONFIG_HOTPLUG_CPU)
 		/* If NMI wants to wake up CPU0, start CPU0. */
 		if (wakeup_cpu0())
 			start_cpu0();
-- 
2.25.1

