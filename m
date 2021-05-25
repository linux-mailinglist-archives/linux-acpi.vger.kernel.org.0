Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1951338FF06
	for <lists+linux-acpi@lfdr.de>; Tue, 25 May 2021 12:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhEYK17 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 May 2021 06:27:59 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:33662 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbhEYK1x (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 25 May 2021 06:27:53 -0400
Received: by mail-oi1-f181.google.com with SMTP id b25so29872027oic.0;
        Tue, 25 May 2021 03:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Oe6ef/YqF0WwCiE/tghboe752yi2MANOadQ5vxRieQ=;
        b=WIojTnBIuypkYjaHkoJKnV0O3l/Dn7UiDnzMH7cjK5MXh6fFJxF0vof+1Z47hHwMGB
         o/0rxuayckn2ETPEvCf7kfFPw+5LVk9YZBPeMcB/Ar1q+0WbhLt5zl9Rt3dBkKUcc4HW
         Yy3kY+0SHWIh1DAaE8uDaqYbJZ+Jmi6rKnOU0683dIMhKe5c6tYNbUh004+rjUfvk9G8
         4IlfyBOwMOQV/NODTAMO00C1PlSdHSWdzHKigOkwZN8c4TMhRc1wYB2G+AJ4R410gwR0
         rX+8WRb7HNEbBvkjR1A3rLx32+N6JIvpfwxND9yLi+72PAKGzgY4EDpeHjofRdBWlHye
         zdqw==
X-Gm-Message-State: AOAM531JgTlDYWeQmrG1BL7j0T07aX9C+4tAshJIH4er46xl4+ZkQh9G
        9ov1CBeeRTunDDjEHIHbSTzFogNUm7bVC283z8Hwa/jK
X-Google-Smtp-Source: ABdhPJwDUCJ73zzJQWjIxFwCFNHIgoHmKKukJ6QLJUNXs6dbWTgSSsxLvIU514HxZUzO3g80pxLuMbMz3cz3zVyKJfI=
X-Received: by 2002:aca:1910:: with SMTP id l16mr13033204oii.69.1621938383625;
 Tue, 25 May 2021 03:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210524120832.1580247-1-liushixin2@huawei.com>
 <CAJZ5v0gZYupB2w4oU1QGvE5aohcyPXk=BJVRvSrApGzp=sXkMQ@mail.gmail.com> <a62a08be-33e2-d22b-c790-3765c87a2309@huawei.com>
In-Reply-To: <a62a08be-33e2-d22b-c790-3765c87a2309@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 25 May 2021 12:26:11 +0200
Message-ID: <CAJZ5v0g8yD4zumhWsMqcHsjV1P-Q6Ghz-T8+U=oUii-tHcp+Tw@mail.gmail.com>
Subject: Re: [PATCH -next] ACPI: LPSS: Replaced simple_strtol() with kstrtol()
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 25, 2021 at 4:46 AM Liu Shixin <liushixin2@huawei.com> wrote:
>
>
>
> On 2021/5/24 22:33, Rafael J. Wysocki wrote:
> > On Mon, May 24, 2021 at 1:35 PM Liu Shixin <liushixin2@huawei.com> wrote:
> >> The simple_strtol() function is deprecated in some situation since
> >> it does not check for the range overflow. Use kstrtol() instead.
> >>
> >> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> >> ---
> >>  drivers/acpi/acpi_lpss.c | 13 ++++++-------
> >>  1 file changed, 6 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> >> index ca742f16a507..1b46e00cad3a 100644
> >> --- a/drivers/acpi/acpi_lpss.c
> >> +++ b/drivers/acpi/acpi_lpss.c
> >> @@ -186,13 +186,12 @@ static void byt_i2c_setup(struct lpss_private_data *pdata)
> >>         long uid = 0;
> >>
> >>         /* Expected to always be true, but better safe then sorry */
> >> -       if (uid_str)
> >> -               uid = simple_strtol(uid_str, NULL, 10);
> >> -
> >> -       /* Detect I2C bus shared with PUNIT and ignore its d3 status */
> >> -       status = acpi_evaluate_integer(handle, "_SEM", NULL, &shared_host);
> >> -       if (ACPI_SUCCESS(status) && shared_host && uid)
> >> -               pmc_atom_d3_mask &= ~(BIT_LPSS2_F1_I2C1 << (uid - 1));
> >> +       if (uid_str && !kstrtol(uid_str, 10, &uid)) {
> >> +               /* Detect I2C bus shared with PUNIT and ignore its d3 status */
> >> +               status = acpi_evaluate_integer(handle, "_SEM", NULL, &shared_host);
> >> +               if (ACPI_SUCCESS(status) && shared_host && uid)
> >> +                       pmc_atom_d3_mask &= ~(BIT_LPSS2_F1_I2C1 << (uid - 1));
> >> +       }
> > This is not a simple replacement.
> >
> > Why are you making the other changes?
> The variables status and shared_host are valid only when the uid is not zero(default to zero).
> If uid_str is NULL or kstrtol() failed or uid is assigned to zero, we can skip these operations.

So why don't you write this in the changelog of the patch?
