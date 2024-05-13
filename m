Return-Path: <linux-acpi+bounces-5793-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 533108C477A
	for <lists+linux-acpi@lfdr.de>; Mon, 13 May 2024 21:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C15F41F21B3D
	for <lists+linux-acpi@lfdr.de>; Mon, 13 May 2024 19:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE78482FA;
	Mon, 13 May 2024 19:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3vRV/zt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3ED39FD8;
	Mon, 13 May 2024 19:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715628449; cv=none; b=KjQGJvqlR3TcUyq5DTYdRhKO8AYGfer6lWNyLlr6R5Jw20vesCXUrLV46oyKzyPmmNpFAE7UXw9m0UhGXE6fxc3fCIeG4uavvgeBtxv5ljxqX7tqLMnQdNriSLZXZYIrr8ZpyVaOp01LhfYArWIEO/sH7DPUqnUwb/7Xgcq9mkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715628449; c=relaxed/simple;
	bh=yQ8BhTdkpgZ1yQl/hBDQ7xzrj+uvnfSAF2aHG+ZyCSM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ie2mT29vljG9TkqH/put9Nul4FWg1vwUv50R1sgX9XxnIdtR7D9Bpk1y7hynWnsdAeICin1O0Hg/RV63yb58E5O7t5y9TbkEtV2xfSn96ejOeiYBh9meh0XQwFMdBqPo0h9vQVKUrX52Hl6b1A642TjR/vvqPCe66Y64H+T0Y8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3vRV/zt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB139C32786;
	Mon, 13 May 2024 19:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715628448;
	bh=yQ8BhTdkpgZ1yQl/hBDQ7xzrj+uvnfSAF2aHG+ZyCSM=;
	h=From:Date:Subject:To:Cc:From;
	b=W3vRV/ztCYZ3SovnozewZ60orfdPiBZg7uc7NpXG9vs5MpCGuWBhVCZKOvI/vdXoR
	 8a/4SlqwpLVOSiACGNDbTbZ628qkBnVFmFOQybaG24tQr9c7j9yfsd6iIK/NKx+PaO
	 zGNR8dkD4GZyGVA26NeKyi8XY1tQ/8BQ9Zhuu+Z+oMmaS+7LAf6kOphyWfP2fymj53
	 b3VHU5FosuHcgjDKnqpGSY+sMsOCCAfYseSgwGx8hlnizKEFFt+J1JcQz9WHPRFbjR
	 Jquqms8FH1rFJLw1B9GE0LK5zQqHPMKveqBo0ZSJPMuvpoqujCLQCdHG7ts5PBoZDR
	 OO95sgc9UdbxA==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5b281f0d06dso164017eaf.0;
        Mon, 13 May 2024 12:27:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7HyYfmsvfA/k2S8alpKP8OPX2cWeehDQpiuwcyQbF87QCI1Gjauwe2fu7cyH+G1PvPs0tNAI505N5Ac3mQXf3eJMaDKZTOT5eL0clZVBVAs1Kvl/ZRDB0R+3WQOJ+ng9m0wn7GAMABw==
X-Gm-Message-State: AOJu0Ywq9JRgpMSZAURUwygyGxBTAPzMEH8gyJZneieBZRd+cwPZS23d
	u8d6vVsf6veRMtWMvh5RHb+cuq0tO/w2qmeU8KztJ7K/JfwSrZHgKgQJ3mzTu+4p7gnjCU1Jp63
	nKCmQ4+JWFXIYHdvODc36YZ/jqiA=
X-Google-Smtp-Source: AGHT+IHSSa1WG0dpD+a01Sb6Ay1kzmUegPxl4ea41KMYj7qmuq85ZY03tdG+FXmYl2ozTg3Dvpmz/i3N9boDJLN4i2c=
X-Received: by 2002:a4a:de14:0:b0:5b2:7aa7:7b29 with SMTP id
 006d021491bc7-5b28193d5e7mr11316049eaf.1.1715628447867; Mon, 13 May 2024
 12:27:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 13 May 2024 21:27:16 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hjT+fR2+RuSw+XJ_KcxagUpsjdYejJcw=uTicjbm6HCA@mail.gmail.com>
Message-ID: <CAJZ5v0hjT+fR2+RuSw+XJ_KcxagUpsjdYejJcw=uTicjbm6HCA@mail.gmail.com>
Subject: [GIT PULL] Thermal control updates for v6.10-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.10-rc1

with top-most commit 3a47fbdd1a750afe8c31971e7d3892f08e7390b8

 Merge branch 'thermal-intel'

