Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA5B1FFB2B
	for <lists+linux-acpi@lfdr.de>; Sun, 17 Nov 2019 18:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfKQR7v (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 17 Nov 2019 12:59:51 -0500
Received: from mga06.intel.com ([134.134.136.31]:44433 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbfKQR7v (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 17 Nov 2019 12:59:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 09:59:50 -0800
X-IronPort-AV: E=Sophos;i="5.68,317,1569308400"; 
   d="scan'208";a="405855083"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 09:59:50 -0800
Subject: [PATCH v2 11/18] libnvdimm: Simplify root read-only definition for
 the 'resource' attribute
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        peterz@infradead.org, dave.hansen@linux.intel.com, hch@lst.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Date:   Sun, 17 Nov 2019 09:45:33 -0800
Message-ID: <157401273394.43284.12148079363063773132.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Rather than update the permission in ->is_visible() set the permission
directly at declaration time.

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Link: https://lore.kernel.org/r/157309905534.1582359.13927459228885931097.stgit@dwillia2-desk3.amr.corp.intel.com
---
 drivers/nvdimm/namespace_devs.c |    9 +++------
 drivers/nvdimm/pfn_devs.c       |   10 +---------
 drivers/nvdimm/region_devs.c    |   10 +++-------
 3 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 05d99a8b3175..032dc61725ff 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1303,7 +1303,7 @@ static ssize_t resource_show(struct device *dev,
 		return -ENXIO;
 	return sprintf(buf, "%#llx\n", (unsigned long long) res->start);
 }
-static DEVICE_ATTR_RO(resource);
+static DEVICE_ATTR(resource, 0400, resource_show, NULL);
 
 static const unsigned long blk_lbasize_supported[] = { 512, 520, 528,
 	4096, 4104, 4160, 4224, 0 };
@@ -1619,11 +1619,8 @@ static umode_t namespace_visible(struct kobject *kobj,
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
 
-	if (a == &dev_attr_resource.attr) {
-		if (is_namespace_blk(dev))
-			return 0;
-		return 0400;
-	}
+	if (a == &dev_attr_resource.attr && is_namespace_blk(dev))
+		return 0;
 
 	if (is_namespace_pmem(dev) || is_namespace_blk(dev)) {
 		if (a == &dev_attr_size.attr)
diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index 17ceac5b5313..b94f7a7e94b8 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -218,7 +218,7 @@ static ssize_t resource_show(struct device *dev,
 
 	return rc;
 }
-static DEVICE_ATTR_RO(resource);
+static DEVICE_ATTR(resource, 0400, resource_show, NULL);
 
 static ssize_t size_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -269,16 +269,8 @@ static struct attribute *nd_pfn_attributes[] = {
 	NULL,
 };
 
-static umode_t pfn_visible(struct kobject *kobj, struct attribute *a, int n)
-{
-	if (a == &dev_attr_resource.attr)
-		return 0400;
-	return a->mode;
-}
-
 static struct attribute_group nd_pfn_attribute_group = {
 	.attrs = nd_pfn_attributes,
-	.is_visible = pfn_visible,
 };
 
 const struct attribute_group *nd_pfn_attribute_groups[] = {
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 0afc1973e938..be3e429e86af 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -553,7 +553,7 @@ static ssize_t resource_show(struct device *dev,
 
 	return sprintf(buf, "%#llx\n", nd_region->ndr_start);
 }
-static DEVICE_ATTR_RO(resource);
+static DEVICE_ATTR(resource, 0400, resource_show, NULL);
 
 static ssize_t persistence_domain_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -605,12 +605,8 @@ static umode_t region_visible(struct kobject *kobj, struct attribute *a, int n)
 	if (!is_memory(dev) && a == &dev_attr_badblocks.attr)
 		return 0;
 
-	if (a == &dev_attr_resource.attr) {
-		if (is_memory(dev))
-			return 0400;
-		else
-			return 0;
-	}
+	if (a == &dev_attr_resource.attr && !is_memory(dev))
+		return 0;
 
 	if (a == &dev_attr_deep_flush.attr) {
 		int has_flush = nvdimm_has_flush(nd_region);

