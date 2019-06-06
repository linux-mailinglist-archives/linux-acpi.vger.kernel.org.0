Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2906B381B7
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2019 01:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfFFXRf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Jun 2019 19:17:35 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:28164 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFFXRf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Jun 2019 19:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559863054; x=1591399054;
  h=to:from:cc:subject:message-id:date:mime-version:
   content-transfer-encoding;
  bh=4uyj4VvjwVuZUR34SxoHmEVzGoZJqgQBVlrePgPuIGM=;
  b=ILt6rmZgKX7T8QHoluCztTkdNKVb34AXVGSWFJn5HzlgNvETQozOIbQh
   q1ppVRVNKwFdo3O8KP4TmUUOOOMx8RkXEIeNpEY2Ijq2OxGDC/kkjYhr0
   YQq9yzabggpM+KTYgGMb/BMKM1jPIgxr4ix5pgaFBD/8UvrEz+fouS2pr
   w=;
X-IronPort-AV: E=Sophos;i="5.60,561,1549929600"; 
   d="scan'208";a="809063749"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2c-168cbb73.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 06 Jun 2019 23:17:31 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2c-168cbb73.us-west-2.amazon.com (Postfix) with ESMTPS id 0FF5EA2154;
        Thu,  6 Jun 2019 23:17:31 +0000 (UTC)
Received: from EX13D07EUB001.ant.amazon.com (10.43.166.214) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 6 Jun 2019 23:17:30 +0000
Received: from [10.85.96.144] (10.43.160.91) by EX13D07EUB001.ant.amazon.com
 (10.43.166.214) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 6 Jun
 2019 23:17:24 +0000
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>
From:   Zeev Zilberman <zeev@amazon.com>
CC:     <benh@kernel.crashing.org>, <ronenk@amazon.com>,
        Hanna Hawa <hhhawa@amazon.com>,
        "Aerov, Vladimir" <vaerov@amazon.com>, <barakw@amazon.com>,
        <dwmw@amazon.co.uk>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <talel@amazon.com>
Subject: [PATCH 1/1] irqchip/gic: Add support for Amazon Graviton variant of
 GICv3+GICv2m
Message-ID: <7f74e9e2-83d4-a69b-aef8-4964b3e43745@amazon.com>
Date:   Fri, 7 Jun 2019 02:17:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.91]
X-ClientProxiedBy: EX13D16UWB003.ant.amazon.com (10.43.161.194) To
 EX13D07EUB001.ant.amazon.com (10.43.166.214)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The patch adds support for Amazon Graviton custom variant of GICv2m, where
hw irq is encoded using the MSI message address, as opposed to standard
GICv2m, where hw irq is encoded in the MSI message data.
In addition, the Graviton flavor of GICv2m is used along GICv3 (and not
GICv2).

Signed-off-by: Zeev Zilberman <zeev@amazon.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 3c77ab6..eeed19f 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -56,6 +56,7 @@
 
 /* List of flags for specific v2m implementation */
 #define GICV2M_NEEDS_SPI_OFFSET		0x00000001
+#define GICV2M_GRAVITON_ADDRESS_ONLY	0x00000002
 
 static LIST_HEAD(v2m_nodes);
 static DEFINE_SPINLOCK(v2m_lock);
@@ -98,15 +99,26 @@ static struct msi_domain_info gicv2m_msi_domain_info = {
 	.chip	= &gicv2m_msi_irq_chip,
 };
 
+static phys_addr_t gicv2m_get_msi_addr(struct v2m_data *v2m, int hwirq)
+{
+	if (v2m->flags & GICV2M_GRAVITON_ADDRESS_ONLY)
+		return v2m->res.start | ((hwirq - 32) << 3);
+	else
+		return v2m->res.start + V2M_MSI_SETSPI_NS;
+}
+
 static void gicv2m_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	struct v2m_data *v2m = irq_data_get_irq_chip_data(data);
-	phys_addr_t addr = v2m->res.start + V2M_MSI_SETSPI_NS;
+	phys_addr_t addr = gicv2m_get_msi_addr(v2m, data->hwirq);
 
 	msg->address_hi = upper_32_bits(addr);
 	msg->address_lo = lower_32_bits(addr);
-	msg->data = data->hwirq;
 
