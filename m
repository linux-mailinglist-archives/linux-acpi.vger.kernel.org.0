Return-Path: <linux-acpi+bounces-15705-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E59B26D66
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 19:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A42807B968C
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 17:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAD71DFE0B;
	Thu, 14 Aug 2025 17:17:29 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC41C32145D;
	Thu, 14 Aug 2025 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755191849; cv=none; b=jHrTspabubgH+qo2GTp5jhUdaOtnAlfyf3a01R3Y+qDVkvFOOS/JhzldvX5CoEKGSqNDax5fpAamwqgrPMnVA6NMFWkj8UtpE4u07Qi2jgNnvCI1vxkIe4UwpB84ruJQqk2BauAzQJVozNYLOodKvUjgBKxGC6ztEX5qy3hY0ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755191849; c=relaxed/simple;
	bh=a/tzTHVb0UUATdpCBBpa30mw3nPFd7vzmZOm7vikXjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bv8ROljirM9n8plrGB7pnMYYO5tyqByk1itfeXc+WruMjBGvV6EVEAiMPbv6FC2igLhcLfBrNa0BnSiID6eRxswGas3tqvsEYafhCKvc2Fv3FGXtVxbIuyJ3fXSSz3YwLP2BPBBQx6V7RbEJX+igt0UALC7C4KjZZ00Ni1wJUeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFE2C4CEED;
	Thu, 14 Aug 2025 17:17:28 +0000 (UTC)
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
Subject: [PATCH 1/4] mm/memory_hotplug: Update comment for hotplug memory callback priorities
Date: Thu, 14 Aug 2025 10:16:47 -0700
Message-ID: <20250814171650.3002930-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814171650.3002930-1-dave.jiang@intel.com>
References: <20250814171650.3002930-1-dave.jiang@intel.com>
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

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 include/linux/memory.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/memory.h b/include/linux/memory.h
index 40eb70ccb09d..02314723e5bd 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -116,7 +116,7 @@ struct mem_section;
 
 /*
  * Priorities for the hotplug memory callback routines (stored in decreasing
- * order in the callback chain)
+ * order in the callback chain). The callback ordering happens from high to low.
  */
 #define DEFAULT_CALLBACK_PRI	0
 #define SLAB_CALLBACK_PRI	1
-- 
2.50.1


