Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B94691ACB
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Feb 2023 10:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjBJJHW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 04:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjBJJGd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 04:06:33 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA3737735;
        Fri, 10 Feb 2023 01:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676019972; x=1707555972;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g9WOYiZgLx/JR1gosHNg5WOS/EaNuj1iypU5OOVGJsQ=;
  b=RFpgGd9JWcFKMfIILq03l6Y1R+rtcgNR5GJ5C2l5CKVe3TjGhwIhaxfs
   dlmseyPL7DcVP0WUU0BTnlTvkP/bgHhTWpttKG0Eih4i+GngKXpqJnmmq
   vIS/UMB+/zWHyBsQExIzMBsCVWylt6WrARpTyzSIQ6ptdb0EEuuMekIyS
   2HYPKuHhm6szX/H8cVWKki874swISFRGMsWF6ZHbsKxngzwRE7EV2k8ZV
   fa7AQbMVCEvxoRNY3AGxcCY0IB2S/wOcToJiXFLyYMoEv5XjlnNXlBL+w
   SWSiywUwYoYRkKP4/8FlkkmqFoSdyIv5oO9Z6HzzsJsltX0KMlvVWmpxP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="416600025"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="416600025"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:05:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="669930220"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="669930220"
Received: from hrchavan-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.46.42])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:05:58 -0800
Subject: [PATCH v2 06/20] cxl/region: Add volatile region creation support
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Gregory Price <gregory.price@memverge.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fan Ni <fan.ni@samsung.com>, dave.hansen@linux.intel.com,
        linux-mm@kvack.org, linux-acpi@vger.kernel.org
Date:   Fri, 10 Feb 2023 01:05:57 -0800
Message-ID: <167601995775.1924368.352616146815830591.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Expand the region creation infrastructure to enable 'ram'
(volatile-memory) regions. The internals of create_pmem_region_store()
and create_pmem_region_show() are factored out into helpers
__create_region() and __create_region_show() for the 'ram' case to
reuse.

Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Reviewed-by: Gregory Price <gregory.price@memverge.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Fan Ni <fan.ni@samsung.com>
Link: https://lore.kernel.org/r/167564537678.847146.4066579806086171091.stgit@dwillia2-xfh.jf.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |   22 +++++-----
 drivers/cxl/core/core.h                 |    1 
 drivers/cxl/core/port.c                 |   14 ++++++
 drivers/cxl/core/region.c               |   71 +++++++++++++++++++++++++------
 4 files changed, 83 insertions(+), 25 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 4c4e1cbb1169..3acf2f17a73f 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -285,20 +285,20 @@ Description:
 		interleave_granularity).
 
 
-What:		/sys/bus/cxl/devices/decoderX.Y/create_pmem_region
-Date:		May, 2022
-KernelVersion:	v6.0
+What:		/sys/bus/cxl/devices/decoderX.Y/create_{pmem,ram}_region
+Date:		May, 2022, January, 2023
+KernelVersion:	v6.0 (pmem), v6.3 (ram)
 Contact:	linux-cxl@vger.kernel.org
 Description:
 		(RW) Write a string in the form 'regionZ' to start the process
-		of defining a new persistent memory region (interleave-set)
-		within the decode range bounded by root decoder 'decoderX.Y'.
-		The value written must match the current value returned from
-		reading this attribute. An atomic compare exchange operation is
-		done on write to assign the requested id to a region and
-		allocate the region-id for the next creation attempt. EBUSY is
-		returned if the region name written does not match the current
-		cached value.
+		of defining a new persistent, or volatile memory region
+		(interleave-set) within the decode range bounded by root decoder
+		'decoderX.Y'. The value written must match the current value
+		returned from reading this attribute. An atomic compare exchange
+		operation is done on write to assign the requested id to a
+		region and allocate the region-id for the next creation attempt.
+		EBUSY is returned if the region name written does not match the
+		current cached value.
 
 
 What:		/sys/bus/cxl/devices/decoderX.Y/delete_region
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 8c04672dca56..5eb873da5a30 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -11,6 +11,7 @@ extern struct attribute_group cxl_base_attribute_group;
 
 #ifdef CONFIG_CXL_REGION
 extern struct device_attribute dev_attr_create_pmem_region;
+extern struct device_attribute dev_attr_create_ram_region;
 extern struct device_attribute dev_attr_delete_region;
 extern struct device_attribute dev_attr_region;
 extern const struct device_type cxl_pmem_region_type;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1e541956f605..9e5df64ea6b5 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -294,6 +294,7 @@ static struct attribute *cxl_decoder_root_attrs[] = {
 	&dev_attr_cap_type3.attr,
 	&dev_attr_target_list.attr,
 	SET_CXL_REGION_ATTR(create_pmem_region)
+	SET_CXL_REGION_ATTR(create_ram_region)
 	SET_CXL_REGION_ATTR(delete_region)
 	NULL,
 };
