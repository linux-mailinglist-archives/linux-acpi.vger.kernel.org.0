Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 440C31555C8
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Feb 2020 11:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgBGKe7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 Feb 2020 05:34:59 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:32839 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGKe7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Feb 2020 05:34:59 -0500
Received: by mail-ot1-f66.google.com with SMTP id b18so1736616otp.0;
        Fri, 07 Feb 2020 02:34:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=N3gjIRLWEByTorZ/B06m6vD/kOUXUSh7A+yrD9F+lKs=;
        b=UtavabXSyvztpncANpvov2W60EE9W0qFiUKCGS28KbM6okSY3OwkoY7XfwYUY2lSsy
         y9EBHCxLU4EpemprIo3zEtbY583LZgfTFAyamvifi+9pE/NCp9Vix4fS0lPOgYChgg6D
         uXEePMV5VwGgAJdzmrxc+8MDmOi/apEtQ2ALdO3TKPaGVstj66FbgmcFzvrtUnlnOBWG
         ADEtiUJQauSeaOQzja7+oiaPTp9yVqKxiUQjTXumT2ODijk5ABN6HuYvC/5GzBYpLXV+
         Y50UI6v0HrxfMbNQITNQUKWlM+oUcTf861mIu/8+guxEC0K2B/copf4uzrCakHw0tsM6
         Uqeg==
X-Gm-Message-State: APjAAAW1LNCyBLnZKvvySfNs9k0nMKOwA9joIFWtqfpk0c1CaLWWcYu4
        fXXAQ/WlqmLbzF4RCtJoIY0yRcxjw/pAKugde2imHY1f
X-Google-Smtp-Source: APXvYqwUvey6PuIK8Pl8d3Vhr/87GvFnUef2HtU0/WiwHdnb1QTR7hhXuaW4wVuskNRm2mXe8l2LoaQ/jQkSy/EA6c4=
X-Received: by 2002:a05:6830:4b9:: with SMTP id l25mr2212795otd.266.1581071698814;
 Fri, 07 Feb 2020 02:34:58 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 7 Feb 2020 11:34:48 +0100
Message-ID: <CAJZ5v0iDEpbZmZvTKxhZYq0CQWJSRZBDfhXgNOJT-wSxUrsb3g@mail.gmail.com>
Subject: [GIT PULL] Additional power management updates for v5.6-rc1
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
 pm-5.6-rc1-3

with top-most commit 332008256f1f7cd8294acd6e288fb821f685d1a9

 Merge branches 'pm-avs' and 'pm-cpuidle'

on top of commit ffda81b69fce50f2543be99ef2d7c77dffc1ebc1

 Merge tag 'acpi-5.6-rc1-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive additional power management updates for 5.6-rc1.

These update the recently merged CPR (Core Power Reduction) support
in the AVS (Adaptive Voltage Scaling) subsystem (Brendan Higgins,
Nathan Chancellor, Niklas Cassel) and the rockchip-io AVS driver
(Heiko Stuebner), add two more module parameters to intel_idle on
top of the recently merged material, clean up a piece of cpuidle
documentation and consolidate system sleep states documentation
somewhat (Rafael Wysocki).

Thanks!


---------------

Brendan Higgins (1):
      power: avs: qcom-cpr: add unspecified HAS_IOMEM dependency

Heiko Stuebner (1):
      PM / AVS: rockchip-io: fix the supply naming for the emmc supply on px30

Nathan Chancellor (1):
      power: avs: qcom-cpr: Avoid clang -Wsometimes-uninitialized in cpr_scale

Niklas Cassel (1):
      power: avs: qcom-cpr: add a printout after the driver has been initialized

Rafael J. Wysocki (4):
      intel_idle: Introduce 'use_acpi' module parameter
      intel_idle: Introduce 'states_off' module parameter
      Documentation: admin-guide: PM: Update sleep states documentation
      cpuidle: Documentation: Clean up PM QoS description

---------------

 Documentation/admin-guide/pm/cpuidle.rst      |  8 +--
 Documentation/admin-guide/pm/intel_idle.rst   | 30 ++++++++--
 Documentation/admin-guide/pm/sleep-states.rst | 76 ++++++++++++++++++++------
 Documentation/power/interface.rst             | 79 ---------------------------
 drivers/idle/intel_idle.c                     | 30 +++++++++-
 drivers/power/avs/Kconfig                     |  2 +-
 drivers/power/avs/qcom-cpr.c                  |  9 +--
 drivers/power/avs/rockchip-io-domain.c        |  6 +-
 8 files changed, 125 insertions(+), 115 deletions(-)
