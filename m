Return-Path: <linux-acpi+bounces-8275-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA6897702A
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Sep 2024 20:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 505931C2361A
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Sep 2024 18:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA081BF7F8;
	Thu, 12 Sep 2024 18:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WN7ji8lV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B4E156F44;
	Thu, 12 Sep 2024 18:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726164787; cv=none; b=D9rByBKOesvJrm0IHwPFY91fl3fF1WA7glQ45qMHdi9k0cb9sX5EtuaOnJKEkm20wcTAmxLpEkxrYonuRSrzbtNdZn17fxiudFJpQJ50qxOH5oMEdhjfIjw34XjnDJ38uTPKu8Pc2pFqiEeZrzva90E4M8DXn5US5LTXQrcugAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726164787; c=relaxed/simple;
	bh=O3NrfUK7yVr4QWzVMb5j+HDZ2lZJzvw6XeSOOpMDagc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=QMGeV6Qkv/6scpCCJLEEqxA3ELp7aC+tzEhtdRkLHyTeQ21BN2nezVLtnKziFIfHLmMXnvoHS61/rvkQmYBEx54aJ0Sq+UKFNbjicH4/NQyhxPqj8+36G6W1PfxK8GnrJT0qgPpxzAaAeHR/QZaZebYLEiyK1N6McbSDikG8FVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WN7ji8lV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9E6C4CEC3;
	Thu, 12 Sep 2024 18:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726164787;
	bh=O3NrfUK7yVr4QWzVMb5j+HDZ2lZJzvw6XeSOOpMDagc=;
	h=From:Date:Subject:To:Cc:From;
	b=WN7ji8lVrYWZoEAAZTXC9camejtHa3eb4L88D8oY8rVkphZyzzZihl4zy9AL+5hmf
	 reReCzy6kncHFVJ3N2YUJvCNVfAca5HjP3HtpyR5o9NJiF0GbGl+gKx9ObSlkVwrF5
	 R1xMMIdBdTiV7fD4kLF7uCqRW3UoBNRJwF80mD8QHSLiwDbVyJJksxSrWLFWY0K4RJ
	 jic3h/sme/F81MyoMAOX1RSw+3PdAfMetUKYQ0rksWPm7nCS6wYwASRcw/cm9SO9Hg
	 pO1BAPv3ohuYpWGcDq80HXco/hEwioybN7Eg9gRglgZ6F7WqKQalmKXCCQbu6THvh/
	 dsTcX7RYT0V9g==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-277fdd7d509so569491fac.0;
        Thu, 12 Sep 2024 11:13:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+rCmdlPzZ6gVdCSCmfd0d+bNKSEX7PGKTcEjXMyXoNm3oN4jveT0bGUIgbnnaRtAHK3KQmYTPpsD89hQ=@vger.kernel.org, AJvYcCXjaew51sr1GdvSQR3J9gJOybghmKOpT9S1D009PheozAJK4Jbu7/qLFRdqz9AwWPBGbBl6SBYFrug=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTEgH44fII9kjsHwepAxCbZnbjo8TRoZwLzgXp1NvXTDSmJZBZ
	+ULilZoYV6QBaClgihxiNEN5dosLfpC+WziVH2aWYJYtPPwjK7X/NmxZYE2iTsG+3pirNUIGuPu
	rVPCSksNNit6ip6mdXtyoBYtx+uY=
X-Google-Smtp-Source: AGHT+IGM8yqnbV8450nrJu/SU/Vdtjfn8glFJAaiGyXQQ7SaZ6bx5hTEoe4WknbII9X5UxZWhXGhO9T4XtZIoKI+COQ=
X-Received: by 2002:a05:6870:5590:b0:278:5fb0:71d5 with SMTP id
 586e51a60fabf-27be6b766a6mr4803771fac.13.1726164786239; Thu, 12 Sep 2024
 11:13:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 12 Sep 2024 20:12:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h44icEbV3_WRxkv+q+z7hYgKqSCbJxRBddb=OahdPuzw@mail.gmail.com>
