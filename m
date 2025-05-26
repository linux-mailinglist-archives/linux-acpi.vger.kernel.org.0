Return-Path: <linux-acpi+bounces-13903-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C57CBAC4440
	for <lists+linux-acpi@lfdr.de>; Mon, 26 May 2025 22:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B2FA18972A1
	for <lists+linux-acpi@lfdr.de>; Mon, 26 May 2025 20:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F4F1F8F09;
	Mon, 26 May 2025 20:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxYSGrkm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E9E4A2D;
	Mon, 26 May 2025 20:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748290143; cv=none; b=j3KBsAuTM6CHMpEZ2/xZ3ftcopJcdJnth6XApJtljTtPJANd03bX9Pw2VGJrRjetXMqHZpRXemdVSiwyNM+9w/6ItRK4BUwEGjyCFoz+OIj2va6qtgy3pCCNTI2kWxihwcQRsv3l2Xby+xzOg0E/39bDNYG9qt95Ww6hdwMmGGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748290143; c=relaxed/simple;
	bh=07cMwox6bxOTATDJ076/Zcq6C8++GPnk8Gr/y4/GKAI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NWItyqCByvfZqFoGm3cxndM4/BqI67Xwd/Y8KopIrjap/yhInAvVo1L6zl/kx9W0ciElEk2rjbvZrRFafvV3ZBv8uKbjr6TClRouDipDQ+ZlN1kOs5x/8m5TJ/IuzTYgdeM84VEQXQyW7iB7kRrIPWaK97bYzWrpjHqs5dRXnds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxYSGrkm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D950C4CEE7;
	Mon, 26 May 2025 20:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748290142;
	bh=07cMwox6bxOTATDJ076/Zcq6C8++GPnk8Gr/y4/GKAI=;
	h=From:Date:Subject:To:Cc:From;
	b=cxYSGrkmOPtV2mIY6NA3RQjiM7t2rOgol85Es0E8sabmfB+loTVgygL+/46qyoryb
	 luGHLVG0GNMjG75mJwhw6KffHuavpHLTG9MuSt1vVOeP4UAp7y6vzXsZwcfVDam9Ss
	 Lgm3RISlz+6m41R2ndjy+5KxiSZD1750uSVoC3lXzKXA8UxIUARLVaJTCdhc1053Qt
	 iJNKBMxQqJgNjQJaXNqe/Jst2wEB9ZMbQKML3P9lkzbVVHNuSxRycwGIxes6nJzkTK
	 X3gS83axRfVySX8ViNBLHCgULoYdwiEdbHN8+Diu1d1nZLebbdnhlscDWCEQfQ9c5V
	 36OoIrRiEINqw==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3feb3f54339so2322730b6e.1;
        Mon, 26 May 2025 13:09:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXbqPB6/ZYKOd0675f5oNjy+lyxoQytkvYMSgppBIEOz4FaAo9yTxWSLIm85XAslEgFgzKrERm8LYT3XI8=@vger.kernel.org, AJvYcCXx8Jve8Lt21AIahyoUiUFSaGKTV6EK1yesRRU7SEig96TLCaMu7ZXBxssVkE8UTqX6sY6fxF2rr4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYRBTc4OtdmZhLvpQYz5m9EEuh12a0M5JiJ//Nd10nR6dmzrEW
	KhF9WuY10LETr9UmYl5PtosYT2oiQv3S5LkIqMfxr5IT7E1W8t0O9rU9e016aCofhZ3yEoy+e0C
	Zbn+Hw2rupaCg4WQdor62PXnJAtqojCo=
X-Google-Smtp-Source: AGHT+IG/e9a79GLiwzaHb40Vc+h/OcmR4uIyYDI7z/G+lyWNDuksINuJrS9UFtkme8QU6ghrCJ+eXZsb/6DH7ljbFzU=
X-Received: by 2002:a05:6808:4441:b0:404:e2fe:eea4 with SMTP id
 5614622812f47-406467b03cfmr7300637b6e.8.1748290141624; Mon, 26 May 2025
 13:09:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 26 May 2025 22:08:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jgQeZnOaAT-00xfM-_4QDfH=RhKJWDPM9NMoMNfWpr_Q@mail.gmail.com>
