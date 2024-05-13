Return-Path: <linux-acpi+bounces-5795-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA8C8C478A
	for <lists+linux-acpi@lfdr.de>; Mon, 13 May 2024 21:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F1E1F22B0D
	for <lists+linux-acpi@lfdr.de>; Mon, 13 May 2024 19:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4C678285;
	Mon, 13 May 2024 19:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdYDWrw/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D12D745E2;
	Mon, 13 May 2024 19:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715628617; cv=none; b=QnkWBDTd09LknmlXmdN41Qw7UtDc2RTrNRIRzFJ8cEvEXC0rRAWMknUEmpJnTp/s0w72yCQHNQGGsebeL5PY4zx9gamNMOj95kh6GkCPIIi9rITSTPF7hA3JU1YN5d0Ka2qBMOeEE7kghQQlXAFs6vZzz0EkEXELCCBGsO0CTdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715628617; c=relaxed/simple;
	bh=Bmn3VkvhWDzNgwGKEi4oKOL/Z5X8DmrE66CJjLFbc80=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=oHzKbwOw+P+NMOT5HCIuP35rq1vEM4sMAyee5rEsmcrjJdNoeoFNnaEEk7k+qZMNuP7/ucBNdAG6ZBxxXuyBHgourib1uc4Rv87XEXPlgs/ZtMo8OUNA6jKHlxlgnqFDOy+UlSYHOhZPwy8BEYuZpGZG5f4qIVkJ7knmURfxmiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdYDWrw/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC40C113CC;
	Mon, 13 May 2024 19:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715628617;
	bh=Bmn3VkvhWDzNgwGKEi4oKOL/Z5X8DmrE66CJjLFbc80=;
	h=From:Date:Subject:To:Cc:From;
	b=FdYDWrw/FnCMCm7ZR8881eXVCyiBdYE9/JbYg/JYSjeUvW8g7bkNVnXrvutev0z3l
	 JSEydrH91lbNAw/hbz8/CbHU/STlnGASX3hBcpTJcIwYCjhBS6YfDDq5TKVq9VwY78
	 l3c4zt+VXNil8ACpIpZx5IumZemM2DX9je0x3mnkVa4MrsMMiby4ZlS1bRv9hl0OeZ
	 vnW74OoYrESf8wudA279ECeHVaV4zbx3OdKbB0F3+ypdtJQ5z5Kp2FqMAKYNUHlquE
	 RHXedQPOwchrDyyEyViy0ENU1lln1nvLKlU0KJgVqRNLIXQICPDdYru7nzl56zsVOr
	 Jj1YDH+iIPcwQ==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5b2760a6ba2so161244eaf.3;
        Mon, 13 May 2024 12:30:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUOnqoCGR9VGGYJP8YNR8UP533YytfP8HkUIJZdlJQ83PXxW2O2w3UY3ExE1D1zLk8S0yMa6gBviuMRDwRRk8+Ke1W5k2d88Iw3iaVkDNtTCL1Lw56BSHe04lOs2/sT5/zNmcjdRBU=
X-Gm-Message-State: AOJu0Yy7wgIO8MWZgiOnhhno6qVI7wPLQvVXwnxTbgAP1FAcZH3U7unX
	ncqvV5zKaaMltRkA1BuIBnlqLqngkabJeFEDeZZEUjIwHDptdKcEfs+Zn9ycfrQJvG0qolUjTc+
	zK3IiE0FCtGF/8anO8YRf/TCnunw=
X-Google-Smtp-Source: AGHT+IFRKCIaib1fx2mPixVo/CyNzG4Edy6/KhVUofT2v2I0l20YEabKhNCDd7UsK5MenBrmr2P6r5Sj8E6/Jb30f/I=
X-Received: by 2002:a4a:d10e:0:b0:5af:be60:ccdc with SMTP id
 006d021491bc7-5b2815e1c94mr11721393eaf.0.1715628616277; Mon, 13 May 2024
 12:30:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 13 May 2024 21:30:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iTaVs5EBUkq0Vs39y+gYCcsZypW5YJNS1n3ES+upM2JQ@mail.gmail.com>
Message-ID: <CAJZ5v0iTaVs5EBUkq0Vs39y+gYCcsZypW5YJNS1n3ES+upM2JQ@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v6.10-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.10-rc1

with top-most commit e573d27e18f8289454b6abb378de531374bd3cde

 Merge branches 'acpi-tools', 'acpi-docs' and 'pnp'

on top of commit dd5a440a31fae6e459c0d6271dddd62825505361

 Linux 6.9-rc7

