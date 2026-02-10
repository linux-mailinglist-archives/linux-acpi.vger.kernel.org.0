Return-Path: <linux-acpi+bounces-20920-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NI0IX46i2neRgAAu9opvQ
	(envelope-from <linux-acpi+bounces-20920-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Feb 2026 15:02:38 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0101F11BAB3
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Feb 2026 15:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8E64307D121
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Feb 2026 13:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8753271EB;
	Tue, 10 Feb 2026 13:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q1dbYch/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E8C26ED3A;
	Tue, 10 Feb 2026 13:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770731914; cv=none; b=RBpfM2vw9azeRQQ4/EKebw/m4MQR05lgbQuG3YfPxGQEiohzhgP4BklTn33dznskb+tVexu5vQpH/A1BytxCnIy3T0WzAPuQHqVmGhmFuN8TzPtwfMB69GffoH3dgiNaebJdx0riBiFIwjmbtc/Y5tRupf9urenO5unbYPqH14M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770731914; c=relaxed/simple;
	bh=m5Dj4gxkuHL8c1PcLJHB5d6IMv21j3TjFODSPGiJ31M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XL7MKuKB0+dP9E7gmInIQXuuhVG/scI+iLIuKE6JxmvgLLLz7fmHW4AWfAbUfiOjXkPXc7jKyWAkIFeqeFhMj1x0Co9RLD3n/4hlBF4yLk2fK+bDF3pKOAVO7nA6BTIqzqTD8Ng1AAQ/ff9xlv70dvh2mKI2WRG4ywvxAYLflzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q1dbYch/; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770731913; x=1802267913;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m5Dj4gxkuHL8c1PcLJHB5d6IMv21j3TjFODSPGiJ31M=;
  b=Q1dbYch/53AWDEJPN3hb+pyNZqb013gAn/709ByoT22ujgS0QKumAuBT
   xIpIeb5ezy9/ZevlpoJQQL/1GpWUhwGfRaflcEZ7Fv/IsVSkIaf/I5XGe
   7RTIXw8ZWzX3mzze8d4EtaQOeZKEOFaVQw2Uz2kil/1DHqsuv1FHSsHTN
   m9T2Kdc41TaNmQAzJLyIVxYV/BB24mhr4MduYEiWV1nPyABHeCxFMSiMb
   tHAZD2AbfvA9KBNLCSpsXjVV381/NOGDNFxSR8ppCkAHsa1WaQgHDfudw
   vsYMmiRNORxb7bhezFNmvUa/+MOqNt9I3AeqebmfKhrNrJfmLZrN0X5mL
   A==;
X-CSE-ConnectionGUID: X891ucwPSpSEJ45A3SCwUw==
X-CSE-MsgGUID: PVML8s0tS+SEEItkZqEIOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="71577654"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="71577654"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 05:58:32 -0800
X-CSE-ConnectionGUID: F/r0FAoSRZ+1u5u4B7vrEQ==
X-CSE-MsgGUID: K877X934RHqky+kk2znn0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="210982022"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 10 Feb 2026 05:58:29 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id B27D198; Tue, 10 Feb 2026 14:58:27 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v1 1/1] device property: Allow secondary lookup in fwnode_get_next_child_node()
Date: Tue, 10 Feb 2026 14:58:22 +0100
Message-ID: <20260210135822.47335-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20920-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,linuxfoundation.org,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,linux.intel.com:mid]
X-Rspamd-Queue-Id: 0101F11BAB3
X-Rspamd-Action: no action

When device_get_child_node_count() got split to the fwnode and device
respective APIs, the fwnode didn't inherit the ability to traverse over
the secondary fwnode. Hence any user, that switches from device to fwnode
API misses this feature. In particular, this was revealed by the commit
1490cbb9dbfd ("device property: Split fwnode_get_child_node_count()")
that effectively broke the GPIO enumeration on Intel Galileo boards.
Fix this by moving the secondary lookup from device to fwnode API.

Note, in general no device_*() API should go into the depth of the fwnode
implementation.

Fixes: 114dbb4fa7c4 ("drivers property: When no children in primary, try secondary")
Cc: stable@vger.kernel.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 6a63860579dd..8d9a34be57fb 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -797,7 +797,18 @@ struct fwnode_handle *
 fwnode_get_next_child_node(const struct fwnode_handle *fwnode,
 			   struct fwnode_handle *child)
 {
-	return fwnode_call_ptr_op(fwnode, get_next_child_node, child);
+	struct fwnode_handle *next;
+
+	if (IS_ERR_OR_NULL(fwnode))
+		return NULL;
+
+	/* Try to find a child in primary fwnode */
+	next = fwnode_call_ptr_op(fwnode, get_next_child_node, child);
+	if (next)
+		return next;
+
+	/* When no more children in primary, continue with secondary */
+	return fwnode_call_ptr_op(fwnode->secondary, get_next_child_node, child);
 }
 EXPORT_SYMBOL_GPL(fwnode_get_next_child_node);
 
@@ -841,19 +852,7 @@ EXPORT_SYMBOL_GPL(fwnode_get_next_available_child_node);
 struct fwnode_handle *device_get_next_child_node(const struct device *dev,
 						 struct fwnode_handle *child)
 {
-	const struct fwnode_handle *fwnode = dev_fwnode(dev);
-	struct fwnode_handle *next;
-
-	if (IS_ERR_OR_NULL(fwnode))
-		return NULL;
-
-	/* Try to find a child in primary fwnode */
-	next = fwnode_get_next_child_node(fwnode, child);
-	if (next)
-		return next;
-
-	/* When no more children in primary, continue with secondary */
-	return fwnode_get_next_child_node(fwnode->secondary, child);
+	return fwnode_get_next_child_node(dev_fwnode(dev), child);
 }
 EXPORT_SYMBOL_GPL(device_get_next_child_node);
 
-- 
2.50.1


