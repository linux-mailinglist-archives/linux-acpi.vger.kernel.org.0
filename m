Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4467D25F8BD
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 12:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbgIGKqU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 06:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbgIGKqK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Sep 2020 06:46:10 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFAEC061574
        for <linux-acpi@vger.kernel.org>; Mon,  7 Sep 2020 03:46:08 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id r25so2542352ioj.0
        for <linux-acpi@vger.kernel.org>; Mon, 07 Sep 2020 03:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Cm3/iyepcYqpKZ6rltE2W8KEjZwGnNaTWPVuCOQ5Qg=;
        b=T+t+Kc7icHKQwmPmJycGZ7/uULY35LFJjcaWVtrCwWckJlS/9Mvo3cJmYr1cnNq+Zw
         RUzZJVxKUpVcG8BwfbcBYW182+wupDMxsgPCB54NQ3zo2un1/TAbT/X4yMEOcauVzdCx
         PhFDQ0yn5mzyvdIZ2sWhI4QAm6gtcuRGZWJokSiBh8HLgqNIuscGlbNxTwKffizwwgkw
         ai5RVJ9Bnc5qGED5cU4egn0aALRWsiPyUDOHPpTKPYNRDpz7tTyxyeQ04bKH9Itq9hpZ
         Qcpnd2P3+rNkQwDPE1iQKcXDzfCwqmprvDn0Tp/23ExA/9wCzD0Ot9xaxO3rp+05lZmT
         SWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Cm3/iyepcYqpKZ6rltE2W8KEjZwGnNaTWPVuCOQ5Qg=;
        b=dshd6psiiQVpv1Xzu2ykgLXhTHjQ6g1523iP1aDFOZYfCGcw8PW/ddVLvWEbyadefm
         ud4upovNlthTw08UCBEHYuQR3xlX+eHAAPXoWmCF8iJkohHlzRCmjXdn1LePuH3x1O48
         djmasLl9OKFZT8wb59kSoVFoIjHxYBprE1+DGEaYCBgEx5eLy/a+U1nkMnaPnN3YWldl
         emZcvHGW2aYDT0bcWMggHwcgk9+WAaIf4t/+qiAHtAUK9f6Ei29On81RZaNI6M04CG5v
         oihophfl3JIRAk4dN/MfufJMeURuoMlgseGZS4xhGkK83O6jtXh6THkuZ7vpF3L+zCHo
         sqPw==
X-Gm-Message-State: AOAM532bm+hxQRsNo3IBeUKg6af2+Phxz7lYzgUxXt7e3eXMkWQL1JEN
        iJsa1F5QKvo1WM6oVkjLLbqOpGFvaFnpvghn96Osww==
X-Google-Smtp-Source: ABdhPJxzStNgKxWLB0PwO83b0jsGUVNmRfL9NzKqyajZsYx8XATak9YS0nxMkzOSvcxRmp7wAE1BQUaM1NNOgR1xqro=
X-Received: by 2002:a02:7817:: with SMTP id p23mr8086846jac.57.1599475567555;
 Mon, 07 Sep 2020 03:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200904154547.3836-1-brgl@bgdev.pl> <20200904154547.3836-24-brgl@bgdev.pl>
 <26ea1683-da8f-30e7-f004-3616e96d56b3@infradead.org>