on top of commit d351eb0ab04c3e8109895fc33250cebbce9c11da

 thermal/debugfs: Prevent use-after-free from occurring after cdev removal

to receive thermal control updates for 6.10-rc1.

The most significant part of this is a rework of thermal governors,
including a redesign of the thermal governor interface and changes to
make some of them take trip point hysteresis into account properly,
as well as some related cleanups of the thermal governors and thermal
core.

The above is based on preliminary changes refactoring thermal data
structures and moving the definitions of some of them into the thermal
core which also ensure that trip point crossing notifications will be
sent to user space via netlink and recorded in the debug statistics in
temperature order.

In addition, netlink bind/unbind notifications are added to the thermal
core and the Intel HFI driver is modified to use them to avoid sending
netlink messages until there are subscribers.

Apart from that, multiple thermal drivers are updated which includes
new hardware support (MediaTek MT8188 and MT8186, Amlogic A1 thermal
sensor, Loongson-2K2000, Lmh QCM2290), fixes, cleanups and documentation
updates, and the recently added thermal debug code is fixed and cleaned
up.

Specifics:

 - Redesign the thermal governor interface to allow the governors to
   work in a more straightforward way (Rafael Wysocki).

 - Make thermal governors take the current trip point thresholds into
   account in their computations which allows trip hysteresis to be
   observed more accurately (Rafael Wysocki).

 - Make the thermal core manage passive polling for thermal zones and
   remove passive polling management from thermal governors  (Rafael
   Wysocki).

 - Refactor trip point representation and move the definition of
   thermal governor and thermal zone device structures to the thermal
   core (Rafael Wysocki).

 - Sort trip point crossing notifications and debug recording of trip
   point crossing events by temperature (Rafael Wysocki).

 - Improve the handling of cooling device states and thermal mitigation
   episodes in progress in the thermal debug code (Rafael Wysocki).

 - Avoid excessive updates of trip point statistics and clean up the
   printing of thermal mitigation episode information (Rafael Wysocki).

 - Clean up thermal governors and thermal core (Rafael Wysocki).

 - Allow thermal drivers to register notifiers that will be invoked
   on netlink events like BIND and UNBIND, so that they can adjust
   their activity depending on whether or not there are any
   subscribers of netlink messages coming from them, and make
   the Intel HFI driver use this mechanism (Stanislaw Gruszka).

 - Adjust the update delay and capabilities-per-event values in the
   Intel HFI thermal driver to prevent it from missing events and allow
   it to process more data in one go (Ricardo Neri).

 - Add missing MODULE_DESCRIPTION() to multiple files in the
   int340x_thermal and intel_soc_dts_iosf drivers (Srinivas Pandruvada).

 - Replace deprecated strncpy() with strscpy() in the int340x_thermal
   driver (Justin Stitt).

 - Add QCM2290 compatible DT bindings for Lmh and fix a NULL pointer
   dereference in the lmh driver when the SCM is not present (Konrad
   Dybcio).

 - Use the strreplace() function instead of doing it manually in the
   Armada driver (Rasmus Villemoes).

 - Convert st,stih407-thermal to DT schema and fix up missing
   properties (Raphael Gallais-Pou).

 - Add suspend/resume by restoring the context of the tsens sensor
   (Priyansh Jain).

 - Support A1 SoC family Thermal Sensor controller and add the DT
   bindings (Dmitry Rokosov).

 - Improve the temperature approximation calculation and consolidate
   the Tj constant into a shared area of the structure instead of
   duplicating it on the Rcar Gen3 (Niklas S=C3=B6derlund).

 - Fix the Mediatek LVTS sensor coefficient for the MT8192 in order to supp=
ort
   it correctly (Hsin-Te Yuan).

 - Fix a NULL pointer dereference in the tsens driver when the function
   compute_intercept_slope() is called with a NULL parameter (Aleksandr
   Mishin).

 - Remove some unused fields in struct qpnp_tm_chip and k3_bandgap
   (Christophe Jaillet).

 - Fix up calibration efuse data decoding, consolidate the code by
   checking boundaries and refactor some part of the LVTS Mediatek
   driver. After setting the scene, add MT8186 and MT8188 along with
   the DT bindings (Nicolas Pitre).

 - Add Loongson-2K2000 support after some minor code adjustments and
   providing the DT bindings definition (Binbin Zhou).

Thanks!


---------------
Aleksandr Mishin (1):
      thermal/drivers/tsens: Fix null pointer dereference

