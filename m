Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF83636409B
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Apr 2021 13:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbhDSLfj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Apr 2021 07:35:39 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:42959 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhDSLfi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Apr 2021 07:35:38 -0400
Received: by mail-oi1-f170.google.com with SMTP id n140so35079298oig.9;
        Mon, 19 Apr 2021 04:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7K5odPDOES5CPhUMgYhbew2lZw0WkcvFtDvEI9ulVZg=;
        b=YLUvRdaiVLDSeBY35KjuRS9H5IQq/MktX32t8XzXP9D3WQhtXdaetEvTyQ0meMfS/W
         ed+KW7afk7qRjipiKxwN8/YTgFywau19z2VaiJ/DHhfb6uLyRn0HJ9W/0apGIJlKwGYO
         qVpuEt4G9zczbaHGmxG9dYC8nRn/2oZZTog3PhhV5ZXQt7XaUzFqnEpVbPO3NF8u99gq
         gs72NWEQFpLwbXXix2dZZ1bYsXOaix1APQ04iDJeubxuE1paO3cdCboi+ikmbICzsVdl
         pCcxueUEiU10wxMYF12mZDJnzWVITTb2/5DvuoPUUGVgVSvO3tDiPJE0Y0m611xhQVAj
         GIBw==
X-Gm-Message-State: AOAM532gAv1g6l6JHg1WF2FlgJFCqPCFFdzrs4Uzgigh/L1b95vgRtxm
        ODvZIVgoiWxrDy72lJnADNQVBs55LY7L/YdM+gi+9xzc
X-Google-Smtp-Source: ABdhPJz3p17brhXUQ7rZMATBBQvPGVxjO/I3EzHx4zT8TmUVuAaxzKSCyQ/ZH+jigKdzsnoddz6wlqngdaCz5S6R8Qc=
X-Received: by 2002:a54:4501:: with SMTP id l1mr15746077oil.157.1618832108958;
 Mon, 19 Apr 2021 04:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210419090750.1272562-1-kai.heng.feng@canonical.com>
In-Reply-To: <20210419090750.1272562-1-kai.heng.feng@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 19 Apr 2021 13:34:52 +0200
Message-ID: <CAJZ5v0imLOF-9VCSJdb-A2HR29SFX-HgU5Kh7Uf7COfuHpZMDg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: s2idle: Invoke _PTS for s2idle
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Apr 19, 2021 at 11:08 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> HP EliteBook 840 G8 reboots on s2idle resume, and HP EliteBook 845 G8
> wakes up immediately on s2idle. Both are caused by the XMM7360 WWAN PCI
> card.
>
> There's a WWAN specific method to really turn off the WWAN via EC:
>     Method (_PTS, 1, NotSerialized)  // _PTS: Prepare To Sleep
>     {
>     ...
>         If (CondRefOf (\_SB.PCI0.GP12.PTS))
>         {
>             \_SB.PCI0.GP12.PTS (Arg0)
>         }
>     ...
>     }
>
>     Scope (_SB.PCI0.GP12)
>     {
>     ...
>         Method (PTS, 1, Serialized)
>         {
>             If (^^LPCB.EC0.ECRG)
>             {
>                 If ((PDID == 0xFFFF))
>                 {
>                     Return (Zero)
>                 }
>
>                 POFF ()
>                 SGIO (WWBR, One)
>                 Sleep (0x1E)
>                 Acquire (^^LPCB.EC0.ECMX, 0xFFFF)
>                 ^^LPCB.EC0.WWP = One
>                 Release (^^LPCB.EC0.ECMX)
>                 Sleep (0x01F4)
>             }
>
>             Return (Zero)
>         }
>     ...
>     }
>
> So let's also invok _PTS for s2idle.
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/acpi/sleep.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 09fd13757b65..7e84b4b09919 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -698,6 +698,7 @@ int acpi_s2idle_prepare(void)
>         }
>
>         acpi_enable_wakeup_devices(ACPI_STATE_S0);
> +       acpi_enter_sleep_state_prep(ACPI_STATE_S0);

The system is in S0 already at this point, so not really.

Please use a quirk to address this.

>
>         /* Change the configuration of GPEs to avoid spurious wakeup. */
>         acpi_enable_all_wakeup_gpes();
> --
