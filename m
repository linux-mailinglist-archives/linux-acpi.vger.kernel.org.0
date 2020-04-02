Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8361419C104
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Apr 2020 14:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbgDBM0U (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 Apr 2020 08:26:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12673 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726252AbgDBM0U (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 2 Apr 2020 08:26:20 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E461D2164003D8894B6D;
        Thu,  2 Apr 2020 20:26:16 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Thu, 2 Apr 2020 20:26:09 +0800
From:   John Garry <john.garry@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sudeep.holla@arm.com>, <jeremy.linton@arm.com>,
        <linuxarm@huawei.com>, <wanghuiqiang@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] ACPI: PPTT: Inform user that table offset used for Physical processor node ID
Date:   Thu, 2 Apr 2020 20:22:25 +0800
Message-ID: <1585830145-208714-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

If the the Processor ID valid is not set for a Physical Processor Package
node, then the node table offset is used as a substitute. As such, we
may get info like this from sysfs:

root@(none)$ pwd
/sys/devices/system/cpu/cpu0/topology
root@(none)$ more physical_package_id
56

Inform the user of this in the bootlog, as it is much less than ideal, and
they can remedy this in their FW.

This topic was originally discussed in:
https://lore.kernel.org/linux-acpi/c325cfe2-7dbf-e341-7f0f-081b6545e890@huawei.com/T/#m0ec18637d8586f832084a8a6af22580e6174669a

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index 4ae93350b70d..b4ed3c818e00 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -515,6 +515,8 @@ static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
 		if (level == 0 ||
 		    cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID)
 			return cpu_node->acpi_processor_id;
+		if (level == PPTT_ABORT_PACKAGE)
+			pr_notice_once("Physical package node Processor ID valid not set, will use table offset as substitute\n");
 		return ACPI_PTR_DIFF(cpu_node, table);
 	}
 	pr_warn_once("PPTT table found, but unable to locate core %d (%d)\n",
-- 
2.16.4

