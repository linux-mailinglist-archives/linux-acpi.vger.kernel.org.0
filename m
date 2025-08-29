Return-Path: <linux-acpi+bounces-16198-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE69B3C4CE
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Aug 2025 00:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90869585EAD
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 22:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D167627EFEB;
	Fri, 29 Aug 2025 22:29:39 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B044F13C8EA;
	Fri, 29 Aug 2025 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756506579; cv=none; b=QHnh+IpEXH7KUW3CuwWmuV1NDdRKTDC/FZIb6tUdzDhVJmVGXO+EIF1MC8fQ3ydfI/Q02tLLZmuKpekqI/HmQ+USlYD3D2bpBvLZaJiz+vXVC6F03FYGY4F22Gng4JKMtJuqcUv4LYZdk2CwYdZxhJQxl50BKkyR3zEjjpuZvLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756506579; c=relaxed/simple;
	bh=o13hbnQtjN++eKtLxKRDI31j4XlT0fvy8S8WwwWo9kA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AlZHukmLwuR2X2KBAEXOrzTtg5NYM9e0/dD2bQQVJpKrRb6DnDZsDXVgkkjhf5TXK3sqIKuq3iftboGJbmA00DiHP4wEYcqBOFbCTrhDkPEjjmbU7EYXsNc6boUNwUq6QGNJV8TbLi/egx73ev9QOx+pXKE2BgKwRan5F3DDoQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BEA3C4CEF0;
	Fri, 29 Aug 2025 22:29:37 +0000 (UTC)
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
Subject: [PATCH v3 1/4] mm/memory_hotplug: Update comment for hotplug memory callback priorities
Date: Fri, 29 Aug 2025 15:29:04 -0700
Message-ID: <20250829222907.1290912-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250829222907.1290912-1-dave.jiang@intel.com>
References: <20250829222907.1290912-1-dave.jiang@intel.com>
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
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v3:
- Update grammar (DavidH)
---
 include/linux/memory.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/memory.h b/include/linux/memory.h
index 40eb70ccb09d..1305102688d0 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -115,8 +115,8 @@ struct notifier_block;
 struct mem_section;
 
 /*
- * Priorities for the hotplug memory callback routines (stored in decreasing
- * order in the callback chain)
+ * Priorities for the hotplug memory callback routines. Invoked from
+ * high to low. Higher priorities correspond to higher numbers.
  */
 #define DEFAULT_CALLBACK_PRI	0
 #define SLAB_CALLBACK_PRI	1
-- 
2.50.1


