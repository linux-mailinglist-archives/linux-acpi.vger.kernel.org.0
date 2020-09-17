Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD0626D6C6
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Sep 2020 10:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgIQIfd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Sep 2020 04:35:33 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13228 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726285AbgIQIfZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Sep 2020 04:35:25 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AF25924BC1BFB9A39572;
        Thu, 17 Sep 2020 15:47:00 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 15:46:50 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 15/25] ACPI: proc: Remove the unused ACPICA debug code
Date:   Thu, 17 Sep 2020 15:38:55 +0800
Message-ID: <1600328345-27627-16-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1600328345-27627-1-git-send-email-guohanjun@huawei.com>
References: <1600328345-27627-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Remove the not used ACPICA debug code which is used
nowhere in proc.c.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/proc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/acpi/proc.c b/drivers/acpi/proc.c
index 7892980..0cca799 100644
--- a/drivers/acpi/proc.c
+++ b/drivers/acpi/proc.c
@@ -10,15 +10,11 @@
 #include "sleep.h"
 #include "internal.h"
 
-#define _COMPONENT		ACPI_SYSTEM_COMPONENT
-
 /*
  * this file provides support for:
  * /proc/acpi/wakeup
  */
 
-ACPI_MODULE_NAME("sleep")
-
 static int
 acpi_system_wakeup_device_seq_show(struct seq_file *seq, void *offset)
 {
-- 
1.7.12.4

