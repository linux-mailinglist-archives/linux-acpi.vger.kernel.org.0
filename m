Return-Path: <linux-acpi+bounces-4217-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B7D876CA1
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Mar 2024 23:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAB42B2184E
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Mar 2024 22:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181675FBA7;
	Fri,  8 Mar 2024 22:02:10 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05E75CDC9;
	Fri,  8 Mar 2024 22:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709935330; cv=none; b=aov+BaqaxPTJBxpUWi/4VAnZTVKp9KQ3EhBANID0p1UOSBSG77Rhplp6q0clwPLo0cUP142HvWbjKNtBDm0Mv42WknNubrcqgnBGway/TwNm1ZH1Vu8UMPRkEas4Z9gc9lAsY972reu5wY0uwKZJfuaqRW6erH41nCsWRJqdIJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709935330; c=relaxed/simple;
	bh=fV3/shBGK7hp2t2FeW5xGKu14Ek0PABcwrbRM89nz2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFBr19ojLYV74m5lZ1uq+BV4/rZ9G8utY6aPgKmVKXerLdgco14DAF9COV7gz6AxyXasXYS6lM1hye9p2asv/a/USYemN4wyGpm+HgaK9c9jOuC6CrNfTfiQiDzelcgo3gyZq3GF+mb3JOy9E3agVcNob1zeMPz2joN3z7qORdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFFC6C433F1;
	Fri,  8 Mar 2024 22:02:08 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	rafael@kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH v7 10/12] cxl/region: Add sysfs attribute for locality attributes of CXL regions
Date: Fri,  8 Mar 2024 14:59:29 -0700
Message-ID: <20240308220055.2172956-11-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308220055.2172956-1-dave.jiang@intel.com>
References: <20240308220055.2172956-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add read/write latencies and bandwidth sysfs attributes for the enabled CXL
region. The bandwidth is the aggregated bandwidth of all devices that
contribute to the CXL region. The latency is the worst latency of the
device amongst all the devices that contribute to the CXL region.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v7:
- Remove comma after NULL in array listing. (Jonathan)
---
 Documentation/ABI/testing/sysfs-bus-cxl | 34 +++++++++
 drivers/cxl/core/region.c               | 94 +++++++++++++++++++++++++
 2 files changed, 128 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index fff2581b8033..3f5627a1210a 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -552,3 +552,37 @@ Description:
 		attribute is only visible for devices supporting the
 		capability. The retrieved errors are logged as kernel
 		events when cxl_poison event tracing is enabled.
+
+
+What:		/sys/bus/cxl/devices/regionZ/accessY/read_bandwidth
+		/sys/bus/cxl/devices/regionZ/accessY/write_banwidth
+Date:		Jan, 2024
+KernelVersion:	v6.9
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) The aggregated read or write bandwidth of the region. The
+		number is the accumulated read or write bandwidth of all CXL memory
+		devices that contributes to the region in MB/s. It is
+		identical data that should appear in
+		/sys/devices/system/node/nodeX/accessY/initiators/read_bandwidth or
+		/sys/devices/system/node/nodeX/accessY/initiators/write_bandwidth.
+		See Documentation/ABI/stable/sysfs-devices-node. access0 provides
+		the number to the closest initiator and access1 provides the
+		number to the closest CPU.
+
+
+What:		/sys/bus/cxl/devices/regionZ/accessY/read_latency
+		/sys/bus/cxl/devices/regionZ/accessY/write_latency
+Date:		Jan, 2024
+KernelVersion:	v6.9
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) The read or write latency of the region. The number is
+		the worst read or write latency of all CXL memory devices that
+		contributes to the region in nanoseconds. It is identical data
+		that should appear in
+		/sys/devices/system/node/nodeX/accessY/initiators/read_latency or
+		/sys/devices/system/node/nodeX/accessY/initiators/write_latency.
+		See Documentation/ABI/stable/sysfs-devices-node. access0 provides
+		the number to the closest initiator and access1 provides the
+		number to the closest CPU.
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 9a0d2d7621de..d4d39536e6c7 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -30,6 +30,98 @@
 
 static struct cxl_region *to_cxl_region(struct device *dev);
 
