Return-Path: <linux-acpi+bounces-2951-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EE7832E16
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Jan 2024 18:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CFF61C23C04
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Jan 2024 17:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8D255E52;
	Fri, 19 Jan 2024 17:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xlp8cChn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C2554BEE;
	Fri, 19 Jan 2024 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705685041; cv=none; b=kHjsglV6wtrlSzODn1vOkgA5NhZe4bobRl6kcQUpDhAl4tC7a8RtT5ZC4EuGzN/TgGo8YeotzjfJdY5QQNKM+q8jmKTSPYy8M1Gtw8lhaxHNi8J+ipGkxReKgeOpa5NYANVvVp2qrJaOHFxvjtk18gcfj0yiWDeQu88knDInZ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705685041; c=relaxed/simple;
	bh=Qmoc0Y6G7tuUbgpDwEQIbD6dPGzXFkswC48DqEIEujM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tw2XwExFhf04VDxhtKjcGPS1JIvBKGJuxvAnuw3jkWTFGvMavSMpdhMWnzyYvESf+DjT6ubiR0zTTbFIDuk5ty2ktAyvptOMKKdGhgPLogPtWIq88nA11UpsvJDo1Qal5HJ95Z3bzu4h+WjqVNSMX1zkyzNLmZoFdvEVUrwEdU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xlp8cChn; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705685039; x=1737221039;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qmoc0Y6G7tuUbgpDwEQIbD6dPGzXFkswC48DqEIEujM=;
  b=Xlp8cChnJOVKJlBcQQy9LwtT12XET+xpQHIeYRZEnIE/bFsfdXNVj0K5
   WT3x2FZANl+Yy0VCWTG+tcFS1sW0LOUCSZjDrvB3/fN7u992FzKoJM+5M
   L6B22+kmys3Xmqu36wQTlXDd6ZeA5QCVtL93xVngxa16VJ6rvMSNzG463
   uUbIapMkBoqxFIBFW8UYLrYnsnDbtt6wGqRz9ZcQHk41H3DtLBNhBGXnR
   Pbc47lauh9uKuyoqG+IgpSNej1F0OeI7VNXWtcCum6slVIOaZjQBq0Zxx
   ikIT2sfQ2KNq8pBM7z6XWqGESWTocnVWGpK6k7PjTj+pGI5+BxAx6d53r
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="7487538"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="7487538"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 09:23:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="1032001848"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="1032001848"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.161.22])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 09:23:58 -0800
Subject: [PATCH v4 09/11] cxl/region: Add sysfs attribute for locality
 attributes of CXL regions
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, jonathan.cameron@huawei.com, dave@stgolabs.net,
 brice.goglin@gmail.com, nifan.cxl@gmail.com, rafael@kernel.org,
 gregkh@linuxfoundation.org
Date: Fri, 19 Jan 2024 10:23:58 -0700
Message-ID: <170568503831.1008395.3930372071523626655.stgit@djiang5-mobl3>
In-Reply-To: <170568485801.1008395.12244787918793980621.stgit@djiang5-mobl3>
References: <170568485801.1008395.12244787918793980621.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add read/write latencies and bandwidth sysfs attributes for the enabled CXL
region. The bandwidth is the aggregated bandwidth of all devices that
contribute to the CXL region. The latency is the worst latency of the
device amongst all the devices that contribute to the CXL region.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v4:
- Added support for access0 and access1 attributes
- Updated documentation for access levels
- Update verbiage of explanation. (Dan)
---
 Documentation/ABI/testing/sysfs-bus-cxl |   60 ++++++++++++++
 drivers/cxl/core/region.c               |  134 +++++++++++++++++++++++++++++++
 2 files changed, 194 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index fff2581b8033..5f8c26815399 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -552,3 +552,63 @@ Description:
 		attribute is only visible for devices supporting the
 		capability. The retrieved errors are logged as kernel
 		events when cxl_poison event tracing is enabled.
