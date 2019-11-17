Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35591FFB1C
	for <lists+linux-acpi@lfdr.de>; Sun, 17 Nov 2019 18:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfKQR7X (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 17 Nov 2019 12:59:23 -0500
Received: from mga04.intel.com ([192.55.52.120]:23111 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfKQR7W (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 17 Nov 2019 12:59:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 09:59:22 -0800
X-IronPort-AV: E=Sophos;i="5.68,317,1569308400"; 
   d="scan'208";a="217631921"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 09:59:21 -0800
Subject: [PATCH v2 06/18] libnvdimm: Move nd_mapping_attribute_group to
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
Date:   Sun, 17 Nov 2019 09:45:05 -0800
Message-ID: <157401270566.43284.8963531428718028531.stgit@dwillia2-desk3.amr.corp.intel.com>
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
nd_mapping_attribute_group and put the responsibility on the core rather
than leaf implementations to define this attribute.

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Oliver O'Halloran" <oohall@gmail.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Link: https://lore.kernel.org/r/157309902686.1582359.6749533709859492704.stgit@dwillia2-desk3.amr.corp.intel.com
---
 arch/powerpc/platforms/pseries/papr_scm.c |    6 ------
 drivers/acpi/nfit/core.c                  |    1 -
 drivers/nvdimm/region_devs.c              |    4 ++--
 include/linux/libnvdimm.h                 |    1 -
 4 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 6428834d7cd5..0405fb769336 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -284,11 +284,6 @@ int papr_scm_ndctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 	return 0;
 }
 
-static const struct attribute_group *region_attr_groups[] = {
-	&nd_mapping_attribute_group,
-	NULL,
-};
-
 static const struct attribute_group *bus_attr_groups[] = {
 	&nvdimm_bus_attribute_group,
 	NULL,
@@ -362,7 +357,6 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
 	mapping.size = p->blocks * p->block_size; // XXX: potential overflow?
 
 	memset(&ndr_desc, 0, sizeof(ndr_desc));
-	ndr_desc.attr_groups = region_attr_groups;
 	target_nid = dev_to_node(&p->pdev->dev);
 	online_nid = papr_scm_node(target_nid);
 	ndr_desc.numa_node = online_nid;
diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 99e20b8b6ea0..69c406ecc3a6 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2196,7 +2196,6 @@ static const struct attribute_group acpi_nfit_region_attribute_group = {
 };
 
 static const struct attribute_group *acpi_nfit_region_attribute_groups[] = {
-	&nd_mapping_attribute_group,
 	&acpi_nfit_region_attribute_group,
 	NULL,
 };
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index f97166583294..0afc1973e938 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -751,11 +751,10 @@ static struct attribute *mapping_attributes[] = {
 	NULL,
 };
 
-struct attribute_group nd_mapping_attribute_group = {
+static const struct attribute_group nd_mapping_attribute_group = {
 	.is_visible = mapping_visible,
 	.attrs = mapping_attributes,
 };
-EXPORT_SYMBOL_GPL(nd_mapping_attribute_group);
 
 static const struct attribute_group nd_region_attribute_group = {
 	.attrs = nd_region_attributes,
@@ -766,6 +765,7 @@ static const struct attribute_group *nd_region_attribute_groups[] = {
 	&nd_device_attribute_group,
 	&nd_region_attribute_group,
 	&nd_numa_attribute_group,
+	&nd_mapping_attribute_group,
 	NULL,
 };
 
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index 312248d334c7..eb597d1cb891 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -67,7 +67,6 @@ enum {
 
 extern struct attribute_group nvdimm_bus_attribute_group;
 extern struct attribute_group nvdimm_attribute_group;
-extern struct attribute_group nd_mapping_attribute_group;
 
 struct nvdimm;
 struct nvdimm_bus_descriptor;

