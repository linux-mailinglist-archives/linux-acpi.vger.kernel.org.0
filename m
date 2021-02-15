Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE3C31C1E9
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Feb 2021 19:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhBOSsn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Feb 2021 13:48:43 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:41256 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhBOSsJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Feb 2021 13:48:09 -0500
Received: by mail-ot1-f49.google.com with SMTP id s107so6904757otb.8;
        Mon, 15 Feb 2021 10:47:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=CLi2nMYytmuw71G7e3zv1nZbTFI8Wm4xUSyCfuFPngI=;
        b=TOVN7GDTpCGNcvuRzdxW/VIEgdoF4P4k7HhW+gSdbZDnLbl3jLBJdJed0vl779ZCur
         38mXPpBl1tDZHqLVI3P3DOw7aOixM2CMAm9CcVO7iND+H9PWXAnt6ILiLvxdoDdsJks0
         mIJLEe4g3XI9cNEgsuVFYFYWq8kkvWX9PACbj8J9gyq4XiBwM+knAza+kjZrUxkC2FGO
         w7PON7g28mXlgg3pmuMbjhnAU6iDP7szENjuXjDUGXjoPduGagaEfcQO1zpByWUPsa9m
         e2bFXFvx0Qnx2PEhCF5HENisqUfzIjEYwF7EABrg95oBwpvlcAEKcdIODDfbICjd0NbO
         SNgA==
X-Gm-Message-State: AOAM531mkDOOAUDt1JmjBdP3CxJ58kgEZUaeFq+asFzkrbuiCYtX6f3O
        8R3mZPRomGNH9cGHgak7Ye/wDXU21GDsl4yrNobsyf36gso=
X-Google-Smtp-Source: ABdhPJw9FRL9oAcZ0FSlk3flW+ksGWmTXWNn4w4kmeFmxN+l0yxp0n4gEZqcuN9EoqyikCLS6IdIVbY24WFV4AOaVgs=
X-Received: by 2002:a05:6830:2106:: with SMTP id i6mr12154242otc.260.1613414845459;
 Mon, 15 Feb 2021 10:47:25 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 15 Feb 2021 19:47:14 +0100
Message-ID: <CAJZ5v0jJqO0FVHptaE27ovFese3wFbwQyKDYdiJB621kYg5U2g@mail.gmail.com>
Subject: [GIT PULL] PNP updates for v5.12-rc1
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
 pnp-5.12-rc1

with top-most commit 96228223933bf5ac920f93862c82449ec28247c0

 PNP: pnpbios: Use DEFINE_SPINLOCK() for spinlock

on top of commit 19c329f6808995b142b3966301f217c831e7cf31

 Linux 5.11-rc4

to receive PNP updates for 5.12-rc1.

These make two janitorial changes of the code.

Specifics:

 - Add printf annotation to a logging function (Tom Rix).

 - Use DEFINE_SPINLOCK() for defining a spinlock so as to initialize
   it statically (Zheng Yongjun).

Thanks!


---------------

Tom Rix (1):
      PNP: add printf attribute to log function

Zheng Yongjun (1):
      PNP: pnpbios: Use DEFINE_SPINLOCK() for spinlock

---------------

 drivers/pnp/interface.c         | 1 +
 drivers/pnp/pnpbios/bioscalls.c | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)
