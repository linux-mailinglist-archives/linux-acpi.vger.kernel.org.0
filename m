Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452A34563E4
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Nov 2021 21:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhKRUP7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Nov 2021 15:15:59 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:33652 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhKRUP7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Nov 2021 15:15:59 -0500
Received: by mail-ot1-f49.google.com with SMTP id h12-20020a056830034c00b0055c8458126fso13066569ote.0;
        Thu, 18 Nov 2021 12:12:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xCJvoNP9xPpvAhhW7OBxum0DMmM9X30KVudKfGO1YfA=;
        b=j52PHK+UmpPLasK1WXVJVO6ILZtJSwVWN+pwdK9pw8ky8fGleaoBu+gPoraRCG4GYM
         i8Kk7g5ivTJBktpi8KS6fPF7eZh/QEA1sAkarf1jE5C5QyvmYpi+Ro1eoD+9tnGZzxjp
         0xR18j6fw53c3xuyA+mGvnn7Y31YkdgnfTd/ccevrXoOv5t+A1xqwTT6CqJarEn+prld
         x0dwk5BeWzqvA6YGn1MSOR+LuMbuZdbVl/S+9HXmhXv/xNBnC0/n8VHOuXHBvNKsi1ma
         KZXjUydGpFqfuQT/NzbiGslEAtYrKgzZYUp4SQUo50RwKjP/fnJ2gCCFoyRxog1dGzWn
         hfww==
X-Gm-Message-State: AOAM531wT06kL3eNGTV3rdXT5nKQmAtWaCX5CMFxPd8eye3Qr9Wl+HzR
        Vr2uqxXm5oTmAwoeFZhnpHh8rQR95yJFKuCJM91JXObhwXs=
X-Google-Smtp-Source: ABdhPJzTU1hNiRtKzkzuMdfJ8NsvMU87j/HSYU9ZaEQsebvs3OCgrtLDUPlbAzVJCTQE/h4mWR5tx0wWkdGRXzR7ioA=
X-Received: by 2002:a9d:a64:: with SMTP id 91mr23215364otg.198.1637266378392;
 Thu, 18 Nov 2021 12:12:58 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Nov 2021 21:12:47 +0100
Message-ID: <CAJZ5v0iE0eRnfid-3+_X1+efdVpA4N6LBX2nKYgWo8bOmp7Arw@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v5.16-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.16-rc2

with top-most commit 3b2b49e6dfdcf423506a771bf44cee842596351a

 Revert "ACPI: scan: Release PM resources blocked by unused objects"

on top of commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf

 Linux 5.16-rc1

to receive an ACPI fix for 5.16-rc2.

This reverts tbe change attempting to release PM resources blocked
by unused ACPI objects after device enumeration, because it caused
boot issues to appear on multiple systems.

Thanks!


---------------

Rafael J. Wysocki (1):
      Revert "ACPI: scan: Release PM resources blocked by unused objects"

---------------

 drivers/acpi/glue.c     | 25 -------------------------
 drivers/acpi/internal.h |  1 -
 drivers/acpi/scan.c     |  6 ------
 3 files changed, 32 deletions(-)
