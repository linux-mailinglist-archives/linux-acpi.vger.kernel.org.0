Return-Path: <linux-acpi+bounces-19358-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A2EC931E0
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Nov 2025 21:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B743034B2B0
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Nov 2025 20:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9865529C328;
	Fri, 28 Nov 2025 20:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFsW35JU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73146261586
	for <linux-acpi@vger.kernel.org>; Fri, 28 Nov 2025 20:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764361878; cv=none; b=UwmV5wJppnti9E4E1uMm5BPGB6x4hnvcXwcpHCEHSmzXci7JtSl9IXqRHsQC0tcfC30UsUplBsjYx1Llk4k9qrZkNXTrQwbpYV2FGw9bJItuxy2XluLH7SltkiqeXYnxlMnldoFSdmuctSN0qI9gEYuWQJ4Rv5IP5tEQo+FF8Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764361878; c=relaxed/simple;
	bh=ocRY3Lw0TbYxuwGesY9jQJGFZNX9FKTMoh7jv8g4c/Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=uOs3PZgi433SyaR1xnj2v9IHhI8B+R4TmqZUOPStzN1TdCkxB4BBcOtVup7CIRdRmpZpTmNyScYSOUJg6qeUJhvbY4fzB+Moej43G87toeTcwFdwJU5j+dVPUrrLo6n6YvMJECLdCUXOX4oXUlyBghtwsksdWlMcIeFIJy4gHjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFsW35JU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2196AC116C6
	for <linux-acpi@vger.kernel.org>; Fri, 28 Nov 2025 20:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764361878;
	bh=ocRY3Lw0TbYxuwGesY9jQJGFZNX9FKTMoh7jv8g4c/Y=;
	h=From:Date:Subject:To:Cc:From;
	b=jFsW35JUoIOOdGixT0v0obV/lk36vOAQgk+f+7NCxkHglYLkvEg6lJwR9CwPrTKGG
	 oJsLkumc4oPOeFyxsuE5qSOwIVrtgHKtPq76DFdTuAPQCheWUVK77wzdvNZWDFvd+6
	 CtVIfRmgGl39qH9I97w0QDhqZR82FgL6lNcZ8DRd0HpjbFNNikm8Kgau80yxtd7SPH
	 2j0yWlVlvCWmrox8rRPAVwV0HO9KmG1DIFD4pw6Kdk20NG44bKYyh2E79feqNsYJ7D
	 CBd1HsrUYCnxd+UvzYuCuMmku/K8BtYbmW9fxR6d1e3xdB6MTL6XTJsw2MIFS/OZku
	 bIFnlt+Xn0fMg==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-45066bee74aso443936b6e.2
        for <linux-acpi@vger.kernel.org>; Fri, 28 Nov 2025 12:31:18 -0800 (PST)
X-Gm-Message-State: AOJu0YxCBa0pybxoKI9R+qG9sf+T3SuWbGNJZdDLWMDc/DHvC4Ex2XyB
	C0u3+rj0xFsvoj7kHxRYUKSiIOoeoW2GeRN8WTlEUIebQbyvDQ4hmkQR4jDn+OL59Vg/VOh3J1d
	fPGHD+q+TKmVucQqvY46zVCTsFBMDbsI=
X-Google-Smtp-Source: AGHT+IFC4otRLk7akgjyp/4Wf1kmvexBcL21Abj32frTCV8ccnd4tKQE1expYTTfUoWdLST/mhV0T1PORVe7btiSrzU=
X-Received: by 2002:a05:6808:c144:b0:44f:dee8:ead1 with SMTP id
 5614622812f47-4511572fb23mr12371635b6e.4.1764361877401; Fri, 28 Nov 2025
 12:31:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 28 Nov 2025 21:31:06 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gaDJaBGHY-6krpyegAZXvtMka22J0q4Hgg9dPMs19FkQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnl8nssPZODHQHbyF0Lc_DcwHVdZS5y99t42I7n8MGomM_QPxJqWCON-YU
Message-ID: <CAJZ5v0gaDJaBGHY-6krpyegAZXvtMka22J0q4Hgg9dPMs19FkQ@mail.gmail.com>
Subject: [GIT PULL] ACPI support updates for v6.19-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

I am sending this in advance because I am not expecting to make any changes
to it before next week.

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.19-rc1

with top-most commit af47d98064e900f279c98bb3bb57445a1e7a8f6b

 Merge branches 'acpi-misc' and 'pnp'

on top of commit fbf04215d9966da61feee3f4ec24dbf4544cfd0f

 Revert "ACPI: processor: Update cpuidle driver check in
__acpi_processor_start()"

to receive ACPI support updates for 6.19-rc1.

