Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9770DC0B7
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Oct 2019 11:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406645AbfJRJS4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Oct 2019 05:18:56 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45355 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390499AbfJRJSz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Oct 2019 05:18:55 -0400
Received: by mail-oi1-f194.google.com with SMTP id o205so4605329oib.12;
        Fri, 18 Oct 2019 02:18:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=yTS+cmXgJUMIzlgHO4090rAX20R9LMZN47qkA+zl3mQ=;
        b=qLfffHjEEO54LWsMuqsUOFoUb/j9gabQdM+xDtPpLMRMhUqEvOL+pqEcCUSzIXbDp/
         iexOIZv0NjVJqK4K473eMHeSTUCbLpU9bZd1lrsGySEsKT6ThEuwVjEBBcIOp12agfLD
         jvZrHd/fbbooXek+Ym3f+fOIy2BYM20T4RfVeWNI2RGc+nScqfsWSURzr+neptOX4ud3
         911dg2U8O9fdDKo2wqgkmyMeyPjjiAYk/WCdyK8bX6dr2JBYz5NSPbAfpJ+DjCYV+b/z
         VGBbkG8MGC0HR7mIRcgtCcq9J92FUbVrfpxwzmt1InyOJ3X+9/At3S4SrXnwdToMrOCR
         DlVw==
X-Gm-Message-State: APjAAAUNopiFJhYj0QrcmgH4fqWYnRJWPpeR+mi3h3uFNQjca9lx+Xqt
        1uIzENBRjogzY1MBfMS+LTRyUoKrqbw2sDOlis0=
X-Google-Smtp-Source: APXvYqwB+NtokmhbLo9+mcq8n2p32alBAWd/fffeN1NJeNpDxjiPZ4q0ZHxNUQG4vVrDocgNw5CJTRby4bfxkFDew2w=
X-Received: by 2002:a05:6808:917:: with SMTP id w23mr6816796oih.68.1571390335017;
 Fri, 18 Oct 2019 02:18:55 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Oct 2019 11:18:44 +0200
Message-ID: <CAJZ5v0gG82GLvm45hvwuZGVVhD4cSLpOREaK6Y-QwYs-ymstqA@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v5.4-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.4-rc4

with top-most commit ffba17bb335d6598de613791f8997a5774455068

 Merge branch 'acpi-tables'

on top of commit 4f5cafb5cb8471e54afdc9054d973535614f7675

 Linux 5.4-rc3

to receive ACPI fixes for 5.4-rc4.

These fix possible use-after-free in the ACPI CPPC support code (John
Garry) and prevent the ACPI HMAT parsing code from using possibly
incorrect data coming from the platform firmware (Daniel Black).

Thanks!


---------------

Daniel Black (1):
      ACPI: HMAT: ACPI_HMAT_MEMORY_PD_VALID is deprecated since ACPI-6.3

John Garry (1):
      ACPI: CPPC: Set pcc_data[pcc_ss_id] to NULL in acpi_cppc_processor_exit()

---------------

 drivers/acpi/cppc_acpi.c | 2 +-
 drivers/acpi/hmat/hmat.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