X-Gm-Features: AX0GCFsI0RuqRQfVwMZM_Scpsym0YxF8T4ZrWAaPceiLbHJEwKNgAXzqMZ2sCl4
Message-ID: <CAJZ5v0jgQeZnOaAT-00xfM-_4QDfH=RhKJWDPM9NMoMNfWpr_Q@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v6.16-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.16-rc1

with top-most commit db0e4d5429c909db9c252be59bd872ab628c78c6

 Merge branches 'acpi-resource', 'acpi-pm', 'acpi-platform-profile'
and 'acpi-docs'

on top of commit a5806cd506af5a7c19bcd596e4708b5c464bfd21

 Linux 6.15-rc7

to receive ACPI updates for 6.16-rc1.

The most significant part of these changes is an ACPICA update covering
two upstream ACPICA releases, 20241212 and 20250404, that have not been
included into the kernel code base yet.  Among other things, it adds
definitions needed to address GCC 15's -Wunterminated-string-initialization
warnings, adds support for three new tables (MRRM, ERDT, RIMT), extends
support for two tables (RAS2, DMAR), and fixes some issues.

On top of the above, there is a new parser for the MRRM table, more
changes related to GCC 15's -Wunterminated-string-initialization
warnings, a CPPC library update including functions related to
autonomous CPU performance state selection, a couple of new quirks,
some assorted fixes and some code cleanups.

Specifics:

 - Fix two ACPICA SLAB cache leaks (Seunghun Han).

 - Add EINJv2 get error type action and define Error Injection Actions
   in hex values to avoid inconsistencies between the specification and
   the code (Zaid Alali).

 - Fix typo in comments for SRAT structures (Adam Lackorzynski).

 - Prevent possible loss of data in ACPICA because of u32 to u8
   conversions (Saket Dumbre).

 - Fix reading FFixedHW operation regions in ACPICA (Daniil Tatianin).

 - Add support for printing AML arguments when the ACPICA debug level is
   ACPI_LV_TRACE_POINT (Mario Limonciello).

 - Drop a stale comment about the file content from actbl2.h (Sudeep
   Holla).

 - Apply pack(1) to union aml_resource (Tamir Duberstein).

 - Fix overflow check in the ACPICA version of vsnprintf() (gldrk).

 - Interpret SIDP structures in DMAR added revision 3.4 of the VT-d
   specification (Alexey Neyman).

 - Add typedef and other definitions related to MRRM to ACPICA (Tony
   Luck).

 - Add definitions for RIMT to ACPICA (Sunil V L).

 - Fix spelling mistake "Incremement" -> "Increment" in the ACPICA
   utilities code (Colin Ian King).

 - Add typedef and other definitions for ERDT to ACPICA (Tony Luck).

 - Introduce ACPI_NONSTRING and use it (Kees Cook, Ahmed Salem).

 - Rename structure and field names of the RAS2 table in actbl2.h (Shiju
   Jose).

 - Fix up whitespace in acpica/utcache.c (Zhe Qiao).

 - Avoid sequence overread in a call to strncmp() in ap_get_table_length()
   and replace strncpy() with memcpy() in ACPICA in some places (Ahmed
   Salem).

 - Update copyright year in all ACPICA files (Saket Dumbre).

 - Add __nonstring annotations for unterminated strings in the static
   ACPI tables parsing code (Kees Cook).

 - Add support for parsing the MRRM ACPI table and sysfs files to
   describe memory regions listed in it (Tony Luck, Anil Keshavamurthy).

 - Remove an (explicitly) unused header file include from the VIOT ACPI
   table parser file (Andy Shevchenko).

 - Improve logging around acpi_initialize_tables() (Bartosz Szczepanek).

 - Clean up the initialization of CPU data structures in the ACPI
   processor driver (Zhang Rui).

 - Remove an obsolete comment regarding the C-states handling in the
   ACPI processor driver (Giovanni Gherdovich).

 - Simplify PCC shared memory region handling (Sudeep Holla).

 - Rework and extend functions for reading CPPC register values and for
   updating CPPC registers (Lifeng Zheng).

 - Add three functions related to autonomous CPU performance state
   selection to the CPPC library (Lifeng Zheng).

 - Turn the acpi_pci_root_remap_iospace() fwnode_handle parameter into a
   const pointer (Pei Xiao).

 - Round battery capacity percengate in the ACPI battery driver to the
   closest integer to avoid user confusion (shitao).

 - Make the ACPI battery driver report the current as a negative number
   to the power supply framework when the battery is discharging as
   documented (Peter Marheine).

 - Add TUXEDO InfinityBook Pro AMD Gen9 to the acpi_ec_no_wakeup[] list
   to prevent spurious wakeups from suspend-to-idle (Werner Sembach).

 - Convert the APEI EINJ driver to a faux device one (Sudeep Holla, Jon
   Hunter).

 - Remove redundant calls to einj_get_available_error_type() from the
   APEI EINJ driver (Zaid Alali).

 - Fix a typo for MECHREVO in irq1_edge_low_force_override[] (Mingcong
   Bai).

 - Add an LPS0 check() callback to the AMD pinctrl driver and fix up
   config symbol dependencies in it (Mario Limonciello, Rafael Wysocki).

 - Avoid initializing the ACPI platform profile driver on non-ACPI
   platforms (Alexandre Ghiti).

 - Document that references to ACPI data (non-device) nodes should use
   string-only references in hierarchical data node packages (Sakari
   Ailus).

 - Fail the ACPI bus registration if acpi_kobj registration fails (Armin
   Wolf).

