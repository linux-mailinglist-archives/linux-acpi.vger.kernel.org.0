Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED17F1C281B
	for <lists+linux-acpi@lfdr.de>; Sat,  2 May 2020 21:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgEBT45 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 2 May 2020 15:56:57 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:34424 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbgEBT45 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 2 May 2020 15:56:57 -0400
Received: by mail-ot1-f42.google.com with SMTP id 72so5454610otu.1;
        Sat, 02 May 2020 12:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Ku7FT7H/qujkTpfndppU/5D0Q3HreZKL0CE63+jkaGE=;
        b=C9KuUp2jQKVlt00/MfqggsyuEh2lma18QJUeiBA8/VyP/ybUc+MW0WmDasZMp7U5aS
         AP4VNa1KowaJzlkeR7AldWzaF3ejEBD52vEZ7ubFfJBgEmGbFalt2GfMLVjSQFkOJrKP
         XGr4WZpS7tHzWlDXM0+YttPszbJU5aIloh+GMOQCjwff712Dof45VPJMozUMdYmVn+yk
         iPPMKlErrW5fuAbbZtfmHCANPLZlXjkOgjQGrhDLFp8JdfM9Mrt+Zh1E421/N/9j/LWQ
         0WeqKZGLGk5cdrJsy4TgwMmI63/d1Gssh4Qz2N1fkpZH9//E6xZzqnB9PeUSTFXGorVS
         bLXg==
X-Gm-Message-State: AGi0PuYjSOI2S/F1rJbNs5qZVevfNRCVpq8Z5oCw/USibZfQKK/lEx+Q
        ycOcPSadf6f/49gByI0FJ9ayveHumo1SZUFzVtKXgi8C
X-Google-Smtp-Source: APiQypJDMfsCYoxZLVpdfFCTqyN+78U8CyqwHxduOqRrk0pa7UvzuIcoyttl7/Fwd66VN6AF8QRPAV5Orra9qj/xcKg=
X-Received: by 2002:a05:6830:18d0:: with SMTP id v16mr8217505ote.118.1588449416859;
 Sat, 02 May 2020 12:56:56 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 2 May 2020 21:56:46 +0200
Message-ID: <CAJZ5v0huWpQa3NgmmJ_OWGB_ngQvA4V3YCX1i3-QutqSxZOzdw@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.7-rc4
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
 pm-5.7-rc4

with top-most commit a53839963ee22470a716de665bca39d2dae63c27

 Merge branches 'pm-cpufreq' and 'pm-sleep'

on top of commit 6a8b55ed4056ea5559ebe4f6a4b247f627870d4c

 Linux 5.7-rc3

to receive power management fixes for 5.7-rc4.

These prevent the intel_pstate driver from printing excessive
diagnostic messages in some cases (Chris Wilson), make the
hibernation restore kernel freeze kernel threads as well as user
space tasks (Dexuan Cui) and fix the ACPI device PM disagnostic
messages to include the correct power state name (Kai-Heng Feng).

Thanks!


---------------

Chris Wilson (1):
      cpufreq: intel_pstate: Only mention the BIOS disabling turbo mode once

Dexuan Cui (1):
      PM: hibernate: Freeze kernel threads in software_resume()

Kai-Heng Feng (1):
      PM: ACPI: Output correct message on target power state

---------------

 drivers/acpi/device_pm.c       | 4 ++--
 drivers/cpufreq/intel_pstate.c | 2 +-
 kernel/power/hibernate.c       | 7 +++++++
 3 files changed, 10 insertions(+), 3 deletions(-)
