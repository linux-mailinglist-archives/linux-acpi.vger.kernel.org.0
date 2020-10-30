Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5B32A0B1D
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Oct 2020 17:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgJ3QaV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Oct 2020 12:30:21 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34363 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgJ3QaV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Oct 2020 12:30:21 -0400
Received: by mail-oi1-f194.google.com with SMTP id l62so1564948oig.1;
        Fri, 30 Oct 2020 09:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=2+04HUHyNvB2dWKZqMu50rtGHzpdRig+Y0RoGuV51Q8=;
        b=eIOUk47yXQW1kouq5ZUr68lexeLt4irSe+/j09LqwaKglMyaQVrGDK8pLSMwBNnNpD
         SX5Hl+Ee5033ZtVgwCYoghqUk85MNptiqq1LTmGx9SZMlNP4HV5ZzQkwQ8syAfLXNhc9
         9006WLOfr+a/bwCCcUn04qbbp/lGI5jHV8BOWeXMg+FcdfAYzPX6yuNRZsfY6s9Ppki3
         pJGzIt8NpKphgt7k9+CnOwxP1zeeD8n/H6vINJAyVzQljjK9JDu16LnmR887ft0862Zr
         po99VIOoscfZ5Uch3xM6QjIIF8o3tpGqfTHNmB+3SaRvtReX7Erq7u0QCeoowQlQX1tE
         KFGg==
X-Gm-Message-State: AOAM533fwrRhsmQU7v2ce8iCpKERRFE2aSPOknc6TSdG/BwsAYRItD0O
        eixDQwJBiLfAT5r2BN4mq10eRTKOonxozrzg39g=
X-Google-Smtp-Source: ABdhPJwerNnfgT5SUDvFOoVErp8Ja5fQETkIuxlUNoo323jNkmX6iKJhIVhgprR1OL3B/6cpe9yNLF9rz9ESEvfytiQ=
X-Received: by 2002:aca:30d7:: with SMTP id w206mr2221950oiw.69.1604075420623;
 Fri, 30 Oct 2020 09:30:20 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Oct 2020 17:30:09 +0100
Message-ID: <CAJZ5v0g+mRzT6pscD0WKgTTyNqTLbXPvt9Jn27oQ7jtTVEsUdw@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v5.10-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.10-rc2

with top-most commit 8f7304bb9113c95b256d3aa79a884b4c60a806e1

 Merge branches 'acpi-button' and 'acpi-dock'

on top of commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec

 Linux 5.10-rc1

to receive ACPI fixes for 5.10-rc2.

These fix three assorted minor issues.

Specifics:

 - Eliminate compiler warning emitted when building the ACPI dock
   driver (Arnd Bergmann).

 - Drop lid_init_state quirk for Acer SW5-012 that is not needed any
   more after recent changes (Hans de Goede).

 - Fix "missing minus" typo in the NFIT parsing code (Zhang Qilong).

Thanks!


---------------

Arnd Bergmann (1):
      ACPI: dock: fix enum-conversion warning

Hans de Goede (1):
      ACPI: button: Drop no longer necessary Acer SW5-012 lid_init_state quirk

Zhang Qilong (1):
      ACPI: NFIT: Fix comparison to '-ENXIO'

---------------

 drivers/acpi/button.c    | 13 -------------
 drivers/acpi/dock.c      |  3 ++-
 drivers/acpi/nfit/core.c |  2 +-
 3 files changed, 3 insertions(+), 15 deletions(-)
