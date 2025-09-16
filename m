Return-Path: <linux-acpi+bounces-17037-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 032BEB59CD2
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 18:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E24D1C03CA4
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 16:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BAA374290;
	Tue, 16 Sep 2025 16:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nJDNfNFP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76896374295
	for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2025 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038506; cv=none; b=FZYWHqDxutpO63Nzuy5XCCwXEZiWwEx9X9GpWPRKCNJ2hAZGFYsxYFbVFi3L26JjyXtdvQoJePtsWfbRGGXtUTP/LScYE6ykYnuOGhWlJw8FB0i8JT/7OBfZ9Xls6sDB2mCodLrHAA69AFZsgcPCvbq83gC9NnRFMNOosOBan/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038506; c=relaxed/simple;
	bh=ip/HVN6uAJqpsMcpsXoCx4aXCUCAsXA45plKmsq1Z7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFMuUn2daOFNwu3ifPDkrkssoZQdF2jOstu2mESGR6RYaAI2hdmTDx7KR8MFcqedYS8rbNHVhM2Rbg5Gt8dLy3jiNJcO451gskksbhuPa49vr0jE65uG3Yu5M0ZrqPUpc9MqcNIHTaR/V8u/HQwrvFulGhpbpM8eQe7E4ntAxRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nJDNfNFP; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758038504; x=1789574504;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ip/HVN6uAJqpsMcpsXoCx4aXCUCAsXA45plKmsq1Z7g=;
  b=nJDNfNFPu8T+WTcRqmmka3yI7ZdBtI/+ssDNqBaYi3VsubEKu16xiaZL
   e59w0osCrxybSpm0w3z2HNrgQXwM31vHMiKzhAedvepSggPD+OW0zsRwd
   MW74Yq67/BDXvcHhV7EAne3+1rEertglh5CeC7rv9xg+lfaE6MSL6KNYV
   LcyKhgNEmAOerB0J2rTJILcDhSx2MO5sdayU1BjWtrT7uoFrI42kPFEZ6
   it5xCJnWFsSY2SQl0BM9QuNh3lhwr9WSJhcQJd/0wnvPqf3m62ki3rmgB
   0e7g7BDGqrElZIMCH10WpjBhdoETjXu9bFybPQmrMcwLegy2yWixuF756
   Q==;
X-CSE-ConnectionGUID: GhK/0B9zSFC1ebImJRajIA==
X-CSE-MsgGUID: 3rvogspbSwytP7iwQGDClA==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="71422984"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="71422984"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 09:01:41 -0700
X-CSE-ConnectionGUID: 4L947SXISOarJr6S03pQrA==
X-CSE-MsgGUID: mHmYsKSUQCy1Bhf7umB+FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="174091546"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.177])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 09:01:38 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 88DC7121F0D;
	Tue, 16 Sep 2025 19:01:30 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uyY7W-0000000Gb0a-2B6k;
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
Subject: [PATCH 13/14] property: Drop functions operating on "available" child nodes
Date: Tue, 16 Sep 2025 19:01:28 +0300
Message-ID: <20250916160129.3955410-14-sakari.ailus@linux.intel.com>
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

fwnode_get_next_available_child_node() and later
fwnode_for_each_available_child_node() were introduced to mirror the OF
interface operating on OF nodes. Now that these two are functionally the
same as the variants without "_available" part, drop the "_available"
variants.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/property.c  | 30 +-----------------------------
 include/linux/property.h |  6 ------
 2 files changed, 1 insertion(+), 35 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index a25040925bf8..04a1256275ce 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -802,35 +802,7 @@ fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
 EXPORT_SYMBOL_GPL(fwnode_get_next_child_node);
 
 /**
- * fwnode_get_next_available_child_node - Return the next available child node handle for a node
- * @fwnode: Firmware node to find the next child node for.
- * @child: Handle to one of the node's child nodes or a %NULL handle.
- *
- * The caller is responsible for calling fwnode_handle_put() on the returned
- * fwnode pointer. Note that this function also puts a reference to @child
- * unconditionally.
- */
-struct fwnode_handle *
-fwnode_get_next_available_child_node(const struct fwnode_handle *fwnode,
-				     struct fwnode_handle *child)
-{
-	struct fwnode_handle *next_child = child;
-
-	if (IS_ERR_OR_NULL(fwnode))
-		return NULL;
-
-	do {
-		next_child = fwnode_get_next_child_node(fwnode, next_child);
-		if (!next_child)
-			return NULL;
-	} while (!fwnode_device_is_available(next_child));
-
-	return next_child;
-}
-EXPORT_SYMBOL_GPL(fwnode_get_next_available_child_node);
-
-/**
- * device_get_next_child_node - Return the next available child node handle for a device
+ * device_get_next_child_node - Return the next available child node handle
  * @dev: Device to find the next child node for.
  * @child: Handle to one of the device's child nodes or a %NULL handle.
  *
diff --git a/include/linux/property.h b/include/linux/property.h
index 8b8bbbe6b5b7..da6202053862 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -161,8 +161,6 @@ struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwn,
 					    unsigned int depth);
 struct fwnode_handle *fwnode_get_next_child_node(
 	const struct fwnode_handle *fwnode, struct fwnode_handle *child);
-struct fwnode_handle *fwnode_get_next_available_child_node(
-	const struct fwnode_handle *fwnode, struct fwnode_handle *child);
 
 #define fwnode_for_each_child_node(fwnode, child)			\
 	for (child = fwnode_get_next_child_node(fwnode, NULL); child;	\
@@ -172,10 +170,6 @@ struct fwnode_handle *fwnode_get_next_available_child_node(
 	fwnode_for_each_child_node(fwnode, child)			\
 		for_each_if(fwnode_name_eq(child, name))
 
-#define fwnode_for_each_available_child_node(fwnode, child)		       \
-	for (child = fwnode_get_next_available_child_node(fwnode, NULL); child;\
-	     child = fwnode_get_next_available_child_node(fwnode, child))
-
 struct fwnode_handle *device_get_next_child_node(const struct device *dev,
 						 struct fwnode_handle *child);
 
-- 
2.47.3


