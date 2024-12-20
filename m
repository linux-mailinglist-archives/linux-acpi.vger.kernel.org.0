Return-Path: <linux-acpi+bounces-10232-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6B09F9C3F
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 22:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB3F188F2E6
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 21:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF2D22C34E;
	Fri, 20 Dec 2024 21:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B0oetdcH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9D4225A57;
	Fri, 20 Dec 2024 21:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734730766; cv=none; b=HCTU81hqOf+Cti/zjdAANprjHxRMcObHI8yUOY06wAK71nh8m1GhyfypofmhENNGJ1/kW8IOcA4pj9qt2LU+AbPf7IE5cVht597JTCBz0C1OKEf8ZtvUOcYOkL5RsqbETbQ065BWTdvN68yc/iJlSqYktsj5aj1BlmZ/HNRvC9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734730766; c=relaxed/simple;
	bh=lJi86SDL3jP0QQKtxfp4RUv5GIs6fNzg9Bs4+TE8C9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jvTGtjQDaXqee7+lm3qu/6ZmPRA+5MwpeVYdZlo5fP/87KO4pc11zxkxDNQLt9tSYu03dhLZH75i4BN9ub+SI7pKclpnJXyL97qqlxohw4feMJFM2hvhN49AOMYmxgE4WRV9cTUUjz/YtZcd4dE7fN3LzmdndQ2vA+7KkE3YwQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B0oetdcH; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734730765; x=1766266765;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lJi86SDL3jP0QQKtxfp4RUv5GIs6fNzg9Bs4+TE8C9k=;
  b=B0oetdcHmzcMGB31t25AtsQnXB9RoP1azrBnX+c/lPIjdDjhlYlQ2rd5
   V2x3Hs/OjeGeC9ahg2oM4hGrp2duEWa3bMTo36phxbpctugFlI9SBFEfM
   rZfrTULmxfgnakuyZKTT3fwiqntUB9mGnV3OdmQKF1BI+rv64O9zntjgO
   Bbd2Q2l5AiFryzzi7Cjcp1HZ+Q6qqsi+9veehcMCLkTXHDDyywQYwxEHy
   hJoMP1+JQgDFcmmkrs08Dx+YH1xNZkTBnG9RUTdTb6Oibcxk1RAgt37Y/
   BHC17I4gtmVFcIGK7N6GVVTJiFdUy/2aehX9e4CoN+mpUoRhYi5EZV/6S
   Q==;
X-CSE-ConnectionGUID: AGwseDzfRr2B3vIIDSijCQ==
X-CSE-MsgGUID: q8aGsFQZRIuquBC3EAt6QQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="39070769"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="39070769"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 13:39:19 -0800
X-CSE-ConnectionGUID: 6FliDagGSaCMJTHqIqm2SA==
X-CSE-MsgGUID: qQmQK1VHSF6HWdYzB5TIkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103223866"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa005.fm.intel.com with ESMTP; 20 Dec 2024 13:39:18 -0800
From: Sohil Mehta <sohil.mehta@intel.com>
To: x86@kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: [RFC PATCH 13/15] x86/cpu/intel: Bound the non-architectural constant_tsc model checks
Date: Fri, 20 Dec 2024 21:37:08 +0000
Message-ID: <20241220213711.1892696-14-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220213711.1892696-1-sohil.mehta@intel.com>
References: <20241220213711.1892696-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Constant TSC has been architectural on Intel CPUs for a while. Supported
CPUs use the architectural Invariant TSC bit in CPUID.80000007. A family
model check is not required for such CPUs.

Prevent unnecessary confusion but restricting the checks and moving it
closer to the architectural check.

Invariant TSC was likely introduced around the Nehalam timeframe on the
Xeon side and Saltwell timeframe on the Atom side. (Needs confirmation)
Due to interspersed model numbers use an Ivybridge model number check to
be safe.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/kernel/cpu/intel.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 26962a602e86..d37ef3a72234 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -210,10 +210,6 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 {
 	u64 misc_enable;
 
-	if ((c->x86 == 0xf && c->x86_model >= 0x03) ||
-		(c->x86 == 0x6 && c->x86_model >= 0x0e))
-		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
-
 	if (c->x86 >= 6 && !cpu_has(c, X86_FEATURE_IA64))
 		c->microcode = intel_get_microcode_revision();
 
@@ -272,6 +268,11 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
 	}
 
+	/* Some older CPUs have invariant TSC but may not report it architecturally via 8000_0007 */
+	if ((c->x86_vfm >= INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_WILLAMETTE) ||
+	    (c->x86_vfm >= INTEL_CORE_YONAH && c->x86_vfm <= INTEL_IVYBRIDGE))
+		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
+
 	/* Penwell and Cloverview have the TSC which doesn't sleep on S3 */
 	switch (c->x86_vfm) {
 	case INTEL_ATOM_SALTWELL_MID:
-- 
2.43.0


