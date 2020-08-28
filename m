Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A0B256189
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Aug 2020 21:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgH1Twy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 28 Aug 2020 15:52:54 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38592 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgH1Twr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Aug 2020 15:52:47 -0400
Received: by mail-oi1-f196.google.com with SMTP id j18so1692769oig.5;
        Fri, 28 Aug 2020 12:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=IIC+v+rMB2R/Q/pneIzZqnD45x7WKCthyoc0N8lU/3M=;
        b=m6LyseE/eJyky1ZLmUYW2eR4nFduyugE6r7IUG8BDifu+UGSkeuamCKrO1mTjc2ikV
         2Te5KIKGNUB6cq64cUSWKrY1Zg5YyAINusKuvHiEIEp2CulHz7H5gbVSlwEW0546baXy
         DO6M0XnIHqgag/Kf/CE77GDfu9rW7sL/SwIPfmy4hm433DQVSGuikho/uslUITLUrX8M
         2zhQw79p24Iz3UUbQzB78XBLQRLDJqNX6e5ODk4easwo51hPUxXpNIv4iTo/fgulkavs
         6mImFEckLN49AgKQzXbA/oh9B2sgAJkpiB2MR+KJXywwjWeAt/6aS80Xnl1ZUnWLNVBo
         n9bg==
X-Gm-Message-State: AOAM533s5tPhPb/qxjHMB51NkBZZYxFVUT0HFqoAjc7wN2E90sV4kE/v
        cEOjcdUY0WtlvXMHeJgzNODlB6NuQHhOgcZcZ9rfUFBAV5s=
X-Google-Smtp-Source: ABdhPJyzrF39Y3pm33iU7zZ+oZcAdet36fVvj4TQXxORXmfxOOcbYTO7FRc7wDn+NySVj04B7xEMPU4UW2AT4v+55iU=
X-Received: by 2002:a54:4f14:: with SMTP id e20mr429629oiy.103.1598644366315;
 Fri, 28 Aug 2020 12:52:46 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Aug 2020 21:52:35 +0200
Message-ID: <CAJZ5v0jWBqqU_-w5yn9iGaJZT6wFnaqNHUvE9e6TRKZhxyxFkg@mail.gmail.com>
Subject: [GIT PULL] Device properties framework fix for v5.9-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 devprop-5.9-rc3

with top-most commit c15e1bdda4365a5f17cdadf22bf1c1df13884a9e

 device property: Fix the secondary firmware node handling in
set_primary_fwnode()

on top of commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5

 Linux 5.9-rc1

to receive device properties framework fix for 5.9-rc1.

This prevents the promotion of the secondary firmware node of a
device to the primary one from leaking a pointer (Heikki Krogerus).

Thanks!


---------------

Heikki Krogerus (1):
      device property: Fix the secondary firmware node handling in
set_primary_fwnode()

---------------

 drivers/base/core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)
