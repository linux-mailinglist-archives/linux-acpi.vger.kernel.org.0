Return-Path: <linux-acpi+bounces-6060-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8708D2367
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 20:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A100E1C22B0B
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 18:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6278517335C;
	Tue, 28 May 2024 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OWHdKjSV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C8A170829;
	Tue, 28 May 2024 18:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716922059; cv=none; b=LKzc/7EnzBjKhydNqfFoPTRxTmRs3Ok1WlwJlyZlP5NjG2LqFP29OvOwJGtICbyxkGq2hSYNu7+onN9RUsSx6/AlPLZHYNTkzsz2rvN1z3EzWO5whgNX2/a9rUaDhi1XO/0KYcX3IIzWgom8vMrZI6vVGAsbe1GZJDgg93axS6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716922059; c=relaxed/simple;
	bh=gCPJaBoIddAMPrycAKcstPhp40qC+YN7SQoPWeSGRBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gHtWXAyeYp/HRMOoIGwN+BCPgn1KY9NZgQlo26W16clL1brLhL0rHgJIv7soHK/wtH7t5dT29xfPcTQ2VTEunvwjgXdcHeFZhFMhfobKQZIbRmBAhLi+lHwepJZgX7G5u8IzGE/s+jJg1xjLsDKzTjFyn/QzIywN/Q+29R5Zh3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OWHdKjSV; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716922058; x=1748458058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gCPJaBoIddAMPrycAKcstPhp40qC+YN7SQoPWeSGRBc=;
  b=OWHdKjSVoOeSzkCKYpe+yMRHetAt9PZj/ra/1Nkk/eo/qkQULDvFeY1q
   Rrw69LBWExIKnhR5ZauoDUSoIVOFIov9l/h1UKcf5I4/7JYVGZx5JTVyB
   rYBIMA1v1mTkS1kN0D8R+JLxTxuvWr4sGtRMcXBrQtFkauW55HSgnEStP
   3UBVfMuw4zdmmoq66o9Cw68rxOEtiMkwCs8HC+YmjOp2frK8mNzJBLNXG
   Xn3plnI8tisLMAv+lzmCyny3teikgKEgmmZ8kJ4tQmDJhFz+JM/DgIY64
   PBDpsIeyem8X0AcPF7Hiw75X1n/L1ntxdOhkzwTd9Wy2OUH8zsBOY0Hg4
   w==;
X-CSE-ConnectionGUID: ZLaWW4mURAaygCCjuE/J5A==
X-CSE-MsgGUID: w9c/jxyaSfaKtSwhFmI0Tg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="17121557"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="17121557"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 11:47:30 -0700
X-CSE-ConnectionGUID: UwKk+SjiTlunVKqNRuBxZg==
X-CSE-MsgGUID: 2iHpidKsQ12CcXeFDjB0cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="72605172"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 11:47:30 -0700
From: Tony Luck <tony.luck@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 3/8] powercap: intel_rapl: Switch to new Intel CPU model defines
Date: Tue, 28 May 2024 11:47:15 -0700
Message-ID: <20240528184720.56259-4-tony.luck@intel.com>
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
 drivers/powercap/intel_rapl_msr.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 35cb152fa9aa..733a36f67fbc 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -139,14 +139,14 @@ static int rapl_msr_write_raw(int cpu, struct reg_action *ra)
 
 /* List of verified CPUs. */
 static const struct x86_cpu_id pl4_support_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_TIGERLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_ALDERLAKE, NULL),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT, NULL),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE, NULL),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P, NULL),
+	X86_MATCH_VFM(INTEL_METEORLAKE, NULL),
+	X86_MATCH_VFM(INTEL_METEORLAKE_L, NULL),
 	{}
 };
 
-- 
2.45.0