These add Microsoft fan extensions support to the ACPI fan driver,
fix a bug in ACPICA, update other ACPI drivers (processor, time and
alarm device), update ACPI power management code and ACPI device
properties management, and fix an ACPI utility:

 - Avoid walking the ACPI namespace in the AML interpreter if the
   starting node cannot be determined (Cryolitia PukNgae)

 - Use min() instead of min_t() in the ACPI device properties handling
   code to avoid discarding significant bits (David Laight)

 - Fix potential fwnode refcount leak in acpi_fwnode_graph_parse_endpoint()
   that may prevent the parent fwnode from being released (Haotian Zhang)

 - Rework acpi_graph_get_next_endpoint() to use ACPI functions only, remove
   unnecessary conditionals from it to make it easier to follow, and make
   acpi_get_next_subnode() static (Sakari Ailus)

 - Drop unused function acpi_get_lps0_constraint(), make some Low-Power
   S0 callback functions for suspend-to-idle static, and rearrange the
   code retrieving Low-Power S0 constraints so it only runs when the
   constraints are actually used (Rafael Wysocki)

 - Drop redundant locking from the ACPI battery driver (Rafael Wysocki)

 - Improve runtime PM in the ACPI time and alarm device (TAD) driver
   using guard macros and rearrange code related to runtime PM in
   acpi_tad_remove() (Rafael Wysocki)

 - Add support for Microsoft fan extensions to the ACPI fan driver along
   with notification support and work around a 64-bit firmware bug in
   that driver (Armin Wolf)

 - Use ACPI_FREE() to free ACPI buffer in the ACPI DPTF code (Kaushlendra
   Kumar)

 - Fix a memory leak and a resource leak in the ACPI pfrut utility (Malaya
   Kumar Rout)

 - Replace `core::mem::zeroed` with `pin_init::zeroed` in the ACPI Rust
   code (Siyuan Huang)

 - Update the ACPI code to use the new style of allocating workqueues
   and new global workqueues (Marco Crivellari)

 - Fix two spelling mistakes in the ACPI code (Chu Guangqing)

 - Fix ISAPNP to generate uevents to auto-load modules (Ren=C3=A9 Rebe)

 - Relocate the state flags initialization in the ACPI processor idle
   driver and drop redundant C-state count checks from it (Huisong Li)

 - Fix map_x2apic_id() in the ACPI processor core driver for amd-pstate
   on am4 (Ren=C3=A9 Rebe)

Thanks!


---------------

Armin Wolf (4):
      ACPI: fan: Workaround for 64-bit firmware bug
      ACPI: fan: Add basic notification support
      ACPI: fan: Add hwmon notification support
      ACPI: fan: Add support for Microsoft fan extensions

Chu Guangqing (2):
      ACPI: LPSS: Fix a spelling mistake
      ACPI: PM: Fix a spelling mistake

Cryolitia PukNgae (1):
      ACPICA: Avoid walking the Namespace if start_node is NULL

David Laight (1):
      ACPI: property: use min() instead of min_t()

Haotian Zhang (1):
      ACPI: property: Fix fwnode refcount leak in
acpi_fwnode_graph_parse_endpoint()

Huisong Li (2):
      ACPI: processor: idle: Relocate state flags initialization
      ACPI: processor: idle: Drop redundant C-state count checks

Kaushlendra Kumar (1):
      ACPI: DPTF: Use ACPI_FREE() for ACPI buffer deallocation

Malaya Kumar Rout (1):
      ACPI: tools: pfrut: fix memory leak and resource leak in pfrut.c

Marco Crivellari (5):
      ACPI: scan: replace use of system_unbound_wq with system_dfl_wq
      ACPI: OSL: replace use of system_wq with system_percpu_wq
      ACPI: EC: Add WQ_PERCPU to alloc_workqueue() users
      ACPI: OSL: Add WQ_PERCPU to alloc_workqueue() users
      ACPI: thermal: Add WQ_PERCPU to alloc_workqueue() users

Rafael J. Wysocki (6):
      ACPI: PM: s2idle: Drop acpi_get_lps0_constraint()
      ACPI: PM: s2idle: Staticise LPS0 callback functions
      ACPI: PM: s2idle: Only retrieve constraints when needed
      ACPI: battery: Drop redundant locking
      ACPI: TAD: Rearrange runtime PM operations in acpi_tad_remove()
      ACPI: TAD: Improve runtime PM using guard macros

Ren=C3=A9 Rebe (2):
      PNP: Fix ISAPNP to generate uevents to auto-load modules
      ACPI: processor_core: fix map_x2apic_id for amd-pstate on am4

Sakari Ailus (3):
      ACPI: property: Make acpi_get_next_subnode() static
      ACPI: property: Use ACPI functions in acpi_graph_get_next_endpoint() =
only
      ACPI: property: Rework acpi_graph_get_next_endpoint()

Siyuan Huang (1):
      rust: acpi: replace `core::mem::zeroed` with `pin_init::zeroed`

---------------

 drivers/acpi/acpi_tad.c              |  73 ++++++------
 drivers/acpi/acpica/nswalk.c         |   9 +-
 drivers/acpi/battery.c               |  12 --
 drivers/acpi/dptf/dptf_pch_fivr.c    |   2 +-
 drivers/acpi/ec.c                    |   3 +-
 drivers/acpi/fan.h                   |  40 +++++++
 drivers/acpi/fan_core.c              | 223 +++++++++++++++++++++++++++++++=
+++-
 drivers/acpi/fan_hwmon.c             |  25 ++--
 drivers/acpi/osl.c                   |   6 +-
 drivers/acpi/processor_core.c        |   2 +-
 drivers/acpi/processor_idle.c        |  42 +++----
 drivers/acpi/property.c              |  29 +++--
 drivers/acpi/scan.c                  |   2 +-
 drivers/acpi/sleep.c                 |   2 +-
 drivers/acpi/sleep.h                 |   3 -
 drivers/acpi/thermal.c               |   3 +-
 drivers/acpi/x86/lpss.c              |   2 +-
 drivers/acpi/x86/s2idle.c            |  65 +++++-----
 drivers/pnp/driver.c                 |  19 +++
 include/linux/acpi.h                 |  15 ---
 rust/kernel/acpi.rs                  |   4 +-
 tools/power/acpi/tools/pfrut/pfrut.c |   7 +-
 22 files changed, 420 insertions(+), 168 deletions(-)

