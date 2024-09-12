Return-Path: <linux-acpi+bounces-8274-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BACC1977022
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Sep 2024 20:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78EBE281517
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Sep 2024 18:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF841BD501;
	Thu, 12 Sep 2024 18:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOkDhm/n"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502A11B1402;
	Thu, 12 Sep 2024 18:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726164615; cv=none; b=jTaoLCoUxWg062FX09ra72OsOpbweZnezkMOHPcGqOtVPoLwFsF3geq3fUrfXrYf7AZ3fwtx/pMIzGxEZPf5SGLQcONhsmvfjdYxtr13RKbPWtYvKOxEwA19Ohy9mmbvINHgINGcgCCBETWnoApOtd085Ir1LZFfOr/f8J9SslI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726164615; c=relaxed/simple;
	bh=zqbdY4GUD+iDcU6h5D20MqtD+MioVg4cKsINF0CdFR0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=CWl7lhVuP4W8STfwA6wCkMDDzKIXZNM+24InipEgzDAOCm3pM/wQCU1O8w/7RRnZSUe86xzqiWnzOkEwAuv8Q8XJMJ5wwWmvxE1/oACGt3dfPTCwmGSXfZtdVwP6U2r9Oubwxtvsl8vQH73r69NJ/O/rbh38pTuWEndAry9mvZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOkDhm/n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D403FC4CEC3;
	Thu, 12 Sep 2024 18:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726164614;
	bh=zqbdY4GUD+iDcU6h5D20MqtD+MioVg4cKsINF0CdFR0=;
	h=From:Date:Subject:To:Cc:From;
	b=hOkDhm/njf5we3I+/MGRnsIxK+EmCZwK69t7poDFpPQhy170vNko8ZHBT9zH0Pfpi
	 iKnusyHM6asqUdWV0rP6jLD64kxDNU/A5+VlgOu7tVf3KgILTfUIs3PueXGK0hTA05
	 T0uJPgzN2+kmS4B5zJF6Hgf8P5KGfeSL6rxRsrE3Y7UJn5uS+wCWDapgzpVixvRJ2A
	 yxaM5KA1p5tKRctbUb+/cjRJ4KZzJPJiM2/J8+LUQx9au9V64ZaercjLJD71HB1Z3I
	 TtGpbFcoqUkzkvIXNVttPb6tCurmzTNfhZy1N1mthfsMgWfBI4oz0lSVawwFKRrbDh
	 DT8le07docm/g==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-277efdcfa63so607109fac.2;
        Thu, 12 Sep 2024 11:10:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVaYd444qwcO9+/v4RXYOKzZaLJm/y067tLcPpUP0+DGeZONd0BzqlP685wWXya67NU2yYwjonUxVACTE46@vger.kernel.org, AJvYcCXOEPS64awo1yaCYPY7v7xcmcvYnkXE9RYyoqiL2F9WZCtI3NQ6W92BZ7oN5tJnYFQOrn2zLH/WRlAG@vger.kernel.org
X-Gm-Message-State: AOJu0YxwnV5mywOjyQzY3RZ/UhuZtN/hznsX+p2jcWBuGtzQSaPl777C
	BU5Qnvq8kDuovsZE1idBMe4nLODIHPp4qJ+K9ip+zbeX2/Varrt4hBkgFwvrSXS+T3YDODmAYEn
	7UTjWqm9YfkuuMjIXCwtpgWNOYHw=
X-Google-Smtp-Source: AGHT+IG778XhjkSePOaVXdbyb9aD2YarvXfmDy6ouD8d3STlb3BL+Zgr/mjog/7vGc8c0owVlSdiwDOScb8mZrxceaw=
X-Received: by 2002:a05:6870:2481:b0:26f:f1ea:6a4f with SMTP id
 586e51a60fabf-27c3f256b78mr2659555fac.1.1726164614129; Thu, 12 Sep 2024
 11:10:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 12 Sep 2024 20:10:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g_7rOA1AvtCsHCHsde8wJqq8prFmXq3oKEPUY2buWvbg@mail.gmail.com>
Message-ID: <CAJZ5v0g_7rOA1AvtCsHCHsde8wJqq8prFmXq3oKEPUY2buWvbg@mail.gmail.com>
Subject: [GIT PULL] Thermal control updates for v6.12-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

The next week will be all conference travel for me and I'll be traveling in
the week after it too, so here's an early request to pull thermal control
updates for 6.12-rc1.

To receive them, please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.12-rc1

with top-most commit 3bc5ed15bdc5077d7ee621f44872f550babbea3e

 Merge tag 'thermal-v6.12-rc1' of
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux into

