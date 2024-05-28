Return-Path: <linux-acpi+bounces-6058-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5CF8D2362
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 20:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6BC1F23AA7
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 18:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38929171640;
	Tue, 28 May 2024 18:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jf5fMO6O"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4ED2E84A;
	Tue, 28 May 2024 18:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716922058; cv=none; b=fb5UpaAuF/TrY474kwFGtlnqjMcrAlrtDC9MpcMOsBsy1vezAsdkRpS8ZR4i3aNeyRzfTgbGiAnMLsU6NCCIwWtso/uuG4QeWAxHBr7ie7pjXJtjy4Z60/naV60IPGo1mOzkK2P2uwR0n7Ncnl8MTh/P/fBGUWexdLlvhCMwk6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716922058; c=relaxed/simple;
	bh=N7BO8ma+2BwG4UD9NIGMDLMhLyzkgYBOUd3reNFktso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBIdY/uJ/z1D4Y9zDecjOEDTCjensoNGTEKW9ZrQHl5XCrYwwxe6ZbRKRfbIIT9fSG5ZEWwBE4CZM1a2kIGy8zp5/L8LKxqf2vKTTQGdJ9FzN91vHx6tIv8/zVtZ/fhuUEK+SUqT84tCF31zcYe1E7LVSPysF8Sh1/QgJqlAjGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jf5fMO6O; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716922057; x=1748458057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N7BO8ma+2BwG4UD9NIGMDLMhLyzkgYBOUd3reNFktso=;
  b=jf5fMO6OEU7KCkjWVlwNv3p2N3uQepyJTEMB6rOxEr538Nt28PE2/6CT
   OlkokcINkd1Wdlz0CgKAheDcNKju3V2FT7kERCY/qYyAOaCFWAHviaxZz
   C/g12HkKCkYSGL1bEvTbH3geZVBPZa/56ZI1pUYVMc0M59S4YWZqEZjpW
   1/SMvfCkqHhqCjb7Vop/PhafSii4WmFGKCaWgbn071hadUDCe8nPAL23R
   Mj7U2WaeQEeqpul/lPjWhTzEMOllM7RJBA7/gvOMwO6lgqX6G9bsbJd4j
   qdmLqd2WLiiF3lkrjQXQcY0kxQWuGAG66uorvI+pmNr/Ep8MJF09UgRGx
   w==;
X-CSE-ConnectionGUID: ExI4jlWPTvyHfxin4DKT/A==
X-CSE-MsgGUID: EVGlhOx2Q1yDm1UeJnQkxQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="17121550"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="17121550"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 11:47:30 -0700
X-CSE-ConnectionGUID: 34FZ5QROR4GOrHgCt0RUuA==
X-CSE-MsgGUID: qyNVppiNRqadtjb7LBd4ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="72605166"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 11:47:29 -0700
From: Tony Luck <tony.luck@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 1/8] cpufreq: Switch to new Intel CPU model defines
Date: Tue, 28 May 2024 11:47:13 -0700
Message-ID: <20240528184720.56259-2-tony.luck@intel.com>
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
 drivers/cpufreq/speedstep-centrino.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/speedstep-centrino.c b/drivers/cpufreq/speedstep-centrino.c
index 75b10ecdb60f..ddd6f53bfd2a 100644
--- a/drivers/cpufreq/speedstep-centrino.c
+++ b/drivers/cpufreq/speedstep-centrino.c
@@ -520,10 +520,10 @@ static struct cpufreq_driver centrino_driver = {
  * or ASCII model IDs.
  */
 static const struct x86_cpu_id centrino_ids[] = {
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL,  6,  9, X86_FEATURE_EST, NULL),
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL,  6, 13, X86_FEATURE_EST, NULL),
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 15,  3, X86_FEATURE_EST, NULL),
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 15,  4, X86_FEATURE_EST, NULL),
+	X86_MATCH_VFM_FEATURE(IFM( 6,  9), X86_FEATURE_EST, NULL),
+	X86_MATCH_VFM_FEATURE(IFM( 6, 13), X86_FEATURE_EST, NULL),
+	X86_MATCH_VFM_FEATURE(IFM(15,  3), X86_FEATURE_EST, NULL),
+	X86_MATCH_VFM_FEATURE(IFM(15,  4), X86_FEATURE_EST, NULL),
 	{}
 };
 
-- 
2.45.0


