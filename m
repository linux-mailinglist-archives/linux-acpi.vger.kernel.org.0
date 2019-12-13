Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4419811E12E
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Dec 2019 10:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbfLMJx5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Dec 2019 04:53:57 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34266 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfLMJx5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Dec 2019 04:53:57 -0500
Received: by mail-ot1-f66.google.com with SMTP id a15so5794274otf.1;
        Fri, 13 Dec 2019 01:53:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=kQXMOkKLQBuzsUmvhlFsweud8OIK7QsHH7RggCqtmtM=;
        b=ZT4tK+3ACxlVp+ZkROCmgagZqkWnGXiBITNjKoJBRUgfVnCJ6NRLwjTokcRuvhpRCK
         ylS5plvgBIH2GyCF38cjKWcg3+Jh8Bh7BHlBwSL3yPe3TNLz+/GhQ3piREgBYvshmnyi
         jxGsgvKKo0shp3rjbf6oy0Vlc5XWAOLWx7tC790yD+8VEsphREz8EhA3zlIaw5simVuT
         Vu8J+zKX+NfOOg3PuMkQoqAkAvY+48CcpUVDXF/rnfQoIJFkyDZoWolMsdC2gEX+V+Sz
         JQlKYjlk3KEzCFbqgRD/AXWStWWQSbo4Wd+LtElNkuivVfpJeGVXXD1mpeUc4rqOGIIB
         4Q8Q==
X-Gm-Message-State: APjAAAWsW6hy3NRqrtLk0JFcfvYGysvL5P4sbuS0Pfu9HoNj17w16zjl
        ddudbTioRf7cXKIDB87xUMJEmnYhacgA2CIOOhlVBoXM
X-Google-Smtp-Source: APXvYqycFbChVrFtM0/G5UhaTCn0IsrJkn0qmL3txvpHumg1p3pXeX7Yx1NDMUDXiQsmNM2Jza76bAJY2XM3A/HAAb0=
X-Received: by 2002:a05:6830:95:: with SMTP id a21mr12964851oto.167.1576230836441;
 Fri, 13 Dec 2019 01:53:56 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 13 Dec 2019 10:53:45 +0100
Message-ID: <CAJZ5v0g-xo1f2yPWGzFnrGQKFuHV=aDk_nV6s7hpWNnhnqyv5g@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v5.5-rc2
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
 pm-5.5-rc2

with top-most commit 4c84515da8099f4bab5d9312a0ffaf40f14aa87b

 Merge branches 'pm-cpuidle' and 'acpi-pm'

on top of commit e42617b825f8073569da76dc4510bfa019b1c35a

 Linux 5.5-rc1

to receive power management updates for 5.5-rc2.

These add PM QoS support to devfreq and fix a few issues in that
subsystem, fix two cpuidle issues and do one minor cleanup in there,
and address an ACPI power management problem related to devices with
special power management requirements, like fans.

Specifics:

 - Add PM QoS support, based on the frequency QoS introduced during
   the 5.4 cycle, to devfreq (Leonard Crestez).

 - Fix some assorted devfreq issues (Leonard Crestez).

 - Fix an unintentional cpuidle behavior change (introduced during
   the 5.4 cycle) related to the active polling time limit (Marcelo
   Tosatti).

 - Fix a recently introduced cpuidle helper function and do a minor
   cleanup in the cpuidle core (Rafael Wysocki).

 - Avoid adding devices with special power management requirements,
   like fans, to the generic ACPI PM domain (Rafael Wysocki).

Thanks!


---------------

Leonard Crestez (6):
      PM / devfreq: Fix devfreq_notifier_call returning errno
      PM / devfreq: Set scaling_max_freq to max on OPP notifier error
      PM / devfreq: Introduce get_freq_range helper
      PM / devfreq: Don't fail devfreq_dev_release if not in list
      PM / devfreq: Add PM QoS support
      PM / devfreq: Use PM QoS for sysfs min/max_freq

Marcelo Tosatti (1):
      cpuidle: use first valid target residency as poll time

Rafael J. Wysocki (3):
      ACPI: PM: Avoid attaching ACPI PM domain to certain devices
      cpuidle: Fix cpuidle_driver_state_disabled()
      cpuidle: Drop unnecessary type cast in cpuidle_poll_time()

---------------

 drivers/acpi/device_pm.c  |  12 +-
 drivers/cpuidle/cpuidle.c |   3 +-
 drivers/cpuidle/driver.c  |  10 ++
 drivers/devfreq/devfreq.c | 273 ++++++++++++++++++++++++++++++++++------------
 include/linux/devfreq.h   |  14 ++-
 5 files changed, 235 insertions(+), 77 deletions(-)
