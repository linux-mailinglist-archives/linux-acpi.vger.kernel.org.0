Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035CC2766B8
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Sep 2020 05:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgIXDFZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Sep 2020 23:05:25 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46244 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726487AbgIXDFW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 23 Sep 2020 23:05:22 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B7E28E407D2BEB987834;
        Thu, 24 Sep 2020 11:05:20 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 24 Sep 2020 11:05:11 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     <linux-acpi@vger.kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH v2 15/15] ACPI: wakeup: Remove the dead ACPICA debug code
Date:   Thu, 24 Sep 2020 10:57:07 +0800
Message-ID: <1600916227-21805-16-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1600916227-21805-1-git-send-email-guohanjun@huawei.com>
References: <1600916227-21805-1-git-send-email-guohanjun@huawei.com>
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

