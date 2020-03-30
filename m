Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10DE1197F70
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Mar 2020 17:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbgC3PVF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Mar 2020 11:21:05 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40415 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbgC3PVD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Mar 2020 11:21:03 -0400
Received: by mail-oi1-f193.google.com with SMTP id y71so15967836oia.7;
        Mon, 30 Mar 2020 08:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=F+k0giqKlwuDpN7d+4rugXNSAJ2S5npLJFcMQv/KKcM=;
        b=S/FYUOy1TG5DcSVrYV2forVTRBVXmwMm5+Qa7/eTHT8vUa0jRD3NB0SP4v7MVRHzLR
         ihuVAxElP+DMhEd6CX/SRm0tT8dckx8ko+zTep+SQQt7IPS2Jry8O5fKaWI/fuoEPYbo
         d+FfHIOJAdL49EEZ8AkmSivBnhz7QuJnIAnLvdvOHQP8Gl7FCwFdfskeTT4tSc/PeKoJ
         fvt9OcjI8ky5heEcF87hDQ7MJ041kDPvODAjg1g7gD36j9ID4jy6mePhrH5VNneCu7ck
         vCBnUFgqyVSqc0HydHwD+F0WVC68Lzkt5Z6ec9gkZOGcUxxdrb7EcvT/xXHlVVFZo3mB
         FILQ==
X-Gm-Message-State: ANhLgQ08kq/HHtqzPBrUe1J4MTf6+E6pKtkDtGoZ4yfTB1ptoyzP4pHy
        pfrKiji8jeEFKcbVr8e1cxu31mIRyAz9udIVb5ZT/nha
X-Google-Smtp-Source: ADFU+vsODFASSq8MqHT0zR+W08p0wSJnzAye+RR1C3ORAPhbTQWKQyHHUiHvihsyA8V9oKLCSSSYh4OSHjjbCu0uHvA=
X-Received: by 2002:a05:6808:8f:: with SMTP id s15mr8203211oic.110.1585581661963;
 Mon, 30 Mar 2020 08:21:01 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 30 Mar 2020 17:20:48 +0200
Message-ID: <CAJZ5v0g=DNuHWVqxgJunTDm0bwPXTfo02gEZLy+eAfZJptVNkQ@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.7-rc1

with top-most commit 2409000a0cad2242fd4e2578f761f97069625478

 Merge branches 'pm-devfreq', 'powercap' and 'pm-docs'

on top of commit 16fbf79b0f83bc752cee8589279f1ebfe57b3b6e

 Linux 5.6-rc7

to receive power management updates for 5.7-rc1.

These clean up and rework the PM QoS API, address a suspend-to-idle
wakeup regression on some ACPI-based platforms, clean up and extend
a few cpuidle drivers, update multiple cpufreq drivers and cpufreq
documentation, and fix a number of issues in devfreq and several
other things all over.

Specifics:

 - Clean up and rework the PM QoS API to simplify the code and
   reduce the size of it (Rafael Wysocki).

 - Fix a suspend-to-idle wakeup regression on Dell XPS13 9370
   and similar platforms where the USB plug/unplug events are
   handled by the EC (Rafael Wysocki).

 - CLean up the intel_idle and PSCI cpuidle drivers (Rafael Wysocki,
   Ulf Hansson).

 - Extend the haltpoll cpuidle driver so that it can be forced to
   run on some systems where it refused to load (Maciej Szmigiero).

 - Convert several cpufreq documents to the .rst format and move the
   legacy driver documentation into one common file (Mauro Carvalho
   Chehab, Rafael Wysocki).

 - Update several cpufreq drivers:

   * Extend and fix the imx-cpufreq-dt driver (Anson Huang).

   * Improve the -EPROBE_DEFER handling and fix unwanted CPU
     overclocking on i.MX6ULL in imx6q-cpufreq (Anson Huang,
     Christoph Niedermaier).

   * Add support for Krait based SoCs to the qcom driver (Ansuel
     Smith).

   * Add support for OPP_PLUS to ti-cpufreq (Lokesh Vutla).

   * Add platform specific intermediate callbacks support to
     cpufreq-dt and update the imx6q driver (Peng Fan).

   * Simplify and consolidate some pieces of the intel_pstate driver
     and update its documentation (Rafael Wysocki, Alex Hung).

 - Fix several devfreq issues:

   * Remove unneeded extern keyword from a devfreq header file
     and use the DEVFREQ_GOV_UPDATE_INTERNAL event name instead of
     DEVFREQ_GOV_INTERNAL (Chanwoo Choi).

   * Fix the handling of dev_pm_qos_remove_request() result (Leonard
     Crestez).

   * Use constant name for userspace governor (Pierre Kuo).

   * Get rid of doc warnings and fix a typo (Christophe JAILLET).

 - Use built-in RCU list checking in some places in the PM core to
   avoid false-positive RCU usage warnings (Madhuparna Bhowmik).

 - Add explicit READ_ONCE()/WRITE_ONCE() annotations to low-level
   PM QoS routines (Qian Cai).

 - Fix removal of wakeup sources to avoid NULL pointer dereferences
   in a corner case (Neeraj Upadhyay).

 - Clean up the handling of hibernate compat ioctls and fix the
   related documentation (Eric Biggers).

 - Update the idle_inject power capping driver to use variable-length
   arrays instead of zero-length arrays (Gustavo Silva).

 - Fix list format in a PM QoS document (Randy Dunlap).

 - Make the cpufreq stats module use scnprintf() to avoid potential
   buffer overflows (Takashi Iwai).

 - Add pm_runtime_get_if_active() to PM-runtime API (Sakari Ailus).

 - Allow no domain-idle-states DT property in generic PM domains (Ulf
   Hansson).

 - Fix a broken y-axis scale in the intel_pstate_tracer utility (Doug
   Smythies).

