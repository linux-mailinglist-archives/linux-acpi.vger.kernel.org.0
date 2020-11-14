Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC0D2B2CDB
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Nov 2020 12:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgKNLO6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 14 Nov 2020 06:14:58 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8089 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgKNLO6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 14 Nov 2020 06:14:58 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CYCR505FzzLy56;
        Sat, 14 Nov 2020 19:14:41 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Sat, 14 Nov 2020
 19:14:51 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>
Subject: [PATCH] ACPI: TAD: Fix reference imbalance in acpi_tad_probe
Date:   Sat, 14 Nov 2020 19:18:34 +0800
Message-ID: <20201114111834.3466695-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It have enabled runtime and suspend the device before going
to fail branch. We should call pm_runtime_resume to keep the
usage counter balanced and pm_runtime_disable to keep disable
depth balanced sequentially.

Fixes: 95c513ec84f7f ("ACPI: Add Time and Alarm Device (TAD) driver")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/acpi/acpi_tad.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
index 7d45cce0c3c1..87ab606a0df8 100644
--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -652,6 +652,8 @@ static int acpi_tad_probe(struct platform_device *pdev)
 	return 0;
 
 fail:
+	pm_runtime_resume(dev);
+	pm_runtime_disable(dev);
 	acpi_tad_remove(pdev);
 	return ret;
 }
-- 
2.25.4

