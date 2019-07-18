Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 088836CB86
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Jul 2019 11:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfGRJGa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Jul 2019 05:06:30 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:32837 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbfGRJGa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Jul 2019 05:06:30 -0400
Received: by mail-ot1-f67.google.com with SMTP id q20so28194170otl.0;
        Thu, 18 Jul 2019 02:06:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=FbAj5yhaqo7OvIXAnydPecQ9dRAE9THaUdkKuKLzG1w=;
        b=K/g+6mHUNOSF2J+5zlaBOCLJ8T4bvEvWSHKyhOW248BJqAe8qFl6cu9M6ReX3FG6xO
         7BvYEfE+QP6Cc3ibzXcvcr2FROwH8x8eUQWlbttMvM9M0wr1bDHsTps4uQY7OHYjh/Nv
         mvng6hIEp+LM3y/7HyhhnH3viErVPVESIWN6yD9OBJ/kyJZkozVk/PjMGtLEtfn8LsPg
         sUAFa3rxn83WgTFhr6h6oiBHeD9mIpgQJdn3xFEoRc1VWGHXRxwayFxcTL8qVaJ/2f9v
         eiXg+aPQCj+CZ2Lx1Fue1sTAII+SGmt0WmPaJKmbgOWbwFpYnDIH6xWttazgi1BRoJ28
         I1Qg==
X-Gm-Message-State: APjAAAW6JrRkqANHUQw1yf66cOQsJvvxDRBpkDDDfuWSKIvggIrizPYo
        YlIwexdTpQ7WjcepZWIK+HS3DU+Fv0WpEE5xEjE=
X-Google-Smtp-Source: APXvYqwVELilhcj7/AyvcoyPaqePI4XcNocPmBuVGOTQJOffopuzXvFDyxzznYHI9PGWCSEnBWFy36yMNNu1I19cKoI=
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr30020650otp.189.1563440789073;
 Thu, 18 Jul 2019 02:06:29 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Jul 2019 11:06:18 +0200
Message-ID: <CAJZ5v0irbFa5E=UZ+1XiiuoXC9zD0qc7vx3NtTCmB88h3_U4hw@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v5.3-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.3-rc1-2

with top-most commit 918e162e6a71e924a343b41f71789ad14e1e3229

 Merge branch 'pm-cpufreq'

on top of commit cf2d213e49fdf47e4c10dc629a3659e0026a54b8

 Merge tag 'pm-5.3-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more power management updates for 5.3-rc1.

These modify the Intel RAPL driver to allow it to use an MMIO
interface to the hardware, make the int340X thermal driver provide
such an interface for it, add Intel Ice Lake CPU IDs to the RAPL
driver (these changes depend on the previously merged x86 arch
changes), update cpufreq to use the PM QoS framework for managing
the min and max frequency limits, and add update the imx-cpufreq-dt
cpufreq driver to support i.MX8MN.

Specifics:

 - Add MMIO interface support to the Intel RAPL power capping
   driver and update the int340X thermal driver to provide a
   RAPL MMIO interface (Zhang Rui, Stephen Rothwell).

 - Add Intel Ice Lake CPU IDs to the RAPL driver (Zhang Rui,
   Rajneesh Bhardwaj).

 - Make cpufreq use the PM QoS framework (instead of notifiers) for
   managing the min and max frequency constraints (Viresh Kumar).

 - Add i.MX8MN support to the imx-cpufreq-dt cpufreq driver (Anson
   Huang).

Thanks!


---------------

Anson Huang (1):
      cpufreq: imx-cpufreq-dt: Add i.MX8MN support

Rajneesh Bhardwaj (1):
      powercap/rapl: Add Ice Lake NNPI support to RAPL driver

Stephen Rothwell (1):
      intel_rapl: need linux/cpuhotplug.h for enum cpuhp_state

