Return-Path: <linux-acpi+bounces-19262-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A44FAC8634E
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 18:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EA063351E1C
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 17:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E55329E46;
	Tue, 25 Nov 2025 17:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="CRoJOjMm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D3020DD51
	for <linux-acpi@vger.kernel.org>; Tue, 25 Nov 2025 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764091605; cv=none; b=XjZpl3lZUInIlhGdU9FwbYvozVrFhqtYEcjL0I/ohHCWq/+zSPL/CkqPAaQds6a7U3xSHLG9yZ9/L8MWwhSAxo29ppSidOJY9mRV4hpABOgcQwTlLCbC6C4D2l1alQUZefaqRA3xPR2gi7qlC/6vCbgWwIWiLimY5zSUoV/M2k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764091605; c=relaxed/simple;
	bh=9yKQn6i4c2KXko0BOBk4oKJB+hxyfzgEqSD4rsgLILE=;
	h=Date:Message-Id:To:Cc:Subject:From:Mime-Version:Content-Type; b=C+jKcnZR488dEd749Ho44yjgGtDowkUoK+KbHUsTfWosm5SQjrTZzmGwAK8p95mveE5/r9lWVSDqQ69bpePax1kEg710HDvSEyeI3dNC8fVeMHIW9BovUnvVdewyRBcTdq9VfvPjP/D9f3Dr83AEwxB1WK+v90tjQ4mhaRaDDlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=CRoJOjMm; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version:From:Subject:Cc:To
	:Message-Id:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=YpUr/+LwOBLmRjUPQxrmaD7SCAHqVJ4mMXF72YuH1GM=; b=C
	RoJOjMmi1xgmoSCJmzkCq00ZlbKGQs9xvyVNHVxRRL6BrnMCV6E/E6Xb3XCbs7e9mJ7fCpARfBD05
	/dVga6tb2VWsjN2ryCKQxcBbYllMq67NsU5A6lic1Lj1AfaymnFmcqdEyGNhdAUsMhhWCPii9shmS
	t55z+l6mchYtH//Lqk2wlTPUnDUGVnZfk60i2SvBaMZgtP0zhfcAx/7cY3qFUynX2Vc0mE1ozn6pN
	dfk3azI12rlCpGwyfMbCCH6NYDbAhViNI4kHDriItsB0ByTj5kJpwzWm4csh1ZN0bzMi78pUbfoIy
	MfVGauhJpHfyC94cjB7qTsP+Sv6UOonxg==;
Date: Tue, 25 Nov 2025 18:26:54 +0100 (CET)
Message-Id: <20251125.182654.1292605389516841541.rene@exactco.de>
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Huang Rui <ray.huang@amd.com>,
 Borislav Petkov (AMD) <bp@alien8.de>
Subject: [PATCH] ACPI: processor_core: fix map_x2apic_id for amd-pstate
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

Fix amd-pstate w/ x2apic on am4 by removing the device_declaration
check in map_x2apic_id(), likewise.

Fixes: 7237d3de78ff ("x86, ACPI: add support for x2apic ACPI extensions")
Signed-off-by: René Rebe <rene@exactco.de>
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
 drivers/acpi/processor_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 9b6b71a2ffb5..a7fbaca91c6f 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -46,7 +46,7 @@ static int map_lapic_id(struct acpi_subtable_header *entry,
 }
 
 static int map_x2apic_id(struct acpi_subtable_header *entry,
-		int device_declaration, u32 acpi_id, phys_cpuid_t *apic_id)
+		u32 acpi_id, phys_cpuid_t *apic_id)
 {
 	struct acpi_madt_local_x2apic *apic =
 		container_of(entry, struct acpi_madt_local_x2apic, header);
@@ -54,7 +54,7 @@ static int map_x2apic_id(struct acpi_subtable_header *entry,
 	if (!(apic->lapic_flags & ACPI_MADT_ENABLED))
 		return -ENODEV;
 
-	if (device_declaration && (apic->uid == acpi_id)) {
+	if (apic->uid == acpi_id) {
 		*apic_id = apic->local_apic_id;
 		return 0;
 	}
@@ -179,7 +179,7 @@ static phys_cpuid_t map_madt_entry(struct acpi_table_madt *madt,
 			if (!map_lapic_id(header, acpi_id, &phys_id))
 				break;
 		} else if (header->type == ACPI_MADT_TYPE_LOCAL_X2APIC) {
-			if (!map_x2apic_id(header, type, acpi_id, &phys_id))
+			if (!map_x2apic_id(header, acpi_id, &phys_id))
 				break;
 		} else if (header->type == ACPI_MADT_TYPE_LOCAL_SAPIC) {
 			if (!map_lsapic_id(header, type, acpi_id, &phys_id))
@@ -256,7 +256,7 @@ static phys_cpuid_t map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
 	else if (header->type == ACPI_MADT_TYPE_LOCAL_SAPIC)
 		map_lsapic_id(header, type, acpi_id, &phys_id);
 	else if (header->type == ACPI_MADT_TYPE_LOCAL_X2APIC)
-		map_x2apic_id(header, type, acpi_id, &phys_id);
+		map_x2apic_id(header, acpi_id, &phys_id);
 	else if (header->type == ACPI_MADT_TYPE_GENERIC_INTERRUPT)
 		map_gicc_mpidr(header, type, acpi_id, &phys_id);
 	else if (header->type == ACPI_MADT_TYPE_CORE_PIC)
-- 
2.46.0

-- 
René Rebe, ExactCODE GmbH, Berlin, Germany
https://exactco.de • https://t2linux.com • https://patreon.com/renerebe

