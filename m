Return-Path: <linux-acpi+bounces-19290-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 308C9C8AC1B
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Nov 2025 16:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 210FF4E219D
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Nov 2025 15:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5153093C6;
	Wed, 26 Nov 2025 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="mYs0k+L4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC21D33B6E0
	for <linux-acpi@vger.kernel.org>; Wed, 26 Nov 2025 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764172502; cv=none; b=R1O1fQxvluf9ecETN7SSqKiRHnMLvXKn1MF008J9ueFTTeboLWv+n1qyE4IH0myyUeDD6NajzVBJDGAOQv9QtQ3gOjO9gxZiqnlrHoIiO48doaX8j0nPGOTqiHA5MFJ0tzPLYaotQAAf/sgx8XIw3rnLQRJclR8oZY9vrhEC/hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764172502; c=relaxed/simple;
	bh=F3QVig14ZRvT1Esvj5ZqfKt0M4mvHVyclwA7KD3pHhM=;
	h=Date:Message-Id:To:Cc:Subject:From:Mime-Version:Content-Type; b=GX9KCfTwI+fAMq0JldZpHDEcq4CoSWstyf+EMHICCSNCLSofi69aXi2xaXG3UBPxtgSzxK+g0Jep8+M71tX9oBUCaLxZDP017Da0ZR2Epx6oxu56nVhiHTvfWJb92j2y5wuBfIRTdvUNylHKOVWLXaHz+cbMzhSclBL8LlgGd8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=mYs0k+L4; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version:From:Subject:Cc:To
	:Message-Id:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=W4Tu9wxxLOptPLPhrNTsZDFp0NbI9VYyurm6x/MU27w=; b=m
	Ys0k+L4r7SPxWj0Q2sDABF9Me8U3y8PxDHkb+aRxhpjV76k6ZiB3PvqYQtJO+CfsuL8sIBFnqe5Vc
	0oHkLSoW+5wcW7olh2yfLAhtbdUqLIZYe6OLAlCMrYZUhFq6lVpndrSqFfkmGMtoQdRZXXhnPtmkH
	iOt6PRbY9nXNPiz3Jc8VkobsWPfXSaTWsu+QsYWd3dCu1juokRyzJbqM+9H3yVKUHbSynzVA9jT1H
	8KdH6IrCaE84FffqQa2W5Lg7f1vBSz6H754Fkzgtq4UAChdjXn/O0OCPQPKgyiTfETWTD2Z0Pn2i2
	XODDIlv1vlH25O/tf77NmpbtJtLWm5hjQ==;
Date: Wed, 26 Nov 2025 16:55:13 +0100 (CET)
Message-Id: <20251126.165513.1373131139292726554.rene@exactco.de>
To: x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Huang Rui <ray.huang@amd.com>,
 Borislav Petkov (AMD) <bp@alien8.de>, tglx@linutronix.de,
 superm1@kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH V2] ACPI: processor_core: fix map_x2apic_id for amd-pstate
 on am4
From: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>
X-Mailer: Mew version 6.10 on Emacs 30.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On all AMD AM4 systems I have seen, e.g ASUS X470-i, Pro WS X570 Ace
and equivalent Gigabyte, amd-pstate does not initialize when the
x2apic is enabled in the BIOS. Kernel debug messages include:

[    0.315438] acpi LNXCPU:00: Failed to get CPU physical ID.
[    0.354756] ACPI CPPC: No CPC descriptor for CPU:0
[    0.714951] amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled

I tracked this down to map_x2apic_id() checking device_declaration
passed in via the type argument of acpi_get_phys_id() via
map_madt_entry() while map_lapic_id() does not.

It appears these BIOS' use Processor statements for declaring the CPUs
in the ACPI namespace instead of processor device objects (which
should have been used). CPU declarations via Processor statements were
deprecated in ACPI 6.0 that was released 10 years ago. They should not
be used any more in any contemporary platform firmware.

I tried to contact Asus support multiple times, but never received a
reply nor did any BIOS update ever change this.

Fix amd-pstate w/ x2apic on am4 by allowing this processor statements
for IDs less than 255.

Fixes: 7237d3de78ff ("x86, ACPI: add support for x2apic ACPI extensions")
Signed-off-by: René Rebe <rene@exactco.de>
---
v2: allow for IDs < 255 only and add ACPI conformance note
---
Tested in production in all x86 T2/Linux builds since 2021-09-26.
[    0.000000] DMI: ASUS System Product Name/Pro WS X570-ACE, BIOS 4702 10/20/2023
[    0.000655] x2apic: enabled by BIOS, switching to x2apic ops
[    0.003328] APIC: Switched APIC routing to: cluster x2apic
[    0.059460] IOAPIC[0]: apic_id 33, version 33, address 0xfec00000, GSI 0-23
[    0.059465] IOAPIC[1]: apic_id 34, version 33, address 0xfec01000, GSI 24-55

rene@5950x:~# grep . /sys/devices/system/cpu/cpufreq/policy0/*
/sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0
/sys/devices/system/cpu/cpufreq/policy0/amd_pstate_highest_perf:166
/sys/devices/system/cpu/cpufreq/policy0/amd_pstate_hw_prefcore:enabled
/sys/devices/system/cpu/cpufreq/policy0/amd_pstate_lowest_nonlinear_freq:1748178
/sys/devices/system/cpu/cpufreq/policy0/amd_pstate_max_freq:5276318
/sys/devices/system/cpu/cpufreq/policy0/amd_pstate_prefcore_ranking:206
/sys/devices/system/cpu/cpufreq/policy0/boost:1
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_avg_freq:1748178
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:5276318
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:572131
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:0
/sys/devices/system/cpu/cpufreq/policy0/energy_performance_available_preferences:default performance balance_performance balance_power power
/sys/devices/system/cpu/cpufreq/policy0/energy_performance_preference:balance_performance
/sys/devices/system/cpu/cpufreq/policy0/related_cpus:0
/sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:performance powersave
/sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:1748178
/sys/devices/system/cpu/cpufreq/policy0/scaling_driver:amd-pstate-epp
/sys/devices/system/cpu/cpufreq/policy0/scaling_governor:powersave
/sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:5276318
/sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:1748178
/sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported>
---
 drivers/acpi/processor_core.c | 2 +-
 1 file changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 9b6b71a2ffb5..a7fbaca91c6f 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -54,7 +54,7 @@ static int map_x2apic_id(struct acpi_subtable_header *entry,
 	if (!(apic->lapic_flags & ACPI_MADT_ENABLED))
 		return -ENODEV;
 
-	if (device_declaration && (apic->uid == acpi_id)) {
+	if (apic->uid == acpi_id && (device_declaration || acpi_id < 255)) {
 		*apic_id = apic->local_apic_id;
 		return 0;
 	}

-- 
2.46.0

-- 
René Rebe, ExactCODE GmbH, Berlin, Germany
https://exactco.de • https://t2linux.com • https://patreon.com/renerebe

