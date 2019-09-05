Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78A03A9943
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2019 06:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfIEELR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Sep 2019 00:11:17 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43814 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725209AbfIEELQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Sep 2019 00:11:16 -0400
Received: by mail-io1-f65.google.com with SMTP id u185so1553650iod.10;
        Wed, 04 Sep 2019 21:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gSeZn3vH2SFf4GEyKXemF8vokoCVQitABq8/fxDmNgM=;
        b=JZblKNRKpMIXiw3muzOLwmrFvcpBrLI1d8Itv/p1HrlB5BFAT1tkFd6c09Wr9srGgH
         7pIjYwIbZ+uqo289graRKrZ6IRf3hQ3rq8TkslViR9j1+Jfx1fnVHS67sKt+yh28V+uR
         61jk/XsEi9NYP59nDpoTwCY1c/eY13mMIwDDtJgqegp2IoVl/VREUzk8HBS5+SDb+wtn
         wKHCMOPipno413aF6oVbpm1BzayQxXtJ34llI21/D+X7hElPzSJl0X9+d7VInsc29mBn
         aBNyeAWEjbuKRW4+6zS93ZDnMV2kU7c6FIWCwhWOkcFwJoZ3CXtcg3R0zZPH6uy4PQyR
         sHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gSeZn3vH2SFf4GEyKXemF8vokoCVQitABq8/fxDmNgM=;
        b=CjVEIGEo/nyXWA0za3tA237w5cNvhZBRdj8cPnVl4caJk5QcVtP6fVJwWHEOO5PdhQ
         MoGqfFI3bGdIvtqo8h4ZITMR/3GoqMmxOBhC+b40YgrKNVpftjezbHHlNW59D9p95K1V
         5H4dCcWPTbGF0f3/UfdzvHB6rkDyBftt31iFgCLS4Gs92PE1jk8lD7gGP1lHjUATcShb
         Qr3sUnbVIMBP/tPJiJtWiwGYqOyuPwR2HxU0Q3Fv8ZZNh1Jwmb9xSLdrumuV4/cpuwsn
         gWVlI1jztX3xE1a66Y6XvB77YC65e7SAsE8RmwN7dquQrS53U+wMtwjA1akqjSsc7qXl
         EgRw==
X-Gm-Message-State: APjAAAWEciabXQUMJfyaQT8ZL/phIkYfZ1l9TfGNlu8zJTtdm1VaMkto
        V1KSDrreQU2I0WvNXO11gh8=
X-Google-Smtp-Source: APXvYqyT7zr86lBDWqJp0aKqf+pnuqW1JSsxf54/xAurwQ5sOFO4FWkAFfIIPhHAydbEjtGgFFREZA==
X-Received: by 2002:a5d:9856:: with SMTP id p22mr296791ios.231.1567656675888;
        Wed, 04 Sep 2019 21:11:15 -0700 (PDT)
Received: from JATN (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id k6sm627669ioh.28.2019.09.04.21.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 21:11:14 -0700 (PDT)
Date:   Wed, 4 Sep 2019 22:11:12 -0600
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org, bjorn@helgaas.com,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/3] ACPI: Remove acpi_has_method() call from acpi_adxl.c
Message-ID: <20190905041112.GB117297@JATN>
References: <20190722023530.67676-1-skunberg.kelsey@gmail.com>
 <20190722023530.67676-2-skunberg.kelsey@gmail.com>
 <CAJZ5v0gRzu0bVL+7L9NhbWu5OxveEP8H8v5qpiW-FeOtoOepiw@mail.gmail.com>
 <20190722182929.GA203187@google.com>
 <CAJZ5v0iF=TxxD_gCJfaZzORTrcu+2StJE1_vhthB70jxqCkHuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iF=TxxD_gCJfaZzORTrcu+2StJE1_vhthB70jxqCkHuw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 02, 2019 at 11:08:08PM +0200, Rafael J. Wysocki wrote:
> Sorry for the delayed reply.
> 
> On Mon, Jul 22, 2019 at 8:29 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > [+cc Tony (original author), Borislav (merged original patch)]
> >
> > On Mon, Jul 22, 2019 at 10:31:11AM +0200, Rafael J. Wysocki wrote:
> > > On Mon, Jul 22, 2019 at 4:36 AM Kelsey Skunberg
> > > <skunberg.kelsey@gmail.com> wrote:
> > > >
> > > > acpi_check_dsm() will already return an error if the DSM method does not
> > > > exist. Checking if the DSM method exists before the acpi_check_dsm() call
> > > > is not needed. Remove acpi_has_method() call to avoid additional work.
> > > >
> > > > Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
> > > > ---
> > > >  drivers/acpi/acpi_adxl.c | 5 -----
> > > >  1 file changed, 5 deletions(-)
> > > >
> > > > diff --git a/drivers/acpi/acpi_adxl.c b/drivers/acpi/acpi_adxl.c
> > > > index 13c8f7b50c46..89aac15663fd 100644
> > > > --- a/drivers/acpi/acpi_adxl.c
> > > > +++ b/drivers/acpi/acpi_adxl.c
> > > > @@ -148,11 +148,6 @@ static int __init adxl_init(void)
> > > >                 return -ENODEV;
> > > >         }
> > > >
> > > > -       if (!acpi_has_method(handle, "_DSM")) {
> > > > -               pr_info("No DSM method\n");
> > >
> > > And why is printing the message not useful?
> > >
> > > > -               return -ENODEV;
> > > > -       }
> > > > -
> > > >         if (!acpi_check_dsm(handle, &adxl_guid, ADXL_REVISION,
> > > >                             ADXL_IDX_GET_ADDR_PARAMS |
> > > >                             ADXL_IDX_FORWARD_TRANSLATE)) {
> >
> > The next line of context (not included in the patch):
> >
> >                pr_info("DSM method does not support forward translate\n");
> >
> > IMHO kernel messages that are just a constant string, with no context
> > or variable part (device ID, path, error code, etc) are questionable
> > in general.  Is there any dev_printk()-like thing that takes an
> > acpi_handle?  Seems like that would be useful for cases like this.
> >
> > This message *does* include an "ADXL: " prefix (from the pr_fmt
> > definition), and from reading the code you can see that the only
> > possible method is "\_SB.ADXL._DSM".
> >
> > There's nothing an end user can do with these messages, so I suspect
> > their value is for debugging during platform bringup, and it would be
> > sufficient to drop the first one (as Kelsey's patch does) and change
> > the second one like this:
> >
> > -              pr_info("DSM method does not support forward translate\n");
> > +              pr_info("%s DSM missing or does not support forward translate\n",
> > +                      path);
> 
> You have a point, but then I would expect the changelog to mention that.
> 
> As it stands, the patch does more than the changelog says, which isn't nice.

You're right, the changelog should include this information. I'll get an
updated version made. Thank you for getting back.

-Kelsey
