Return-Path: <linux-acpi+bounces-10976-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3924FA2FB88
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 22:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 981CB188331A
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 21:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED8824E4B8;
	Mon, 10 Feb 2025 21:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MIxVqEGV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8671E24CED5;
	Mon, 10 Feb 2025 21:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739221957; cv=none; b=CtJVugP5hka7uGMi2jINFQthtA14LaDC0nmnLrWl2HOOwW1etKNFf1vpnlHAhnEeqFTXHszH6dLhjh9223WGxGAwXmilCWkWK6oAVIAjtrjcy3REXTF+ZZN0EEgxlH/Rmpg0/nUVu9EjkLoNfUPQNYSZwAPdAWZTC1tXruphtq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739221957; c=relaxed/simple;
	bh=8MX2jSRA6p3msqeidieChxEGZWfp3uNvo8+3hloLNGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sz4QSRLjUvV6kUxg13XI8aSIVRCclNDdIbyL22CWQnpWot6lCQdMGYx1+Hk49wuP2TcePmLS6U54VmyvJbJwwCORI7GZiM8aotLpLKrb4W3zvGPANa81LJ7AGhD9M7zeHCiszP8zNSGc6Zgj0xCXGntq2FOco1JnVRtDB7Hg0Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MIxVqEGV; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739221956; x=1770757956;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8MX2jSRA6p3msqeidieChxEGZWfp3uNvo8+3hloLNGA=;
  b=MIxVqEGVYeDg7TtN/OMuWGreAh+yVb8mGbexBzromDcqNMdhCoVaix1Q
   w7VpO5D39Uk+GUYDHdXryB1MeRkXw79Y6lXOkz/GCYHckUHBMs8L35mCs
   WzddDgMRYI70JkgJ3rkVWw1kLwRZ5YlkhKrnqjiYEGlzzSgR92ejdH5Br
   VxMURjfV2gqqR2lzYVUy97Tu7ZxdHRB51vsG1DNufKuQVYmO+rlZsRPFi
   xcP/uG7ciulOizrf0rPMGGehL0QCouCK4MtptxuwiOv6KkFHdEdX2NtYa
   WEYam7WkshbgsBDD2bsqhdwP/oLyxROA1FULLkhPDYKVCbo/0Ab2DedPw
   g==;
X-CSE-ConnectionGUID: QmfB+vwyQwy68lv/gz5iGQ==
X-CSE-MsgGUID: O2KqbZK8T6+9d2I0aIVkQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="39969766"
X-IronPort-AV: E=Sophos;i="6.13,275,1732608000"; 
   d="scan'208";a="39969766"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 13:12:31 -0800
X-CSE-ConnectionGUID: 6f5cx5jLSf67/Q4eRH5Qig==
X-CSE-MsgGUID: 9jJCCjNwSTm3QG2+dIaX/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116393887"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 13:12:31 -0800
From: Tony Luck <tony.luck@intel.com>
To: Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH 3/4] ACPI/MRRM: Add "node" symlink to /sys/devices/system/memory/rangeX
Date: Mon, 10 Feb 2025 13:12:22 -0800
Message-ID: <20250210211223.6139-4-tony.luck@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210211223.6139-1-tony.luck@intel.com>
References: <20250210211223.6139-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Users will likely want to know which node owns each memory range
and which CPUs are local to the range.

Add a symlink to the node directory to provide both pieces of information.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/acpi/acpi_mrrm.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/acpi/acpi_mrrm.c b/drivers/acpi/acpi_mrrm.c
index 51ed9064e025..28b484943bbd 100644
--- a/drivers/acpi/acpi_mrrm.c
+++ b/drivers/acpi/acpi_mrrm.c
@@ -119,6 +119,31 @@ static struct attribute *memory_range_attrs[] = {
 
 ATTRIBUTE_GROUPS(memory_range);
 
+static __init int add_node_link(struct mrrm_mem_range_entry *entry)
+{
+	struct node *node = NULL;
+	int ret = 0;
+	int nid;
+
+	for_each_online_node(nid) {
+		for (int z = 0; z < MAX_NR_ZONES; z++) {
+			struct zone *zone = NODE_DATA(nid)->node_zones + z;
+
+			if (!populated_zone(zone))
+				continue;
+			if (zone_intersects(zone, PHYS_PFN(entry->base), PHYS_PFN(entry->length))) {
+				node = node_devices[zone->node];
+				goto found;
+			}
+		}
+	}
+found:
+	if (node)
+		ret = sysfs_create_link(&entry->dev.kobj, &node->dev.kobj, "node");
+
+	return ret;
+}
+
 static __init int add_boot_memory_ranges(void)
 {
 	char name[16];
@@ -140,6 +165,10 @@ static __init int add_boot_memory_ranges(void)
 			put_device(&entry->dev);
 			return ret;
 		}
+
+		ret = add_node_link(entry);
+		if (ret)
+			break;
 	}
 
 	return ret;
-- 
2.48.1


