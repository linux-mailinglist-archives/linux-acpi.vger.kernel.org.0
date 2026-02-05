Return-Path: <linux-acpi+bounces-20871-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBlMH0zyhGkF7AMAu9opvQ
	(envelope-from <linux-acpi+bounces-20871-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Feb 2026 20:41:00 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 131C3F6E73
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Feb 2026 20:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69DB9301DBAA
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Feb 2026 19:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012BF329C7D;
	Thu,  5 Feb 2026 19:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLUN+u2T"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EF4329C6A
	for <linux-acpi@vger.kernel.org>; Thu,  5 Feb 2026 19:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770320453; cv=none; b=YVebp0BLvXyTjXoVOMD3Jt16hQ/08oCAeA5sqb3t5nQc1ussLgzfGwzbSSfbaPUzL/dR4CPAOK7ciHqytE8eXcG10vkMyxQwMXvQVtDO14RGcChiPPUnkU+5XUasPN43TGR/S4XZvK1Tmg56R1MF/68bL5kVt3aXHZTC2qNNoHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770320453; c=relaxed/simple;
	bh=YM7TaopOnlL3PjXXYXdhFLkvbclg2IStPNqvQTan2ZQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=S/MvN8uw5+5Ofmta1uQXpjCOAJFXn8om8Lo0v2jg/grqxYwIaoLkYHyHWw5u4i+JXuvQ3UPnrXYtAK+/usd0VgOgzRVTH0uV7OZNDHluiCVwq9G4JPBF3+5x6mNIEcU9bWd3eeHcoZVR4EDhlDFk1IqTFk+wab0kgEkjZ4xljlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLUN+u2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF03C19423
	for <linux-acpi@vger.kernel.org>; Thu,  5 Feb 2026 19:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770320453;
	bh=YM7TaopOnlL3PjXXYXdhFLkvbclg2IStPNqvQTan2ZQ=;
	h=From:Date:Subject:To:Cc:From;
	b=BLUN+u2TZmlwML6rKNwHLPQ7SbXXctJdkCH4x/mpcc5RxSUtakGprIEtyUEAogAqX
	 mwIDbrTQlT2G3hUtyc3rh4w5h5WSzazZUq9A0gwtgRWb8ENNRSPk53W6uK1jLQDrMI
	 JjQ/wM5h8l1Hdi3tDX2PcL+qhtfLwyBHTf40tlQBnezq6ljLPRniANdZfMKqAWd8V7
	 PZIk4ehMGHjyTuwORYV96fgPJy7C6OXRIKuv+Gxaj+/NkJOjJLTDVJA0fDLm32zu/c
	 XtUmv0gMi6k3bXGsED7PDEYSYxj/JyMaFfT+nZEhwKA0y6LLawDpHLmVwm+56z7GaQ
	 +gPP/adrN9o3A==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4042fe53946so485471fac.3
        for <linux-acpi@vger.kernel.org>; Thu, 05 Feb 2026 11:40:53 -0800 (PST)
X-Gm-Message-State: AOJu0Yza/oG+rPhBCwKB1/T95oBuc+vKY+yWFP+cEtxcRsdAz7WfgRp/
	OU3xRx2qcMhOG/ZfMG68ZQDyGq2HadEJ0K6kjxEGiQY9grtOkhULHKwbwhRPu1CVBJ7azJi0F+b
	sv6NgsCUOn3uuMmZYyKHK4Ys8coPysbU=
X-Received: by 2002:a05:6820:150b:b0:663:23a:caf3 with SMTP id
 006d021491bc7-66d09abcda8mr216860eaf.13.1770320452273; Thu, 05 Feb 2026
 11:40:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 5 Feb 2026 20:40:40 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hP_9QeMbeB=oa8+4GaO77HuhpdqEngHsd2K-sF_yQ+Ew@mail.gmail.com>
X-Gm-Features: AZwV_QjFVs3sXzVaqAas871QmZL_jMD5pnNQm8pUsgR29fj4h7fQ4t2BRyUwglg
Message-ID: <CAJZ5v0hP_9QeMbeB=oa8+4GaO77HuhpdqEngHsd2K-sF_yQ+Ew@mail.gmail.com>
Subject: [GIT PULL] ACPI support updates for v6.20-rc1/v7.0-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20871-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 131C3F6E73
X-Rspamd-Action: no action

Hi Linus,

This goes a bit early, but it's ready.

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.20-rc1

with top-most commit dfa5dc3ad3b15a519101f134ed76c068526004e4

 Merge branch 'acpi-apei'

on top of commit 63804fed149a6750ffd28610c5c1c98cce6bd377

 Linux 6.19-rc7

to receive ACPI support updates for 6.20-rc1/7.0-rc1 (whichever it
turns out to be).

This one is significantly larger than previous ACPI support pull
requests because several significant updates have coincided in it.

First, there is a routine ACPICA code update, to upstream version
20251212, but this time it covers new ACPI 6.6 material that has not
been covered yet.  Among other things, it includes definitions of a
few new ACPI tables and updates of some others, like the GICv5 MADT
structures and ARM IORT IWB node definitions that are used for adding
GICv5 ACPI probing on ARM (that technically is IRQ subsystem material,
but it depends on the ACPICA changes, so it is included here).  The
latter alone adds a few hundred lines of new code.

Second, there is an update of ACPI _OSC handling including a fix that
prevents failures from occurring in some corner cases due to careless
handling of _OSC error bits.

On top of that, the "system resource" ACPI device objects with the
PNP0C01 and PNP0C02 are now going to be handled by the ACPI core
device enumeration code instead of handing them over to the legacy
PNP system driver which causes device enumeration issues to occur.
Some of those issues have been worked around in device drivers and
elsewhere and those workarounds should not be necessary any more, so
they are going away.

Moreover, the time has come to convert all "core ACPI" device drivers
that were still using struct acpi_driver objects for device binding
into proper platform drivers that use struct platform_driver for this
purpose.  These updates are accompanied by some requisite core ACPI
device enumeration code changes.

Next, there are ACPI APEI updates, including changes to avoid excess
overhead in the NMI handler and in SEA on the ARM side, changes
to unify ACPI-based HW error tracing and logging, and changes to
prevent APEI code from reaching out of its allocated memory.

There are also some ACPI power management updates, mostly related to
the ACPI cpuidle support in the processor driver, suspend-to-idle
handling on systems with ACPI support and to ACPI PM of devices.

In addition to the above, bugs are fixed and the code is cleaned up
in assorted places all over.

Specifics:

 - Update the ACPICA code in the kernel to upstream version 20251212
   which includes the following changes:

   * Add support for new ACPI table DTPR (Michal Camacho Romero)
   * Release objects with acpi_ut_delete_object_desc() (Zilin Guan)
   * Add UUIDs for Microsoft fan extensions and UUIDs associated with
     TPM 2.0 devices (Armin Wolf)
   * Fix NULL pointer dereference in acpi_ev_address_space_dispatch()
     (Alexey Simakov)
   * Add KEYP ACPI table definition (Dave Jiang)
   * Add support for the Microsoft display mux _OSI string (Armin Wolf)
   * Add definitions for the IOVT ACPI table (Xianglai Li)
   * Abort AML bytecode execution on AML_FATAL_OP (Armin Wolf)
   * Include all fields in subtable type1 for PPTT (Ben Horgan)
   * Add GICv5 MADT structures and Arm IORT IWB node definitions (Jose
     Marinho)
   * Update Parameter Block structure for RAS2 and add a new flag in
     Memory Affinity Structure for SRAT (Pawel Chmielewski)
   * Add _VDM (Voltage Domain) object (Pawel Chmielewski)

 - Add support for GICv5 ACPI probing on ARM which is based on the
   GICv5 MADT structures and ARM IORT IWB node definitions recently
   added to ACPICA (Lorenzo Pieralisi)

 - Rework ACPI PM notification setup for PCI root buses and modify the
   ACPI PM setup for devices to register wakeup source objects under
   physical (that is, PCI, platform, etc.) devices instead of doing that
   under their ACPI companions (Rafael Wysocki)

 - Adjust debug messages regarding postponed ACPI PM printed during
   system resume to be more accurate (Rafael Wysocki)

 - Remove dead code from lps0_device_attach() (Gergo Koteles)

 - Start to invoke Microsoft Function 9 (Turn On Display) of the Low-
   Power S0 Idle (LPS0) _DSM in the suspend-to-idle resume flow on
   systems with ACPI LPS0 support to address a functional issue on
   Lenovo Yoga Slim 7i Aura (15ILL9), where system fans and keyboard
   backlights fail to resume after suspend (Jakob Riemenschneider)

 - Add sysfs attribute cid for exposing _CID lists under ACPI device
   objects (Rafael Wysocki)

 - Replace sprintf() with sysfs_emit() in all of the core ACPI sysfs
   interface code (Sumeet Pawnikar)

 - Use acpi_get_local_u64_address() in the code implementing ACPI
   support for PCI to evaluate _ADR instead of evaluating that object
   directly (Andy Shevchenko)

 - Add JWIPC JVC9100 to irq1_level_low_skip_override[] to unbreak
   serial IRQs on that system (Ai Chao)

 - Fix handling of _OSC errors in acpi_run_osc() to avoid failures on
   systems where _OSC error bits are set even though the _OSC return
   buffer contains acknowledged feature bits (Rafael Wysocki)

 - Clean up and rearrange \_SB._OSC handling for general platform
   features and USB4 features to avoid code duplication and unnecessary
   memory management overhead (Rafael Wysocki)

 - Make the ACPI core device enumeration code handle PNP0C01 and PNP0C02
   ("system resource") device objects directly instead of letting the
   legacy PNP system driver handle them to avoid device enumeration
   issues on systems where PNP0C02 is present in the _CID list under
   ACPI device objects with a _HID matching a proper device driver in
   Linux (Rafael Wysocki)

 - Drop workarounds for the known device enumeration issues related to
   _CID lists containing PNP0C02 (Rafael Wysocki)

 - Drop outdated comment regarding removed function in the ACPI-based
   device enumeration code (Julia Lawall)

 - Make PRP0001 device matching work as expected for ACPI device objects
   using it as a _HID for board development and similar purposes (Kartik
   Rajput)

 - Use async schedule function in acpi_scan_clear_dep_fn() to avoid
   races with user space initialization on some systems (Yicong Yang)

 - Add a piece of documentation explaining why binding drivers directly
   to ACPI device objects is not a good idea in general and why it is
   desirable to convert drivers doing so into proper platform drivers
   that use struct platform_driver for device binding (Rafael Wysocki)

 - Convert multiple "core ACPI" drivers, including the NFIT ACPI device
   driver, the generic ACPI button drivers, the generic ACPI thermal
   zone driver, the ACPI hardware event device (HED) driver, the ACPI EC
   driver, the ACPI SMBUS HC driver, the ACPI Smart Battery Subsystem
   (SBS) driver, and the ACPI backlight (video) driver to proper platform
   drivers that use struct platform_driver for device binding (Rafael
   Wysocki)

 - Use acpi_get_local_u64_address() in the ACPI backlight (video) driver
   to evaluate _ADR instead of evaluating that object directly (Andy
   Shevchenko)

 - Convert the generic ACPI battery driver to a proper platform driver
   using struct platform_driver for device binding (Rafael Wysocki)

 - Fix incorrect charging status when current is zero in the generic
   ACPI battery driver (Ata =C4=B0lhan K=C3=B6kt=C3=BCrk)

 - Use LIST_HEAD() for initializing a stack-allocated list in the
   generic ACPI watchdog device driver (Can Peng)

 - Rework the ACPI idle driver initialization to register it directly
   from the common initialization code instead of doing that from a
   CPU hotplug "online" callback and clean it up (Huisong Li, Rafael
   Wysocki)

 - Fix a possible NULL pointer dereference in
   acpi_processor_errata_piix4() (Tuo Li)

 - Make read-only array non_mmio_desc[] static const (Colin Ian King)

 - Prevent the APEI GHES support code on ARM from accessing memory out
   of bounds or going past the ARM processor CPER record buffer (Mauro
   Carvalho Chehab)

 - Prevent cper_print_fw_err() from dumping the entire memory on systems
   with defective firmware (Mauro Carvalho Chehab)

 - Improve ghes_notify_nmi() status check to avoid unnecessary overhead
   in the NMI handler by carrying out all of the requisite preparations
   and the NMI registration time (Tony Luck)

 - Refactor the GHES driver by extracting common functionality into
   reusable helper functions to reduce code duplication and improve
   the ghes_notify_sea() status check in analogy with the previous
   ghes_notify_nmi() status check improvement (Shuai Xue)

 - Make ELOG and GHES log and trace consistently and support the CPER
   CXL protocol analogously (Fabio De Francesco)

 - Disable KASAN instrumentation in the APEI GHES driver when compile
   testing with clang < 18 (Nathan Chancellor)

 - Let ghes_edac be the preferred driver to load on  __ZX__ and _BYO_
   systems by extending the platform detection list in the APEI GHES
   driver (Tony W Wang-oc)

 - Clean up cppc_perf_caps and cppc_perf_ctrls structs and rename EPP
   constants for clarity in the ACPI CPPC library (Sumit Gupta)

Thanks!


---------------

Ai Chao (1):
      ACPI: resource: Add JWIPC JVC9100 to irq1_level_low_skip_override[]

Alexey Simakov (1):
      ACPICA: Fix NULL pointer dereference in acpi_ev_address_space_dispatc=
h()

Andy Shevchenko (2):
      ACPI: video: simplify code with acpi_get_local_u64_address()
      ACPI: PCI: simplify code with acpi_get_local_u64_address()

Armin Wolf (5):
      ACPICA: Add UUID for Microsoft fan extensions
      ACPICA: Add UUIDs associated with TPM 2.0 devices
      ACPICA: Add support for the Microsoft display mux _OSI string
      ACPICA: Abort AML bytecode execution when executing AML_FATAL_OP
      ACPICA: Fix asltests using the Fatal() opcode

Ata =C4=B0lhan K=C3=B6kt=C3=BCrk (1):
      ACPI: battery: fix incorrect charging status when current is zero

Ben Horgan (1):
      ACPICA: ACPI 6.4: PPTT: include all fields in subtable type1

Can Peng (1):
      ACPI: acpi_watchdog: use LIST_HEAD for stack-allocated list

Colin Ian King (1):
      ACPI: APEI: EINJ: make read-only array non_mmio_desc static const

Dave Jiang (1):
      ACPICA: Add KEYP table definition

Fabio M. De Francesco (5):
      ACPI: extlog: Trace CPER Non-standard Section Body
      ACPI: extlog: Trace CPER PCI Express Error Section
      ACPI: APEI: GHES: Add helper for CPER CXL protocol errors checks
      ACPI: APEI: GHES: Add helper to copy CPER CXL protocol error
info to work struct
      ACPI: extlog: Trace CPER CXL Protocol Error Section

Gergo Koteles (1):
      ACPI: x86: s2idle: Remove dead code in lps0_device_attach()

Huisong Li (8):
      ACPI: processor: idle: Optimize ACPI idle driver registration
      ACPI: processor: Remove unused empty stubs of some functions
      ACPI: processor: idle: Rearrange declarations in header file
      ACPI: processor: Do not expose global variable acpi_idle_driver
      ACPI: processor: idle: Add debug log for states with invalid entry me=
thods
      ACPI: processor: idle: Convert
acpi_processor_setup_cpuidle_states() to void
      ACPI: processor: idle: Convert acpi_processor_setup_cpuidle_dev() to =
void
      ACPI: processor: idle: Rework the handling of
acpi_processor_ffh_lpi_probe()

Jakob Riemenschneider (1):
      ACPI: x86: s2idle: Invoke Microsoft _DSM Function 9 (Turn On Display)

Jose Marinho (2):
      ACPICA: Add GICv5 MADT structures
      ACPICA: Add Arm IORT IWB node definitions

Julia Lawall (1):
      ACPI: scan: Drop outdated comment regarding removed function

Kartik Rajput (1):
      ACPI: bus: Align acpi_device_get_match_data() with driver match order

Lorenzo Pieralisi (6):
      irqdomain: Add parent field to struct irqchip_fwid
      PCI/MSI: Make the pci_msi_map_rid_ctlr_node() interface firmware agno=
stic
      irqchip/gic-v5: Split IRS probing into OF and generic portions
      irqchip/gic-v5: Add ACPI IRS probing
      irqchip/gic-v5: Add ACPI ITS probing
      irqchip/gic-v5: Add ACPI IWB probing

Mauro Carvalho Chehab (4):
      APEI/GHES: ARM processor Error: don't go past allocated memory
      EFI/CPER: don't go past the ARM processor CPER record buffer
      APEI/GHES: ensure that won't go past CPER allocated record
      EFI/CPER: don't dump the entire memory region

Michal Camacho Romero (10):
      ACPICA: Add support for the new ACPI Table: DTPR
      ACPICA: Add DTPR table support for the ASL compiler
      ACPICA: Define DTPR structure related info tables and data template
      ACPICA: Create auxiliary ACPI_TPR_AUX_SR structure for iASL compiler
      ACPICA: Fix Segmentation Fault error related to DTPR
      ACPICA: Verify DTPR and TPR Instance buffer pointers
      ACPICA: Cleanup comments and DTPR Table handle functions
      ACPICA: Align comments in TPRn-related structures
      ACPICA: Replace TPRn Base and Limit registers
      ACPICA: Refactor for TPR Base/Limit registers bitmasks

Nathan Chancellor (1):
      ACPI: APEI: GHES: Disable KASAN instrumentation when compile
testing with clang < 18

Pawel Chmielewski (3):
      ACPICA: actbl2.h: ACPI 6.6: RAS2: Update Parameter Block structure
      ACPICA: actbl3.h: ACPI 6.6: SRAT: New flag in Memory Affinity Structu=
re
      ACPICA: ACPI 6.6: Add _VDM (Voltage Domain) object

Rafael J. Wysocki (48):
      ACPI: PNP: Drop PNP0C01 and PNP0C02 from acpi_pnp_device_ids[]
      platform/x86/intel/hid: Stop creating a platform device
      platform/x86/intel/vbtn: Stop creating a platform device
      ACPI: PNP: Drop acpi_nonpnp_device_ids[]
      ACPI: PCI: PM: Rework root bus notification setup
      ACPI: PM: Register wakeup sources under physical devices
      ACPI: bus: Fix handling of _OSC errors in acpi_run_osc()
      ACPI: bus: Rework printing debug messages on _OSC errors
      ACPI: bus: Split _OSC evaluation out of acpi_run_osc()
      ACPI: bus: Split _OSC error processing out of acpi_run_osc()
      ACPI: bus: Rename label and use ACPI_FREE() in acpi_run_osc()
      ACPI: bus: Rework the handling of \_SB._OSC platform features
      ACPI: bus: Adjust feature mask creation for \_SB._OSC
      ACPI: bus: Rework the handling of \_SB._OSC USB4 features
      ACPI: NFIT: core: Convert the driver to a platform one
      ACPI: scan: Register platform devices for fixed event buttons
      ACPI: scan: Reduce code duplication related to fixed event devices
      ACPI: button: Adjust event notification routines
      ACPI: button: Convert the driver to a platform one
      ACPI: tiny-power-button: Convert the driver to a platform one
      ACPI: scan: Do not bind ACPI drivers to fixed event buttons
      ACPI: scan: Do not mark button ACPI devices as wakeup-capable
      ACPI: scan: Register platform devices for thermal zones
      ACPI: thermal: Adjust event notification routine
      ACPI: thermal: Convert the driver to a platform one
      ACPI: thermal: Rework system suspend and resume handling
      ACPI: battery: Adjust event notification routine
      ACPI: battery: Reduce code duplication related to cleanup
      ACPI: battery: Convert the driver to a platform one
      ACPI: HED: Convert the driver to a platform one
      ACPI: EC: Register a platform device for ECDT EC
      ACPI: EC: Convert the driver to a platform one
      ACPI: SMBUS HC: Convert the driver to a platform one
      ACPI: SBS: Convert the driver to a platform one
      ACPI: sysfs: Add device cid attribute for exposing _CID lists
      ACPI: bus: Adjust acpi_osc_handshake() parameter list
      ACPI: bus: Fix typo under sizeof() in acpi_run_osc()
      ACPI: scan: Use resource_type() for resource type checking
      ACPI: processor: Update cpuidle driver check in __acpi_processor_star=
t()
      ACPI: processor: idle: Redefine two functions as void
      ACPI: scan: Register platform devices for backlight device objects
      ACPI: video: Adjust event notification routine
      ACPI: video: Convert the driver to a platform one
      ACPI: Documentation: driver-api: Disapprove of using ACPI drivers
      ACPI: PM: Let acpi_dev_pm_attach() skip devices without ACPI PM
      ACPI: scan: Use acpi_setup_gpe_for_wake() for buttons
      ACPI: scan: Clean up after recent changes
      ACPI: PM: Adjust messages regarding postponed ACPI PM

Saket Dumbre (1):
      ACPICA: Logfile: Changes for version 20251212

Shuai Xue (2):
      ACPI: APEI: GHES: Extract helper functions for error status handling
      ACPI: APEI: GHES: Improve ghes_notify_sea() status check

Sumeet Pawnikar (1):
      ACPI: sysfs: Replace sprintf() with sysfs_emit()

Sumit Gupta (2):
      ACPI: CPPC: Clean up cppc_perf_caps and cppc_perf_ctrls structs
      ACPI: CPPC: Rename EPP constants for clarity

Tony Luck (1):
      ACPI: APEI: GHES: Improve ghes_notify_nmi() status check

Tony W Wang-oc (1):
      ACPI: APEI: GHES: Add ghes_edac support for __ZX__ and _BYO_ systems

Tuo Li (1):
      ACPI: processor: Fix NULL-pointer dereference in
acpi_processor_errata_piix4()

Xianglai Li (1):
      ACPICA: iASL: Add definitions for the IOVT table

Yicong Yang (1):
      ACPI: scan: Use async schedule function in acpi_scan_clear_dep_fn()

Zilin Guan (1):
      ACPICA: ACPICA: replace ACPI_FREE() with acpi_ut_delete_object_desc()

---------------

 Documentation/driver-api/acpi/acpi-drivers.rst |  80 ++++
 Documentation/driver-api/acpi/index.rst        |   1 +
 drivers/acpi/Kconfig                           |   2 +
 drivers/acpi/acpi_extlog.c                     |  64 ++++
 drivers/acpi/acpi_platform.c                   |  40 +-
 drivers/acpi/acpi_pnp.c                        |  19 +-
 drivers/acpi/acpi_processor.c                  |  28 +-
 drivers/acpi/acpi_video.c                      |  62 ++--
 drivers/acpi/acpi_watchdog.c                   |   4 +-
 drivers/acpi/acpica/acpredef.h                 |   3 +
 drivers/acpi/acpica/evregion.c                 |   4 +-
 drivers/acpi/acpica/exoparg3.c                 |  53 ++-
 drivers/acpi/acpica/nsxfname.c                 |   2 +-
 drivers/acpi/acpica/utobject.c                 |   2 +-
 drivers/acpi/acpica/utosi.c                    |   6 +-
 drivers/acpi/apei/Makefile                     |   5 +
 drivers/acpi/apei/einj-core.c                  |   2 +-
 drivers/acpi/apei/ghes.c                       | 187 +++++++---
 drivers/acpi/apei/ghes_helpers.c               |  66 ++++
 drivers/acpi/arm64/iort.c                      | 193 ++++++++--
 drivers/acpi/battery.c                         |  80 ++--
 drivers/acpi/bus.c                             | 481 ++++++++++++++-------=
----
 drivers/acpi/button.c                          | 128 +++----
 drivers/acpi/cppc_acpi.c                       |   2 +-
 drivers/acpi/device_pm.c                       |  16 +-
 drivers/acpi/device_sysfs.c                    |  51 ++-
 drivers/acpi/ec.c                              |  54 +--
 drivers/acpi/hed.c                             |  23 +-
 drivers/acpi/nfit/core.c                       |  47 ++-
 drivers/acpi/pci_root.c                        |   2 +-
 drivers/acpi/pci_slot.c                        |  10 +-
 drivers/acpi/processor_driver.c                |  13 +-
 drivers/acpi/processor_idle.c                  | 158 ++++----
 drivers/acpi/resource.c                        |   8 +
 drivers/acpi/sbs.c                             |  48 ++-
 drivers/acpi/sbshc.c                           |  43 +--
 drivers/acpi/scan.c                            | 224 ++++++++----
 drivers/acpi/sysfs.c                           |  30 +-
 drivers/acpi/thermal.c                         |  90 ++---
 drivers/acpi/tiny-power-button.c               |  25 +-
 drivers/acpi/x86/s2idle.c                      |   9 +-
 drivers/cxl/core/ras.c                         |   3 +-
 drivers/firmware/efi/cper-arm.c                |  12 +-
 drivers/firmware/efi/cper.c                    |   8 +-
 drivers/irqchip/irq-gic-its-msi-parent.c       |  43 +--
 drivers/irqchip/irq-gic-v5-irs.c               | 227 +++++++++---
 drivers/irqchip/irq-gic-v5-its.c               | 132 ++++++-
 drivers/irqchip/irq-gic-v5-iwb.c               |  42 ++-
 drivers/irqchip/irq-gic-v5.c                   | 138 ++++++-
 drivers/pci/msi/irqdomain.c                    |  23 +-
 drivers/pci/pci-acpi.c                         |  15 +-
 drivers/pci/pcie/aer.c                         |   2 +-
 drivers/platform/x86/intel/hid.c               |  41 +--
 drivers/platform/x86/intel/vbtn.c              |  30 +-
 drivers/ras/ras.c                              |   6 +-
 include/acpi/acpixf.h                          |   2 +-
 include/acpi/actbl1.h                          | 257 +++++++++++++
 include/acpi/actbl2.h                          | 194 +++++++++-
 include/acpi/actbl3.h                          |   1 +
 include/acpi/acuuid.h                          |   6 +
 include/acpi/cppc_acpi.h                       |   6 +-
 include/acpi/ghes.h                            |   2 +
 include/acpi/processor.h                       |  34 +-
 include/cxl/event.h                            |  22 ++
 include/linux/acpi.h                           |   1 +
 include/linux/acpi_iort.h                      |  11 +-
 include/linux/cper.h                           |   3 +-
 include/linux/irqchip/arm-gic-v5.h             |   8 +
 include/linux/irqdomain.h                      |  30 +-
 include/linux/msi.h                            |   3 +-
 include/linux/pci-acpi.h                       |   3 +-
 kernel/irq/irqdomain.c                         |  14 +-
 72 files changed, 2573 insertions(+), 1111 deletions(-)

