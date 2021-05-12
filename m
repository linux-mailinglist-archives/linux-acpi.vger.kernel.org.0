Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D0537B48C
	for <lists+linux-acpi@lfdr.de>; Wed, 12 May 2021 05:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhELDft (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 May 2021 23:35:49 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2635 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbhELDft (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 May 2021 23:35:49 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fg0gn45lRzQkjR;
        Wed, 12 May 2021 11:31:17 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 11:34:29 +0800
From:   chenxiang <chenxiang66@hisilicon.com>
To:     <robert.moore@intel.com>, <erik.kaneda@intel.com>,
        <rafael.j.wysocki@intel.com>, <hoan@os.amperecomputing.com>,
        <fancer.lancer@gmail.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linuxarm@huawei.com>, Xiang Chen <chenxiang66@hisilicon.com>
Subject: [PATCH] ACPICA: fix a memleak issue related to ACPI/GPIO
Date:   Wed, 12 May 2021 11:30:07 +0800
Message-ID: <1620790207-128605-1-git-send-email-chenxiang66@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

There is a memleak reported as follows:

unreferenced object 0xffff00208ff85a00 (size 128):
  comm "swapper/0", pid 1, jiffies 4294892588 (age 887.572s)
  hex dump (first 32 bytes):
    00 00 00 00 02 00 00 00 08 5a f8 8f 20 00 ff ff  .........Z.. ...
    08 5a f8 8f 20 00 ff ff 00 00 00 00 00 00 00 00  .Z.. ...........
backtrace:
    [<00000000bc25bad8>] slab_post_alloc_hook+0x80/0x2e0
    [<000000008d547074>] kmem_cache_alloc+0x194/0x2c0
    [<00000000b08da9ad>] acpi_os_create_semaphore+0x3c/0x78
    [<0000000024816c0a>] acpi_ev_install_space_handler+0x214/0x274
    [<00000000d93a5ac2>] acpi_install_address_space_handler+0x64/0xb0
    [<0000000098c37a45>] acpi_gpiochip_add+0x130/0x348
    [<00000000c1cf4b42>] gpiochip_add_data_with_key+0x79c/0xdd0
    [<000000005ce539e9>] devm_gpiochip_add_data_with_key+0x30/0x90
    [<00000000a3038b8d>] dwapb_gpio_probe+0x3e4/0x7e8
    [<0000000047a03eba>] platform_probe+0x68/0xe0
    [<00000000dc15c501>] really_probe+0x17c/0x4a0
    [<00000000aa1f123d>] driver_probe_device+0x68/0xd0
    [<00000000d97646e0>] device_driver_attach+0x74/0x80
    [<0000000073d5b3e5>] __driver_attach+0x8c/0xe0
    [<00000000ff60d118>] bus_for_each_dev+0x7c/0xd8
    [<00000000b018393d>] driver_attach+0x24/0x30

It requires to delete the handler object in function 
acpi_remove_address_space_handler() but it just up the sem with function
acpi_os_release_mutex(), so use acpi_os_delete_mutex() instead of 
acpi_os_release_mutex() in function acpi_remove_address_space_handler().

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
---
 drivers/acpi/acpica/evxfregn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index b1ff0a8..4db0bec 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -201,7 +201,7 @@ acpi_remove_address_space_handler(acpi_handle device,
 
 			/* Now we can delete the handler object */
 
-			acpi_os_release_mutex(handler_obj->address_space.
+			acpi_os_delete_mutex(handler_obj->address_space.
 					      context_mutex);
 			acpi_ut_remove_reference(handler_obj);
 			goto unlock_and_exit;
-- 
2.8.1

