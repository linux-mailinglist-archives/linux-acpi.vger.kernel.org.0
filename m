Return-Path: <linux-acpi+bounces-17418-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8868DBA9B99
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 16:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB2161891F1D
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 14:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215DD302CB7;
	Mon, 29 Sep 2025 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyfRsIAf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DD5302170
	for <linux-acpi@vger.kernel.org>; Mon, 29 Sep 2025 14:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759157858; cv=none; b=T/IGwecJlxyPf+sfza8nIN5V4ZWfnn4P34+X+NwuNW/SpbMRW2HqaTj3qfQfX6CbCCbuA/5fBWBFmMur06x8iiLbYTQ2evcf3ubzewQMKq7+7x4U11gU1ZhpK+tSPJI3Q4jqg1p9sszvmw39Z9zLCWSgly+pIirZseyQKND5XNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759157858; c=relaxed/simple;
	bh=JJhxQiedYInT20UrAtPJukF4RB4xd6RqlKV3pbgn5Hs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=D4PhZKlXBDUuCafDxNNVxp0P9RXiiC0QPBarXiNe3EoflgqlGzlefnsJaTdvQZ8ij5QfbXwaOqvzKDPhEC6StnRK6P1Sh0CyjmPpANftUamd6/bSOWJukrQCFSkCyICdzMgld9My9YBKR3QrQ5F+r5GyFOhcSpkuQyC3VLWgyug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyfRsIAf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB12C4CEF7
	for <linux-acpi@vger.kernel.org>; Mon, 29 Sep 2025 14:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759157857;
	bh=JJhxQiedYInT20UrAtPJukF4RB4xd6RqlKV3pbgn5Hs=;
	h=From:Date:Subject:To:Cc:From;
	b=TyfRsIAfcUUzyMNIApiO69WB4TNhS6c96vV6xOW92WvpOZOs1w5UOHgeNKIjqk3JW
	 lZ+hJOQpuR6zqNTA8FCNjJk1UhN2W3otT+c68yy06Qdadb3DKR9hdf5y7IhakeHhIW
	 JsbFdnTptcyaN67wbfzoffjrad+Hn+7nTAMGMPFb3EKybxt3vZbsStbsYVDsupkKQ2
	 Ptmx8Gx0GtKX46rn4Ifk5f5WS9RWsKkVJvMaIbAJfkjfABcuej7A4QZ/bWuCRzQSUB
	 R7O+gwYz7Kdn7XFhSx7jGaZN28bhiXy/vE/i6M3Y3vgEBWot8RpWRXqxnGYKBvgmQz
	 +Mko0Cf6MieaA==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-30cce892b7dso2892750fac.1
        for <linux-acpi@vger.kernel.org>; Mon, 29 Sep 2025 07:57:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXJdYlku3xvx9grm13yQbbOgbNAKHj0ZPjoQXovvjqrE6WbploWhtqw4WgpiPuE18okMUVIun1+eiOr@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyvuje//LiRjau/xym8D+qFcrlW4GfpMBAqIymk0tJQ3NUHpPu
	f88exMv40Z36Yh2p2mdT7tSS1zRY9HMBBIF9bCtol2LVt+RVJ5eIkxESS6O7+lAnVYoXNfy8Wct
	QzA1kYD8CZghm7GrM4IGh7Qnf/aCH3jo=
X-Google-Smtp-Source: AGHT+IFBCHOoiww/1oXN+bc9K6V6QMm+c1RxDOVHlQ/gfL7ms+95mOmbmciPTMkEx5haaQt4QDWm366l3DMmlhOYMhs=
X-Received: by 2002:a05:6870:a79f:b0:2ff:a27f:9c67 with SMTP id
 586e51a60fabf-35ee91f95f8mr8877983fac.30.1759157856882; Mon, 29 Sep 2025
 07:57:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 29 Sep 2025 16:57:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0joS1VAnZ=hKtf2cx51XGNeMkqnJwq1GX-W58k_FQy39A@mail.gmail.com>
X-Gm-Features: AS18NWCOnimc8tkP0qAX9BLmQa1vEDXjdbE3Ov5ZzKGesQ6fhI98m1ODcBNYhUo
Message-ID: <CAJZ5v0joS1VAnZ=hKtf2cx51XGNeMkqnJwq1GX-W58k_FQy39A@mail.gmail.com>
Subject: [GIT PULL] Thermal control updates for v6.18-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.18-rc1

with top-most commit 2085f0f4697234a0f59ed718d0e72f38688210e0

 Merge tag 'thermal-v6.18-rc1-2' of
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux

