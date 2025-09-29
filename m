Return-Path: <linux-acpi+bounces-17417-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 069EEBA9B90
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 16:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 086F57A075F
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 14:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384FB302170;
	Mon, 29 Sep 2025 14:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rjmu8Pva"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1403F2D29C7
	for <linux-acpi@vger.kernel.org>; Mon, 29 Sep 2025 14:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759157751; cv=none; b=QCfCi7bTeohRze1HAPuxrrEaA+Q47p3kq2tlX20qmd22NUi94KXt3gMaO5u5zgxf9woeQmrC6g/GR6yKwb2O5w8PBBi87U0B2SlNtgipbRF+BQjRtfUDRXEwvcmWr0uYbxh0aymqwPirW5+flyBjitKbGzH5QfL1yTFgcp4Pqo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759157751; c=relaxed/simple;
	bh=ByiLIA/1BpsN+4oI1klTJ50EdnFmMrpnhMiAAQcIuEI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ll+xcJOuZ7l8U8HkSLIbwlKD5inptdMDDLIEg6Onz1rHY2zKbegNwTArjDmxL40pDBBXP1+Rllw+Lf9ge0sCL6jembf3adhYDrv6hi/y8MGfDOS/dtlbQ/rciLjlLNiNTIYIyUZvxrraDtJgCPwFMsrri6/4Ce3Fef94I4ztBFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rjmu8Pva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A0BC4CEF4
	for <linux-acpi@vger.kernel.org>; Mon, 29 Sep 2025 14:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759157750;
	bh=ByiLIA/1BpsN+4oI1klTJ50EdnFmMrpnhMiAAQcIuEI=;
	h=From:Date:Subject:To:Cc:From;
	b=Rjmu8PvaTJCb+F5zzvDLquxtSjX9vV3hwWINtn1EHzAPKgDT9GLMwTRTVY7428wAG
	 92Njk1IBNvjUOP4BMDKg3GHb5K4I9w7LRg0xI9/DCva+7YtYVp1XhyyYhEy5IPimt8
	 Nfhf9Vn86osa3Qtx9R48g5wZNr6NVAby607TnkXZWrdhLpA8HUiZKiUhR1oiCrHhAv
	 Oh/MTB1D2RM1/ZepEb0oVnLX3mi/VWM2tpqySDMOXKaY7ZNoEVXYsw4bhkRSnQhto5
	 t6OXbUuMuSTkkrE7cuVIk0UzXyVVNH1nxGFxtXCYSjYEMGWsOY3tNbdG29FyOD12jP
	 mgjDHw5bHrETw==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-64442ff55c2so376926eaf.2
        for <linux-acpi@vger.kernel.org>; Mon, 29 Sep 2025 07:55:50 -0700 (PDT)
X-Gm-Message-State: AOJu0YxGic3J6djqcr1yuDwqoBiwwfBcf82A9L1UWakKUmscvoE2vpHL
	d8Z1K+a4yyUb6+nkyfve/2fmYok9/JUm7TBgS3dkMrTnFTUQsn2TLbHeKb4nC2Z90nX2snGntpq
	2rUI0bZmWjBSvBBT5/oref297qRus+ds=
X-Google-Smtp-Source: AGHT+IFLFOvOwI0iXTVHLm3hRLSSeJftd0ftyyZTUARpJLjOX4Yq1UVFyJUd6tzh+bW6J+bbrV2dKRp7tzZS2wCfTOk=
X-Received: by 2002:a05:6870:d372:b0:358:ecec:b2 with SMTP id
 586e51a60fabf-35ebdfa1e2dmr8544763fac.7.1759157750186; Mon, 29 Sep 2025
 07:55:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 29 Sep 2025 16:55:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jcXB0jGz_50Fr5Qj=p9esKE9565Y7_+qQjer-DpnOn4Q@mail.gmail.com>
