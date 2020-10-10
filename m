Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32A628A373
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Oct 2020 01:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390348AbgJJW5E (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 10 Oct 2020 18:57:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732640AbgJJTyo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 10 Oct 2020 15:54:44 -0400
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3131207E8;
        Sat, 10 Oct 2020 09:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602322342;
        bh=DUFG9J5AcMUp5irs8D9SHdYwSl2ByabA6T3c+hN4CVY=;
        h=From:To:Cc:Subject:Date:From;
        b=GJ5OYii0BaygS11g+Z6ee8RaWcjnixsYYvsUJKQGUxO/BdpQOw4G09yOMHY5HoCRA
         M65wYXKWIo/riUMFq7QaRXd08nGtjbbhUGmLJr5C6SPlQwWgrHq6ER8UiKpNCu+pSP
         M8lC6kbn1BJSczr7AD8BI0BIXlA8DHWAv09gT2dg=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-acpi@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH] arm64: mm: set ZONE_DMA size based on early IORT scan
Date:   Sat, 10 Oct 2020 11:31:53 +0200
Message-Id: <20201010093153.30177-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

We recently introduced a 1 GB sized ZONE_DMA to cater for platforms
incorporating masters that can address less than 32 bits of DMA, in
particular the Raspberry Pi 4, which has 4 or 8 GB of DRAM, but has
peripherals that can only address up to 1 GB (and its PCIe host
bridge can only access the bottom 3 GB)

Instructing the DMA layer about these limitations is straight-forward,
even though we had to fix some issues regarding memory limits set in
the IORT for named components, and regarding the handling of ACPI _DMA
methods. However, the DMA layer also needs to be able to allocate
memory that is guaranteed to meet those DMA constraints, for bounce
buffering as well as allocating the backing for consistent mappings.

This is why the 1 GB ZONE_DMA was introduced recently. Unfortunately,
it turns out the having a 1 GB ZONE_DMA as well as a ZONE_DMA32 causes
problems with kdump, and potentially in other places where allocations
cannot cross zone boundaries. Therefore, we should avoid having two
separate DMA zones when possible.

So let's do an early scan of the IORT, and only create the ZONE_DMA
if we encounter any devices that need it. This puts the burden on
the firmware to describe such limitations in the IORT, which may be
redundant (and less precise) if _DMA methods are also being provided.
However, it should be noted that this situation is highly unusual for
arm64 ACPI machines. Also, the DMA subsystem still gives precedence to
the _DMA method if implemented, and so we will not lose the ability to
perform streaming DMA outside the ZONE_DMA if the _DMA method permits
it.

Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
This is related to the discussion in 

https://lore.kernel.org/linux-arm-kernel/20201001161740.29064-2-nsaenzjulienne@suse.de/

 Documentation/arm64/arm-acpi.rst |  7 +++
 arch/arm64/mm/init.c             |  8 +++
 drivers/acpi/arm64/iort.c        | 51 ++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/Documentation/arm64/arm-acpi.rst b/Documentation/arm64/arm-acpi.rst
index 47ecb9930dde..947f5b5c45ef 100644
--- a/Documentation/arm64/arm-acpi.rst
+++ b/Documentation/arm64/arm-acpi.rst
@@ -205,6 +205,13 @@ devices available.  This list of tables is not meant to be all inclusive;
 in some environments other tables may be needed (e.g., any of the APEI
 tables from section 18) to support specific functionality.
 
+It is assumed that all DMA capable devices in the system are able to
+access the lowest 4 GB of system memory. If this is not the case, an
+IORT describing those limitations is mandatory, even if an IORT is not
+otherwise necessary to describe the I/O topology, and regardless of
+whether _DMA methods are used to describe the DMA limitations more
+precisely. Once the system has booted, _DMA methods will take precedence
+over DMA addressing limits described in the IORT.
 
 ACPI Detection
 --------------
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index f0599ae73b8d..829fa63c3d72 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -191,6 +191,14 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
 
 #ifdef CONFIG_ZONE_DMA
+	if (IS_ENABLED(CONFIG_ACPI)) {
+		extern unsigned int acpi_iort_get_zone_dma_size(void);
+
+		zone_dma_bits = min(zone_dma_bits,
+				    acpi_iort_get_zone_dma_size());
+		arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
+	}
+
 	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
 #endif
 #ifdef CONFIG_ZONE_DMA32
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index ec782e4a0fe4..c3db44896e49 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1722,3 +1722,54 @@ void __init acpi_iort_init(void)
 
 	iort_init_platform_devices();
 }
+
+#ifdef CONFIG_ZONE_DMA
+/*
+ * Check the IORT whether any devices exist whose DMA mask is < 32 bits.
+ * If so, return the smallest value encountered, or 32 otherwise.
+ */
+unsigned int __init acpi_iort_get_zone_dma_size(void)
+{
+	struct acpi_table_iort *iort;
+	struct acpi_iort_node *node, *end;
+	acpi_status status;
+	u8 limit = 32;
+	int i;
+
+	if (acpi_disabled)
+		return limit;
+
+	status = acpi_get_table(ACPI_SIG_IORT, 0,
+				(struct acpi_table_header **)&iort);
+	if (ACPI_FAILURE(status))
+		return limit;
+
+	node = ACPI_ADD_PTR(struct acpi_iort_node, iort, iort->node_offset);
+	end = ACPI_ADD_PTR(struct acpi_iort_node, iort, iort->header.length);
+
+	for (i = 0; i < iort->node_count; i++) {
+		if (node >= end)
+			break;
+
+		switch (node->type) {
+			struct acpi_iort_named_component *ncomp;
+			struct acpi_iort_root_complex *rc;
+
+		case ACPI_IORT_NODE_NAMED_COMPONENT:
+			ncomp = (struct acpi_iort_named_component *)node->node_data;
+			if (ncomp->memory_address_limit)
+				limit = min(limit, ncomp->memory_address_limit);
+			break;
+
+		case ACPI_IORT_NODE_PCI_ROOT_COMPLEX:
+			rc = (struct acpi_iort_root_complex *)node->node_data;
+			if (rc->memory_address_limit);
+				limit = min(limit, rc->memory_address_limit);
+			break;
+		}
+		node = ACPI_ADD_PTR(struct acpi_iort_node, node, node->length);
+	}
+	acpi_put_table(&iort->header);
+	return limit;
+}
+#endif
-- 
2.17.1

