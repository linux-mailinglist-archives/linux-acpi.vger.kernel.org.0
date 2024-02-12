Return-Path: <linux-acpi+bounces-3397-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F0D851055
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Feb 2024 11:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4BB21C22050
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Feb 2024 10:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6B817C62;
	Mon, 12 Feb 2024 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NqjNY2kK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9488B17BC2
	for <linux-acpi@vger.kernel.org>; Mon, 12 Feb 2024 10:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707732522; cv=none; b=bYr7DgRTxQAoqj9QTi28QmPNjf82BElzLL2KjoRgONmWyPhbg23V3xXtnmOgRDdzIHNNf9k8oCiWM/h79s32fITSVUgn6y11NoDHZVvQOYVuH0oj0HW6r2AyQYXaE0jp2SibNcT/7yR5CHjF3vzNjSF/UltI/4hqck51d5p2af0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707732522; c=relaxed/simple;
	bh=k8QVgH4+krOKol/STMCuoIzq0qCnkcZNv92l2VStESY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aG+mu06i69ViUsSgeIxMPl2DslElV/3kbgb8LSE4ILVoPxobuZE/K7doZsKqrFpv8/FbWwIHvg0BUfHLmP4Y9+rjHXL8uWibJCcyKvm9pu3XZ16Ek1H3kCNpqb+PTEdVri4RV1n+wxW9ScPF+6XbvcADRSBVV+smpKlSc8xKvcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NqjNY2kK; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707732521; x=1739268521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k8QVgH4+krOKol/STMCuoIzq0qCnkcZNv92l2VStESY=;
  b=NqjNY2kKQm0IVdnh2hYVaZBYRqz+oztzi4xhz5503LHbOvs0W6OlID7m
   aXlW1Zgss3zAhNRZT5rbvbokv2biojFEoATIazNtT0LKT6UEaGWZuUryX
   uHxHyKnzj/prp6fJAvc878c9DSCHEaaDnoR1wW4WUjGc84wOPUxNyE+OX
   gQ4ANACNyHMH49GNvWmoI/dIk9HPwyR2wb28JQ9tkCJgSxZLyDI5tCNX/
   l8kwSPGmSpiD29Uo5FOcjGEEE2c43RhOWLcHgb+ALSg89QzA1hOUnSLlu
   +xcdLMIOIx3kP5cwpvrwebJrmhP749L1P1Vnwiax/6VBMKN+qt4U57H+9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1828603"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="1828603"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 02:08:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="33617875"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 02:08:36 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 2301C11FA12;
	Mon, 12 Feb 2024 12:00:34 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH 2/2] ACPI: property: Ignore bad data nodes
Date: Mon, 12 Feb 2024 12:00:32 +0200
Message-Id: <20240212100032.346422-3-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212100032.346422-1-sakari.ailus@linux.intel.com>
References: <20240212100032.346422-1-sakari.ailus@linux.intel.com>
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
instead. The corresponding information has been added to ipu-bridge to
cover the missing bits.

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
index 7286cf4579bc..2b806112a05a 100644
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
+	static bool dmi_tested = false, ignore_port;
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