X-Gm-Features: AS18NWBjnrjPXQ0eRcc2fN3M6d4soYPx1inFnZnhRNOGREOG2bJRvV6A0mo2EUU
Message-ID: <CAJZ5v0jcXB0jGz_50Fr5Qj=p9esKE9565Y7_+qQjer-DpnOn4Q@mail.gmail.com>
Subject: [GIT PULL] ACPI support updates for v6.18-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.18-rc1

with top-most commit c87072064bd482930a021e88c11f438e780d36de

 Merge branches 'acpi-apei', 'acpi-misc' and 'pnp'

on top of commit 07e27ad16399afcd693be20211b0dfae63e0615f

 Linux 6.17-rc7

to receive ACPI updates for 6.18-rc1.

These include an ACPICA update (upstream revision 20250807 with a few
fixes on top), fixes and cleanups of the ACPI processor driver, fixes
and cleanups of the ACPI properties management code, one more ACPI IRQ
resource management quirk, one more ACPI backlight quirk, an ACPI
device enumeration quirk related to _DEP, a power resource quirk
related to WWAN modem for HP EliteBook 855 G7, ACPI SPCR table parser
extensions, an ACPI APEI EINJ driver update allowing it to handle
more address types, and several assorted cleanups of ACPI drivers and
PNP code.

Specifics:

 - Add SoundWire File Table (SWFT) signature to ACPICA (Maciej Strozek)

 - Rearrange local variable definition involving #ifdef in ACPICA to
   avoid using uninitialized variables (Zhe Qiao)

 - Allow ACPICA to skip Global Lock initialization (Huacai Chen)

 - Apply ACPI_NONSTRING in more places in ACPICA and fix two regressions
   related to incorrect ACPI_NONSTRING usage (Ahmed Salem)

 - Fix printing CDAT table header when disassembling CDAT AML (Ahmed
   Salem)

 - Use acpi_ds_clear_operands() in acpi_ds_call_control_method() in
   ACPICA (Hans de Goede)

 - Update dsmethod.c in ACPICA to address unused variable warning (Saket
   Dumbre)

 - Print error messages in ACPICA for too few or too many control method
   arguments (Saket Dumbre)

 - Update ACPICA version to 20250807 (Saket Dumbre)

 - Fix largest possible resource descriptor index in ACPICA (Dmitry
   Antipov)

 - Add Back-Invalidate restriction to CXL Window for CEDT in ACPICA
   (Davidlohr Bueso).

 - Add the package type to acceptable Arg3 types for _DSM in ACPICA
   because ACPI_TYPE_ANY does not cover it (Saket Dumbre)

 - Fix return values in ap_is_valid_checksum() in the acpidump utility
   in ACPICA (Kaushlendra Kumar)

 - Add Intel CVS ACPI HIDs to acpi_ignore_dep_ids[] so it is not
   regarded as real dependency (Hans de Goede)

 - Use ACPI_FREE() for freeing an ACPI object in description_show() in
   the ACPI sysfs-related code (Kaushlendra Kumar)

 - Fix memory leak in the ACPI processor idle driver registration error
   code path and optimize ACPI idle driver registration (Huisong Li,
   Rafael Wysocki)

 - Add module import namespace to the ACPI processor idle driver (Rafael
   Wysocki)

 - Eliminate static variable flat_state_cnt from the ACPI processor idle
   driver (Rafael Wysocki)

 - Release cpufreq policy references using __free() in the ACPI
   processor thermal driver (Zihuan Zhang)

 - Remove unused empty stubs of some functions and rearrange function
   declarations in a header file in the ACPI processor driver (Huisong
   Li)

 - Redefine two functions as void in the ACPI processor driver (Rafael
   Wysocki)

 - Stop exposing global variable acpi_idle_driver in the ACPI processor
   driver (Huisong Li)

 - Fix ACPI buffer properties extraction for data-only subnodes
   represented as _DSD-equivalent packages (Rafael Wysocki)

 - Fix handling of ACPI data-only subnodes represented as _DSD-equivalent
   packages in the case when they are embedded in larger _DSD-equivalent
   packages and clean up acpi_nondev_subnode_extract() (Rafael Wysocki)

 - Skip ACPI IRQ override on ASUS Vivobook Pro N6506CU (Sam van Kampen)

 - Add power resource init function and use it for introducing an HP
   EliteBook 855 G7 WWAN modem power resource quirk (Maciej Szmigiero)

 - Add support for DBG2 RISC-V SBI port subtype and Precise Baud Rate
   field to the ACPI SPCR table parser (Chen Pei)

 - Eliminate a dummy local variable from the ACPI thermal driver (Rafael
   Wysocki)

 - Fold two simple functions into their only caller in the ACPI fan
   driver (Rafael Wysocki)

 - Force native backlight on Lenovo 82K8 in the ACPI backlight (video)
   driver (Mario Limonciello)

 - Add missing sysfs_remove_group() for ACPI_TAD_RT (Daniel Tang)

 - Skip PRM handlers with NULL handler_address or NULL VA in the ACPI
   PRM driver (Shang song)

 - Remove redundant assignments in erst_dbg_{ioctl|write}() in the ACPI
   APEI driver (Thorsten Blum)

 - Allow the ACPI APEI EINJ to handle more types of addresses than just
   MMIO (Jiaqi Yan)

 - Use str_low_high() helper in two places in the ACPI code (Chelsy
   Ratnawat)

 - Use str_plural() to simplify the PNP code (Xichao Zhao)

 - Fix signedness issues in read/write helpers in the ACPI AML debugger
   interface (Amir Mohammad)

