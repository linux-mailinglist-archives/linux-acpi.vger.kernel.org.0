Return-Path: <linux-acpi+bounces-6885-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A43EA931B27
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jul 2024 21:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E32DB224D1
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jul 2024 19:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BDE136E1D;
	Mon, 15 Jul 2024 19:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwz/Dg8T"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB386E61B;
	Mon, 15 Jul 2024 19:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721072477; cv=none; b=NSJ4w8+RUB8DZW8lXPgLE5EJB97D3YLpzU9lZyGqsTRtC0DXGDuJVqNbhfObQWBwO2oH3MxtFrT5jUCcWxmkZAmfG9MPEhJ9qnvFIVFX1MglQBnyWmi73IhhAQR1chM9dA42RUxgLBto639Bp1C2HsZgWaIg3ZtCnHDG65twxtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721072477; c=relaxed/simple;
	bh=V5BZB48Gz3N4as/aSfFIyDl48y+kPgPMrhXFfaW5l+c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DzaMJ3UY375qEBU5iO7KhvseSQaUILKRzlALQ1OtogW4y0RVTTqDGsggOFSKpaaijQ4yQ6UzxeTMN3EcxI0WjtyIbS3LViXTUma6deNeWjJ42zxFhP6tKX6Jq8QZ8wJekHt9c2zxt+OhJGSzG6hc1Dzl/ehSKX9YFdmpxVMzndo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwz/Dg8T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0411EC4AF0A;
	Mon, 15 Jul 2024 19:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721072477;
	bh=V5BZB48Gz3N4as/aSfFIyDl48y+kPgPMrhXFfaW5l+c=;
	h=From:Date:Subject:To:Cc:From;
	b=hwz/Dg8Tho8ZFlCGJUbv5J5cb/oPcNMba/IW9M0YkMdCdxr4ZUSHU0Y4HJvXAm5A0
	 SuRqWT7w1Rw/wj2wI76Z3SpAHaLe5ttuu/vCagnrLK53ZFiCFisitydVtnl5e0fIsw
	 oS/vPhvj0csYJ0rjKLtF4MEdx8qoDIDmaeRLsOySl0gmtPCgSH8ytRlo3QflMAc+/c
	 nE02/EweGGN48FhyY0CaZh7L8jLjR4fOzlrgpI6Zkj5YaLmfnYTzV26XI76E1zzoWv
	 5lg02vt2TRLUXi4ogk2rfr5sVtJeEh1eYmHE7cJ+x6d3MgaOfAcA4asZPaKwgPjhED
	 6NIi9EVeULQxQ==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-254c411d816so543515fac.1;
        Mon, 15 Jul 2024 12:41:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWlYDJYed4t0WPae/ksxog7J88fVxMPQrhIh66gHWCighszKujAPYC9a6fRHoIz13JwfagI+0xyO2No4Bxjaek6mInBAk96tpUeKeJSwUqQ7ehGSaEFmT+jp9h+FHWr2btR6lwXnhl/yA==
X-Gm-Message-State: AOJu0Yxuzvta8/aXe/CsNjQPpiEnGLWQyO+yB4lDWuzaMB4QdISm2H3a
	UUSnunrBy78PW41RsxILt8RMp6zgOmnu5/iq3XeQjxI04o1lciKNJjcKvYfwAm53fdH/8cDerAu
	FUaXn4xSkBK86Rjdwz27krkhUTMM=
X-Google-Smtp-Source: AGHT+IHFqTo2Br5MMUHuhTpLrQLAhOJIPHdDjgLOhNKjMYgK87aIXUUvyKQH50wiEO57iox9G6sVgbRedsqKYc3I6NU=
X-Received: by 2002:a4a:4308:0:b0:5c6:67b7:41dd with SMTP id
 006d021491bc7-5d25035c588mr563647eaf.0.1721072476196; Mon, 15 Jul 2024
 12:41:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Jul 2024 21:41:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0guQr816kzz88G8XUjC7fnV9psTVdR_HWyt9D7evA27LA@mail.gmail.com>
Message-ID: <CAJZ5v0guQr816kzz88G8XUjC7fnV9psTVdR_HWyt9D7evA27LA@mail.gmail.com>
Subject: [GIT PULL] Thermal control updates for v6.11-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.11-rc1