Thanks!


---------------

Alex Hung (1):
      Documentation: intel_pstate: update links for references

Anson Huang (3):
      cpufreq: imx-cpufreq-dt: Add "cpu-supply" property check
      cpufreq: imx-cpufreq-dt: Correct i.MX8MP's market segment fuse location
      cpufreq: imx6q-cpufreq: Improve the logic of -EPROBE_DEFER handling

Ansuel Smith (1):
      cpufreq: qcom: Add support for krait based socs

Chanwoo Choi (2):
      PM / devfreq: Remove unneeded extern keyword
      PM / devfreq: Change to DEVFREQ_GOV_UPDATE_INTERVAL event name

Christoph Niedermaier (1):
      cpufreq: imx6q: Fixes unwanted cpu overclocking on i.MX6ULL

Christophe JAILLET (1):
      PM / devfreq: Fix a typo in a comment

Doug Smythies (1):
      tools/power/x86/intel_pstate_tracer: fix a broken y-axis scale

Eric Biggers (2):
      PM: hibernate: fix docs for ioctls that return loff_t via pointer
      PM / hibernate: Remove unnecessary compat ioctl overrides

Gustavo A. R. Silva (1):
      powercap: idle_inject: Replace zero-length array with
flexible-array member

Leonard Crestez (1):
      PM / devfreq: Fix handling dev_pm_qos_remove_request result

Lokesh Vutla (1):
      cpufreq: ti-cpufreq: Add support for OPP_PLUS

Maciej S. Szmigiero (1):
      cpuidle: haltpoll: allow force loading on hosts without the REALTIME hint

Madhuparna Bhowmik (2):
      PM: sleep: core: Use built-in RCU list checking
      PM: sleep: wakeup: Use built-in RCU list checking

Mauro Carvalho Chehab (6):
      docs: cpufreq: fix a broken reference
      docs: cpu-freq: convert index.txt to ReST
      docs: cpu-freq: convert core.txt to ReST
      docs: cpu-freq: convert cpu-drivers.txt to ReST
      docs: cpu-freq: convert cpufreq-stats.txt to ReST
      PM / devfreq: Get rid of some doc warnings

Neeraj Upadhyay (1):
      PM: sleep: wakeup: Skip wakeup_source_sysfs_remove() if device
is not there

Peng Fan (3):
      cpufreq: imx6q: fix error handling
      cpufreq: imx6q: read OCOTP through nvmem for imx6q
      cpufreq: dt: Allow platform specific intermediate callbacks

Qian Cai (1):
      PM: QoS: annotate data races in pm_qos_*_value()

