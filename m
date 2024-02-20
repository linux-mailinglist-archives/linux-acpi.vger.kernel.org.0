Return-Path: <linux-acpi+bounces-3746-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0728685CBD5
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 00:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06B61F22B04
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Feb 2024 23:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AB5154C08;
	Tue, 20 Feb 2024 23:14:20 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FBF135416;
	Tue, 20 Feb 2024 23:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708470860; cv=none; b=Uisk1Ie8iAYcKAMJsuva/4HAn+QZgFGLmMuHnFgXYtOULZrn6EecSYsvoK0bi4m7fP5SLAhytt8ieNkVZJ4aAr8DE4gtcYscRq0nUP/WIaYRxvZQ2u6yYLqY+ezwaEtsoNpmdCz9d8KQxbeOl/q+Bk/mWmckcOFLaxWbNfz+1jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708470860; c=relaxed/simple;
	bh=v1Ih0MsopCwM+G6KtZsctwxTKDGK80VFBDxZmLqFxjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4yU11iiAe1AsibZjPEe9hbH/RK2h+WxTkF1kBxZTFLOngyuF4FCa4Hwfpnf9rl0ZA2uE1kGWf/mvV9oeNynnXjHnX/uZ05D5WtdAU4kKrCWfw0lFQI6+FvwTXk1JhWE4710U0XPa1iEhvQVCtgpRdFbfkbAWw8kg1RsG1d71Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3B6C43390;
	Tue, 20 Feb 2024 23:14:20 +0000 (UTC)
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
Subject: [PATCH v6 03/12] ACPI: HMAT: Introduce 2 levels of generic port access class
Date: Tue, 20 Feb 2024 16:12:32 -0700
Message-ID: <20240220231402.3156281-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220231402.3156281-1-dave.jiang@intel.com>
References: <20240220231402.3156281-1-dave.jiang@intel.com>
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
v6:
- Remove check for genport when setting p_nodes in
  hmat_update_target_attrs(). (Jonathan)
- Fix access compare logic (kernel test bot)
---
 drivers/acpi/numa/hmat.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index e0144cfbf1f3..a1257888a6df 100644
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
 
@@ -736,7 +738,8 @@ static void hmat_update_target_attrs(struct memory_target *target,
 		list_for_each_entry(initiator, &initiators, node) {
 			u32 value;
 
-			if (access == ACCESS_COORDINATE_CPU &&
+			if ((access == ACCESS_COORDINATE_CPU ||
+			     access == NODE_ACCESS_CLASS_GENPORT_SINK_CPU) &&
 			    !initiator->has_cpu) {
 				clear_bit(initiator->processor_pxm, p_nodes);
 				continue;
@@ -775,7 +778,9 @@ static void hmat_update_generic_target(struct memory_target *target)
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


