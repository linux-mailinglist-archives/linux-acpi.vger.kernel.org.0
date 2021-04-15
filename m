Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72C5360F87
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Apr 2021 17:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbhDOPzl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Apr 2021 11:55:41 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:33716 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbhDOPzl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Apr 2021 11:55:41 -0400
Received: by mail-oi1-f171.google.com with SMTP id l131so19691474oih.0;
        Thu, 15 Apr 2021 08:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=WhJn/GSE0cUrfVR1S5Ls8ABidG57zY9s1o6uvV8ZwsE=;
        b=lnBoJRhMNjRQQZHW/D9W4FW/U+9T+HUALTJZ99QOK+pyqSNnU6makcl2Y6wruF+qr+
         VPe5zLj/7Bk8Cue2FmkpUsKdUvnIIT3FxGiSpkoH5H8lCU8SczYEObPPoge1MSg58sSR
         gd7/qVRDKCsiUV4ubCrjiPYkIK3yQ/dRXmvz/cw22edv2FrsSFsBUC3FGH4RoJb8hcut
         ZhbNXo5qZRy9oWBlSydXsnLrPdPswMwLE9rWSkgD4Gsqn6E5v9Q06XNqpRUapfH9VYlW
         5GSQB17D5ZAjJKpAcgrNRyY2OT/GzSzmeF+mk7kTjabHNRfveSX4Z5ZAxbq2BwcEv9NL
         ieAw==
X-Gm-Message-State: AOAM53283H60qgp+zS26bTJMS4vNelKxIKkRD66eyc6zdYx/XUsCifii
        QyQzOBZwgo3WTBX13AwInSIfX01lhoKlk91Q13Y=
X-Google-Smtp-Source: ABdhPJx1sUDoDakLHoQUUKWVbWP/1OAHArktr0FySyEp/DnKImkzmq5bdVLZHEUe0rfHur5HpACsVhMz3HDH3GADRKQ=
X-Received: by 2002:a54:4501:: with SMTP id l1mr3086865oil.157.1618502117774;
 Thu, 15 Apr 2021 08:55:17 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 15 Apr 2021 17:55:06 +0200
Message-ID: <CAJZ5v0iGcYnp1Skmu6_9xfOTj9f--8J71u0kxV0jC8HGwDp8Ng@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v5.12-rc8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.12-rc8

with top-most commit 6998a8800d73116187aad542391ce3b2dd0f9e30

 ACPI: x86: Call acpi_boot_table_init() after acpi_table_upgrade()

on top of commit d434405aaab7d0ebc516b68a8fc4100922d7f5ef

 Linux 5.12-rc7

to receive an ACPI fix for 5.12-rc8.

This restores the initrd-based ACPI table override functionality
broken by one of the recent fixes.

Thanks!


---------------

Rafael J. Wysocki (1):
      ACPI: x86: Call acpi_boot_table_init() after acpi_table_upgrade()

---------------

 arch/x86/kernel/setup.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)
