Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F5129F347
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 18:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgJ2Rbh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Oct 2020 13:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgJ2Rbh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Oct 2020 13:31:37 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCFEC0613D5;
        Thu, 29 Oct 2020 10:31:37 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id j5so1631283plk.7;
        Thu, 29 Oct 2020 10:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L4ra82p6fZeZOXOkClmLT1gG8p31YUcgYto+ENCnODI=;
        b=Ki0hrf2SyzbOkwT5NXRdsgkIhoZqEYhdxCEOFpsf3d2jPRG/kQ2M3eY8raixBKvnJw
         AaDUy9/TfMKR3RzJXHwndy0jNvMDiMtgtCypZe93gHf0b+GJnqqSo0h7NSLyQxp6vwQV
         l4/itpSKWLCeTSOsEZWtzTbODEC/riXVvhwJVOvnMt2Drfx+5Sh+/gsP+tlsi7Lri+qv
         VFxEk2Qco3ROcxD1r49sr/z1Y6ocX33YNDydRzbJO8kVuquFlG/SJggJwfqXDwOaqUY+
         HiEtrxdk0ib+Hf/5mr3G29xnTxLO4fr9GoPo41Z4AZBv9FswJOo0lI5ARGsJfIgsOaGm
         wd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L4ra82p6fZeZOXOkClmLT1gG8p31YUcgYto+ENCnODI=;
        b=MaiUPjOLdpBT4ZdBi2bMfaGvIDVABiTyCMchhPPdm4p1uHWANKi1MGWPJcnz0blWFz
         kBSRGs2wVzRVlZ7Hb3D5VvLiyIdwiPzBBobi52mv5UeYYF5LST6EeFqB9/YW9Xng+ejY
         1yI6hN4wZz3XGqEpIYU96NWGKRTG1cEiiKSWenRPRTTpu/cjw6R3joqwj0LKaz/3deHL
         VSJP8cQVpKbTXTLnDF/+YdQ8sW549ZFRNrKVJNw4Ch75+p0pW9jmHYmywnFwD1GK/38d
         LWa+IFzAUa5dyA68HDYSrhynwEmIQE8TjLU2+Sem3zEOdwHWIO2O77hSg/fTissMM3cc
         N+eQ==
X-Gm-Message-State: AOAM532FiM5f41bou3kivMMTRrls93rANamoIAn/pGbKHY4nAKYGycvn
        l7KWlMw1oL1JbiJhlXrTTGdK2RwOmD80ZcGX0FI=
X-Google-Smtp-Source: ABdhPJz5hdiHBHE85St8QoKVAzHkqtj6l9doedFZdK6xGF2oBkDXCdJlmjpQ7OMPTvGOT4hncie+sP8XPCYkM2AcmW0=
X-Received: by 2002:a17:902:bc4a:b029:d6:7ef9:689c with SMTP id
 t10-20020a170902bc4ab02900d67ef9689cmr5149016plz.21.1603992696981; Thu, 29
 Oct 2020 10:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201028171757.765866-1-ribalda@chromium.org> <20201028182744.GZ4077@smile.fi.intel.com>
 <CANiDSCvy2dPyY8O5DVgTBwNNLmfA=kJ5HUKJqcFLnqQ8CWsJgA@mail.gmail.com>
In-Reply-To: <CANiDSCvy2dPyY8O5DVgTBwNNLmfA=kJ5HUKJqcFLnqQ8CWsJgA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 29 Oct 2020 19:31:21 +0200
Message-ID: <CAHp75Vc6LhqKvuAeOkVtTAniHGRMGV=7Pa71CNT7por=PRk9eQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: Support GpioInt with active_low polarity
To:     Ricardo Ribalda <ribalda@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 29, 2020 at 5:37 PM Ricardo Ribalda <ribalda@google.com> wrote:
> On Thu, Oct 29, 2020 at 3:38 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Wed, Oct 28, 2020 at 06:17:57PM +0100, Ricardo Ribalda wrote:
> > > On the current implementation we only support active_high polarity for
> > > GpioInt.
> > >
> > > There can be cases where a GPIO has active_low polarity and it is also a
> > > IRQ source.
> > >
> > > De-couple the irq_polarity and active_low fields instead of re-use it.
> > >
> > > With this patch we support ACPI devices such as:
> >
> > Is it real device on the market?!
>
> Yes, it is a chromebook.

You mean it's already on sale with this broken table?!

> > This table is broken. _DSD GPIO active_low is only for GpioIo().
>
> AFAIK the format of the _DSD is not in the ACPI standard. We have
> decided its fields. (please correct me if I am wrong here)

_DSD is a concept that is part of the spec, but each UUID and its
application is out of scope indeed.

GPIO application to _DSD is described in the in-kernel documentation.
Thanks for pointing out the issues it has.

> On the other mail I have described why we need to make use of the
> active_low on a GpioInt()
>
> If there is another way of describing ActiveBoth + inverted polarity
> please let me know and I will go that way.

I answered it there, please, continue this topic there.
NAK to the proposed change.

> > If it is a ChromeBook, please fix the firmware.

-- 
With Best Regards,
Andy Shevchenko
