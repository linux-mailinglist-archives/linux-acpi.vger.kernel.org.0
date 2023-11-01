Return-Path: <linux-acpi+bounces-1125-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D70417DDDBF
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 09:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 958D4281395
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 08:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAEC6FCC
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 08:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AKp56bAv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819AA63B0;
	Wed,  1 Nov 2023 07:27:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702D7EA;
	Wed,  1 Nov 2023 00:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698823658; x=1730359658;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7pm77fK1ke7gShb15risUQeIqhs8IPiEf1lI1Wzsra0=;
  b=AKp56bAvVsceXx6vJL3T9qn5U0/c8JyorCqrr98HM4HMsZYtKqHH1odr
   6TDS/5OuJ9nK4d+pHDhCB27DCNitV04QnaCkJDXiT2XlaJWIQyE/L1bVc
   mLeUhd2uszkREnU0HmQW2Comt3TwuvVbP1kUd4Flz+PPnE1x8qizXVpru
   riR63zIF0CGA8AZiR21Qry5OcCIoGiDlEukisGmoKNyzy6IYvgwUY8C4Y
   tqISJ/NoBdM5piTisN0MizNBApO2fuVJ3AXX15HUfO0JWZYtXA8gpCUSw
   AVXOOdB0APzrPR9dqoJDWUHZZ/YjM1Z5+xk1xcwrcjgCauHAKPYGPA00u
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="7076849"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="7076849"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 00:27:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="904568442"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="904568442"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 00:27:34 -0700
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id D33AC11F929;
	Wed,  1 Nov 2023 09:27:29 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
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
Subject: [PATCH v2 1/1] device property: Add fwnode_name_eq()
Date: Wed,  1 Nov 2023 09:27:29 +0200
Message-Id: <20231101072729.1142578-1-sakari.ailus@linux.intel.com>
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
'@' (besides '\0') is applied on also both ACPI and swnode. The function
is intended for comparing unit address-less node names on DT and firmware
or swnodes compliant with DT bindings.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
since v1:

- Use str_has_prefix().

- Fix kernel-doc for @fwnode argument.

- Use size_t type for len.

The patch is untested.

 drivers/base/property.c  | 28 ++++++++++++++++++++++++++++
 include/linux/property.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 8c40abed7852..89a6e0833356 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -594,6 +594,34 @@ const char *fwnode_get_name_prefix(const struct fwnode_handle *fwnode)
 	return fwnode_call_ptr_op(fwnode, get_name_prefix);
 }
 
+/**
+ * fwnode_name_eq - Return true if node name is equal
+ * @fwnode: The firmware node
+ * @name: The name to which to compare the node name
+ *
+ * Compare the name provided as an argument to the name of the node, stopping
+ * the comparison to either '\0' or '@' character, whichever comes first. This
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


