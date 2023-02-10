Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4666C691AC5
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Feb 2023 10:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjBJJGl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 04:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjBJJGI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 04:06:08 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308035A906;
        Fri, 10 Feb 2023 01:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676019941; x=1707555941;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3cQC8uwKOt3b1h6vNcSkmE8AzC7Sg9UhcvwbHDHzsBA=;
  b=dY/wlWSPmqvnTVPn7s/3qREwEx3YcYYzDVwHE6TNGzIE8v9Cm9WS5Epl
   F6E40ntp6WfjaQw+FWvh4vJX3tYQTjSUYCZ/Yy1i9+/5gqvFJaJD36j/K
   bjj85s5GQ3LHx3rtnqrYqx96jhlk+rXu0pCkdm/IOZ/RmMUEARlteshan
   ofcZbgNAQxp2UIx3ZK2U5rqrYoozTIXtHCoEKPHpvLBcN7hUaTv2aDm3Y
   VSxpsmEllWcNhnAXW2+IsHpBsJhrUpkO7i8vg/0vqL8fUSYerUVul1wY0
   VC7DiWs0l3l/pqryeqcwMMW0aPdu3hv7Lw65eiTQ7GLADX+DPjfHPGswP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="416599982"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="416599982"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:05:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="669930135"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="669930135"
Received: from hrchavan-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.46.42])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:05:39 -0800
Subject: [PATCH v2 03/20] cxl/region: Add a mode attribute for regions
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fan Ni <fan.ni@samsung.com>, dave.hansen@linux.intel.com,
        linux-mm@kvack.org, linux-acpi@vger.kernel.org
Date:   Fri, 10 Feb 2023 01:05:39 -0800
Message-ID: <167601993930.1924368.4305018565539515665.stgit@dwillia2-xfh.jf.intel.com>
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

In preparation for a new region type, "ram" regions, add a mode
attribute to clarify the mode of the decoders that can be added to a
region. Share the internals of mode_show() (for decoders) with the
region case.

Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Gregory Price <gregory.price@memverge.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Fan Ni <fan.ni@samsung.com>
Link: https://lore.kernel.org/r/167564536041.847146.11330354943211409793.stgit@dwillia2-xfh.jf.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |   11 +++++++++++
 drivers/cxl/core/port.c                 |   12 +-----------
 drivers/cxl/core/region.c               |   10 ++++++++++
 drivers/cxl/cxl.h                       |   14 ++++++++++++++
 4 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 5be032313e29..058b0c45001f 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -358,6 +358,17 @@ Description:
 		results in the same address being allocated.
 
 
+What:		/sys/bus/cxl/devices/regionZ/mode
+Date:		January, 2023
+KernelVersion:	v6.3
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) The mode of a region is established at region creation time
+		and dictates the mode of the endpoint decoder that comprise the
+		region. For more details on the possible modes see
+		/sys/bus/cxl/devices/decoderX.Y/mode
+
+
 What:		/sys/bus/cxl/devices/regionZ/resource
 Date:		May, 2022
 KernelVersion:	v6.0
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 317bcf4dbd9d..1e541956f605 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -180,17 +180,7 @@ static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
 {
 	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
 
-	switch (cxled->mode) {
-	case CXL_DECODER_RAM:
-		return sysfs_emit(buf, "ram\n");
-	case CXL_DECODER_PMEM:
-		return sysfs_emit(buf, "pmem\n");
-	case CXL_DECODER_NONE:
-		return sysfs_emit(buf, "none\n");
-	case CXL_DECODER_MIXED:
-	default:
-		return sysfs_emit(buf, "mixed\n");
-	}
+	return sysfs_emit(buf, "%s\n", cxl_decoder_mode_name(cxled->mode));
 }
 
 static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 60828d01972a..17d2d0c12725 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -458,6 +458,15 @@ static ssize_t resource_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(resource);
 
+static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+
+	return sysfs_emit(buf, "%s\n", cxl_decoder_mode_name(cxlr->mode));
+}
+static DEVICE_ATTR_RO(mode);
+
 static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 {
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
@@ -585,6 +594,7 @@ static struct attribute *cxl_region_attrs[] = {
 	&dev_attr_interleave_granularity.attr,
 	&dev_attr_resource.attr,
 	&dev_attr_size.attr,
+	&dev_attr_mode.attr,
 	NULL,
 };
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index aa3af3bb73b2..ca76879af1de 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -320,6 +320,20 @@ enum cxl_decoder_mode {
 	CXL_DECODER_DEAD,
 };
 
+static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
+{
+	static const char * const names[] = {
+		[CXL_DECODER_NONE] = "none",
+		[CXL_DECODER_RAM] = "ram",
+		[CXL_DECODER_PMEM] = "pmem",
+		[CXL_DECODER_MIXED] = "mixed",
+	};
+
+	if (mode >= CXL_DECODER_NONE && mode <= CXL_DECODER_MIXED)
+		return names[mode];
+	return "mixed";
+}
+
 /**
  * struct cxl_endpoint_decoder - Endpoint  / SPA to DPA decoder
  * @cxld: base cxl_decoder_object

