Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1F71C857F
	for <lists+linux-acpi@lfdr.de>; Thu,  7 May 2020 11:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgEGJQO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 May 2020 05:16:14 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3836 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726367AbgEGJQO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 May 2020 05:16:14 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5C1DD8683BFED22DDEDE;
        Thu,  7 May 2020 17:16:11 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 17:16:02 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, <linux-acpi@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 9/9] ACPI: sleep: Put the FACS table after using it
Date:   Thu, 7 May 2020 17:09:21 +0800
Message-ID: <1588842561-32907-10-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1588842561-32907-1-git-send-email-guohanjun@huawei.com>
References: <1588842561-32907-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Put the FACS table after using it to release the table
mapping.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/acpi/sleep.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 4edc8a3..30e2df9 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -1297,8 +1297,10 @@ static void acpi_sleep_hibernate_setup(void)
 		return;
 
 	acpi_get_table(ACPI_SIG_FACS, 1, (struct acpi_table_header **)&facs);
-	if (facs)
+	if (facs) {
 		s4_hardware_signature = facs->hardware_signature;
+		acpi_put_table((struct acpi_table_header *)facs);
+	}
 }
 #else /* !CONFIG_HIBERNATION */
 static inline void acpi_sleep_hibernate_setup(void) {}
-- 
1.7.12.4

