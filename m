Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18670FFB16
	for <lists+linux-acpi@lfdr.de>; Sun, 17 Nov 2019 18:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfKQR7N (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 17 Nov 2019 12:59:13 -0500
Received: from mga12.intel.com ([192.55.52.136]:20600 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfKQR7M (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 17 Nov 2019 12:59:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 09:59:11 -0800
X-IronPort-AV: E=Sophos;i="5.68,317,1569308400"; 
   d="scan'208";a="356581336"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 09:59:11 -0800
Subject: [PATCH v2 04/18] libnvdimm: Move nd_numa_attribute_group to
 device_type
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oliver O'Halloran <oohall@gmail.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        peterz@infradead.org, dave.hansen@linux.intel.com, hch@lst.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Date:   Sun, 17 Nov 2019 09:44:55 -0800
Message-ID: <157401269537.43284.14411189404186877352.stgit@dwillia2-desk3.amr.corp.intel.com>
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
nd_numa_attribute_group and put the responsibility on the core rather
than leaf implementations to define this attribute.

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Oliver O'Halloran" <oohall@gmail.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Link: https://lore.kernel.org/r/157309901655.1582359.18126990555058555754.stgit@dwillia2-desk3.amr.corp.intel.com
---
 arch/powerpc/platforms/pseries/papr_scm.c |    1 -
 drivers/acpi/nfit/core.c                  |    1 -
 drivers/nvdimm/bus.c                      |    3 +--
 drivers/nvdimm/nd.h                       |    1 +
 drivers/nvdimm/region_devs.c              |    1 +
 include/linux/libnvdimm.h                 |    1 -
 6 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 04726f8fd189..6ffda03a6349 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -287,7 +287,6 @@ int papr_scm_ndctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 static const struct attribute_group *region_attr_groups[] = {
 	&nd_region_attribute_group,
 	&nd_mapping_attribute_group,
-	&nd_numa_attribute_group,
 	NULL,
 };
 
diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index dec7c2b08672..b3213faf37b5 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2198,7 +2198,6 @@ static const struct attribute_group acpi_nfit_region_attribute_group = {
 static const struct attribute_group *acpi_nfit_region_attribute_groups[] = {
 	&nd_region_attribute_group,
 	&nd_mapping_attribute_group,
-	&nd_numa_attribute_group,
 	&acpi_nfit_region_attribute_group,
 	NULL,
 };
diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index eb422527dd57..28e1b265aa63 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -697,11 +697,10 @@ static umode_t nd_numa_attr_visible(struct kobject *kobj, struct attribute *a,
 /*
  * nd_numa_attribute_group - NUMA attributes for all devices on an nd bus
  */
-struct attribute_group nd_numa_attribute_group = {
+const struct attribute_group nd_numa_attribute_group = {
 	.attrs = nd_numa_attributes,
 	.is_visible = nd_numa_attr_visible,
 };
-EXPORT_SYMBOL_GPL(nd_numa_attribute_group);
 
 int nvdimm_bus_create_ndctl(struct nvdimm_bus *nvdimm_bus)
 {
diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index 21e018bfa188..ec3d5f619957 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -240,6 +240,7 @@ void nvdimm_exit(void);
 void nd_region_exit(void);
 struct nvdimm;
 extern const struct attribute_group nd_device_attribute_group;
+extern const struct attribute_group nd_numa_attribute_group;
 struct nvdimm_drvdata *to_ndd(struct nd_mapping *nd_mapping);
 int nvdimm_check_config_data(struct device *dev);
 int nvdimm_init_nsarea(struct nvdimm_drvdata *ndd);
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 710b5111eaa8..e4281f806adc 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -765,6 +765,7 @@ EXPORT_SYMBOL_GPL(nd_region_attribute_group);
 
 static const struct attribute_group *nd_region_attribute_groups[] = {
 	&nd_device_attribute_group,
+	&nd_numa_attribute_group,
 	NULL,
 };
 
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index d7dbf42498af..e9a4e25fc708 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -67,7 +67,6 @@ enum {
 
 extern struct attribute_group nvdimm_bus_attribute_group;
 extern struct attribute_group nvdimm_attribute_group;
-extern struct attribute_group nd_numa_attribute_group;
 extern struct attribute_group nd_region_attribute_group;
 extern struct attribute_group nd_mapping_attribute_group;
 

