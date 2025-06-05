Return-Path: <linux-acpi+bounces-14155-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21173ACF2AE
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 17:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BB787AC8F7
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 15:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F389826156A;
	Thu,  5 Jun 2025 15:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="dGTjAS2Y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CC1213236;
	Thu,  5 Jun 2025 15:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749136200; cv=none; b=n+CXeaxquDyHACNSSlrklGP0b1KcbY9NF6/5eUTdyCZBlhH7c+pdh83Vo8tKMbUyoG0ZLaF2U+NSqUiTCQwah7fzU/ufJ7uEbJx2XDhbLudvWg7qUHgCpE14Lghi+Crs0KEa+Lek82lQfJgHAKAW3xrpaMj6esTC5C++MT/VWyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749136200; c=relaxed/simple;
	bh=zn5CSctDyQsT/L2Pm39ZZn7bjDup1bfb5cvHM/imHRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ffdbByc0sWGpp5Q58iJKargjog/crjVuDkpOmep0Wh5FOp74fNz4F8g1x8VCXszc15dU2JeuAwWKVrCj+va9a+Fv2OFPgT9OkeXqaMS+DjkxMelCZFu0GEvXFHVOEReWhS9S8sYy341+R2TGISdr8thgfWFN1ScOnvmnoCfxis0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=dGTjAS2Y; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 2D30D66C03E;
	Thu,  5 Jun 2025 17:09:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1749136187;
	bh=zn5CSctDyQsT/L2Pm39ZZn7bjDup1bfb5cvHM/imHRE=;
	h=From:Subject:Date;
	b=dGTjAS2YScgoZkHJ+Oo4cWLkjAnDp9CEQxScjDah+ZFMDIOkRkmnhiqXTozBL66Ex
	 +7Fe3jyfjEUV7pwOaR/TPXoIzCrkLYZJ7NetGsF9hTHeURnaL/CZMGtEOJp5zm+CNp
	 gRi0kBLh0cQ2QCPlU+YGgUxADLzYyycXwliDfb09rIb7AaMxXKikrhp44waH5fa8PF
	 pjdGwxuVHP1Ih9OBmlSOy3tHPpmDVG4083bueSU/P4ORIZYcBN3VIUx25dQ9ZnrBJr
	 J0Zd2mB80d4neEVUMx9oLQ4G9CDmMxmM2JTWmZRroPOgBjfx/TgDwnOMev9XqDJloO
	 B3biorch762ew==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: x86 Maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Linux ACPI <linux-acpi@vger.kernel.org>
Subject: [PATCH v1 2/5] x86/smp: PM/hibernate: Split arch_resume_nosmt()
Date: Thu, 05 Jun 2025 17:05:24 +0200
Message-ID: <3361688.44csPzL39Z@rjwysocki.net>
In-Reply-To: <2226957.irdbgypaU6@rjwysocki.net>
References: <2226957.irdbgypaU6@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 5.63.189.50
X-CLIENT-HOSTNAME: 5.63.189.50
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: dmFkZTEzSEGzZ/ONVrWENr6vcXfS3S2jicISDIUk4t6WJg+Zjj/tMsiKrH6p/W9hVn65rDd2JKDd5uTYEHknKQT2r7pOoqF3rdVD5yhK7Rprhh7g9Zvcj23lpp2rY7UCLtUpLjrE40L5kP2ENOt7F7JFMQrsU0BxCSyD9ImwCg/5uHKqloLfTfX1B6buKhq24d5iBCDj1fuCRg5EDPCCcGoXCAG/xJ8DxnVxdLMqNeA6Murrcf5yV2bVSf0qD3cTb1ZGJEaagT8ZwEZw1hwmHq4GBUTZA/geTkMBRKK8IMyXCx4LjU27eYT2E9Bi7kPkpz1heTPAWpmaTKgTxzYdBmQllqRTTwMDfwG+Sgkl3X2bgxU9r4IS3Tl9pii23Hp2cX6urAKdnsGV9LGP7DU5W5jGFf6HL4d3qV/8+OUbV1vnRD1WTrNI/1taJTojkpvyIpTpGJr598cIfei46Yt7yXKH2jjvfwH2y+Vohnf+1tlwl8d4Z4jJHSwRKG/s2ZQ9tMVn65xIpQxXNqH70uNEPRDk+20vjoDMEX5rziCkuFqLWebbD9rpWMO58weWz/+XTOFEOuznvL8JE2KcGt8cpeqezge5Dnm7dGW4FUedskzCerp3+RxGsvY8c1UM7c1+p1++SGe5LJmpVlfifu+8OgJC3OJBqayA6D2IIkYdKO2HRzQ3VA
X-DCC--Metrics: v370.home.net.pl 1024; Body=12 Fuz1=12 Fuz2=12

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Move the inner part of the arch_resume_nosmt() code into a separate
function called arch_cpu_rescan_dead_smt_siblings(), so it can be
used in other places where "dead" SMT siblings may need to be taken
online and offline again in order to get into deep idle states.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/kernel/smp.c      |   23 +++++++++++++++++++++++
 arch/x86/power/hibernate.c |   17 +++++------------
 include/linux/cpu.h        |    1 +
 3 files changed, 29 insertions(+), 12 deletions(-)

--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -299,3 +299,26 @@
 	.send_call_func_single_ipi = native_send_call_func_single_ipi,
 };
 EXPORT_SYMBOL_GPL(smp_ops);
+
+int arch_cpu_rescan_dead_smt_siblings(void)
+{
+	enum cpuhp_smt_control old = cpu_smt_control;
+	int ret;
+
+	/*
+	 * If SMT has been disabled and SMT siblings are in HLT, bring them back
+	 * online and offline them again so that they end up in MWAIT proper.
+	 *
+	 * Called with hotplug enabled.
+	 */
+	if (old != CPU_SMT_DISABLED && old != CPU_SMT_FORCE_DISABLED)
+		return 0;
+
+	ret = cpuhp_smt_enable();
+	if (ret)
+		return ret;
+
+	ret = cpuhp_smt_disable(old);
+
+	return ret;
+}
--- a/arch/x86/power/hibernate.c
+++ b/arch/x86/power/hibernate.c
@@ -188,7 +188,8 @@
 
 int arch_resume_nosmt(void)
 {
-	int ret = 0;
+	int ret;
+
 	/*
 	 * We reached this while coming out of hibernation. This means
 	 * that SMT siblings are sleeping in hlt, as mwait is not safe
@@ -202,18 +203,10 @@
 	 * Called with hotplug disabled.
 	 */
 	cpu_hotplug_enable();
-	if (cpu_smt_control == CPU_SMT_DISABLED ||
-			cpu_smt_control == CPU_SMT_FORCE_DISABLED) {
-		enum cpuhp_smt_control old = cpu_smt_control;
 
-		ret = cpuhp_smt_enable();
-		if (ret)
-			goto out;
-		ret = cpuhp_smt_disable(old);
-		if (ret)
-			goto out;
-	}
-out:
+	ret = arch_cpu_rescan_dead_smt_siblings();
+
 	cpu_hotplug_disable();
+
 	return ret;
 }
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -172,6 +172,7 @@
 void arch_tick_broadcast_enter(void);
 void arch_tick_broadcast_exit(void);
 void __noreturn arch_cpu_idle_dead(void);
+int arch_cpu_rescan_dead_smt_siblings(void);
 
 #ifdef CONFIG_ARCH_HAS_CPU_FINALIZE_INIT
 void arch_cpu_finalize_init(void);




