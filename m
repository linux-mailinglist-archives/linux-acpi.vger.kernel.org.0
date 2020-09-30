Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1DED27EAA8
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Sep 2020 16:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbgI3OKA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Sep 2020 10:10:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14793 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730322AbgI3OKA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 30 Sep 2020 10:10:00 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8B57B4ED18E9292FB188;
        Wed, 30 Sep 2020 22:09:55 +0800 (CST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Wed, 30 Sep 2020 22:09:47 +0800
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <rafael@kernel.org>, Ingo Molnar <mingo@redhat.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, <linuxarm@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        "Sean V Kelley" <sean.v.kelley@linux.intel.com>,
        <linux-api@vger.kernel.org>, "Borislav Petkov" <bp@alien8.de>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v12 4/6] ACPI: HMAT: Fix handling of changes from ACPI 6.2 to ACPI 6.3
Date:   Wed, 30 Sep 2020 22:05:45 +0800
Message-ID: <20200930140547.840251-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200930140547.840251-1-Jonathan.Cameron@huawei.com>
References: <20200930140547.840251-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In ACPI 6.3, the Memory Proximity Domain Attributes Structure
changed substantially.  One of those changes was that the flag
for "Memory Proximity Domain field is valid" was deprecated.

This was because the field "Proximity Domain for the Memory"
became a required field and hence having a validity flag makes
no sense.

So the correct logic is to always assume the field is there.
Current code assumes it never is.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/acpi/numa/hmat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 2c32cfb72370..6a91a55229ae 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -424,7 +424,8 @@ static int __init hmat_parse_proximity_domain(union acpi_subtable_headers *heade
 		pr_info("HMAT: Memory Flags:%04x Processor Domain:%u Memory Domain:%u\n",
 			p->flags, p->processor_PD, p->memory_PD);
 
-	if (p->flags & ACPI_HMAT_MEMORY_PD_VALID && hmat_revision == 1) {
+	if ((hmat_revision == 1 && p->flags & ACPI_HMAT_MEMORY_PD_VALID) ||
+	    hmat_revision > 1) {
 		target = find_mem_target(p->memory_PD);
 		if (!target) {
 			pr_debug("HMAT: Memory Domain missing from SRAT\n");
-- 
2.19.1

