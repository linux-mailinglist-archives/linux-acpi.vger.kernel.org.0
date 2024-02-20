Return-Path: <linux-acpi+bounces-3744-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F8985CBD3
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Feb 2024 00:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DEDF286104
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Feb 2024 23:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E181154BEB;
	Tue, 20 Feb 2024 23:14:17 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129D1154BE5;
	Tue, 20 Feb 2024 23:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708470857; cv=none; b=cU5d2WkNlgvDDE8QfjtZr6MYOZSuUgwY59+fwpjte8t4Pesz/F1qAL0oQspyswk9PbnQnKnyMgux3DJ9KeocGWNZ2UD3mKXljHfApl4LgMP7c6j86lRvVJH2UVJltPDNv3igPxw3O6am+ya3JQxFpioH1/RVHvk+1iIYM89zD7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708470857; c=relaxed/simple;
	bh=CEonglwzYHXdfYOiz03UTcaaTN2YsZ1mpkQgwc4LsyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATOMrHh2TgIk/R1i8Kpyq4lW7HkkshMDzvBezhlZFoAQWZPntBMK04l27dh0k6G1tNzX4pvpcYwoE9WNT9dOdYTuTgDe+xDMq6HJIu0Val/WLmUJuV9I/EKS9CBCdKBeZa9gzQuZbJHUcd6vpqZ43A6WggSkvqzM5+x/QQhKFOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA35C433F1;
	Tue, 20 Feb 2024 23:14:16 +0000 (UTC)
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
Subject: [PATCH v6 01/12] ACPI: HMAT: Remove register of memory node for generic target
Date: Tue, 20 Feb 2024 16:12:30 -0700
Message-ID: <20240220231402.3156281-2-dave.jiang@intel.com>
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

For generic targets, there's no reason to call
register_memory_node_under_compute_node() with the access levels that are
only visible to HMAT handling code. Only update the attributes and rename
hmat_register_generic_target_initiators() to hmat_update_generic_target().

The original call path ends up triggering register_memory_node_under_compute_node().
Although the access level would be "3" and not impact any current node arrays, it
introduces unwanted data into the numa node access_coordinate array.

Fixes: a3a3e341f169 ("acpi: numa: Add setting of generic port system locality attributes")
Cc: Rafael J. Wysocki <rafael@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v6:
- Add result of fix to commit log (Jonathan)
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


