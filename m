Return-Path: <linux-acpi+bounces-6065-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EC98D2378
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 20:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920F11F22E84
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 18:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AF0178CD2;
	Tue, 28 May 2024 18:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fpT9Y7/L"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C72176FBE;
	Tue, 28 May 2024 18:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716922062; cv=none; b=c/b5nJgMqA7HMVSdKpKu7HtobMU3rVTuJR5jFxEcdVRxfQxcfqcn2mh+Zvoaw6xXUf0OJm3+wK5Fc7mGSz4wNiUU0dCipWtd6h7lAW4jKadUZ8Pb3CzzE8BbaSS5XDdo2KYVtq7AXHdP/deC1Wx3aRDjGcmzjFV4WSKEB5ugbTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716922062; c=relaxed/simple;
	bh=+cW1FKmICz5yWt4FR2pNW4rOWKXVwnN1+017ENhmnxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ITILNSjyRaYTY0/AHcyJAxBs2FpcIPe/VGcD9PX4vL5aA0YVJMSKFUoDct4XGEJusYk0uJzcqLNjloyzKOqRYmINkv3G98UpDWfWkjqG2Wu/qEprvuVv/XFsUM8eyJ6nbHg0Bky986Rd7OlsrYFrZ2vQlZYgXTdEmkWW2AUrSPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fpT9Y7/L; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716922061; x=1748458061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+cW1FKmICz5yWt4FR2pNW4rOWKXVwnN1+017ENhmnxI=;
  b=fpT9Y7/Lpnh79j6d2xKDQC+fDZBTldz8SYXPllA4+dm/Ahi2T2xByU0q
   eOSBxTtULa2K8I3whiYGmbHq7DME05GBSSCsJeRtJ8T4CqyPDMO3/ZAIu
   y10T+CjzS3CdslRBpwitUhLHrEeCpPflzvMYvhqk8AM9HHCNm0sSIEf0h
   +4rwkKvyDI+1FMbvWSRAPyh9NMSrEkoLUO+fCbObJB97Auna94RE4nmKC
   QFZQAx9GTT1XuFjLaH7ZtOR6m+uogjPkFNND5Uv+Wfs1KwJ3uWV0AdHd/
   w3G6BAUu6UzcKGCXXlHeKbwl1p1HcN78OANw3/uJ/YfT26j9Xn8tI86tp
   Q==;
X-CSE-ConnectionGUID: mL/yk3eRSwyGQevUDl3gRA==
X-CSE-MsgGUID: YmmQBx6bQDmuQbGke7dfPA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="17121575"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="17121575"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 11:47:31 -0700
X-CSE-ConnectionGUID: x/ICtLuYRZKz8pLqelCWdg==
X-CSE-MsgGUID: S1Y9awmZSRCYnRk7JEJDvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="72605188"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 11:47:31 -0700
From: Tony Luck <tony.luck@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 8/8] powercap: intel_rapl: Switch to new Intel CPU model defines
Date: Tue, 28 May 2024 11:47:20 -0700
Message-ID: <20240528184720.56259-9-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240528184720.56259-1-tony.luck@intel.com>
References: <20240528184720.56259-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 120 +++++++++++++--------------
 1 file changed, 60 insertions(+), 60 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index aac0744011a3..3cffa6c79538 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1222,66 +1222,66 @@ static const struct rapl_defaults rapl_defaults_amd = {
 };
 
 static const struct x86_cpu_id rapl_ids[] __initconst = {
-	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(SANDYBRIDGE_X,	&rapl_defaults_core),
-
-	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE_X,		&rapl_defaults_core),
-
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_L,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_G,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_X,		&rapl_defaults_hsw_server),
-
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_G,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_D,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X,		&rapl_defaults_hsw_server),
-
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,		&rapl_defaults_hsw_server),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(CANNONLAKE_L,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_NNPI,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&rapl_defaults_hsw_server),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&rapl_defaults_hsw_server),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        &rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&rapl_defaults_spr_server),
-	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,	&rapl_defaults_spr_server),
-	X86_MATCH_INTEL_FAM6_MODEL(LUNARLAKE_M,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE_H,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ARROWLAKE,		&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(LAKEFIELD,		&rapl_defaults_core),
-
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT,	&rapl_defaults_byt),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT,	&rapl_defaults_cht),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID,	&rapl_defaults_tng),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_AIRMONT_MID,	&rapl_defaults_ann),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_PLUS,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_D,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&rapl_defaults_core),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	&rapl_defaults_core),
-
-	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNL,	&rapl_defaults_hsw_server),
-	X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,	&rapl_defaults_hsw_server),
+	X86_MATCH_VFM(INTEL_SANDYBRIDGE,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_SANDYBRIDGE_X,	&rapl_defaults_core),
+
+	X86_MATCH_VFM(INTEL_IVYBRIDGE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_IVYBRIDGE_X,	&rapl_defaults_core),
+
+	X86_MATCH_VFM(INTEL_HASWELL,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_HASWELL_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_HASWELL_G,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_HASWELL_X,		&rapl_defaults_hsw_server),
+
+	X86_MATCH_VFM(INTEL_BROADWELL,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_BROADWELL_G,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_BROADWELL_D,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_BROADWELL_X,	&rapl_defaults_hsw_server),
+
+	X86_MATCH_VFM(INTEL_SKYLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_SKYLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_SKYLAKE_X,		&rapl_defaults_hsw_server),
+	X86_MATCH_VFM(INTEL_KABYLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_KABYLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_CANNONLAKE_L,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ICELAKE_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ICELAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ICELAKE_NNPI,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ICELAKE_X,		&rapl_defaults_hsw_server),
+	X86_MATCH_VFM(INTEL_ICELAKE_D,		&rapl_defaults_hsw_server),
+	X86_MATCH_VFM(INTEL_COMETLAKE_L,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_COMETLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_TIGERLAKE_L,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_TIGERLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ROCKETLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ALDERLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,        &rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_METEORLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_METEORLAKE_L,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,	&rapl_defaults_spr_server),
+	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,	&rapl_defaults_spr_server),
+	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ARROWLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_LAKEFIELD,		&rapl_defaults_core),
+
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT,	&rapl_defaults_byt),
+	X86_MATCH_VFM(INTEL_ATOM_AIRMONT,	&rapl_defaults_cht),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID, &rapl_defaults_tng),
+	X86_MATCH_VFM(INTEL_ATOM_AIRMONT_MID,	&rapl_defaults_ann),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_PLUS,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_D,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT_D,	&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT_L,	&rapl_defaults_core),
+
+	X86_MATCH_VFM(INTEL_XEON_PHI_KNL,	&rapl_defaults_hsw_server),
+	X86_MATCH_VFM(INTEL_XEON_PHI_KNM,	&rapl_defaults_hsw_server),
 
 	X86_MATCH_VENDOR_FAM(AMD, 0x17, &rapl_defaults_amd),
 	X86_MATCH_VENDOR_FAM(AMD, 0x19, &rapl_defaults_amd),
-- 
2.45.0


