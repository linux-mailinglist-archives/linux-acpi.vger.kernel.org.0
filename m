Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9297762B23
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Jul 2019 23:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbfGHViL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Jul 2019 17:38:11 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33215 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730630AbfGHViL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Jul 2019 17:38:11 -0400
Received: by mail-ot1-f67.google.com with SMTP id q20so17771136otl.0;
        Mon, 08 Jul 2019 14:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=vZ/t7rbdOPKcsM8PmAfHvKdGH2fc+Rnq6ySUamyqiuw=;
        b=g9SoGg4MPWfEyc7CusibUL58PqKjCybMzMyjb0MVHlHFcj3ETAPWV+BMXE4lUHUsge
         C+DayohhR0FF0UMqShzdNuw1idJoDJOmhMnlkFP9DuSSw3RH0xkItoHBD5RVzU9IuSFL
         3Hb1HAvptVZXXaBTdsMAQXkDe7wnSFzinbLXhN8skJg+qTH2o2yxwwxqD93VUuq99xci
         q/DpMjumhjOlzfdnXb7cv7+1vCYf656YbzUZY28VVwAGXRXxghPVtXeiVOe9Vrnkfx2B
         nnkHc9YXANdWQUVfMb02JuVt0HFb0Qcna0g2JB+xBbJO3X6pG+4X0hZDTzScZq2GFJCk
         Iqsg==
X-Gm-Message-State: APjAAAV6JYhdWKoR2VGgzVlv1i5SXy3hO8+zfueIICgt+FCOexSJAQIc
        gE+4f/gxzUoTCEJkZpgdZbqwLeVfZvDqHWQrDeryrzKI
X-Google-Smtp-Source: APXvYqyftAyxiOcH796wgu4YRcIDE60dFcJqAX+1UOd4+3mXYCgkZJxEdaiZjqW4L9r7EF4OdH3Hj76NE7fs5ktvilE=
X-Received: by 2002:a9d:6959:: with SMTP id p25mr15356458oto.118.1562621890348;
 Mon, 08 Jul 2019 14:38:10 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 8 Jul 2019 23:37:58 +0200
Message-ID: <CAJZ5v0gSbQy-GFz2Bo4bGGj7WemDvS21TW6=VHVvivDZCvEKWg@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v5.3-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.3-rc1

with top-most commit 64372c0b7dcbc9ad08b1bad877ae8d8cddb62e45

 Merge branches 'acpi-apei', 'acpi-doc' and 'acpi-soc'

on top of commit 6fbc7275c7a9ba97877050335f290341a1fd8dbf

 Linux 5.2-rc7

to receive ACPI updates for 5.3-rc1.

These update the ACPICA code in the kernel to upstream revision
20190703, fix up the handling of GPEs in ACPICA, allow some more ACPI
code to be built on ARM64 platforms, allow BGRT to be overridden, fix
minor issues and clean up assorted pieces of ACPI code.

Specifics:

 - Update the ACPICA code in the kernel to upstream revision 20190703
   including:
   * Initial/defalut namespace creation simplification (Bob Moore).
   * Object initialization sequence update (Bob Moore).
   * Removal of legacy module-level (dead) code (Erik Schmauss).
   * Table load object initialization update (Erik Schmauss, Nikolaus
     Voss).

 - Fix GPE enabling issue in ACPICA causing premature wakeups from
   suspend-to-idle to occur (Rafael Wysocki).

 - Allow ACPI AC and battery drivers to be built on non-X86 (Ard
   Biesheuvel).

 - Fix address space handler removal in the ACPI PMIC driver for
   Intel platforms (Andy Shevchenko).

 - Allow BGRT to be overridden via initrd or configfs (Andrea Oliveri).

 - Fix object resolution on table loads via configfs (Nikolaus Voss).

 - Clean up assorted pieces of ACPI code and tools (Colin Ian King,
   Liguang Zhang, Masahiro Yamada).

 - Fix documentation build warning, convert the extcon document to
   ReST and add it to the ACPI documentation (Mauro Carvalho Chehab,
   Qian Cai).

Thanks!


---------------

Andrea Oliveri (1):
      ACPI: tables: Allow BGRT to be overridden

Andy Shevchenko (1):
      ACPI / PMIC: intel: Drop double removal of address space handler

Ard Biesheuvel (1):
      ACPI: Make AC and battery drivers available on !X86

Bob Moore (3):
      ACPICA: Namespace: simplify creation of the initial/default namespace
      ACPICA: Update for object initialization sequence
      ACPICA: Update version to 20190703

Colin Ian King (1):
      ACPI: APD: remove redundant assignment to pointer clk

Erik Schmauss (2):
      ACPICA: remove legacy module-level code due to deprecation
      ACPICA: Update table load object initialization

Liguang Zhang (1):
      ACPI / APEI: Remove needless __ghes_check_estatus() calls

Masahiro Yamada (1):
      ACPI: tools: Exclude tools/* from .gitignore patterns

Mauro Carvalho Chehab (1):
      docs: extcon: convert it to ReST and move to ACPI dir

Nikolaus Voss (1):
      ACPI: configfs: Resolve objects on host-directed table loads

Qian Cai (1):
      ACPI: OSL: Make a W=1 kernel-doc warning go away

Rafael J. Wysocki (1):
      ACPICA: Clear status of GPEs on first direct enable

---------------

 .../acpi/extcon-intel-int3496.rst}                 |  14 +-
 Documentation/firmware-guide/acpi/index.rst        |   1 +
 MAINTAINERS                                        |   6 +-
 drivers/acpi/Kconfig                               |   2 -
 drivers/acpi/acpi_apd.c                            |   2 +-
 drivers/acpi/acpi_configfs.c                       |   6 +-
 drivers/acpi/acpica/acevents.h                     |   3 +-
 drivers/acpi/acpica/acglobal.h                     |   1 -
 drivers/acpi/acpica/acnamesp.h                     |   2 -
 drivers/acpi/acpica/dsinit.c                       |   2 +-
 drivers/acpi/acpica/evgpe.c                        |   8 +-
 drivers/acpi/acpica/evgpeblk.c                     |   2 +-
 drivers/acpi/acpica/evxface.c                      |   2 +-
 drivers/acpi/acpica/evxfgpe.c                      |   2 +-
 drivers/acpi/acpica/exconfig.c                     |  16 +-
 drivers/acpi/acpica/nsaccess.c                     |  54 ++++--
 drivers/acpi/acpica/nseval.c                       | 190 ---------------------
 drivers/acpi/acpica/nsinit.c                       |  49 +++---
 drivers/acpi/acpica/nsload.c                       |  12 --
 drivers/acpi/acpica/nsutils.c                      |  12 --
 drivers/acpi/acpica/tbdata.c                       |  13 --
 drivers/acpi/acpica/tbxfload.c                     |   7 +
 drivers/acpi/acpica/utinit.c                       |   1 -
 drivers/acpi/acpica/utxfinit.c                     |  18 +-
 drivers/acpi/apei/ghes.c                           |   2 +-
 drivers/acpi/osl.c                                 |   4 +-
 drivers/acpi/pmic/intel_pmic.c                     |   2 -
 drivers/acpi/tables.c                              |  21 +--
 include/acpi/acpi_io.h                             |   4 +-
 include/acpi/acpixf.h                              |   2 +-
 tools/power/acpi/.gitignore                        |   8 +-
 31 files changed, 131 insertions(+), 337 deletions(-)
