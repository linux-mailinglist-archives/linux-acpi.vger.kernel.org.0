Return-Path: <linux-acpi+bounces-17029-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 524E1B59CCD
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 18:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91AC11B27CE9
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 16:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD082848A3;
	Tue, 16 Sep 2025 16:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JBhd0EBZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE5F2BF001
	for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2025 16:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038501; cv=none; b=JO4amuYK58rB4eOyVRA8xo2nWl6c5FH738XWgxMyReesj91YH9laoLUFxeAhti6ves0dEMDLfyjZqzhPnkFryjWc5+qwS5ejpnqTf8iLexFcxmPuhPtl08HKO//urRGqzdCNcducUhSN/kJuwErVZTvGXUT2sR8POORAo60N/N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038501; c=relaxed/simple;
	bh=JG4rsFos70kSJAlELojkpuYY4KctBqvDce779223KhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+z4RYaJ1GFPj14jhdZ4lUNBmB7b+GgSicScq7L7LNbcvldH2PXf6lkJjWiYzaDexiVsY0j4hSjMFKzD2LNJT3MabfNAnYvySPtRrYA93KZYf0kd+6AcgJUX1WUESK0cqNztn1bz490c9McyjYoKGQoOPRLE+6ivs+N4OCNws1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JBhd0EBZ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758038499; x=1789574499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JG4rsFos70kSJAlELojkpuYY4KctBqvDce779223KhQ=;
  b=JBhd0EBZissHPoguifxug5IGAs62aDe34pfzbMv6izJwxgg1KgE11K6t
   GGVw5qP4D4MhjOOZUsVHrzQbU6Cqw8tOaEAnjR3Ooy+ZoILwKC3z7gqia
   z0/ZEnkpNpxdnRxrvKKAuhqNmYlAoNpVRxUJuOtQN/Rh6nKCimCI4GkWR
   IoKPpW9UU1i0+8oYoxThnO4rjCxg549GebYAvKeLLD1qa/FJzPVa0qKDD
   cTveHL3IPz0IiGBQJSN/kYbElGV2eRTHU+uVAcnuPFQV2eplwDOWFotTX
   aR3yH6/7N2FRoqyhB5r2cSHbV/MhBKezK9jTxCvQ4hPJ9PKV1kY/EemWt
   w==;
X-CSE-ConnectionGUID: yMd49T1CRZC+1skr8MQgXw==
X-CSE-MsgGUID: 0cpFLsvZTIm0pFIL7Zf9DQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="71422922"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="71422922"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 09:01:36 -0700
X-CSE-ConnectionGUID: lUDVKGVyTSSe2ZSwSWJMEA==
X-CSE-MsgGUID: DZFj2qiXThW8wMvd+6d8lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="174091514"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.177])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 09:01:33 -0700
Received: from punajuuri.localdomain (unknown [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 6A420121F03;
	Tue, 16 Sep 2025 19:01:30 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.98.2)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1uyY7W-0000000Gazp-1dbv;
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
Subject: [PATCH 04/14] property: Drop DEVICE_DISABLED flag in fwnode_graph_get_endpoint_by_id()
Date: Tue, 16 Sep 2025 19:01:19 +0300
Message-ID: <20250916160129.3955410-5-sakari.ailus@linux.intel.com>
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

No caller uses FWNODE_GRAPH_DEVICE_DISABLED flag when calling
fwnode_graph_get_endpoint_by_id(). Drop support for the flag entirely and
remove it from the documentation.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/property.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index f626d5bbe806..b48ef81ae43e 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1241,9 +1241,6 @@ static bool fwnode_graph_remote_available(struct fwnode_handle *ep)
  * If FWNODE_GRAPH_ENDPOINT_NEXT is passed in @flags and the specified endpoint
  * has not been found, look for the closest endpoint ID greater than the
  * specified one and return the endpoint that corresponds to it, if present.
- *
- * Does not return endpoints that belong to disabled devices or endpoints that
- * are unconnected, unless FWNODE_GRAPH_DEVICE_DISABLED is passed in @flags.
  */
 struct fwnode_handle *
 fwnode_graph_get_endpoint_by_id(const struct fwnode_handle *fwnode,
@@ -1252,13 +1249,12 @@ fwnode_graph_get_endpoint_by_id(const struct fwnode_handle *fwnode,
 	struct fwnode_handle *ep, *best_ep = NULL;
 	unsigned int best_ep_id = 0;
 	bool endpoint_next = flags & FWNODE_GRAPH_ENDPOINT_NEXT;
-	bool enabled_only = !(flags & FWNODE_GRAPH_DEVICE_DISABLED);
 
 	fwnode_graph_for_each_endpoint(fwnode, ep) {
 		struct fwnode_endpoint fwnode_ep = { 0 };
 		int ret;
 
-		if (enabled_only && !fwnode_graph_remote_available(ep))
+		if (!fwnode_graph_remote_available(ep))
 			continue;
 
 		ret = fwnode_graph_parse_endpoint(ep, &fwnode_ep);
-- 
2.47.3