Thanks!


---------------

Adam Lackorzynski (1):
      ACPICA: Fix typo in comments for SRAT structures

Ahmed Salem (3):
      ACPICA: Avoid sequence overread in call to strncmp()
      ACPICA: Apply ACPI_NONSTRING in more places
      ACPICA: Replace strncpy() with memcpy()

Alexandre Ghiti (1):
      ACPI: platform_profile: Avoid initializing on non-ACPI platforms

Alexey Neyman (1):
      ACPICA: Interpret SIDP structures in DMAR

Andy Shevchenko (1):
      ACPI: VIOT: Remove (explicitly) unused header

Anil S Keshavamurthy (1):
      ACPI: MRRM: Fix default max memory region

Armin Wolf (1):
      ACPI: bus: Bail out if acpi_kobj registration fails

Bartosz Szczepanek (1):
      ACPI: tables: Improve logging around acpi_initialize_tables()

Colin Ian King (1):
      ACPICA: Utilities: Fix spelling mistake "Incremement" -> "Increment"

Daniil Tatianin (1):
      ACPICA: exserial: don't forget to handle FFixedHW opregions for reading

Giovanni Gherdovich (1):
      ACPI: processor: idle: Remove obsolete comment

Jon Hunter (1):
      ACPI: APEI: EINJ: Fix probe error message

Kees Cook (3):
      ACPI: tables: Add __nonstring annotations for unterminated strings
      ACPICA: Introduce ACPI_NONSTRING
      ACPICA: Apply ACPI_NONSTRING

Lifeng Zheng (8):
      ACPI: CPPC: Add IS_OPTIONAL_CPC_REG macro to judge if a cpc_reg
is optional
      ACPI: CPPC: Optimize cppc_get_perf()
      ACPI: CPPC: Rename cppc_get_perf() to cppc_get_reg_val()
      ACPI: CPPC: Extract cppc_get_reg_val_in_pcc()
      ACPI: CPPC: Add cppc_set_reg_val()
      ACPI: CPPC: Refactor register value get and set ABIs
      ACPI: CPPC: Modify cppc_get_auto_sel_caps() to cppc_get_auto_sel()
      ACPI: CPPC: Add three functions related to autonomous selection

Mario Limonciello (4):
      ACPI: Add missing prototype for non CONFIG_SUSPEND/CONFIG_X86 case
      pinctrl: amd: Add an LPS0 check() callback
      ACPICA: Add support for printing AML arguments when trace point enabled
      pinctrl: amd: Fix use of undeclared identifier
'pinctrl_amd_s2idle_dev_ops'

Mingcong Bai (1):
      ACPI: resource: fix a typo for MECHREVO in irq1_edge_low_force_override[]

Pei Xiao (1):
      ACPI: PCI: Constify fwnode_handle in acpi_pci_root_remap_iospace()

Peter Marheine (1):
      ACPI: battery: negate current when discharging

