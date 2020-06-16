Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F471FAC2E
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jun 2020 11:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgFPJUZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Jun 2020 05:20:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6333 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725911AbgFPJUZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 16 Jun 2020 05:20:25 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EFF4E7CABB7DC5C85B51;
        Tue, 16 Jun 2020 17:20:22 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Tue, 16 Jun 2020 17:20:17 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <guohanjun@huawei.com>, <wangxiongfeng2@huawei.com>
Subject: [PATCH 1/2] ACPI: EC: add a newline when printing module parameter 'ec_event_clearing'
Date:   Tue, 16 Jun 2020 17:14:08 +0800
Message-ID: <1592298849-41530-2-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1592298849-41530-1-git-send-email-wangxiongfeng2@huawei.com>
References: <1592298849-41530-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When I cat acpi module parameter
'/sys/module/acpi/parameters/ec_event_clearing', it displays as follows.
It is better to add a newline for easy reading.

[root@hulk-202 ~]# cat /sys/module/acpi/parameters/ec_event_clearing
query[root@hulk-202 ~]#

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/acpi/ec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 04ce2b9..fcddda3 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -2059,13 +2059,13 @@ static int param_get_event_clearing(char *buffer,
 {
 	switch (ec_event_clearing) {
 	case ACPI_EC_EVT_TIMING_STATUS:
-		return sprintf(buffer, "status");
+		return sprintf(buffer, "status\n");
 	case ACPI_EC_EVT_TIMING_QUERY:
-		return sprintf(buffer, "query");
+		return sprintf(buffer, "query\n");
 	case ACPI_EC_EVT_TIMING_EVENT:
-		return sprintf(buffer, "event");
+		return sprintf(buffer, "event\n");
 	default:
-		return sprintf(buffer, "invalid");
+		return sprintf(buffer, "invalid\n");
 	}
 	return 0;
 }
-- 
1.7.12.4

