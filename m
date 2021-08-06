Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3093E2F09
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Aug 2021 19:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242095AbhHFRzr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Aug 2021 13:55:47 -0400
Received: from mail-oo1-f54.google.com ([209.85.161.54]:33699 "EHLO
        mail-oo1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242112AbhHFRzr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Aug 2021 13:55:47 -0400
Received: by mail-oo1-f54.google.com with SMTP id e3-20020a4ab9830000b029026ada3b6b90so2447521oop.0;
        Fri, 06 Aug 2021 10:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=gy2jMWufx5g8FWCoY6X1l9X9BFWJNP1jjjJtTzChdEM=;
        b=QB932zNRoXLUoHbaRXN5BYgblhF8PpNK9m0JFZj8EceDKoRt0i/0yBDdMAEpP50YQi
         o+/O6kMSjMZZ4ZwBwqPd7maU1jugX+2drf2Gk4hpnH6QSHm0UXRamRy2y5/M6I0hgSJB
         S1gBwdSIqz15eZN80qUsBiDxRLY8KNnVyd9O+b16cikh218pvVvMGWrwmYka/GkMm+Vz
         xDhTI0Yt6tr4T2AsUTSyXg3rhd3avoGnvLPhWJbfl1rEn3F1Jc4eRgIPXq0KtbKlvKy5
         imYiCBsINWz67Oze+5be4CRKZ0TZD9EltLPrmdcqctzMpBw9jZBjwVhRcdnEzOrkwIsO
         OoRA==
X-Gm-Message-State: AOAM5309ME/XwiKEBbfO0Ct/ykAfIbpMkl4e0hJEUrOkEtr9b6Q+ux2P
        uHO23dYzzZf7V1Rv+NOWy+R3Q6hXjW0bgsIBFMpIu6JIu/I=
X-Google-Smtp-Source: ABdhPJxz31f5DmtQZ/KdLOdB5/QCAX6vwqbT1KSNYk5rMbNZ1DddADX87h7O+qulAjkvXJ8bvD9gYKhxaRgGyC9EgK4=
X-Received: by 2002:a4a:3b85:: with SMTP id s127mr7206072oos.44.1628272531232;
 Fri, 06 Aug 2021 10:55:31 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 6 Aug 2021 19:55:20 +0200
Message-ID: <CAJZ5v0ju+gC_Yt4JUu-BOgL8+YuJ75RDeT7Vk=ACmBVB4F419w@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v5.14-rc4
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
 acpi-5.14-rc5

with top-most commit 6511a8b5b7a65037340cd8ee91a377811effbc83

 Revert "ACPICA: Fix memory leak caused by _CID repair function"

on top of commit c500bee1c5b2f1d59b1081ac879d73268ab0ff17

 Linux 5.14-rc4

to receive an ACPI fix for 5.14-rc5.

This reverts a recent ACPICA commit causing boot issues to appear on
some systems.

Thanks!


---------------

Rafael J. Wysocki (1):
      Revert "ACPICA: Fix memory leak caused by _CID repair function"

---------------

 drivers/acpi/acpica/nsrepair2.c | 7 -------
 1 file changed, 7 deletions(-)
