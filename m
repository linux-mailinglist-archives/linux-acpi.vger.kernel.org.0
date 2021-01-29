Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B93308C34
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Jan 2021 19:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbhA2SMK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 Jan 2021 13:12:10 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:37252 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhA2SMJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Jan 2021 13:12:09 -0500
Received: by mail-ot1-f46.google.com with SMTP id h14so9483052otr.4;
        Fri, 29 Jan 2021 10:11:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Q4oVQSes+s6zJZHgbO5XBLVNfA/GuxCMLqREk38t5eY=;
        b=ks8y6omQQgpIhUdOTOy7iEN9cqnBaWv42XlcOTcpZvmsfFZ2i1jLe4zt01hOrll6Np
         8/f37rT3LSPgw1x3IAHGdWQP1O9fzXKTlaRE/fG8LhzIz7wMTC40nJ3uNi4ihbrBhnC6
         HXyhS+2YIoJyXhqQgtPA3wFqx6XWUxvP6F+eF2ubLL82vKGbJ0MCA5lKY2JfcAGOX2X6
         C3j9C3LqbavtLRWm/ZliRNG+VBc3SgD1rMI7nOLNF8FFSrE4dFowPWEY7gTJeyjBONjx
         sBJMdTdquBWIu2HuNwrIeuV75rZ5dSWrUKwGKepD9DZUwi2cugjDCSd2nk6gL5kBUOTu
         wTEQ==
X-Gm-Message-State: AOAM531IFgnWlrkXA3SJEI/WbBFts/0aju2kkBqhN6SiqsCe5WJb26uB
        AJ0A8QMXnbExuHKpuqUjdV9Rzw1X0HlofpR7WeMLWaxObyo=
X-Google-Smtp-Source: ABdhPJwWVTb27M10LImI8Ql5aBqCCDUdwfufJ8qd1DtyyXgYufMEHKn8AWOxGEY7QhOFvF99va4Q0cU7gOHVnXt5qiI=
X-Received: by 2002:a9d:7a4a:: with SMTP id z10mr3775525otm.206.1611943888425;
 Fri, 29 Jan 2021 10:11:28 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 29 Jan 2021 19:11:17 +0100
Message-ID: <CAJZ5v0is8qQ91Nx_hhMgc3Ga8NgFbE-JAu03=M-L9sCpf8pVmQ@mail.gmail.com>
Subject: [GIT PULL][Resend] ACPI fixes for v5.11-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[Resending, because it hasn't made it to the mailing lists, not sure why.]

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.11-rc6

with top-most commit b584b7e9630acc65a4d01ff5f9090d1a0fb3bbb6

 Merge branch 'acpi-sysfs'

on top of commit 6ee1d745b7c9fd573fba142a2efdad76a9f1cb04

 Linux 5.11-rc5

to receive ACPI fixes for 5.11-rc6.

These fix the handling of notifications in the ACPI thermal driver
and address a device enumeration issue leading to the presence of
multiple MODALIAS entries in one uevent file in sysfs in some cases.

Specifics:

 - Modify the ACPI thermal driver to avoid evaluating _TMP directly
   in its Notify () handler callback and running too many thermal
   checks for one thermal zone at the same time so as to address a
   work item accumulation issue observed on some systems that fail
   to shut down as a result of it (Rafael Wysocki).

 - Modify the ACPI uevent file creation code to avoid putting
   multiple MODALIAS entries in one uevent file in sysfs which
   breaks systemd-udevd (Kai-Heng Feng).

Thanks!


---------------

Kai-Heng Feng (1):
      ACPI: sysfs: Prefer "compatible" modalias

Rafael J. Wysocki (1):
      ACPI: thermal: Do not call acpi_thermal_check() directly

---------------

 drivers/acpi/device_sysfs.c | 20 ++++++--------------
 drivers/acpi/thermal.c      | 46 ++++++++++++++++++++++++++++++++-------------
 2 files changed, 39 insertions(+), 27 deletions(-)