Viresh Kumar (8):
      PM / QOS: Pass request type to dev_pm_qos_{add|remove}_notifier()
      PM / QOS: Rename __dev_pm_qos_read_value() and dev_pm_qos_raw_read_value()
      PM / QOS: Pass request type to dev_pm_qos_read_value()
      PM / QoS: Add support for MIN/MAX frequency constraints
      cpufreq: Register notifiers with the PM QoS framework
      cpufreq: intel_pstate: Reuse refresh_frequency_limits()
      cpufreq: Add QoS requests for userspace constraints
      cpufreq: Make cpufreq_generic_init() return void

Zhang Rui (16):
      intel_rapl: use reg instead of msr
      intel_rapl: remove hardcoded register index
      intel_rapl: introduce intel_rapl.h
      intel_rapl: introduce struct rapl_if_private
      intel_rapl: abstract register address
      intel_rapl: abstract register access operations
      intel_rapl: cleanup some functions
      intel_rapl: cleanup hardcoded MSR access
      intel_rapl: abstract RAPL common code
      intel_rapl: support 64 bit register
      intel_rapl: support two power limits for every RAPL domain
      int340X/processor_thermal_device: add support for MMIO RAPL
      intel_rapl: Fix module autoloading issue
      powercap/intel_rapl: add support for IceLake desktop
      powercap/intel_rapl: add support for ICX
      powercap/intel_rapl: add support for ICX-D

---------------

 Documentation/power/pm_qos_interface.txt           |  12 +-
 MAINTAINERS                                        |   1 +
 drivers/base/power/domain.c                        |   8 +-
 drivers/base/power/domain_governor.c               |   4 +-
 drivers/base/power/qos.c                           | 135 +++-
 drivers/base/power/runtime.c                       |   2 +-
 drivers/cpufreq/bmips-cpufreq.c                    |  17 +-
 drivers/cpufreq/cpufreq.c                          | 216 ++++--
 drivers/cpufreq/davinci-cpufreq.c                  |   3 +-
 drivers/cpufreq/imx-cpufreq-dt.c                   |   3 +-
 drivers/cpufreq/imx6q-cpufreq.c                    |   6 +-
 drivers/cpufreq/intel_pstate.c                     |   7 +-
 drivers/cpufreq/kirkwood-cpufreq.c                 |   3 +-
 drivers/cpufreq/loongson1-cpufreq.c                |   8 +-
 drivers/cpufreq/loongson2_cpufreq.c                |   3 +-
 drivers/cpufreq/maple-cpufreq.c                    |   3 +-
 drivers/cpufreq/omap-cpufreq.c                     |  15 +-
 drivers/cpufreq/pasemi-cpufreq.c                   |   3 +-
 drivers/cpufreq/pmac32-cpufreq.c                   |   3 +-
 drivers/cpufreq/pmac64-cpufreq.c                   |   3 +-
 drivers/cpufreq/s3c2416-cpufreq.c                  |   9 +-
 drivers/cpufreq/s3c64xx-cpufreq.c                  |  15 +-
 drivers/cpufreq/s5pv210-cpufreq.c                  |   3 +-
 drivers/cpufreq/sa1100-cpufreq.c                   |   3 +-
 drivers/cpufreq/sa1110-cpufreq.c                   |   3 +-
 drivers/cpufreq/spear-cpufreq.c                    |   3 +-
 drivers/cpufreq/tegra20-cpufreq.c                  |   8 +-
 drivers/cpuidle/governor.c                         |   2 +-
 drivers/powercap/Kconfig                           |  11 +-
 drivers/powercap/Makefile                          |   3 +-
 .../powercap/{intel_rapl.c => intel_rapl_common.c} | 801 ++++++++-------------
 drivers/powercap/intel_rapl_msr.c                  | 183 +++++
 drivers/thermal/intel/int340x_thermal/Kconfig      |   6 +
 .../int340x_thermal/processor_thermal_device.c     | 173 ++++-
 include/linux/cpufreq.h                            |  14 +-
 include/linux/intel_rapl.h                         | 155 ++++
 include/linux/pm_qos.h                             |  48 +-
 37 files changed, 1196 insertions(+), 699 deletions(-)
