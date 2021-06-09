Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479DD3A1524
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Jun 2021 15:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbhFINLg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Jun 2021 09:11:36 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:44656 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhFINLg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Jun 2021 09:11:36 -0400
Received: by mail-oi1-f172.google.com with SMTP id a26so4327323oie.11;
        Wed, 09 Jun 2021 06:09:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P0GmgUrrkX11P8OBeo+YoXlCXuNG154V9MO9ItscuiA=;
        b=ci4eJ2KbMOje0JEVOBIxm/waBGBKD9xTrr5shC29qrG1FeXpwjj+FSPzhh+ZVG3Jtw
         veF/GFlgyrgFQGPeFTOjDgQcV+fqidzLN1LQ9dnwC8o/11AfV6X1cf/cafFuBDmpm/Mi
         belmWzXCKRoeU6qEvmWlPYG7qJUCgaYD0hnpZMtWeufHXrjfJIyygibXjVToVun5ndbb
         llfSrw/5/nKUFsYCIx5wgpyyjuUxYTViO91jzVTnIoe7LO7F0Vat7hUm4e4H3WtxOFWR
         M354qhpA0zygKMpIlWaFVjVeuVHY1cEXzJino+q6AyntoL1Pd5DMVF1pberT0mfWLOjP
         0NKQ==
X-Gm-Message-State: AOAM533cZBtoMrcIGF7mMpELas5+0eK6wmN3pyuelk/cNzAropn3cqCu
        Du9vWljhBIJERjLeslzP/iJljB0jITeH10GBVw1KE3Wg
X-Google-Smtp-Source: ABdhPJx1dwdQ8zgpC/D+anoaaVJXeiybzuipYz+3jZ0H935g2FaV+IFobv8Cb9yZyG5Utx2UCEFmj2CozRgfcvrdX4k=
X-Received: by 2002:aca:1910:: with SMTP id l16mr6188798oii.69.1623244169771;
 Wed, 09 Jun 2021 06:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210608023733.2745553-1-libaokun1@huawei.com>
In-Reply-To: <20210608023733.2745553-1-libaokun1@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Jun 2021 15:09:18 +0200
Message-ID: <CAJZ5v0hRqKM7GrcSuxT=7-E3EhtZ+nmrpeTaAdUijSZ2s2APmg@mail.gmail.com>
Subject: Re: [PATCH -next] acpi/bus: fix doc warnings in bus.c
To:     Baokun Li <libaokun1@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Yue Haibing <yuehaibing@huawei.com>, yangjihong1@huawei.com,
        yu kuai <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 8, 2021 at 4:28 AM Baokun Li <libaokun1@huawei.com> wrote:
>
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/acpi/bus.c:437: warning: Function parameter or
>   member 'handle' not described in 'acpi_bus_notify'
>  drivers/acpi/bus.c:437: warning: Function parameter or
>   member 'type' not described in 'acpi_bus_notify'
>  drivers/acpi/bus.c:437: warning: Function parameter or
>   member 'data' not described in 'acpi_bus_notify'
>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  drivers/acpi/bus.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index be7da23fad76..021b85ff990a 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -430,6 +430,9 @@ static void acpi_bus_osc_negotiate_usb_control(void)
>
>  /**
>   * acpi_bus_notify
> + * @handle: Handle to acpi device.
> + * @type: ACPI device event type.
> + * @data: ACPI device data.

This just addresses specific warnings without really fixing the entire
kerneldoc.

Please either fix it entirely, or don't change it.

>   * ---------------
>   * Callback for all 'system-level' device notifications (values 0x00-0x7F).
>   */
> --
> 2.31.1
>
