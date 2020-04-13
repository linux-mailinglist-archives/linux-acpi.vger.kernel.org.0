Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2481A677F
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Apr 2020 16:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbgDMOFn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Apr 2020 10:05:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2365 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730262AbgDMOFm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 13 Apr 2020 10:05:42 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B85697FE27BEFDDC1BA6;
        Mon, 13 Apr 2020 22:05:34 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Mon, 13 Apr 2020
 22:05:28 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <robert.moore@intel.com>, <erik.kaneda@intel.com>,
        <rafael.j.wysocki@intel.com>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>, <devel@acpica.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] ACPICA: Use ARRAY_SIZE instead of hardcoded siz
Date:   Mon, 13 Apr 2020 22:31:56 +0800
Message-ID: <20200413143156.22633-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fix the following coccicheck warning:

./drivers/acpi/acpica/rsdumpinfo.c:18:48-49: WARNING: Use ARRAY_SIZE
./drivers/acpi/acpica/rsdumpinfo.c:18:48-49: WARNING: Use ARRAY_SIZE
./drivers/acpi/acpica/rsdumpinfo.c:18:48-49: WARNING: Use ARRAY_SIZE
./drivers/acpi/acpica/rsdumpinfo.c:18:48-49: WARNING: Use ARRAY_SIZE
./drivers/acpi/acpica/rsdumpinfo.c:18:48-49: WARNING: Use ARRAY_SIZE
./drivers/acpi/acpica/rsdumpinfo.c:18:48-49: WARNING: Use ARRAY_SIZE
./drivers/acpi/acpica/rsdumpinfo.c:18:48-49: WARNING: Use ARRAY_SIZE

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/acpi/acpica/rsdumpinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/rsdumpinfo.c b/drivers/acpi/acpica/rsdumpinfo.c
index cafa8134b4c6..f1ba4cd8080f 100644
--- a/drivers/acpi/acpica/rsdumpinfo.c
+++ b/drivers/acpi/acpica/rsdumpinfo.c
@@ -15,7 +15,7 @@ ACPI_MODULE_NAME("rsdumpinfo")
 #if defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DISASSEMBLER) || defined(ACPI_DEBUGGER)
 #define ACPI_RSD_OFFSET(f)          (u8) ACPI_OFFSET (union acpi_resource_data,f)
 #define ACPI_PRT_OFFSET(f)          (u8) ACPI_OFFSET (struct acpi_pci_routing_table,f)
-#define ACPI_RSD_TABLE_SIZE(name)   (sizeof(name) / sizeof (struct acpi_rsdump_info))
+#define ACPI_RSD_TABLE_SIZE(name)   ARRAY_SIZE(name)
 /*******************************************************************************
  *
  * Resource Descriptor info tables
-- 
2.21.1