Binbin Zhou (4):
      thermal/drivers/loongson2: Trivial code style adjustment
      dt-bindings: thermal: loongson,ls2k-thermal: Add Loongson-2K0500
compatible
      dt-bindings: thermal: loongson,ls2k-thermal: Fix incorrect
compatible definition
      thermal/drivers/loongson2: Add Loongson-2K2000 support

Christophe JAILLET (2):
      thermal/drivers/qcom: Remove some unused fields in struct qpnp_tm_chi=
p
      thermal/drivers/k3_bandgap: Remove some unused fields in struct k3_ba=
ndgap

Dmitry Rokosov (2):
      dt-bindings: thermal: amlogic: add support for A1 thermal sensor
      thermal/drivers/amlogic: Support A1 SoC family Thermal Sensor control=
ler

Hsin-Te Yuan (1):
      thermal/drivers/mediatek/lvts_thermal: Add coeff for mt8192

Justin Stitt (1):
      thermal: intel: int340x_thermal: replace deprecated strncpy()
with strscpy()

Konrad Dybcio (2):
      dt-bindings: thermal: lmh: Add QCM2290 compatible
      thermal/drivers/qcom/lmh: Check for SCM availability at probe

Nicolas Pitre (11):
      thermal/drivers/mediatek/lvts_thermal: Retrieve all calibration bytes
      thermal/drivers/mediatek/lvts_thermal: Move comment
      thermal/drivers/mediatek/lvts_thermal: Remove .hw_tshut_temp
      thermal/drivers/mediatek/lvts_thermal: Use offsets for every
calibration byte
      thermal/drivers/mediatek/lvts_thermal: Guard against efuse data
buffer overflow
      dt-bindings: thermal: mediatek: Add LVTS thermal controller
definition for MT8186
      thermal/drivers/mediatek/lvts_thermal: Add MT8186 support
      thermal/drivers/mediatek/lvts_thermal: Provision for gt variable loca=
tion
      thermal/drivers/mediatek/lvts_thermal: Allow early empty sensor slots
      dt-bindings: thermal: mediatek: Add LVTS thermal controller
definition for MT8188
      thermal/drivers/mediatek/lvts_thermal: Add MT8188 support

Niklas S=C3=B6derlund (2):
      thermal/drivers/rcar_gen3: Move Tj_T storage to shared private data
      thermal/drivers/rcar_gen3: Update temperature approximation calculati=
on

Priyansh Jain (1):
      thermal/drivers/tsens: Add suspend to RAM support for tsens

Rafael J. Wysocki (35):
      thermal: gov_step_wise: Simplify get_target_state()
      thermal: gov_step_wise: Simplify checks related to passive trips
      thermal: core: Move threshold out of struct thermal_trip
      thermal: core: Make struct thermal_zone_device definition internal
      thermal: core: Rewrite comments in handle_thermal_trip()
      thermal: core: Send trip crossing notifications at init time if neede=
d
      thermal: core: Sort trip point crossing notifications by temperature
      thermal: core: Relocate the struct thermal_governor definition
      thermal: core: Introduce .trip_crossed() callback for thermal governo=
rs
      thermal: gov_bang_bang: Use .trip_crossed() instead of .throttle()
      thermal: gov_bang_bang: Clean up thermal_zone_trip_update()
      thermal: gov_bang_bang: Fold thermal_zone_trip_update() into its call=
er
      thermal: core: Introduce .manage() callback for thermal governors
      thermal: gov_power_allocator: Use .manage() callback instead of
.throttle()
      thermal: gov_power_allocator: Eliminate a redundant variable
      thermal: gov_step_wise: Use .manage() callback instead of .throttle()
      thermal: gov_step_wise: Use trip thresholds instead of trip temperatu=
res
      thermal: gov_step_wise: Clean up thermal_zone_trip_update()
      thermal: gov_fair_share: Use .manage() callback instead of .throttle(=
)
      thermal: gov_fair_share: Use trip thresholds instead of trip temperat=
ures
      thermal: gov_fair_share: Eliminate unnecessary integer divisions
      thermal: gov_user_space: Use .trip_crossed() instead of .throttle()
      thermal: core: Drop the .throttle() governor callback
      thermal: core: Relocate critical and hot trip handling
      thermal/debugfs: Avoid excessive updates of trip point statistics
      thermal/debugfs: Clean up thermal_debug_update_temp()
      thermal/debugfs: Rename thermal_debug_update_temp() to
thermal_debug_update_trip_stats()
      thermal/debugfs: Make tze_seq_show() skip invalid trips and