Message-ID: <CAJZ5v0h44icEbV3_WRxkv+q+z7hYgKqSCbJxRBddb=OahdPuzw@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v6.12-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The next week will be all conference travel for me and I'll be traveling in
the week after it too, so here's an early request to pull ACPI updates for
6.12-rc1.

To receive them, please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.12-rc1

with top-most commit 3dd2fcf496359d2e196acd33e53dc921d6e39cff

 Merge branches 'acpi-video', 'acpi-resource', 'acpi-pad' and 'acpi-misc'

on top of commit da3ea35007d0af457a0afc87e84fddaebc4e0b63

 Linux 6.11-rc7

These update the ACPICA code in the kernel to upstream version 20240827,
add support for ACPI-based enumeration of interrupt controllers on
RISC-V along with some related irqchip updates, clean up the ACPI device
object sysfs interface, add some quirks for backlight handling and IRQ
overrides, fix assorted issues and clean up code.

Specifics:

 - Check return value in acpi_db_convert_to_package() (Pei Xiao).

 - Detect FACS and allow setting the waking vector on reduced-hardware
   ACPI platforms (Jiaqing Zhao).

 - Allow ACPICA to represent semaphores as integers (Adrien Destugues).

 - Complete CXL 3.0 CXIMS structures support in ACPICA (Zhang Rui).

 - Make ACPICA support SPCR version 4 and add RISC-V SBI Subtype to
   DBG2 (Sia Jee Heng).

 - Implement the Dword_PCC Resource Descriptor Macro in ACPICA (Jose
   Marinho).

 - Correct the typo in struct acpi_mpam_msc_node member (Punit Agrawal).

 - Implement ACPI_WARNING_ONCE() and ACPI_ERROR_ONCE() and use them to
   prevent a Stall() violation warning from being printed every time
   this takes place (Vasily Khoruzhick).

 - Allow PCC Data Type in MCTP resource (Adam Young).

 - Fix memory leaks on acpi_ps_get_next_namepath()
   and acpi_ps_get_next_field() failures  (Armin Wolf).

 - Add support for suppressing leading zeros in hex strings when
   converting them to integers and update integer-to-hex-string
   conversions in ACPICA (Armin Wolf).

 - Add support for Windows 11 22H2 _OSI string (Armin Wolf).

 - Avoid warning for Dump Functions in ACPICA (Adam Lackorzynski).

 - Add extended linear address mode to HMAT MSCIS in ACPICA (Dave
   Jiang).

 - Handle empty connection_node in iasl (Aleksandrs Vinarskis).

 - Allow for more flexibility in _DSM args (Saket Dumbre).

 - Setup for ACPICA release 20240827 (Saket Dumbre).

 - Add ACPI device enumeration support for interrupt controller probing
   including taking dependencies into account (Sunil V L).

 - Implement ACPI-based interrupt controller probing on RISC-V (Sunil V L).

 - Add ACPI support for AIA in riscv-intc and add ACPI support to
   riscv-imsic, riscv-aplic, and sifive-plic (Sunil V L).

 - Do not release locks during operation region accesses in the ACPI EC
   driver (Rafael Wysocki).

 - Fix up the _STR handling in the ACPI device object sysfs interface,
   make it represent the device object attributes as an attribute group
   and make it rely on driver core functionality for sysfs attribute
   management (Thomas Wei=C3=9Fschuh).

 - Extend error messages printed to the kernel log when acpi_evaluate_dsm()
   fails to include revision and function number (David Wang).

 - Add a new AMDI0015 platform device ID to the ACPi APD driver for AMD
   SoCs (Shyam Sundar S K).

 - Use the driver core for the async probing management in the ACPI
   battery driver (Thomas Wei=C3=9Fschuh).

 - Remove redundant initialization of a local variable to NULL from the
   ACPI battery driver (Ilpo J=C3=A4rvinen).

 - Remove unneeded check in tps68470_pmic_opregion_probe() (Aleksandr
   Mishin).

 - Add support for setting the EPP register through the ACPI CPPC sysfs
   interface if it is in FFH (Mario Limonciello).

 - Fix MASK_VAL() usage in the ACPI CPPC library (Cl=C3=A9ment L=C3=A9ger).

 - Reduce the log level of a per-CPU message about idle states in the
   ACPI processor driver (Li RongQing).

 - Fix crash in exit_round_robin() in the ACPI processor aggregator
   device (PAD) driver (Seiji Nishikawa).

 - Add force_vendor quirk for Panasonic Toughbook CF-18 in the ACPI
   backlight driver (Hans de Goede).

 - Make the DMI checks related to backlight handling on Lenovo Yoga
   Tab 3 X90F less strict (Hans de Goede).

 - Enforce native backlight handling on Apple MacbookPro9,2 (Esther
   Shimanovich).

 - Add IRQ override quirks for Asus Vivobook Go E1404GAB and MECHREV
   GM7XG0M, and refine the TongFang GMxXGxx quirk (Li Chen, Tamim Khan,
   Werner Sembach).

 - Quirk ASUS ROG M16 to default to S3 sleep (Luke D. Jones).

 - Define and use symbols for device and class name lengths in the ACPI
   bus type code and make the code use strscpy() instead of strcpy() in
   several places (Muhammad Qasim Abdul Majeed).

