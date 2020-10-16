Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47AFC29097D
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Oct 2020 18:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409840AbgJPQPJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Oct 2020 12:15:09 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37419 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409844AbgJPQPJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Oct 2020 12:15:09 -0400
Received: by mail-oi1-f195.google.com with SMTP id t77so3022645oie.4
        for <linux-acpi@vger.kernel.org>; Fri, 16 Oct 2020 09:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x2LK6OOATc1pGBV8SF/3b9Lqb24pgV2Uui241RFnrwM=;
        b=NA+/DGB7lbyjlkJVOxor3BnEbL3U+hGkuuKh27WQKwtncBGCx6j4feiM2bCJpUaPvr
         aCGFITBud1FTzheGqWh+HW6r7kSMTLIaXp24ino16qMqc/xthNVmFwdXRAOAusZJHAmh
         6Nk6I8ICr/mV5YScnUnmRjrZMoXVjcsmiTM/XZh1En7rvMk76hHcGN+U32dtM7fZZ+qH
         v7+Nd6sUHdxJuDxFolverIrGmRglOYNL4mbXPIkHEcy0dJSnqfcRnwxYZVIkMu2Swoq+
         wrAaIzHqmeOEgffWq0a8TOlokacjuxD+bIcZD2n3boPa4A7Y5NDIhgbGgngH0v5SOAgQ
         C7cg==
X-Gm-Message-State: AOAM5313IhibQrx/Pzl2I+QZFS30INYCTfjKEs/2r08TVZcVSgSULsbV
        PZ86WiS8gZwKTOYIv7v0vUYLLwqZj6VQCSxjEcLSKskA
X-Google-Smtp-Source: ABdhPJxw20s+w2sku9sARVkv52XFZj7HPmA/1JXePVK2N83xnD3wzWF1pTZgdo2qFwumM1RkPem8Z7cNZqOse1oFT30=
X-Received: by 2002:aca:5256:: with SMTP id g83mr3064114oib.71.1602864907228;
 Fri, 16 Oct 2020 09:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20201014010340.433398-1-alex.hung@canonical.com>
In-Reply-To: <20201014010340.433398-1-alex.hung@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Oct 2020 18:14:56 +0200
Message-ID: <CAJZ5v0g+9ZL8=jsp23YZYAYtRMZMgBx+A0usfx7q1WaNQqLp=A@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor: remove unnecessary string _UID comments
To:     Alex Hung <alex.hung@canonical.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 14, 2020 at 3:03 AM Alex Hung <alex.hung@canonical.com> wrote:
>
> ACPI 6.3 Errata A no longer allows _UID to be string except Itanium
> for historical reasons as stated in section 5.2.12. Therefore, it is
> redundant to comment "we don't handle string _UIDs yet" which implies a
> feature is missing.
>
> "From ACPI Specification 6.3 onward, all processor objects for all
> architectures except Itanium must now use Device() objects with an _HID
> of ACPI0007, and use only integer _UID values."
>
> Signed-off-by: Alex Hung <alex.hung@canonical.com>
> ---
>  drivers/acpi/acpi_processor.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index b51ddf3..710605f 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -264,7 +264,6 @@ static int acpi_processor_get_info(struct acpi_device *device)
>         } else {
>                 /*
>                  * Declared with "Device" statement; match _UID.
> -                * Note that we don't handle string _UIDs yet.
>                  */
>                 status = acpi_evaluate_integer(pr->handle, METHOD_NAME__UID,
>                                                 NULL, &value);
> --

Applied as 5.10-rc material with edited changelog and subject, thanks!
