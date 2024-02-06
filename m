Return-Path: <linux-acpi+bounces-3259-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8516F84C006
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Feb 2024 23:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8D831C21267
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Feb 2024 22:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EA31C283;
	Tue,  6 Feb 2024 22:30:07 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9821A1BF2B;
	Tue,  6 Feb 2024 22:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707258607; cv=none; b=QoLEI7pj9nzUTXvyfFddr0Wgiq5bbbexSO+RCKxj0x0Hb+/I924Ar2UGPkIa6dWTqHtccgJiAxFM+QV1tbjqbPgNfyGEtTTmr8Fxw+32I3YwlPjWIAfzN8RYSeYpuFRfRrNPALtzUnjkf80ewWJmoaxUtFfk9pawjMDp5rGMQiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707258607; c=relaxed/simple;
	bh=Ehz50Non44eNKFJT0gk3OgV1VizJ7lNceLs3vRXVExs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JcCMJFE3+vvJwa/vWfdsogdPyPfWNuMsHDX/NGxR6M2XWXzi/jhTF5E/pcHSJgldXMTKnR5R80QR0XHuGhS6zLgk4gosb+ANWZ6+Hyt5QFxhffqSdNG4wN3MBSzk2j5kH+ZoXsfgBG6NAigZoJTFeHEojCWkXHNXVHgaMl0I9ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2C4C43390;
	Tue,  6 Feb 2024 22:30:06 +0000 (UTC)
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
Subject: [PATCH v5 01/12] ACPI: HMAT: Remove register of memory node for generic target
Date: Tue,  6 Feb 2024 15:28:29 -0700
Message-ID: <20240206222951.1833098-2-dave.jiang@intel.com>
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

For generic targets, there's no reason to call
register_memory_node_under_compute_node() with the access levels that are
only visible to HMAT handling code. Only update the attributes and rename
hmat_register_generic_target_initiators() to hmat_update_generic_target().

Fixes: a3a3e341f169 ("acpi: numa: Add setting of generic port system locality attributes")
Cc: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/acpi/numa/hmat.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index d6b85f0f6082..a26e7793ec4e 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -770,12 +770,12 @@ static void __hmat_register_target_initiators(struct memory_target *target,
 	}
 }
 
-static void hmat_register_generic_target_initiators(struct memory_target *target)
+static void hmat_update_generic_target(struct memory_target *target)
 {
 	static DECLARE_BITMAP(p_nodes, MAX_NUMNODES);
 
-	__hmat_register_target_initiators(target, p_nodes,
-					  NODE_ACCESS_CLASS_GENPORT_SINK);
+	hmat_update_target_attrs(target, p_nodes,
+				 NODE_ACCESS_CLASS_GENPORT_SINK);
 }
 
 static void hmat_register_target_initiators(struct memory_target *target)
@@ -835,7 +835,7 @@ static void hmat_register_target(struct memory_target *target)
 	 */
 	mutex_lock(&target_lock);
 	if (*(u16 *)target->gen_port_device_handle) {
-		hmat_register_generic_target_initiators(target);
+		hmat_update_generic_target(target);
 		target->registered = true;
 	}
 	mutex_unlock(&target_lock);
-- 
2.43.0


