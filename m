Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1A926D58E
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Sep 2020 10:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgIQIEW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Sep 2020 04:04:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56448 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726387AbgIQIDw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Sep 2020 04:03:52 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 741531196665FA611A0D;
        Thu, 17 Sep 2020 15:46:55 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 15:46:46 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 06/25] ACPI: memhotplug: Remove the leftover ACPICA debug functionality
Date:   Thu, 17 Sep 2020 15:38:46 +0800
Message-ID: <1600328345-27627-7-git-send-email-guohanjun@huawei.com>
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

After commit ("0a34764411aa ACPI / scan: Make memory hotplug driver use
struct acpi_scan_handler"), all the ACPICA debug functionality was
removed, remove the leftover ACPICA debug code.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/acpi_memhotplug.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index e294f44..9cd987d 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -22,13 +22,6 @@
 #define ACPI_MEMORY_DEVICE_HID			"PNP0C80"
 #define ACPI_MEMORY_DEVICE_NAME			"Hotplug Mem Device"
 
-#define _COMPONENT		ACPI_MEMORY_DEVICE_COMPONENT
-
-#undef PREFIX
-#define 	PREFIX		"ACPI:memory_hp:"
-
-ACPI_MODULE_NAME("acpi_memhotplug");
-
 static const struct acpi_device_id memory_device_ids[] = {
 	{ACPI_MEMORY_DEVICE_HID, 0},
 	{"", 0},
-- 
1.7.12.4

