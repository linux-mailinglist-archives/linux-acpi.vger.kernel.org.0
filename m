Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7311B25FCF3
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 17:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbgIGPYW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 11:24:22 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37592 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730160AbgIGPXl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Sep 2020 11:23:41 -0400
Received: by mail-ot1-f65.google.com with SMTP id 37so12538859oto.4;
        Mon, 07 Sep 2020 08:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wvn2btk6OaWtKKqXcuwG3Mb/+3b+ZXDIOngM0aY6pjg=;
        b=XaZEXWy8EsoZxu7hvbr+cnQ3Hin3RWQ1fuJLNPsMPjsPv6EDRziGnxqs2Fbr+dfjcG
         Ox6fVe4oOT8VJsy84s/NkwPMzos2s5zuEvQ0QflC0o1nIpszoE5y+9fCNZEzfaAnud/D
         zk6fV9oQPHhcvXleqvlXUamb99OtAr9zbImODajj5Msbtcl4hcv92KtrbsxGHV1FIdxe
         EZprnfRxnnE0X5IDVr+PPM8CNc9JoEx+oo8/XQJcD0PG/SBTc2yK5z+o8ha5rrdrS1js
         mQY3hkA0tPtBXeJiozZqeP/d9yNH2PhVQgryNLQkZK1flJTyZvq7iGLvoxVr+iTGAcIP
         y95A==
X-Gm-Message-State: AOAM532o2EfFivRcmR3froIablVXkmDiCsY3Nkir9h2m4UP2rDsSmTn6
        jjjV5JveTvQ7CoJJlJirP3j/gBSAkUUbupDD4m8=
X-Google-Smtp-Source: ABdhPJyDwgT+6M2sQy7tGvosk035vPyDVZyUNCPmIeCmF3kluyMlyIYL0NDIKleeHYd1wrhn0a3Lngnt0gBXEn3ic7M=
X-Received: by 2002:a05:6830:1008:: with SMTP id a8mr13928569otp.107.1599492220372;
 Mon, 07 Sep 2020 08:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200904154547.3836-1-brgl@bgdev.pl> <20200904154547.3836-24-brgl@bgdev.pl>
 <26ea1683-da8f-30e7-f004-3616e96d56b3@infradead.org> <20200907095932.GU1891694@smile.fi.intel.com>
 <CAMpxmJXvhYOVkZY7LLf=v+o8E2xKTh1RYhLrdVsS9nN1XZ5QJQ@mail.gmail.com>
 <20200907115310.GA1891694@smile.fi.intel.com> <CAMpxmJUfNkko4Rrb4N5CF_rdwRAWGhVr9DSOHfhYyTxYSH7dsQ@mail.gmail.com>
 <20200907122238.GA1849893@kroah.com> <CAMpxmJXM=8oGoPSGg8G8XJ4HXJFrAQ2-_EXrz3rf3+ZmCSWB7g@mail.gmail.com>
 <20200907140829.GL1891694@smile.fi.intel.com>
In-Reply-To: <20200907140829.GL1891694@smile.fi.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Sep 2020 17:23:28 +0200
Message-ID: <CAMuHMdV42oUu=af_O=aUVED_Nxce0wnTKTMNNSskaSGT=p5ZMw@mail.gmail.com>
Subject: Re: [PATCH 23/23] Documentation: gpio: add documentation for gpio-mockup
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Mon, Sep 7, 2020 at 4:14 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, Sep 07, 2020 at 03:49:23PM +0200, Bartosz Golaszewski wrote:
> > On Mon, Sep 7, 2020 at 2:22 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > On Mon, Sep 07, 2020 at 02:06:15PM +0200, Bartosz Golaszewski wrote:
>
> ...
>
> > > Yes it is.  Or at least until you fix all existing users so that if you
> > > do change it, no one notices it happening :)
> > >
> >
> > Then another question is: do we really want to commit to a stable ABI
> > for a module we only use for testing purposes and which doesn't
> > interact with any real hardware.
> >
> > Rewriting this module without any legacy cruft is tempting though. :)
>
> Another thought spoken loudly: maybe it can be unified with GPIO aggregator
> code? In that case it makes sense.

You want to aggregate GPIOs out of thin air?

From DT, that would be something like

    gpios = <&gpio1 2>, <0>, <0>, <&gpio2, 5>;

?

For writing into ".../new_device", we could agree on something like "0"
means not backed by an existing GPIO?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
