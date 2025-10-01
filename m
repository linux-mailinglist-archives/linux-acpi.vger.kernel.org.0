Return-Path: <linux-acpi+bounces-17469-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B07CBB001C
	for <lists+linux-acpi@lfdr.de>; Wed, 01 Oct 2025 12:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6D561942FB8
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Oct 2025 10:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A50A2D73A1;
	Wed,  1 Oct 2025 10:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m23S06zB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFDF2BE647;
	Wed,  1 Oct 2025 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759314411; cv=none; b=MQxR4DH3Ze5WT7rCsFFrkFKb/WlEv4CbjAUKv/jOAYKPzO/KjC6tqCgi+5UyTQonnuO4Rvc7YZkowmiGFLjbm/7vp4ErumjmrKbJWwMIUfRBXC2bmtHadE3jnqDEg+B31dSy3gLeqNjoInRvLI8aKOuTHty8cfMSF20L4L/7GT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759314411; c=relaxed/simple;
	bh=sFcKzsZMTlZYAPhM32GPmHYLBxCNLYAjCZlrziwQj6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fn3dekJkzqukQSjjSP4jCqR4hO+dWaq9SrVnVljFqywfFhX3Yxg31egwAVGwu9c1P4qW02Kb5aEiOfBP5Zi36CrK7EtI3DmZW6VsnOvisWJ85bOvkoZpYI/dJ6Ma+wl2M1b4Pkhb/1dvSv3B6hR6xk1+HlJfA1GugGkDI4YH/do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m23S06zB; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759314409; x=1790850409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sFcKzsZMTlZYAPhM32GPmHYLBxCNLYAjCZlrziwQj6s=;
  b=m23S06zBXKkrO6+QrNSwGHT0NAdcq7NWCT7On9g42FnqRC1wwCNt+8NE
   pOioQe+ZsfIS+ZAD+QMQxSLF78toCmH6Q9F7e7zJhG5qQ2aLovqHpGgHl
   nThyzGONcGiDj292y5lhChuHmuL+XLAObZGCu7vh1P8/mrXESAa1fR12U
   FOOPLsqq68evxqUipIutOFmvwEnPC8xrVp9FuDtCXdk/rTlF6j31CY/hI
   hoRI94wLmNf/jxO+sJZvCO7W+pMs9IxmLmCJ0qTzlqdy9v0GnQfN1L95J
   IF5NkfCFeu3zMtmLdM36iAIZh40u4IfNjR8u3nA4q2bqX4jC6h8zaL8jQ
   g==;
X-CSE-ConnectionGUID: 2NSRNtjXSUSvqS8lYIZDww==
X-CSE-MsgGUID: Pj2Tq6JMTO+DFDRDYuuvyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="71834073"
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; 
   d="scan'208";a="71834073"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 03:26:46 -0700
X-CSE-ConnectionGUID: 9BgI1KxySbGifppoLWkdbQ==
X-CSE-MsgGUID: +NHM8WlGTByygzZxhXaCXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; 
   d="scan'208";a="182778111"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.14])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 03:26:40 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 935DC120DA3;
	Wed, 01 Oct 2025 13:26:36 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1v3u2e-00000005L63-29B6;
	Wed, 01 Oct 2025 13:26:36 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/1] ACPI: property: Return present device nodes only on fwnode interface
Date: Wed,  1 Oct 2025 13:26:36 +0300
Message-ID: <20251001102636.1272722-2-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251001102636.1272722-1-sakari.ailus@linux.intel.com>
References: <20251001102636.1272722-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fwnode_graph_get_next_subnode() may return fwnode backed by ACPI device
nodes and there has been no check these devices are present in the system,
unlike there has been on fwnode OF backend. In order to provide consistent
behaviour towards callers, add a check for device presence by introducing
a new function acpi_get_next_present_subnode(), used as the
get_next_child_node() fwnode operation that also checks device node
presence.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 drivers/acpi/property.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 436019d96027..10bab30300f3 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1318,6 +1318,28 @@ struct fwnode_handle *acpi_get_next_subnode(const struct fwnode_handle *fwnode,
 	return NULL;
 }
 
+/*
+ * acpi_get_next_present_subnode - Return the next present child node handle for a fwnode
+ * @fwnode: Firmware node to find the next child node for.
+ * @child: Handle to one of the device's child nodes or a null handle.
+ *
+ * Like acpi_get_next_subnode(), but the device nodes returned by
+ * acpi_get_next_present_subnode() are guaranteed to be present.
+ *
+ * Returns: The next sub-node fwnode handle.
+ */
+static struct fwnode_handle *
+acpi_get_next_present_subnode(const struct fwnode_handle *fwnode,
+			      struct fwnode_handle *child)
+{
+	do {
+		child = acpi_get_next_subnode(fwnode, child);
+	} while (is_acpi_device_node(child) &&
+		 !acpi_device_is_present(to_acpi_device_node(child)));
+
+	return child;
+}
+
 /**
  * acpi_node_get_parent - Return parent fwnode of this fwnode
  * @fwnode: Firmware node whose parent to get
@@ -1662,7 +1684,7 @@ static int acpi_fwnode_irq_get(const struct fwnode_handle *fwnode,
 		.property_read_string_array =				\
 			acpi_fwnode_property_read_string_array,		\
 		.get_parent = acpi_node_get_parent,			\
-		.get_next_child_node = acpi_get_next_subnode,		\
+		.get_next_child_node = acpi_get_next_present_subnode,	\
 		.get_named_child_node = acpi_fwnode_get_named_child_node, \
 		.get_name = acpi_fwnode_get_name,			\
 		.get_name_prefix = acpi_fwnode_get_name_prefix,		\
-- 
2.47.3


