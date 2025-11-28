Return-Path: <linux-acpi+bounces-19360-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7895C931FB
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Nov 2025 21:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9DF3AC57D
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Nov 2025 20:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FE32D5920;
	Fri, 28 Nov 2025 20:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwvPrI4S"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D62285C98
	for <linux-acpi@vger.kernel.org>; Fri, 28 Nov 2025 20:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764362153; cv=none; b=lN4mrM7IsOjKXdhAx8VgkiLPnJjW2DiX2FFiYV0lM6Fc2hm5RcZby8Btd+yoK2bBwoYaAcA9SjDRO3UpRC8qD7wvqkrlPGG3sdZdKcCY3KCV/VgkIzBUzvZuxdbQiQaIORJ8wIFRiP9ZDbN7hdhis+kxd0Q8SOnigiStCzgLK+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764362153; c=relaxed/simple;
	bh=XDuXb8JEjNFqOvxtdlRXZohHzPIYYqzXPUW3ax+Pces=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rC8EX94N6LlGm9jmBE7iQuKe8vmVl/iorbqLCp2gcfo+0A4Bc0kRUUAjzSejnib8+XMzJCOmxZyGbkvJOT1hmdprrkheHXt4oaP+b2j6xfEJCSmeVDfOYHxEKr/6jc5J/3GP+NPRWigN7MU4Wi0m1ERPuSH/MaeW21Hdzx91AYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwvPrI4S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F5CC116C6
	for <linux-acpi@vger.kernel.org>; Fri, 28 Nov 2025 20:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764362153;
	bh=XDuXb8JEjNFqOvxtdlRXZohHzPIYYqzXPUW3ax+Pces=;
	h=From:Date:Subject:To:Cc:From;
	b=DwvPrI4SbmzHPYvcATe52vgBLPn02D0RGlifsrSjxtMHu+shKS+7KZurKtUHaIWJ0
	 6KSQA0w9wZEH9P8qOfApyYw6tk6UyaZZSXkn/Ob4yvtaP1PT8LsFnsRW+NnmDlYeLQ
	 qS4Fj5y/ha8oheh3XQOSCdRwYZJ+I8gQ+uh8Qck3G9aYWiDczuL+HDTxiL08F0BfaI
	 gepwQ8/C5mLgviQpALGkEisd/ZVxpotZzN7EqVLwkq/qkYdWQMNjSA8UqZ7kgOBZHt
	 SKi/lZ4dmwym5mwZv0/a5Bh5pqDJFGdFGgCWAmgjaOSBkTYy2x1zsxzVGt1GGnsbZB
	 Akd6Gf59u7Xgg==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6574ace76dbso833311eaf.3
        for <linux-acpi@vger.kernel.org>; Fri, 28 Nov 2025 12:35:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqOa9OD1n8lTDTfA1wMjfOBw2Vhhh76TxBgylDkC74kNmPKJVYe785JYETF7gFrqTfDnJBUESNWrhM@vger.kernel.org
X-Gm-Message-State: AOJu0YxpEfwHiaQWEXUCMvCzZxmnLRrETgIS0IMdKGTDqaKKBehGZb2Z
	Zb05dIU2pUtLkEGmzMRtEfFsrvDxMgnwUhCNpPO2ERrK6Bt8nzCbGpgneZLdwHXQ97pEiSwvjGJ
	pI+5xSITVu21MIGr86psuOFEWclwNG20=
X-Google-Smtp-Source: AGHT+IGbdLqaTBUGi4zgCm6syLPxXIVrwKpHpKju8+KNZoBpBSrPdllPG+wVJbMskQSGKWfB2h/M03QRuh6+AjLwhfA=
X-Received: by 2002:a05:6820:1ca2:b0:657:6746:cd0a with SMTP id
 006d021491bc7-65790b7e8bdmr9485843eaf.8.1764362152725; Fri, 28 Nov 2025
 12:35:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 28 Nov 2025 21:35:41 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iDwQTbmwxSNTrHsoHmANMzd6MzWgAXRNxnfhE00wUj+g@mail.gmail.com>
X-Gm-Features: AWmQ_blEZkza7OMemaxMs9sk8u7aYy4bvwsTe93oLwUx0BO1SD9FqwDNAmU0tu0
Message-ID: <CAJZ5v0iDwQTbmwxSNTrHsoHmANMzd6MzWgAXRNxnfhE00wUj+g@mail.gmail.com>
Subject: [GIT PULL] Thermal control updates for v6.19-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

I am sending this in advance because I am not expecting to make any changes
to it before next week.

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.19-rc1

with top-most commit 63d26c3811421ceeb5b82a85489b88bf545e33c7

 Merge tag 'thermal-v6.19-rc1' of
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux

on top of commit 6146a0f1dfae5d37442a9ddcba012add260bceb0

 Linux 6.18-rc4

to receive thermal control updates for 6.19-rc1.