Rafael J. Wysocki (43):
      intel_idle: Simplify LAPIC timer reliability checks
      intel_idle: Clean up definitions of cpuidle callbacks
      intel_idle: Relocate definitions of cpuidle callbacks
      intel_idle: Add __initdata annotations to init time variables
      intel_idle: Annotate init time data structures
      intel_idle: Reorder declarations of static variables
      intel_idle: Clean up kerneldoc comments for multiple functions
      intel_idle: Define CPUIDLE_FLAG_TLB_FLUSHED as BIT(16)
      intel_idle: Update copyright notice, known limitations and version
      PM: QoS: Drop debugfs interface
      PM: QoS: Drop pm_qos_update_request_timeout()
      PM: QoS: Drop the PM_QOS_SUM QoS type
      PM: QoS: Clean up pm_qos_update_target() and pm_qos_update_flags()
      PM: QoS: Clean up pm_qos_read_value() and pm_qos_get/set_value()
      PM: QoS: Drop iterations over global QoS classes
      PM: QoS: Clean up misc device file operations
      PM: QoS: Redefine struct pm_qos_request and drop struct pm_qos_object
      PM: QoS: Drop PM_QOS_CPU_DMA_LATENCY notifier chain
      PM: QoS: Rename things related to the CPU latency QoS
      PM: QoS: Simplify definitions of CPU latency QoS trace events
      PM: QoS: Adjust pm_qos_request() signature and reorder pm_qos.h
      PM: QoS: Add CPU latency QoS API wrappers
      cpuidle: Call cpu_latency_qos_limit() instead of pm_qos_request()
      x86: platform: iosf_mbi: Call cpu_latency_qos_*() instead of pm_qos_*()
      drm: i915: Call cpu_latency_qos_*() instead of pm_qos_*()
      drivers: hsi: Call cpu_latency_qos_*() instead of pm_qos_*()
      drivers: media: Call cpu_latency_qos_*() instead of pm_qos_*()
      drivers: mmc: Call cpu_latency_qos_*() instead of pm_qos_*()
      drivers: net: Call cpu_latency_qos_*() instead of pm_qos_*()
      drivers: spi: Call cpu_latency_qos_*() instead of pm_qos_*()
      drivers: tty: Call cpu_latency_qos_*() instead of pm_qos_*()
      drivers: usb: Call cpu_latency_qos_*() instead of pm_qos_*()
      sound: Call cpu_latency_qos_*() instead of pm_qos_*()
      PM: QoS: Drop PM_QOS_CPU_DMA_LATENCY and rename related functions
      PM: QoS: Update file information comments
      Documentation: PM: QoS: Update to reflect previous code changes
      PM: QoS: Make CPU latency QoS depend on CONFIG_CPU_IDLE
      Documentation: cpufreq: Move legacy driver documentation
      cpufreq: intel_pstate: Consolidate policy verification
      ACPI: PM: s2idle: Fix comment in acpi_s2idle_prepare_late()
      ACPICA: Allow acpi_any_gpe_status_set() to skip one GPE
      ACPI: PM: s2idle: Refine active GPEs check
      cpufreq: intel_pstate: Simplify intel_pstate_cpu_init()

Randy Dunlap (1):
      Documentation: power: fix pm_qos_interface.rst format warning

Sakari Ailus (1):
      PM: runtime: Add pm_runtime_get_if_active()

Takashi Iwai (1):
      cpufreq: Use scnprintf() for avoiding potential buffer overflow

Ulf Hansson (2):
      PM / Domains: Allow no domain-idle-states DT property in genpd
when parsing
      cpuidle: psci: Split psci_dt_cpu_init_idle()

pierre Kuo (1):
      PM / devfreq: Use constant name of userspace governor

