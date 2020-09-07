Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD04325FD1C
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 17:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbgIGP3D (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 11:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730060AbgIGPPM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Sep 2020 11:15:12 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08740C0613ED
        for <linux-acpi@vger.kernel.org>; Mon,  7 Sep 2020 08:15:10 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id e23so18656271eja.3
        for <linux-acpi@vger.kernel.org>; Mon, 07 Sep 2020 08:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iCA0F/2SnnESSDI4EBT00k34dz77kYR2spCZaIF2uHY=;
        b=su5o8fbyLOAaM8fgU+7htLf0ioeMDDxB5U7fu0pBeX1RsoTpb/1cOIek0DB/bkQsSe
         OGOsu2MN9t/TvW2JalBS0/NCCta2ULcJbyAHpcv+hLGeiyMC9kZeGA+ZYT1ey2wBje4C
         Fm4VCplStpeCef/cIw8oAeFLYSCR9RzsurKfZOw97nq1dSv43B1+AJ8U9WxP4U7YVRUZ
         hgBPd5GG5Q1Epl0QxB2Ni8oYpQrTRMGHVa0lwQ4Wl/ZnBDU7GSYjG762YjRVvS7d9mNJ
         CamhaXcst7pcZU/7wyB5C69hediUKLLRnHDNXSUs5EamIpEVI0J4UmUQ+TXPZIkcGoK6
         f1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iCA0F/2SnnESSDI4EBT00k34dz77kYR2spCZaIF2uHY=;
        b=THKTnDO1ry/zQNDtEptOl9t6E0ls3rCj2TmY5VwXEa4/n+9Deii/n3tB+uG7HnP+8m
         7pZP9ifi7Gtru2ikwzHyrxMqL1giZUadntUC7f+d1QczC4bu5INf768cB8myQ2KlQttW
         5BeWHI2A70cLWfvy9+o4tW3+FlEAKNFJHECF140sacyZrmQMQQZnCdFOaKUMPhpg968a
         w3pMkuvdnSJUsq7rWjNWg5StEV/FH9ik3ioZNfOSHuSlrwhuZSvBmYBWdRtDStMtShnA
         ec4925pliPPI+HPqDBESIPl3PeYrYBoOfH2uugCoHlv/v/yGCcIfW24T/Hx7ppnWfWqZ
         foZw==
X-Gm-Message-State: AOAM531CxtY1ia6viJVOF6ARm1ttKHnlLrHsQqna11WwVoNXzqny7khY
        miJnh6Qk5hyw3xROvLBKaKNJwS7w8pzcUT/mlv0dvQ==
X-Google-Smtp-Source: ABdhPJwag5uFVbOznIRFD7hUBenCZZKrZmRn3jTCX4vHYpA4VymrG36hBOtB09F9smlRBodPgmoaNTlMD/ezmHNmkOk=
X-Received: by 2002:a17:906:19db:: with SMTP id h27mr19818725ejd.154.1599491709642;
 Mon, 07 Sep 2020 08:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200904154547.3836-1-brgl@bgdev.pl> <20200904154547.3836-24-brgl@bgdev.pl>
 <26ea1683-da8f-30e7-f004-3616e96d56b3@infradead.org> <20200907095932.GU1891694@smile.fi.intel.com>
 <CAMpxmJXvhYOVkZY7LLf=v+o8E2xKTh1RYhLrdVsS9nN1XZ5QJQ@mail.gmail.com>
 <20200907115310.GA1891694@smile.fi.intel.com> <CAMpxmJUfNkko4Rrb4N5CF_rdwRAWGhVr9DSOHfhYyTxYSH7dsQ@mail.gmail.com>
 <20200907122238.GA1849893@kroah.com> <CAMpxmJXM=8oGoPSGg8G8XJ4HXJFrAQ2-_EXrz3rf3+ZmCSWB7g@mail.gmail.com>
 <20200907140829.GL1891694@smile.fi.intel.com>
In-Reply-To: <20200907140829.GL1891694@smile.fi.intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 7 Sep 2020 17:14:58 +0200
Message-ID: <CAMpxmJWvrW2H-QhJRACJ88MZ3uXWR2G-QKor+ZTHpiCkLgPqcg@mail.gmail.com>
Subject: Re: [PATCH 23/23] Documentation: gpio: add documentation for gpio-mockup
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Mon, Sep 7, 2020 at 4:08 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
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
>

Cc'ing Geert but I don't quite see how this would make sense. :)

Also one thing I'm not sure about re configfs is the interface we use
to read values/set pull i.e. the line attributes in debugfs, do you
think configfs allows this type of attributes?

Bart
