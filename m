Return-Path: <linux-acpi+bounces-17027-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC706B59CD5
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 18:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B595A3A8A74
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 16:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445122BEC3D;
	Tue, 16 Sep 2025 16:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RnA7xqUN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732562C0F73
	for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2025 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038499; cv=none; b=rSR8qmuzjRFQDvXvFdVZK/drfb/NbFSnArfzvockaZebYAfInitXyS8FdZv21zdFLJYxufwp/R9iVlXKF8hzaOf88ZWSgXnK7DNjkGJadTT7Aes44045YvlmjJaq88UXkT1UlLILrnXm0kR1W5tivA+3+9o01zkrfIDkiCrLO+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038499; c=relaxed/simple;
	bh=lc9Glr9BwzhFBLnbso28BCvb5e7Kjl++8bpVTtvOtKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fg5kJvLq5kS5dliyj+F2JMiNRRjRyHKHBng7TdApSHvj1tGNA0Ynxq8e6kTEhv1rABF7r1FlnaJ7znrlvlwL0UHgP9eApqwivWQMKYgSWtelwynheaWKQu3gomBArb/al9ICq9BTLdMcNHbl7C/cxgAl5i9lqO8q2t7G+mAc90c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RnA7xqUN; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758038498; x=1789574498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lc9Glr9BwzhFBLnbso28BCvb5e7Kjl++8bpVTtvOtKk=;
  b=RnA7xqUNM4pJFvSI3lW8jZOFdOFeXxsGeSeElQzo+c3tevGKW8C++BCz
   vgG8b4mwv+nP7p7FH7LDs0YtRTjeSNFOLD+wHLj2p9j9Uh1QNBpvNUqZt
   SpHboNVYwI0YkEw+c+ShOxeqIBoATArKEZvg87Td4eenM/aN9G/pbGRqy
   FpGRdqyZDXp/FZcPZDqF2tI7LggiUiR008euj6+ka6JALKSn5m4yocKN5
   3sgsp7Nloukj7gg0gC/LlvlFBwSN2rjquLyEBT4n6+4e+t0UCt3WISzpn
   6t00VAp7owrG8MkDqtz/82d9d4wek7lD7BfghC3ToHS7JdUOJF7oYgsav
   Q==;
X-CSE-ConnectionGUID: bhb36k4/T2WxbxidFLc8Kg==
X-CSE-MsgGUID: IeiIukWSReeZwUTICNf3CA==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="71422925"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="71422925"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 09:01:36 -0700
X-CSE-ConnectionGUID: U4TTSYelTsOBW3vWNrkWdw==
X-CSE-MsgGUID: alPZHdYSSc+APmghdbFuVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="174091515"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.177])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 09:01:33 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 66D8B121F01;
	Tue, 16 Sep 2025 19:01:30 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uyY7W-0000000Gazh-1ThH;
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
Subject: [PATCH 02/14] ACPI: property: Make acpi_get_next_subnode() static
Date: Tue, 16 Sep 2025 19:01:17 +0300
Message-ID: <20250916160129.3955410-3-sakari.ailus@linux.intel.com>
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

acpi_get_next_subnode() is only used in drivers/acpi/property.c. Remove
its prototype from include/linux/acpi.h and make it static.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c |  5 +++--
 include/linux/acpi.h    | 10 ----------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 8d9a9876748f..3e85900080ac 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1264,8 +1264,9 @@ static int stop_on_next(struct acpi_device *adev, void *data)
  * @fwnode: Firmware node to find the next child node for.
  * @child: Handle to one of the device's child nodes or a null handle.
  */
-struct fwnode_handle *acpi_get_next_subnode(const struct fwnode_handle *fwnode,
-					    struct fwnode_handle *child)
+static struct fwnode_handle *
+acpi_get_next_subnode(const struct fwnode_handle *fwnode,
+		      struct fwnode_handle *child)
 {
 	struct acpi_device *adev = to_acpi_device_node(fwnode);
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 5ff5d99f6ead..703323b9fe0c 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1349,9 +1349,6 @@ acpi_data_add_props(struct acpi_device_data *data, const guid_t *guid,
 int acpi_node_prop_get(const struct fwnode_handle *fwnode, const char *propname,
 		       void **valptr);
 
-struct fwnode_handle *acpi_get_next_subnode(const struct fwnode_handle *fwnode,
-					    struct fwnode_handle *child);
-
 struct acpi_probe_entry;
 typedef bool (*acpi_probe_entry_validate_subtbl)(struct acpi_subtable_header *,
 						 struct acpi_probe_entry *);
@@ -1450,13 +1447,6 @@ static inline int acpi_node_prop_get(const struct fwnode_handle *fwnode,
 	return -ENXIO;
 }
 
-static inline struct fwnode_handle *
-acpi_get_next_subnode(const struct fwnode_handle *fwnode,
-		      struct fwnode_handle *child)
-{
-	return NULL;
-}
-
 static inline struct fwnode_handle *
 acpi_graph_get_next_endpoint(const struct fwnode_handle *fwnode,
 			     struct fwnode_handle *prev)
-- 
2.47.3


