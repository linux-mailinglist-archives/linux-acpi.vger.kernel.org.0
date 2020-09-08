Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78751261719
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Sep 2020 19:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbgIHRZY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Sep 2020 13:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731117AbgIHQRM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Sep 2020 12:17:12 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDF4C0619F0
        for <linux-acpi@vger.kernel.org>; Tue,  8 Sep 2020 07:02:13 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id y2so15470960ilp.7
        for <linux-acpi@vger.kernel.org>; Tue, 08 Sep 2020 07:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/2SewoQNKfdvZ9130x2jsaU2/okRx8tFDqHXaAJPM5A=;
        b=JGVOHbBqWPpU0Q8L9woL1d2GbtrYzS0DIxJiG4Qc526y6YGijYry+9DuHLrGk4AkPh
         HglsW33sBrVqBLvI9Ldp2kiLotwU1516D9ublRTSbn0LX163oAsZQmRc6bBYvnr8MK4w
         b5lQLeL6I9nDr91a0Rn7qLmZLCyLCwF421imiVyR7bzfJ0uEwHIDk776XryoZ9LdO2l0
         9lWCcj0feoWEV4gREwpnhXS9Cwa9rCO3LLtNCxlelLRT9AInUx2swiSZBuGA/b4bPucX
         ttG4115TcL1RGy9WHQ7VfRs5NRWPB5K2DQTRmBAVvfrAVGKtV9f9Tv46q8DKYLBD6foj
         ilKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/2SewoQNKfdvZ9130x2jsaU2/okRx8tFDqHXaAJPM5A=;
        b=kx2BSbmrn5eTJmnHDwFcaqq0kCTyc7ofKCflr/g2ushQ8fTkS2XSy/6Q9v7Hn8uAcx
         pyp7gnl7GRY4mMtPIHAlR2FIkh6TE/qxLPrBLPRNy1jOADEPKlllh4zedxPhoIu20SVo
         SagmABUSqOx1eDKkFz1NWceQw6NUtplgySYX03wTrrtY/5CZWb6HtZH2Zn+4jB0/nwEb
         9qBYdY1ABpFJQzVND6zqRBN9YK2IuGIGhRmidNPvUjHn4Lbgnbv8lOvZ0H9i6B2APZcx
         1aCwpY1M4G7b/qepJ7EK977XCPV583s2fi7bILFKb5XF/fM6X/jiKBCofjI6LW1fhQnC
         fjhw==
X-Gm-Message-State: AOAM530L0VGNCx3rvKPeeKx9SmTsg0G4kXufUnFY1SwhKkhvlT9gj0s1
        SoTkgUHfBFc8GXSMZFAHw1QLSwj0j0c0fRZk3H3rDg==
X-Google-Smtp-Source: ABdhPJzwsSeBQ9p0c9q0Y8FRcx34We+BdEwhPsmnqyBN9DlgrfGhwepub6Xs5dnl/CskrDY7ZWHiqagdY7hXazz18Nw=
X-Received: by 2002:a92:189:: with SMTP id 131mr24167998ilb.40.1599573733037;
 Tue, 08 Sep 2020 07:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200908125813.8809-1-brgl@bgdev.pl> <20200908125813.8809-4-brgl@bgdev.pl>
 <20200908134957.GB1891694@smile.fi.intel.com>
In-Reply-To: <20200908134957.GB1891694@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 8 Sep 2020 16:01:59 +0200
Message-ID: <CAMRc=MdECnhqbRCFAy7hMQrWvF+Vz-rAU1GSD+d85eRSM6L9Lg@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpiolib: unexport devprop_gpiochip_set_names()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 8, 2020 at 3:52 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Sep 08, 2020 at 02:58:13PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Now that devprop_gpiochip_set_names() is only used in a single place
> > inside drivers/gpio/gpiolib.c, there's no need anymore for it to be
> > exported or to even live in its own source file. Pull this function into
> > the core source file for gpiolib.
>
> Did you miss to remove old file?
>
> >  drivers/gpio/Makefile       |  1 -
> >  drivers/gpio/gpiolib.c      | 47 +++++++++++++++++++++++++++++++++++++
> >  include/linux/gpio/driver.h |  2 --
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Arr yes, rebase failed me. :(

Bart
