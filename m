Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C7A4071B0
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Sep 2021 21:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhIJTIN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Sep 2021 15:08:13 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:46036 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbhIJTIM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Sep 2021 15:08:12 -0400
Received: by mail-ot1-f49.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso3560510otv.12;
        Fri, 10 Sep 2021 12:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=uFOZEV6ekgzmEVVQbYxxF+K/ci1h3bEPDPVoxSGAi5c=;
        b=FU858GXrsxSeoR8+HpxtckfH8I35EqEW6PvdqfHJIXYt2WecJWKPMN/4R0qy5u82gA
         /Gkfn0XXStn2kFv0FkIdovyY1vndo1XKhRb2VKFwu+Axfm+ZYFhNg1mYoc9jd45HmBSZ
         tJh664evmYk02o9NXTlHPCQujcn8x+dTioDvgyWHLCK23pK7D3mhzkOc55y65x6BkHYB
         t2ZauCH1q3YQaNlpi1iGENp8sNjR+9YyFhokMvpZt3YemBAF3l8gbgV1uknDUhhDucZY
         L89ABgHfGH2MdlmEE+NgDVCeIw4aFwGxBVswDZvovgn1uufXEneLOKJ+A7Fj4A1oLWVP
         Oj5w==
X-Gm-Message-State: AOAM532TcxAcrlE2aDZ3osYfvdZXSixE9+BMXrN1N+h4kgYcAxTfvHiV
        3PaPDswpUnD0WYtS/FIhBFtTjM834Tm3MT+xqPOQP8HG/j8=
X-Google-Smtp-Source: ABdhPJx+eNjmU0FR3SzW5vWL8ki3u9UHBEARUkxudB1fof64Hhbpla+7N61K02LCt1TwB4EoENAL1T/vnF3PCCxHyqU=
X-Received: by 2002:a9d:4d93:: with SMTP id u19mr6026686otk.86.1631300821154;
 Fri, 10 Sep 2021 12:07:01 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 10 Sep 2021 21:06:50 +0200
Message-ID: <CAJZ5v0ha6P6u8pC6nXUipY7ZVDBCh6jMum0A5viFUUamVc=V2w@mail.gmail.com>
Subject: [GIT PULL] More ACPI updates for v5.15-rc1
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
 acpi-5.15-rc1-3

with top-most commit 8fbc1c5b91133f7ae5254061d2cb3326992635c4

 Merge branches 'acpi-scan' and 'acpi-prm'

on top of commit 30f349097897c115345beabeecc5e710b479ff1e

 Merge tag 'pm-5.15-rc1-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive additional ACPI updates for 5.15-rc1.

These prevent a confusing PRMT-related message from being printed,
drop an unnecessary header file include and update the list of
ACPICA maintainers.

Specifics:

 - Prevent a message about missing PRMT from being printed on systems
   that do not support PRM, which are the majority now (Aubrey Li).

 - Drop unnecessary header include from scan.c (Kari Argillander).

 - Update the list of ACPICA maintainers after recent departure of
   one of them (Rafael Wysocki).

Thanks!


---------------

Aubrey Li (1):
      ACPI: PRM: Find PRMT table before parsing it

Kari Argillander (1):
      ACPI: scan: Remove unneeded header linux/nls.h

Rafael J. Wysocki (1):
      ACPICA: Update the list of maintainers

---------------

 MAINTAINERS         |  1 -
 drivers/acpi/prmt.c | 10 +++++++++-
 drivers/acpi/scan.c |  1 -
 3 files changed, 9 insertions(+), 3 deletions(-)