on top of commit b320789d6883cc00ac78ce83bccbfe7ed58afcf0

 Linux 6.17-rc4

to receive thermal control updates for 6.18-rc1.

These are mostly thermal driver updates, including new thermal drivers
for Renesas RZ/G3S and Renesas RZ/G3E SoCs, a new power slider platform
feature support in the Intel int340x thermal driver, a new Tegra114-
specific SOCTHERM driver and more.

There is also a Step-wise thermal governor update allowing it to start
reducing cooling somewhat earlier if the temperature of the given
thermal zone is falling down and a thermal testing code cleanup.

Specifics:

 - Add new thermal driver for the Renesas RZ/G3S SoC (Claudiu Beznea)

 - Add new thermal driver for the Renesas RZ/G3E SoC (John Madieu)

 - Add support for new platform power slider feature to the Intel
   int340x driver (Srinivas Pandruvada).

 - Add new Tegra114-specific SOCTHERM driver and document Tegra114
   SOCTHERM Thermal Management System in DT bindings (Svyatoslav Ryhel)

 - Add temperature sensor channel to thermal-generic-adc (Svyatoslav
   Ryhel)

 - Add support for per-SoC default trim values to the Renesas rcar_gen3
   thermal driver, use it for adding R-Car V4H default trim values, fix
   a comment typo in that driver and document Gen4 support in its
   Kconfig entry (Marek Vasut)

 - Fix mapping SoCs to generic Gen4 entry in the Renesas rcar_gen3
   thermal driver (Wolfram Sang)

 - Document the TSU unit in the r9a08g045-tsu and r9a09g047-tsu DT
   bindings (Claudiu Beznea, John Madieu)

 - Make LMH select QCOM_SCM and add missing IRQ includes to the
   qcom/lmh thermal driver (Dmitry Baryshkov)

 - Fix incorrect error message in the qcom/lmh thermal driver (Sumeet
   Pawnikar)

 - Add QCS615 compatible to tsens thermal DT bindings (Gaurav Kohli)

 - Document the Glymur temperature sensor in qcom-tsens thermal DT
   bindings (Manaf Meethalavalappu Pallikunhi)

 - Make k3_j72xx_bandgap thermal driver register the thermal sensor
   with hwmon (Michael Walle)

 - Tighten GRF requirements in the rockchip thermal DT bindings,
   silence a GRF warning in the rockchip thermal driver and unify
   struct rockchip_tsadc_chip format in it (Sebastian Reichel)

 - Update the Step-wise thermal governor to allow it to reduce the
   cooling level earlier if thermal zone temperature is dropping
   and clean it up (Rafael Wysocki)

 - Clean up the thermal testing code (Rafael Wysocki)

 - Assorted cleanups of thermal drivers (Jiapeng Chong, Salah Triki,
   Osama Abdelkader)

Thanks!


---------------

Claudiu Beznea (2):
      dt-bindings: thermal: r9a08g045-tsu: Document the TSU unit
      thermal/drivers/renesas/rzg3s: Add thermal driver for the
Renesas RZ/G3S SoC

Dmitry Baryshkov (2):
      thermal/drivers/qcom: Make LMH select QCOM_SCM
      thermal/drivers/qcom/lmh: Add missing IRQ includes

Gaurav Kohli (1):
      dt-bindings: thermal: tsens: Add QCS615 compatible

Jiapeng Chong (1):
      thermal/drivers/mediatek/lvts_thermal: Remove unneeded semicolon

John Madieu (3):
      dt-bindings: thermal: r9a09g047-tsu: Document the TSU unit
      thermal/drivers/renesas/rzg3e: Add thermal driver for the
Renesas RZ/G3E SoC
      thermal/drivers/renesas/rzg3e: Fix add thermal driver for the
Renesas RZ/G3E SoC

Manaf Meethalavalappu Pallikunhi (1):
      dt-bindings: thermal: qcom-tsens: Document the Glymur temperature Sensor

Marek Vasut (4):
      thermal/drivers/rcar_gen3: Add support for per-SoC default trim values
      thermal/drivers/rcar_gen3: Add support for R-Car V4H default trim values
      thermal/drivers/rcar_gen3: Fix comment typo
      thermal/drivers/rcar_gen3: Document Gen4 support in Kconfig entry

Michael Walle (1):
      thermal/drivers/k3_j72xx_bandgap: Register sensors with hwmon

Osama Abdelkader (1):
      thermal: hwmon: replace deprecated strcpy() with strscpy()

