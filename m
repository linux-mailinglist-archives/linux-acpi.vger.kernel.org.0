Return-Path: <linux-acpi+bounces-8787-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D797899DD3C
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Oct 2024 06:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D62F01C211EB
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Oct 2024 04:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838DF16E860;
	Tue, 15 Oct 2024 04:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QXz1assA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FCE4428;
	Tue, 15 Oct 2024 04:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728967711; cv=none; b=rz5h0YIU+V8OKkFHYizQMfl0J+kSL8JgJzRL1gFC6NmALBczvuu/HxLpoH0n+cKeA1uVZy65GyCTamcPHz+gszm3E/vnOAZaIsCrrUUlA6hoy5sc1xEuZVW29aFhoUWMuzCyRv0tCOzYS9wSpsZdN9bVphBMEcIWYhrXqTafunQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728967711; c=relaxed/simple;
	bh=Q6vGslhy7cEyzOgdV9Kt50rKZs8AFmPnEbqbeHRB5N8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OhiePnnPQCblZCiIKjC0ciEiJu0R1ZxSf4HlyBcyjGwsTnTbggM8RqzPITzJjGm3kfWzxLjMaIEGW6Igs9TesoXPz06+nCBDfqqAsB8Jpgxi1YDeIxitGXqMGYLuquulOBaICfAKXrLrkdNEXhrzz3itC2+YKWiD4g8reYrsegs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QXz1assA; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728967710; x=1760503710;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q6vGslhy7cEyzOgdV9Kt50rKZs8AFmPnEbqbeHRB5N8=;
  b=QXz1assAWfDKoDi0Gux/g0/X8IiFxMVSXY8UrJtP1T8fkdBOaV5K8HJ7
   3c7xniK1zFnm2S2wgamWIOAxHOQtgVEu6zrr4DeHaP3qVDAM+oNun7Ap8
   GP7bIQ//yNcQONDW1toZJ3ZfrtiHZ6EkAJyQWgjWhBYh4Pkdbg3mkGg6s
   gtD8tN4NvxgdxhFMNvU1R1FL434s0bTyX97za+W20VTAIB99/lOVfALeB
   FVmTUjSGIw7l3IbUlN96t1UKc635oSC3Ex4gHBkcKVZo0jraNiWy41TTc
   i7nw8Bsmd02AgdGvLA5Yz9pLYssCWJMthtlu3UBICTflJKG/NgBGz8l0u
   A==;
X-CSE-ConnectionGUID: CsSfbPqHQB6vUWp4dXVL7w==
X-CSE-MsgGUID: OUzbKeVzR5i2WUFVswBNPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28438645"
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="28438645"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 21:48:29 -0700
X-CSE-ConnectionGUID: 7+OuBUtMQR6gaq7E8rOOqg==
X-CSE-MsgGUID: vumhu9OCSH6IhQzQfXR4vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="108508106"
Received: from rzhang1-mobl7.sh.intel.com ([10.238.6.124])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 21:48:26 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Cc: rui.zhang@intel.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V3] x86/apic: Always explicitly disarm TSC-deadline timer
Date: Tue, 15 Oct 2024 12:48:17 +0800
Message-Id: <20241015044817.5375-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New processors have become pickier about the local APIC timer state
before entering low power modes. These low power modes are used (for
example) when you close your laptop lid and suspend. If you put your
laptop in a bag in this unnecessarily-high-power state, it is likely
to get quite toasty while it quickly sucks the battery dry.

The problem boils down to some CPUs' inability to power down until the
kernel fully disables the local APIC timer. The current kernel code
works in one-shot and periodic modes but does not work for deadline
mode. Deadline mode has been the supported and preferred mode on
Intel CPUs for over a decade and uses an MSR to drive the timer
instead of an APIC register.

Disable the TSC Deadline timer in lapic_timer_shutdown() by writing to
MSR_IA32_TSC_DEADLINE when in TSC-deadline mode. Also avoid writing
to the initial-count register (APIC_TMICT) which is ignored in
TSC-deadline mode.

Note: The APIC_LVTT|=APIC_LVT_MASKED operation should theoretically be
enough to tell the hardware that the timer will not fire in any of the
timer modes. But mitigating AMD erratum 411[1] also requires clearing
out APIC_TMICT. Solely setting APIC_LVT_MASKED is also ineffective in
practice on Intel Lunar Lake systems, which is the motivation for this
change.

1. 411 Processor May Exit Message-Triggered C1E State Without an Interrupt if Local APIC Timer Reaches Zero - https://www.amd.com/content/dam/amd/en/documents/archived-tech-docs/revision-guides/41322_10h_Rev_Gd.pdf

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Tested-by: Todd Brandt <todd.e.brandt@intel.com>
---
V2
- Improve changelog
V3
- Subject and changelog rewrite
- Check LAPIC Timer mode using APIC_LVTT value instead of extra CPU feature flag check
- Avoid APIC_TMICT write which is ignored in TSC-deadline mode
---
 arch/x86/kernel/apic/apic.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 6513c53c9459..5436a4083065 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -440,7 +440,19 @@ static int lapic_timer_shutdown(struct clock_event_device *evt)
 	v = apic_read(APIC_LVTT);
 	v |= (APIC_LVT_MASKED | LOCAL_TIMER_VECTOR);
 	apic_write(APIC_LVTT, v);
-	apic_write(APIC_TMICT, 0);
+
+	/*
+	 * Setting APIC_LVT_MASKED should be enough to tell the
+	 * hardware that this timer will never fire. But AMD
+	 * erratum 411 and some Intel CPU behavior circa 2024
+	 * say otherwise. Time for belt and suspenders programming,
+	 * mask the timer and zero the counter registers:
+	 */
+	if (v & APIC_LVT_TIMER_TSCDEADLINE)
+		wrmsrl(MSR_IA32_TSC_DEADLINE, 0);
+	else
+		apic_write(APIC_TMICT, 0);
+
 	return 0;
 }
 
-- 
2.34.1