These add Nova Lake processor support to the Intel thermal drivers
and DPTF code, update thermal control documentation, simplify the ACPI
DPTF code related to thermal control, add QCS8300 compatible to the
tsens thermal DT bindings, add DT bindings for NXP i.MX91 thermal
module and add support for it to the imx91 thermal driver, update
a few other thermal drivers and fix a format string issue in a thermal
utility:

 - Add Nova Lake processor thermal device to the int340x
   processor_thermal driver, add DLVR support for Nova Lake to it,
   add Nova Lake support to the ACPI DPTF code, document thermal
   throttling on Intel platforms, and update workload type hint
   interface documentation (Srinivas Pandruvada)

 - Remove int340x thermal scan handler from the ACPI DPTF code
   because it turned out to be unnecessary (Slawomir Rosek)

 - Clean up the Intel int340x thermal driver (Kaushlendra Kumar)

 - Document the RZ/V2H TSU DT bindings (Ovidiu Panait)

 - Document the Kaanapali Temperature Sensor (Manaf Meethalavalappu
   Pallikunhi)

 - Document R-Car Gen4 and RZ/G2 support in driver comment (Marek Vasut)

 - Convert to DEFINE_SIMPLE_DEV_PM_OPS() in R-Car [Gen3] (Geert
   Uytterhoeven)

 - Fix format string bug in thermal-engine (Malaya Kumar Rout)

 - Make ipq5018 tsens standalone compatible (George Moussalem)

 - Add the QCS8300 compatible for QCom Tsens (Gaurav Kohli)

 - Add support for the NXP i.MX91 thermal module, including the DT
   bindings (Pengfei Li)

Thanks!


---------------

Gaurav Kohli (1):
      dt-bindings: thermal: tsens: Add QCS8300 compatible

Geert Uytterhoeven (2):
      thermal/drivers/rcar: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
      thermal/drivers/rcar_gen3: Convert to DEFINE_SIMPLE_DEV_PM_OPS()

George Moussalem (1):
      dt-bindings: thermal: qcom-tsens: make ipq5018 tsens standalone compatible

Kaushlendra Kumar (2):
      thermal: intel: int340x: Use symbolic constant for UUID comparison
      thermal: intel: int340x: Replace sprintf() with sysfs_emit()

Malaya Kumar Rout (1):
      tools/thermal/thermal-engine: Fix format string bug in thermal-engine

Manaf Meethalavalappu Pallikunhi (1):
      dt-bindings: thermal: qcom-tsens: document the Kaanapali
Temperature Sensor

Marek Vasut (1):
      thermal/drivers/rcar_gen3: Document R-Car Gen4 and RZ/G2 support
in driver comment

Ovidiu Panait (1):
      dt-bindings: thermal: r9a09g047-tsu: Document RZ/V2H TSU

Pengfei Li (2):
      dt-bindings: thermal: fsl,imx91-tmu: add bindings for NXP i.MX91
thermal module
      thermal/drivers/imx91: Add support for i.MX91 thermal monitoring unit

Slawomir Rosek (2):
      thermal: intel: Select INT340X_THERMAL from INTEL_SOC_DTS_THERMAL
      ACPI: DPTF: Remove int340x thermal scan handler

Srinivas Pandruvada (5):
      thermal: int340x: processor_thermal: Add Nova Lake processor
thermal device
      thermal: intel: int340x: Add DLVR support for Nova Lake
      ACPI: DPTF: Support Nova Lake
      Documentation: thermal: Document thermal throttling on Intel platforms
      docs: driver-api/thermal/intel_dptf: Add new workload type hint

---------------

 Documentation/admin-guide/thermal/index.rst        |   1 +
 .../admin-guide/thermal/intel_thermal_throttle.rst |  91 +++++
 .../devicetree/bindings/thermal/fsl,imx91-tmu.yaml |  87 +++++
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   9 +-
 .../bindings/thermal/renesas,r9a09g047-tsu.yaml    |   6 +-
 Documentation/driver-api/thermal/intel_dptf.rst    |  23 ++
 drivers/acpi/dptf/Makefile                         |   1 -
 drivers/acpi/dptf/dptf_power.c                     |   2 +
 drivers/acpi/dptf/int340x_thermal.c                |  94 -----
 drivers/acpi/fan.h                                 |   1 +
 drivers/acpi/internal.h                            |   1 -
 drivers/acpi/scan.c                                |   1 -
 drivers/thermal/Kconfig                            |  10 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/imx91_thermal.c                    | 384 +++++++++++++++++++++
 drivers/thermal/intel/Kconfig                      |   3 +-
 .../intel/int340x_thermal/int3400_thermal.c        |  13 +-
 .../intel/int340x_thermal/int3403_thermal.c        |   1 +
 .../int340x_thermal/processor_thermal_device.h     |   2 +
 .../int340x_thermal/processor_thermal_device_pci.c |  10 +
 .../intel/int340x_thermal/processor_thermal_rfim.c |  15 +
 drivers/thermal/renesas/rcar_gen3_thermal.c        |  10 +-
 drivers/thermal/renesas/rcar_thermal.c             |   8 +-
 tools/thermal/thermal-engine/thermal-engine.c      |   2 +-
 24 files changed, 660 insertions(+), 116 deletions(-)