Rafael J. Wysocki (4):
      thermal: gov_step_wise: Clean up local variable initialization
      thermal: gov_step_wise: Clarify cooling logic description comment
      thermal: gov_step_wise: Allow cooling level to be reduced earlier
      thermal: testing: Rearrange variable declarations involving __free()

Salah Triki (1):
      thermal: intel: int340x: Remove redundant acpi_has_method() call

Sebastian Reichel (3):
      thermal/drivers/rockchip: Unify struct rockchip_tsadc_chip format
      thermal/drivers/rockchip: Shut up GRF warning
      dt-bindings: thermal: rockchip: Tighten grf requirements

Srinivas Pandruvada (6):
      thermal: intel: int340x: Add support for power slider
      thermal: intel: int340x: Enable power slider interface for Panther Lake
      thermal: intel: int340x: Add module parameter for balanced Slider
      thermal: intel: int340x: Add module parameter to change slider offset
      thermal: intel: selftests: workload_hint: Mask unsupported types
      thermal: intel: int340x: Power Slider: Validate slider_balance range

Sumeet Pawnikar (1):
      drivers/thermal/qcom/lmh: Fix incorrect error message

Svyatoslav Ryhel (5):
      dt-bindings: thermal: Document Tegra114 SOCTHERM Thermal Management System
      thermal/drivers/tegra/soctherm-fuse: Prepare calibration for
Tegra114 support
      dt-bindings: thermal: add Tegra114 soctherm header
      thermal/drivers/tegra: Add Tegra114 specific SOCTHERM driver
      thermal/drivers/thermal-generic-adc: Add temperature sensor channel

Wolfram Sang (1):
      thermal/drivers/rcar_gen3: Fix mapping SoCs to generic Gen4 entry

---------------

 .../bindings/thermal/nvidia,tegra124-soctherm.yaml |   2 +
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   2 +
 .../bindings/thermal/renesas,r9a08g045-tsu.yaml    |  93 ++++
 .../bindings/thermal/renesas,r9a09g047-tsu.yaml    |  87 ++++
 .../bindings/thermal/rockchip-thermal.yaml         |  15 +
 MAINTAINERS                                        |  14 +
 drivers/thermal/gov_step_wise.c                    |  25 +-
 drivers/thermal/intel/int340x_thermal/Kconfig      |   1 +
 drivers/thermal/intel/int340x_thermal/Makefile     |   1 +
 .../intel/int340x_thermal/acpi_thermal_rel.c       |   3 -
 .../int340x_thermal/processor_thermal_device.c     |  20 +
 .../int340x_thermal/processor_thermal_device.h     |   6 +
 .../int340x_thermal/processor_thermal_device_pci.c |   3 +-
 .../int340x_thermal/processor_thermal_soc_slider.c | 284 +++++++++++
 drivers/thermal/k3_j72xx_bandgap.c                 |   4 +
 drivers/thermal/mediatek/lvts_thermal.c            |   2 +-
 drivers/thermal/qcom/Kconfig                       |   3 +-
 drivers/thermal/qcom/lmh.c                         |   4 +-
 drivers/thermal/renesas/Kconfig                    |  21 +-
 drivers/thermal/renesas/Makefile                   |   3 +
 drivers/thermal/renesas/rcar_gen3_thermal.c        |  63 ++-
 drivers/thermal/renesas/rzg3e_thermal.c            | 547 +++++++++++++++++++++
 drivers/thermal/renesas/rzg3s_thermal.c            | 272 ++++++++++
 drivers/thermal/rockchip_thermal.c                 |  50 +-
 drivers/thermal/tegra/Makefile                     |   1 +
 drivers/thermal/tegra/soctherm-fuse.c              |  18 +-
 drivers/thermal/tegra/soctherm.c                   |  13 +
 drivers/thermal/tegra/soctherm.h                   |  11 +-
 drivers/thermal/tegra/tegra114-soctherm.c          | 209 ++++++++
 drivers/thermal/tegra/tegra124-soctherm.c          |   4 +
 drivers/thermal/tegra/tegra132-soctherm.c          |   4 +
 drivers/thermal/tegra/tegra210-soctherm.c          |   4 +
 drivers/thermal/testing/zone.c                     |  31 +-
 drivers/thermal/thermal-generic-adc.c              |  55 ++-
 drivers/thermal/thermal_hwmon.c                    |   2 +-
 include/dt-bindings/thermal/tegra114-soctherm.h    |  19 +
 .../intel/workload_hint/workload_hint_test.c       |   2 +
 37 files changed, 1804 insertions(+), 94 deletions(-)

