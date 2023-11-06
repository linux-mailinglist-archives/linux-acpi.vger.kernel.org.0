Return-Path: <linux-acpi+bounces-1249-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A987E1C3A
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 09:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 129DD280C4F
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 08:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5EE156D8
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 08:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z4Ln4jBq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DA82F47;
	Mon,  6 Nov 2023 07:40:40 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B692AF;
	Sun,  5 Nov 2023 23:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699256439; x=1730792439;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pCrnP5rHZmj4ISuVRVw65rZpqm5s3mY61ftuGZidaTY=;
  b=Z4Ln4jBqcvYUYqMusg7Fm1lqgxPBg6n5K8CrEMG5BpXfxrOb+pk2nDdq
   52J3OO8yO71zrgxmL+M96+jqhXut5LRXrfwY4Vjju+wKbwcu6QgTcDQn3
   Stj9tGcbg5h5lH/fBwHMtVITaR60lWyAo8ppMcD0DZGo4OqlGBkhnMHWu
   wKTO53S8+Cvt4e4agsK+o2XiNYl63yy/ueFkKapEMsT5lclQHt9Bavogt
   xlFEF37H3V5mNWP6Zx46xheWT+Al7D3I/nfZnLtrDk6Nru15+aN199T90
   IJzD643szIIDV/r/Xm51e08ETenv6c4d7LjXAyzI97dCV03AbDtVOSsnQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="386398682"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="386398682"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 23:40:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="797229586"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="797229586"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 23:40:34 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 429AA11F724;
	Mon,  6 Nov 2023 09:31:45 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
	linux-mediatek@lists.infradead.org,
	rafael@kernel.org
Subject: [RESEND PATCH v4 1/1] device property: Add fwnode_name_eq()
Date: Mon,  6 Nov 2023 09:31:41 +0200
Message-Id: <20231106073141.1250344-1-sakari.ailus@linux.intel.com>
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
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
---
Hi Greg,

Could we merge this via the media tree?

Another patch (or rather a future version of it) there would need it:
<URL:https://lore.kernel.org/linux-media/20231030133247.11243-1-laurent.pinchart@ideasonboard.com/T/#m489b7e83cbc755815c5002f85454a76bfb41adb2>.

since v3:

- Use ptrdiff_t type for len.

 drivers/base/property.c  | 28 ++++++++++++++++++++++++++++
 include/linux/property.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 8667b13639d2..f20379c9a5c9 100644
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
+	ptrdiff_t len;
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


