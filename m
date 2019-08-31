Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1D0CA4350
	for <lists+linux-acpi@lfdr.de>; Sat, 31 Aug 2019 10:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfHaIeA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 31 Aug 2019 04:34:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5261 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726360AbfHaIeA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 31 Aug 2019 04:34:00 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E49CB9A8C018A4B8E46B;
        Sat, 31 Aug 2019 16:33:56 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Sat, 31 Aug 2019 16:33:48 +0800
From:   tiantao <tiantao6@huawei.com>
To:     <rafael.j.wysocki@intel.com>, <guohanjun@huawei.com>,
        <robert.moore@intel.com>, <erik.schmauss@intel.com>,
        <lenb@kernel.org>
CC:     <linuxarm@huawei.com>, <linux-acpi@vger.kernel.org>,
        <devel@acpica.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ACPICA: Namespace: fix the no brace needed warning
Date:   Sat, 31 Aug 2019 16:31:35 +0800
Message-ID: <1567240295-44686-1-git-send-email-tiantao6@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

for if else statements having single block no braces are needed fixed
the following checkpatch warning

WARNING: braces {} are not necessary for any arm of this statement
+               if (!prev_node) {
[...]
+               } else {
[...]

Signed-off-by: tiantao <tiantao6@huawei.com>
---
 drivers/acpi/acpica/nsaccess.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
index 2566e2d..7cef22a 100644
--- a/drivers/acpi/acpica/nsaccess.c
+++ b/drivers/acpi/acpica/nsaccess.c
@@ -109,11 +109,10 @@ acpi_status acpi_ns_root_initialize(void)
 		new_node->descriptor_type = ACPI_DESC_TYPE_NAMED;
 		new_node->type = init_val->type;
 
-		if (!prev_node) {
+		if (!prev_node)
 			acpi_gbl_root_node_struct.child = new_node;
-		} else {
+		else
 			prev_node->peer = new_node;
-		}
 
 		new_node->parent = &acpi_gbl_root_node_struct;
 		prev_node = new_node;
-- 
2.7.4

