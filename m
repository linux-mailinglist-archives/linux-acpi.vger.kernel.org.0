Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 312D4112952
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Dec 2019 11:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfLDKfB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Dec 2019 05:35:01 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39080 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfLDKfB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Dec 2019 05:35:01 -0500
Received: by mail-ot1-f68.google.com with SMTP id 77so5874618oty.6;
        Wed, 04 Dec 2019 02:35:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=WNn4XHe9ywl5H5Cb0VGU+9qS/kYHcdC+aeiiry/1kpM=;
        b=OI6cVXpMhdjVAbn0ZtgEAo788b6jCZ60MVD3EkSbOpIiYmo4vvbxvsmk/JXpZ3U8FS
         Jr6Orw/vKUmcA8l675DGDr7rse2U8BfPZt49+Hce+oZ9VMWW3VxrtSxWLg9j4QvQZW/w
         E0iaxUF1qbAw8t00wVAxKQJVLEI2/BfUShT9vilFaNiI4GLDcf6SakdtIYxF8wFtdJUN
         Oyfg/qZlWYpvH5yoMVt26JmPbaY0fJ8DzIy6fCGABpcI079tdjahw3sEGGhrqe7+edAN
         C8linyYdmC75/gZA33W/NGZyX+4RURAXt7ykb9TfmMCbKgVxfgWnoBdMbdAp30FG4wBd
         z2rg==
X-Gm-Message-State: APjAAAVf/8z+1xGInGzP/fh3D8kNN+5U21WD/WpSX/Dt40rtSmf6uB4s
        zuNdQrvsqxIffWbH04S/6r8Ac+oOPnMkGLjcTSzThina
X-Google-Smtp-Source: APXvYqwi/xv+2t7WJjFELHBgx2xxlAvDSPObHgOKAMie0hXPlaY8UJ7uVPjZHHOG5pB3iZgU8+48EoXBwiTvMXTp3tQ=
X-Received: by 2002:a05:6830:4b9:: with SMTP id l25mr1965013otd.266.1575455700009;
 Wed, 04 Dec 2019 02:35:00 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 4 Dec 2019 11:34:48 +0100
Message-ID: <CAJZ5v0iWz6HG4C19U2Pax8KpyGm=AvwDbU__w=Yt7ij1JqQZFg@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v5.5-rc1
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
 pm-5.5-rc1-2

with top-most commit 1e4230f56dac141eb149ebec01f41b6fad27e503

 Merge branches 'pm-sleep', 'pm-cpuidle', 'pm-cpufreq', 'pm-devfreq'
and 'pm-avs'

on top of commit 6e9f879684b46331f51d0c76ebee981c788417db

 Merge tag 'acpi-5.5-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive additional power management updates for 5.5-rc1.

These fix an ACPI EC driver bug exposed by the recent rework
of the suspend-to-idle code flow, reintroduce frequency
constraints into device PM QoS (in preparation for adding
QoS support to devfreq), drop a redundant field from struct
cpuidle_state and clean up Kconfig in some places.

Specifics:

 - Avoid a race condition in the ACPI EC driver that may cause
   systems to be unable to leave suspend-to-idle (Rafael Wysocki).

 - Drop the "disabled" field, which is redundant, from struct
   cpuidle_state (Rafael Wysocki).

 - Reintroduce device PM QoS frequency constraints (temporarily
   introduced and than dropped during the 5.4 cycle) in preparation
   for adding QoS support to devfreq (Leonard Crestez).

 - Clean up indentation (in multiple places) and the cpuidle drivers
   help text in Kconfig (Krzysztof Kozlowski, Randy Dunlap).

Thanks!


---------------

Krzysztof Kozlowski (3):
      cpuidle: Fix Kconfig indentation
      cpufreq: Fix Kconfig indentation
      power: avs: Fix Kconfig indentation

Leonard Crestez (4):
      PM / QoS: Redefine FREQ_QOS_MAX_DEFAULT_VALUE to S32_MAX
      PM / QoS: Initial kunit test
      PM / QoS: Reorder pm_qos/freq_qos/dev_pm_qos structs
      PM / QoS: Restore DEV_PM_QOS_MIN/MAX_FREQUENCY

Marek Szyprowski (1):
      PM / devfreq: Add missing locking while setting suspend_freq

Rafael J. Wysocki (3):
      cpuidle: Drop disabled field from struct cpuidle_state
      ACPI: EC: Rework flushing of pending work
      ACPI: PM: s2idle: Rework ACPI events synchronization

Randy Dunlap (1):
      cpuidle: minor Kconfig help text fixes

---------------

 arch/sh/kernel/cpu/shmobile/cpuidle.c |   8 +--
 drivers/acpi/ec.c                     |  36 ++++-------
 drivers/acpi/sleep.c                  |  26 ++++++--
 drivers/base/Kconfig                  |   4 ++
 drivers/base/power/Makefile           |   1 +
 drivers/base/power/qos-test.c         | 117 ++++++++++++++++++++++++++++++++++
 drivers/base/power/qos.c              |  73 +++++++++++++++++++--
 drivers/cpufreq/Kconfig.powerpc       |   8 +--
 drivers/cpufreq/Kconfig.x86           |  16 ++---
 drivers/cpuidle/Kconfig               |  16 ++---
 drivers/cpuidle/Kconfig.arm           |  22 +++----
 drivers/cpuidle/cpuidle.c             |   2 +-
 drivers/cpuidle/poll_state.c          |   1 -
 drivers/devfreq/devfreq.c             |   4 ++
 drivers/idle/intel_idle.c             |   6 +-
 drivers/power/avs/Kconfig             |  12 ++--
 include/linux/cpuidle.h               |   2 +-
 include/linux/pm_qos.h                |  86 ++++++++++++++-----------
 kernel/power/qos.c                    |   4 +-
 19 files changed, 324 insertions(+), 120 deletions(-)
