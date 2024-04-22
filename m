Return-Path: <linux-acpi+bounces-5257-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4538AD2AD
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Apr 2024 18:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5112BB23DFA
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Apr 2024 16:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACC9153816;
	Mon, 22 Apr 2024 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nyJSqJyr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD3315358B
	for <linux-acpi@vger.kernel.org>; Mon, 22 Apr 2024 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713804437; cv=none; b=lL5dwO4uKshg8sclBT6NpUO1+GvfJDKzNuUF3vj9c2jIzBroX3JOmGODv2sQw6blWBucCYXrnr8OqPRv/B1svlC22bQdNXi40RhRP9d8Y0LBH/DnZ1SxNeQJFKDNdiRel+I+aOL9OFFeya14BJHnWQT6mAdTqf2UMXlLjZuP6aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713804437; c=relaxed/simple;
	bh=JsuHU/uiRlbuXLGd2jq3bAmvz5bvKgsQuAwVRdaR0NM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UXcl/EKMrJc6pAT1Glm4weTqLzCf5pZWXt2RxbaatwD/DSl/CYM67bS2oIruy5XPswysubP8AjweinVL11VlAMzLGuCsFCHwxGDq4tVQVVCPZ1Gwd1CewOiJ4oP3JksubdGXmx3MMqbHKqgDMEx5upwjV5MWSVJoS+YtWd5zyvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nyJSqJyr; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713804431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dcyoi5sOG2B7iFToO0Fnv1/d2q+P/6hiQ3YBRfUehOg=;
	b=nyJSqJyrY26dfbyJrlebkOGESL+TILpfJMgByW5Gme7yAkGMcsxCBV/561pBkf37GgT3RY
	gxiqUdN2qtNaxojlEvtFrjMgOozleQs22/d/dyG6n/Q9b9BypzmtAvNcVkH+6hhO7sLUrh
	deOYvS9qGZtw0XMzcWoaJ/nThDdC3Hc=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2] software node: Implement device_get_match_data fwnode callback
Date: Tue, 23 Apr 2024 00:46:58 +0800
Message-Id: <20240422164658.217037-1-sui.jingfeng@linux.dev>
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

Implement the .device_get_match_data fwnode callback, device drivers or
platform setup codes are expected to provide a string property, named as
"compatible", the value of this software node string property is used to
match against the compatible entries in the of_device_id table.

This also helps to keep the three backends of the fwnode API aligned as
much as possible, which is a fundamential step to make device driver
OF-independent truely possible.

Fixes: ffb42e64561e ("drm/tiny/repaper: Make driver OF-independent")
Fixes: 5703d6ae9573 ("drm/tiny/st7735r: Make driver OF-independent")
Closes: https://lore.kernel.org/lkml/20230223203713.hcse3mkbq3m6sogb@skbuf/
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Daniel Scally <djrscally@gmail.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 V2: Update commit message
 drivers/base/swnode.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index eb6eb25b343b..48d18a90b97b 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/kobject.h>
 #include <linux/kstrtox.h>
+#include <linux/mod_devicetable.h>
 #include <linux/list.h>
 #include <linux/property.h>
 #include <linux/slab.h>
@@ -390,6 +391,30 @@ static void software_node_put(struct fwnode_handle *fwnode)
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
@@ -676,6 +701,7 @@ software_node_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 static const struct fwnode_operations software_node_ops = {
 	.get = software_node_get,
 	.put = software_node_put,
+	.device_get_match_data = software_node_get_match_data,
 	.property_present = software_node_property_present,
 	.property_read_int_array = software_node_read_int_array,
 	.property_read_string_array = software_node_read_string_array,
-- 
2.34.1