---------------

 Documentation/admin-guide/pm/cpufreq_drivers.rst   | 274 ++++++++++
 Documentation/admin-guide/pm/cpuidle.rst           |  73 ++-
 Documentation/admin-guide/pm/intel_pstate.rst      |   4 +-
 Documentation/admin-guide/pm/working-state.rst     |   1 +
 Documentation/cpu-freq/amd-powernow.txt            |  38 --
 Documentation/cpu-freq/{core.txt => core.rst}      |  65 +--
 .../cpu-freq/{cpu-drivers.txt => cpu-drivers.rst}  | 129 +++--
 Documentation/cpu-freq/cpufreq-nforce2.txt         |  19 -
 .../{cpufreq-stats.txt => cpufreq-stats.rst}       | 119 +++--
 Documentation/cpu-freq/index.rst                   |  39 ++
 Documentation/cpu-freq/index.txt                   |  56 ---
 Documentation/cpu-freq/pcc-cpufreq.txt             | 207 --------
 .../devicetree/bindings/opp/qcom-nvmem-cpufreq.txt |   3 +-
 Documentation/index.rst                            |   1 +
 Documentation/power/pm_qos_interface.rst           |  88 ++--
 Documentation/power/runtime_pm.rst                 |   6 +
 Documentation/power/userland-swsusp.rst            |   8 +-
 Documentation/trace/events-power.rst               |  21 +-
 arch/x86/platform/intel/iosf_mbi.c                 |  13 +-
 drivers/acpi/acpica/achware.h                      |   2 +-
 drivers/acpi/acpica/evxfgpe.c                      |  17 +-
 drivers/acpi/acpica/hwgpe.c                        |  47 +-
 drivers/acpi/ec.c                                  |   5 +
 drivers/acpi/internal.h                            |   1 +
 drivers/acpi/sleep.c                               |  24 +-
 drivers/base/power/domain.c                        |   2 +-
 drivers/base/power/main.c                          |  12 +-
 drivers/base/power/runtime.c                       |  36 +-
 drivers/base/power/wakeup.c                        |  17 +-
 drivers/cpufreq/Kconfig.arm                        |   2 +-
 drivers/cpufreq/Kconfig.x86                        |   2 +-
 drivers/cpufreq/cpufreq-dt-platdev.c               |   5 +
 drivers/cpufreq/cpufreq-dt.c                       |   4 +
 drivers/cpufreq/cpufreq-dt.h                       |   4 +
 drivers/cpufreq/cpufreq_stats.c                    |  14 +-
 drivers/cpufreq/imx-cpufreq-dt.c                   |  13 +-
 drivers/cpufreq/imx6q-cpufreq.c                    |  71 +--
 drivers/cpufreq/intel_pstate.c                     |  26 +-
 drivers/cpufreq/qcom-cpufreq-nvmem.c               | 191 ++++++-
 drivers/cpufreq/ti-cpufreq.c                       |   7 +
 drivers/cpuidle/cpuidle-haltpoll.c                 |  12 +-
 drivers/cpuidle/cpuidle-psci.c                     |  46 +-
 drivers/cpuidle/cpuidle.c                          |  40 +-
 drivers/cpuidle/governor.c                         |   2 +-
 drivers/devfreq/devfreq.c                          |  14 +-
 drivers/devfreq/governor.h                         |  21 +-
 drivers/devfreq/governor_simpleondemand.c          |   4 +-
 drivers/devfreq/governor_userspace.c               |   2 +-
 drivers/devfreq/tegra30-devfreq.c                  |   4 +-
 drivers/gpu/drm/i915/display/intel_dp.c            |   4 +-
 drivers/gpu/drm/i915/i915_drv.c                    |  12 +-
 drivers/gpu/drm/i915/intel_sideband.c              |   5 +-
 drivers/hsi/clients/cmt_speech.c                   |   9 +-
 drivers/idle/intel_idle.c                          | 302 +++++------
 drivers/media/pci/saa7134/saa7134-video.c          |   5 +-
 drivers/media/platform/via-camera.c                |   4 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  14 +-
 drivers/net/ethernet/intel/e1000e/netdev.c         |  13 +-
 drivers/net/wireless/ath/ath10k/core.c             |   4 +-
 drivers/net/wireless/intel/ipw2x00/ipw2100.c       |  10 +-
 drivers/powercap/idle_inject.c                     |   2 +-
 drivers/spi/spi-fsl-qspi.c                         |   4 +-
 drivers/tty/serial/8250/8250_omap.c                |  13 +-
 drivers/tty/serial/omap-serial.c                   |  15 +-
 drivers/usb/chipidea/ci_hdrc_imx.c                 |  12 +-
 include/acpi/acpixf.h                              |   2 +-
 include/linux/devfreq.h                            | 106 ++--
 include/linux/pm_qos.h                             |  81 +--
 include/linux/pm_runtime.h                         |  12 +-
 include/trace/events/power.h                       |  59 +--
 kernel/power/qos.c                                 | 559 ++++++---------------
 kernel/power/user.c                                |  16 +-
 sound/core/pcm_native.c                            |  14 +-
 sound/soc/intel/atom/sst/sst.c                     |   5 +-
 sound/soc/intel/atom/sst/sst_loader.c              |   4 +-
 sound/soc/ti/omap-dmic.c                           |   7 +-
 sound/soc/ti/omap-mcbsp.c                          |  16 +-
 sound/soc/ti/omap-mcpdm.c                          |  16 +-
 .../x86/intel_pstate_tracer/intel_pstate_tracer.py |   1 -
 79 files changed, 1564 insertions(+), 1573 deletions(-)
