Return-Path: <linux-acpi+bounces-20872-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sK8QNbDyhGkF7AMAu9opvQ
	(envelope-from <linux-acpi+bounces-20872-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Feb 2026 20:42:40 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3D0F6E84
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Feb 2026 20:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC1B23017019
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Feb 2026 19:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED240329C7D;
	Thu,  5 Feb 2026 19:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9qSoCP5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8791F3D56
	for <linux-acpi@vger.kernel.org>; Thu,  5 Feb 2026 19:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770320557; cv=none; b=HdkFPiOud5FrIyB6fINzTuzHQeIPqAzAwyRkJQ34jJeWx6S4MERde/vWbCysTW4zcKyDb28oQLmFUwQiUy3Iw5b+c7R0Ci5mlh6SL9HBQe3HzSeuFYaYdGT6J3MEF1SAXbcbGQUSpHsTeUB/QQf5drJAEOmfAl+ClxAwuuKH7ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770320557; c=relaxed/simple;
	bh=5WVz5Jep1PszBcH0ttRMBL3JFtE4hrI25hoBStHHHps=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=VFUy0D1kquOBcV6DGMKu9rIpPKWpTBXpjCT6BsL/TbgRNUCJHgJeQTrZdXIZaycPO2HCYF73wj2JgiXjaHJdlmWvACxwjpAqjACdNoCZAUPsZwWY3DBgQ9Tqq7KaxFnqrFaXI1uVdZrhmWqUmJaW1K3O3lj8A6V6a4k2cRtw+BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9qSoCP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F966C116D0
	for <linux-acpi@vger.kernel.org>; Thu,  5 Feb 2026 19:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770320557;
	bh=5WVz5Jep1PszBcH0ttRMBL3JFtE4hrI25hoBStHHHps=;
	h=From:Date:Subject:To:Cc:From;
	b=M9qSoCP571hzo5db60JZFke7Mn+dTd07PA6uIlHwVYiNZlhAA0KPAUdwdP0vJeJhr
	 U1BCr/TYMbwWLptem2AR0kKDYjnTo+2iyDwgqW7YooCm7awbyFPd/MYylDfifrZ4yi
	 7BPOBQpfLuP1864SOtPGTBtWl+/1wFfQ/RbPYAEbWaIu3r/XqyAcspg4sd6pddO9H3
	 1bwd04r41s76KIsUMgA1oQbiEwphhyb6Y4Ssz6/Toip2MX6Ymkl4uRzwfkoHMDqr07
	 3MKoCZVJCEmj2gmz3HpvODlZgIc1uVBkc+RTeo3IjQFQ0HD6Mx/XGiu5yyzZBA+kJK
	 PJ9QWbe055UqA==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-662f485e58aso621607eaf.0
        for <linux-acpi@vger.kernel.org>; Thu, 05 Feb 2026 11:42:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXrJVve2L84pXl5hWUUagwZmOPZeqBzdVfsbJvEDKFqLZQdTL6kV87NcbC5BE/coI6/W+D3oLKMYESU@vger.kernel.org
X-Gm-Message-State: AOJu0YyWgUZj/hF2Kgssw/4efJBzVY939NF36nebmKb+fk/F4TUbkjyu
	AfuZYSqIpVprN2A2PMrrHPa60ab6qQBrWyoFy4ktNrfX4pts5l4jovNtTNxptehcU954aIOEuUQ
	yAaapQyAcYtHmXTVXtRd93T/hJkp6OMg=
X-Received: by 2002:a05:6820:1c98:b0:662:f746:5728 with SMTP id
 006d021491bc7-66d0c6666aamr214835eaf.60.1770320556461; Thu, 05 Feb 2026
 11:42:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 5 Feb 2026 20:42:25 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hOUCPEPeE1bN3BkgRnM3ouDX301f5qnK53BTD+oU5=rw@mail.gmail.com>
X-Gm-Features: AZwV_Qg_PBKt0KwCcVNFUErnqpTpkdFpjZMCnzZ55TUbg-y2VOCD2raFwlY1wKk
Message-ID: <CAJZ5v0hOUCPEPeE1bN3BkgRnM3ouDX301f5qnK53BTD+oU5=rw@mail.gmail.com>
Subject: [GIT PULL] Thermal control updates for v6.20-rc1/v7.0-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-20872-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3C3D0F6E84
X-Rspamd-Action: no action

Hi Linus,

This goes a bit early, but it's ready.

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.20-rc1

with top-most commit 8035d70cf85e86f36f5eb1e07b243f300a936b8b

 Merge branch 'thermal-intel'

on top of commit 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb

 Linux 6.19-rc4

to receive thermal control updates for 6.20-rc1/7.0-rc1 (whichever it
turns out to be).

These add support for "slow" (long-term trend) workload type hints
to the Intel int340x thermal driver and selftests (and enable it for
Panther Lake), add support for MT8196 along with DT bindings and for
MT7987 to the Mediatek LVTS thermal driver, add support for RZ/T2H and
RZ/N2H along with DT bindings to the Renesas rzg3e thermal driver,
add support for the Panther Lake, Wildcat Lake and Nova Lake processors
to the intel_tcc_cooling driver, fix bugs, make some cosmetic changes
including code cleanups and library function substitutions, and update
documentation.

Specifics:

 - Add Panther Lake, Wildcat Lake and Nova Lake processor IDs to the
   list of supported processors in the intel_tcc_cooling thermal
   driver (Srinivas Pandruvada)

 - Drop unnecessary explicit driver data clearing on removal from the
   intel_pch_thermal driver (Kaushlendra Kumar)

 - Add support for "slow" workload type hints to the int340x
   processor_thermal driver and enable it on the Panther Lake
   platform (Srinivas Pandruvada)

 - Use sysfs_emit{_at}() in sysfs show functions in Intel thermal
   drivers (Thorsten Blum)

 - Update the x86_pkg_temp_thermal driver to handle THERMAL_TEMP_INVALID
   that can be passed to it via sysfs as expected (Rafael Wysocki)

 - Drop a redundant local variable from the intel_tcc_cooling thermal
   driver and fix a kerneldoc comment typo in the TCC library (Sumeet
   Pawnikar)

 - Fix CFLAGS and LDFLAGS in the pkg-config libthermal template (Romain
   Gantois)

 - Support multiple temp to raw conversion functions in the Mediatek
   LVTS thermal driver and add MT8196 and MT6991 support to it (Laura
   Nao)

 - Add Mediatek LVTS driver support for MT7987 (Frank Wunderlich)

 - Use the existing HZ_PER_MHZ macro on STM32 (Andy Shevchenko)

 - Use the existing clamp() macro on BCM2835 (Thorsten Blum)

 - Make the reset line optional in order to support new Renesas SoCs
   where it is not available and add support for RZ/T2H and RZ/N2H
   to the rzg3e thermal driver (Cosmin Tanislav)

 - Document RZ/V2N TSU in the r9a09g047-tsu DT bindings (Ovidiu
   Panait)

 - Fix all kernel-doc warnings in the internal thermal core header
   file (Randy Dunlap)

 - Fix a device node reference leak in thermal_of_cm_lookup() (Felix Gu)

 - Replace some old-style library function calls with ones that are
   currently recommended in several places in the thermal core and
   debugfs code (Sumeet Pawnikar, Thorsten Blum)

Thanks!


---------------

Andy Shevchenko (1):
      thermal/drivers/stm32: Use predefined HZ_PER_MHZ instead of a custom one

Cosmin Tanislav (5):
      thermal: renesas: rzg3e: make reset optional
      thermal: renesas: rzg3e: make min and max temperature per-chip
      thermal: renesas: rzg3e: make calibration value retrieval per-chip
      dt-bindings: thermal: r9a09g047-tsu: document RZ/T2H and RZ/N2H
      thermal: renesas: rzg3e: add support for RZ/T2H and RZ/N2H

Felix Gu (1):
      thermal/of: Fix reference leak in thermal_of_cm_lookup()

Frank Wunderlich (2):
      dt-bindings: thermal: mediatek: Add LVTS thermal controller
definition for MT7987
      thermal/drivers/mediatek/lvts_thermal: Add mt7987 support

Kaushlendra Kumar (1):
      thermal: intel: intel_pch_thermal: Drop explicit driver data clearing

Laura Nao (8):
      dt-bindings: thermal: mediatek: Add LVTS thermal controller
support for MT8196
      thermal/drivers/mediatek/lvts: Make number of calibration
offsets configurable
      thermal/drivers/mediatek/lvts: Add platform ops to support
alternative conversion logic
      thermal/drivers/mediatek/lvts: Add lvts_temp_to_raw variant
      thermal/drivers/mediatek/lvts: Add support for ATP mode
      thermal/drivers/mediatek/lvts: Support MSR offset for 16-bit
calibration data
      thermal/drivers/mediatek/lvts_thermal: Add MT8196 support
      dt-bindings: nvmem: mediatek: efuse: Add support for MT8196

Ovidiu Panait (1):
      dt-bindings: thermal: r9a09g047-tsu: Document RZ/V2N TSU

Rafael J. Wysocki (1):
      thermal: intel: x86_pkg_temp_thermal: Handle invalid temperature

Randy Dunlap (1):
      thermal: core: thermal_core.h: fix all kernel-doc warnings

Romain Gantois (1):
      tools: lib: thermal: Correct CFLAGS and LDFLAGS in pkg-config template

Srinivas Pandruvada (3):
      thermal: intel: intel_tcc_cooling: Add CPU models in the support list
      thermal: int340x: processor_thermal: Enable slow workload type hints
      thermal: intel: selftests: workload_hint: Support slow workload hints

Sumeet Pawnikar (4):
      thermal: Replace sprintf() with sysfs_emit() for sysfs show functions
      thermal: debugfs: Use seq_puts() for constant string output
      thermal: intel: fix typo "nagative" in comment for cpu argument
      drivers: thermal: intel: tcc_cooling: Drop redundant local variable

Thorsten Blum (5):
      thermal: core: Use strnlen() in thermal_zone_device_register_with_trips()
      thermal: intel: int340x: Use sysfs_emit{_at}() in sysfs show functions
      thermal: sysfs: Replace snprintf() with strscpy() in policy_store()
      thermal: intel: Use sysfs_emit() in a sysfs show function
      thermal/drivers/broadcom: Use clamp to simplify bcm2835_thermal_temp2adc

---------------

 .../devicetree/bindings/nvmem/mediatek,efuse.yaml  |   1 +
 .../bindings/thermal/mediatek,lvts-thermal.yaml    |   3 +
 .../bindings/thermal/renesas,r9a09g047-tsu.yaml    |  34 +-
 Documentation/driver-api/thermal/intel_dptf.rst    |   3 +
 drivers/thermal/broadcom/bcm2835_thermal.c         |   8 +-
 .../int340x_thermal/processor_thermal_device.c     |   5 +-
 .../intel/int340x_thermal/processor_thermal_rfim.c |   9 +-
 .../int340x_thermal/processor_thermal_wt_hint.c    |  57 +++-
 .../int340x_thermal/processor_thermal_wt_req.c     |   7 +-
 drivers/thermal/intel/intel_pch_thermal.c          |   1 -
 drivers/thermal/intel/intel_tcc.c                  |   8 +-
 drivers/thermal/intel/intel_tcc_cooling.c          |  13 +-
 drivers/thermal/intel/therm_throt.c                |   5 +-
 drivers/thermal/intel/x86_pkg_temp_thermal.c       |   3 +
 drivers/thermal/mediatek/lvts_thermal.c            | 362 +++++++++++++++++++--
 drivers/thermal/renesas/rzg3e_thermal.c            | 123 ++++---
 drivers/thermal/st/stm_thermal.c                   |   4 +-
 drivers/thermal/thermal_core.c                     |   8 +-
 drivers/thermal/thermal_core.h                     |   7 +-
 drivers/thermal/thermal_debugfs.c                  |   2 +-
 drivers/thermal/thermal_hwmon.c                    |   4 +-
 drivers/thermal/thermal_of.c                       |   4 +-
 drivers/thermal/thermal_sysfs.c                    |  38 +--
 .../dt-bindings/thermal/mediatek,lvts-thermal.h    |  29 ++
 tools/lib/thermal/libthermal.pc.template           |   4 +-
 .../intel/workload_hint/workload_hint_test.c       |  74 +++--
 26 files changed, 651 insertions(+), 165 deletions(-)

