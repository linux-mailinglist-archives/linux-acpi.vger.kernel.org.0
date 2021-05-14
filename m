Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A36380B08
	for <lists+linux-acpi@lfdr.de>; Fri, 14 May 2021 16:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbhENOGa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 May 2021 10:06:30 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:45995 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbhENOGa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 14 May 2021 10:06:30 -0400
Received: by mail-ot1-f53.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so5397777otc.12;
        Fri, 14 May 2021 07:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GvnE1ADB9+I/WYT7tF9DV2btsg6bTF8SeNiQgcN4m0w=;
        b=End/WvO6iOlMXu/U9VAHI2zZW3dn3UUlul2ljYPao0+WCj3rUeFeZwPxhcN15+sZNW
         tQpanrGhSsohXN8LTnlFB71avK1X2Zrh0sDv5MeJtMxwmNRLIrFrKGiWnUMyr8UgAd1I
         gIkSCi5PC8qz1gf7Hq5hDif7FwjsDnbr5kqecnFFTpdS7uTZ743L+BEkXjzwZ2UkA3oq
         pVlYH1vtxmEas2Zdv8bdS1AjIjaIhv+3PJUCDwlkP07xehJWX8qTWlxNbcajaGIhYWxh
         XuY3HW6M2aRfDI39yZL1HiXZisVZl0mCin2OiAkqo2pGQOHa758Xm2M2wDXV2vBguMYa
         x7hw==
X-Gm-Message-State: AOAM531Krp2tJlUPxgPiVqD4qATfJk6ivH5zk7Kso2YDbEieFtbC5tNH
        xz2fotfBmg91MLMekofrlLI4D2CfIs/5jOJj4PF8rTesXy4=
X-Google-Smtp-Source: ABdhPJzeaoY6xz4M2hQ6Bbv7PLM1iJ74+qY3c+/pXro1wEBAxQ7wotJ3aSHgxmHSlzyuZAlfDqOFTQ3bwxiXGrS5IcI=
X-Received: by 2002:a9d:3bcb:: with SMTP id k69mr41505230otc.206.1621001117692;
 Fri, 14 May 2021 07:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210430124224.6383-1-wsj20369@163.com>
In-Reply-To: <20210430124224.6383-1-wsj20369@163.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 May 2021 16:05:06 +0200
Message-ID: <CAJZ5v0g--YTuzHiMTiVwuEH2Z87k+JCmynqqFshZ70yNXuUHew@mail.gmail.com>
Subject: Re: [PATCH] Revert "ACPI: power: Turn off unused power resources unconditionally"
To:     Shujun Wang <wsj20369@163.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Apr 30, 2021 at 2:43 PM Shujun Wang <wsj20369@163.com> wrote:
>
> This reverts commit 7e4fdeafa61f2b653fcf9678f09935e55756aed2.
> It may cause some NVMe device probes to fail, and the system may get
> stuck when using an NVMe device as the root filesystem.
>
> In the function nvme_pci_enable(struct nvme_dev *dev), as shown below,
> readl(NVME_REG_CSTS) always returns -1 with the commit, which results in
> the probe failed.
>
>   if (readl(dev->bar + NVME_REG_CSTS) == -1) {
>         result = -ENODEV;
>         goto disable;
>   }
>
> dmesg:
>   [    1.106280] nvme 0000:04:00.0: platform quirk: setting simple suspend
>   [    1.109111] nvme nvme0: pci function 0000:04:00.0
>   [    1.113066] nvme 0000:04:00.0: enabling device (0000 -> 0002)
>   [    1.121040] nvme nvme0: Removing after probe failure status: -19
>
> lspci:
>   Non-Volatile memory controller: KIOXIA Corporation Device 0001
>
> device uevent:
>   DRIVER=nvme
>   PCI_CLASS=10802
>   PCI_ID=1E0F:0001
>   PCI_SUBSYS_ID=1E0F:0001
>   PCI_SLOT_NAME=0000:04:00.0
>   MODALIAS=pci:v00001E0Fd00000001sv00001E0Fsd00000001bc01sc08i02
>
> This patch was tested in Lenovo Thinkpad X1.

Please send me the dmidecode output from this machine or (better)
attach it at https://bugzilla.kernel.org/show_bug.cgi?id=213019

Thanks!
