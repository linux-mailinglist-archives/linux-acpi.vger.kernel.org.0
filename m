Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCF9227251
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jul 2020 00:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgGTWYb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Jul 2020 18:24:31 -0400
Received: from mga07.intel.com ([134.134.136.100]:35411 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbgGTWYb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 20 Jul 2020 18:24:31 -0400
IronPort-SDR: pjuYd2KYqd1oAG0IHpNtv+rfH39yvGeNs6ni16Fszl7aKv24jmvHLzwuUu8YkyBZ4mZ+oKCt98
 Cmbjyu+QkoDQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="214686921"
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="214686921"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 15:24:30 -0700
IronPort-SDR: n8jZBCRHGNfmR59Qc6dDKF+uKAuHRK0edJ5jQaqNW/Eo3XX2H5HvMOshCHhC9jzZvlppv96pHO
 yt9n9GU13X+g==
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="461851455"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 15:24:30 -0700
Subject: [PATCH v3 09/11] libnvdimm: Convert to DEVICE_ATTR_ADMIN_RO()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 20 Jul 2020 15:08:13 -0700
Message-ID: <159528289333.993790.15029366071987801760.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159528284411.993790.11733759435137949717.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159528284411.993790.11733759435137949717.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Move libnvdimm sysfs attributes that currently use an open coded
DEVICE_ATTR() to hide sensitive root-only information (physical memory
layout) to the new DEVICE_ATTR_ADMIN_RO() helper.

Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/namespace_devs.c |    2 +-
 drivers/nvdimm/pfn_devs.c       |    2 +-
 drivers/nvdimm/region_devs.c    |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index ae155e860fdc..6da67f4d641a 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1309,7 +1309,7 @@ static ssize_t resource_show(struct device *dev,
 		return -ENXIO;
 	return sprintf(buf, "%#llx\n", (unsigned long long) res->start);
 }
-static DEVICE_ATTR(resource, 0400, resource_show, NULL);
+static DEVICE_ATTR_ADMIN_RO(resource);
 
 static const unsigned long blk_lbasize_supported[] = { 512, 520, 528,
 	4096, 4104, 4160, 4224, 0 };
diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index 34db557dbad1..3e11ef8d3f5b 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -218,7 +218,7 @@ static ssize_t resource_show(struct device *dev,
 
 	return rc;
 }
-static DEVICE_ATTR(resource, 0400, resource_show, NULL);
+static DEVICE_ATTR_ADMIN_RO(resource);
 
 static ssize_t size_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 4502f9c4708d..20ff30c2ab93 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -605,7 +605,7 @@ static ssize_t resource_show(struct device *dev,
 
 	return sprintf(buf, "%#llx\n", nd_region->ndr_start);
 }
-static DEVICE_ATTR(resource, 0400, resource_show, NULL);
+static DEVICE_ATTR_ADMIN_RO(resource);
 
 static ssize_t persistence_domain_show(struct device *dev,
 		struct device_attribute *attr, char *buf)

