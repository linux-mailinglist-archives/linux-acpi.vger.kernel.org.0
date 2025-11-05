Return-Path: <linux-acpi+bounces-18563-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB83C3867F
	for <lists+linux-acpi@lfdr.de>; Thu, 06 Nov 2025 00:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A64C03B3D03
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 23:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470B6258EC1;
	Wed,  5 Nov 2025 23:49:01 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7E81FA272;
	Wed,  5 Nov 2025 23:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762386541; cv=none; b=fIdVEQPPvr5qHwBRliW1aXKOqZn8tjIY6YSm9sPA0TGlpuypV+6t3722T6JpnhG1c3Y6ABjQYnDETdECFryhEnLpYQD07jaC9Q6HnPnRUm9/zlpeRNDCICSMszXpkoNw9Ooql1C6J0ppz8z8odWJiREmgQgOOwLlHdc0DyZoSzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762386541; c=relaxed/simple;
	bh=EbOHSgLDrk9RhJCElcvwo/xfT2UXm3dcCPq91nMz9vM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HNLJC2Ylijp5X83aqFJ/Ncm/ez7G2jNfagu/XOJtlR5qW85r8ErMZ0EdiczTREhC6B+MZ9xUa7W+VMP18HeJXG5eJy+68wQSF4sU7A6EMtpmqLijIdxl3TUj7FqnPop18l4tKTWV8P13q+ynVkR7Lt1MfKECdd3LdLjHhfXgTQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771EFC4CEF5;
	Wed,  5 Nov 2025 23:49:00 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	rafael@kernel.org,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v4 1/2] acpi/hmat: Return when generic target is updated
Date: Wed,  5 Nov 2025 16:48:50 -0700
Message-ID: <20251105234851.81589-5-dave.jiang@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251105234851.81589-1-dave.jiang@intel.com>
References: <20251105234851.81589-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the current code flow, once the generic target is updated
target->registered is set and the remaining code is skipped.
So return immediately instead of going through the checks and
then skip.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
no changes
---
 drivers/acpi/numa/hmat.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 5a36d57289b4..1dc73d20d989 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -888,12 +888,13 @@ static void hmat_register_target(struct memory_target *target)
 	 * Register generic port perf numbers. The nid may not be
 	 * initialized and is still NUMA_NO_NODE.
 	 */
-	mutex_lock(&target_lock);
-	if (*(u16 *)target->gen_port_device_handle) {
-		hmat_update_generic_target(target);
-		target->registered = true;
+	scoped_guard(mutex, &target_lock) {
+		if (*(u16 *)target->gen_port_device_handle) {
+			hmat_update_generic_target(target);
+			target->registered = true;
+			return;
+		}
 	}
-	mutex_unlock(&target_lock);
 
 	/*
 	 * Skip offline nodes. This can happen when memory
-- 
2.51.1


