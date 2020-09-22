Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07EEE273C2D
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Sep 2020 09:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbgIVHlQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Sep 2020 03:41:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13818 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729751AbgIVHlQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 22 Sep 2020 03:41:16 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1D7E5767AB46DA20738D;
        Tue, 22 Sep 2020 15:41:11 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 22 Sep 2020 15:41:00 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <robert.moore@intel.com>, <erik.kaneda@intel.com>,
        <rafael.j.wysocki@intel.com>, <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <devel@acpica.org>,
        <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] ACPICA: Remove unneeded semicolon
Date:   Tue, 22 Sep 2020 15:48:49 +0800
Message-ID: <1600760929-102547-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fixes coccicheck warning:

./drivers/acpi/acpica/nsalloc.c:297:2-3: Unneeded semicolon

Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/acpi/acpica/nsalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/nsalloc.c b/drivers/acpi/acpica/nsalloc.c
index fe9b363..83d26ab 100644
--- a/drivers/acpi/acpica/nsalloc.c
+++ b/drivers/acpi/acpica/nsalloc.c
@@ -294,7 +294,7 @@ void acpi_ns_delete_children(struct acpi_namespace_node *parent_node)
 		node_to_delete = next_node;
 		next_node = next_node->peer;
 		acpi_ns_delete_node(node_to_delete);
-	};
+	}
 
 	/* Clear the parent's child pointer */
 
-- 
2.6.2