+#define __ACCESS_ATTR_RO(_level, _name) {				\
+	.attr	= { .name = __stringify(_name), .mode = 0444 },		\
+	.show	= _name##_access##_level##_show,			\
+}
+
+#define ACCESS_DEVICE_ATTR_RO(level, name)	\
+	struct device_attribute dev_attr_access##level##_##name = __ACCESS_ATTR_RO(level, name)
+
+#define ACCESS_ATTR_RO(level, attrib)					      \
+static ssize_t attrib##_access##level##_show(struct device *dev,	      \
+					  struct device_attribute *attr,      \
+					  char *buf)			      \
+{									      \
+	struct cxl_region *cxlr = to_cxl_region(dev);			      \
+									      \
+	if (cxlr->coord[level].attrib == 0)				      \
+		return -ENOENT;						      \
+									      \
+	return sysfs_emit(buf, "%u\n", cxlr->coord[level].attrib);	      \
+}									      \
+static ACCESS_DEVICE_ATTR_RO(level, attrib)
+
+ACCESS_ATTR_RO(0, read_bandwidth);
+ACCESS_ATTR_RO(0, read_latency);
+ACCESS_ATTR_RO(0, write_bandwidth);
+ACCESS_ATTR_RO(0, write_latency);
+
+#define ACCESS_ATTR_DECLARE(level, attrib)	\
+	(&dev_attr_access##level##_##attrib.attr)
+
+static struct attribute *access0_coordinate_attrs[] = {
+	ACCESS_ATTR_DECLARE(0, read_bandwidth),
+	ACCESS_ATTR_DECLARE(0, write_bandwidth),
+	ACCESS_ATTR_DECLARE(0, read_latency),
+	ACCESS_ATTR_DECLARE(0, write_latency),
+	NULL
+};
+
+ACCESS_ATTR_RO(1, read_bandwidth);
+ACCESS_ATTR_RO(1, read_latency);
+ACCESS_ATTR_RO(1, write_bandwidth);
+ACCESS_ATTR_RO(1, write_latency);
+
+static struct attribute *access1_coordinate_attrs[] = {
+	ACCESS_ATTR_DECLARE(1, read_bandwidth),
+	ACCESS_ATTR_DECLARE(1, write_bandwidth),
+	ACCESS_ATTR_DECLARE(1, read_latency),
+	ACCESS_ATTR_DECLARE(1, write_latency),
+	NULL
+};
+
+#define ACCESS_VISIBLE(level)						\
+static umode_t cxl_region_access##level##_coordinate_visible(		\
+		struct kobject *kobj, struct attribute *a, int n)	\
+{									\
+	struct device *dev = kobj_to_dev(kobj);				\
+	struct cxl_region *cxlr = to_cxl_region(dev);			\
+									\
+	if (a == &dev_attr_access##level##_read_latency.attr &&		\
+	    cxlr->coord[level].read_latency == 0)			\
+		return 0;						\
+									\
+	if (a == &dev_attr_access##level##_write_latency.attr &&	\
+	    cxlr->coord[level].write_latency == 0)			\
+		return 0;						\
+									\
+	if (a == &dev_attr_access##level##_read_bandwidth.attr &&	\
+	    cxlr->coord[level].read_bandwidth == 0)			\
+		return 0;						\
+									\
+	if (a == &dev_attr_access##level##_write_bandwidth.attr &&	\
+	    cxlr->coord[level].write_bandwidth == 0)			\
+		return 0;						\
+									\
+	return a->mode;							\
+}
+
+ACCESS_VISIBLE(0);
+ACCESS_VISIBLE(1);
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
@@ -2069,6 +2161,8 @@ static const struct attribute_group *region_groups[] = {
 	&cxl_base_attribute_group,
 	&cxl_region_group,
 	&cxl_region_target_group,
+	&cxl_region_access0_coordinate_group,
+	&cxl_region_access1_coordinate_group,
 	NULL,
 };
 
-- 
2.44.0