Thanks!


---------------

Ahmed Salem (4):
      ACPICA: Apply ACPI_NONSTRING
      ACPICA: iASL: Fix printing CDAT table header
      ACPICA: acpidump: drop ACPI_NONSTRING attribute from file_name
      ACPICA: Debugger: drop ACPI_NONSTRING attribute from name_seg

Amir Mohammad Jahangirzad (1):
      ACPI: debug: fix signedness issues in read/write helpers

Chelsy Ratnawat (1):
      ACPI: Use str_low_high() helper in two places

Chen Pei (2):
      ACPI: SPCR: Add support for DBG2 RISC-V SBI port subtype
      ACPI: SPCR: Support Precise Baud Rate field

Daniel Tang (1):
      ACPI: TAD: Add missing sysfs_remove_group() for ACPI_TAD_RT

Davidlohr Bueso (1):
      ACPICA: CEDT: Add Back-Invalidate restriction to CXL Window

Dmitry Antipov (1):
      ACPICA: Fix largest possible resource descriptor index

Hans de Goede (2):
      ACPI: scan: Add Intel CVS ACPI HIDs to acpi_ignore_dep_ids[]
      ACPICA: dispatcher: Use acpi_ds_clear_operands() in
acpi_ds_call_control_method()

Huacai Chen (1):
      ACPICA: Allow to skip Global Lock initialization

Huisong Li (6):
      ACPI: processor: idle: Fix memory leak when register cpuidle device failed
      ACPI: processor: idle: Optimize ACPI idle driver registration
      ACPI: processor: idle: Fix function defined but not used warning
      ACPI: processor: Remove unused empty stubs of some functions
      ACPI: processor: idle: Rearrange declarations in header file
      ACPI: processor: Do not expose global variable acpi_idle_driver

Jiaqi Yan (1):
      ACPI: APEI: EINJ: Allow more types of addresses except MMIO

Kaushlendra Kumar (2):
      ACPI: sysfs: Use ACPI_FREE() for freeing an ACPI object
      ACPICA: acpidump: fix return values in ap_is_valid_checksum()

Maciej S. Szmigiero (2):
      ACPI: PM: Add power resource init function
      ACPI: PM: Add HP EliteBook 855 G7 WWAN modem power resource quirk

Maciej Strozek (1):
      ACPICA: Add SoundWire File Table (SWFT) signature

Mario Limonciello (AMD) (1):
      ACPI: video: force native for Lenovo 82K8

