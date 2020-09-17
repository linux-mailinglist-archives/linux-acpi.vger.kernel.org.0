Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1F726D6B4
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Sep 2020 10:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgIQIe2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Sep 2020 04:34:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12824 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726106AbgIQIeY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Sep 2020 04:34:24 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CE9A1AA66E8CED9F2D11;
        Thu, 17 Sep 2020 15:47:05 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 15:46:55 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 23/25] ACPI: wakeup: Remove the dead ACPICA debug code
Date:   Thu, 17 Sep 2020 15:39:03 +0800
Message-ID: <1600328345-27627-24-git-send-email-guohanjun@huawei.com>
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

The ACPICA debug code of ACPI_SYSTEM_COMPONENT and ACPI_MODULE_NAME()
are not used in wakeup.c, remove it.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/wakeup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/wakeup.c b/drivers/acpi/wakeup.c
index 0b2e425..f89dd9a 100644
--- a/drivers/acpi/wakeup.c
+++ b/drivers/acpi/wakeup.c
@@ -26,8 +26,6 @@ struct acpi_wakeup_handler {
  * suspend/resume and isn't really required as this is called in S-state. At
  * that time, there is no device hotplug
  **/
-#define _COMPONENT		ACPI_SYSTEM_COMPONENT
-ACPI_MODULE_NAME("wakeup_devices")
 
 /**
  * acpi_enable_wakeup_devices - Enable wake-up device GPEs.
-- 
1.7.12.4