Rafael J. Wysocki (1):
      pinctrl: amd: Fix hibernation support with CONFIG_SUSPEND unset

Sakari Ailus (1):
      Documentation: ACPI: Use all-string data node references

Saket Dumbre (5):
      ACPICA: New release 20240927
      ACPICA: Fix warnings from PR #295 merge
      ACPICA: Logfile: Changes for version 20241212
      ACPICA: Logfile: Changes for version 20250404
      ACPICA: Update copyright year

Seunghun Han (2):
      ACPICA: fix acpi operand cache leak in dswstate.c
      ACPICA: fix acpi parse and parseext cache leaks

Shiju Jose (1):
      ACPICA: actbl2.h: ACPI 6.5: RAS2: Rename structure and field
names of the RAS2 table

Sudeep Holla (4):
      ACPI: APEI: EINJ: Transition to the faux device interface
      ACPICA: Drop stale comment about the header file content
      ACPI: PCC: Simplify PCC shared memory region handling
      ACPI: CPPC: Simplify PCC shared memory region handling

Sunil V L (1):
      ACPICA: actbl2: Add definitions for RIMT

Tamir Duberstein (1):
      ACPICA: Apply pack(1) to union aml_resource

Tony Luck (8):
      ACPICA: infrastructure: Add new header and ACPI_DMT_BUF26 types
      ACPICA: actbl2.h: MRRM: Add typedef and other definitions
      ACPICA: MRRM: Some cleanups
      ACPICA: infrastructure: Add new DMT_BUF types and shorten a long name
      ACPICA: actbl2.h: ERDT: Add typedef and other definitions
      ACPI: MRRM: Minimal parse of ACPI MRRM table
      ACPI: MRRM: Add /sys files to describe memory ranges
      ACPI: Add documentation for exposing MRRM data

Werner Sembach (1):
      ACPI: EC: Add device to acpi_ec_no_wakeup[] quirk list

Zaid Alali (3):
      ACPICA: actbl1: Update values to hex to follow ACPI specs
      ACPICA: actbl1: Add EINJv2 get error type action
      ACPI: APEI: EINJ: Remove redundant calls to
einj_get_available_error_type()

Zhang Rui (2):
      ACPI: processor: idle: Set pr->flags.power unconditionally
      ACPI: processor: idle: Remove redundant pr->power.count assignment

Zhe Qiao (1):
      ACPICA: Adjust the position of code lines

gldrk (1):
      ACPICA: utilities: Fix overflow check in vsnprintf()

shitao (1):
      ACPI: battery: Round capacity percengate to closest integer

