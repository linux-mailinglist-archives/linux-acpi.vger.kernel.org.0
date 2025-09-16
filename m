Return-Path: <linux-acpi+bounces-17033-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D5AB59CD0
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 18:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 551871C02530
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 16:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208B637428F;
	Tue, 16 Sep 2025 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZrqsHfyJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702C93728BD
	for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2025 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038504; cv=none; b=SSlnwtGs4aGoXIBy5L+v5nCwik6YFbGa9IjGlQT2mHK38nl2rTGM9/ek4dIX+2+hr9iZeIYG6X47OtJLeICUXhHtyZu+wWZxXuv3JtgQ74QCasx6gJvUEgUfbYLpqfcgIceNjMW3VBYScyPCrKWT3esO9ZM8L+FLzV04nHlCESM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038504; c=relaxed/simple;
	bh=W0b4p37CBihZL73njJioYhBBV2ohPHzY3NKaMoAuWj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AX0PIynZGoCZf6QaeCPhdV9JKCeMn3cT+8lNpgvM2xs7cIzasnBVcKDCgfm2Pu3EAYEpj743S+EQnm37t/jHlhaz5tt6K3jXGYnMsNyZgK+ZNse8kYKlSujdo4RbfK1eL+xTF+YZqP2EGNvDymBwY8AXUG739wch8nMk+15Vilg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZrqsHfyJ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758038502; x=1789574502;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W0b4p37CBihZL73njJioYhBBV2ohPHzY3NKaMoAuWj4=;
  b=ZrqsHfyJ4d+IXeZ78A369DN14NJ3S0RyZbww0hqOSW9vxcr2G7wFrPIw
   eZ6TOHNb7d7LQ8EqrRjnWjbp8WxJMosKl74KtD++aJY/+EffIJiA91os0
   w+IQcavjyr9jlj47KP8450E6giZiLZekv9WpprEsO11jWzf6JkgGTvxnD
   EL26WHX+83tx7kjggcmCueJuWlOhXPKu4sTyRzfD8IaHO1rxKJjlUVVfj
   VCsOm9wUUJp7KbHwRWJ22W+uTQSmpLeMkbN+nctn/nM3ph7nvxqM4yhqD
   3vhQ/xjGiq3IHnCbmIoHtXcgo+gLmONCXZd0Zldwby90HBmDHkXXJC4iT
   A==;
X-CSE-ConnectionGUID: MjYx/YWcRqCiRWuS4NPSuA==
X-CSE-MsgGUID: yCbUmH/hTrmYGITYhHvMpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="71422963"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="71422963"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 09:01:40 -0700
X-CSE-ConnectionGUID: BsZjpyncQUe8HaqrZ9x/Pg==
X-CSE-MsgGUID: AXRtOX3sTtyOdHz1nIvSfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="174091536"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.177])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 09:01:38 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 71C1D121F05;
	Tue, 16 Sep 2025 19:01:30 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uyY7W-0000000Gb00-1lmp;
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
Subject: [PATCH 06/14] property: Document that fwnode API returns available nodes
Date: Tue, 16 Sep 2025 19:01:21 +0300
Message-ID: <20250916160129.3955410-7-sakari.ailus@linux.intel.com>
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

The fwnode API has historically provided two functions to iterate over a
fwnode's child nodes, fwnode_get_next_child_node() and
fwnode_get_next_available_child_node() whereas all of the fwnode API has
always worked on available nodes, apart unavailable ACPI child device
nodes could have been returned by fwnode_get_next_child_node().

Now that the availability check has been added to ACPI side as well,
document that the functions in the fwnode API return available nodes.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/property.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 2e0ff0232b27..a25040925bf8 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -785,7 +785,7 @@ struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwnode,
 EXPORT_SYMBOL_GPL(fwnode_get_nth_parent);
 
 /**
- * fwnode_get_next_child_node - Return the next child node handle for a node
+ * fwnode_get_next_child_node - Return the next available child node handle
  * @fwnode: Firmware node to find the next child node for.
  * @child: Handle to one of the node's child nodes or a %NULL handle.
  *
@@ -830,7 +830,7 @@ fwnode_get_next_available_child_node(const struct fwnode_handle *fwnode,
 EXPORT_SYMBOL_GPL(fwnode_get_next_available_child_node);
 
 /**
- * device_get_next_child_node - Return the next child node handle for a device
+ * device_get_next_child_node - Return the next available child node handle for a device
  * @dev: Device to find the next child node for.
  * @child: Handle to one of the device's child nodes or a %NULL handle.
  *
@@ -858,7 +858,7 @@ struct fwnode_handle *device_get_next_child_node(const struct device *dev,
 EXPORT_SYMBOL_GPL(device_get_next_child_node);
 
 /**
- * fwnode_get_named_child_node - Return first matching named child node handle
+ * fwnode_get_named_child_node - Return first available matching named child node handle
  * @fwnode: Firmware node to find the named child node for.
  * @childname: String to match child node name against.
  *
@@ -874,7 +874,7 @@ fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
 EXPORT_SYMBOL_GPL(fwnode_get_named_child_node);
 
 /**
- * device_get_named_child_node - Return first matching named child node handle
+ * device_get_named_child_node - Return first available matching named child node handle for a device
  * @dev: Device to find the named child node for.
  * @childname: String to match child node name against.
  *
@@ -928,7 +928,7 @@ bool fwnode_device_is_available(const struct fwnode_handle *fwnode)
 EXPORT_SYMBOL_GPL(fwnode_device_is_available);
 
 /**
- * fwnode_get_child_node_count - return the number of child nodes for a given firmware node
+ * fwnode_get_child_node_count - Return the number of available child nodes for a given firmware node
  * @fwnode: Pointer to the parent firmware node
  *
  * Return: the number of child nodes for a given firmware node.
@@ -946,7 +946,7 @@ unsigned int fwnode_get_child_node_count(const struct fwnode_handle *fwnode)
 EXPORT_SYMBOL_GPL(fwnode_get_child_node_count);
 
 /**
- * fwnode_get_named_child_node_count - number of child nodes with given name
+ * fwnode_get_named_child_node_count - Return the number of available child nodes with given name
  * @fwnode: Node which child nodes are counted.
  * @name: String to match child node name against.
  *
-- 
2.47.3