to receive ACPI updates for 6.10-rc1.

These are ACPICA updates coming from the 20240322 release upstream, an
ACPI DPTF driver update adding new platform support for it, some new
quirks and some assorted fixes and cleanups.

Specifics:

 - Add EINJ CXL error types to actbl1.h (Ben Cheatham).

 - Add support for RAS2 table to ACPICA (Shiju Jose).

 - Fix various spelling mistakes in text files and code comments in
   ACPICA (Colin Ian King).

 - Fix spelling and typos in ACPICA (Saket Dumbre).

 - Modify ACPI_OBJECT_COMMON_HEADER (lijun).

 - Add RISC-V RINTC affinity structure support to ACPICA (Haibo Xu).

 - Fix CXL 3.0 structure (RDPAS) in the CEDT table (Hojin Nam).

 - Add missin increment of registered GPE count to ACPICA (Daniil
   Tatianin).

 - Mark new ACPICA release 20240322 (Saket Dumbre).

 - Add support for the AEST V2 table to ACPICA (Ruidong Tian).

 - Disable -Wstringop-truncation for some ACPICA code in the kernel to
   avoid a compiler warning  that is not very useful (Arnd Bergmann).

 - Make the kernel indicate support for several ACPI features that are
   in fact supported to the platform firmware through _OSC and fix the
   Generic Initiator Affinity _OSC bit (Armin Wolf).

 - Make the ACPI core set the owner value for ACPI drivers, drop the
   owner setting from a number of drivers and eliminate the owner
   field from struct acpi_driver (Krzysztof Kozlowski).

 - Rearrange fields in several structures to effectively eliminate
   computations from container_of() in some cases (Andy Shevchenko).

 - Do some assorted cleanups of the ACPI device enumeration code (Andy
   Shevchenko).

 - Make the ACPI device enumeration code skip devices with _STA values
   clearly identified by the specification as invalid (Rafael Wysocki).

 - Rework the handling of the NHLT table to simplify and clarify it and
   drop some obsolete pieces (Cezary Rojewski).

 - Add ACPI IRQ override quirks for Asus Vivobook Pro N6506MV, TongFang
   GXxHRXx and GMxHGxx, and XMG APEX 17 M23 (Guenter Schafranek, Tamim
   Khan, Christoffer Sandberg).

 - Add reference to UEFI DSD Guide to the documentation related to the
   ACPI handling of device properties (Sakari Ailus).

 - Fix SRAT lookup of CFMWS ranges with numa_fill_memblks(), remove
   lefover architecture-dependent code from the ACPI NUMA handling code
   and simplify it on top of that (Robert Richter).

 - Add a num-cs device property to specify the number of chip selects
   for Intel Braswell to the ACPI LPSS (Intel SoC) driver and remove a
   nested CONFIG_PM #ifdef from it (Andy Shevchenko).

 - Move three x86-specific ACPI files to the x86 directory (Andy
   Shevchenko).

 - Mark SMO8810 accel on Dell XPS 15 9550 as always present and add a
   PNP_UART1_SKIP quirk for Lenovo Blade2 tablets (Hans de Goede).

 - Move acpi_blacklisted() declaration to asm/acpi.h (Kuppuswamy
   Sathyanarayanan).

 - Add Lunar Lake support to the ACPI DPTF driver (Sumeet Pawnikar).

 - Mark the einj_driver driver's remove callback as __exit because it
   cannot get unbound via sysfs (Uwe Kleine-K=C3=B6nig).

 - Fix a typo in the ACPI documentation regarding the layout of sysfs
   subdirectory representing the ACPI namespace (John Watts).

 - Make the ACPI pfrut utility print the update_cap field during
   capability query (Chen Yu).

 - Add HAS_IOPORT dependencies to PNP (Niklas Schnelle).

 - Add backlight=3Dnative quirk for Lenovo Slim 7 16ARH7 to the ACPI
   backlight (video) driver (Takashi Iwai).

Thanks!


---------------

Andy Shevchenko (12):
      ACPI: bus: Make container_of() no-op where it makes sense
      ACPI: bus: Don't use "proxy" headers
      ACPI: scan: Use list_first_entry_or_null() in acpi_device_hid()
      ACPI: scan: Move misleading comment to acpi_dma_configure_id()
      ACPI: scan: Use standard error checking pattern
      ACPI: scan: Introduce typedef:s for struct acpi_hotplug_context membe=
