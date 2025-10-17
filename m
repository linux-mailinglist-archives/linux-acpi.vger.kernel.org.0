Return-Path: <linux-acpi+bounces-17928-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB080BEBCBA
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 23:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67D211AA7936
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 21:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760C33112B0;
	Fri, 17 Oct 2025 21:21:11 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EE82701C4;
	Fri, 17 Oct 2025 21:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760736071; cv=none; b=B2zm4phlKL4hBBXiu4iGVIgvBf83pIOgmiJN/31VmFAl4LEZuwic355IJrYmf3bjEg0zRfSrUbx9j/BxY3L1+E9YeFmYkciGe/cSaC8s94XrNCd9MFo+EaqFHHmymSauAD4XNGAGTquTgHBwy0xsQKbFumacqAEWDKZJWPxAe5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760736071; c=relaxed/simple;
	bh=qZ1AxmbOT7SagUvfm9xGUfxuKJ1y/x/eabnQsAtZkwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5k952k/Ne69aJTvb4kusuZI/F3EpJlbDu7BE2NY+/4spxUtLHe5Em2U1JobFEUoWoXPelS+U79Ta36p+VGGVzdwgofdwQvzJTjp40rYaMMTbIa4zx7Z0ineRO9syvrPBXmYBE0RnLVydPMMmO+Xs4n/sELmhNjkDuU5axBDEWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEEAC4CEE7;
	Fri, 17 Oct 2025 21:21:08 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	rafael@kernel.org
Subject: [PATCH v3 1/2] acpi/hmat: Return when generic target is updated
Date: Fri, 17 Oct 2025 14:21:04 -0700
Message-ID: <20251017212105.4069510-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017212105.4069510-1-dave.jiang@intel.com>
References: <20251017212105.4069510-1-dave.jiang@intel.com>
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

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
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
2.51.0


