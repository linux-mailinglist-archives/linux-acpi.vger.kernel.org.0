Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932BB20B4EE
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Jun 2020 17:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgFZPkT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Jun 2020 11:40:19 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43762 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgFZPkS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Jun 2020 11:40:18 -0400
Received: by mail-oi1-f196.google.com with SMTP id x83so849782oif.10;
        Fri, 26 Jun 2020 08:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Ok8v13Cv4FCzAZhKNNcmCGL0KKiV49QkXwmc3vVd7B0=;
        b=cduz2Dpy5qGzVnKn6jDT9tHftmyVjjrMY0w9T9AHFhXBvERV+JwijoCNzs2mqulvun
         7rlRR1YgRPz49Y7xpHezWoG1AeKqQ992Dyhunc02pPPXmcEM19YWqAuJSH1mY0T/xPRb
         vDhT56pMe9Z/k7R1YvEcM0cQwxDl0i1FWtv7tWsKzi7a/vZRGOTRg4EHUqqurfwtymyq
         iruD4uJlO8HmJmTfairFPA6kZdvlfiQGjjs/vfYnug1QGTAGhDQWLQMyZ0seJeFfYsed
         zo3zK/PONx0Qt4+IXN3KHLo1CRMmWb80+9PCJcV0G3gkQyCdyCyKBCWWOhXDH1QPP2On
         2MUA==
X-Gm-Message-State: AOAM531lJwQZV72P05Ke+IgmfmAeR9yzw6YlfcQOhVy7hw4PxxwJEOQ0
        Ui8lzNd7chbd/7mgszp98TblXCkBZoURQUv6yU7kwIgt
X-Google-Smtp-Source: ABdhPJyFzJUv+9yld/k8cWXllEHV9YDbGccM+bEVkP7RC+fybeXuXq/EhC4eytap3n/oDcGGEG/vx7NoRbbJGipECIw=
X-Received: by 2002:a05:6808:99b:: with SMTP id a27mr2839510oic.68.1593186017715;
 Fri, 26 Jun 2020 08:40:17 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 26 Jun 2020 17:40:06 +0200
Message-ID: <CAJZ5v0iCm=bku-rKaOLveA-Kr0NbJ0Wp3mvQGTv2G9mpjJZpxg@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v5.8-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.8-rc3

with top-most commit 0f29c20bf4342c7757d9f4bf81159b02498b1b0d

 Merge branch 'acpi-sysfs'

on top of commit 48778464bb7d346b47157d21ffde2af6b2d39110

 Linux 5.8-rc2

to receive ACPI fixes for 5.8-rc3.

These prevent bypassing kernel lockdown via the ACPI tables loading
interface (Jason A. Donenfeld) and fix the handling of an ACPI sysfs
attribute (Nathan Chancellor).

Thanks!


---------------

Jason A. Donenfeld (1):
      ACPI: configfs: Disallow loading ACPI tables when locked down

Nathan Chancellor (1):
      ACPI: sysfs: Fix pm_profile_attr type

---------------

 drivers/acpi/acpi_configfs.c | 6 +++++-
 drivers/acpi/sysfs.c         | 4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)
