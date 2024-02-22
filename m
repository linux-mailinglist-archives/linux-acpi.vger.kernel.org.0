Return-Path: <linux-acpi+bounces-3862-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B14B785FADB
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 15:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66BEF1F2529F
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 14:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34037130AD2;
	Thu, 22 Feb 2024 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cIJ1y6ho"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D94131720
	for <linux-acpi@vger.kernel.org>; Thu, 22 Feb 2024 14:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708611210; cv=none; b=JTZ9caF5GjKIl7DdA4MYKcBQG2P8uKagWaKQJBClRE579OymW7SOgs+ITTrf9lLaW1kHlBjLKeyKodYrfC4MqKutJdeEMgmMp/S+BG8ITLW8Il6F9IXaujupqg5nlh7Jtc5uErBpPnzAdhd1vcs4A8Vi1wdY7YkuLgE/wJeI11U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708611210; c=relaxed/simple;
	bh=BsB8ytaU+b+zzCl6+FJVZt2ZH+bPbE9krI57gYI2St0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fZZvVNu0HKng3i00P+XTyPvl7lJgg/B0jKhVXDxt+rgELlNE7UWnkxaib9YY9jS/l0UUfng+JKtQnG1lIGfG5KFCRkfRC1gToYG6pzZLRfRaszWIaQpJAiJvsQZHE3ds30R+fpnWyUafXWyuF4wae9lUgqzkhKgIqqSJhfGhgY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cIJ1y6ho; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708611208; x=1740147208;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BsB8ytaU+b+zzCl6+FJVZt2ZH+bPbE9krI57gYI2St0=;
  b=cIJ1y6hodqeyYlDmAB8p26DdHFg/Ay7zMDoY5FCOVS9IZKtJdJ03loIl
   GHfaRVOQsRo6fiXQCcvCAPYnLtOfbnOKd8tnhA3Mb1dFExvXc+QC532AA
   ejVxpfp3GszoBTeJpTuMxwr6xiBLQub778Qx4nDQdXoaDL5/c4Om2ZWLV
   8wtH3RKHPD0iSq9pB6k9Q6K+aPO53OHueN6sr5Wc9HNzTpuyNlQi/CjRZ
   SQ3WSNlp8DGjA7S6V7ompFD7m3D2otmEoDDzWbzDHN2t+pqEqEL5eC0cz
   6Cx9ELrpaLnruoI91IZ7MIrBDlHTX4VtnUfQTr6yw035lsmj7gImAQIrR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="6615318"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="6615318"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 06:13:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5489560"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 06:13:26 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 2167D11F81D;
	Thu, 22 Feb 2024 16:13:21 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	"Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Subject: [PATCH 1/1] ACPI: property: Polish ignoring bad data nodes
Date: Thu, 22 Feb 2024 16:13:21 +0200
Message-Id: <20240222141321.616794-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up ignoring data nodes in mipi-disco-img.c: use { } initialiser, fix
a kernel-doc warning and use isdigit().

Fixes: 6018731b04ca ("ACPI: property: Ignore bad graph port nodes on Dell XPS 9315")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
Hi Rafael,

Feel free to squash this to the original patch.

 drivers/acpi/mipi-disco-img.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/mipi-disco-img.c b/drivers/acpi/mipi-disco-img.c
index da71eb4bf6a6..d05413a0672a 100644
--- a/drivers/acpi/mipi-disco-img.c
+++ b/drivers/acpi/mipi-disco-img.c
@@ -732,7 +732,7 @@ static const struct dmi_system_id dmi_ignore_port_nodes[] = {
 			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 9315"),
 		},
 	},
-	{ 0 }
+	{ }
 };
 
 static const char *strnext(const char *s1, const char *s2)
@@ -749,7 +749,7 @@ static const char *strnext(const char *s1, const char *s2)
  * acpi_graph_ignore_port - Tell whether a port node should be ignored
  * @handle: The ACPI handle of the node (which may be a port node)
  *
- * Returns true if a port node should be ignored and the data to that should
+ * Return: true if a port node should be ignored and the data to that should
  * come from other sources instead (Windows ACPI definitions and
  * ipu-bridge). This is currently used to ignore bad port nodes related to IPU6
  * ("IPU?") and camera sensor devices ("LNK?") in certain Dell systems with
@@ -778,12 +778,12 @@ bool acpi_graph_ignore_port(acpi_handle handle)
 	if (!path)
 		goto out_free;
 
-	if (!(path[0] >= '0' && path[0] <= '9' && path[1] == '.'))
+	if (!(isdigit(path[0]) && path[1] == '.'))
 		goto out_free;
 
 	/* Check if the node has a "PRT" prefix. */
 	path = strnext(path, "PRT");
-	if (path && path[0] >= '0' && path[0] <= '9' && !path[1]) {
+	if (path && isdigit(path[0]) && !path[1]) {
 		acpi_handle_debug(handle, "ignoring data node\n");
 
 		kfree(orig_path);
-- 
2.39.2


