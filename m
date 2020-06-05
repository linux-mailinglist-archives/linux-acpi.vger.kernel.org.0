Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9F11EF669
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jun 2020 13:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgFELa2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Jun 2020 07:30:28 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38661 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgFELa1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Jun 2020 07:30:27 -0400
Received: by mail-oi1-f196.google.com with SMTP id c194so7927323oig.5;
        Fri, 05 Jun 2020 04:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d0R9p6qjH+B6P6CPnMYqQfxpU/F40huKcC5wauLBz4A=;
        b=OO5uiYgMi49InbUpBpDPW1m12iZhwPtugeUmvzKAcGJrtCiaFvj4fU7xMLfk4kdrXg
         HYCiu6SF9TVr8elqdQRKpaVsK1/MUv+YpC91ShXKnV28s+cGPKgyzgLkxCNkf8/9meFc
         3p+gcYEoW4OsWfDVQ+FEiqfTCJZigqR2GR4c2paE9KRRuXLYc0ZcTBj609T1k87UTqIe
         LIedhi58OwE46hvwpzIrAzYFqa0k1z2B48F/Y25m8tkccor/U9Gaut0PKvuYH4XuAgTr
         jOskVOUei4ObmdS9HCio8aFGRFM3ajO/g3EaoVViLUGItoTalCK6GfKFlWYZSyp3p3Zz
         kmsQ==
X-Gm-Message-State: AOAM533SpizYHuI4nsntVrB7kZBZvQYnRAT6McAoUe9oxRLvCVXrjXkW
        l6Mj1su6FEPy/SCMb2Iuyify6Jquv8397Vs9qkfQOiMS
X-Google-Smtp-Source: ABdhPJy9VIwtpNV88POANwX7VNxTZ/2nLsI1HS3/BCAGNhb8CYP3hruYlxizk0/qvIp1j5cBNgBkZknVjB4D4ywplwA=
X-Received: by 2002:aca:ab92:: with SMTP id u140mr1579489oie.68.1591356626786;
 Fri, 05 Jun 2020 04:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200604195658.66201-1-mathewk@chromium.org>
In-Reply-To: <20200604195658.66201-1-mathewk@chromium.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Jun 2020 13:30:13 +0200
Message-ID: <CAJZ5v0iteOV=4CnQrVx5ZmnWq5Uf88k7UMMmKcMxgJnco3kxvg@mail.gmail.com>
Subject: Re: [PATCH] acpi: battery: Always read fresh battery state on update
To:     Mathew King <mathewk@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 4, 2020 at 9:57 PM Mathew King <mathewk@chromium.org> wrote:
>
> When the ACPI battery receives a notification event it should always
> read the battery state fresh from the ACPI device and not use the cached
> state.

Why should it?

> Currently the cached state stays valid and the new state may not
> be read when a notification occurs. This can lead to a udev event
> showing that the battery has changed but the sysfs state will still have
> the cached state values.

Is there a bug entry or similar related to that which can be referred
to from this patch?

> This change invalidates the update time forcing
> the state to be updated before notifying the power_supply subsystem of
> the change.
>
> Signed-off-by: Mathew King <mathewk@chromium.org>
> ---
>  drivers/acpi/battery.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 366c389175d8..ab7fa4879fbe 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -981,6 +981,7 @@ static int acpi_battery_update(struct acpi_battery *battery, bool resume)
>                 acpi_battery_init_alarm(battery);
>         }
>
> +       battery->update_time = 0;

AFAICS this is equivalent to dropping battery->update_time altogether.
Isn't that a bit too excessive?

>         result = acpi_battery_get_state(battery);
>         if (result)
>                 return result;
> --
