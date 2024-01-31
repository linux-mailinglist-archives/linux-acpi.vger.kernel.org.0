Return-Path: <linux-acpi+bounces-3109-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A37843918
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jan 2024 09:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BF3D1C28F0C
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jan 2024 08:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D435DF1F;
	Wed, 31 Jan 2024 08:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EInphIyi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F5B53E3D
	for <linux-acpi@vger.kernel.org>; Wed, 31 Jan 2024 08:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689824; cv=none; b=NVr81DEKNuG4keqgq6tUwt4KJQhFrVadFIvDj+e1rc8831ZzlhipZYCkyMqFvUWs1CPW3vXD6kgQq++SX+WxsD8XorodMgDmKE8pKSsD+7xxNBW7Uj0GMmRlrlP6XslWDk8areZKstE+d4oAsTgSLIKwCNvhLie0NajqulJNmGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689824; c=relaxed/simple;
	bh=xU6+xL2HskrmNdykm9M4m4IL09/g6UB0gUsfHDxXyyc=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=IqWFoiKYBayirkSXxXQu7jBR1X+bdLE6dd6ktZOqL2B8My0vfi3sNmYzQ06lv2JVgItWp0zGGtm2Nkhy9BnayTqkiWqMiT0D45BP78+WD19AivzeGdLoFyCWRhVfRR1Iup+KRKLifQ71HCj4+sw2ynFkPe62+9jIogu3ZhsYx40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EInphIyi; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706689822; x=1738225822;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xU6+xL2HskrmNdykm9M4m4IL09/g6UB0gUsfHDxXyyc=;
  b=EInphIyiEnxH01Gwr47al9BeK+dVYL+N7qw4WW+9Wj4mxsTyer5GKxQb
   T2QaJkgvfSrekm1Q+KjW7qnSGOj7opNv+cP/GiSqKNonm3NuzZ3RWS9GA
   HTcT0JmsW0/AHZ4WHBN0JIdYMgsfoA3zBlt9uiccm52Ajxn73cqKgaHrg
   z5WyUyq7ooTPBiOOVfRR4+jjTpoPY3FtYJ7M/B29wMyFBvk8BvvmK5lhQ
   gmlZ2RESZU5T3nyqK+GD32jl9g01C23khsOBXoe9OAOljTHCOcfTdV6ZG
   A/vb8IUXyRxIbtVyvZJDzNI8aswcIakBXydqnJtAc6p1plUmcewHkZKBC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="17065154"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="17065154"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:30:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="1119546468"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="1119546468"
Received: from rijanshr-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.100.213])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:30:21 -0800
Subject: [PATCH] ACPI/HMAT: Move HMAT messages to pr_debug()
From: Dan Williams <dan.j.williams@intel.com>
To: rafael@kernel.org
Cc: Priya Autee <priya.v.autee@intel.com>, linux-acpi@vger.kernel.org
Date: Wed, 31 Jan 2024 00:30:21 -0800
Message-ID: <170668982094.318782.2963631284830500182.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The HMAT messages printed at boot, beyond being noisy, can also print
details for nodes that are not yet enabled. The primary method to
consume HMAT details is via sysfs, and the sysfs interface gates what is
emitted by whether the node is online or not. Hide the messages by
default by moving them from "info" to "debug" log level.

Otherwise, these prints are just a pretty-print way to dump the ACPI
HMAT table. It has always been the case that post-analysis was required
for these messages to map proximity-domains to Linux NUMA nodes, and as
Priya points out that analysis also needs to consider whether the
proximity domain is marked "enabled" in the SRAT.

Reported-by: Priya Autee <priya.v.autee@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/numa/hmat.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index d6b85f0f6082..5331abc7c956 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -409,9 +409,9 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
 		return -EINVAL;
 	}
 
-	pr_info("Locality: Flags:%02x Type:%s Initiator Domains:%u Target Domains:%u Base:%lld\n",
-		hmat_loc->flags, hmat_data_type(type), ipds, tpds,
-		hmat_loc->entry_base_unit);
+	pr_debug("Locality: Flags:%02x Type:%s Initiator Domains:%u Target Domains:%u Base:%lld\n",
+		 hmat_loc->flags, hmat_data_type(type), ipds, tpds,
+		 hmat_loc->entry_base_unit);
 
 	inits = (u32 *)(hmat_loc + 1);
 	targs = inits + ipds;
@@ -422,9 +422,9 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
 			value = hmat_normalize(entries[init * tpds + targ],
 					       hmat_loc->entry_base_unit,
 					       type);
-			pr_info("  Initiator-Target[%u-%u]:%u%s\n",
-				inits[init], targs[targ], value,
-				hmat_data_type_suffix(type));
+			pr_debug("  Initiator-Target[%u-%u]:%u%s\n",
+				 inits[init], targs[targ], value,
+				 hmat_data_type_suffix(type));
 
 			hmat_update_target(targs[targ], inits[init],
 					   mem_hier, type, value);
@@ -452,9 +452,9 @@ static __init int hmat_parse_cache(union acpi_subtable_headers *header,
 	}
 
 	attrs = cache->cache_attributes;
-	pr_info("Cache: Domain:%u Size:%llu Attrs:%08x SMBIOS Handles:%d\n",
-		cache->memory_PD, cache->cache_size, attrs,
-		cache->number_of_SMBIOShandles);
+	pr_debug("Cache: Domain:%u Size:%llu Attrs:%08x SMBIOS Handles:%d\n",
+		 cache->memory_PD, cache->cache_size, attrs,
+		 cache->number_of_SMBIOShandles);
 
 	target = find_mem_target(cache->memory_PD);
 	if (!target)
@@ -513,9 +513,9 @@ static int __init hmat_parse_proximity_domain(union acpi_subtable_headers *heade
 	}
 
 	if (hmat_revision == 1)
-		pr_info("Memory (%#llx length %#llx) Flags:%04x Processor Domain:%u Memory Domain:%u\n",
-			p->reserved3, p->reserved4, p->flags, p->processor_PD,
-			p->memory_PD);
+		pr_debug("Memory (%#llx length %#llx) Flags:%04x Processor Domain:%u Memory Domain:%u\n",
+			 p->reserved3, p->reserved4, p->flags, p->processor_PD,
+			 p->memory_PD);
 	else
 		pr_info("Memory Flags:%04x Processor Domain:%u Memory Domain:%u\n",
 			p->flags, p->processor_PD, p->memory_PD);


