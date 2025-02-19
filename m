Return-Path: <linux-acpi+bounces-11304-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C050A3C89D
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 20:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F613A7B30
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 19:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505D522ACFB;
	Wed, 19 Feb 2025 19:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SRuqLXOF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BAB1F3FC8;
	Wed, 19 Feb 2025 19:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739993308; cv=none; b=WN6a6iFrkzuE7yZSyumUnm1soq5ZMin8q8r6g+drE9KDjalzg8/RcPHoyYUqy7UoS9Kh3wMCxI/vrXuXyvD+e4V8Lg3ltQy6glxxFBoWQ8jyBMhgJeFXnXUOyYndH0KuzbDXkruEWtoFThed2W9oZ4XgB15xrhZHNHn1ImRHoKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739993308; c=relaxed/simple;
	bh=ZxgjjTOf0eO9C1n3ehn9Thqcxmzs3zf5Ywl8XjOse/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKwCT4XKtZ5i4KKaa930rduBASLf2C13fP/gQ849omzjygF6OA0Y7X8CGeastJKnI8MACS/fwlj3QSXAR1aRbOaanLFGuNGAnn13ppDY+l+bULFoCerpOCczrFZgsF79bUUJW+Ny4im9gkS6hc+4gNYbroCnFuGLLaXMniMT4Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SRuqLXOF; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739993306; x=1771529306;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZxgjjTOf0eO9C1n3ehn9Thqcxmzs3zf5Ywl8XjOse/8=;
  b=SRuqLXOF6J3LKEmLdY1jWNzl9pCckXe7FF4qCh3S4nKLweLQYfWB2e/A
   F67PEeAEbU90KLzANEctxP/YHTOtrynR2MhCpB0zf/uvN9qXGPCi+7duQ
   aSdz2OX6zcBQBXbO5oQtt8MXsVaGGPmvMkYuh8EcnnXF588kyITIZ7QsZ
   Y2M33phCuWJ7lfgNiTCufoUWoeVuS0QB6JX19ispOmi3eZcGLlKfTIb36
   vEvm6FT1Ziag/o3oYanqH9Z52Fo7u10D77rJ7SN+I2ekcHjb499KBsLBY
   0R5mGZN2tqiqXOwERhDBGc1k2OYj0ZpWsHrdlRpLPLlrUaQZG8Lc43Nx0
   g==;
X-CSE-ConnectionGUID: AHKtx7FyRH2htuouk/77Zw==
X-CSE-MsgGUID: 78MBF8+bTBK2E3smqdcOog==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52182745"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52182745"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 11:28:25 -0800
X-CSE-ConnectionGUID: RkoY1f1PRZCz0fmsoR8Ojw==
X-CSE-MsgGUID: 8VxTYZAmRWqjzcXqWfscoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="115344001"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa010.fm.intel.com with ESMTP; 19 Feb 2025 10:44:48 -0800
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
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Zhang Rui <rui.zhang@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	David Laight <david.laight.linux@gmail.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 01/15] x86/apic: Fix 32-bit APIC initialization for extended Intel Families
Date: Wed, 19 Feb 2025 18:41:19 +0000
Message-ID: <20250219184133.816753-2-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219184133.816753-1-sohil.mehta@intel.com>
References: <20250219184133.816753-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

APIC detection is currently limited to a few specific Families and will
not match the upcoming Families >=18.

Extend the check to include all Families 6 or greater. Also convert it
to a VFM check to make it simpler.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
---
v3: No change
v2: Update commit message to make it more precise
---
 arch/x86/kernel/apic/apic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index e893dc6f11c1..4d99bd65faf5 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2014,8 +2014,8 @@ static bool __init detect_init_APIC(void)
 	case X86_VENDOR_HYGON:
 		break;
 	case X86_VENDOR_INTEL:
-		if (boot_cpu_data.x86 == 6 || boot_cpu_data.x86 == 15 ||
-		    (boot_cpu_data.x86 == 5 && boot_cpu_has(X86_FEATURE_APIC)))
+		if ((boot_cpu_data.x86 == 5 && boot_cpu_has(X86_FEATURE_APIC)) ||
+		    boot_cpu_data.x86_vfm >= INTEL_PENTIUM_PRO)
 			break;
 		goto no_apic;
 	default:
-- 
2.43.0


