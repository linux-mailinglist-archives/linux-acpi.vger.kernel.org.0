Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 483721FE91
	for <lists+linux-acpi@lfdr.de>; Thu, 16 May 2019 06:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfEPEnT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 May 2019 00:43:19 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:38857 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfEPEnT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 16 May 2019 00:43:19 -0400
Received: by mail-pg1-f182.google.com with SMTP id j26so904310pgl.5;
        Wed, 15 May 2019 21:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=wN34173xpf/6mtqZSpgPuozTnCy2fGMnh6ji7J9ET1Y=;
        b=TKQjb330FOL2RQf5vMjT20pzorPLk8Tb5+r7NPZUjOrWakRLrilk9dQ31QT3Ergn4k
         Gd7t8AzO0ybrgTwDZhLtwNYqTOs1CWoRxqjiOcdSTFSfAuW3iJ9QQN2gyZKxPD+6CsYb
         dsjruKZmxbLM5v0c70ICed4S+eDc5xSZ6AL+V1nBflKzyr9SjLHJU+KSuHIEuWBjc5Vm
         /qKEHIVY5FAuRI26uMfz2uuzI6Z6LesFBvdtRCGW28PF96GcVGrSXwG878RMQW0kha8u
         LRogtxpRXh18aDOFBJbISXqqAqT96eUz4k59s4nYcnFnT+8yBYvNpsyoqboJVAo4By1A
         rjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wN34173xpf/6mtqZSpgPuozTnCy2fGMnh6ji7J9ET1Y=;
        b=SNR4UfrY8wZBHsdCUCATqZOzIB+lMBPvXoj2qE1/u+2ohioHu4+DQw+3Zo8GhGPROY
         pzPEAXlGGzEk3+VoMwxUjBeZYjS+P8ivOYB5/9TMALABqyb6Cd2AN79MkQVoa7NHzTiK
         LNF0KrcFJVsGqIb2Nlhn/Svs06FFDBdLfubGz8XL+wpSmyyXYane6b6SY0t7+we5x/PY
         pZrIWvCYnE2NgKjtghx0BruEhi1+zKoyzHZhu873fgG3+at8BfQRJSJ7Pm2IUvsKZOSw
         +qhW+tu6VetP0aA2qVYk98nRitzOC9Ex/OXTelG8d+5+GhOfsbCxP0qFlW/eW60ys79V
         3xPw==
X-Gm-Message-State: APjAAAVCrvaIGecjBMXyHYr5pFXhodHALl7JVGbSkggGIBF31s8OmCrn
        gwFlh06VBsDMoYSRsOOXhjU=
X-Google-Smtp-Source: APXvYqzhON08IhcpMOKp1b2wceuN+XNO7KkXMqXPwgiIfpSN4oRcNwitGNgmg3zRaosphPjylxR/yA==
X-Received: by 2002:a65:5c8c:: with SMTP id a12mr48030291pgt.452.1557981798080;
        Wed, 15 May 2019 21:43:18 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id l23sm3905562pgh.68.2019.05.15.21.43.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 21:43:16 -0700 (PDT)
Date:   Wed, 15 May 2019 21:43:14 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rui Zhang <rui.zhang@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Thermal-SoC management changes for v5.2-rc1
Message-ID: <20190516044313.GA17751@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello Linus,

Please consider the following thermal soc changes for v5.2-rc1.