In-Reply-To: <26ea1683-da8f-30e7-f004-3616e96d56b3@infradead.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 7 Sep 2020 12:45:56 +0200
Message-ID: <CAMRc=MdsPna_pXv=9A=euX5eZXah9OeHha1CDTGBBc9fjVbNeA@mail.gmail.com>
Subject: Re: [PATCH 23/23] Documentation: gpio: add documentation for gpio-mockup
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Sep 5, 2020 at 5:16 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi,
>
> On 9/4/20 8:45 AM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > There's some documentation for gpio-mockup's debugfs interface in the
> > driver's source but it's not much. Add proper documentation for this
> > testing module.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  .../admin-guide/gpio/gpio-mockup.rst          | 87 +++++++++++++++++++
> >  1 file changed, 87 insertions(+)
> >  create mode 100644 Documentation/admin-guide/gpio/gpio-mockup.rst
> >
> > diff --git a/Documentation/admin-guide/gpio/gpio-mockup.rst b/Documentation/admin-guide/gpio/gpio-mockup.rst
> > new file mode 100644
> > index 000000000000..1d452ee55f8d
> > --- /dev/null
> > +++ b/Documentation/admin-guide/gpio/gpio-mockup.rst
> > @@ -0,0 +1,87 @@
> > +.. SPDX-License-Identifier: GPL-2.0-only
> > +
> > +GPIO Testing Driver
> > +===================
> > +
> > +The GPIO Testing Driver (gpio-mockup) provides a way to create simulated GPIO
> > +chips for testing purposes. There are two ways of configuring the chips exposed
> > +by the module. The lines can be accessed using the standard GPIO character
> > +device interface as well as manipulated using the dedicated debugfs directory
> > +structure.
>
> Could configfs be used for this instead of debugfs?
> debugfs is ad hoc.
>
> > +
> > +Creating simulated chips using debugfs
> > +--------------------------------------
> > +
> > +When the gpio-mockup module is loaded (or builtin) it creates its own directory
> > +in debugfs. Assuming debugfs is mounted at /sys/kernel/debug/, the directory
> > +will be located at /sys/kernel/debug/gpio-mockup/. Inside this directory there
> > +are two attributes: new_device and delete_device.
> > +
> > +New chips can be created by writing a single line containing a number of
> > +options to "new_device". For example:
> > +
> > +.. code-block:: sh
> > +
> > +    $ echo "label=my-mockup num_lines=4 named_lines" > /sys/kernel/debug/gpio-mockup/new_device
> > +
> > +Supported options:
> > +
> > +    num_lines=<num_lines> - number of GPIO lines to expose
> > +
> > +    label=<label> - label of the dummy chip
> > +
> > +    named_lines - defines whether dummy lines should be named, the names are
> > +                  of the form X-Y where X is the chip's label and Y is the
> > +                  line's offset
> > +
> > +Note: only num_lines is mandatory.
> > +
> > +Chips can be dynamically removed by writing the chip's label to
> > +"delete_device". For example:
> > +
> > +.. code-block:: sh
> > +
> > +    echo "gpio-mockup.0" > /sys/kernel/debug/gpio-mockup/delete_device
> > +
> > +Creating simulated chips using module params
> > +--------------------------------------------
> > +
> > +Note: this is an older, now deprecated method kept for backward compatibility
> > +for user-space tools.
> > +
> > +When loading the gpio-mockup driver a number of parameters can be passed to the
> > +module.
> > +
> > +    gpio_mockup_ranges
> > +
> > +        This parameter takes an argument in the form of an array of integer
> > +        pairs. Each pair defines the base GPIO number (if any) and the number
> > +        of lines exposed by the chip. If the base GPIO is -1, the gpiolib
> > +        will assign it automatically.
> > +
> > +        Example: gpio_mockup_ranges=-1,8,-1,16,405,4
> > +
> > +        The line above creates three chips. The first one will expose 8 lines,
> > +        the second 16 and the third 4. The base GPIO for the third chip is set
> > +        to 405 while for two first chips it will be assigned automatically.
> > +
> > +    gpio_named_lines
> > +
> > +        This parameter doesn't take any arguments. It lets the driver know that
> > +        GPIO lines exposed by it should be named.
> > +
> > +        The name format is: gpio-mockup-X-Y where X is the letter associated
> > +        with the mockup chip and Y is the line offset.
>
> Where does this 'X' letter associated with the mockup chip come from?
>
> > +
> > +Manipulating simulated lines
> > +----------------------------
> > +
> > +Each mockup chip creates its own subdirectory in /sys/kernel/debug/gpio-mockup/.
> > +The directory is named after the chip's label. A symlink is also created, named
> > +after the chip's name, which points to the label directory.
> > +
> > +Inside each subdirectory, there's a separate attribute for each GPIO line. The
> > +name of the attribute represents the line's offset in the chip.
> > +
> > +Reading from a line attribute returns the current value. Writing to it (0 or 1)
> > +changes its pull.
>
> What does "pull" mean here?
>

Yeah I should probably clarify this. "Pull" here means a simulated
pull-down/up resistor basically.

Bart
