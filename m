Return-Path: <linux-acpi+bounces-15872-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8B2B2E5CB
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Aug 2025 21:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6A9A23FCA
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Aug 2025 19:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D5E1B394F;
	Wed, 20 Aug 2025 19:47:33 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389618F49;
	Wed, 20 Aug 2025 19:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755719253; cv=none; b=vCMXYA5vZlfuqqn++zgxSsE4lO5h5asaFnKgnT29PvZf8LvZIVlZ5BnU+EeAZGiw7jX4zlBH2Myh2QndYWRTYfoqcbiCO3LSphUelrvayyLFHsIXr7zBabg3VcJdvZMFHAoZALmCAYcXEiNIhlIZkXef8TtVbEbj7RZowH8e9/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755719253; c=relaxed/simple;
	bh=LXuu2Cje6OHE3XwS/50xEtHZHzM3gOFhHiFVE5g8TAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hgp/GFqNgXXfbABoi5OrL6AKjIrjjh9N/3z8MlknipkKTrfKQ7TGenYVyGvSc1xPYv50boMw68IP0gVDrEHLzY8Sz5tKEUB4INExExC2a50aGaLFKMu3OO0q/cXfBP7JNJQ5SmThh9s+7MOF4dNvLsTSq1YsqqTwU8Bd/fbMIQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33BEC4CEE7;
	Wed, 20 Aug 2025 19:47:31 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	marc.herbert@linux.intel.com,
	akpm@linux-foundation.org,
	david@redhat.com
Subject: [PATCH v2 1/4] mm/memory_hotplug: Update comment for hotplug memory callback priorities
Date: Wed, 20 Aug 2025 12:47:01 -0700
Message-ID: <20250820194704.4130565-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820194704.4130565-1-dave.jiang@intel.com>
References: <20250820194704.4130565-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add clarification to comment for memory hotplug callback ordering as the
current comment does not provide clear language on which callback happens
first.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- Clearer comment suggestion from DavidH.
---
 include/linux/memory.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/memory.h b/include/linux/memory.h
index 40eb70ccb09d..de5c0d8e8925 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -115,8 +115,8 @@ struct notifier_block;
 struct mem_section;
 
 /*
- * Priorities for the hotplug memory callback routines (stored in decreasing
- * order in the callback chain)
+ * Priorities for the hotplug memory callback routines. Invoked from
+ * high to low. Higher priorities corresponds to higher numbers.
  */
 #define DEFAULT_CALLBACK_PRI	0
 #define SLAB_CALLBACK_PRI	1
-- 
2.50.1


