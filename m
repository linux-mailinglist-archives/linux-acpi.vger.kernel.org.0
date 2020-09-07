Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89DA325FA10
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 14:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgIGMAg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 08:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729149AbgIGL7s (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Sep 2020 07:59:48 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99B2C061575
        for <linux-acpi@vger.kernel.org>; Mon,  7 Sep 2020 04:59:47 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id q21so12564754edv.1
        for <linux-acpi@vger.kernel.org>; Mon, 07 Sep 2020 04:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bR2mzR5z4Fp1s//vb7R8PemzbT1nIPea5CxsPeQGbCo=;
        b=sdlgVprv5Ml6FcGFfq4SFwKLBdhqpgt1/tD2prJUf3yezMMf+zk3OqmlSCmjl90GHA
         9J+0bfsuL2zGyEMQv67lgp7Uh5bekpJZkJHE6RCa3MxRx2asJEH0Rqd9mlGTMD/4z6Ur
         rlj+DdN2WEqADLINNVdSYBEhSR/vahUY1tKDlmtHNxKtIAaiKOIlwVeS9MfAxEMbdzNI
         veqHk6YVwBCiYL+JFMHTSCZgP67iVXGNuh01a9SlxoSynu7DM83hrYh4tzt5UwLCwkk9
         giM2ryBZgwbxSSOdWZIXQxuIHht3JyKr6Uv/HaVrENAUpyjSEsHY1RcTVtVySWPD86y2
         ro2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bR2mzR5z4Fp1s//vb7R8PemzbT1nIPea5CxsPeQGbCo=;
        b=Xvb4xbZV4acj4F5xSZJPBJ/N9A3KFlcpBiArimk8BFHFxC9Y33VZyC8PQj520G6Bp+
         z9IaaY1emkdm3N482v2yR+/diI+fnV4hyX9GOwr1L30860ygSN72YwaNII0OLdeEu9Sf
         /aF5NXbxC3kR+v/jJOTiAKAtuKOJP76+9+cacc16BnjLN0swOyb/6DhhFEU++wZLiNoi
         czikHMZTovk6zqXi3UYNRKehZJSWScNyTV3XvH1EAB21XICMwgoQUMGbQxdSwG7tV7d/
         fSA7h7SgDqYNMh4jg88QU+GG4qPEYht0evETvNkMF9X9nem3q6aUaDsvHoyTwnftoBhi
         mPWg==
X-Gm-Message-State: AOAM530Cw7vHQIJ9XDkC32vVotoDGkstZml/3wTUfHrbYcWaMisv2boe
        sJUMhca2QOG9hMiKgBN2bykbdA3fEJ3MJVqrZx8uJA==
X-Google-Smtp-Source: ABdhPJyvgUJP0ylxO5qehk4m0jdhpk8hsO0Sw1TL7vejIAJ+s0I1Q151uttBgmbE3hq97WmzbCF8SLXZr4mDtGwGZag=
X-Received: by 2002:a50:f687:: with SMTP id d7mr22155378edn.353.1599479986024;
 Mon, 07 Sep 2020 04:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200904154547.3836-1-brgl@bgdev.pl> <20200904154547.3836-16-brgl@bgdev.pl>
 <20200904164917.GC1891694@smile.fi.intel.com> <CAMRc=MeG8xuB0GNbMLi6+QZTphSN==77Hsw1fjVNU_+Z=Ky2qQ@mail.gmail.com>
 <20200907115051.GY1891694@smile.fi.intel.com>
In-Reply-To: <20200907115051.GY1891694@smile.fi.intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 7 Sep 2020 13:59:35 +0200
Message-ID: <CAMpxmJWM265uk39mddEwVUYJdnM+1Stx3Ds8O9-ucYvMnV7hRw@mail.gmail.com>
Subject: Re: [PATCH 15/23] gpio: mockup: use dynamic device IDs
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 7, 2020 at 1:50 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Sep 07, 2020 at 01:04:29PM +0200, Bartosz Golaszewski wrote:
> > On Fri, Sep 4, 2020 at 6:49 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Fri, Sep 04, 2020 at 05:45:39PM +0200, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > >
> > > > We're currently creating chips at module init time only so using a
> > > > static index for dummy devices is fine. We want to support dynamically
> > > > created chips however so we need to switch to dynamic device IDs.
> > >
> > > It misses ida_destroy().
> >
> > No, we always call ida_free() for separate IDs when removing devices
> > and we remove all devices at module exit so no need to call
> > ida_destroy().
>
> Perhaps couple of words about this in the commit message?
>

But ida_destroy() and ida_free() are already well documented. It's
clear that we remove all devices at exit and that every device removes
its ID, there's really no point in mentioning it again.

Bart