on top of commit c0a1ef9c5be72ff28a5413deb1b3e1a066593c13

 thermal: of: Fix OF node leak in of_thermal_zone_find() error paths

to receive thermal control updates for 6.12-rc1.

These mostly continue to rework the thermal core and the thermal zone
driver interface to make the code more straightforward and reduce bloat.
The most significant piece of this work is a change of the code related
to binding cooling devices to thermal zones which, among other things,
replaces two previously existing thermal zone operations with one
allowing driver implementations to be much simpler.

There is also a new thermal core testing module allowing mock thermal
zones to be created and controlled via debugfs in order to exercise the
thermal core functionality.  It is expected to be used for implementing
thermal core self tests in the future.

Apart from the above, there are assorted thermal driver updates.

Specifics:

 - Update some thermal drivers to eliminate thermal_zone_get_trip()
   calls from them and get rid of that function (Rafael Wysocki).

 - Update the thermal sysfs code to store trip point attributes in trip
   descriptors and get to trip points via attribute pointers (Rafael
   Wysocki).

 - Move the computation of the low and high boundaries for
   thermal_zone_set_trips() to __thermal_zone_device_update() (Daniel
   Lezcano).

 - Introduce a debugfs-based facility for thermal core testing (Rafael
   Wysocki).

 - Replace the thermal zone .bind() and .unbind() callbacks for binding
   cooling devices to thermal zones with one .should_bind() callback
   used for deciding whether or not a given cooling devices should be
   bound to a given trip point in a given thermal zone (Rafael Wysocki).

 - Eliminate code that has no more users after the other changes, drop
   some redundant checks from the thermal core and clean it up (Rafael
   Wysocki).

 - Fix rounding of delay jiffies in the thermal core (Rafael Wysocki).

 - Refuse to accept trip point temperature or hysteresis that would lead
   to an invalid threshold value when setting them via sysfs (Rafael
   Wysocki).

 - Adjust states of all uninitialized instances in the .manage()
   callback of the Bang-bang thermal governor (Rafael Wysocki).

 - Drop a couple of redundant checks along with the code depending on
   them from the thermal core (Rafael Wysocki).

 - Rearrange the thermal core to avoid redundant checks and simplify
   control flow in a couple of code paths (Rafael Wysocki).

 - Add power domain DT bindings for new Amlogic SoCs (Georges Stark).

 - Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() in the ST
   driver and add a Kconfig dependency on THERMAL_OF subsystem for the
   STi driver (Raphael Gallais-Pou).

 - Simplify the error code path in the probe functions in the brcmstb
   driver with the help of dev_err_probe() (Yan Zhen).

 - Make imx_sc_thermal use dev_err_probe() (Alexander Stein).

 - Remove trailing space after \n newline in the Renesas driver (Colin
   Ian King).

 - Add DT binding compatible string for the SA8255p to the tsens thermal
   driver (Nikunj Kela).

 - Use the devm_clk_get_enabled() helpers to simplify the init routine
   in the sprd thermal driver (Huan Yang).

 - Remove __maybe_unused notations for the functions by using the new
   RUNTIME_PM_OPS() and SYSTEM_SLEEP_PM_OPS() macros on the IMx and
   Qoriq drivers (Fabio Estevam)

 - Remove unused declarations from the ti-soc-thermal driver's header
   file as the functions in question were removed previously (Zhang
   Zekun).

Thanks!


---------------

Alexander Stein (1):
      thermal/drivers/imx_sc_thermal: Use dev_err_probe

Colin Ian King (1):
      thermal/drivers/renesas: Remove trailing space after \n newline

Daniel Lezcano (1):
      thermal/core: Compute low and high boundaries in
thermal_zone_device_update()

Fabio Estevam (2):
      thermal/drivers/qoriq: Remove __maybe_unused notations
      thermal/drivers/imx: Remove __maybe_unused notations

George Stark (1):
      dt-bindings: thermal: amlogic,thermal: add optional power-domains

Huan Yang (1):
      thermal/drivers/sprd: Use devm_clk_get_enabled() helpers

Nikunj Kela (1):
      dt-bindings: thermal: tsens: document support on SA8255p

Rafael J. Wysocki (36):
      thermal: broadcom: Use thermal_zone_get_crit_temp() in
bcm2835_thermal_probe()
      thermal: hisi: Use thermal_zone_for_each_trip() in
