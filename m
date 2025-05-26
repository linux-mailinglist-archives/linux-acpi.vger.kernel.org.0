Return-Path: <linux-acpi+bounces-13902-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6366BAC443E
	for <lists+linux-acpi@lfdr.de>; Mon, 26 May 2025 22:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785E3189093B
	for <lists+linux-acpi@lfdr.de>; Mon, 26 May 2025 20:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD2C1DF271;
	Mon, 26 May 2025 20:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8ytLS72"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE8D190057;
	Mon, 26 May 2025 20:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748290039; cv=none; b=CFOWwtn9M/Lz8ah93AGKceB7ZUucZXTG4NZhaz+oAgG49ZdcAxojnCBG4vw85+wUMaCo2JD1bdgsTXGODjJ/z8DXJ9U5DVS/F3FiuvS2EuHPKQ12VoRpkMzFpDqo4UhNT3g7CQ1W+pRTol/UKRPPlmLhNsFypKOquS6Fmul4cFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748290039; c=relaxed/simple;
	bh=2h8mPg8pHJTB2digswKPZ+FpqDcEtfuqo2Mv5MAMbP0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=TkOx+0Ru2HpnnXDJFEHP+gSzuaVRv/A920bfBut8T2HqwvVWobST0OxmzFMQMZhE7mDNy+DzJFt3XnPDZNATn7V3qahL8CUq/qjQ24r47XumIppV6nd/lILO48rcH9Lt/ZO6pJvKsXxBp9Y2UHgMT9B8kSGMgLWA81Vwc1z7p7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8ytLS72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A141FC4CEE7;
	Mon, 26 May 2025 20:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748290038;
	bh=2h8mPg8pHJTB2digswKPZ+FpqDcEtfuqo2Mv5MAMbP0=;
	h=From:Date:Subject:To:Cc:From;
	b=s8ytLS729MfLjxIuCS+/LBhRH10Oiyy9bQoo14u41Sp9VExdp2h/Utn1p+9qpYNV0
	 gJheQ6BWQ0MUtqZVZcI3Cc+jOe7dB9Cm8boVglKEOZ2uQ9SrIgcAB8/DuUaESvLmbd
	 kSQrXjm6rt3y+tA80vhzYiTCUuFXBxQvW24bEszmlDyng7NgLG/uyOM8GRfJ2G3Qos
	 IEO7bQV7fSC/gAvz5M4fEIBTFOd/bfAm5zZwAGselIrFCZmAbgz36gsiJEmtOudKGT
	 46vo39qaOPEb3vVMlqkn8+zvTD3k9ivr2y2/OvXFlZ5ZKg8OjQZIoYse8mEP+oeVtW
	 RXI8UD5RKUTYw==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-72c13802133so661519a34.3;
        Mon, 26 May 2025 13:07:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWWBB04AaaRsVEPSn7bq35rLD9G40PPk8JkDeng5l3LgY8uDN8L+HEPHYesQlJX49NUUGWr2IcsoN3ix0AL@vger.kernel.org, AJvYcCXblxSyerq0IHom/e8g7VjDAzTuRAEZ+8pl6JeOk6ExWbK8weTOhpsYun3rfcvvWHgLfCdn4KkBv83L@vger.kernel.org
X-Gm-Message-State: AOJu0YyGgiyKD8Fj1lJpy0dSsVpwOM64l7TYqX0cGRIv8gtmwkdwBTwK
	/GumdUyiLOl/jfmSEOV+II0p0lHArOAEeHP8S4neEiQ5ithDz4pEefDM+lwzVFeuaOLeDVPpW6G
	lyrnGaFBDQ09VifmwbIlv1DYjY9uG1lQ=
X-Google-Smtp-Source: AGHT+IHad05Czm30ecZhI1PmmIVVV3vLG5n5Oyv3ZSa+MpbPBktoK355NfbVfvqVevxCk0gwirMXcP87p8qC6gUgMEc=
X-Received: by 2002:a05:6808:3191:b0:404:b5c6:46f3 with SMTP id
 5614622812f47-406467fff88mr6662350b6e.21.1748290037958; Mon, 26 May 2025
 13:07:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 26 May 2025 22:07:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jtbcDUaMcTrnG7ewHmuMG2YUwe4ho1LUg-v9TrwLybLA@mail.gmail.com>
X-Gm-Features: AX0GCFvmqkqGvP8_niqkJH1vWH5nPYbxY_IgeaKZL4rcdf03WXjM3sKvqq3y2cs
Message-ID: <CAJZ5v0jtbcDUaMcTrnG7ewHmuMG2YUwe4ho1LUg-v9TrwLybLA@mail.gmail.com>
Subject: [GIT PULL] Thermal control updates for v6.16-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.16-rc1

with top-most commit 01daf71a4f57062055f68f8163ed1ad88fb47990

 thermal: qcom: ipq5018: make ops_ipq5018 struct static

on top of commit 82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3

 Linux 6.15-rc6

to receive thermal control updates for 6.16-rc1.

