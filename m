Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150973D3C61
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jul 2021 17:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbhGWOn5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Jul 2021 10:43:57 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:42569 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235569AbhGWOnZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Jul 2021 10:43:25 -0400
Received: by mail-oi1-f179.google.com with SMTP id x15so2157589oic.9;
        Fri, 23 Jul 2021 08:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=yNf3Pq9g0kNIcS3a0kRlWMtxUE0rdOiKEggsk+jWY2U=;
        b=ucPh6yGWTR8sHMdEna7PLok72jObgXVq9+aRa/Va6MsHz6exI0sIEIy5Y7ZWqkCv3O
         kk/b66PhxAM5QAXg1ZKptp00rzuSFfFZtgcu7H6Tnw1Jacc3N3Em5i+Lr2FHk9tt5tqF
         lpJ1sUBO/RFkI9TRmz/U+1BDzdazQfKuMQoD4FpnB57uZC+UmadmFb67uji7s5phqWZZ
         Ltm9e+n84DyUj5Jf9BI+trEJUaJ1skKqQN0mHxwUbIzhhlIedraakuOy/xYv7Bq2uFUh
         NtfOXQU9aWhxTLDe3LapPwj4ngXGK1L94wcNbjSF9Tu1OS+03pV5ME52Tsx6VicPFa0f
         SzUQ==
X-Gm-Message-State: AOAM531igZ2CSX59fn82bSpJlNoatDx0piQ8GPogAsG3mWcGExOVQa2h
        qBj2u96zXGSA3K6CI10BcYZ3M3XCU1wWF461nKMDARhhAyI=
X-Google-Smtp-Source: ABdhPJxkAxGHzhKzoEh7R2M1MZcqelQUYvlK5DPkdJRYb8DP75q7CWBVP8/QHf2YiLgXJcRYO1R2MyqgQQ7OmB11ows=
X-Received: by 2002:aca:4f57:: with SMTP id d84mr3463060oib.71.1627053838476;
 Fri, 23 Jul 2021 08:23:58 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 23 Jul 2021 17:23:47 +0200
Message-ID: <CAJZ5v0gEn3X2FCc0kC-BJ_7D8VXH4XRmhpj3Qn2dEC9K_BUCRQ@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v5.14-rc3
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
 acpi-5.14-rc3

with top-most commit 0b8a53a8444c267114f6b5a85d21153ddea190eb

 Merge branch 'acpi-utils'

on top of commit 2734d6c1b1a089fb593ef6a23d4b70903526fe0c

 Linux 5.14-rc2

to receive ACPI fixes for 5.14-rc3.

These fix a recently broken Kconfig dependency and ACPI device
reference counting in an iterator macro.

Specifics:

 - Fix recently broken Kconfig dependency for the ACPI table
   override via built-in initrd (Robert Richter).

 - Fix ACPI device reference counting in the for_each_acpi_dev_match()
   helper macro to avoid use-after-free (Andy Shevchenko).

Thanks!


---------------

Andy Shevchenko (1):
      ACPI: utils: Fix reference counting in for_each_acpi_dev_match()

Robert Richter (1):
      ACPI: Kconfig: Fix table override from built-in initrd

---------------

 drivers/acpi/Kconfig                       | 2 +-
 drivers/acpi/utils.c                       | 7 +++----
 drivers/firmware/efi/dev-path-parser.c     | 1 -
 drivers/media/pci/intel/ipu3/cio2-bridge.c | 6 ++----
 include/acpi/acpi_bus.h                    | 5 -----
 5 files changed, 6 insertions(+), 15 deletions(-)
