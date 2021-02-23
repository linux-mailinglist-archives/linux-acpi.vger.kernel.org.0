Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35779322353
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Feb 2021 01:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhBWA4V (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Feb 2021 19:56:21 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12565 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhBWA4S (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Feb 2021 19:56:18 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Dl0sq3CGVzMctk;
        Tue, 23 Feb 2021 08:53:35 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Tue, 23 Feb 2021 08:55:33 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>
Subject: [PATCH] ACPI: processor: Remove initialization of static variables
Date:   Tue, 23 Feb 2021 08:56:29 +0800
Message-ID: <1614041789-28216-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Address the following checkpatch errors:
ERROR: do not initialise statics to false

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/acpi/processor_perflib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 32f0f55..91c401e 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -459,7 +459,7 @@ int acpi_processor_pstate_control(void)
 
 int acpi_processor_notify_smm(struct module *calling_module)
 {
-	static int is_done = 0;
+	static int is_done;
 	int result;
 
 	if (!acpi_processor_cpufreq_init)
-- 
2.7.4

