Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3CA6393574
	for <lists+linux-acpi@lfdr.de>; Thu, 27 May 2021 20:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbhE0SeD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 May 2021 14:34:03 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:39643 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbhE0SeC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 May 2021 14:34:02 -0400
Received: by mail-oi1-f180.google.com with SMTP id y76so1699924oia.6;
        Thu, 27 May 2021 11:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=XILEL23RkvJSsCguY3HUKgkJIH3PmBjKaO6LkzDCX+g=;
        b=rZ2+Zl3/4Jud7bVzunV4Bn5k09kDhls+rC0Ohfg3xgpZ25PA1WNqDL/5m2+ZMXsq62
         vD62/zLwEIhia5j8xy4A4qBcsEsymVxhFmB3t6RI3umf/zLmqPJ4Nqid5eXg3BzZfbd8
         HC4xCIKL9TIoULSBH3tz3oZekgeaWtd0Krf4nVzqIKiiRRcafhgoaMDFFjEklwnGnccz
         XEbiYSRG7wtXjCNmp45324J0G19ZBmsrDpfIRKUKGcSYdTQYfA/DFDx4yGHpWupYAZS2
         df9iOu+AID8i9GzWqZ+jHJF2vTHENIgFscFaUXxMsuHzSUDhHtz2erjPXqRqQFmtj0wd
         K4kA==
X-Gm-Message-State: AOAM5317xykz7XbflVLmMovl5QZcZjjWEJ+vLvjIqB5a0nevCERhRA6d
        AhPx43PInDtL05qiqHbU1Utx1fXWBOCHC15pCupSEiLMqdk=
X-Google-Smtp-Source: ABdhPJy4jW7Dha2Uw4yWvXIYUysnXekRh6Asy8UcXLwOTFnAPXZuCPmBwh2qYicHDWiBgIode1zciR7FQtW3ugC6jqA=
X-Received: by 2002:aca:1910:: with SMTP id l16mr3175684oii.69.1622140347829;
 Thu, 27 May 2021 11:32:27 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 27 May 2021 20:32:16 +0200
Message-ID: <CAJZ5v0i1WebaCZL3q-6rQOexMnYXacD6KTnO1ONcxN1Li01LSg@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v5.13-rc4
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
 acpi-5.13-rc4

with top-most commit 9b7ff25d129df7c4f61e08382993e1988d56f6a7

 ACPI: power: Refine turning off unused power resources

on top of commit c4681547bcce777daf576925a966ffa824edd09d

 Linux 5.13-rc3

to receive an ACPI fix for 5.13-rc4.

This fixes a recent ACPI power management regression causing
boot issues to occur on some systems due to attempts to turn
off ACPI power resources that are already off (which should
work according to the ACPI specification).

Thanks!


---------------

Rafael J. Wysocki (1):
      ACPI: power: Refine turning off unused power resources

---------------

 drivers/acpi/internal.h |  4 ++--
 drivers/acpi/power.c    | 59 ++++++++++++++++++++++++++++++++++++++-----------
 drivers/acpi/scan.c     |  2 +-
 drivers/acpi/sleep.c    |  2 +-
 4 files changed, 50 insertions(+), 17 deletions(-)
