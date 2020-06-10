Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733A11F5854
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jun 2020 17:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbgFJPuq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Jun 2020 11:50:46 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37052 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbgFJPup (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Jun 2020 11:50:45 -0400
Received: by mail-oi1-f194.google.com with SMTP id a3so2505716oid.4;
        Wed, 10 Jun 2020 08:50:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=y19GN0GAG3z1gPsM787nBUvaywv+HAe0szNPPBNORkc=;
        b=n6zKwPdEFjvm9k5j0JTd7TzlNDNa8Wgcs6bqwN26bffmd9BSjIENJ5q28vl46ieGL8
         Fros7mvNXA7vfveIt8PdO9q+uaNHmHPd/9Y5djJs7JNa6VT4PZs2/1NOEpVmxWCJpeN5
         1T21pbbw6BwLrnVvRzUaP6saP5BZ0GuQAP1kY7SaObQFzoZ0veGPrtbyZModPHMYbvRF
         mzIp+unB5mtjbAJCbNUgNhykNeyaxCE2FLin+4OX5BUdHnLPbXOnuFhnG832masYVCLp
         KprnPOhp2WWH7BsWLRA1ezAd6ryCweZdIEUJ/TuRiLRosqzu0V4oGZY78KHd15MXXXtX
         QUDw==
X-Gm-Message-State: AOAM531MoYWuMUNm+VnGlmMUN53ZZVBbHT6itewvtDd7rji/Oaeh0GR8
        Y0HinObYwLiT/OkxfhOyH4LdzLSlHdOErjd/eB24pkfg
X-Google-Smtp-Source: ABdhPJybcHk7EwREF669+YZ1Dcc1f+JX+fSyyJem9dNgFqreOhYBMmCOYDkGWXcPhfwWYLvlnzEHt2aOmX5xWiRmnE4=
X-Received: by 2002:aca:ad88:: with SMTP id w130mr3093928oie.103.1591804244479;
 Wed, 10 Jun 2020 08:50:44 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 10 Jun 2020 17:50:33 +0200
Message-ID: <CAJZ5v0iEWuYG7-FtYMSk_kJZn-vVgcUimPfud75zSF5MU1Adbw@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v5.8-rc1
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
 pm-5.8-rc1-2

with top-most commit 50dd154ed7b17a8b3a1983fc32a8e41d4cc4211a

 Merge branches 'pm-cpufreq' and 'pm-acpi'

on top of commit 355ba37d756c38962fe9bb616f5f48eb12a7e11e

 Merge tag 'pm-5.8-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more power management updates for 5.8-rc1.

These are operating performance points (OPP) framework updates mostly,
including support for interconnect bandwidth in the OPP core, plus a
few cpufreq changes, including boost support in the CPPC cpufreq
driver, an ACPI device power management fix and a hibernation code
cleanup.

Specifics:

 - Add support for interconnect bandwidth to the OPP core (Georgi
   Djakov, Saravana Kannan, Sibi Sankar, Viresh Kumar).

 - Add support for regulator enable/disable to the OPP core (Kamil
   Konieczny).

 - Add boost support to the CPPC cpufreq driver (Xiongfeng Wang).

 - Make the tegra186 cpufreq driver set the
   CPUFREQ_NEED_INITIAL_FREQ_CHECK flag (Mian Yousaf Kaukab).

 - Prevent the ACPI power management from using power resources
   with devices where the list of power resources for power state
   D0 (full power) is missing (Rafael Wysocki).

 - Annotate a hibernation-related function with __init (Christophe
   JAILLET).

Thanks!


---------------

Christophe JAILLET (1):
      PM: hibernate: Add __init annotation to swsusp_header_init()

Georgi Djakov (5):
      interconnect: Add of_icc_get_by_index() helper function
      opp: Add support for parsing interconnect bandwidth
      opp: Add sanity checks in _read_opp_key()
      opp: Update the bandwidth on OPP frequency changes
      cpufreq: dt: Add support for interconnect bandwidth scaling

Jordan Crouse (1):
      interconnect: Remove unused module exit code from core

Kamil Konieczny (1):
      opp: core: add regulators enable and disable

Mian Yousaf Kaukab (1):
      cpufreq: tegra186: add CPUFREQ_NEED_INITIAL_FREQ_CHECK flag

Rafael J. Wysocki (1):
      ACPI: PM: Avoid using power resources if there are none for D0

Saravana Kannan (2):
      dt-bindings: opp: Introduce opp-peak-kBps and opp-avg-kBps bindings
      OPP: Add helpers for reading the binding properties

Sibi Sankar (1):
      opp: Don't parse icc paths unnecessarily

Viresh Kumar (4):
      interconnect: Disallow interconnect core to be built as a module
      opp: Expose bandwidth information via debugfs
      opp: Reorder the code for !target_freq case
      opp: Remove bandwidth votes when target_freq is zero

Xiongfeng Wang (2):
      cpufreq: change '.set_boost' to act on one policy
      cpufreq: CPPC: add SW BOOST support

---------------

 Documentation/devicetree/bindings/opp/opp.txt      |  17 +-
 .../devicetree/bindings/property-units.txt         |   4 +
 drivers/acpi/device_pm.c                           |   2 +-
 drivers/acpi/scan.c                                |  28 ++-
 drivers/cpufreq/acpi-cpufreq.c                     |  14 +-
 drivers/cpufreq/cppc_cpufreq.c                     |  39 +++-
 drivers/cpufreq/cpufreq-dt.c                       |   4 +
 drivers/cpufreq/cpufreq.c                          |  57 +++---
 drivers/cpufreq/tegra186-cpufreq.c                 |   3 +-
 drivers/interconnect/Kconfig                       |   2 +-
 drivers/interconnect/core.c                        |  97 +++++++---
 drivers/opp/core.c                                 | 119 ++++++++++--
 drivers/opp/debugfs.c                              |  42 +++++
 drivers/opp/of.c                                   | 205 +++++++++++++++++++--
 drivers/opp/opp.h                                  |  10 +
 include/linux/cpufreq.h                            |   2 +-
 include/linux/interconnect.h                       |  12 ++
 include/linux/pm_opp.h                             |  18 ++
 kernel/power/swap.c                                |   2 +-
 19 files changed, 573 insertions(+), 104 deletions(-)