+
+
+What:		/sys/bus/cxl/devices/regionZ/accessY/read_bandwidth
+Date:		Jan, 2024
+KernelVersion:	v6.9
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) The aggregated read bandwidth of the region. The number is
+		the accumulated read bandwidth of all CXL memory devices that
+		contributes to the region in MB/s. It is identical data that
+		should appear in
+		/sys/devices/system/node/nodeX/accessY/initiators/read_bandwidth.
+		See Documentation/ABI/stable/sysfs-devices-node. access0 provides
+		the number to the closest initiator and access1 provides the
+		number to the closest CPU.
+
+
+What:		/sys/bus/cxl/devices/regionZ/accessY/write_bandwidth
+Date:		Jan, 2024
+KernelVersion:	v6.9
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) The aggregated write bandwidth of the region. The number is
+		the accumulated write bandwidth of all CXL memory devices that
+		contributes to the region in MB/s. It is identical data that
+		should appear in
+		/sys/devices/system/node/nodeX/accessY/initiators/write_bandwidth.
+		See Documentation/ABI/stable/sysfs-devices-node. access0 provides
+		the number to the closest initiator and access1 provides the
+		number to the closest CPU.
+
+
+What:		/sys/bus/cxl/devices/regionZ/accessY/read_latency
+Date:		Jan, 2024
+KernelVersion:	v6.9
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) The read latency of the region. The number is
+		the worst read latency of all CXL memory devices that
+		contributes to the region in nanoseconds. It is identical data
+		that should appear in
+		/sys/devices/system/node/nodeX/accessY/initiators/read_latency.
+		See Documentation/ABI/stable/sysfs-devices-node. access0 provides
+		the number to the closest initiator and access1 provides the
+		number to the closest CPU.
+
+
+What:		/sys/bus/cxl/devices/regionZ/accessY/write_latency
+Date:		Jan, 2024
+KernelVersion:	v6.9
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) The write latency of the region. The number is
+		the worst write latency of all CXL memory devices that
+		contributes to the region in nanoseconds. It is identical data
+		that should appear in
+		/sys/devices/system/node/nodeX/accessY/initiators/write_latency.
+		See Documentation/ABI/stable/sysfs-devices-node. access0 provides
+		the number to the closest initiator and access1 provides the
+		number to the closest CPU.
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 7f19b533c5ae..978d1707964a 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -30,6 +30,138 @@
 
 static struct cxl_region *to_cxl_region(struct device *dev);
 
