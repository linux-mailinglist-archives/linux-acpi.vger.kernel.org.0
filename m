Return-Path: <linux-acpi+bounces-2945-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6153A832E10
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Jan 2024 18:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B3D8287EE3
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Jan 2024 17:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2DA55E42;
	Fri, 19 Jan 2024 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YU9rCJgK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2324E54BEE;
	Fri, 19 Jan 2024 17:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705685005; cv=none; b=PxgvA8tkr5ME426OHhGAChdEWyMabJ9amntDqSzXVryppLq7YUaqAtWuiAoq/BfQ0qf80maDC0wa3LI7N/RgkE0m4tejpuNI0KwRfqOOd/LFAUVMq6vbk3gCd6UeQ2z7hS9VPnW3jwpjNQjDnSE3RCMLTPrvRatjXrIa38Z2U2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705685005; c=relaxed/simple;
	bh=BBwQImyZcEESkB4PZ75IkitdWlLpB8eqynK8oNV0x+c=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qlsMqADprrvLhsHqCGNqx7JLa/nxaLYyAkK9424OsAbYPxsgP4EkcelXxCKGDnGymsD4yNJv6Tn4SBfuy6/1nYCaaCmTrlY8Ke20Dck4u3WCgkc9NF/fCImV52FlIwZRQQeRc2pDRqa5cilVFIEdOOH+dDaLBaArCV91DfSUqLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YU9rCJgK; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705685004; x=1737221004;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BBwQImyZcEESkB4PZ75IkitdWlLpB8eqynK8oNV0x+c=;
  b=YU9rCJgKEi8/8XBB8KA91t3tHNlZAnqDCUjf/iPL45PLsi1GCp/EY2SZ
   H7lszuC68b208b/EXTydnDcEodzgTJ1HbEbULJAL1LVRgIH6DVy1E9IPP
   Tf8b12TeyhDSfKUd2eCbHqB82hDUydOb8FbK50L+cWgECPcuTPq/gotPp
   AXVYQXqUIjRYtmLmLqUTv0MUHS2EqA+fWMPcDVNUl8yRB2i+wpu53iPFq
   EKmCFpQq3JoD67BiADbznDt29CvQO+7SEI1VQnTXf8ZIY8MuWixnjd+j+
   IaNd3uHtySz5/NHn1eaM7febmaUZBW/K/wxi0k0aCvIhHGsWBN8FcPapn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="399666156"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="399666156"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 09:23:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="634551"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.161.22])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 09:23:23 -0800
Subject: [PATCH v4 03/11] ACPI: HMAT: Introduce 2 levels of generic port
 access class
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 jonathan.cameron@huawei.com, dave@stgolabs.net, brice.goglin@gmail.com,
 nifan.cxl@gmail.com, rafael@kernel.org, gregkh@linuxfoundation.org
Date: Fri, 19 Jan 2024 10:23:22 -0700
Message-ID: <170568500200.1008395.15259203933708935902.stgit@djiang5-mobl3>
In-Reply-To: <170568485801.1008395.12244787918793980621.stgit@djiang5-mobl3>
References: <170568485801.1008395.12244787918793980621.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

In order to compute access0 and access1 classes for CXL memory, 2 levels
of generic port information must be stored. Access0 will indicate the
generic port access coordinates to the closest initiator and access1
will indicate the generic port access coordinates to the cloest CPU.

Cc: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/acpi/numa/hmat.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index e0144cfbf1f3..8dbb0e366059 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -59,7 +59,8 @@ struct target_cache {
 };
 
 enum {
-	NODE_ACCESS_CLASS_GENPORT_SINK = ACCESS_COORDINATE_MAX,
+	NODE_ACCESS_CLASS_GENPORT_SINK_LOCAL = ACCESS_COORDINATE_MAX,
+	NODE_ACCESS_CLASS_GENPORT_SINK_CPU,
 	NODE_ACCESS_CLASS_MAX,
 };
 
@@ -141,7 +142,7 @@ int acpi_get_genport_coordinates(u32 uid,
 	if (!target)
 		return -ENOENT;
 
-	*coord = target->coord[NODE_ACCESS_CLASS_GENPORT_SINK];
+	*coord = target->coord[NODE_ACCESS_CLASS_GENPORT_SINK_LOCAL];
 
 	return 0;
 }
@@ -695,7 +696,8 @@ static void hmat_update_target_attrs(struct memory_target *target,
 	int i;
 
 	/* Don't update for generic port if there's no device handle */
-	if (access == NODE_ACCESS_CLASS_GENPORT_SINK &&
+	if ((access == NODE_ACCESS_CLASS_GENPORT_SINK_LOCAL ||
+	     access == NODE_ACCESS_CLASS_GENPORT_SINK_CPU) &&
 	    !(*(u16 *)target->gen_port_device_handle))
 		return;
 
@@ -707,7 +709,8 @@ static void hmat_update_target_attrs(struct memory_target *target,
 	 */
 	if (target->processor_pxm != PXM_INVAL) {
 		cpu_nid = pxm_to_node(target->processor_pxm);
-		if (access == ACCESS_COORDINATE_LOCAL ||
+		if ((access == ACCESS_COORDINATE_LOCAL ||
+		     access == NODE_ACCESS_CLASS_GENPORT_SINK_LOCAL) &&
 		    node_state(cpu_nid, N_CPU)) {
 			set_bit(target->processor_pxm, p_nodes);
 			return;
@@ -736,7 +739,8 @@ static void hmat_update_target_attrs(struct memory_target *target,
 		list_for_each_entry(initiator, &initiators, node) {
 			u32 value;
 
-			if (access == ACCESS_COORDINATE_CPU &&
+			if ((access == ACCESS_COORDINATE_CPU &&
+			     access == NODE_ACCESS_CLASS_GENPORT_SINK_CPU) &&
 			    !initiator->has_cpu) {
 				clear_bit(initiator->processor_pxm, p_nodes);
 				continue;
@@ -775,7 +779,9 @@ static void hmat_update_generic_target(struct memory_target *target)
 	static DECLARE_BITMAP(p_nodes, MAX_NUMNODES);
 
 	hmat_update_target_attrs(target, p_nodes,
-				 NODE_ACCESS_CLASS_GENPORT_SINK);
+				 NODE_ACCESS_CLASS_GENPORT_SINK_LOCAL);
+	hmat_update_target_attrs(target, p_nodes,
+				 NODE_ACCESS_CLASS_GENPORT_SINK_CPU);
 }
 
 static void hmat_register_target_initiators(struct memory_target *target)



