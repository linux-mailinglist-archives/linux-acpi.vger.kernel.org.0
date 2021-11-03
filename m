Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D886443F2C
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Nov 2021 10:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhKCJVr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Nov 2021 05:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbhKCJVq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Nov 2021 05:21:46 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53341C061714;
        Wed,  3 Nov 2021 02:19:10 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id f4so6649706edx.12;
        Wed, 03 Nov 2021 02:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=izh+Izi2ViuBwJmcCrMjhlzLlTjUKnonv7xgDnMZKrU=;
        b=TOKXBUUZnEhSiVUGswo5BWK4XFiOQ2DZnwlqKSdHEn10SsJWliHEGHgqw+9ylVayJt
         0caUEzS8EWy0LF4JQtctFoGh5RdeYpx+7IQqErlBGO2l7DdUhV+P5GmH6qngfsNRwk4f
         QV74rbGLnWWigx5dWqctsPl7vZQYQh7urXzFT6EacH63MKT9vaY4a/w2PLDAzcm0U2vA
         TptxGVG18x246E1nDbf0/8ht0qt1SvLPGAxFt9sq0M0hCr3nd+4aJD3Rdg5tTtsLPevu
         VDwcDwrgtcsU+RfaLUpEvakbwjWWpLxfMOx2Rq5RgaBlhxgHRBmIfFoUOkuGrOBpAkVY
         7NmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=izh+Izi2ViuBwJmcCrMjhlzLlTjUKnonv7xgDnMZKrU=;
        b=YMJbFUm8sXX4rnxoYg+y12JIQl+qddkVpoh94+gldV8orlFE7FwTsikCd5qON+lOms
         zblxs4Na9aWy15OGal/CJ2jKY+5Vnxrk8lncqSqXNb2ottXc+77W8CrcW9zAMe870j57
         2IRebJnDQJqe/QEKH/SQuQV7Of8O+3spCnKyID80wVBS+rm79Z1W1vesM0GZubDsCdvp
         zicCakhz49JPfACYjDAjcePWzjw2B9G/YlZVu8YzbTUTRi2XceZzcifk+SeU00oEYcEZ
         6c2d/TJWmLDHf5RBfITXxOfwPamIJMH6mr1EpYDm6b+jZWCWGLeCilQT9qfb1oHcFXKL
         RG7g==
X-Gm-Message-State: AOAM533XOkQrjUvWOoGAfAbzzma3cymfS6fOyaP6IKKS9xm49pPIE+68
        1+LESdhPzh03MDSZEe3ub4i85QEAzTZOS9Fi+0s=
X-Google-Smtp-Source: ABdhPJylFvUk+eMM/aD3uh9TFRjKL0A0DPL5/C9zxrRXh8EDSBK11TVImY7EP6IdHGBEUgJ/89og7ZwlPvXA2Da80+M=
X-Received: by 2002:a05:6402:207c:: with SMTP id bd28mr48553253edb.240.1635931148908;
 Wed, 03 Nov 2021 02:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211102223959.3873-1-hdegoede@redhat.com>
In-Reply-To: <20211102223959.3873-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 3 Nov 2021 11:18:31 +0200
Message-ID: <CAHp75VdoYO7DCWGHadgto3Aay836z1A7g4LHT7RNLF4kgAa_Pg@mail.gmail.com>
Subject: Re: [RFC v2 0/2] ACPI/power-suppy add fuel-gauge support on cht-wc
 PMIC without USB-PD support devs
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Sebastian Reichel <sre@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 3, 2021 at 12:40 AM Hans de Goede <hdegoede@redhat.com> wrote:

...

> While working on this I realized that there also is a 4th option,
> which is basically option 1 from the v1 RFC minus the 2 gpiolib-acpi
> patches.
>
> With the 2nd option (as implemented by this RFC) we leave the
> _AEI handler in place and run the fuel-gauge without interrupt,
> we can do the same when marking the fuel-gauge as always present
> by treating IRQs on ACPI devices the same way as in the
> max17042_battery code, which has already solved the IRQ problem
> without disabling the _AEI handler:
>
>                 /*
>                  * On ACPI systems the IRQ may be handled by ACPI-event code,
>                  * so we need to share (if the ACPI code is willing to share).
>                  */

>                 if (acpi_id)

(Side remark: wouldn't it be better to have has_acpi_companion() and
use device_get_match_data()?)

>                         flags |= IRQF_SHARED | IRQF_PROBE_SHARED;
>
> This is a pretty decent option too, it requires:
>
> 1. 2 more always_present quirks in the ACPI scan code which is part of
> the main kernel image.
>
> 2. Patches to the bq27xxx_battery code to support ACPI enumeration.

If it works, why not try it?

I like the common base for the FG drivers that can be used as a pattern then.


-- 
With Best Regards,
Andy Shevchenko