+#define __ACCESS0_ATTR_RO(_name) {				\
+	.attr	= { .name = __stringify(_name), .mode = 0444 },	\
+	.show	= _name##_access0_show,				\
+}
+
+#define ACCESS0_DEVICE_ATTR_RO(_name) \
+	struct device_attribute dev_attr_access0_##_name = __ACCESS0_ATTR_RO(_name)
+
+#define ACCESS0_ATTR(attrib)					\
+static ssize_t attrib##_access0_show(struct device *dev,	\
+			   struct device_attribute *attr,	\
+			   char *buf)				\
+{								\
+	struct cxl_region *cxlr = to_cxl_region(dev);		\
+								\
+	if (cxlr->coord[0].attrib == 0)				\
+		return -ENOENT;					\
+								\
+	return sysfs_emit(buf, "%u\n", cxlr->coord[0].attrib);	\
+}								\
+static ACCESS0_DEVICE_ATTR_RO(attrib)
+
+ACCESS0_ATTR(read_bandwidth);
+ACCESS0_ATTR(read_latency);
+ACCESS0_ATTR(write_bandwidth);
+ACCESS0_ATTR(write_latency);
+
+static struct attribute *access0_coordinate_attrs[] = {
+	&dev_attr_access0_read_bandwidth.attr,
+	&dev_attr_access0_write_bandwidth.attr,
+	&dev_attr_access0_read_latency.attr,
+	&dev_attr_access0_write_latency.attr,
+	NULL,
+};
+
+static umode_t cxl_region_access0_coordinate_visible(struct kobject *kobj,
+						     struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_region *cxlr = to_cxl_region(dev);
+
+	if (a == &dev_attr_access0_read_latency.attr &&
+	    cxlr->coord[ACCESS_COORDINATE_LOCAL].read_latency == 0)
+		return 0;
+
+	if (a == &dev_attr_access0_write_latency.attr &&
+	    cxlr->coord[ACCESS_COORDINATE_LOCAL].write_latency == 0)
+		return 0;
+
+	if (a == &dev_attr_access0_read_bandwidth.attr &&
+	    cxlr->coord[ACCESS_COORDINATE_LOCAL].read_bandwidth == 0)
+		return 0;
+
+	if (a == &dev_attr_access0_write_bandwidth.attr &&
+	    cxlr->coord[ACCESS_COORDINATE_LOCAL].write_bandwidth == 0)
+		return 0;
+
+	return a->mode;
+}
+
+#define __ACCESS1_ATTR_RO(_name) {				\
+	.attr	= { .name = __stringify(_name), .mode = 0444 },	\
+	.show	= _name##_access1_show,				\
+}
+
+#define ACCESS1_DEVICE_ATTR_RO(_name) \
+	struct device_attribute dev_attr_access1_##_name = __ACCESS1_ATTR_RO(_name)
+
+#define ACCESS1_ATTR(attrib)					\
+static ssize_t attrib##_access1_show(struct device *dev,	\
+			   struct device_attribute *attr,	\
+			   char *buf)				\
+{								\
+	struct cxl_region *cxlr = to_cxl_region(dev);		\
+								\
+	if (cxlr->coord[1].attrib == 0)				\
+		return -ENOENT;					\
+								\
+	return sysfs_emit(buf, "%u\n", cxlr->coord[1].attrib);	\
+}								\
+static ACCESS1_DEVICE_ATTR_RO(attrib)
+
+ACCESS1_ATTR(read_bandwidth);
+ACCESS1_ATTR(read_latency);
+ACCESS1_ATTR(write_bandwidth);
+ACCESS1_ATTR(write_latency);
+
+static struct attribute *access1_coordinate_attrs[] = {
+	&dev_attr_access1_read_bandwidth.attr,
+	&dev_attr_access1_write_bandwidth.attr,
+	&dev_attr_access1_read_latency.attr,
+	&dev_attr_access1_write_latency.attr,
+	NULL,
+};
+
+static umode_t cxl_region_access1_coordinate_visible(struct kobject *kobj,
+						     struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_region *cxlr = to_cxl_region(dev);
+
+	if (a == &dev_attr_access1_read_latency.attr &&
+	    cxlr->coord[ACCESS_COORDINATE_CPU].read_latency == 0)
+		return 0;
+
+	if (a == &dev_attr_access1_write_latency.attr &&
+	    cxlr->coord[ACCESS_COORDINATE_CPU].write_latency == 0)
+		return 0;
+
+	if (a == &dev_attr_access1_read_bandwidth.attr &&
+	    cxlr->coord[ACCESS_COORDINATE_CPU].read_bandwidth == 0)
+		return 0;
+
+	if (a == &dev_attr_access1_write_bandwidth.attr &&
+	    cxlr->coord[ACCESS_COORDINATE_CPU].write_bandwidth == 0)
+		return 0;
+
+	return a->mode;
+}
+
+static const struct attribute_group cxl_region_access0_coordinate_group = {
+	.name = "access0",
+	.attrs = access0_coordinate_attrs,
+	.is_visible = cxl_region_access0_coordinate_visible,
+};
+
+static const struct attribute_group cxl_region_access1_coordinate_group = {
+	.name = "access1",
+	.attrs = access1_coordinate_attrs,
+	.is_visible = cxl_region_access1_coordinate_visible,
+};
+
 static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
@@ -2039,6 +2171,8 @@ static const struct attribute_group *region_groups[] = {
 	&cxl_base_attribute_group,
 	&cxl_region_group,
 	&cxl_region_target_group,
+	&cxl_region_access0_coordinate_group,
+	&cxl_region_access1_coordinate_group,
 	NULL,
 };
 



