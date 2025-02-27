Return-Path: <linux-acpi+bounces-11596-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD21AA48C01
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 23:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AB2416D226
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 22:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208E0271815;
	Thu, 27 Feb 2025 22:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KhhXveEp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C7323E352;
	Thu, 27 Feb 2025 22:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740696524; cv=none; b=eUPqpSLJnGLBKFuFaGbNkA+VSdHAxyHDCIGNYnVuvHnkhwRmhSdJ5UzIqZI5WR0t/rzHVC463EEfYoZvRwgx25MhpUq/Nn13xgMJ6vC0LerAfupySt5Ztxr5fdWgSFMi4VHD77RV77KGrnxaIcSKLkN38w5Dq7T52nCcrMVRsLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740696524; c=relaxed/simple;
	bh=5dLuIAnj4GerB++3zMLGjP08kKlVE0y/APjV7HD4j0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CwvJ2pJ/4QbTOj0sALOUfMzYtwrYv2O5xiUT/Gwpg9UWsNYKtxpa92CNnxAapV+rLNcpmHw/rCfuDk7f3GDZ514WTbvU6X18CHL4H1QbquLLgDKnF54mKCmlEPKnNIvyeCgy2JZN5nSqOYiQ8K7oKTCtBcYXYCSxq07E5bqoKn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KhhXveEp; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740696522; x=1772232522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5dLuIAnj4GerB++3zMLGjP08kKlVE0y/APjV7HD4j0I=;
  b=KhhXveEp0pES82fjIObBWHU+msFPgZR9eAsOJAEeB2Nod0yeFNeVncr1
   Ccith8YE82XRscKHpEt3z4NE3v5kc2TjagxRqFMneBP0EHazuN29VjSoE
   lFbTnpBCwBr/g5tfbf0SuO9Rh2PiJismp1JtSokB3hKaCxyxsIjBssmZk
   UPFCvsyFgrowDuw3LY3/Y+RUerdMfEc1TJrEmU5aJjduUPIlBoxa491mC
   XczTn6/pzF5WiUIojNv1meGThZj9IoK6T4tC5dqa3fMnJzul5kqv/2cEs
   3DatW/BPx91HIZdnoQdAabHKNt72G5HeTH5KuZSTMpIKCJy8gowHzdv9l
   g==;
X-CSE-ConnectionGUID: TBWivM9LSdGRmtkkQmBj6A==
X-CSE-MsgGUID: YxMj/IwkT32giSQ2IP8zQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="64077570"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="64077570"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 14:48:40 -0800
X-CSE-ConnectionGUID: R2pLDkmiRtKb9+XyaT7yvw==
X-CSE-MsgGUID: a9f4NdGZTIWS7KICWckfQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117187056"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 14:48:39 -0800
From: Tony Luck <tony.luck@intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2 4/4] acpi_mrrm: fake for testing, do not apply!
Date: Thu, 27 Feb 2025 14:48:28 -0800
Message-ID: <20250227224828.306537-5-tony.luck@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227224828.306537-1-tony.luck@intel.com>
References: <20250227224828.306537-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dummy MRRM table for a 2 socket system with memory map:

						LocalAccess RemoteAccess
0-3.5G		DDR on socket 0			0	    1
2G-512G		More DDR on socket 0		0	    1
512G-1T		DDR on socket 1			0	    1
1T-2T		Reserved for CXL on socket 0	2	    3
2T-3T		Reserved for CXL on socket 1	2	    3

This tags all local DDR access in region 0, remote DDR in region 1,
local CXL in region 2, and remote CXL in region 3.

Presented to user like this:

$ cd /sys/firmware/acpi
$ grep ^ memory_ranges/*/*
memory_ranges/range0/base:0x0
memory_ranges/range0/length:0xe0000000
memory_ranges/range0/local_region_id:0x0
memory_ranges/range0/remote_region_id:0x1
memory_ranges/range1/base:0x100000000
memory_ranges/range1/length:0x7f00000000
memory_ranges/range1/local_region_id:0x0
memory_ranges/range1/remote_region_id:0x1
memory_ranges/range2/base:0x8000000000
memory_ranges/range2/length:0x8000000000
memory_ranges/range2/local_region_id:0x0
memory_ranges/range2/remote_region_id:0x1
memory_ranges/range3/base:0x10000000000
memory_ranges/range3/length:0x100000000000
memory_ranges/range3/local_region_id:0x2
memory_ranges/range3/remote_region_id:0x3
memory_ranges/range4/base:0x200000000000
memory_ranges/range4/length:0x100000000000
memory_ranges/range4/local_region_id:0x2
memory_ranges/range4/remote_region_id:0x3

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/acpi/acpi_mrrm.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/acpi/acpi_mrrm.c b/drivers/acpi/acpi_mrrm.c
index 1f7d0381a628..16f0ca7072e0 100644
--- a/drivers/acpi/acpi_mrrm.c
+++ b/drivers/acpi/acpi_mrrm.c
@@ -147,11 +147,35 @@ static __init int add_boot_memory_ranges(void)
 	return ret;
 }
 
+#define FAKE 1
+#ifdef FAKE
+static const u8 fake_mrrm[] = {
+	0x4D,0x52,0x52,0x4D,0xE0,0x00,0x00,0x00,0x01,0x3A,0x49,0x4E,0x54,0x45,0x4C,0x00,
+	0x49,0x4E,0x54,0x45,0x4C,0x20,0x49,0x44,0x02,0x00,0x00,0x00,0x49,0x4E,0x54,0x4C,
+	0x12,0x12,0x24,0x20,0x04,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+	0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+	0x00,0x00,0x20,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+	0x00,0x00,0x00,0xE0,0x00,0x00,0x00,0x00,0x03,0x00,0x00,0x01,0x00,0x00,0x00,0x00,
+	0x00,0x00,0x20,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00,0x00,0x00,
+	0x00,0x00,0x00,0x00,0x7F,0x00,0x00,0x00,0x03,0x00,0x00,0x01,0x00,0x00,0x00,0x00,
+	0x00,0x00,0x20,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x80,0x00,0x00,0x00,
+	0x00,0x00,0x00,0x00,0x80,0x00,0x00,0x00,0x03,0x00,0x00,0x01,0x00,0x00,0x00,0x00,
+	0x00,0x00,0x20,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00,0x00,
+	0x00,0x00,0x00,0x00,0x00,0x10,0x00,0x00,0x03,0x00,0x02,0x03,0x00,0x00,0x00,0x00,
+	0x00,0x00,0x20,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x20,0x00,0x00,
+	0x00,0x00,0x00,0x00,0x00,0x10,0x00,0x00,0x03,0x00,0x02,0x03,0x00,0x00,0x00,0x00
+};
+#endif
+
 static __init int mrrm_init(void)
 {
 	int ret;
 
+#ifdef FAKE
+	ret = acpi_parse_mrrm((struct acpi_table_header *)fake_mrrm);
+#else
 	ret = acpi_table_parse(ACPI_SIG_MRRM, acpi_parse_mrrm);
+#endif
 
 	if (ret < 0)
 		return ret;
-- 
2.48.1


