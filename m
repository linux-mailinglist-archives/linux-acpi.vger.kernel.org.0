Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75205268233
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Sep 2020 02:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgINArY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 13 Sep 2020 20:47:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12243 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725962AbgINArY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 13 Sep 2020 20:47:24 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4C60D1802ACFD753FA8B
        for <linux-acpi@vger.kernel.org>; Mon, 14 Sep 2020 08:47:21 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Mon, 14 Sep 2020 08:47:10 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <rafael.j.wysocki@intel.com>, <linux-acpi@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH] PNP: Fix duplicate included pci.h
Date:   Mon, 14 Sep 2020 08:44:50 +0800
Message-ID: <1600044290-12475-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

linux/pci.h is included more than once, Remove the one that isn't
necessary.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/pnp/quirks.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pnp/quirks.c b/drivers/pnp/quirks.c
index de99f37..ac98b99 100644
--- a/drivers/pnp/quirks.c
+++ b/drivers/pnp/quirks.c
@@ -226,8 +226,6 @@ static void quirk_ad1815_mpu_resources(struct pnp_dev *dev)
 	dev_info(&dev->dev, "made independent IRQ optional\n");
 }
 
-#include <linux/pci.h>
-
 static void quirk_system_pci_resources(struct pnp_dev *dev)
 {
 	struct pci_dev *pdev = NULL;
-- 
2.7.4

