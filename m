Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED11316D23
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Feb 2021 18:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbhBJRqT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Feb 2021 12:46:19 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:41955 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbhBJRqQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Feb 2021 12:46:16 -0500
Received: by mail-wr1-f41.google.com with SMTP id n6so3533920wrv.8;
        Wed, 10 Feb 2021 09:46:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=zgBAojcyhJWbv1E+GzHMD8bBo3LM9waajJfrvw4DAmo=;
        b=JGmhPqsE7S1VBBd9iXxMinRrSc9vrokOhDX7RxBRGkZpG1Rr57V5fLviYwPLOGn4H4
         oPve/LOv1If7HaDbrfY8E1nvvpMHjc7//+0Csz9nqEA/J5lTnp7kOnJuJsSBdlQdJOE3
         ss3AIeCaJ5XHpF5KN98ZhHAqfH41Njh4GcoNEWHhNc+87Y7TtSQuQ3wTGtItiSKx/R5V
         L1AB9n4xqsYY7a2P/VWABKgGZQ5jroMkc54l4+Q/oWkTpOThEDst4CWDWrG/HPXWxb9V
         h+C82oOs55bgQR1QFdInihTSxPYEQooIfWBLSXG3D59efT0EDWdPiJmJ8XFHe9t+Jgr8
         rCzg==
X-Gm-Message-State: AOAM533aDhODt/vlEVhVKRiYceZp657bQl6XSd7tDgOhIhl8GL7W9asP
        Rx4TCbv1PzbEYv18vah13IJiVXtzuUyFmsq7uUtTi5TZZNk=
X-Google-Smtp-Source: ABdhPJyziveJkAi3mG61RgtHSJANHb/BKK9fHYE5DRSIRzxvgHBFNrnIuzttYsDK5nSWqwfIgK1RBjO6FBSjwRasaNM=
X-Received: by 2002:adf:e411:: with SMTP id g17mr4983803wrm.296.1612979134318;
 Wed, 10 Feb 2021 09:45:34 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 10 Feb 2021 18:45:22 +0100
Message-ID: <CAJZ5v0ikQ6D0V2c7xL0_jHm+UwiwqgRSSm=4fCqPkkApZe54Ow@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v5.11-rc8
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
 acpi-5.11-rc8

with top-most commit fe0af09074bfeb46a35357e67635eefe33cdfc49

 Revert "ACPICA: Interpreter: fix memory leak by using existing buffer"

on top of commit 92bf22614b21a2706f4993b278017e437f7785b3

 Linux 5.11-rc7

to receive an ACPI fix for 5.11-rc8.

This reverts a problematic ACPICA commit that changed the code to
attempt to update memory regions which may be read-only on some
systems (Ard Biesheuvel).

Thanks!


---------------

Ard Biesheuvel (1):
      Revert "ACPICA: Interpreter: fix memory leak by using existing buffer"

---------------

 drivers/acpi/acpica/nsrepair2.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)
