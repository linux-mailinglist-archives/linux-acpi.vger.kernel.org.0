Return-Path: <linux-acpi+bounces-3753-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C80E85CBDC
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 00:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B64DB1F22FEC
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Feb 2024 23:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB730154BF1;
	Tue, 20 Feb 2024 23:14:32 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00ED135416;
	Tue, 20 Feb 2024 23:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708470872; cv=none; b=cxB0mEfakpOWkqmd+1laoZJjfOSRxOBcGKw/PuouqBdO3e3y439mVyBKqU9KoR/7UWGtuQT9wdTXPielPiaeGWZk98lTZAztyETuVXI+daXrC8mbdZoxg4Yvy5RIsGBHJbwsXJw0qT9f9psvYNSGOTHSVbn4bhvUJwTsvXeiB70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708470872; c=relaxed/simple;
	bh=UG5P8AgM5kEHsOL6hTR3lNBAX3jAA7gsoKpgum4hH+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KxauQ3TLMXB7JxLyW2Sl3CNNl/OIHEBdT6m+yHx1qVxU9FI0kt94D7NJNIknaX9wZM69fcTID7iTgISpTFsnk6GkSlekz358SpzbEBvO1OjrEPJ/UJ04jBCoNaaPyDlhi0HDcMWbP9iO+aTN5oatu0WPxq2bFbdaVDfBPjf94Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD6AC43390;
	Tue, 20 Feb 2024 23:14:32 +0000 (UTC)
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
Subject: [PATCH v6 10/12] cxl/region: Add sysfs attribute for locality attributes of CXL regions
Date: Tue, 20 Feb 2024 16:12:39 -0700
Message-ID: <20240220231402.3156281-11-dave.jiang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220231402.3156281-1-dave.jiang@intel.com>
References: <20240220231402.3156281-1-dave.jiang@intel.com>
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

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v6:
- Use macros to reduce duplicated code. (Jonathan)
- Combine documentation entries. (Jonathan)
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
index 9a0d2d7621de..61249a6b42c7 100644
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
+	NULL,
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
+	NULL,
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
2.43.0