rs
      ACPI: LPSS: Advertise number of chip selects via property
      ACPI: LPSS: Remove nested ifdeffery for CONFIG_PM
      ACPI: x86: Introduce a Makefile
      ACPI: x86: Move acpi_cmos_rtc to x86 folder
      ACPI: x86: Move blacklist to x86 folder
      ACPI: x86: Move LPSS to x86 folder

Armin Wolf (5):
      ACPI: bus: Indicate support for _TFP thru _OSC
      ACPI: bus: Indicate support for more than 16 p-states thru _OSC
      ACPI: bus: Indicate support for the Generic Event Device thru _OSC
      ACPI: Fix Generic Initiator Affinity _OSC bit
      ACPI: bus: Indicate support for IRQ ResourceSource thru _OSC

Arnd Bergmann (1):
      ACPI: disable -Wstringop-truncation

Ben Cheatham (1):
      ACPICA: actbl1.h: Add EINJ CXL error types

Cezary Rojewski (4):
      ACPI: NHLT: Reintroduce types the table consists of
      ACPI: NHLT: Introduce API for the table
      ACPI: NHLT: Drop redundant types
      ACPI: NHLT: Streamline struct naming

Chen Yu (1):
      ACPI: tools: pfrut: Print the update_cap field during capability quer=
y

Christoffer Sandberg (1):
      ACPI: resource: Do IRQ override on TongFang GXxHRXx and GMxHGxx

Colin Ian King (1):
      ACPICA: Fix various spelling mistakes in text files and code comments

Daniil Tatianin (1):
      ACPICA: events/evgpeinit: don't forget to increment registered GPE co=
unt

Guenter Schafranek (1):
      ACPI: resource: Do IRQ override on GMxBGxx (XMG APEX 17 M23)

Haibo Xu (2):
      ACPICA: SRAT: Add RISC-V RINTC affinity structure
      ACPICA: SRAT: Add dump and compiler support for RINTC affinity struct=
ure

Hans de Goede (2):
      ACPI: x86: utils: Mark SMO8810 accel on Dell XPS 15 9550 as always pr=
esent
      ACPI: x86: Add PNP_UART1_SKIP quirk for Lenovo Blade2 tablets

Hojin Nam (1):
      ACPICA: Fix CXL 3.0 structure (RDPAS) in the CEDT table

John Watts (1):
      Documentation: firmware-guide: ACPI: Fix namespace typo

Krzysztof Kozlowski (19):
      ACPI: store owner from modules with acpi_bus_register_driver()
      Input: atlas - drop owner assignment
      net: fjes: drop owner assignment
      platform/chrome: wilco_ec: drop owner assignment
      platform: asus-laptop: drop owner assignment
      platform: classmate-laptop: drop owner assignment
      platform/x86/dell: drop owner assignment
      platform/x86/eeepc: drop owner assignment
      platform/x86/intel/rst: drop owner assignment
      platform/x86/intel/smartconnect: drop owner assignment
      platform/x86/lg-laptop: drop owner assignment
      platform/x86/sony-laptop: drop owner assignment
      platform/x86/toshiba_acpi: drop owner assignment
      platform/x86/toshiba_bluetooth: drop owner assignment
      platform/x86/toshiba_haps: drop owner assignment
      platform/x86/wireless-hotkey: drop owner assignment
      ptp: vmw: drop owner assignment
      virt: vmgenid: drop owner assignment
      ACPI: drop redundant owner from acpi_driver

Kuppuswamy Sathyanarayanan (1):
      ACPI: Move acpi_blacklisted() declaration to asm/acpi.h

Niklas Schnelle (1):
      PNP: add HAS_IOPORT dependencies

Rafael J. Wysocki (1):
      ACPI: scan: Avoid enumerating devices with clearly invalid _STA value=
s

Robert Richter (4):
      x86/numa: Fix SRAT lookup of CFMWS ranges with numa_fill_memblks()
      ACPI/NUMA: Remove architecture dependent remainings
      ACPI/NUMA: Squash acpi_numa_slit_init() into acpi_parse_slit()
      ACPI/NUMA: Squash acpi_numa_memory_affinity_init() into
acpi_parse_memory_affinity()

Ruidong Tian (1):
      ACPICA: AEST: Add support for the AEST V2 table

Sakari Ailus (1):
      ACPI: property: Add reference to UEFI DSD Guide

Saket Dumbre (4):
      ACPICA: Attempt 1 to fix issue #900
      ACPICA: Clean up the fix for Issue #900
      ACPICA: Fix spelling and typos
      ACPICA: Update acpixf.h for new ACPICA release 20240322

Shiju Jose (1):
      ACPICA: ACPI 6.5: RAS2: Add support for RAS2 table

