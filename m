Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06DF52818E5
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Oct 2020 19:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387688AbgJBRLy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 2 Oct 2020 13:11:54 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:47024 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgJBRLy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Oct 2020 13:11:54 -0400
Received: by mail-ot1-f65.google.com with SMTP id a13so2025451otl.13
        for <linux-acpi@vger.kernel.org>; Fri, 02 Oct 2020 10:11:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Au+xEfwyuOjHg5DosP/anCYZf+QkwWEcyzXNkrc1uqw=;
        b=m6uAUmPDcETrvJIFMqHsDHZKqr3QxRU4pAXlVW+6p+8UqUSpueU7i7duadjD0L7PZD
         VIxPW3v6paOziwrcySxTfuLFpYPM3a9WWSQ+Bu8A9O5uuIrpIXajGnqb0glvbp7SDtEB
         VcCEB0D6Yc/+/Ia/jk9xvOJpdiBISvrPBZ5YlVJ82rK9KS2Lqty/R5cKxl73kk5o+mgz
         3+61/21ka8XpY7UphU0cp7QLpX/Wh0IqnrqakFN27BGif+9SxAjYtQrTJZ5q7CP5ERI9
         CsqUGqn2hAKbvHabqQWZO/bbClKo0dXrGOst/vn6U81ibQ6FSwMKFZa8FCfkTpFze0P+
         It/w==
X-Gm-Message-State: AOAM533JarRRaWgCgUMrbS32QwmDe0AEZRCVrB5ZY7EHLPoN6GeLHbmW
        EDuM906biQGw5YqnEcyuOqnU+9xsxAxWCfGN8Ck=
X-Google-Smtp-Source: ABdhPJyjEHi19bTE2CUySy095DVoNsUuFZ/N0PfZOaNzwKopkN+Uo0plTBG2Q7XgyKg78r2vOUV1F7O9I4rcxYmHZzY=
X-Received: by 2002:a05:6830:150a:: with SMTP id k10mr2308108otp.167.1601658713650;
 Fri, 02 Oct 2020 10:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <1601169268-12062-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1601169268-12062-1-git-send-email-tiantao6@hisilicon.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 2 Oct 2020 19:11:42 +0200
Message-ID: <CAJZ5v0hni_MqqoUB5ikPxMP5ZUmS38XGA8=r1LzVfAuT0HDSog@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: scan: Use pr_debug replace ACPI_DEBUG_PRINT()
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Sep 27, 2020 at 3:17 AM Tian Tao <tiantao6@hisilicon.com> wrote:
>
> Fixes the following W=1 kernel build warning(s):
> drivers/acpi/scan.c: In function ‘acpi_bus_get_wakeup_device_flags’:
> drivers/acpi/scan.c:902:43: warning: suggest braces around empty body in
> an ‘if’ statement [-Wempty-body]
>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
> v2:rewrite the patch and change the patch name.
> ---
>  drivers/acpi/scan.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 2142f15..684c726 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -898,8 +898,7 @@ static void acpi_bus_get_wakeup_device_flags(struct acpi_device *device)
>          */
>         err = acpi_device_sleep_wake(device, 0, 0, 0);
>         if (err)
> -               ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> -                               "error in _DSW or _PSW evaluation\n"));
> +               pr_debug("error in _DSW or _PSW evaluation\n");
>  }
>
>  static void acpi_bus_init_power_state(struct acpi_device *device, int state)
> --

Applied as 5.10 material with edited subject and changelog, thanks!
