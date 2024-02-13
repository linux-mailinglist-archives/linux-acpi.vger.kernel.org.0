Return-Path: <linux-acpi+bounces-3452-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 928B4853231
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Feb 2024 14:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DC3F28180F
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Feb 2024 13:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C39356468;
	Tue, 13 Feb 2024 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nclP84Ux"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8985655C1D
	for <linux-acpi@vger.kernel.org>; Tue, 13 Feb 2024 13:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707831976; cv=none; b=gSeJ9HFRGvvwpIEo2+vyCDPQ0EZ1mZMbN3ti29fASWULjIFUDirrHtIxOzIGqd7gtFMQ94pg03Iwr/ilsUCDP5CZool6uZ0qx/OX9BeSPKqnrGbqLv3h+lePkC3xAw4IU81lese5Jj0Q4LUTDzxiSI7eb51+hmSwdvAcem9HeH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707831976; c=relaxed/simple;
	bh=8rzeWomKjFDbpxN+10h1iEcLWtkTj9WveWna+xoInh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VssCENQ8wPFLnnu+pZSZeM1ahb9F3rwDCs5j1xDGPJ5ojDjqhWDN3BmH1r17DUNj2SIGMub52uZvEYwTTxmRSqCjt9Knnn3lt75WZvawN/j0ptnWPimjEwOgIrEXTGUqsSYPNQhNiyBG/GCvy5FqKZmgi3zCXp9zDzADgN1sYxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nclP84Ux; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707831975; x=1739367975;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8rzeWomKjFDbpxN+10h1iEcLWtkTj9WveWna+xoInh8=;
  b=nclP84UxoLapnaBLTXt2RQSza61tPTnK/sIgaMUYT5AE242FhQOe+mws
   kjtU7nMclPfQGDmJZxmXdzZu+wrmlhYhd8oPqIjynbs8qIORcg78dkzgf
   z9niucSVN+tqfaN2l+vFKem7tZoHKLVnG0C6ignZdjfxrNKLKLWcFGZg3
   HsXO4bAbELR4LvX9xM0N+GGXZVDftY/MMQgjwO4Hu9T5H142tmUtwSs+B
   kdOT3PWxuyxS9ag4tKLh2UgPDlELfYlKZez/+YC2gsGjrXzNE5xqRDWWS
   qsCQMFZKGCRHyKcjLOV/4xzZRsRODfZvLaAgxiIwJikHH203lZ4ITu92x
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1743675"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="1743675"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 05:46:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="3207230"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 05:46:11 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 5A7E211F9DB;
	Tue, 13 Feb 2024 15:46:08 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH v2 2/2] ACPI: property: Ignore bad graph port nodes on Dell XPS 9315
Date: Tue, 13 Feb 2024 15:46:06 +0200
Message-Id: <20240213134606.383817-3-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213134606.383817-1-sakari.ailus@linux.intel.com>
References: <20240213134606.383817-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some systems were shipped with both Windows and Linux camera descriptions.
In general, if Linux description exist, they will be used and Windows
description ignored.

In this case the Linux descriptions were buggy so use Windows definition
instead. This patch ignores the bad graph port nodes on Dell XPS 9315 and
there are likely other such systems, too. The corresponding information
has been added to ipu-bridge to cover the missing bits.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/internal.h       |  1 +
 drivers/acpi/mipi-disco-img.c | 71 +++++++++++++++++++++++++++++++++++
 drivers/acpi/property.c       |  3 ++
 3 files changed, 75 insertions(+)

diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 6588525c45ef..e0145df519bd 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -301,5 +301,6 @@ void acpi_mipi_check_crs_csi2(acpi_handle handle);
 void acpi_mipi_scan_crs_csi2(void);
 void acpi_mipi_init_crs_csi2_swnodes(void);
 void acpi_mipi_crs_csi2_cleanup(void);
+bool acpi_graph_ignore_port(acpi_handle handle);
 
 #endif /* _ACPI_INTERNAL_H_ */
diff --git a/drivers/acpi/mipi-disco-img.c b/drivers/acpi/mipi-disco-img.c
index 7286cf4579bc..da71eb4bf6a6 100644
--- a/drivers/acpi/mipi-disco-img.c
+++ b/drivers/acpi/mipi-disco-img.c
@@ -19,6 +19,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/dmi.h>
 #include <linux/limits.h>
 #include <linux/list.h>
 #include <linux/module.h>
@@ -723,3 +724,73 @@ void acpi_mipi_crs_csi2_cleanup(void)
 	list_for_each_entry_safe(csi2, csi2_tmp, &acpi_mipi_crs_csi2_list, entry)
 		acpi_mipi_del_crs_csi2(csi2);
 }
+
+static const struct dmi_system_id dmi_ignore_port_nodes[] = {
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 9315"),
+		},
+	},
+	{ 0 }
+};
+
+static const char *strnext(const char *s1, const char *s2)
+{
+	s1 = strstr(s1, s2);
+
+	if (!s1)
+		return NULL;
+
+	return s1 + strlen(s2);
+}
+
+/**
+ * acpi_graph_ignore_port - Tell whether a port node should be ignored
+ * @handle: The ACPI handle of the node (which may be a port node)
+ *
+ * Returns true if a port node should be ignored and the data to that should
+ * come from other sources instead (Windows ACPI definitions and
+ * ipu-bridge). This is currently used to ignore bad port nodes related to IPU6
+ * ("IPU?") and camera sensor devices ("LNK?") in certain Dell systems with
+ * Intel VSC.
+ */
+bool acpi_graph_ignore_port(acpi_handle handle)
+{
+	const char *path = NULL, *orig_path;
+	static bool dmi_tested, ignore_port;
+
+	if (!dmi_tested) {
+		ignore_port = dmi_first_match(dmi_ignore_port_nodes);
+		dmi_tested = true;
+	}
+
+	if (!ignore_port)
+		return false;
+
+	/* Check if the device is either "IPU" or "LNK" (sensor). */
+	orig_path = acpi_handle_path(handle);
+	if (!orig_path)
+		return false;
+	path = strnext(orig_path, "IPU");
+	if (!path)
+		path = strnext(orig_path, "LNK");
+	if (!path)
+		goto out_free;
+
+	if (!(path[0] >= '0' && path[0] <= '9' && path[1] == '.'))
+		goto out_free;
+
+	/* Check if the node has a "PRT" prefix. */
+	path = strnext(path, "PRT");
+	if (path && path[0] >= '0' && path[0] <= '9' && !path[1]) {
+		acpi_handle_debug(handle, "ignoring data node\n");
+
+		kfree(orig_path);
+		return true;
+	}
+
+out_free:
+	kfree(orig_path);
+	return false;
+}
diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index a6ead5204046..2b73580c9f36 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -80,6 +80,9 @@ static bool acpi_nondev_subnode_extract(union acpi_object *desc,
 	struct acpi_data_node *dn;
 	bool result;
 
+	if (acpi_graph_ignore_port(handle))
+		return false;
+
 	dn = kzalloc(sizeof(*dn), GFP_KERNEL);
 	if (!dn)
 		return false;
-- 
2.39.2