Thanks!


---------------

Adam Lackorzynski (1):
      ACPICA: Avoid warning for Dump Functions

Adam Young (1):
      ACPICA: Allow PCC Data Type in MCTP resource.

Adrien Destugues (1):
      ACPICA: haiku: Fix invalid value used for semaphores

Aleksandr Mishin (1):
      ACPI: PMIC: Remove unneeded check in tps68470_pmic_opregion_probe()

Aleksandrs Vinarskis (1):
      ACPICA: iasl: handle empty connection_node

Armin Wolf (6):
      ACPICA: Fix memory leak if acpi_ps_get_next_namepath() fails
      ACPICA: Fix memory leak if acpi_ps_get_next_field() fails
      ACPICA: Allow for suppressing leading zeros when using
acpi_ex_convert_to_ascii()
      ACPICA: Add support for suppressing leading zeros in hex strings
      ACPICA: Update integer-to-hex-string conversions
      ACPICA: Add support for Windows 11 22H2 _OSI string

Cl=C3=A9ment L=C3=A9ger (1):
      ACPI: CPPC: Fix MASK_VAL() usage

Dave Jiang (1):
      ACPICA: HMAT: Add extended linear address mode to MSCIS

David Wang (1):
      ACPI: utils: Add rev/func to message when acpi_evaluate_dsm() fails

Esther Shimanovich (1):
      ACPI: video: force native for Apple MacbookPro9,2

Hans de Goede (3):
      ACPI: video: Make Lenovo Yoga Tab 3 X90F DMI match less strict
      ACPI: x86: Make Lenovo Yoga Tab 3 X90F DMI match less strict
      ACPI: video: Add force_vendor quirk for Panasonic Toughbook CF-18

Ilpo J=C3=A4rvinen (1):
      ACPI: battery: Remove redundant NULL initalizations

Jiaqing Zhao (2):
      ACPICA: Detect FACS in reduced hardware build
      ACPICA: Allow setting waking vector on reduced hardware platforms

Jose Marinho (1):
      ACPICA: Implement the Dword_PCC Resource Descriptor Macro

Li Chen (1):
      ACPI: resource: Do IRQ override on MECHREV GM7XG0M

Li RongQing (1):
      ACPI: processor: Reduce the log level of a per-CPU message about
idle states

Luke D. Jones (1):
      ACPI: PM: Quirk ASUS ROG M16 to default to S3 sleep

Mario Limonciello (1):
      ACPI: CPPC: Add support for setting EPP register in FFH

