Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B4526D6C4
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Sep 2020 10:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgIQIfX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Sep 2020 04:35:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12826 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726200AbgIQIfW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Sep 2020 04:35:22 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CAEDDDBC5DB460FEC7FA;
        Thu, 17 Sep 2020 15:47:05 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 15:46:56 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH RFC 25/25] ACPI: debug: Update the ACPI debug document
Date:   Thu, 17 Sep 2020 15:39:05 +0800
Message-ID: <1600328345-27627-26-git-send-email-guohanjun@huawei.com>
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

Update the document as some of the COMPONENT bit define
are removed.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 Documentation/firmware-guide/acpi/debug.rst | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/debug.rst b/Documentation/firmware-guide/acpi/debug.rst
index 1a152dd..508cf46 100644
--- a/Documentation/firmware-guide/acpi/debug.rst
+++ b/Documentation/firmware-guide/acpi/debug.rst
@@ -56,14 +56,10 @@ shows the supported mask values, currently these::
     ACPI_AC_COMPONENT               0x00020000
     ACPI_BATTERY_COMPONENT          0x00040000
     ACPI_BUTTON_COMPONENT           0x00080000
-    ACPI_SBS_COMPONENT              0x00100000
-    ACPI_FAN_COMPONENT              0x00200000
     ACPI_PCI_COMPONENT              0x00400000
     ACPI_POWER_COMPONENT            0x00800000
-    ACPI_CONTAINER_COMPONENT        0x01000000
     ACPI_SYSTEM_COMPONENT           0x02000000
     ACPI_THERMAL_COMPONENT          0x04000000
-    ACPI_MEMORY_DEVICE_COMPONENT    0x08000000
     ACPI_VIDEO_COMPONENT            0x10000000
     ACPI_PROCESSOR_COMPONENT        0x20000000
 
-- 
1.7.12.4

