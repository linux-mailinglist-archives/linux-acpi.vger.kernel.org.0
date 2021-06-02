Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD613991BC
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jun 2021 19:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhFBRef (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Jun 2021 13:34:35 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:43744 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhFBRee (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2021 13:34:34 -0400
Received: by mail-oi1-f170.google.com with SMTP id x196so3017554oif.10;
        Wed, 02 Jun 2021 10:32:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=RY7O7u2Oyi97lukEthyEStZ/2IoTJtOOho5cKJky/aA=;
        b=iMeUVCCNePTkJp1FWYpX+xSsbnLhrEDsXNmvGL1ApmIb53COnOJQBQY2nCvgjpC005
         Olof0XdiRKsNB/9IFghAam4DJyFYcvbRM+j16B8Cu0b8yY43uiPZVN3FEcda6oUFakL0
         wm5w+ppGxOZ4zzKX+Vn9OqJWqlPDV+W2qLz6BYfDa+36DQ/As8HE+hWDCtUuOAQRCxhc
         KsHdRLcE+S/0AihDZdW5jKGm29h6zjw0H44Lw8KmniHvbXw1nRjBWW+O7hr7nE1ud6Vx
         mvkb7HoxDwTGq22HTIXxYozIfBJHZY4mV3xOgXIj9gfT4OPv2Mwme5v74njdsnxwRJV8
         uapg==
X-Gm-Message-State: AOAM530/7w3wXZgvdjT0scKP4cE9K/6rDb5pm76QEVdoJTxcrvnvmkde
        9Gwe75BZfY8rZdWxS+D8nFUP3EKR2IUBv7MrnQH4+rgnpqM=
X-Google-Smtp-Source: ABdhPJw26p+rXGV5H3AebvAZG4D/DeA5t1pKT/+hjmL2KBaSYIwSY5PztzEh6qErrFdaoHPT0mcaXPnrBtn3HpdxMcE=
X-Received: by 2002:aca:b406:: with SMTP id d6mr14684243oif.71.1622655170820;
 Wed, 02 Jun 2021 10:32:50 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 2 Jun 2021 19:32:39 +0200
Message-ID: <CAJZ5v0hCofs+k5a-U=xcEwBTtTmGweAU1OkhJRmNu9TBuoJzrg@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v5.13-rc5
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
 acpi-5.13-rc5

with top-most commit e4dfe108371214500ee10c2cf19268f53acaa803

 ACPICA: Clean up context mutex during object deletion

on top of commit 8124c8a6b35386f73523d27eacb71b5364a68c4c

 Linux 5.13-rc4

to receive an ACPI fix for 5.13-rc5.

Fix a mutex object memory leak in ACPICA occurring during object
deletion that was introduced in 5.12-rc1 (Erik Kaneda).

Thanks!


---------------

Erik Kaneda (1):
      ACPICA: Clean up context mutex during object deletion

---------------

 drivers/acpi/acpica/utdelete.c | 8 ++++++++
 1 file changed, 8 insertions(+)
