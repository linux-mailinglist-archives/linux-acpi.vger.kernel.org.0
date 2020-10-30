Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209E22A0B2A
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Oct 2020 17:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgJ3Qcs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Oct 2020 12:32:48 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36817 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgJ3Qcs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Oct 2020 12:32:48 -0400
Received: by mail-ot1-f68.google.com with SMTP id 32so6087082otm.3;
        Fri, 30 Oct 2020 09:32:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=cPd38CtT53z1e5QGFlhf5EK9D4LjkP3P819XBl50Xb4=;
        b=JVRXNwuPF9KEGPWE+fBjLWchEsMbMeUcKstE7l5bUnoUuIJZSeQizgGEP9SCBm93Rf
         PJ0aRsMCpXBO1/GKgKMo1Ukie+C1e0Qn1DUOMsEI0nL8sTlJrKj5zCZSn1XvClGN/xSG
         unAAIa8vskzaZP7/p+EmHdrU4xZKZcb03k+pF+9iaBYvkxqjSs3QBVZGoutMnyeHaUUA
         pJgrBk/Db36zas9A8XxGJ5HYyJmeIkKuCrBkmUTmecBKn6D8Sh8jaD+meV++dTp38PLt
         kMHOi/ls2p35WTqNLBempqIDysHfw53a/baPLYuTi564o4smLfYpPGNv2c9TgKiIcZkl
         Ls0g==
X-Gm-Message-State: AOAM530jKyx8Os2goRkzpJq7mwPIaKMImR7RxApJK1X9qQGYDWlzNmez
        gYIYsHYsruHLN89hC+XiHzWeuFjEhcEOSziQxHvt6VWccKY=
X-Google-Smtp-Source: ABdhPJz/JU4qu/rce6xtL2Dcr9FnmKUxYYUjwNN5LkICyOcsch/dgKkW25It8sxaUC3TJNhvRH8y46QCOsqMFbCuwPk=
X-Received: by 2002:a9d:734f:: with SMTP id l15mr2458639otk.260.1604075567900;
 Fri, 30 Oct 2020 09:32:47 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Oct 2020 17:32:37 +0100
Message-ID: <CAJZ5v0gYkVwz1HvMUDPcLya+okWSNiMPkuStGxAjkxcAJXcBsQ@mail.gmail.com>
Subject: [GIT PULL] PNP fix for v5.10-rc2
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
 pnp-5.10-rc2

with top-most commit e510785f8aca4a7346497edd4d5aceefe5370960

 PNP: fix kernel-doc markups

on top of commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec

 Linux 5.10-rc1

to receive a PNP fix for 5.10-rc2.

Make function names in kerneldoc comments match the actual names of
the functions that they correspond to (Mauro Carvalho Chehab).

Thanks!


---------------

Mauro Carvalho Chehab (1):
      PNP: fix kernel-doc markups

---------------

 drivers/pnp/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