+	if (v2m->flags & GICV2M_GRAVITON_ADDRESS_ONLY)
+		msg->data = 0;
+	else
+		msg->data = data->hwirq;
 	if (v2m->flags & GICV2M_NEEDS_SPI_OFFSET)
 		msg->data -= v2m->spi_offset;
 
@@ -188,7 +200,7 @@ static int gicv2m_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	hwirq = v2m->spi_start + offset;
 
 	err = iommu_dma_prepare_msi(info->desc,
-				    v2m->res.start + V2M_MSI_SETSPI_NS);
+				    gicv2m_get_msi_addr(v2m, hwirq));
 	if (err)
 		return err;
 
@@ -307,7 +319,7 @@ static int gicv2m_allocate_domains(struct irq_domain *parent)
 
 static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
 				  u32 spi_start, u32 nr_spis,
-				  struct resource *res)
+				  struct resource *res, u32 flags)
 {
 	int ret;
 	struct v2m_data *v2m;
@@ -320,6 +332,7 @@ static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
 
 	INIT_LIST_HEAD(&v2m->entry);
 	v2m->fwnode = fwnode;
+	v2m->flags = flags;
 
 	memcpy(&v2m->res, res, sizeof(struct resource));
 
@@ -334,7 +347,14 @@ static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
 		v2m->spi_start = spi_start;
 		v2m->nr_spis = nr_spis;
 	} else {
-		u32 typer = readl_relaxed(v2m->base + V2M_MSI_TYPER);
+		u32 typer;
+
+		/* Graviton should always have explicit spi_start/nr_spis */
+		if (v2m->flags & GICV2M_GRAVITON_ADDRESS_ONLY) {
+			ret = -EINVAL;
+			goto err_iounmap;
+		}
+		typer = readl_relaxed(v2m->base + V2M_MSI_TYPER);
 
 		v2m->spi_start = V2M_MSI_TYPER_BASE_SPI(typer);
 		v2m->nr_spis = V2M_MSI_TYPER_NUM_SPI(typer);
@@ -355,18 +375,21 @@ static int __init gicv2m_init_one(struct fwnode_handle *fwnode,
 	 *
 	 * Broadom NS2 GICv2m implementation has an erratum where the MSI data
 	 * is 'spi_number - 32'
+	 *
+	 * Reading that register fails on the Graviton implementation
 	 */
-	switch (readl_relaxed(v2m->base + V2M_MSI_IIDR)) {
-	case XGENE_GICV2M_MSI_IIDR:
-		v2m->flags |= GICV2M_NEEDS_SPI_OFFSET;
-		v2m->spi_offset = v2m->spi_start;
-		break;
-	case BCM_NS2_GICV2M_MSI_IIDR:
-		v2m->flags |= GICV2M_NEEDS_SPI_OFFSET;
-		v2m->spi_offset = 32;
-		break;
+	if (!(v2m->flags & GICV2M_GRAVITON_ADDRESS_ONLY)) {
+		switch (readl_relaxed(v2m->base + V2M_MSI_IIDR)) {
+		case XGENE_GICV2M_MSI_IIDR:
+			v2m->flags |= GICV2M_NEEDS_SPI_OFFSET;
+			v2m->spi_offset = v2m->spi_start;
+			break;
+		case BCM_NS2_GICV2M_MSI_IIDR:
+			v2m->flags |= GICV2M_NEEDS_SPI_OFFSET;
+			v2m->spi_offset = 32;
+			break;
+		}
 	}
-
 	v2m->bm = kcalloc(BITS_TO_LONGS(v2m->nr_spis), sizeof(long),
 			  GFP_KERNEL);
 	if (!v2m->bm) {
@@ -419,7 +442,8 @@ static int __init gicv2m_of_init(struct fwnode_handle *parent_handle,
 			pr_info("DT overriding V2M MSI_TYPER (base:%u, num:%u)\n",
 				spi_start, nr_spis);
 
-		ret = gicv2m_init_one(&child->fwnode, spi_start, nr_spis, &res);
+		ret = gicv2m_init_one(&child->fwnode, spi_start, nr_spis,
+				      &res, 0);
 		if (ret) {
 			of_node_put(child);
 			break;
@@ -451,6 +475,29 @@ static struct fwnode_handle *gicv2m_get_fwnode(struct device *dev)
 	return data->fwnode;
 }
 
+#ifdef CONFIG_ACPI
+static bool acpi_check_amazon_graviton_quirks(void)
+{
+	static struct acpi_table_madt *madt;
+	acpi_status status;
+	bool rc = false;
+
+#define ACPI_AMZN_OEM_ID		"AMAZON"
+
+	status = acpi_get_table(ACPI_SIG_MADT, 0,
+				(struct acpi_table_header **)&madt);
+
+	if (ACPI_FAILURE(status) || !madt)
+		return rc;
+	rc = !memcmp(madt->header.oem_id, ACPI_AMZN_OEM_ID, ACPI_OEM_ID_SIZE);
+	acpi_put_table((struct acpi_table_header *)madt);
+
+	return rc;
+}
+#else
+static inline bool acpi_check_amazon_graviton_quirks(void) { return false; }
+#endif
+
 static int __init
 acpi_parse_madt_msi(union acpi_subtable_headers *header,
 		    const unsigned long end)
@@ -460,6 +507,7 @@ acpi_parse_madt_msi(union acpi_subtable_headers *header,
 	u32 spi_start = 0, nr_spis = 0;
 	struct acpi_madt_generic_msi_frame *m;
 	struct fwnode_handle *fwnode;
+	u32 flags = 0;
 
 	m = (struct acpi_madt_generic_msi_frame *)header;
 	if (BAD_MADT_ENTRY(m, end))
@@ -469,6 +517,13 @@ acpi_parse_madt_msi(union acpi_subtable_headers *header,
 	res.end = m->base_address + SZ_4K - 1;
 	res.flags = IORESOURCE_MEM;
 
+	if (acpi_check_amazon_graviton_quirks()) {
+		pr_info("applying Amazon Graviton quirk\n");
+		res.end = res.start + SZ_8K - 1;
+		flags |= GICV2M_GRAVITON_ADDRESS_ONLY;
+		gicv2m_msi_domain_info.flags &= ~MSI_FLAG_MULTI_PCI_MSI;
+	}
+
 	if (m->flags & ACPI_MADT_OVERRIDE_SPI_VALUES) {
 		spi_start = m->spi_base;
 		nr_spis = m->spi_count;
@@ -483,7 +538,7 @@ acpi_parse_madt_msi(union acpi_subtable_headers *header,
 		return -EINVAL;
 	}
 
-	ret = gicv2m_init_one(fwnode, spi_start, nr_spis, &res);
+	ret = gicv2m_init_one(fwnode, spi_start, nr_spis, &res, flags);
 	if (ret)
 		irq_domain_free_fwnode(fwnode);
 
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index f44cd89..1282f81 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1343,6 +1343,9 @@ static int __init gic_init_bases(void __iomem *dist_base,
 	if (gic_dist_supports_lpis()) {
 		its_init(handle, &gic_data.rdists, gic_data.domain);
 		its_cpu_init();
+	} else {
+		if (IS_ENABLED(CONFIG_ARM_GIC_V2M))
+			gicv2m_init(handle, gic_data.domain);
 	}
 
 	if (gic_prio_masking_enabled()) {
diff --git a/include/linux/irqchip/arm-gic-common.h b/include/linux/irqchip/arm-gic-common.h
index 9a1a479..62a8821 100644
--- a/include/linux/irqchip/arm-gic-common.h
+++ b/include/linux/irqchip/arm-gic-common.h
@@ -39,4 +39,9 @@ struct gic_kvm_info {
 
 const struct gic_kvm_info *gic_get_kvm_info(void);
 
+struct irq_domain;
+struct fwnode_handle;
+int gicv2m_init(struct fwnode_handle *parent_handle,
+		struct irq_domain *parent);
+
 #endif /* __LINUX_IRQCHIP_ARM_GIC_COMMON_H */
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 0f049b3..7bd3bc6 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -160,9 +160,6 @@ int gic_of_init_child(struct device *dev, struct gic_chip_data **gic, int irq);
  */
 void gic_init(void __iomem *dist , void __iomem *cpu);
 
-int gicv2m_init(struct fwnode_handle *parent_handle,
-		struct irq_domain *parent);
-
 void gic_send_sgi(unsigned int cpu_id, unsigned int irq);
 int gic_get_cpu_id(unsigned int cpu);
 void gic_migrate_target(unsigned int new_cpu_id);
-- 
2.7.4