---------------

 Documentation/ABI/testing/sysfs-firmware-acpi      |  21 ++
 .../acpi/dsd/data-node-references.rst              |  26 +-
 Documentation/firmware-guide/acpi/dsd/graph.rst    |  11 +-
 Documentation/firmware-guide/acpi/dsd/leds.rst     |   7 +-
 arch/x86/Kconfig                                   |   1 +
 drivers/acpi/Kconfig                               |   3 +
 drivers/acpi/Makefile                              |   1 +
 drivers/acpi/acpi_mrrm.c                           | 183 +++++++++++
 drivers/acpi/acpi_pcc.c                            |  13 +-
 drivers/acpi/acpica/acapps.h                       |   4 +-
 drivers/acpi/acpica/accommon.h                     |   2 +-
 drivers/acpi/acpica/acconvert.h                    |   2 +-
 drivers/acpi/acpica/acdebug.h                      |   4 +-
 drivers/acpi/acpica/acdispat.h                     |   2 +-
 drivers/acpi/acpica/acevents.h                     |   2 +-
 drivers/acpi/acpica/acglobal.h                     |   2 +-
 drivers/acpi/acpica/achware.h                      |   2 +-
 drivers/acpi/acpica/acinterp.h                     |   5 +-
 drivers/acpi/acpica/aclocal.h                      |   6 +-
 drivers/acpi/acpica/acmacros.h                     |   2 +-
 drivers/acpi/acpica/acnamesp.h                     |   2 +-
 drivers/acpi/acpica/acobject.h                     |   2 +-
 drivers/acpi/acpica/acopcode.h                     |   2 +-
 drivers/acpi/acpica/acparser.h                     |   2 +-
 drivers/acpi/acpica/acpredef.h                     |   2 +-
 drivers/acpi/acpica/acresrc.h                      |   2 +-
 drivers/acpi/acpica/acstruct.h                     |   2 +-
 drivers/acpi/acpica/actables.h                     |   2 +-
 drivers/acpi/acpica/acutils.h                      |   2 +-
 drivers/acpi/acpica/amlcode.h                      |   2 +-
 drivers/acpi/acpica/amlresrc.h                     |  10 +-
 drivers/acpi/acpica/dbhistry.c                     |   2 +-
 drivers/acpi/acpica/dsargs.c                       |   2 +-
 drivers/acpi/acpica/dscontrol.c                    |   2 +-
 drivers/acpi/acpica/dsdebug.c                      |   2 +-
 drivers/acpi/acpica/dsfield.c                      |   2 +-
 drivers/acpi/acpica/dsinit.c                       |   2 +-
 drivers/acpi/acpica/dsmethod.c                     |   2 +-
 drivers/acpi/acpica/dsmthdat.c                     |   1 +
 drivers/acpi/acpica/dsobject.c                     |   2 +-
 drivers/acpi/acpica/dsopcode.c                     |   2 +-
 drivers/acpi/acpica/dspkginit.c                    |   2 +-
 drivers/acpi/acpica/dsutils.c                      |   9 +-
 drivers/acpi/acpica/dswexec.c                      |   2 +-
 drivers/acpi/acpica/dswload.c                      |   2 +-
 drivers/acpi/acpica/dswload2.c                     |   2 +-
 drivers/acpi/acpica/dswscope.c                     |   2 +-
 drivers/acpi/acpica/dswstate.c                     |   2 +-
 drivers/acpi/acpica/evevent.c                      |   2 +-
 drivers/acpi/acpica/evglock.c                      |   2 +-
 drivers/acpi/acpica/evgpe.c                        |   2 +-
 drivers/acpi/acpica/evgpeblk.c                     |   2 +-
 drivers/acpi/acpica/evgpeinit.c                    |   2 +-
 drivers/acpi/acpica/evgpeutil.c                    |   2 +-
 drivers/acpi/acpica/evhandler.c                    |   2 +-
 drivers/acpi/acpica/evmisc.c                       |   2 +-
 drivers/acpi/acpica/evregion.c                     |   2 +-
 drivers/acpi/acpica/evrgnini.c                     |   2 +-
 drivers/acpi/acpica/evxface.c                      |   2 +-
 drivers/acpi/acpica/evxfevnt.c                     |   2 +-
 drivers/acpi/acpica/evxfgpe.c                      |   2 +-
 drivers/acpi/acpica/evxfregn.c                     |   2 +-
 drivers/acpi/acpica/exconcat.c                     |   2 +-
 drivers/acpi/acpica/exconfig.c                     |   2 +-
 drivers/acpi/acpica/exconvrt.c                     |   6 +-
 drivers/acpi/acpica/excreate.c                     |   2 +-
 drivers/acpi/acpica/exdebug.c                      |   2 +-
 drivers/acpi/acpica/exdump.c                       |   2 +-
 drivers/acpi/acpica/exfield.c                      |   2 +-
 drivers/acpi/acpica/exfldio.c                      |   2 +-
 drivers/acpi/acpica/exmisc.c                       |   2 +-
 drivers/acpi/acpica/exmutex.c                      |   2 +-
 drivers/acpi/acpica/exnames.c                      |   2 +-
 drivers/acpi/acpica/exoparg1.c                     |   2 +-
 drivers/acpi/acpica/exoparg2.c                     |   2 +-
 drivers/acpi/acpica/exoparg3.c                     |   2 +-
 drivers/acpi/acpica/exoparg6.c                     |   2 +-
 drivers/acpi/acpica/exprep.c                       |   2 +-
 drivers/acpi/acpica/exregion.c                     |   2 +-
 drivers/acpi/acpica/exresnte.c                     |   2 +-
 drivers/acpi/acpica/exresolv.c                     |   2 +-
 drivers/acpi/acpica/exresop.c                      |   2 +-
 drivers/acpi/acpica/exserial.c                     |   8 +-
 drivers/acpi/acpica/exstore.c                      |   2 +-
 drivers/acpi/acpica/exstoren.c                     |   2 +-
 drivers/acpi/acpica/exstorob.c                     |   2 +-
 drivers/acpi/acpica/exsystem.c                     |   2 +-
 drivers/acpi/acpica/extrace.c                      |  53 +++-
 drivers/acpi/acpica/exutils.c                      |   2 +-
 drivers/acpi/acpica/hwacpi.c                       |   2 +-
 drivers/acpi/acpica/hwesleep.c                     |   2 +-
 drivers/acpi/acpica/hwgpe.c                        |   2 +-
 drivers/acpi/acpica/hwsleep.c                      |   2 +-
 drivers/acpi/acpica/hwtimer.c                      |   2 +-
 drivers/acpi/acpica/hwvalid.c                      |   2 +-
 drivers/acpi/acpica/hwxface.c                      |   2 +-
 drivers/acpi/acpica/hwxfsleep.c                    |   2 +-
 drivers/acpi/acpica/nsarguments.c                  |   2 +-
 drivers/acpi/acpica/nsconvert.c                    |   2 +-
 drivers/acpi/acpica/nsdump.c                       |   2 +-
 drivers/acpi/acpica/nsdumpdv.c                     |   2 +-
 drivers/acpi/acpica/nsinit.c                       |   2 +-
 drivers/acpi/acpica/nsload.c                       |   2 +-
 drivers/acpi/acpica/nsnames.c                      |   2 +-
 drivers/acpi/acpica/nsparse.c                      |   2 +-
 drivers/acpi/acpica/nspredef.c                     |   2 +-
 drivers/acpi/acpica/nsprepkg.c                     |   2 +-
 drivers/acpi/acpica/nsrepair.c                     |   2 +-
 drivers/acpi/acpica/nsrepair2.c                    |   4 +-
 drivers/acpi/acpica/nsutils.c                      |   2 +-
 drivers/acpi/acpica/nswalk.c                       |   2 +-
 drivers/acpi/acpica/nsxfname.c                     |   2 +-
 drivers/acpi/acpica/psargs.c                       |   2 +-
 drivers/acpi/acpica/psloop.c                       |   2 +-
 drivers/acpi/acpica/psobject.c                     |  54 +---
 drivers/acpi/acpica/psopcode.c                     |   2 +-
 drivers/acpi/acpica/psopinfo.c                     |   2 +-
 drivers/acpi/acpica/psparse.c                      |   2 +-
 drivers/acpi/acpica/psscope.c                      |   2 +-
 drivers/acpi/acpica/pstree.c                       |   2 +-
 drivers/acpi/acpica/psutils.c                      |   2 +-
 drivers/acpi/acpica/pswalk.c                       |   2 +-
 drivers/acpi/acpica/psxface.c                      |   2 +-
 drivers/acpi/acpica/rsaddr.c                       |  13 +-
 drivers/acpi/acpica/rscalc.c                       |  22 +-
 drivers/acpi/acpica/rslist.c                       |  12 +-
 drivers/acpi/acpica/tbdata.c                       |   2 +-
 drivers/acpi/acpica/tbfadt.c                       |   2 +-
 drivers/acpi/acpica/tbfind.c                       |   6 +-
 drivers/acpi/acpica/tbinstal.c                     |   2 +-
 drivers/acpi/acpica/tbprint.c                      |   2 +-
 drivers/acpi/acpica/tbutils.c                      |   2 +-
 drivers/acpi/acpica/tbxface.c                      |   2 +-
 drivers/acpi/acpica/tbxfload.c                     |   2 +-
 drivers/acpi/acpica/tbxfroot.c                     |   2 +-
 drivers/acpi/acpica/utaddress.c                    |   2 +-
 drivers/acpi/acpica/utalloc.c                      |   2 +-
 drivers/acpi/acpica/utascii.c                      |   2 +-
 drivers/acpi/acpica/utbuffer.c                     |   2 +-
 drivers/acpi/acpica/utcache.c                      |   4 +-
 drivers/acpi/acpica/utcksum.c                      |   2 +-
 drivers/acpi/acpica/utcopy.c                       |   2 +-
 drivers/acpi/acpica/utdebug.c                      |   2 +-
 drivers/acpi/acpica/utdecode.c                     |   2 +-
 drivers/acpi/acpica/utdelete.c                     |   2 +-
 drivers/acpi/acpica/uteval.c                       |   2 +-
 drivers/acpi/acpica/utglobal.c                     |   2 +-
 drivers/acpi/acpica/uthex.c                        |   2 +-
 drivers/acpi/acpica/utids.c                        |   2 +-
 drivers/acpi/acpica/utinit.c                       |   2 +-
 drivers/acpi/acpica/utlock.c                       |   2 +-
 drivers/acpi/acpica/utnonansi.c                    |   2 +-
 drivers/acpi/acpica/utobject.c                     |   2 +-
 drivers/acpi/acpica/utosi.c                        |   2 +-
 drivers/acpi/acpica/utpredef.c                     |   2 +-
 drivers/acpi/acpica/utprint.c                      |   9 +-
 drivers/acpi/acpica/utresrc.c                      |  14 +-
 drivers/acpi/acpica/uttrack.c                      |   2 +-
 drivers/acpi/acpica/utuuid.c                       |   2 +-
 drivers/acpi/acpica/utxface.c                      |   2 +-
 drivers/acpi/acpica/utxfinit.c                     |   2 +-
 drivers/acpi/apei/einj-core.c                      |  62 ++--
 drivers/acpi/battery.c                             |  23 +-
 drivers/acpi/bus.c                                 |   6 +-
 drivers/acpi/cppc_acpi.c                           | 329 +++++++++++---------
 drivers/acpi/ec.c                                  |   6 +
 drivers/acpi/pci_root.c                            |   2 +-
 drivers/acpi/platform_profile.c                    |   3 +
 drivers/acpi/processor_idle.c                      |  14 +-
 drivers/acpi/resource.c                            |   2 +-
 drivers/acpi/tables.c                              |   8 +-
 drivers/acpi/viot.c                                |   2 +-
 drivers/cpufreq/amd-pstate.c                       |   3 +-
 drivers/pinctrl/pinctrl-amd.c                      |  49 ++-
 include/acpi/acbuffer.h                            |   2 +-
 include/acpi/acconfig.h                            |   2 +-
 include/acpi/acexcep.h                             |   2 +-
 include/acpi/acnames.h                             |   2 +-
 include/acpi/acoutput.h                            |   2 +-
 include/acpi/acpi.h                                |   2 +-
 include/acpi/acpiosxf.h                            |   2 +-
 include/acpi/acpixf.h                              |   4 +-
 include/acpi/acrestyp.h                            |   2 +-
 include/acpi/actbl.h                               |   8 +-
 include/acpi/actbl1.h                              |  47 ++-
 include/acpi/actbl2.h                              | 335 ++++++++++++++++++++-
 include/acpi/actbl3.h                              |   4 +-
 include/acpi/actypes.h                             |  10 +-
 include/acpi/acuuid.h                              |   2 +-
 include/acpi/cppc_acpi.h                           |  30 +-
 include/acpi/platform/acenv.h                      |   2 +-
 include/acpi/platform/acenvex.h                    |   2 +-
 include/acpi/platform/acgcc.h                      |  10 +-
 include/acpi/platform/acgccex.h                    |   2 +-
 include/acpi/platform/aclinux.h                    |   2 +-
 include/acpi/platform/aclinuxex.h                  |   2 +-
 include/acpi/platform/aczephyr.h                   |   2 +-
 include/linux/acpi.h                               |  18 +-
 tools/power/acpi/common/cmfsize.c                  |   2 +-
 tools/power/acpi/common/getopt.c                   |   2 +-
 .../acpi/os_specific/service_layers/oslinuxtbl.c   |   4 +-
 .../acpi/os_specific/service_layers/osunixdir.c    |   2 +-
 .../acpi/os_specific/service_layers/osunixmap.c    |   2 +-
 .../acpi/os_specific/service_layers/osunixxf.c     |   2 +-
 tools/power/acpi/tools/acpidump/acpidump.h         |   2 +-
 tools/power/acpi/tools/acpidump/apdump.c           |   2 +-
 tools/power/acpi/tools/acpidump/apfiles.c          |   4 +-
 tools/power/acpi/tools/acpidump/apmain.c           |   2 +-
 208 files changed, 1252 insertions(+), 553 deletions(-)

