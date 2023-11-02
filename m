Return-Path: <linux-acpi+bounces-1147-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8167DEE2F
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 09:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2D42B2105B
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 08:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DB879C7
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 08:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nJ1hciEz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC15B6FD5;
	Thu,  2 Nov 2023 08:22:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F7D111;
	Thu,  2 Nov 2023 01:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698913359; x=1730449359;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vBSds/gTpfNc10t6+hxe6aDfRKotMg4nmb4CB+V0TUo=;
  b=nJ1hciEzQb02eqfnYs7ewhQ0j1Gh+qp0x2dNV+B2r3Dg0iUBlDfbZ7Ff
   m6oA90k4YEHe74cKGeYHtBeO3rLZ6/nKh9B/m9MiL20p1B9YJxw+gyTQ/
   kYRUr8Ilyqi1zfplSZqRFo2qvS8KoXSAKRbVBusGgVafXCH+nJpL1422P
   9veOw9SJCjOzbHSG9rdSMdvkr0H0cJEzPO43/sS9y323s5w7DT7FMrQ6w
   /gMWoAlDCvEBPEyqY8evzy59btTQ9YwZDxcMPnkQZrZ1rSgImRPZIFJUc
   B0uJaRlcGB5Rz59IVBCqXoxnWp8fhr7jl+1z7IyJB751mWPE44v0RdQ8Q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="385837180"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="385837180"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 01:22:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="878160265"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="878160265"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 01:22:34 -0700
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id B3C5111F9E8;
	Thu,  2 Nov 2023 10:16:13 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org,
	rafael@kernel.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-media@vger.kernel.org,
	Paul Elder <paul.elder@ideasonboard.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Julien Stephan <jstephan@baylibre.com>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 1/1] device property: Add fwnode_name_eq()
Date: Thu,  2 Nov 2023 10:16:11 +0200
Message-Id: <20231102081611.1179964-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add fwnode_name_eq() to implement the functionality of of_node_name_eq()
on fwnode property API. The same convention of ending the comparison at
'@' (besides NUL) is applied on also both ACPI and swnode. The function
is intended for comparing unit address-less node names on DT and firmware
or swnodes compliant with DT bindings.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
Hi Rafael,

Could we merge this via the media tree (pending further review comments,
if any)? There'a a patch to be merged via that tree which will depend on
fwnode_name_eq(), namely:
<URL:https://lore.kernel.org/linux-media/20231030133247.11243-1-laurent.pinchart@ideasonboard.com/T/#m489b7e83cbc755815c5002f85454a76bfb41adb2>.

since v2:

- Use NUL instead of '\0' and "at" instead of "to" (before "stopping
  comparison").

 drivers/base/property.c  | 28 ++++++++++++++++++++++++++++
 include/linux/property.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 8667b13639d2..572e065e8797 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -595,6 +595,34 @@ const char *fwnode_get_name_prefix(const struct fwnode_handle *fwnode)
 	return fwnode_call_ptr_op(fwnode, get_name_prefix);
 }
 
+/**
+ * fwnode_name_eq - Return true if node name is equal
+ * @fwnode: The firmware node
+ * @name: The name to which to compare the node name
+ *
+ * Compare the name provided as an argument to the name of the node, stopping
+ * the comparison at either NUL or '@' character, whichever comes first. This
+ * function is generally used for comparing node names while ignoring the
+ * possible unit address of the node.
+ *
+ * Return: true if the node name matches with the name provided in the @name
+ * argument, false otherwise.
+ */
+bool fwnode_name_eq(const struct fwnode_handle *fwnode, const char *name)
+{
+	const char *node_name;
+	size_t len;
+
+	node_name = fwnode_get_name(fwnode);
+	if (!node_name)
+		return false;
+
+	len = strchrnul(node_name, '@') - node_name;
+
+	return str_has_prefix(node_name, name) == len;
+}
+EXPORT_SYMBOL_GPL(fwnode_name_eq);
+
 /**
  * fwnode_get_parent - Return parent firwmare node
  * @fwnode: Firmware whose parent is retrieved
diff --git a/include/linux/property.h b/include/linux/property.h
index 083a1f41364b..096ade186601 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -108,6 +108,7 @@ struct fwnode_handle *fwnode_find_reference(const struct fwnode_handle *fwnode,
 
 const char *fwnode_get_name(const struct fwnode_handle *fwnode);
 const char *fwnode_get_name_prefix(const struct fwnode_handle *fwnode);
+bool fwnode_name_eq(const struct fwnode_handle *fwnode, const char *name);
 
 struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode);
 struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode);
-- 
2.39.2


