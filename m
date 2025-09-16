Return-Path: <linux-acpi+bounces-17030-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F59B59CD7
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 18:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D82884E2A10
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 16:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA67370593;
	Tue, 16 Sep 2025 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WcmGokHn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1F2341AAF
	for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2025 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038502; cv=none; b=IabxvXVZfY//swjmjoabm20iqGGs+n0ThEVybOhbH3fTOslesD0Hf890jQMPEDK8XXi2MVR1FF86ERSfKwsskWQcoScd+pxEUu0qfA2TWXbiGJsYNYCPTBc34qe5/k7EvcKg5WclUCPvaHcWNBHjFkh7OasT6iI53ZPu3pVSzwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038502; c=relaxed/simple;
	bh=JBWpnpXd/QLOs58DF0oZRtobdgvUq9xLMN4isPKV3vQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btxiYt04yTkZNsM3i1bJBD0xZgRDXeQIGZgYgeTVtYO4R3BuUzOSvR0DkhaEBiK8JO+b71/fjkemzsffx7kTXlPhFyEH2kTF3Akuc3InMixcMVUsvnfxGCfjwcD9mVPvTLdfstpa90MiWxXNgcQT0K1/RZGTw1p/4+pfNHek1Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WcmGokHn; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758038501; x=1789574501;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JBWpnpXd/QLOs58DF0oZRtobdgvUq9xLMN4isPKV3vQ=;
  b=WcmGokHnI21LE7dtePBmgtJ3V6jFTf3qKQsGDdz3whg5R10xOa+lJW11
   m/CWkbS/nMm9VNbySzsCdKF4Jp0FYRBW3ZXeEF2d1SRrMHiS/ks8Dz4QE
   AgkznopEQPRknlQ5NZqnJSPuBnQrTTcSjDmkc3LZNeEIHEJk8Pnowie/n
   ETk7OtaYBCm28SP7VkQ3d7dHIUpAzfIWsB6NLN0iSscknOJNjCWbB8B7D
   L4F1TTg+nvdc7J/0i8vdjDJbVnFzLP1pCINWCUiMcMUET0CNT4QJKjFHR
   QhXz+Cl86Mq6x5LBacYX9U4UlbT9ZcRwKRaDhVqiU3ykuFwIUi5p8ba9v
   g==;
X-CSE-ConnectionGUID: hoHI105YSSKs9zmS8B3FUg==
X-CSE-MsgGUID: TxzrlOSQRICse78NlQq9Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="71422945"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="71422945"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 09:01:39 -0700
X-CSE-ConnectionGUID: 6wX4XQjNRGi9+ClO29TuBw==
X-CSE-MsgGUID: pKZzDRTfRCOonbil9irfJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="174091519"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.177])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 09:01:33 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 68BAF121F02;
	Tue, 16 Sep 2025 19:01:30 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uyY7W-0000000Gazl-1Z8t;
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
Subject: [PATCH 03/14] ACPI: property: Return present device nodes only on fwnode interface
Date: Tue, 16 Sep 2025 19:01:18 +0300
Message-ID: <20250916160129.3955410-4-sakari.ailus@linux.intel.com>
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

fwnode_graph_get_next_subnode() may return fwnode backed by ACPI device
nodes and there has been no check these devices are present in the system,
unlike there has been on fwnode OF backend. In order to provide consistent
behaviour towards callers, add a check for device presence by introducing
a new function acpi_get_next_present_subnode(), used as the
get_next_child_node() fwnode operation that also checks device node
presence.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 3e85900080ac..f7461592b5f6 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1319,6 +1319,25 @@ acpi_get_next_subnode(const struct fwnode_handle *fwnode,
 	return NULL;
 }
 
+/**
+ * acpi_get_next_present_subnode - Return the next present child node handle for a fwnode
+ * @fwnode: Firmware node to find the next child node for.
+ * @child: Handle to one of the device's child nodes or a null handle.
+ * Like acpi_get_next_subnode, but the device nodes returned by
+ * acpi_get_next_present_subnode() are guaranteed to be present.
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
@@ -1663,7 +1682,7 @@ static int acpi_fwnode_irq_get(const struct fwnode_handle *fwnode,
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


