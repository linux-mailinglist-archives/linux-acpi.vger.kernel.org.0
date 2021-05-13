Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C49F37FDCA
	for <lists+linux-acpi@lfdr.de>; Thu, 13 May 2021 21:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhEMTHL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 May 2021 15:07:11 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:34813 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbhEMTHK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 13 May 2021 15:07:10 -0400
Received: by mail-ot1-f53.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso24523535ote.1;
        Thu, 13 May 2021 12:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=LFsmwrfQZ1tEvh5wrSGIULVwCrwkJuIzxXXMgjAcjTE=;
        b=HYzLtlKHJFx0/9bOuAtmtY2R4j1skV0p2jtWr592QMvH+XoENH5J68wO/JWYs7Q2ak
         xI9Vqfn3u11ZouzdR310LGaeMrS/hV0AKNvODm/8QypS/DuBPmozDAv96vXfuxtOgioy
         j0Y9Zc47N6wJGeKYmWkNB/Grg77nLi3L68pblYwjBrhedNDAvSOCRfC2dmBi2xsibAsM
         hTUt95Lp9ETv+9UR3NA5jl/TKHwsYatk7cJmGHmPpHowaPnSS8ZQGpa2U8IJ2sGF1cqt
         pUr7fO1ovGDa/F44mjJzDvDVTymbflxe+jCxqpeb4htJ0166tSYx8qXv7VRuCNEE00xR
         b1BA==
X-Gm-Message-State: AOAM531r5wqdK0SBl0jwX5BviJ3RqRtapSQKxH8aQPoQDAN/o4SwsYDu
        ofwF+zAANwXp4cKV9eGmLNcJSJwdcRjxQ3zNi1qhyi0dtIs=
X-Google-Smtp-Source: ABdhPJzw+Ffm8fdlJGH2vfPkeMzKbadehFREw3g4COrWUy2mJkC0uIBubwQ6GS0yS9vRB/tqKuVTat4TmAUElbqDZRo=
X-Received: by 2002:a9d:5a7:: with SMTP id 36mr36983278otd.321.1620932759515;
 Thu, 13 May 2021 12:05:59 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 May 2021 21:05:48 +0200
Message-ID: <CAJZ5v0in2AeuGt-YRjKE5r4AKhu1kTf=zRfFWfb+cPFZL-NESA@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v5.13-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.13-rc2

with top-most commit fd38651716b45f817a542c34cd5336ff372d06e6

 Merge branch 'acpi-pm'

on top of commit 6efb943b8616ec53a5e444193dccf1af9ad627b5

 Linux 5.13-rc1

to receive ACPI fixes for 5.13-rc2.

These revert an unnecessary revert of an ACPI power management
commit, add a missing device ID to one of the lists and fix a
possible memory leak in an error path.

Specifics:

 - Revert a revert of a recent ACPI power management change that
   does not need to be reverted after all (Rafael Wysocki).

 - Add missing fan device ID to the list of device IDs for which
   the devices should not be put into the ACPI PM domain (Sumeet
   Pawnikar).

 - Fix possible memory leak in an error path in the ACPI device
   enumeration code (Christophe JAILLET).

Thanks!


---------------

Christophe JAILLET (1):
      ACPI: scan: Fix a memory leak in an error handling path

Rafael J. Wysocki (1):
      Revert "Revert "ACPI: scan: Turn off unused power resources
during initialization""

Sumeet Pawnikar (1):
      ACPI: PM: Add ACPI ID of Alder Lake Fan

---------------

 drivers/acpi/device_pm.c | 1 +
 drivers/acpi/internal.h  | 1 +
 drivers/acpi/power.c     | 2 +-
 drivers/acpi/scan.c      | 3 +++
 drivers/acpi/sleep.h     | 1 -
 5 files changed, 6 insertions(+), 2 deletions(-)