Muhammad Qasim Abdul Majeed (7):
      ACPI: battery: Use strscpy() instead of strcpy()
      ACPI: AC: Use strscpy() instead of strcpy()
      ACPI: PAD: Use strscpy() instead of strcpy()
      ACPI: acpi_processor: Use strscpy instead() of strcpy()
      ACPI: battery : Use strscpy() instead of strcpy()
      ACPI: bus: Define and use symbols for device and class name lengths
      ACPI: button: Use strscpy() instead of strcpy()

Pei Xiao (1):
      ACPICA: check null return of ACPI_ALLOCATE_ZEROED() in
acpi_db_convert_to_package()

Punit Agrawal (1):
      ACPICA: MPAM: Correct the typo in struct acpi_mpam_msc_node member

Rafael J. Wysocki (1):
      ACPI: EC: Do not release locks during operation region accesses

Saket Dumbre (2):
      ACPICA: Allow for more flexibility in _DSM args
      ACPICA: Setup for ACPICA release 20240827

Seiji Nishikawa (1):
      ACPI: PAD: fix crash in exit_round_robin()

Shyam Sundar S K (1):
      ACPI: APD: Add AMDI0015 as platform device

Sia Jee Heng (2):
      ACPICA: SPCR: Update the SPCR table to version 4
      ACPICA: Headers: Add RISC-V SBI Subtype to DBG2

Sunil V L (17):
      arm64: PCI: Migrate ACPI related functions to pci-acpi.c
      ACPI: scan: Add a weak arch_sort_irqchip_probe() to order the
IRQCHIP probe
      ACPI: bus: Add acpi_riscv_init() function
      ACPI: scan: Refactor dependency creation
      ACPI: scan: Add RISC-V interrupt controllers to honor list
      ACPI: scan: Define weak function to populate dependencies
      ACPI: bus: Add RINTC IRQ model for RISC-V
      ACPI: pci_link: Clear the dependencies after probe
      ACPI: RISC-V: Implement PCI related functionality
      ACPI: RISC-V: Implement function to reorder irqchip probe entries
      ACPI: RISC-V: Initialize GSI mapping structures
      ACPI: RISC-V: Implement function to add implicit dependencies
      irqchip/riscv-intc: Add ACPI support for AIA
      irqchip/riscv-imsic-state: Create separate function for DT
      irqchip/riscv-imsic: Add ACPI support
      irqchip/riscv-aplic: Add ACPI support
      irqchip/sifive-plic: Add ACPI support

Tamim Khan (1):
      ACPI: resource: Skip IRQ override on Asus Vivobook Go E1404GAB

Thomas Wei=C3=9Fschuh (6):
      ACPI: sysfs: validate return type of _STR method
      ACPI: sysfs: evaluate _STR on each sysfs access
      ACPI: sysfs: manage attributes as attribute_group
      ACPI: sysfs: manage sysfs attributes through device core
      ACPI: sysfs: remove return value of acpi_device_setup_files()
      ACPI: battery: use driver core managed async probing

Vasily Khoruzhick (2):
      ACPICA: Implement ACPI_WARNING_ONCE and ACPI_ERROR_ONCE
      ACPICA: executer/exsystem: Don't nag user about every Stall()
violating the spec

Werner Sembach (1):
      ACPI: resource: Add another DMI match for the TongFang GMxXGxx

Zhang Rui (1):
      ACPICA: Complete CXL 3.0 CXIMS structures