These add support for a new feature, Platform Temperature Control (PTC),
to the Intel int340x thermal driver, add support for the Airoha EN7581
thermal sensor and the IPQ5018 platform, fix up the ACPI thermal zones
handling, fix other assorted issues and clean up code.

Specifics:

 - Add Platform Temperature Control (PTC) support to the Intel int340x
   thermal driver (Srinivas Pandruvada).

 - Make the Hisilicon thermal driver compile by default when ARCH_HISI
   is set (Krzysztof Kozlowski).

 - Clean up printk() format by using %pC instead of %pCn in the bcm2835
   thermal driver (Luca Ceresoli).

 - Fix variable name coding style in the AmLogic thermal driver (Enrique
   Isidoro Vazquez Ramos).

 - Fix missing debugfs entry removal on failure by using the devm_
   variant in the LVTS thermal driver (AngeloGioacchino Del Regno).

 - Remove the unused lvts_debugfs_exit() function as the devm_ variant
   introduced before takes care of removing the debugfs entry in the
   LVTS driver (Arnd Bergmann).

 - Add the Airoha EN7581 thermal sensor support along with its DT
   bindings (Christian Marangi).

 - Add ipq5018 compatible string DT binding, cleanup and add its support
   to the QCom Tsens thermal driver (Sricharan Ramabadhran, George
   Moussalem).

 - Fix comments typos in the Airoha driver (Christian Marangi, Colin Ian
   King).

 - Address a sparse warning by making a local variable static in the
   QCom thermal driver (George Moussalem).

 - Fix the usage of the _SCP control method in the driver for ACPI
   thermal zones (Armin Wolf).

Thanks!


---------------

AngeloGioacchino Del Regno (1):
      thermal/drivers/mediatek/lvts: Fix debugfs unregister on failure

Armin Wolf (2):
      ACPI: OSI: Stop advertising support for "3.0 _SCP Extensions"
      ACPI: thermal: Execute _SCP before reading trip points

Arnd Bergmann (1):
      thermal/drivers/mediatek/lvts: Remove unused lvts_debugfs_exit

Christian Marangi (3):
      dt-bindings: thermal: Add support for Airoha EN7581 thermal sensor
      thermal/drivers: Add support for Airoha EN7581 thermal sensor
      thermal/drivers/airoha: Fix spelling mistake

Colin Ian King (1):
      thermal/drivers/airoha: Fix spelling mistake "calibrarion" ->
"calibration"

Enrique Isidoro Vazquez Ramos (1):
      thermal/drivers/amlogic: Rename Uptat to uptat to follow kernel
coding style

George Moussalem (3):
      thermal/drivers/qcom/tsens: Update conditions to strictly
evaluate for IP v2+
      thermal/drivers/qcom/tsens: Add support for tsens v1 without RPM
      thermal: qcom: ipq5018: make ops_ipq5018 struct static

Krzysztof Kozlowski (1):
      thermal/drivers/hisi: Do not enable by default during compile testing

Luca Ceresoli (2):
      thermal/drivers/bcm2835: Use %pC instead of %pCn
      vsprintf: remove redundant and unused %pCn format specifier

Sricharan Ramabadhran (2):
      dt-bindings: thermal: qcom-tsens: Add ipq5018 compatible
      thermal/drivers/qcom/tsens: Add support for IPQ5018 tsens

Srinivas Pandruvada (3):
      thermal: intel: int340x: Add platform temperature control interface
      thermal: intel: int340x: Enable platform temperature control
      thermal: int340x: processor_thermal: Platform temperature
control documentation

---------------

 Documentation/core-api/printk-formats.rst          |   3 +-
 .../bindings/thermal/airoha,en7581-thermal.yaml    |  48 ++
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   2 +
 Documentation/driver-api/thermal/intel_dptf.rst    |  21 +
 .../translations/zh_CN/core-api/printk-formats.rst |   3 +-
 drivers/acpi/osi.c                                 |   1 -
 drivers/acpi/thermal.c                             |  10 +-
 drivers/thermal/Kconfig                            |  11 +-
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/airoha_thermal.c                   | 489 +++++++++++++++++++++
 drivers/thermal/amlogic_thermal.c                  |  16 +-
 drivers/thermal/broadcom/bcm2835_thermal.c         |   2 +-
 drivers/thermal/intel/int340x_thermal/Makefile     |   1 +
 .../int340x_thermal/platform_temperature_control.c | 243 ++++++++++
 .../int340x_thermal/processor_thermal_device.c     |  15 +-
 .../int340x_thermal/processor_thermal_device.h     |   3 +
 .../int340x_thermal/processor_thermal_device_pci.c |   5 +-
 drivers/thermal/mediatek/lvts_thermal.c            |  18 +-
 drivers/thermal/qcom/tsens-v1.c                    |  62 +++
 drivers/thermal/qcom/tsens.c                       |  27 +-
 drivers/thermal/qcom/tsens.h                       |   4 +
 lib/vsprintf.c                                     |  10 +-
 22 files changed, 946 insertions(+), 49 deletions(-)

