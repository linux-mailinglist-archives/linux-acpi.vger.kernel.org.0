Return-Path: <linux-acpi+bounces-6061-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F14448D2369
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 20:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0FFC285ABA
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 18:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1589174EFC;
	Tue, 28 May 2024 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NZgKXocg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E28D17165C;
	Tue, 28 May 2024 18:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716922059; cv=none; b=ZKuACA0VGtIPdlfbCpZZdm4prekA6kKJon8VVnoudUfsIYx3iZiN5CCs+k5qldgL32CByvnrLmmTZfOftUdbw8FDqfGcDGvDrSwVBpdQHMxjQk1OHRJ4SFq8a/4ru1SM8enGyXfPkGsmxekr93bEG/LCZXr8eR6Ni10ftVkJaRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716922059; c=relaxed/simple;
	bh=Sbt9Xz2Ynh3GTpeHeMDFV/YANtnFR7us28NjBssk4I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aKg9xz0cF18XkjzbnW/IwrMQSrU/1DAUE97dOzJFzhZenKAg2p3OAfWrFqctUdIeTcua3JqP4mykHH1HjNNsXPVno5BjRVGhZ5XJ0qkqAsmvJbvrgKIWr9L9QxmwnfYFMEZXIobquNhpgskzvouM6BJQ2g4VSezvAiQsrY4tyoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NZgKXocg; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716922059; x=1748458059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Sbt9Xz2Ynh3GTpeHeMDFV/YANtnFR7us28NjBssk4I0=;
  b=NZgKXocgINgMP8lI49yQwDquxAuim1Q6HSnASgNWLvIeL0TiauyLj3lx
   zjmyvj0RVvz3l4Lkn84h/Abb5Juxx1dzap70ycuFvLbn8NSRKr3x/csZY
   yy/JgyXfs1bkkOJK2aRnbw3x1qQU2s9R6iZcpty+KhhOsIeV4Rthh7qHN
   R/EysrdTbER+CLVLeWdwPLf68k1Lc+mfPYlJyoAc6oJs9jJ3hClAtGeD3
   RVltieaXY/D5wRzIz1Cv00Al0FMS89jMjkuAXxeBRsdNPMk+QsL4dR31J
   GnYipbbTU5xSfWKXda2NjFdZispGSvlXd83TDAI8B5Eh21EGRVOq18Jmj
   w==;
X-CSE-ConnectionGUID: Y4mejYK5SO62oOHivmFnLg==
X-CSE-MsgGUID: PZTpAsKmROOw/bWJbwwB8A==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="17121560"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="17121560"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 11:47:30 -0700
X-CSE-ConnectionGUID: X39/DewpROelWO+06rnIhw==
X-CSE-MsgGUID: MWa/eYfLSn6KEqrRra4tnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="72605175"
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
Subject: [PATCH 4/8] ASoC: Intel: Switch to new Intel CPU model defines
Date: Tue, 28 May 2024 11:47:16 -0700
Message-ID: <20240528184720.56259-5-tony.luck@intel.com>
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
 include/linux/platform_data/x86/soc.h         | 12 ++++++------
 drivers/thermal/intel/intel_soc_dts_thermal.c |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/platform_data/x86/soc.h b/include/linux/platform_data/x86/soc.h
index a5705189e2ac..f981907a5cb0 100644
--- a/include/linux/platform_data/x86/soc.h
+++ b/include/linux/platform_data/x86/soc.h
@@ -20,7 +20,7 @@
 static inline bool soc_intel_is_##soc(void)			\
 {								\
 	static const struct x86_cpu_id soc##_cpu_ids[] = {	\
-		X86_MATCH_INTEL_FAM6_MODEL(type, NULL),		\
+		X86_MATCH_VFM(type, NULL),			\
 		{}						\
 	};							\
 	const struct x86_cpu_id *id;				\
@@ -31,11 +31,11 @@ static inline bool soc_intel_is_##soc(void)			\
 	return false;						\
 }
 
-SOC_INTEL_IS_CPU(byt, ATOM_SILVERMONT);
-SOC_INTEL_IS_CPU(cht, ATOM_AIRMONT);
-SOC_INTEL_IS_CPU(apl, ATOM_GOLDMONT);
-SOC_INTEL_IS_CPU(glk, ATOM_GOLDMONT_PLUS);
-SOC_INTEL_IS_CPU(cml, KABYLAKE_L);
+SOC_INTEL_IS_CPU(byt, INTEL_ATOM_SILVERMONT);
+SOC_INTEL_IS_CPU(cht, INTEL_ATOM_AIRMONT);
+SOC_INTEL_IS_CPU(apl, INTEL_ATOM_GOLDMONT);
+SOC_INTEL_IS_CPU(glk, INTEL_ATOM_GOLDMONT_PLUS);
+SOC_INTEL_IS_CPU(cml, INTEL_KABYLAKE_L);
 
 #undef SOC_INTEL_IS_CPU
 
diff --git a/drivers/thermal/intel/intel_soc_dts_thermal.c b/drivers/thermal/intel/intel_soc_dts_thermal.c
index 9c825c6e1f38..718c6326eaf4 100644
--- a/drivers/thermal/intel/intel_soc_dts_thermal.c
+++ b/drivers/thermal/intel/intel_soc_dts_thermal.c
@@ -36,7 +36,7 @@ static irqreturn_t soc_irq_thread_fn(int irq, void *dev_data)
 }
 
 static const struct x86_cpu_id soc_thermal_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT, BYT_SOC_DTS_APIC_IRQ),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT, BYT_SOC_DTS_APIC_IRQ),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, soc_thermal_ids);
-- 
2.45.0


