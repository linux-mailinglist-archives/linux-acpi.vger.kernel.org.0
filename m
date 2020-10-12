Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A95328B274
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Oct 2020 12:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387669AbgJLKnH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Oct 2020 06:43:07 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33232 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387596AbgJLKnH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Oct 2020 06:43:07 -0400
Received: by mail-ot1-f67.google.com with SMTP id t15so15485051otk.0
        for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2020 03:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FNdG1MGcFaUsr7wF+6WWLM/nbNEIpoqNIuMa9ABnFws=;
        b=kDWR8jDF3ntP9ZKSnmE1YGWBEFyERtLn5uESub6Ycg5vENjrDQvGki5SdevPfTbuhq
         RugWAmHdJgugO8k7jg7hNX44rw7lZAohqfPa9H00jniUyBzpBdk9/9KI9wVZr44IxNBH
         qTjHoFS1+69myw6QRpVnAhcCCe2jOKbLqOLQJUpE2FPb/wPAyJCIIE3Q+eiT7oPMx9u+
         sIDeVsDm+aU7bugFVvK9xvrBq1md9hNX4oLAVPY5P26ddHnPHvBrph7qW69RmeSO2y5Z
         c+2Z/9CLBcJS2fZ+bMrvTJomVZ0jrxh3x3ttJ0wVeUrfsJfvgMN1+x29RrmyNlSHGei4
         ODoQ==
X-Gm-Message-State: AOAM5316E26jGaoY4ZP4dt3aN1ddWpHwL/egRcqWdDC5TXm+Q+SOz3dO
        fax/jOLYnyjCYeBmRCjtqUz3HmLZjOEkkyM7W4YUnGdtG/s=
X-Google-Smtp-Source: ABdhPJycKUQq7SanniBDFnT1Ib0LfuXgjk2ytgqWuAnKK/eBt0KfRNCgryGGEa5cyP4khbd0k+kN3skIXQ0+QNvsN30=
X-Received: by 2002:a9d:734f:: with SMTP id l15mr19095652otk.260.1602499385988;
 Mon, 12 Oct 2020 03:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <20201010022606.27669-1-rui.zhang@intel.com>
In-Reply-To: <20201010022606.27669-1-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Oct 2020 12:42:51 +0200
Message-ID: <CAJZ5v0jM-B5VxGSVYf9DVoWkwbGpNFZw_-wTxLxifGap6OA2ug@mail.gmail.com>
Subject: Re: [PATCH] acpi: reboot: fix racing after writing to ACPI RESET_REG
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, sukumar.ghorai@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Oct 10, 2020 at 4:36 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> According to the ACPI spec, "The system must reset immediately following
> the write to the ACPI RESET_REG register.", but there are cases that the
> system does not follow this and results in racing with the subsequetial
> reboot mechanism, which brings unexpected behavior.
>
> Fix this by adding a 15ms delay after writing to the ACPI RESET_REG.
>
> Reported-by: Ghorai, Sukumar <sukumar.ghorai@intel.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/reboot.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/reboot.c b/drivers/acpi/reboot.c
> index ca707f5b521d..88e6b083d702 100644
> --- a/drivers/acpi/reboot.c
> +++ b/drivers/acpi/reboot.c
> @@ -3,6 +3,7 @@
>  #include <linux/pci.h>
>  #include <linux/acpi.h>
>  #include <acpi/reboot.h>
> +#include <linux/delay.h>
>
>  #ifdef CONFIG_PCI
>  static void acpi_pci_reboot(struct acpi_generic_address *rr, u8 reset_value)
> @@ -66,4 +67,10 @@ void acpi_reboot(void)
>                 acpi_reset();
>                 break;
>         }
> +
> +       /*
> +        * delay for 15ms in case the system does not shutdown immediately after
> +        * writing to the ACPI reset register

It would also be good to make a note of where the 15ms value comes from.

Even if it has been guessed, it will still be good to know that, say,
5 years from now.

> +        */
> +       mdelay(15);
>  }
> --
> 2.17.1
>
