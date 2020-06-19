Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8252003AB
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Jun 2020 10:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731243AbgFSIXl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 Jun 2020 04:23:41 -0400
Received: from foss.arm.com ([217.140.110.172]:47128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731288AbgFSIVH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 19 Jun 2020 04:21:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DC7813A1;
        Fri, 19 Jun 2020 01:20:59 -0700 (PDT)
Received: from red-moon.arm.com (unknown [10.57.58.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7EF53F71F;
        Fri, 19 Jun 2020 01:20:56 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Diana Craciun <diana.craciun@oss.nxp.com>,
        iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Joerg Roedel <joro@8bytes.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2 11/12] bus/fsl-mc: Refactor the MSI domain creation in the DPRC driver
Date:   Fri, 19 Jun 2020 09:20:12 +0100
Message-Id: <20200619082013.13661-12-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Diana Craciun <diana.craciun@oss.nxp.com>

The DPRC driver is not taking into account the msi-map property
and assumes that the icid is the same as the stream ID. Although
this assumption is correct, generalize the code to include a
translation between icid and streamID.

Furthermore do not just copy the MSI domain from parent (for child
containers), but use the information provided by the msi-map property.

If the msi-map property is missing from the device tree retain the old
behaviour for backward compatibility ie the child DPRC objects
inherit the MSI domain from the parent.

Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
---
 drivers/bus/fsl-mc/dprc-driver.c            | 31 ++++++---------------
 drivers/bus/fsl-mc/fsl-mc-bus.c             |  4 +--
 drivers/bus/fsl-mc/fsl-mc-msi.c             | 31 +++++++++++++--------
 drivers/bus/fsl-mc/fsl-mc-private.h         |  6 ++--
 drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c | 15 +++++++++-
 5 files changed, 47 insertions(+), 40 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index c8b1c3842c1a..189bff2115a8 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -592,6 +592,7 @@ static int dprc_probe(struct fsl_mc_device *mc_dev)
 	bool mc_io_created = false;
 	bool msi_domain_set = false;
 	u16 major_ver, minor_ver;
+	struct irq_domain *mc_msi_domain;
 
 	if (!is_fsl_mc_bus_dprc(mc_dev))
 		return -EINVAL;
@@ -621,31 +622,15 @@ static int dprc_probe(struct fsl_mc_device *mc_dev)
 			return error;
 
 		mc_io_created = true;
+	}
 
-		/*
-		 * Inherit parent MSI domain:
-		 */
-		dev_set_msi_domain(&mc_dev->dev,
-				   dev_get_msi_domain(parent_dev));
-		msi_domain_set = true;
+	mc_msi_domain = fsl_mc_find_msi_domain(&mc_dev->dev);
+	if (!mc_msi_domain) {
+		dev_warn(&mc_dev->dev,
+			 "WARNING: MC bus without interrupt support\n");
 	} else {
-		/*
-		 * This is a root DPRC
-		 */
-		struct irq_domain *mc_msi_domain;
-
-		if (dev_is_fsl_mc(parent_dev))
-			return -EINVAL;
-
-		error = fsl_mc_find_msi_domain(parent_dev,
-					       &mc_msi_domain);
-		if (error < 0) {
-			dev_warn(&mc_dev->dev,
-				 "WARNING: MC bus without interrupt support\n");
-		} else {
-			dev_set_msi_domain(&mc_dev->dev, mc_msi_domain);
-			msi_domain_set = true;
-		}
+		dev_set_msi_domain(&mc_dev->dev, mc_msi_domain);
+		msi_domain_set = true;
 	}
 
 	error = dprc_open(mc_dev->mc_io, 0, mc_dev->obj_desc.id,
diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 8ead3f0238f2..824ff77bbe86 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -370,8 +370,8 @@ EXPORT_SYMBOL_GPL(fsl_mc_get_version);
 /**
  * fsl_mc_get_root_dprc - function to traverse to the root dprc
  */
-static void fsl_mc_get_root_dprc(struct device *dev,
-				 struct device **root_dprc_dev)
+void fsl_mc_get_root_dprc(struct device *dev,
+			 struct device **root_dprc_dev)
 {
 	if (!dev) {
 		*root_dprc_dev = NULL;
diff --git a/drivers/bus/fsl-mc/fsl-mc-msi.c b/drivers/bus/fsl-mc/fsl-mc-msi.c
index 8b9c66d7c4ff..e7bbff445a83 100644
--- a/drivers/bus/fsl-mc/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -177,23 +177,30 @@ struct irq_domain *fsl_mc_msi_create_irq_domain(struct fwnode_handle *fwnode,
 	return domain;
 }
 
-int fsl_mc_find_msi_domain(struct device *mc_platform_dev,
-			   struct irq_domain **mc_msi_domain)
+struct irq_domain *fsl_mc_find_msi_domain(struct device *dev)
 {
-	struct irq_domain *msi_domain;
-	struct device_node *mc_of_node = mc_platform_dev->of_node;
+	struct irq_domain *msi_domain = NULL;
+	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
 
-	msi_domain = of_msi_get_domain(mc_platform_dev, mc_of_node,
-				       DOMAIN_BUS_FSL_MC_MSI);
-	if (!msi_domain) {
-		pr_err("Unable to find fsl-mc MSI domain for %pOF\n",
-		       mc_of_node);
+	msi_domain = of_msi_map_get_device_domain(dev, mc_dev->icid,
+						  DOMAIN_BUS_FSL_MC_MSI);
 
-		return -ENOENT;
+	/*
+	 * if the msi-map property is missing assume that all the
+	 * child containers inherit the domain from the parent
+	 */
+	if (!msi_domain) {
+		struct device *root_dprc_dev;
+		struct device *bus_dev;
+
+		fsl_mc_get_root_dprc(dev, &root_dprc_dev);
+		bus_dev = root_dprc_dev->parent;
+		msi_domain = of_msi_get_domain(bus_dev,
+					       bus_dev->of_node,
+					       DOMAIN_BUS_FSL_MC_MSI);
 	}
 
-	*mc_msi_domain = msi_domain;
-	return 0;
+	return msi_domain;
 }
 
 static void fsl_mc_msi_free_descs(struct device *dev)
diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
index 21ca8c756ee7..7a46a12eb747 100644
--- a/drivers/bus/fsl-mc/fsl-mc-private.h
+++ b/drivers/bus/fsl-mc/fsl-mc-private.h
@@ -595,8 +595,7 @@ int fsl_mc_msi_domain_alloc_irqs(struct device *dev,
 
 void fsl_mc_msi_domain_free_irqs(struct device *dev);
 
-int fsl_mc_find_msi_domain(struct device *mc_platform_dev,
-			   struct irq_domain **mc_msi_domain);
+struct irq_domain *fsl_mc_find_msi_domain(struct device *dev);
 
 int fsl_mc_populate_irq_pool(struct fsl_mc_bus *mc_bus,
 			     unsigned int irq_count);
@@ -613,6 +612,9 @@ void fsl_destroy_mc_io(struct fsl_mc_io *mc_io);
 
 bool fsl_mc_is_root_dprc(struct device *dev);
 
+void fsl_mc_get_root_dprc(struct device *dev,
+			 struct device **root_dprc_dev);
+
 struct fsl_mc_device *fsl_mc_device_lookup(struct fsl_mc_obj_desc *obj_desc,
 					   struct fsl_mc_device *mc_bus_dev);
 
diff --git a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
index 606efa64adff..a5c8d577e424 100644
--- a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
@@ -23,6 +23,18 @@ static struct irq_chip its_msi_irq_chip = {
 	.irq_set_affinity = msi_domain_set_affinity
 };
 
+static u32 fsl_mc_msi_domain_get_msi_id(struct irq_domain *domain,
+					struct fsl_mc_device *mc_dev)
+{
+	struct device_node *of_node;
+	u32 out_id;
+
+	of_node = irq_domain_get_of_node(domain);
+	out_id = of_msi_map_id(&mc_dev->dev, of_node, mc_dev->icid);
+
+	return out_id;
+}
+
 static int its_fsl_mc_msi_prepare(struct irq_domain *msi_domain,
 				  struct device *dev,
 				  int nvec, msi_alloc_info_t *info)
@@ -43,7 +55,8 @@ static int its_fsl_mc_msi_prepare(struct irq_domain *msi_domain,
 	 * NOTE: This device id corresponds to the IOMMU stream ID
 	 * associated with the DPRC object (ICID).
 	 */
-	info->scratchpad[0].ul = mc_bus_dev->icid;
+	info->scratchpad[0].ul = fsl_mc_msi_domain_get_msi_id(msi_domain,
+							      mc_bus_dev);
 	msi_info = msi_get_domain_info(msi_domain->parent);
 
 	/* Allocate at least 32 MSIs, and always as a power of 2 */
-- 
2.26.1