---------------

 arch/arm64/kernel/pci.c                    | 191 ----------------
 arch/riscv/Kconfig                         |   2 +
 arch/riscv/include/asm/irq.h               |  55 +++++
 arch/riscv/kernel/acpi.c                   |  31 ++-
 drivers/acpi/ac.c                          |   4 +-
 drivers/acpi/acpi_apd.c                    |   6 +
 drivers/acpi/acpi_pad.c                    |  10 +-
 drivers/acpi/acpi_processor.c              |   6 +-
 drivers/acpi/acpica/acglobal.h             |   6 +-
 drivers/acpi/acpica/aclocal.h              |   2 +
 drivers/acpi/acpica/acpredef.h             |   2 +-
 drivers/acpi/acpica/dbconvert.c            |   2 +
 drivers/acpi/acpica/exconvrt.c             |  58 ++++-
 drivers/acpi/acpica/exprep.c               |   3 +
 drivers/acpi/acpica/exsystem.c             |  11 +-
 drivers/acpi/acpica/hwxfsleep.c            |  15 +-
 drivers/acpi/acpica/psargs.c               |  47 ++++
 drivers/acpi/acpica/rsaddr.c               |   3 +-
 drivers/acpi/acpica/rsdump.c               |   2 +
 drivers/acpi/acpica/tbutils.c              |   2 -
 drivers/acpi/acpica/utdelete.c             |   4 +-
 drivers/acpi/acpica/utinit.c               |   2 +-
 drivers/acpi/acpica/utosi.c                |   1 +
 drivers/acpi/acpica/utxfinit.c             |  24 +--
 drivers/acpi/battery.c                     |  39 +---
 drivers/acpi/bus.c                         |   4 +
 drivers/acpi/button.c                      |   6 +-
 drivers/acpi/cppc_acpi.c                   |  53 ++++-
 drivers/acpi/device_sysfs.c                | 196 ++++++++---------
 drivers/acpi/ec.c                          |  55 ++++-
 drivers/acpi/internal.h                    |   3 +-
 drivers/acpi/pci_link.c                    |   2 +
 drivers/acpi/pmic/tps68470_pmic.c          |   6 +-
 drivers/acpi/resource.c                    |  19 ++
 drivers/acpi/riscv/Makefile                |   2 +-
 drivers/acpi/riscv/init.c                  |  13 ++
 drivers/acpi/riscv/init.h                  |   4 +
 drivers/acpi/riscv/irq.c                   | 335 +++++++++++++++++++++++++=
++++
 drivers/acpi/scan.c                        | 109 ++++++----
 drivers/acpi/sleep.c                       |  14 ++
 drivers/acpi/utils.c                       |   3 +-
 drivers/acpi/video_detect.c                |  17 +-
 drivers/acpi/x86/utils.c                   |   1 -
 drivers/irqchip/irq-riscv-aplic-direct.c   |  22 +-
 drivers/irqchip/irq-riscv-aplic-main.c     |  71 +++---
 drivers/irqchip/irq-riscv-aplic-main.h     |   1 +
 drivers/irqchip/irq-riscv-aplic-msi.c      |   9 +-
 drivers/irqchip/irq-riscv-imsic-early.c    |  64 +++++-
 drivers/irqchip/irq-riscv-imsic-platform.c |  32 ++-
 drivers/irqchip/irq-riscv-imsic-state.c    | 150 +++++++------
 drivers/irqchip/irq-riscv-imsic-state.h    |   2 +-
 drivers/irqchip/irq-riscv-intc.c           |  90 ++++++++
 drivers/irqchip/irq-sifive-plic.c          |  99 +++++++--
 drivers/pci/pci-acpi.c                     | 182 ++++++++++++++++
 include/acpi/acconfig.h                    |   1 -
 include/acpi/acoutput.h                    |   5 +
 include/acpi/acpi_bus.h                    |   9 +-
 include/acpi/acpixf.h                      |  10 +-
 include/acpi/actbl1.h                      |  10 +-
 include/acpi/actbl2.h                      |   2 +-
 include/acpi/actbl3.h                      |  12 +-
 include/acpi/actypes.h                     |   1 +
 include/acpi/cppc_acpi.h                   |   2 +
 include/acpi/platform/acenv.h              |   6 +
 include/linux/acpi.h                       |   9 +
 include/linux/irqchip/riscv-imsic.h        |   9 +
 66 files changed, 1561 insertions(+), 607 deletions(-)

