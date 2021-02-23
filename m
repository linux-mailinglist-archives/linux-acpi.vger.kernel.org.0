Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A6D3231D9
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Feb 2021 21:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbhBWUIi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Feb 2021 15:08:38 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:47024 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbhBWUIC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Feb 2021 15:08:02 -0500
Received: by mail-oi1-f180.google.com with SMTP id f3so18921499oiw.13;
        Tue, 23 Feb 2021 12:07:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=VTLM+6PNxNabUGckCe2Rhdt/lr8ZBT+VmG1d5lG8TeE=;
        b=mlpwSkITkLqsv4u88/h5kV4qx09PiGGJCSbM2CSYfplaaJJymjwpfnLEdyILaSZ0a8
         WPDOH+aJNs/jK5gg0BgDbiFUfoM4vBAaVdJ+O/vAj8jwKHudxvF9/Gyyb2j2SmDlxFE3
         iPYUlSCjevIn8RItm40mrwRHzNd1HdlCuC66EHVCV9S/Tk+sweg2TrkPriUKVJCyCKbp
         mLzy7vJNseeDgYqR+kmrxYW9Z1j+c5MRhk+OGuiC3r2cSPaWnn/mH2y/ZIkVA1ccXc1e
         DE5ReAPtNs/n4FJ4CbeRUUuAtXJhbA4onZTcS+G0EqS4f2OvR2C3W+hwrb4qLBKk2FuK
         OB7w==
X-Gm-Message-State: AOAM530N6uxSVkdKRtYmD0l1K1Z34MOa2u0XSDa2fhjldy24uFAwMo9P
        ukRA2XwNwVxi8y093jvAZA1FOm5SEwhj52cXJx97CQXhAIg=
X-Google-Smtp-Source: ABdhPJwYhKvHiMNiv8EnMJxWAcTb5Ity+CGexm06ZXCyA1vnT3lCvDxTvigyFCZBIoqJQ6UxLXEf12bZ8nRUs7X/Tnc=
X-Received: by 2002:aca:5dc4:: with SMTP id r187mr320156oib.69.1614110841713;
 Tue, 23 Feb 2021 12:07:21 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 Feb 2021 21:07:10 +0100
Message-ID: <CAJZ5v0g9-LpR2JM4VBotHQhCKj5jYPdW3g_eqh0pGMkRhoSUWA@mail.gmail.com>
Subject: [GIT PULL] More ACPI updates for v5.12-rc1
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
 acpi-5.12-rc1-2

with top-most commit 833a18d0715d97db8fa5e8d7eb614fc143ac78e4

 Merge branch 'acpica'

on top of commit 2d4eb3317248c55268685e80f692c2eefb485a31

 Merge branch 'acpi-messages'

to receive more ACPI updates for 5.12-rc1.

These fix a race condition in generic_serial_bus (I2C) and GPIO
Operation Region handling in ACPICA and reduce some related code
duplication (Hans de Goede).

Thanks!


---------------

Hans de Goede (2):
      ACPICA: Fix race in generic_serial_bus (I2C) and GPIO op_region
parameter handling
      ACPICA: Remove some code duplication from acpi_ev_address_space_dispatch

---------------

 drivers/acpi/acpica/acobject.h  |  1 +
 drivers/acpi/acpica/evhandler.c |  7 +++++
 drivers/acpi/acpica/evregion.c  | 69 +++++++++++++++++++++++++----------------
 drivers/acpi/acpica/evxfregn.c  |  2 ++
 4 files changed, 53 insertions(+), 26 deletions(-)
