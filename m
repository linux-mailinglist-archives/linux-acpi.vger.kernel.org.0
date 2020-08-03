Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D29239EF7
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Aug 2020 07:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgHCFTd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 Aug 2020 01:19:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:16846 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728032AbgHCFTd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 3 Aug 2020 01:19:33 -0400
IronPort-SDR: +PCa9/ihIbRQUCl3Xvav8GqvmUTMxTcXStN6XcdVFE0Sc2ItfKrfWMhMNLLmGoSijt1MiqUSOI
 bZfYzPOfwEZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="216472142"
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="scan'208";a="216472142"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 22:19:32 -0700
IronPort-SDR: xgSN7LuDBztttPvRwXwahH2wKu3/cXRemn3lBKOgjSYVW+SBnlQfGEZrEIXSrKssjt9ZCAqvXi
 sqNRQeqpu+hA==
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="scan'208";a="329890491"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 22:19:32 -0700
Subject: [PATCH v4 09/23] device-dax: Move instance creation parameters to
 'struct dev_dax_data'
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>, peterz@infradead.org,
        dave.hansen@linux.intel.com, ard.biesheuvel@linaro.org,
        vishal.l.verma@intel.com, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, joao.m.martins@oracle.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Date:   Sun, 02 Aug 2020 22:03:14 -0700
Message-ID: <159643099411.4062302.1337305960720423895.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159643094279.4062302.17779410714418721328.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159643094279.4062302.17779410714418721328.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In preparation for adding more parameters to instance creation, move
existing parameters to a new struct.

Cc: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/bus.c       |   14 +++++++-------
 drivers/dax/bus.h       |   16 ++++++++--------
 drivers/dax/hmem/hmem.c |    8 +++++++-
 drivers/dax/pmem/core.c |    9 ++++++++-
 4 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index f06ffa66cd78..dffa4655e128 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -395,9 +395,9 @@ static void unregister_dev_dax(void *dev)
 	put_device(dev);
 }
 
-struct dev_dax *__devm_create_dev_dax(struct dax_region *dax_region, int id,
-		struct dev_pagemap *pgmap, enum dev_dax_subsys subsys)
+struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 {
+	struct dax_region *dax_region = data->dax_region;
 	struct device *parent = dax_region->dev;
 	struct dax_device *dax_dev;
 	struct dev_dax *dev_dax;
@@ -405,14 +405,14 @@ struct dev_dax *__devm_create_dev_dax(struct dax_region *dax_region, int id,
 	struct device *dev;
 	int rc = -ENOMEM;
 
-	if (id < 0)
+	if (data->id < 0)
 		return ERR_PTR(-EINVAL);
 
 	dev_dax = kzalloc(sizeof(*dev_dax), GFP_KERNEL);
 	if (!dev_dax)
 		return ERR_PTR(-ENOMEM);
 
-	memcpy(&dev_dax->pgmap, pgmap, sizeof(*pgmap));
+	memcpy(&dev_dax->pgmap, data->pgmap, sizeof(struct dev_pagemap));
 
 	/*
 	 * No 'host' or dax_operations since there is no access to this
@@ -438,13 +438,13 @@ struct dev_dax *__devm_create_dev_dax(struct dax_region *dax_region, int id,
 
 	inode = dax_inode(dax_dev);
 	dev->devt = inode->i_rdev;
-	if (subsys == DEV_DAX_BUS)
+	if (data->subsys == DEV_DAX_BUS)
 		dev->bus = &dax_bus_type;
 	else
 		dev->class = dax_class;
 	dev->parent = parent;
 	dev->type = &dev_dax_type;
-	dev_set_name(dev, "dax%d.%d", dax_region->id, id);
+	dev_set_name(dev, "dax%d.%d", dax_region->id, data->id);
 
 	rc = device_add(dev);
 	if (rc) {
@@ -464,7 +464,7 @@ struct dev_dax *__devm_create_dev_dax(struct dax_region *dax_region, int id,
 
 	return ERR_PTR(rc);
 }
-EXPORT_SYMBOL_GPL(__devm_create_dev_dax);
+EXPORT_SYMBOL_GPL(devm_create_dev_dax);
 
 static int match_always_count;
 
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index 55577e9791da..299c2e7fac09 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -13,18 +13,18 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 		struct resource *res, int target_node, unsigned int align);
 
 enum dev_dax_subsys {
-	DEV_DAX_BUS,
+	DEV_DAX_BUS = 0, /* zeroed dev_dax_data picks this by default */
 	DEV_DAX_CLASS,
 };
 
-struct dev_dax *__devm_create_dev_dax(struct dax_region *dax_region, int id,
-		struct dev_pagemap *pgmap, enum dev_dax_subsys subsys);
+struct dev_dax_data {
+	struct dax_region *dax_region;
+	struct dev_pagemap *pgmap;
+	enum dev_dax_subsys subsys;
+	int id;
+};
 
-static inline struct dev_dax *devm_create_dev_dax(struct dax_region *dax_region,
-		int id, struct dev_pagemap *pgmap)
-{
-	return __devm_create_dev_dax(dax_region, id, pgmap, DEV_DAX_BUS);
-}
+struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data);
 
 /* to be deleted when DEV_DAX_CLASS is removed */
 struct dev_dax *__dax_pmem_probe(struct device *dev, enum dev_dax_subsys subsys);
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 506893861253..b84fe17178d8 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -11,6 +11,7 @@ static int dax_hmem_probe(struct platform_device *pdev)
 	struct dev_pagemap pgmap = { };
 	struct dax_region *dax_region;
 	struct memregion_info *mri;
+	struct dev_dax_data data;
 	struct dev_dax *dev_dax;
 	struct resource *res;
 
@@ -26,7 +27,12 @@ static int dax_hmem_probe(struct platform_device *pdev)
 	if (!dax_region)
 		return -ENOMEM;
 
-	dev_dax = devm_create_dev_dax(dax_region, 0, &pgmap);
+	data = (struct dev_dax_data) {
+		.dax_region = dax_region,
+		.id = 0,
+		.pgmap = &pgmap,
+	};
+	dev_dax = devm_create_dev_dax(&data);
 	if (IS_ERR(dev_dax))
 		return PTR_ERR(dev_dax);
 
diff --git a/drivers/dax/pmem/core.c b/drivers/dax/pmem/core.c
index ea52bb77a294..08ee5947a49c 100644
--- a/drivers/dax/pmem/core.c
+++ b/drivers/dax/pmem/core.c
@@ -14,6 +14,7 @@ struct dev_dax *__dax_pmem_probe(struct device *dev, enum dev_dax_subsys subsys)
 	resource_size_t offset;
 	struct nd_pfn_sb *pfn_sb;
 	struct dev_dax *dev_dax;
+	struct dev_dax_data data;
 	struct nd_namespace_io *nsio;
 	struct dax_region *dax_region;
 	struct dev_pagemap pgmap = { };
@@ -57,7 +58,13 @@ struct dev_dax *__dax_pmem_probe(struct device *dev, enum dev_dax_subsys subsys)
 	if (!dax_region)
 		return ERR_PTR(-ENOMEM);
 
-	dev_dax = __devm_create_dev_dax(dax_region, id, &pgmap, subsys);
+	data = (struct dev_dax_data) {
+		.dax_region = dax_region,
+		.id = id,
+		.pgmap = &pgmap,
+		.subsys = subsys,
+	};
+	dev_dax = devm_create_dev_dax(&data);
 
 	/* child dev_dax instances now own the lifetime of the dax_region */
 	dax_region_put(dax_region);

