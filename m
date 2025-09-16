Return-Path: <linux-acpi+bounces-17036-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC96B59CE3
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 18:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2569D17E74E
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 16:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E5637428C;
	Tue, 16 Sep 2025 16:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E4CL7WiR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24435374291
	for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2025 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038505; cv=none; b=bTP4UdS90STLQdv8idnsoNAmHlWiQLKSNNOBJxzDdIkUVjHLgOZBRCElgWqbCq5XV8xgXgw5jVtMZGNIPNcGpOM3IztRPFHYppQwNvVN+iWlbTDWRGoDqKBcvNQ+F8n4JQNP2otYG8m7D6TJOqPpThxiqJvtX2Fr5pB1ZUijckY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038505; c=relaxed/simple;
	bh=5G1F7Vnk4GyRSWL4lH+hOF83H6LZc87lTDgnql5p15Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RMIzVxK2MxbvmAf1I3cj0/AxSLkgL8kuJdgH8qZQWZy4d1NYafbxauMeuBTFkAAA4FskjdctoIIFoX2AcOnAejs78ld1Dv/MM2PtKnDrJyJw6AP4p6lZn+0qav5K4zI6DScg8rphb8E8albccGfE6++OUSxHM6IubNEk6pH0rww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E4CL7WiR; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758038504; x=1789574504;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5G1F7Vnk4GyRSWL4lH+hOF83H6LZc87lTDgnql5p15Q=;
  b=E4CL7WiR/lRfka9js5owyOT6PWsi69PgREuOfit+HgvDvlCCMNhTlYS1
   s9bmBukpQDr112DmO4YRKXAewgrz/TIkXRig86vyNYyd27/VWjtuCMEm+
   R5oRPfZ/hSy+4Vn4LqAzwNlah3GUmC4SIk6HEDIXFa3d1NAu/PMBihzOx
   33Qk5OYLgLykOiv0UyYwuoUeAOVhAt4gR4RKIJMz4b98n9VH9fwKM1kHF
   IQLybx80LRWcNNr0zIZu7TRrtZKzdl/U6acWgOAh88RVlQ1r1cBsFIVer
   QXSgKOH9GPlPwRoAMxWR2l0Vd0yMRcYZ/LDxefzFAwlhVNzhqKdHI4Om1
   g==;
X-CSE-ConnectionGUID: y4VjvUGcQJGiZOqpGXNRoQ==
X-CSE-MsgGUID: XwudIEWfSf+9amR7QD41FQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="71422970"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="71422970"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 09:01:41 -0700
X-CSE-ConnectionGUID: nTOEXo60QxWsSekwEZpS/w==
X-CSE-MsgGUID: 4uRBu0EHQ0ypJ29inkoYUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="174091538"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.177])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 09:01:38 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 74DB3121F06;
	Tue, 16 Sep 2025 19:01:30 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uyY7W-0000000Gb06-1pKg;
	Tue, 16 Sep 2025 19:01:30 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 07/14] driver core: Use fwnode_for_each_child_node() instead
Date: Tue, 16 Sep 2025 19:01:22 +0300
Message-ID: <20250916160129.3955410-8-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250916160129.3955410-1-sakari.ailus@linux.intel.com>
References: <20250916160129.3955410-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fwnode_for_each_child_node() is now the same as
fwnode_for_each_available_child_node() on all backends (OF, ACPI and
swnode). In order to remove the available variants, switch the uses to
non-available variants.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index d22d6b23e758..4bffd347e2f9 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -185,7 +185,7 @@ void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode)
 	fwnode->flags |= FWNODE_FLAG_NOT_DEVICE;
 	fwnode_links_purge_consumers(fwnode);
 
-	fwnode_for_each_available_child_node(fwnode, child)
+	fwnode_for_each_child_node(fwnode, child)
 		fw_devlink_purge_absent_suppliers(child);
 }
 EXPORT_SYMBOL_GPL(fw_devlink_purge_absent_suppliers);
@@ -231,7 +231,7 @@ static void __fw_devlink_pickup_dangling_consumers(struct fwnode_handle *fwnode,
 	fwnode->flags |= FWNODE_FLAG_NOT_DEVICE;
 	__fwnode_links_move_consumers(fwnode, new_sup);
 
-	fwnode_for_each_available_child_node(fwnode, child)
+	fwnode_for_each_child_node(fwnode, child)
 		__fw_devlink_pickup_dangling_consumers(child, new_sup);
 }
 
@@ -1318,7 +1318,7 @@ void device_links_driver_bound(struct device *dev)
 
 		guard(mutex)(&fwnode_link_lock);
 
-		fwnode_for_each_available_child_node(dev->fwnode, child)
+		fwnode_for_each_child_node(dev->fwnode, child)
 			__fw_devlink_pickup_dangling_consumers(child,
 							       dev->fwnode);
 		__fw_devlink_link_to_consumers(dev);
@@ -1736,7 +1736,7 @@ static void fw_devlink_parse_fwtree(struct fwnode_handle *fwnode)
 
 	fw_devlink_parse_fwnode(fwnode);
 
-	while ((child = fwnode_get_next_available_child_node(fwnode, child)))
+	while ((child = fwnode_get_next_child_node(fwnode, child)))
 		fw_devlink_parse_fwtree(child);
 }
 
@@ -2309,7 +2309,7 @@ static void __fw_devlink_link_to_suppliers(struct device *dev,
 	 * case where the supplier is added before the consumer's parent device
 	 * (@dev).
 	 */
-	while ((child = fwnode_get_next_available_child_node(fwnode, child)))
+	while ((child = fwnode_get_next_child_node(fwnode, child)))
 		__fw_devlink_link_to_suppliers(dev, child);
 }
 
-- 
2.47.3


