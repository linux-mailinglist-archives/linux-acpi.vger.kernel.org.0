Return-Path: <linux-acpi+bounces-11040-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C62A315B8
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 20:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 326E67A4189
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 19:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9483D265CCB;
	Tue, 11 Feb 2025 19:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DbMS2vCG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE13264621;
	Tue, 11 Feb 2025 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303197; cv=none; b=LMSGr/TSqlMkzOITTu1LO0IvIOkkivLSnM8VbfvDXLhgf152ml/kcFePBeMndKR1za3N83eC451bLtm2zfv5zzMcJC57yWYclLSHsLs8iZW7ZPzQI4HjTEcX07unYm0VezzU2zj+Ilso4UJ0Twy6UmkCmnYoYAtSnv7KpnlUAAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303197; c=relaxed/simple;
	bh=nzUCrs1+DTXuNre3max01ArGpANP9d9Vy4S2KxVyNPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jg080a5sQtP0TEJiJclHAHmXWrMfQM2EY6DeGmrbPOI5Z4F6ruzj2KuDthwNFJNcM5CCKrO425i93uybYrI/paPkKrjBff02F/HxTdp9fpzzHEBMxAmSaDcMxUplrhDXHTdzSaRbjeomRVPgoQmjDrs8Rr/csKCoKp4R5OGhwwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DbMS2vCG; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739303196; x=1770839196;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nzUCrs1+DTXuNre3max01ArGpANP9d9Vy4S2KxVyNPg=;
  b=DbMS2vCG7CApEu354OFasqhtdEx6ZZhWPmTx9BN3EktxV1ahDuzXoT74
   uq6PJnapscu2rEGs+T0ovri4TtpVwl5eubOlu7LckNllHLBZ0/EjNJFbE
   sKaQXbSbVMkk2zetqgkF3vXB/nl6mzbA/HwxZxzgfslY5OESMTFn9Lpxf
   mIjlMdOPapG3QXxAasCTP3a8Z5P47VIGkDST1oqm6D/g+F0l5NZhlp1MD
   RWS6kQfPFHImlruCjKnw5ZjcrUqpL6LgEXiQUrHP/rsL/yLdzwAQFtGQt
   kHGl3+1WoeXSQ8Mxd8jJI2QPT7lQrQDSbpD1WgFSfCE6UAY/swINGWoS4
   w==;
X-CSE-ConnectionGUID: lw6r7UAPSRSUSEuSCZncIw==
X-CSE-MsgGUID: NPr08YlPTqaT/zm+R4qJJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39854913"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="39854913"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 11:46:33 -0800
X-CSE-ConnectionGUID: fwJaGHBtQI6D7LhuuIK/xQ==
X-CSE-MsgGUID: NPAaN3yLShqbZTeGCxww8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="143519283"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa001.fm.intel.com with ESMTP; 11 Feb 2025 11:46:33 -0800
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
	Zhang Rui <rui.zhang@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	David Laight <david.laight.linux@gmail.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: [PATCH v2 08/17] x86/microcode: Update the Intel processor flag scan check
Date: Tue, 11 Feb 2025 19:43:58 +0000
Message-ID: <20250211194407.2577252-9-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250211194407.2577252-1-sohil.mehta@intel.com>
References: <20250211194407.2577252-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Family model check to read the processor flag MSR is misleading and
potentially incorrect. It doesn't consider Family while comparing the
model number. The original check did have a Family number but it got
lost/moved during refactoring.

intel_collect_cpu_info() is called through multiple paths such as early
initialization, CPU hotplug as well as IFS image load. Some of these
flows would be error prone due to the ambiguous check.

Correct the processor flag scan check to use a Family number and update
it to a VFM based one to make it more readable.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>

---

v2: Use a VFM check instead of hardcoded numbers.

I evaluted whether CPUID can be avoided in intel_collect_cpu_info(). But
the answer seems a bit more complex than I expected.

* On the BSP, intel_collect_cpu_info() can be called very early
  via load_ucode_bsp() even before cpu_data[] has been populated.

* In the hotplug path, based on section II.c. of
  Documentation/power/suspend-and-cpuhotplug.rst rescanning of FMS
  during ucode load might be intentional.

Maybe this can be resolved by updating the Intel ucode load flows to
pass the CPU information or the cpuid_eax information around. But it is
beyond the scope of this series. Also, I am not sure whether the
effort/risk would be worth saving a single cpuid() call in an uncommon
path. If this is desired, I can work on it in a seperate patch.

---
 arch/x86/include/asm/intel-family.h   | 1 +
 arch/x86/kernel/cpu/microcode/intel.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 6d7b04ffc5fd..cccc932d761e 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -46,6 +46,7 @@
 #define INTEL_ANY			IFM(X86_FAMILY_ANY, X86_MODEL_ANY)
 
 #define INTEL_PENTIUM_PRO		IFM(6, 0x01)
+#define INTEL_PENTIUM_III_DESCHUTES	IFM(6, 0x05)
 
 #define INTEL_CORE_YONAH		IFM(6, 0x0E)
 
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index f3d534807d91..819199bc0119 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -74,7 +74,7 @@ void intel_collect_cpu_info(struct cpu_signature *sig)
 	sig->pf = 0;
 	sig->rev = intel_get_microcode_revision();
 
-	if (x86_model(sig->sig) >= 5 || x86_family(sig->sig) > 6) {
+	if (IFM(x86_family(sig->sig), x86_model(sig->sig)) >= INTEL_PENTIUM_III_DESCHUTES) {
 		unsigned int val[2];
 
 		/* get processor flags from MSR 0x17 */
-- 
2.43.0