hisi_thermal_register_sensor()
      thermal: qcom: Use thermal_zone_get_crit_temp() in qpnp_tm_init()
      thermal: tegra: Introduce struct trip_temps for critical and hot trips
      thermal: tegra: Use thermal_zone_for_each_trip() for walking trip points
      thermal: helpers: Drop get_thermal_instance()
      thermal: trip: Get rid of thermal_zone_get_num_trips()
      thermal: trip: Drop thermal_zone_get_trip()
      thermal: core: Store trip sysfs attributes in thermal_trip_desc
      thermal: sysfs: Get to trips via attribute pointers
      thermal: sysfs: Refine the handling of trip hysteresis changes
      thermal: Introduce a debugfs-based testing facility
      thermal: core: Fold two functions into their respective callers
      thermal: core: Rearrange checks in thermal_bind_cdev_to_trip()
      thermal: core: Drop redundant thermal instance checks
      thermal: sysfs: Use the dev argument in instance-related show/store
      thermal: core: Move thermal zone locking out of bind/unbind functions
      thermal: core: Introduce .should_bind() thermal zone callback
      thermal: ACPI: Use the .should_bind() thermal zone callback
      thermal: core: Unexport thermal_bind_cdev_to_trip() and
thermal_unbind_cdev_from_trip()
      platform/x86: acerhdf: Use the .should_bind() thermal zone callback
      mlxsw: core_thermal: Use the .should_bind() thermal zone callback
      thermal: imx: Use the .should_bind() thermal zone callback
      thermal/of: Use the .should_bind() thermal zone callback
      thermal: core: Drop unused bind/unbind functions and callbacks
      thermal: core: Clean up trip bind/unbind functions
      thermal: core: Fix rounding of delay jiffies
      thermal: core: Rename cdev-to-thermal-zone bind/unbind functions
      thermal: core: Drop redundant checks from thermal_bind_cdev_to_trip()
      thermal: core: Drop tz field from struct thermal_instance
      thermal: sysfs: Add sanity checks for trip temperature and hysteresis
      thermal: gov_bang_bang: Adjust states of all uninitialized instances
      thermal: core: Drop redundant lockdep_assert_held()
      thermal: core: Drop dead code from monitor_thermal_zone()
      thermal: core: Check passive delay in monitor_thermal_zone()
      thermal: core: Drop thermal_zone_device_is_enabled()

Raphael Gallais-Pou (2):
      thermal/drivers/st: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
      thermal/drivers/sti: Depend on THERMAL_OF subsystem

Yan Zhen (1):
      thermal/drivers/brcmstb_thermal: Simplify with dev_err_probe()

Zhang Zekun (1):
      thermal/drivers/ti-soc-thermal: Remove unused declarations

---------------

 .../bindings/thermal/amlogic,thermal.yaml          |   3 +
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   1 +
 Documentation/driver-api/thermal/sysfs-api.rst     |  68 +--
 drivers/acpi/thermal.c                             |  66 +--
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c | 115 ++---
 drivers/platform/x86/acerhdf.c                     |  33 +-
 drivers/thermal/Kconfig                            |  11 +-
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/broadcom/bcm2835_thermal.c         |   7 +-
 drivers/thermal/broadcom/brcmstb_thermal.c         |  15 +-
 drivers/thermal/gov_bang_bang.c                    |  14 +-
 drivers/thermal/hisi_thermal.c                     |  25 +-
 drivers/thermal/imx_sc_thermal.c                   |   3 +-
 drivers/thermal/imx_thermal.c                      |  36 +-
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c        |  22 +-
 drivers/thermal/qoriq_thermal.c                    |  10 +-
 drivers/thermal/renesas/rcar_gen3_thermal.c        |   6 +-
 drivers/thermal/renesas/rcar_thermal.c             |   2 +-
 drivers/thermal/sprd_thermal.c                     |  14 +-
 drivers/thermal/st/st_thermal.c                    |  32 +-
 drivers/thermal/st/st_thermal_memmap.c             |   2 +-
 drivers/thermal/st/stm_thermal.c                   |   8 +-
 drivers/thermal/tegra/soctherm.c                   |  36 +-
 drivers/thermal/tegra/tegra30-tsensor.c            |  57 +--
 drivers/thermal/testing/Makefile                   |   7 +
 drivers/thermal/testing/command.c                  | 221 ++++++++++
 drivers/thermal/testing/thermal_testing.h          |  11 +
 drivers/thermal/testing/zone.c                     | 468 +++++++++++++++++++++
 drivers/thermal/thermal_core.c                     | 243 ++++-------
 drivers/thermal/thermal_core.h                     |  38 +-
 drivers/thermal/thermal_helpers.c                  |  32 +-
 drivers/thermal/thermal_of.c                       | 171 ++------
 drivers/thermal/thermal_sysfs.c                    | 222 +++++-----
 drivers/thermal/thermal_trip.c                     |  53 +--
 drivers/thermal/ti-soc-thermal/ti-bandgap.h        |   4 -
 include/linux/thermal.h                            |  31 +-
 36 files changed, 1160 insertions(+), 928 deletions(-)

