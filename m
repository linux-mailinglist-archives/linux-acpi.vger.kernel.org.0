Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF83FFB13
	for <lists+linux-acpi@lfdr.de>; Sun, 17 Nov 2019 18:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfKQR7H (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 17 Nov 2019 12:59:07 -0500
Received: from mga02.intel.com ([134.134.136.20]:25873 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfKQR7H (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 17 Nov 2019 12:59:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 09:59:06 -0800
X-IronPort-AV: E=Sophos;i="5.68,317,1569308400"; 
   d="scan'208";a="380437256"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 09:59:06 -0800
Subject: [PATCH v2 03/18] libnvdimm: Move nd_device_attribute_group to
 device_type
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oliver O'Halloran <oohall@gmail.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        peterz@infradead.org, dave.hansen@linux.intel.com, hch@lst.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Date:   Sun, 17 Nov 2019 09:44:50 -0800
Message-ID: <157401269020.43284.13207298434196987268.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157401267421.43284.2135775608523385279.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157401267421.43284.2135775608523385279.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

A 'struct device_type' instance can carry default attributes for the
device. Use this facility to remove the export of
nd_device_attribute_group and put the responsibility on the core rather
than leaf implementations to define this attribute.

For regions this creates a new nd_region_attribute_groups[] added to the
per-region device-type instances.

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Oliver O'Halloran" <oohall@gmail.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Link: https://lore.kernel.org/r/157309901138.1582359.12909354140826530394.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/powerpc/platforms/pseries/papr_scm.c |    2 --
 drivers/acpi/nfit/core.c                  |    2 --
 drivers/nvdimm/bus.c                      |    3 +--
 drivers/nvdimm/dimm_devs.c                |    8 +++++++-
 drivers/nvdimm/e820.c                     |    1 -
 drivers/nvdimm/nd.h                       |    1 +
 drivers/nvdimm/of_pmem.c                  |    1 -
 drivers/nvdimm/region_devs.c              |   18 +++++++++++++-----
 include/linux/libnvdimm.h                 |    1 -
 9 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 61883291defc..04726f8fd189 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -286,7 +286,6 @@ int papr_scm_ndctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 
 static const struct attribute_group *region_attr_groups[] = {
 	&nd_region_attribute_group,
-	&nd_device_attribute_group,
 	&nd_mapping_attribute_group,
 	&nd_numa_attribute_group,
 	NULL,
@@ -299,7 +298,6 @@ static const struct attribute_group *bus_attr_groups[] = {
 
 static const struct attribute_group *papr_scm_dimm_groups[] = {
 	&nvdimm_attribute_group,
-	&nd_device_attribute_group,
 	NULL,
 };
 
diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 14e68f202f81..dec7c2b08672 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1699,7 +1699,6 @@ static const struct attribute_group acpi_nfit_dimm_attribute_group = {
 
 static const struct attribute_group *acpi_nfit_dimm_attribute_groups[] = {
 	&nvdimm_attribute_group,
-	&nd_device_attribute_group,
 	&acpi_nfit_dimm_attribute_group,
 	NULL,
 };
@@ -2199,7 +2198,6 @@ static const struct attribute_group acpi_nfit_region_attribute_group = {
 static const struct attribute_group *acpi_nfit_region_attribute_groups[] = {
 	&nd_region_attribute_group,
 	&nd_mapping_attribute_group,
-	&nd_device_attribute_group,
 	&nd_numa_attribute_group,
 	&acpi_nfit_region_attribute_group,
 	NULL,
diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index d47412dcdf38..eb422527dd57 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -669,10 +669,9 @@ static struct attribute *nd_device_attributes[] = {
 /*
  * nd_device_attribute_group - generic attributes for all devices on an nd bus
  */
-struct attribute_group nd_device_attribute_group = {
+const struct attribute_group nd_device_attribute_group = {
 	.attrs = nd_device_attributes,
 };
-EXPORT_SYMBOL_GPL(nd_device_attribute_group);
 
 static ssize_t numa_node_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index 196aa44c4936..278867c68682 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -202,9 +202,15 @@ static void nvdimm_release(struct device *dev)
 	kfree(nvdimm);
 }
 
-static struct device_type nvdimm_device_type = {
+static const struct attribute_group *nvdimm_attribute_groups[] = {
+	&nd_device_attribute_group,
+	NULL,
+};
+
+static const struct device_type nvdimm_device_type = {
 	.name = "nvdimm",
 	.release = nvdimm_release,
+	.groups = nvdimm_attribute_groups,
 };
 
 bool is_nvdimm(struct device *dev)
diff --git a/drivers/nvdimm/e820.c b/drivers/nvdimm/e820.c
index 87f72f725e4f..adde2864c6a4 100644
--- a/drivers/nvdimm/e820.c
+++ b/drivers/nvdimm/e820.c
@@ -15,7 +15,6 @@ static const struct attribute_group *e820_pmem_attribute_groups[] = {
 
 static const struct attribute_group *e820_pmem_region_attribute_groups[] = {
 	&nd_region_attribute_group,
-	&nd_device_attribute_group,
 	NULL,
 };
 
diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index d83dd34cd169..21e018bfa188 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -239,6 +239,7 @@ int __init nd_label_init(void);
 void nvdimm_exit(void);
 void nd_region_exit(void);
 struct nvdimm;
+extern const struct attribute_group nd_device_attribute_group;
 struct nvdimm_drvdata *to_ndd(struct nd_mapping *nd_mapping);
 int nvdimm_check_config_data(struct device *dev);
 int nvdimm_init_nsarea(struct nvdimm_drvdata *ndd);
diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
index 97187d6c0bdb..41348fa6b74c 100644
--- a/drivers/nvdimm/of_pmem.c
+++ b/drivers/nvdimm/of_pmem.c
@@ -11,7 +11,6 @@
 
 static const struct attribute_group *region_attr_groups[] = {
 	&nd_region_attribute_group,
-	&nd_device_attribute_group,
 	NULL,
 };
 
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index e89f2eb3678c..710b5111eaa8 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -763,19 +763,27 @@ struct attribute_group nd_region_attribute_group = {
 };
 EXPORT_SYMBOL_GPL(nd_region_attribute_group);
 
-static struct device_type nd_blk_device_type = {
+static const struct attribute_group *nd_region_attribute_groups[] = {
+	&nd_device_attribute_group,
+	NULL,
+};
+
+static const struct device_type nd_blk_device_type = {
 	.name = "nd_blk",
 	.release = nd_region_release,
+	.groups = nd_region_attribute_groups,
 };
 
-static struct device_type nd_pmem_device_type = {
+static const struct device_type nd_pmem_device_type = {
 	.name = "nd_pmem",
 	.release = nd_region_release,
+	.groups = nd_region_attribute_groups,
 };
 
-static struct device_type nd_volatile_device_type = {
+static const struct device_type nd_volatile_device_type = {
 	.name = "nd_volatile",
 	.release = nd_region_release,
+	.groups = nd_region_attribute_groups,
 };
 
 bool is_nd_pmem(struct device *dev)
@@ -931,8 +939,8 @@ void nd_region_release_lane(struct nd_region *nd_region, unsigned int lane)
 EXPORT_SYMBOL(nd_region_release_lane);
 
 static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
-		struct nd_region_desc *ndr_desc, struct device_type *dev_type,
-		const char *caller)
+		struct nd_region_desc *ndr_desc,
+		const struct device_type *dev_type, const char *caller)
 {
 	struct nd_region *nd_region;
 	struct device *dev;
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index b6eddf912568..d7dbf42498af 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -67,7 +67,6 @@ enum {
 
 extern struct attribute_group nvdimm_bus_attribute_group;
 extern struct attribute_group nvdimm_attribute_group;
-extern struct attribute_group nd_device_attribute_group;
 extern struct attribute_group nd_numa_attribute_group;
 extern struct attribute_group nd_region_attribute_group;
 extern struct attribute_group nd_mapping_attribute_group;