@@ -305,6 +306,13 @@ static bool can_create_pmem(struct cxl_root_decoder *cxlrd)
 	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
 }
 
+static bool can_create_ram(struct cxl_root_decoder *cxlrd)
+{
+	unsigned long flags = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_RAM;
+
+	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
+}
+
 static umode_t cxl_root_decoder_visible(struct kobject *kobj, struct attribute *a, int n)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -313,7 +321,11 @@ static umode_t cxl_root_decoder_visible(struct kobject *kobj, struct attribute *
 	if (a == CXL_REGION_ATTR(create_pmem_region) && !can_create_pmem(cxlrd))
 		return 0;
 
-	if (a == CXL_REGION_ATTR(delete_region) && !can_create_pmem(cxlrd))
+	if (a == CXL_REGION_ATTR(create_ram_region) && !can_create_ram(cxlrd))
+		return 0;
+
+	if (a == CXL_REGION_ATTR(delete_region) &&
+	    !(can_create_pmem(cxlrd) || can_create_ram(cxlrd)))
 		return 0;
 
 	return a->mode;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 285835145e9b..e440db8611a4 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1689,6 +1689,15 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 	struct device *dev;
 	int rc;
 
+	switch (mode) {
+	case CXL_DECODER_RAM:
+	case CXL_DECODER_PMEM:
+		break;
+	default:
+		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %d\n", mode);
+		return ERR_PTR(-EINVAL);
+	}
+
 	cxlr = cxl_region_alloc(cxlrd, id);
 	if (IS_ERR(cxlr))
 		return cxlr;
@@ -1717,12 +1726,38 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 	return ERR_PTR(rc);
 }
 
+static ssize_t __create_region_show(struct cxl_root_decoder *cxlrd, char *buf)
+{
+	return sysfs_emit(buf, "region%u\n", atomic_read(&cxlrd->region_id));
+}
+
 static ssize_t create_pmem_region_show(struct device *dev,
 				       struct device_attribute *attr, char *buf)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
+	return __create_region_show(to_cxl_root_decoder(dev), buf);
+}
 
-	return sysfs_emit(buf, "region%u\n", atomic_read(&cxlrd->region_id));
+static ssize_t create_ram_region_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	return __create_region_show(to_cxl_root_decoder(dev), buf);
+}
+
+static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
+					  enum cxl_decoder_mode mode, int id)
+{
+	int rc;
+
+	rc = memregion_alloc(GFP_KERNEL);
+	if (rc < 0)
+		return ERR_PTR(rc);
+
+	if (atomic_cmpxchg(&cxlrd->region_id, id, rc) != id) {
+		memregion_free(rc);
+		return ERR_PTR(-EBUSY);
+	}
+
+	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_EXPANDER);
 }
 
 static ssize_t create_pmem_region_store(struct device *dev,
@@ -1731,29 +1766,39 @@ static ssize_t create_pmem_region_store(struct device *dev,
 {
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
 	struct cxl_region *cxlr;
-	int id, rc;
+	int rc, id;
 
 	rc = sscanf(buf, "region%d\n", &id);
 	if (rc != 1)
 		return -EINVAL;
 
-	rc = memregion_alloc(GFP_KERNEL);
-	if (rc < 0)
-		return rc;
+	cxlr = __create_region(cxlrd, CXL_DECODER_PMEM, id);
+	if (IS_ERR(cxlr))
+		return PTR_ERR(cxlr);
 
-	if (atomic_cmpxchg(&cxlrd->region_id, id, rc) != id) {
-		memregion_free(rc);
-		return -EBUSY;
-	}
+	return len;
+}
+DEVICE_ATTR_RW(create_pmem_region);
+
+static ssize_t create_ram_region_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t len)
+{
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
+	struct cxl_region *cxlr;
+	int rc, id;
 
-	cxlr = devm_cxl_add_region(cxlrd, id, CXL_DECODER_PMEM,
-				   CXL_DECODER_EXPANDER);
+	rc = sscanf(buf, "region%d\n", &id);
+	if (rc != 1)
+		return -EINVAL;
+
+	cxlr = __create_region(cxlrd, CXL_DECODER_RAM, id);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
 	return len;
 }
-DEVICE_ATTR_RW(create_pmem_region);
+DEVICE_ATTR_RW(create_ram_region);
 
 static ssize_t region_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)

