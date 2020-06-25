Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B78820A9A3
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Jun 2020 02:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgFZAHZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Jun 2020 20:07:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:4797 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbgFZAHY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 Jun 2020 20:07:24 -0400
IronPort-SDR: l3Xt460FlEUt6GI3n1REM5dGSN/bJlK3hjVXYi19ujCy86eypT7UZGzqqfvanu0Krb4y40r6ao
 sBdXjMILu3LA==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="206647957"
X-IronPort-AV: E=Sophos;i="5.75,281,1589266800"; 
   d="scan'208";a="206647957"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 17:07:23 -0700
IronPort-SDR: MnLUyPO0qkcP3gzDormJi7AkZdvGQ5g436iulTn+h2EJfdVIe491du/PqvY1Egak9OMCJc5YJI
 INWnW+QmFfuA==
X-IronPort-AV: E=Sophos;i="5.75,281,1589266800"; 
   d="scan'208";a="423910118"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 17:07:23 -0700
Subject: [PATCH 09/12] libnvdimm: Convert to DEVICE_ATTR_ADMIN_RO()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 25 Jun 2020 16:51:08 -0700
Message-ID: <159312906883.1850128.431646371098593911.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159312902033.1850128.1712559453279208264.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159312902033.1850128.1712559453279208264.stgit@dwillia2-desk3.amr.corp.intel.com>
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