The following changes since commit 37624b58542fb9f2d9a70e6ea006ef8a5f66c30b:

  Linux 5.1-rc7 (2019-04-28 17:04:13 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal linus

for you to fetch changes up to 37bcec5d9f71bd13142a97d2196b293c9ac23823:

  hwmon: (pwm-fan) Use devm_thermal_of_cooling_device_register (2019-05-14 07:00:47 -0700)

Specifics:
- thermal core has a new devm_* API for registering cooling devices, thanks to Guenter R.
  I took the entire series, that is why you see changes on drivers/hwmon in this pull.
- rockchip thermal driver gains support to PX30 SoC, thanks to Elaine Z.
- the generic-adc thermal driver now considers the lookup table DT property as optional,
  thanks to Jean-Francois D.
- Refactoring of tsens thermal driver, thanks to Amit K.
- Cleanups on cpu cooling driver, thanks to Daniel L.
- broadcom thermal driver dropped support to ACPI, thanks to Srinath M.
- tegra thermal driver gains support to OC hw throttle and GPU throtle, thanks to Wei Ni.
- Fixes in several thermal drivers.

BR,

Eduardo Valentin

----------------------------------------------------------------
Amit Kucheria (21):
      drivers: thermal: tsens: Document the data structures
      drivers: thermal: tsens: Rename tsens_data
      drivers: thermal: tsens: Rename tsens_device
      drivers: thermal: tsens: Rename variable tmdev
      drivers: thermal: tsens: Use consistent names for variables
      drivers: thermal: tsens: Function prototypes should have argument names
      drivers: thermal: tsens: Rename tsens-8916 to prepare to merge with tsens-8974
      drivers: thermal: tsens: Rename constants to prepare to merge with tsens-8974
      drivers: thermal: tsens: Merge tsens-8974 into tsens-v0_1
      drivers: thermal: tsens: Introduce reg_fields to deal with register description
      drivers: thermal: tsens: Save reference to the device pointer and use it
      drivers: thermal: tsens: Don't print error message on -EPROBE_DEFER
      drivers: thermal: tsens: Add new operation to check if a sensor is enabled
      drivers: thermal: tsens: change data type for sensor IDs
      drivers: thermal: tsens: Introduce IP-specific max_sensor count
      drivers: thermal: tsens: simplify get_temp_tsens_v2 routine
      drivers: thermal: tsens: Move get_temp_tsens_v2 to allow sharing
      drivers: thermal: tsens: Common get_temp() learns to do ADC conversion
      dt: thermal: tsens: Add bindings for qcs404
      drivers: thermal: tsens: Add generic support for TSENS v1 IP
      drivers: thermal: tsens: Move calibration constants to header file

Andrey Smirnov (1):
      thermal: qoriq: Remove unnecessary DT node is NULL check

Daniel Lezcano (4):
      thermal/drivers/cpu_cooling: Remove pointless test in power2state()
      thermal/drivers/cpu_cooling: Fixup the header and copyright
      thermal/drivers/cpu_cooling: Add Software Package Data Exchange (SPDX)
      thermal/drivers/cpu_cooling: Remove pointless field

Elaine Zhang (3):
      thermal: rockchip: fix up the tsadc pinctrl setting error
      dt-bindings: rockchip-thermal: Support the PX30 SoC compatible
      thermal: rockchip: Support the PX30 SoC in thermal driver

Enrico Weigelt, metux IT consult (1):
      drivers: thermal: Kconfig: pedantic cleanups

Guenter Roeck (6):
      thermal: Introduce devm_thermal_of_cooling_device_register
      hwmon: (aspeed-pwm-tacho) Use devm_thermal_of_cooling_device_register
      hwmon: (gpio-fan) Use devm_thermal_of_cooling_device_register
      hwmon: (mlxreg-fan) Use devm_thermal_of_cooling_device_register
      hwmon: (npcm750-pwm-fan) Use devm_thermal_of_cooling_device_register
      hwmon: (pwm-fan) Use devm_thermal_of_cooling_device_register

Hoan Nguyen An (1):
      thermal: rcar_gen3_thermal: Fix init value of IRQCTL register

Jean-Francois Dagenais (2):
      thermal: generic-adc: make lookup table optional
      dt-bindings: thermal: generic-adc: make lookup-table optional

Jiada Wang (3):
      thermal: rcar_gen3_thermal: fix interrupt type
      thermal: rcar_gen3_thermal: disable interrupt in .remove
      thermal: rcar_gen3_thermal: Fix to show correct trip points number

Matthias Kaehlcke (1):
      thermal: cpu_cooling: Actually trace CPU load in thermal_power_cpu_get_power

Srinath Mannam (1):
      thermal: broadcom: Remove ACPI support

Talel Shenhar (3):
      dt-bindings: thermal: al-thermal: Add binding documentation
      thermal: Introduce Amazon's Annapurna Labs Thermal Driver
      thermal: Fix build error of missing devm_ioremap_resource on UM

Wei Ni (9):
      of: Add bindings of thermtrip for Tegra soctherm
      thermal: tegra: support hw and sw shutdown
      of: Add bindings of gpu hw throttle for Tegra soctherm
      thermal: tegra: add support for gpu hw-throttle
      thermal: tegra: add support for thermal IRQ
      thermal: tegra: add set_trips functionality
      thermal: tegra: add support for EDP IRQ
      of: Add bindings of OC hw throttle for Tegra soctherm
      thermal: tegra: enable OC hw throttle

Wolfram Sang (1):
      thermal: stm32: simplify getting .driver_data

Yangtao Li (1):
      of: thermal: Improve print information

Yoshihiro Kaneko (1):
      thermal: rcar_thermal: update calculation formula for R-Car Gen3 SoCs

 .../bindings/thermal/amazon,al-thermal.txt         |  33 +
 .../bindings/thermal/nvidia,tegra124-soctherm.txt  |  62 +-
 .../devicetree/bindings/thermal/qcom-tsens.txt     |  14 +
 .../bindings/thermal/rockchip-thermal.txt          |   1 +
 .../bindings/thermal/thermal-generic-adc.txt       |  10 +-
 MAINTAINERS                                        |   6 +
 drivers/hwmon/aspeed-pwm-tacho.c                   |   6 +-
 drivers/hwmon/gpio-fan.c                           |  25 +-
 drivers/hwmon/mlxreg-fan.c                         |  31 +-
 drivers/hwmon/npcm750-pwm-fan.c                    |   6 +-
 drivers/hwmon/pwm-fan.c                            |  73 +-
 drivers/thermal/Kconfig                            |  11 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/broadcom/sr-thermal.c              |   8 -
 drivers/thermal/cpu_cooling.c                      |  30 +-
 drivers/thermal/of-thermal.c                       |   3 +
 drivers/thermal/qcom/Makefile                      |   4 +-
 drivers/thermal/qcom/tsens-8916.c                  | 105 ---
 drivers/thermal/qcom/tsens-8960.c                  |  84 +-
 drivers/thermal/qcom/tsens-common.c                | 159 +++-
 .../thermal/qcom/{tsens-8974.c => tsens-v0_1.c}    | 166 +++-
 drivers/thermal/qcom/tsens-v1.c                    | 193 +++++
 drivers/thermal/qcom/tsens-v2.c                    | 111 +--
 drivers/thermal/qcom/tsens.c                       | 100 ++-
 drivers/thermal/qcom/tsens.h                       | 291 ++++++-
 drivers/thermal/qoriq_thermal.c                    |   5 -
 drivers/thermal/rcar_gen3_thermal.c                |  51 +-
 drivers/thermal/rcar_thermal.c                     |  11 +-
 drivers/thermal/rockchip_thermal.c                 |  74 +-
 drivers/thermal/st/Kconfig                         |  22 +-
 drivers/thermal/st/stm_thermal.c                   |   6 +-
 drivers/thermal/tegra/Kconfig                      |   4 +-
 drivers/thermal/tegra/soctherm.c                   | 961 +++++++++++++++++++--
 drivers/thermal/tegra/soctherm.h                   |  16 +
 drivers/thermal/tegra/tegra124-soctherm.c          |   7 +-
 drivers/thermal/tegra/tegra132-soctherm.c          |   7 +-
 drivers/thermal/tegra/tegra210-soctherm.c          |  15 +-
 drivers/thermal/thermal-generic-adc.c              |   9 +-
 drivers/thermal/thermal_core.c                     |  49 ++
 drivers/thermal/thermal_mmio.c                     | 129 +++
 include/dt-bindings/thermal/tegra124-soctherm.h    |   8 +-
 include/linux/thermal.h                            |  13 +
 42 files changed, 2330 insertions(+), 590 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/amazon,al-thermal.txt
 delete mode 100644 drivers/thermal/qcom/tsens-8916.c
 rename drivers/thermal/qcom/{tsens-8974.c => tsens-v0_1.c} (56%)
 create mode 100644 drivers/thermal/qcom/tsens-v1.c
 create mode 100644 drivers/thermal/thermal_mmio.c