Sumeet Pawnikar (1):
      ACPI: DPTF: Add Lunar Lake support

Takashi Iwai (1):
      ACPI: video: Add backlight=3Dnative quirk for Lenovo Slim 7 16ARH7

Tamim Khan (1):
      ACPI: resource: Skip IRQ override on Asus Vivobook Pro N6506MV

Uwe Kleine-K=C3=B6nig (1):
      ACPI: APEI: EINJ: mark remove callback as __exit

lijun (1):
      ACPICA: Modify ACPI_OBJECT_COMMON_HEADER

---------------

 Documentation/firmware-guide/acpi/namespace.rst    |   4 +-
 arch/x86/include/asm/acpi.h                        |   2 +
 arch/x86/include/asm/sparsemem.h                   |   2 -
 arch/x86/mm/numa.c                                 |   4 +-
 drivers/acpi/Kconfig                               |   3 +
 drivers/acpi/Makefile                              |   8 +-
 drivers/acpi/acpica/Makefile                       |   1 +
 drivers/acpi/acpica/aclocal.h                      |   2 +-
 drivers/acpi/acpica/acobject.h                     | 107 +++--
 drivers/acpi/acpica/evgpeinit.c                    |   1 +
 drivers/acpi/acpica/utdebug.c                      |   5 +
 drivers/acpi/apei/einj-core.c                      |  12 +-
 drivers/acpi/bus.c                                 |  25 +-
 drivers/acpi/dock.c                                |  48 +-
 drivers/acpi/dptf/dptf_pch_fivr.c                  |   1 +
 drivers/acpi/dptf/dptf_power.c                     |   2 +
 drivers/acpi/dptf/int340x_thermal.c                |   6 +
 drivers/acpi/fan.h                                 |   1 +
 drivers/acpi/internal.h                            |   3 +-
 drivers/acpi/nhlt.c                                | 289 ++++++++++++
 drivers/acpi/numa/srat.c                           |  82 ++--
 drivers/acpi/property.c                            |  11 +-
 drivers/acpi/resource.c                            |  25 +
 drivers/acpi/scan.c                                |  30 +-
 drivers/acpi/video_detect.c                        |   8 +
 drivers/acpi/x86/Makefile                          |   8 +
 drivers/acpi/{ =3D> x86}/blacklist.c                 |   2 +-
 drivers/acpi/{acpi_cmos_rtc.c =3D> x86/cmos_rtc.c}   |   2 +-
 drivers/acpi/{acpi_lpss.c =3D> x86/lpss.c}           |   5 +-
 drivers/acpi/x86/utils.c                           |  29 +-
 drivers/input/misc/atlas_btns.c                    |   1 -
 drivers/net/fjes/fjes_main.c                       |   1 -
 drivers/platform/chrome/wilco_ec/event.c           |   1 -
 drivers/platform/x86/asus-laptop.c                 |   1 -
 drivers/platform/x86/classmate-laptop.c            |   5 -
 drivers/platform/x86/dell/dell-rbtn.c              |   1 -
 drivers/platform/x86/eeepc-laptop.c                |   1 -
 drivers/platform/x86/intel/rst.c                   |   1 -
 drivers/platform/x86/intel/smartconnect.c          |   1 -
 drivers/platform/x86/lg-laptop.c                   |   1 -
 drivers/platform/x86/sony-laptop.c                 |   2 -
 drivers/platform/x86/toshiba_acpi.c                |   1 -
 drivers/platform/x86/toshiba_bluetooth.c           |   1 -
 drivers/platform/x86/toshiba_haps.c                |   1 -
 drivers/platform/x86/wireless-hotkey.c             |   1 -
 drivers/pnp/isapnp/Kconfig                         |   2 +-
 drivers/ptp/ptp_vmw.c                              |   1 -
 .../intel/int340x_thermal/int3400_thermal.c        |   1 +
 .../intel/int340x_thermal/int3403_thermal.c        |   1 +
 drivers/virt/vmgenid.c                             |   1 -
 include/acpi/acpi_bus.h                            |  36 +-
 include/acpi/acpixf.h                              |   2 +-
 include/acpi/actbl1.h                              |   8 +-
 include/acpi/actbl2.h                              | 516 +++++++++++++----=
----
 include/acpi/actbl3.h                              |  18 +-
 include/acpi/nhlt.h                                | 181 ++++++++
 include/linux/acpi.h                               |  13 +-
 include/linux/numa.h                               |   7 +-
 tools/power/acpi/tools/pfrut/pfrut.c               |   2 +
 59 files changed, 1129 insertions(+), 408 deletions(-)

