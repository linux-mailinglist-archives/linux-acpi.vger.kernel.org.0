Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474BD461175
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Nov 2021 10:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245585AbhK2J57 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Nov 2021 04:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241100AbhK2Jz6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Nov 2021 04:55:58 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275B0C061D69
        for <linux-acpi@vger.kernel.org>; Mon, 29 Nov 2021 01:35:22 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id x6so68939469edr.5
        for <linux-acpi@vger.kernel.org>; Mon, 29 Nov 2021 01:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Bujp+O6NOAfy/3Z4QGD0Dc48fM8rRU0DYEEDCE/2Tcg=;
        b=U8e2oHfb6icHI7KF5itwUh5StM4vWsKmIVrmPPWYLjGi5gHGLJmO/c1M2Ci6h6n0bW
         hIoCFH3IU/Nvck/+4OHN422QK3Sj3gINzMssK1zlEVbTgR+55qF6s8p2iAyppuRQjjwz
         DUBx4Z5+vjl9qOeekl5oBxBULVqkTiEqV4mtFcE39PTleLD9pMqepRlAM7ogxAVPWc5Y
         /Y5ixA7HJnEpa8gHVZqQHw0eYpjVZdVOve40qi2w9EchwAGNRLmc4+9unsOAFkLEYWVh
         ypMYnfPB0MHNDXLFOw2RQ5ENjMqfBehXzHuKptRY8tg1IGcy5MmvHYrKp975PSDSeNa7
         TDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Bujp+O6NOAfy/3Z4QGD0Dc48fM8rRU0DYEEDCE/2Tcg=;
        b=deYgoZuWr0Kx8UcZAZLYD6CDoE4/zb8naUtaCsFmBn7ffqMm+GqfLsTKz/3L/IrYcd
         moaIULj8fm4LEYBvBfJImVQLEBkT7y5UhP7CvBGP536A/PeeGMNjzXqQbwvNkyQSVJkY
         XPlGsloLof76Z40NN5WwilmUYzQnx8rKFV46/BuiqZbwIbfAbvRZOwQgf0brz4463SVE
         XVJlC4qzLysq7WKUanjUFl6OaE+p9uGurOVXVNM8bUAVqPen11rlK92smNoENzkDToAt
         MHNDnDDkiAUcT9P9zlIYK4h7nNSdH7vbLRkq9jqnxW+ZGhqobJVZy37exAdCrBey3AzF
         0I6A==
X-Gm-Message-State: AOAM532tbS27q4+f5RYY0O/OHTYnYw6OQ0kqw97xsBgVlZelwcnAAiqX
        Bo/k0wwpS3babRBc4kk4ZQIi4NVjcRLD7IdHAk83fNRP3KijBg==
X-Google-Smtp-Source: ABdhPJwHhJeUYKCZ2dAkzoLYn2b/1dOLqyAlAZ6xeyY6JQDjeYvwOTz1aG6v2eB0XR0b+sl/ktL2FhiGhE/6lBew26I=
X-Received: by 2002:a50:d741:: with SMTP id i1mr72697811edj.37.1638178520698;
 Mon, 29 Nov 2021 01:35:20 -0800 (PST)
MIME-Version: 1.0
References: <20211126152109.230986-1-hdegoede@redhat.com> <20211126152109.230986-3-hdegoede@redhat.com>
 <YaEDy+5ffLeQRe1D@smile.fi.intel.com> <ec8a5fcf-3e6d-e485-3426-6a0178f32855@redhat.com>
In-Reply-To: <ec8a5fcf-3e6d-e485-3426-6a0178f32855@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Nov 2021 11:34:44 +0200
Message-ID: <CAHp75VfsjTJuy-Dv=pg8ohGHiSm4XsViwPpcSJZ+gArH9to+zw@mail.gmail.com>
Subject: Re: [PATCH 3/3] ACPI: PMIC: xpower: Fix _TMP ACPI errors
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Nov 27, 2021 at 11:59 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 11/26/21 16:56, Andy Shevchenko wrote:
> > On Fri, Nov 26, 2021 at 04:21:09PM +0100, Hans de Goede wrote:

...

> >> +    /*
> >> +     * Some LPAT tables in the ACPI Device for the AXP288 PMIC for so=
me
> >> +     * reason only describe a small temperature range, e.g. 27=C2=B0 =
- 37=C2=B0
> >> +     * Celcius. Resulting in errors when the tablet is idle in a cool=
 room.
> >> +     *
> >> +     * To avoid these errors clamp the raw value to be inside the LPA=
T.
> >> +     */
> >
> >> +    if (first.raw < last.raw)
> >
> > Wondering what that would mean if this condition is false.
>
> That the tables is in descending raw value order, rather then
> in ascending one. Which quite a few LPAT tables actually are.
>
> The existing acpi_lpat_raw_to_temp() has been carefully written
> to be able to handle both cases too.

Thanks for explanation. Never thought that somebody can put tables in
reversed order.

...

> >> +            raw =3D clamp(raw, first.raw, last.raw);
> >> +    else
> >> +            raw =3D clamp(raw, last.raw, first.raw);
> >
> > clamp_value() slightly better due to type checking.
>
> Quoting from include/linux/minmax.h :
>
>  * This macro does strict typechecking of @lo/@hi to make sure they are o=
f the
>  * same type as @val.  See the unnecessary pointer comparisons.
>  */
> #define clamp(val, lo, hi) min((typeof(val))max(val, lo), hi)
>
> So we already get strict type-checking from plain clamp()

Pardon me, I was confused myself, it's actually other way around, so
clamp() does require strict types, while clamp_val() for the cases
when range is not of the same type as value.

--=20
With Best Regards,
Andy Shevchenko
