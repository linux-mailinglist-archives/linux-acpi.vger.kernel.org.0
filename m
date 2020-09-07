Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060AA25F81A
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 12:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgIGK0w (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 06:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbgIGK0r (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Sep 2020 06:26:47 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324DDC061575
        for <linux-acpi@vger.kernel.org>; Mon,  7 Sep 2020 03:26:47 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id gr14so16426762ejb.1
        for <linux-acpi@vger.kernel.org>; Mon, 07 Sep 2020 03:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HmvvDOBbOI3Ap25LolJkNiUzAqYW/BkylmIeV4YjRD8=;
        b=QDdavu3QQmHCnnU4KwLOJr5Oqa+V9NiMQ1XwjqwN4Vf2/Yl3FamhFwkRnK9uYu0WMM
         PSIo98ml3rL98H/MFyPHXu20UitXy3KZs6DuWoJyxF5RrbDa1aPfsa1zk2tKopjDf92t
         oxo871xKdzsVRbGhOSWrfmLzWXP1g3/zK22U4SR+waK/pY8uV+I18/6oBOqI7kXsfGG+
         lRPUidIYCyv/fl7hMJdze89IE3yiK8vG8YSPcuMTCt3puxMTRgbzm+XlUiKl6PSZAZFB
         UrTltAyeJJ/5hiL9WET3bwgBk0tFhMnH+r3fxLY6lbC1V0A6JzZcriwY/wtmltFYV3GN
         TqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HmvvDOBbOI3Ap25LolJkNiUzAqYW/BkylmIeV4YjRD8=;
        b=PUYVXULbSuzSHWYl74xCW92ooxdhmLsJ0l/pQUkTiHOQsKH/rNBfLuTii3jlHzVfeR
         l1q/HxyqqLr0ZjHarwGSCh/ylN8lkHd6n3Wny8Yunyks/QeuFGcL6/N32n/hULlZ52kG
         Hx3wVuUYFF+oVdmBBbJczW8kzwKJNF9IoCd0jDl4AeV/XuuGqz5nnV0JeQz1i/iJgYxD
         ZP/X8ShDv4yRsNxJW9Q71VeThlHNSd3PUEhHcIY5ceaDL/xbNfM3/Le8/NyCSeMTUfyx
         pkn5dufvYIp6pp9kH8mBlXrwdZiRByl8onCJBpRsLB9pW9MXUQkSfD6U7dfvetavxC7n
         ilow==
X-Gm-Message-State: AOAM533JFgHHdaBbHOMFHvyB42Y0GTZaFPlBE9C2aGPzEu7fQrw38Afj
        825XsdnDbeFg4hGHH4IwATj9IMj/iaxKvx8gdQsIhw==
X-Google-Smtp-Source: ABdhPJzU3TRrxz7IZqvY6j9hu2ty43AjKwNnl8X1LKDXaPDRCwBiEKtxjLALYuvJMHAGMXF/jF07pg9xrPNCh4fKRnk=
X-Received: by 2002:a17:907:20d9:: with SMTP id qq25mr15792481ejb.382.1599474405853;
 Mon, 07 Sep 2020 03:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200904154547.3836-1-brgl@bgdev.pl> <20200904154547.3836-24-brgl@bgdev.pl>
 <26ea1683-da8f-30e7-f004-3616e96d56b3@infradead.org> <20200907095932.GU1891694@smile.fi.intel.com>
In-Reply-To: <20200907095932.GU1891694@smile.fi.intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 7 Sep 2020 12:26:34 +0200
Message-ID: <CAMpxmJXvhYOVkZY7LLf=v+o8E2xKTh1RYhLrdVsS9nN1XZ5QJQ@mail.gmail.com>
Subject: Re: [PATCH 23/23] Documentation: gpio: add documentation for gpio-mockup
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 7, 2020 at 11:59 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Sep 04, 2020 at 08:15:59PM -0700, Randy Dunlap wrote:
> > On 9/4/20 8:45 AM, Bartosz Golaszewski wrote:
>
> ...
>
> > > +GPIO Testing Driver
> > > +===================
> > > +
> > > +The GPIO Testing Driver (gpio-mockup) provides a way to create simulated GPIO
> > > +chips for testing purposes. There are two ways of configuring the chips exposed
> > > +by the module. The lines can be accessed using the standard GPIO character
> > > +device interface as well as manipulated using the dedicated debugfs directory
> > > +structure.
> >
> > Could configfs be used for this instead of debugfs?
> > debugfs is ad hoc.
>
> Actually sounds like a good idea.
>

Well, then we can go on and write an entirely new mockup driver
(ditching module params and dropping any backwards compatibility)
because we're already using debugfs for line values.

How would we pass the device properties to configfs created GPIO chips
anyway? Devices seem to only be created using mkdir. Am I missing
something?

Bart
