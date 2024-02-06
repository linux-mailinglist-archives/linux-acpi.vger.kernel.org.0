Return-Path: <linux-acpi+bounces-3261-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2586F84C009
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Feb 2024 23:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E668B24374
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Feb 2024 22:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C011C28B;
	Tue,  6 Feb 2024 22:30:11 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E77B1BF47;
	Tue,  6 Feb 2024 22:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707258611; cv=none; b=r+nT0hB/7qeUmmpwFnpD5cHI7L94pXbDrnHMPJi2ny19QEd9Vp/BM5BtpjJcl6TekwJuP9SQL+8LzAfl83D0ngcRs2J8TfHHJSBu+3jD96ICSTDd4ryFeqlqhpHzZQydL/6dJRmRg1fbyHAvV8PzEAF0+uUMP/t9GpBHCy8JvyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707258611; c=relaxed/simple;
	bh=pFQI12o8Qa4suFm+ZKJ6s6AaX1qpFMILvPxKAd7ExSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGammAJIxFOlzRPSzZOLvl59mjW/3gayVaLYSirBuvxOWMi/y/vIbacEuabeP1p30YrPhgsNSWJI4C7VUEoz4Is1PhITVFxHhuXOSpZRSbJkenAirveD5tR7u16ws0sMJdgyhXlgXj/l3vbEkO9+BcfpheoFRvjnlE0NdlLtdYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B74C433F1;
	Tue,  6 Feb 2024 22:30:10 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	rafael@kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH v5 03/12] ACPI: HMAT: Introduce 2 levels of generic port access class
Date: Tue,  6 Feb 2024 15:28:31 -0700
Message-ID: <20240206222951.1833098-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206222951.1833098-1-dave.jiang@intel.com>
References: <20240206222951.1833098-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to compute access0 and access1 classes for CXL memory, 2 levels
of generic port information must be stored. Access0 will indicate the
generic port access coordinates to the closest initiator and access1
will indicate the generic port access coordinates to the cloest CPU.

Cc: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/acpi/numa/hmat.c | 18 ++++++++++++------
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
-- 
2.43.0


