Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548862E3B7C
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Dec 2020 14:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406387AbgL1Nun (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Dec 2020 08:50:43 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10001 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406372AbgL1Num (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Dec 2020 08:50:42 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D4Jn13SDXzj0MV;
        Mon, 28 Dec 2020 21:49:09 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Mon, 28 Dec 2020 21:49:49 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <rafael.j.wysocki@intel.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] pnp: pnpbios: Use DEFINE_SPINLOCK() for spinlock
Date:   Mon, 28 Dec 2020 21:50:26 +0800
Message-ID: <20201228135026.28343-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

spinlock can be initialized automatically with DEFINE_SPINLOCK()
rather than explicitly calling spin_lock_init().

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/pnp/pnpbios/bioscalls.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pnp/pnpbios/bioscalls.c b/drivers/pnp/pnpbios/bioscalls.c
index ba5cfc3dbe11..ddc6f2163c8e 100644
--- a/drivers/pnp/pnpbios/bioscalls.c
+++ b/drivers/pnp/pnpbios/bioscalls.c
@@ -72,7 +72,7 @@ __visible u32 pnp_bios_fault_esp;
 __visible u32 pnp_bios_fault_eip;
 __visible u32 pnp_bios_is_utter_crap = 0;
 
-static spinlock_t pnp_bios_lock;
+static DEFINE_SPINLOCK(pnp_bios_lock);
 
 /*
  * Support Functions
@@ -473,7 +473,6 @@ void pnpbios_calls_init(union pnp_bios_install_struct *header)
 {
 	int i;
 
-	spin_lock_init(&pnp_bios_lock);
 	pnp_bios_callpoint.offset = header->fields.pm16offset;
 	pnp_bios_callpoint.segment = PNP_CS16;
 
-- 
2.22.0