with top-most commit 281cfec53b4484ce2092c89b6909f5573cb23443

 Merge branch 'thermal-intel'

on top of commit 94eacc1c583dd2ba51a2158fb13285f5dc42714b

 thermal: core: Fix list sorting in __thermal_zone_device_update()

to receive thermal control updates for 6.11-rc1.

These add some new hardware support (notably, the Lunar Lake platform
support in int340x and X1E80100 temperature sensor), continue to rework
the thermal driver interface to eliminate trip point IDs from it, update
DT bindings for a number of platforms and simplify probe in a number of
thermal drivers, address issues and clean up code.

Specifics:

 - Add DLVR and MSI interrupt support for the Lunar Lake platform to the
   int340x thermal driver (Srinivas Pandruvada).

 - Enable workload type hints (WLT) support and power floor interrupt
   support for the Lunar Lake platform in int340x ((Srinivas Pandruvada).

 - Switch Intel thermal drivers to new Intel CPU model defines (Tony
   Luck).

 - Clean up the int3400 and int3403 drivers (Erick Archer and David Alan
   Gilbert).

 - Improve intel_pch_thermal kernel log messages printed during suspend
   to idle (Zhang Rui).

 - Make the intel_tcc_cooling driver use a model-specific bitmask for
   TCC offset (Ricardo Neri).

 - Redesign the .set_trip_temp() thermal zone callback to take a trip
   pointer instead of a trip ID and update its users (Rafael Wysocki).

 - Avoid using invalid combinations of polling_delay and passive_delay
   thermal zone parameters (Rafael Wysocki).

 - Update a cooling device registration function to take a const
   argument (Krzysztof Kozlowski).

 - Make the uniphier thermal driver use thermal_zone_for_each_trip() for
   walking trip points (Rafael Wysocki).

 - Fix and clean up several minor shortcomings in thermal debug (Rafael
   Wysocki).

 - Rename __thermal_zone_set_trips() to thermal_zone_set_trips() and
   make it use trip thresholds (Rafael Wysocki).

 - Use READ_ONCE() for lockless access to trip temperature and
   hysteresis (Rafael Wysocki).

 - Drop unnecessary cooling device target state checks from the
   Bang-Bang thermal governor (Rafael Wysocki).

 - Avoid invoking thermal governor .trip_crossed() callback for critical
   and hot trip points (Rafael Wysocki).

 - Group all Renesas drivers inside a dedicated sub directory and add
   the missing dependency to OF (Niklas S=C3=B6derlund).

 - Add suspend/resume support on k3_j72xx_bandgap and take the
   opportunity to remove an unneeded delay in the init time code
   path (Th=C3=A9o Lebrun).

 - Fix thermal zone definition for MT8186 and MT8188 (Julien Panis).

 - Convert hisilicon-thermal.txt to dt-schema (Abdulrasaq Lawani).

 - Add DT bindings for the X1E80100 temperature sensor (Abel Vesa).

 - Fix the thermal zone node name regular expression in the DT schema
   (Krzysztof Kozlowski).

 - Avoid failing thermal control initialization by using default values
   on some platforms where calibration data is missing  (Chen-Yu Tsai).

 - Fix the sensor cell size in DT for the Exynos platform (Krzysztof
   Kozlowski).

 - Bring the common definition of '#thermal-sensor-cells' property in
   order to simplify the bindings on all the platforms where this
   change makes sense and do some minor cleanups (Krzysztof Kozlowski).

 - Fix a race between removal and clock disable in the broadcom thermal
   driver (Krzysztof Kozlowski).

 - Drop 'trips' DT node as required from the thermal zone bindings in
   order to fix the remaining warnings appearing for thermal zones
   without trip points (Rob Herring).

 - Simplify all the drivers where dev_err_probe() can apply (Krzysztof
   Kozlowski).

 - Clean up code related to stih416 as this platform is not described
   anywhere (Raphael Gallais-Pou).

Thanks!


---------------

Abdulrasaq Lawani (1):
      dt-bindings: thermal: convert hisilicon-thermal.txt to dt-schema

Abel Vesa (1):
      dt-bindings: thermal: qcom-tsens: Document the X1E80100 Temperature S=
ensor

Chen-Yu Tsai (1):
      thermal/drivers/mediatek/lvts_thermal: Provide default calibration da=
ta

Dr. David Alan Gilbert (1):
      thermal: int3403: remove unused struct 'int3403_performance_state'

Erick Archer (1):
      thermal: int3400: Use sizeof(*pointer) instead of sizeof(type)

Julien Panis (2):
      dt-bindings: thermal: mediatek: Fix thermal zone definition for MT818=
6
      dt-bindings: thermal: mediatek: Fix thermal zone definitions for MT81=
88

Krzysztof Kozlowski (36):
      thermal: core: constify 'type' in
devm_thermal_of_cooling_device_register()
      dt-bindings: thermal: correct thermal zone node name limit
      dt-bindings: thermal: samsung,exynos: specify cells
      dt-bindings: thermal: amlogic: reference thermal-sensor schema
      dt-bindings: thermal: allwinner,sun8i-a83t-ths: reference
thermal-sensor schema
      dt-bindings: thermal: brcm,avs-ro: reference thermal-sensor schema
      dt-bindings: thermal: generic-adc: reference thermal-sensor schema
      dt-bindings: thermal: imx8mm: reference thermal-sensor schema
      dt-bindings: thermal: nvidia,tegra186-bpmp: reference
thermal-sensor schema
      dt-bindings: thermal: nvidia,tegra30-tsensor: reference
thermal-sensor schema
      dt-bindings: thermal: qcom-spmi-adc-tm-hc: reference thermal-sensor s=
chema
      dt-bindings: thermal: qcom-spmi-adc-tm5: reference thermal-sensor sch=
ema
      dt-bindings: thermal: qcom-tsens: reference thermal-sensor schema
      dt-bindings: thermal: rcar-gen3: reference thermal-sensor schema
      dt-bindings: thermal: rockchip: reference thermal-sensor schema
      dt-bindings: thermal: rzg2l: reference thermal-sensor schema
      dt-bindings: thermal: socionext,uniphier: reference thermal-sensor sc=
hema
      dt-bindings: thermal: sprd: reference thermal-sensor schema
      dt-bindings: thermal: st,stm32: reference thermal-sensor schema
      dt-bindings: thermal: ti,am654: reference thermal-sensor schema
      dt-bindings: thermal: ti,j72xx: reference thermal-sensor schema
      dt-bindings: thermal: simplify few bindings
      dt-bindings: thermal: cleanup examples indentation
      dt-bindings: thermal: qoriq: reference thermal-sensor schema
      thermal/drivers/broadcom: Fix race between removal and clock disable
      thermal/drivers/broadcom: Simplify probe() with local dev variable
      thermal/drivers/broadcom: Simplify with dev_err_probe()
      thermal/drivers/exynos: Simplify probe() with local dev variable
      thermal/drivers/exynos: Simplify with dev_err_probe()
      thermal/drivers/hisi: Simplify with dev_err_probe()
      thermal/drivers/imx: Simplify probe() with local dev variable
      thermal/drivers/imx: Simplify with dev_err_probe()
      thermal/drivers/qcom-spmi-adc-tm5: Simplify with dev_err_probe()
      thermal/drivers/qcom-tsens: Simplify with dev_err_probe()
      thermal/drivers/generic-adc: Simplify probe() with local dev variable
      thermal/drivers/generic-adc: Simplify with dev_err_probe()

Niklas S=C3=B6derlund (2):
      thermal/drivers/renesas: Group all renesas thermal drivers together
      thermal/drivers/renesas/rcar: Add dependency on OF

Rafael J. Wysocki (21):
      thermal/debugfs: Use helper to update trip point overstepping duratio=
n
      thermal/debugfs: Do not extend mitigation episodes beyond system resu=
me
      thermal/debugfs: Print mitigation timestamp value in milliseconds
      thermal/debugfs: Fix up units in "mitigations" files
      thermal/debugfs: Adjust check for trips without statistics in
tze_seq_show()
      thermal/debugfs: Compute maximum temperature for mitigation
episode as a whole
      thermal/debugfs: Move some statements from under thermal_dbg->lock
      thermal: trip: Use common set of trip type names
      thermal: trip: Rename __thermal_zone_set_trips() to
thermal_zone_set_trips()
      thermal: trip: Make thermal_zone_set_trips() use trip thresholds
      thermal: trip: Use READ_ONCE() for lockless access to trip properties
      thermal: gov_bang_bang: Drop unnecessary cooling device target
state checks
      thermal: core: Avoid calling .trip_crossed() for critical and hot tri=
ps
      thermal: uniphier: Use thermal_zone_for_each_trip() for walking
trip points
      thermal: core: Change passive_delay and polling_delay data type
      thermal: helpers: Introduce thermal_trip_is_bound_to_cdev()
      thermal: trip: Add conversion macros for thermal trip priv field
      thermal: imx: Drop critical trip check from imx_set_trip_temp()
      thermal: trip: Pass trip pointer to .set_trip_temp() thermal zone cal=
lback
      thermal: trip: Fold __thermal_zone_get_trip() into its caller
      thermal: core: Add sanity checks for polling_delay and passive_delay

Raphael Gallais-Pou (1):
      thermal/drivers/sti: Cleanup code related to stih416

Ricardo Neri (2):
      thermal: intel: intel_tcc: Add model checks for temperature registers
      thermal: intel: intel_tcc_cooling: Use a model-specific bitmask
for TCC offset

Rob Herring (Arm) (1):
      dt-bindings: thermal: Drop 'trips' node as required

Srinivas Pandruvada (6):
      thermal: intel: int340x: Cleanup of DLVR sysfs on driver remove
      thermal: intel: int340x: Capability to map user space to firmware val=
ues
      thermal: intel: int340x: Add DLVR support for Lunar Lake
      thermal: intel: int340x: Remove unnecessary calls to free irq
      thermal: intel: int340x: Support MSI interrupt for Lunar Lake
      thermal: intel: int340x: Enable WLT and power floor support for Lunar=
 Lake

Th=C3=A9o Lebrun (1):
      thermal/drivers/k3_j72xx_bandgap: Implement suspend/resume support

Tony Luck (2):
      thermal: intel: intel_tcc_cooling: Switch to new Intel CPU model defi=
nes
      thermal: intel: intel_soc_dts_thermal: Switch to new Intel CPU
model defines

Zhang Rui (2):
      thermal: intel: intel_pch: Improve cooling log
      thermal: intel: hfi: Give HFI instances package scope

---------------

 .../bindings/thermal/allwinner,sun8i-a83t-ths.yaml |   6 +-
 .../bindings/thermal/amlogic,thermal.yaml          |  22 +--
 .../bindings/thermal/brcm,avs-ro-thermal.yaml      |  24 +--
 .../devicetree/bindings/thermal/brcm,avs-tmon.yaml |  17 +-
 .../bindings/thermal/brcm,bcm2835-thermal.yaml     |   1 -
 .../bindings/thermal/fsl,scu-thermal.yaml          |   1 -
 .../bindings/thermal/generic-adc-thermal.yaml      |   5 +-
 .../bindings/thermal/hisilicon,tsensor.yaml        |  57 +++++++
 .../bindings/thermal/hisilicon-thermal.txt         |  32 ----
 .../bindings/thermal/imx8mm-thermal.yaml           |   5 +-
 .../bindings/thermal/loongson,ls2k-thermal.yaml    |   1 -
 .../bindings/thermal/mediatek,lvts-thermal.yaml    |   1 -
 .../bindings/thermal/nvidia,tegra124-soctherm.yaml |   1 -
 .../thermal/nvidia,tegra186-bpmp-thermal.yaml      |  12 +-
 .../bindings/thermal/nvidia,tegra30-tsensor.yaml   |   9 +-
 .../bindings/thermal/qcom,spmi-temp-alarm.yaml     |   1 -
 .../bindings/thermal/qcom-spmi-adc-tm-hc.yaml      |   8 +-
 .../bindings/thermal/qcom-spmi-adc-tm5.yaml        |   8 +-
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |  97 ++++++-----
 .../devicetree/bindings/thermal/qoriq-thermal.yaml |   5 +-
 .../bindings/thermal/rcar-gen3-thermal.yaml        |  71 +++++----
 .../devicetree/bindings/thermal/rcar-thermal.yaml  |  64 ++++----
 .../bindings/thermal/rockchip-thermal.yaml         |   5 +-
 .../devicetree/bindings/thermal/rzg2l-thermal.yaml |  43 ++---
 .../bindings/thermal/samsung,exynos-thermal.yaml   |   3 +-
 .../thermal/socionext,uniphier-thermal.yaml        |   5 +-
 .../devicetree/bindings/thermal/sprd-thermal.yaml  |  49 +++---
 .../bindings/thermal/st,stm32-thermal.yaml         |   5 +-
 .../devicetree/bindings/thermal/thermal-zones.yaml |   6 +-
 .../bindings/thermal/ti,am654-thermal.yaml         |  15 +-
 .../bindings/thermal/ti,j72xx-thermal.yaml         |   5 +-
 MAINTAINERS                                        |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c        |   2 +-
 drivers/thermal/Kconfig                            |  28 +---
 drivers/thermal/Makefile                           |   4 +-
 drivers/thermal/broadcom/bcm2835_thermal.c         |  49 ++----
 drivers/thermal/gov_bang_bang.c                    |  14 +-
 drivers/thermal/hisi_thermal.c                     |   9 +-
 drivers/thermal/imx_thermal.c                      |  55 +++----
 .../intel/int340x_thermal/int3400_thermal.c        |   2 +-
 .../intel/int340x_thermal/int3403_thermal.c        |  11 --
 .../intel/int340x_thermal/int340x_thermal_zone.c   |  22 +--
 .../int340x_thermal/processor_thermal_device.c     |   3 +-
 .../int340x_thermal/processor_thermal_device.h     |   1 +
 .../int340x_thermal/processor_thermal_device_pci.c | 118 +++++++++++---
 .../intel/int340x_thermal/processor_thermal_rfim.c | 113 ++++++++++++-
 drivers/thermal/intel/intel_hfi.c                  |  30 ++--
 drivers/thermal/intel/intel_pch_thermal.c          |   5 +
 drivers/thermal/intel/intel_quark_dts_thermal.c    |  28 +++-
 drivers/thermal/intel/intel_soc_dts_iosf.c         |  15 +-
 drivers/thermal/intel/intel_soc_dts_thermal.c      |   2 +-
 drivers/thermal/intel/intel_tcc.c                  | 177 +++++++++++++++++=
+++-
 drivers/thermal/intel/intel_tcc_cooling.c          |  32 ++--
 drivers/thermal/intel/x86_pkg_temp_thermal.c       |   9 +-
 drivers/thermal/k3_j72xx_bandgap.c                 | 111 +++++++++----
 drivers/thermal/mediatek/lvts_thermal.c            |  46 ++++--
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c           |   9 +-
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c        |  10 +-
 drivers/thermal/qcom/tsens.c                       |   8 +-
 drivers/thermal/renesas/Kconfig                    |  28 ++++
 drivers/thermal/renesas/Makefile                   |   5 +
 drivers/thermal/{ =3D> renesas}/rcar_gen3_thermal.c  |   2 +-
 drivers/thermal/{ =3D> renesas}/rcar_thermal.c       |   2 +-
 drivers/thermal/{ =3D> renesas}/rzg2l_thermal.c      |   2 +-
 drivers/thermal/samsung/exynos_tmu.c               |  54 +++----
 drivers/thermal/st/st_thermal_memmap.c             |  10 --
 drivers/thermal/tegra/soctherm.c                   |  15 +-
 drivers/thermal/thermal-generic-adc.c              |  27 ++--
 drivers/thermal/thermal_core.c                     |  21 ++-
 drivers/thermal/thermal_core.h                     |   4 +-
 drivers/thermal/thermal_debugfs.c                  | 110 ++++++++-----
 drivers/thermal/thermal_debugfs.h                  |   2 +
 drivers/thermal/thermal_helpers.c                  |  47 ++++--
 drivers/thermal/thermal_sysfs.c                    |  21 +--
 drivers/thermal/thermal_trip.c                     |  53 +++---
 drivers/thermal/uniphier_thermal.c                 |  39 +++--
 .../dt-bindings/thermal/mediatek,lvts-thermal.h    |  12 +-
 include/linux/intel_tcc.h                          |   1 +
 include/linux/platform_data/x86/soc.h              |  12 +-
 include/linux/thermal.h                            |  18 ++-
 80 files changed, 1207 insertions(+), 779 deletions(-)

