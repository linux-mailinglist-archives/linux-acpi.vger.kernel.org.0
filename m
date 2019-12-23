Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBCD412939C
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Dec 2019 10:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfLWJ20 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Dec 2019 04:28:26 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7729 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726059AbfLWJ20 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 23 Dec 2019 04:28:26 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E6CCE65D4C28A1E9BEFB;
        Mon, 23 Dec 2019 17:28:23 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Mon, 23 Dec 2019 17:28:17 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Pankaj Bansal" <pankaj.bansal@nxp.com>,
        Erik Schmauss <erik.schmauss@intel.com>
CC:     <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [RFC PATCH 1/2] ACPICA/IORT: Correct the comment for id_count
Date:   Mon, 23 Dec 2019 17:23:16 +0800
Message-ID: <1577092997-9852-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In IORT spec
(http://infocenter.arm.com/help/topic/com.arm.doc.den0049d/DEN0049D_IO_Remapping_Table.pdf),
id_num means Number of IDs minus one, update the comment.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---

This patch just for comments, needs to be upstream in ACPICA first.

 include/acpi/actbl2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index e45ced2..382642f 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -104,7 +104,7 @@ enum acpi_iort_node_type {
 
 struct acpi_iort_id_mapping {
 	u32 input_base;		/* Lowest value in input range */
-	u32 id_count;		/* Number of IDs */
+	u32 id_count;		/* Number of IDs in the range minus one */
 	u32 output_base;	/* Lowest value in output range */
 	u32 output_reference;	/* A reference to the output node */
 	u32 flags;
-- 
1.7.12.4

