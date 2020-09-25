Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71220278E6E
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Sep 2020 18:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgIYQ30 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 25 Sep 2020 12:29:26 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45294 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbgIYQ3Z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Sep 2020 12:29:25 -0400
Received: by mail-oi1-f195.google.com with SMTP id z26so3333610oih.12
        for <linux-acpi@vger.kernel.org>; Fri, 25 Sep 2020 09:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EQJJZCWGTIx2LpU6Fiu7wNA19cx3eJDw7Qqz/Zd55HM=;
        b=YnmP4IjDBLTaOscilb5AEYhPLaRAaMTsnLbofESdb+B4Pe0+Nv307SvdhpjigTHKvM
         26E3LfkHZvLyYWfCX505I5O7BLAksEIVwCwIzwqI67/t26L9ov5wpWOG4STbHmskBWhZ
         l9REXN7IY17NF0u1hMImb7kFB/kKIu2tgYCIz5Wi9EufHAkaZudcIIWLwNbIzFW7hKu0
         zZTj8C9MQbfTdfQJq+tpJB3Qa24t6pRqVPcpumpwnvh/CPzc3Bmp10mX9doGDx1sVnxO
         AhYXtSTHXhUVMlQfqoEPNw9A9IfHw+cxIefkWTKXmRKGEXzqGmOz3qU29L1WmslfNXGr
         GRYw==
X-Gm-Message-State: AOAM5301m6JQgOO5n2W4CqF4jc28VW6M0puH37sqprpRP5IOpgubv/Uk
        PNiQKqOSYq0joQE4Z7D18t5nOBIZ2v4Kw2tTGBw=
X-Google-Smtp-Source: ABdhPJwTlcXqEgiJFvB9CVSjbV8cBr/hjuyl7Vkd07klSaVxdi5MJDIgHPfBHruAyRZQYvpqvNUJhuCAbwgEfEPW50w=
X-Received: by 2002:aca:df84:: with SMTP id w126mr72776oig.103.1601051365038;
 Fri, 25 Sep 2020 09:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <1600947263-43551-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1600947263-43551-1-git-send-email-tiantao6@hisilicon.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Sep 2020 18:29:14 +0200
Message-ID: <CAJZ5v0herK0L_PPfB1X2tT7QQfECPT-tcpFQzb9w=h8OcONAhg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: scan: Add braces around empty statements
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 24, 2020 at 1:37 PM Tian Tao <tiantao6@hisilicon.com> wrote:
>
> Fixes the following W=1 kernel build warning(s):
> drivers/acpi/scan.c: In function ‘acpi_bus_get_wakeup_device_flags’:
> drivers/acpi/scan.c:902:43: warning: suggest braces around empty body in
> an ‘if’ statement [-Wempty-body]
>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/acpi/scan.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 2142f15..8340965 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -897,9 +897,10 @@ static void acpi_bus_get_wakeup_device_flags(struct acpi_device *device)
>          * present will the _PSW object used.
>          */
>         err = acpi_device_sleep_wake(device, 0, 0, 0);
> -       if (err)
> +       if (err) {
>                 ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>                                 "error in _DSW or _PSW evaluation\n"));
> +       }

Better replace ACPI_DEBUG_PRINT() with pr_debug().


Thanks!

>  }
>
>  static void acpi_bus_init_power_state(struct acpi_device *device, int state)
> --
> 2.7.4
>
