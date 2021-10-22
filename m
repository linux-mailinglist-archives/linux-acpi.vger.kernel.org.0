Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6FE437D0C
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Oct 2021 21:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbhJVTDf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Oct 2021 15:03:35 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:33523 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbhJVTDd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Oct 2021 15:03:33 -0400
Received: by mail-oi1-f172.google.com with SMTP id q129so6283587oib.0;
        Fri, 22 Oct 2021 12:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=sVPsYavfjqxFWrItFViHXcG8XKwEKF8PjeSz3vyL0+o=;
        b=Z+HVPS3Ed/3hkqIlogw66ybqYc797coIGXi5FhBpX2uwZysuLafjKzZHxHnXSbPWEu
         D6yo8Mz/YNhAZCWU0n/ZKyznq/n/QXEUnjqTp3Gz1FjU/n/Sf+H7/ztcIvvMahFxMJk4
         VSd2Rw+TXnMx9a3qu4q1fOyCSVlRhGLSN1OKu8luC54skuNdez/MK4o7yqP5jfcrhc3K
         LWovbry9Klqtd3YxheGbBNYEERFmqgK770uNAGqq133kYI8h/3oed2dF3sgAmT9MWKhQ
         JgKP3degT+RBVSDGPUKYDZ3AbYdm1Vu48Pc5ER/+9Gwld+3gDzyYZPcySZ0/VNKcdaGg
         wC4Q==
X-Gm-Message-State: AOAM533iAAPFNAvdN42v4+/H4klsT3hW6oLnteL1udl8H2tseY2/a49W
        aM7sj3YJCp9d7oDCmfCL4pwuLP+vxDvoIPfUL65LeGuA8B0=
X-Google-Smtp-Source: ABdhPJza4UDhYY1YwYmHq8EtydwJDr1+Sbi/5eSgIKWebxzWVrw4NOs2yyvhyLLfZeDBJeZEuaSTn1GONNhoLsRwbGI=
X-Received: by 2002:a05:6808:e87:: with SMTP id k7mr1117483oil.166.1634929274954;
 Fri, 22 Oct 2021 12:01:14 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Oct 2021 21:01:04 +0200
Message-ID: <CAJZ5v0hTtyu981j91vxH_u3bvHWWBho4YSAhd+os9Zn=sbwe2Q@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v5.15-rc7
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
 acpi-5.15-rc7

with top-most commit 7a7489005a80af97ba289dc0579fccd50af4fe8d

 Merge branch 'acpi-tools'

on top of commit 519d81956ee277b4419c723adfb154603c2565ba

 Linux 5.15-rc6

to receive ACPI fixes for 5.15-rc7.

These fix two regressions, one related to ACPI power resources
management and one that broke ACPI tools compilation.

Specifics:

 - Stop turning off unused ACPI power resources in an unknown state
   to address a regression introduced during the 5.14 cycle (Rafael
   Wysocki).

 - Fix an ACPI tools build issue introduced recently when the minimal
   stdarg.h was added (Miguel Bernal Marin).

Thanks!


---------------

Miguel Bernal Marin (1):
      ACPI: tools: fix compilation error

Rafael J. Wysocki (1):
      ACPI: PM: Do not turn off power resources in unknown state

---------------

 drivers/acpi/power.c          | 7 +------
 include/acpi/platform/acgcc.h | 9 +++++++--
 2 files changed, 8 insertions(+), 8 deletions(-)
