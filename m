Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318DD35A233
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Apr 2021 17:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhDIPpM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 9 Apr 2021 11:45:12 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:38436 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhDIPpL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Apr 2021 11:45:11 -0400
Received: by mail-ot1-f43.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so6090959otk.5;
        Fri, 09 Apr 2021 08:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=VEs+wjuKWR88LlB/ggXhauOBmGil7c6BjaxvckBhYQ4=;
        b=a06WFuZgHMU0O82/cciLXpl2GH3Ld1MrXyAWH4PHUpaPARP1QDEJBONN3sZD/KBwXZ
         bNu1rhGqLkv3EB4Z1d3trLpckJKwt2yD2ABa9NEcQGEW10dB8cHyqd5VexxYYpFeMkaS
         EdTyiddNSa0WWd7GGTg57ZUJUEA1T7s4j41UkrLJffi4QtzBZhPVFsGfhaDjbF8tIZZe
         Z29cEFAUU/tGLIecllgtJ8EpmkjiGJt6id6NXJKDm4TdcDCuQFdy/ZsJs18oOVzeB22f
         2vEdwkYagMG0RcS7MjpIWf0eRDenonOOxMfF8xpgUDze+pN5LhzaGDP0zSHpcXJS5moy
         ikoA==
X-Gm-Message-State: AOAM533brFgrZIBi9S+VARh79BVTEprflpVjVcmuel3QVZ9GUB/MFPr9
        49XwiqmWRFoV3laOXOBBECw2kawCws4whQqzb3YzKXBJNJE=
X-Google-Smtp-Source: ABdhPJwWVM3ciwS3ypd+YxjYLoj0wKLxTpwAipbch/ikf/aK4FVW/HTpcTzEtEX8IDCOmsYbognCVSRNejrymwzsKc0=
X-Received: by 2002:a05:6830:55b:: with SMTP id l27mr12669145otb.260.1617983098087;
 Fri, 09 Apr 2021 08:44:58 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 9 Apr 2021 17:44:47 +0200
Message-ID: <CAJZ5v0ii5+k8j-9LwGxjHnJZ5ru3UNSLP=Z_BoE4pOWZN0nTyQ@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v5.12-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.12-rc7

with top-most commit fa26d0c778b432d3d9814ea82552e813b33eeb5c

 ACPI: processor: Fix build when CONFIG_ACPI_PROCESSOR=m

on top of commit e49d033bddf5b565044e2abe4241353959bc9120

 Linux 5.12-rc6

to receive an ACPI fix for 5.12-rc7.

This fixes a build issue introduced by a previous fix in the ACPI
processor driver (Vitaly Kuznetsov).

Thanks!


---------------

Vitaly Kuznetsov (1):
      ACPI: processor: Fix build when CONFIG_ACPI_PROCESSOR=m

---------------

 arch/x86/include/asm/smp.h    |  2 +-
 arch/x86/kernel/smpboot.c     | 26 ++++++++++++--------------
 drivers/acpi/processor_idle.c |  4 +---
 3 files changed, 14 insertions(+), 18 deletions(-)
