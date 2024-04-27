Return-Path: <linux-acpi+bounces-5439-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC678B4810
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Apr 2024 22:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF685281C97
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Apr 2024 20:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5B6146586;
	Sat, 27 Apr 2024 20:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fDPRGa20"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B82B146013
	for <linux-acpi@vger.kernel.org>; Sat, 27 Apr 2024 20:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714250229; cv=none; b=nnmxrtbqj5jy6TEJcyOkMLa1eczT6nXQyQuY+COIqqOeaTgz1Q3qYN61jXTwSvZeOBsVXHNNyJHNb+LIv9FYd7nbD2I3S8wmhEZsPcwx1ak7/sNoCKu9dmHKLb9vPTEAAeRoBNJeAc0jKTrP5gdic01kxerT1WLYR8ccHn+62hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714250229; c=relaxed/simple;
	bh=84vNZ3nmzMiKLywUCaQxMOTyHtj96UqMDq9BjY9biKM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EQZzZ+EY72c9sEfdu5gaLyrmHQ5meWdHLOIoiN5NUpM26AHnu5iQUWh/dlUn7XEHW+RjYoL7SwPpgLNMu+fnXbDFCPCZC9MBHeEhT6KMRp85hesYtti2udFMeB+JmhVtef3Bynn08BM94ZSS28rWw8ki38j1lxaif9AYNOgxALk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fDPRGa20; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714250224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=89hBKLXcLRSTgQwaDLYQQNky8U7DVywScwGQ66L4gss=;
	b=fDPRGa20xofVpruZB625R2dpAIcxLgCl9awbjtM1HUfw0QFK/ACYmv9nhUFlyMgdwc0L4U
	RyrmD6QxHRO7v45wBWrM7Enfm1AMycU6E9HlejPHCGMuJzR786sLc32zlnr2om6BNq88pM
	FqKc/vIBrT1kw0JYKWDXAuzinkv2H0E=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v3] software node: Implement device_get_match_data fwnode callback
Date: Sun, 28 Apr 2024 04:36:50 +0800
Message-Id: <20240427203650.582989-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Because the software node backend of the fwnode API framework lacks an
implementation for the .device_get_match_data function callback. This
makes it difficult to use(and/or test) a few drivers that originates
from DT world on the non-DT platform.

Implement the .device_get_match_data fwnode callback, which helps to keep
the three backends of the fwnode API aligned as much as possible. This is
also a fundamental step to make a few drivers OF-independent truely
possible.

Device drivers or platform setup codes are expected to provide a software
node string property, named as "compatible". At this moment, the value of
this string property is being used to match against the compatible entries
in the of_device_id table. It can be extended in the future though.

Fixes: ffb42e64561e ("drm/tiny/repaper: Make driver OF-independent")
Fixes: 5703d6ae9573 ("drm/tiny/st7735r: Make driver OF-independent")
Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Daniel Scally <djrscally@gmail.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
---
v1 -> v2: Update commit message
v2 -> v3: Move a loop invariant conditional out of while clause
---
 drivers/base/swnode.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index eb6eb25b343b..b6f40715c4f8 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -15,6 +15,7 @@
 #include <linux/kobject.h>
 #include <linux/kstrtox.h>
 #include <linux/list.h>
+#include <linux/mod_devicetable.h>
 #include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -390,6 +391,33 @@ static void software_node_put(struct fwnode_handle *fwnode)
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
+	if (!matches)
+		return NULL;
+
+	while (matches->compatible[0]) {
+		if (!strcmp(matches->compatible, val))
+			return matches->data;
+
+		++matches;
+	}
+
+	return NULL;
+}
+
 static bool software_node_property_present(const struct fwnode_handle *fwnode,
 					   const char *propname)
 {
@@ -676,6 +704,7 @@ software_node_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 static const struct fwnode_operations software_node_ops = {
 	.get = software_node_get,
 	.put = software_node_put,
+	.device_get_match_data = software_node_get_match_data,
 	.property_present = software_node_property_present,
 	.property_read_int_array = software_node_read_int_array,
 	.property_read_string_array = software_node_read_string_array,
-- 
2.34.1