Rafael J. Wysocki (11):
      ACPI: processor: idle: Add module import namespace
      ACPI: processor: idle: Eliminate static variable flat_state_cnt
      ACPI: thermal: Get rid of a dummy local variable
      ACPI: fan: Fold two simple functions into their only caller
      ACPI: property: Fix buffer properties extraction for subnodes
      ACPI: property: Disregard references in data-only subnode lists
      ACPI: property: Add code comments explaining what is going on
      ACPI: property: Do not pass NULL handles to acpi_attach_data()
      ACPI: property: Adjust failure handling in acpi_nondev_subnode_extract()
      ACPI: processor: Update cpuidle driver check in __acpi_processor_start()
      ACPI: processor: idle: Redefine two functions as void

Saket Dumbre (4):
      ACPICA: Update dsmethod.c to get rid of unused variable warning
      ACPICA: Print error messages for too few or too many arguments
      ACPICA: Update version to 20250807
      ACPICA: ACPI_TYPE_ANY does not include the package type

Sam van Kampen (1):
      ACPI: resource: Skip IRQ override on ASUS Vivobook Pro N6506CU

Shang song (Lenovo) (1):
      ACPI: PRM: Skip handlers with NULL handler_address or NULL VA

Thorsten Blum (1):
      ACPI: APEI: Remove redundant assignments in erst_dbg_{ioctl|write}()

Xichao Zhao (1):
      PNP: isapnp: use str_plural() to simplify the code

Zhe Qiao (3):
      ACPICA: Modify variable definition position
      ACPICA: Remove redundant "#ifdef" definitions
      ACPICA: Change the compilation conditions

Zihuan Zhang (1):
      ACPI: processor: thermal: Release policy references using __free()

---------------

 drivers/acpi/acpi_dbg.c                            |  26 ++--
 drivers/acpi/acpi_processor.c                      |   4 +-
 drivers/acpi/acpi_tad.c                            |   3 +
 drivers/acpi/acpica/acdebug.h                      |   2 +-
 drivers/acpi/acpica/aclocal.h                      |   2 +-
 drivers/acpi/acpica/acpredef.h                     |   3 +-
 drivers/acpi/acpica/dsmethod.c                     |  21 ++-
 drivers/acpi/acpica/evglock.c                      |   4 +
 drivers/acpi/acpica/psopinfo.c                     |   4 +-
 drivers/acpi/acpica/tbprint.c                      |   8 ++
 drivers/acpi/apei/einj-core.c                      |  51 +++++--
 drivers/acpi/apei/erst-dbg.c                       |   8 +-
 drivers/acpi/device_sysfs.c                        |   2 +-
 drivers/acpi/fan_core.c                            |  18 +--
 drivers/acpi/internal.h                            |   1 +
 drivers/acpi/pci_irq.c                             |   3 +-
 drivers/acpi/power.c                               |  90 +++++++++++-
 drivers/acpi/prmt.c                                |  19 ++-
 drivers/acpi/processor_driver.c                    |   6 +-
 drivers/acpi/processor_idle.c                      | 139 +++++++++++--------
 drivers/acpi/processor_thermal.c                   |  52 +++----
 drivers/acpi/property.c                            | 152 +++++++++++++--------
 drivers/acpi/resource.c                            |  10 +-
 drivers/acpi/scan.c                                |   3 +
 drivers/acpi/spcr.c                                |  13 +-
 drivers/acpi/tables.c                              |   2 +-
 drivers/acpi/thermal.c                             |   8 +-
 drivers/acpi/video_detect.c                        |   8 ++
 drivers/pnp/isapnp/core.c                          |   3 +-
 include/acpi/acexcep.h                             |  10 +-
 include/acpi/acpixf.h                              |   8 +-
 include/acpi/actbl.h                               |   2 +-
 include/acpi/actbl1.h                              |   1 +
 include/acpi/actbl2.h                              |  21 +++
 include/acpi/processor.h                           |  34 +----
 .../acpi/os_specific/service_layers/oslinuxtbl.c   |   4 +-
 tools/power/acpi/tools/acpidump/apdump.c           |   3 +-
 tools/power/acpi/tools/acpidump/apfiles.c          |   2 +-
 38 files changed, 498 insertions(+), 252 deletions(-)