trips with no stats
      thermal: core: Introduce thermal_governor_trip_crossed()
      thermal/debugfs: Create records for cdev states as they get used
      thermal/debugfs: Pass cooling device state to thermal_debug_cdev_add(=
)
      thermal/debugfs: Avoid printing zero duration for mitigation
events in progress
      thermal: trip: Add missing empty code line
      thermal: core: Do not call handle_thermal_trip() if zone
temperature is invalid
      thermal: core: Move passive polling management to the core

Raphael Gallais-Pou (1):
      dt-bindings: thermal: convert st,stih407-thermal to DT schema

Rasmus Villemoes (1):
      thermal/drivers/armada: Simplify name sanitization

Ricardo Neri (4):
      thermal: intel: hfi: Rename HFI_UPDATE_INTERVAL
      thermal: intel: hfi: Shorten the thermal netlink event delay to 100ms
      thermal: intel: hfi: Rename HFI_MAX_THERM_NOTIFY_COUNT
      thermal: intel: hfi: Increase the number of CPU capabilities per
netlink event

Srinivas Pandruvada (1):
      thermal: intel: Add missing module description

Stanislaw Gruszka (3):
      thermal: netlink: Add genetlink bind/unbind notifications
      thermal: netlink: Rename thermal_gnl_family
      thermal: intel: hfi: Enable HFI only when required


---------------

 .../bindings/thermal/amlogic,thermal.yaml          |  12 +-
 .../bindings/thermal/loongson,ls2k-thermal.yaml    |  24 +-
 .../bindings/thermal/mediatek,lvts-thermal.yaml    |   6 +
 .../devicetree/bindings/thermal/qcom-lmh.yaml      |  12 +-
 .../bindings/thermal/st,stih407-thermal.yaml       |  58 +++
 .../devicetree/bindings/thermal/st-thermal.txt     |  32 --
 drivers/thermal/amlogic_thermal.c                  |  10 +
 drivers/thermal/armada_thermal.c                   |   9 +-
 drivers/thermal/gov_bang_bang.c                    |  97 ++---
 drivers/thermal/gov_fair_share.c                   |  82 ++--
 drivers/thermal/gov_power_allocator.c              |  45 +--
 drivers/thermal/gov_step_wise.c                    |  98 ++---
 drivers/thermal/gov_user_space.c                   |  10 +-
 .../intel/int340x_thermal/acpi_thermal_rel.c       |   4 +-
 .../intel/int340x_thermal/processor_thermal_mbox.c |   1 +
 .../processor_thermal_power_floor.c                |   1 +
 .../intel/int340x_thermal/processor_thermal_rapl.c |   1 +
 .../intel/int340x_thermal/processor_thermal_rfim.c |   1 +
 .../int340x_thermal/processor_thermal_wt_hint.c    |   1 +
 .../int340x_thermal/processor_thermal_wt_req.c     |   1 +
 drivers/thermal/intel/intel_hfi.c                  | 113 +++++-
 drivers/thermal/intel/intel_soc_dts_iosf.c         |   1 +
 drivers/thermal/k3_bandgap.c                       |   1 -
 drivers/thermal/loongson2_thermal.c                | 117 ++++--
 drivers/thermal/mediatek/lvts_thermal.c            | 438 +++++++++++++++--=
----
 drivers/thermal/qcom/lmh.c                         |   3 +
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c        |   1 -
 drivers/thermal/qcom/tsens-v2.c                    |   1 +
 drivers/thermal/qcom/tsens.c                       |  33 +-
 drivers/thermal/qcom/tsens.h                       |   5 +
 drivers/thermal/rcar_gen3_thermal.c                | 165 ++++----
 drivers/thermal/thermal_core.c                     | 180 ++++++---
 drivers/thermal/thermal_core.h                     | 121 +++++-
 drivers/thermal/thermal_debugfs.c                  | 113 ++++--
 drivers/thermal/thermal_debugfs.h                  |   8 +-
 drivers/thermal/thermal_helpers.c                  |   8 +-
 drivers/thermal/thermal_netlink.c                  |  68 +++-
 drivers/thermal/thermal_netlink.h                  |  26 ++
 drivers/thermal/thermal_sysfs.c                    |  20 +-
 drivers/thermal/thermal_trace.h                    |   2 +
 drivers/thermal/thermal_trace_ipa.h                |   2 +
 drivers/thermal/thermal_trip.c                     |  16 +-
 .../dt-bindings/thermal/mediatek,lvts-thermal.h    |  26 ++
 include/linux/thermal.h                            | 109 +----
 44 files changed, 1354 insertions(+), 728 deletions(-)

