Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8084E248C79
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Aug 2020 19:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgHRRGj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 Aug 2020 13:06:39 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2658 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728532AbgHRRGj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Aug 2020 13:06:39 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id CFA31B454DC57785B1B3;
        Tue, 18 Aug 2020 18:06:37 +0100 (IST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Tue, 18 Aug 2020 18:06:37 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, <linuxarm@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Sean V Kelley <sean.v.kelley@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v8 4/6] ACPI: HMAT: Fix handling of changes from ACPI 6.2 to ACPI 6.3
Date:   Wed, 19 Aug 2020 01:04:15 +0800
Message-ID: <20200818170417.1515975-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200818170417.1515975-1-Jonathan.Cameron@huawei.com>
References: <20200818170417.1515975-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-ClientProxiedBy: lhreml702-chm.china.huawei.com (10.201.108.51) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
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
 drivers/acpi/numa/hmat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 2c32cfb72370..07cfe50136e0 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -424,7 +424,7 @@ static int __init hmat_parse_proximity_domain(union acpi_subtable_headers *heade
 		pr_info("HMAT: Memory Flags:%04x Processor Domain:%u Memory Domain:%u\n",
 			p->flags, p->processor_PD, p->memory_PD);
 
-	if (p->flags & ACPI_HMAT_MEMORY_PD_VALID && hmat_revision == 1) {
+	if ((p->flags & ACPI_HMAT_MEMORY_PD_VALID && hmat_revision == 1) || hmat_revision == 2) {
 		target = find_mem_target(p->memory_PD);
 		if (!target) {
 			pr_debug("HMAT: Memory Domain missing from SRAT\n");
-- 
2.19.1

