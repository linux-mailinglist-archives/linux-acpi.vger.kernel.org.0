Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2A3414710
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Sep 2021 12:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbhIVK5q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 22 Sep 2021 06:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235274AbhIVK5n (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Sep 2021 06:57:43 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97E6C0613C1;
        Wed, 22 Sep 2021 03:56:06 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ee50so8098391edb.13;
        Wed, 22 Sep 2021 03:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZzvueIk88GImLWt+oE2Hwp6q2+HV7chxzi1E3ng8KFU=;
        b=PHN3LKMIrfJ1OaeUX9nk64X5r02gFW0ngbrSWZz8yw0D3p3GgYcuG5Oyoc6rG073py
         b5DcLiJ07WqYvfWsvrARAuxD2ywpk7s9CKJKPYsQvkgb0MS40AR/+q1Mu4qrG1WxpoVv
         dabSUF9daUjHyJiJE8QYNPZcg7O428VgPgi3r1rJCwHZ0pSz1BWR9r3L+Q6413a3bOA7
         n4PuOo4UADz9H2cdPgrcRBJg8gr/34D9UddIM/KB8+b58BybZ/pefEOnos0wwg8Wc/NB
         yK9F7DCGVCMebRtK9T03ha0Cg+M3G8bJJkpXiMct0/DtQoplLSbEQmidwt2cmqwMvyvF
         Kxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZzvueIk88GImLWt+oE2Hwp6q2+HV7chxzi1E3ng8KFU=;
        b=FRCqvGh/5BNfSBjhoIN6xPwqlvNdDRjVzlVuS+br9uBGaNA3WPZvscTme1Gpes4pUl
         qAncSObygnKi3UMtiTPw7JbuUD4Dm5O+lqPONN1nIMbIpaN2OFr4ckIKzrndv9/Jpe1P
         G3s6h0lqHAuavjXj5d6Om7c7/YxI29o5eT68kc3nnUMwVPoSl9z9D0ySwyMzexpXPDGf
         WBD0/Dit0FSWn4V7bloyviJDzW+jFc/0ARUrYR1dNs1zGc33JtCd+PQSUfprvUZhb6Z3
         GEuDnodijUKsZ8qpK3EwE93f/1MtsB426DGc8dzSk/uvwF/F8GH2bVvZIIr8A3Pt+umV
         RpPA==
X-Gm-Message-State: AOAM530NCX4JumulZw6VwElo4Teuv2DfyGGaG9DMvyEksMCSDmHcGXAC
        GqWUe5Haq65vcvG1iXsU7Xmeflp1q9DWisbCL6w=
X-Google-Smtp-Source: ABdhPJyrSjopnHz/kohS0lzG2/3mkFjdcbS9Y1ar0+wSAdqNRuGaVFb646QgAu8C6O7eu1XYa2+V514T+CATTncNn84=
X-Received: by 2002:a17:907:6004:: with SMTP id fs4mr2121936ejc.567.1632308165331;
 Wed, 22 Sep 2021 03:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210816093856.12313-1-hdegoede@redhat.com> <CACRpkdZ8ngakZhbrJp=OjcayLJ4j7C9gqb72N18fHExtMT7gNg@mail.gmail.com>
 <86fafc6f-113c-2ea9-579b-ea29343865da@redhat.com> <CAMpxmJUtYoq1tX060dw6sKNpAf+D73Dr_s-pMhUdpeOKSr22gg@mail.gmail.com>
In-Reply-To: <CAMpxmJUtYoq1tX060dw6sKNpAf+D73Dr_s-pMhUdpeOKSr22gg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 22 Sep 2021 13:55:27 +0300
Message-ID: <CAHp75Vf4mjDoiVCZ=z7QS5oDMsPQM1rTQUTFps5fKRsNEj99Ug@mail.gmail.com>
Subject: Re: [PATCH regression fix] gpiolib: acpi: Make set-debounce-timeout
 failures non fatal
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 22, 2021 at 12:17 PM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
> On Tue, Sep 21, 2021 at 8:42 PM Hans de Goede <hdegoede@redhat.com> wrote:
> > On 9/21/21 8:28 PM, Linus Walleij wrote:
> > > On Mon, Aug 16, 2021 at 11:39 AM Hans de Goede <hdegoede@redhat.com> wrote:

...

> > >> Fixes: 8dcb7a15a585 ("gpiolib: acpi: Take into account debounce settings")
> > >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > >
> > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > >
> > > Bartosz will pick this up I think, I'm a bit off duty with GPIO right now.
> >
> > Added Bartosz to the To: list, to make sure that he actually
> > sees this. I somehow did not add him in the To/Cc when sending out
> > the patch, sorry about that.
>
> Yep, I only process patches that are directed to me personally (TO or CC).

Hmm... It's then strange that GPIO lib ACPI is not listed for you in
MAINTAINERS.
Perhaps we need to update MAINTAINERS as well.

> Now applied but I'll only be able to send it out for v5.15-rc3.

Thanks!

-- 
With Best Regards,
Andy Shevchenko
