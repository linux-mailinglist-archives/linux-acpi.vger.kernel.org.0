Return-Path: <linux-acpi+bounces-4370-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 391A487F42F
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Mar 2024 00:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5834281249
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Mar 2024 23:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C125F85C;
	Mon, 18 Mar 2024 23:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z8rzyd6x"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1E45F859
	for <linux-acpi@vger.kernel.org>; Mon, 18 Mar 2024 23:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710805357; cv=none; b=LM/sVi1juz0STUeFpukryLt/kJJ0t3fxpuz6nzDSU1I1imjjMyYdWcjmrphAzu1lXeCWuxt/dO8kMP5bCTGdkv7FCzrImHNKurzjccdBSNUZaJtS4MGdyYZDMR+HaTCW0I1FCuiSW6DW8dYUUlQ48O2VQs3xA4SpE0zIBAms4BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710805357; c=relaxed/simple;
	bh=pGOvfu2z8KNkO7muzJdm/yKDZ5YG9b5n5cu77cFk1OU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eNL8dvzXMGfhryIV69nYVMeUxWy+nBgposGtzZIMSYDnIAqJyVHHAojurpVBNkp2Z1WXX0Nql9douz8vZzJ7MWWYygeyP8+2yr6T2Mwnpr1bofGynJc/imdi2V0l3gjKY7R3xaeiarefyxhiirWjJSbv8iz9DfUxGLDZM2swHzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z8rzyd6x; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710805353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w0W1TcwjE/iK1zTqE+wMMVfVgJ37P2hH21l+AHsTGLU=;
	b=Z8rzyd6xT1dNzDVSCg4FMo4Giv0Hab4i1vuixvZyDpIfCN1gIe7/RcxmKBV28btFqI0/MA
	Hw85v/PXbgXcRzfvd/iy4106ivcrwLMmWr8LVcgfkLDKNiq8sH1/PzKDAMBkfCnwL5oQwC
	zq8ZSOIJgMjL7reRdWijDLqfqe5Kmrw=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-acpi@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH] software node: Implement device_get_match_data fwnode callback
Date: Tue, 19 Mar 2024 07:42:22 +0800
Message-Id: <20240318234222.1278882-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This makes it possible to support (and/or test) a few drivers that
originates from DT World on the x86-64 platform. Originally, those
drivers using the of_device_get_match_data() function to get match
data. For example, drivers/gpu/drm/bridge/simple-bridge.c and
drivers/gpu/drm/bridge/display-connector.c. Those drivers works very
well in the DT world, however, there is no counterpart to
of_device_get_match_data() when porting them to the x86 platform,
because x86 CPUs lack DT support.

By replacing it with device_get_match_data() and creating a software
graph that mimics the OF graph, everything else works fine, except that
there isn't an out-of-box replacement for the of_device_get_match_data()
function. Because the software node backend of the fwnode framework lacks
an implementation for the device_get_match_data callback.

Implement device_get_match_data fwnode callback fwnode callback to fill
this gap. Device drivers or platform setup codes are expected to provide
a "compatible" string property. The value of this string property is used
to match against the compatible entries in the of_device_id table. Which
is consistent with the original usage style.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/base/swnode.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 36512fb75a20..3670094592f2 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -8,6 +8,7 @@
 
 #include <linux/device.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/property.h>
 #include <linux/slab.h>
 
@@ -379,6 +380,30 @@ static void software_node_put(struct fwnode_handle *fwnode)
 	kobject_put(&swnode->kobj);
 }
 
+static const void *
+software_node_get_match_data(const struct fwnode_handle *fwnode,
+			     const struct device *dev)
+{
+	struct swnode *swnode = to_swnode(fwnode);
+	const struct of_device_id *matches = dev->driver->of_match_table;
+	const char *val = NULL;
+	int ret;
+
+	ret = property_entry_read_string_array(swnode->node->properties,
+					       "compatible", &val, 1);
+	if (ret < 0 || !val)
+		return NULL;
+
+	while (matches && matches->compatible[0]) {
+		if (!strcmp(matches->compatible, val))
+			return matches->data;
+
+		matches++;
+	}
+
+	return NULL;
+}
+
 static bool software_node_property_present(const struct fwnode_handle *fwnode,
 					   const char *propname)
 {
@@ -665,6 +690,7 @@ software_node_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 static const struct fwnode_operations software_node_ops = {
 	.get = software_node_get,
 	.put = software_node_put,
+	.device_get_match_data = software_node_get_match_data,
 	.property_present = software_node_property_present,
 	.property_read_int_array = software_node_read_int_array,
 	.property_read_string_array = software_node_read_string_array,
-- 
2.34.1


