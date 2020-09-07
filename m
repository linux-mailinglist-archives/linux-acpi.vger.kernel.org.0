Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406DA25F945
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 13:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbgIGLXx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 07:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728947AbgIGLXA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Sep 2020 07:23:00 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54ADEC061756
        for <linux-acpi@vger.kernel.org>; Mon,  7 Sep 2020 04:01:14 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id w8so12153261ilj.8
        for <linux-acpi@vger.kernel.org>; Mon, 07 Sep 2020 04:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mM0y+Q0a8sB0DkvdsC2ZAa0jhM0rMUB3DCeyiwaznjU=;
        b=rKpXyZ2H5uP2/h9Dt5pZ0EPjXGgMA3de0HXUxZtvju1LXugoHzeD4RaryePMRR4utI
         K1Xpnc7dqWuJ1RRNtAvBK9L4dDhOmI1bjUHQE6oaeroH1bhZD6WHqXQXEatSsX2GFpgq
         sloN9nsm3Z8VHroFwHEs2MLKdtmiSZCfrSio0VqGihZq5rXGXCGVr5/1Euh+ed6/NGxR
         +PtyIa/kQzMjz3AGzVI0uXl9wO4mXKNkjoWAYUT0S74QK9gzwlCsvvzKGVr1bhFs4Lp2
         krBFagjdLqhrymwwVXwl3GsqF95A2B4h0KlX1P6NgCoyedRyf1lcmDqwyoeacDbfAQkR
         cKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mM0y+Q0a8sB0DkvdsC2ZAa0jhM0rMUB3DCeyiwaznjU=;
        b=jn3VL/Gh/niZC/nBWK+B238d2jOgmRyEwedP7busI048NPOI1CuaFCApXIJiRQPeCx
         3GTD2iQKnFfpbwxoVcrJzGnPzt/hLeGzYFQONEhiv/4sO0G4XLJQuSxyaT1IawxyWDxZ
         GF3qQtvrm7dCIu4O8ewwAIzpvqmKKOwt5yMmPBGZZHdOsJ3dL7i4TcDIy3kO3D6DmApH
         8BQ7LlIKTLjwvKceN5a8dnp3yNZ6OSyyH+I1X/RB4zq42Hs5vD6ZSwbcbj8Zp5tlhkHq
         tMlaqKXsbvPcU0C6rB3sZK/AJo22QCNnL4NFECdjuar071Tswb3J9zOkLk72qU77k1aj
         b+Tg==
X-Gm-Message-State: AOAM5338r4HC2heEFh62rRH+kRmhf+TUXdVs3Ryj0SB5BWpo8ToUCyXM
        I7zNz1QL7I1+SSVgBQgOYC79Fm36ija0bwyUj2MJbw==
X-Google-Smtp-Source: ABdhPJzKTB4141AX04DUZCtSVaif2wmDuuNUNco4lagdf94reZmn5rumBiscprbs2LT1YPBLbmGSPn2FRbAHpzNrfok=
X-Received: by 2002:a92:189:: with SMTP id 131mr19175912ilb.40.1599476473551;
 Mon, 07 Sep 2020 04:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200904154547.3836-1-brgl@bgdev.pl> <20200904154547.3836-14-brgl@bgdev.pl>
 <20200904164820.GB1891694@smile.fi.intel.com>
In-Reply-To: <20200904164820.GB1891694@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 7 Sep 2020 13:01:02 +0200
Message-ID: <CAMRc=Mea4pGbW+fY3mCWfNSSqo9ZwaJxx2C0JmstnQOc8eVrLg@mail.gmail.com>
Subject: Re: [PATCH 13/23] gpio: mockup: pass the chip label as device property
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 4, 2020 at 6:48 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Sep 04, 2020 at 05:45:37PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > While we do check the "chip-name" property in probe(), we never actually
> > use it. Let's pass the chip label to the driver using device properties
> > as we'll want to allow users to define their own once dynamically
> > created chips are supported.
> >
> > The property is renamed to "chip-label" to not cause any confusion with
> > the actual chip name which is of the form: "gpiochipX".
> >
> > If the "chip-label" property is missing, let's do what most devices in
> > drivers/gpio/ do and use dev_name().
>
> Just wondering if we have a documentation in kernel how this mockup mechanism
> works and what kind of properties it uses.
>
> Side note: moving to software nodes would make some advantages in future such
> as visibility properties and their values (not yet implemented, but there is an
> idea to move forward).

Seems like we're implicitly using software nodes already:
fwnode_create_software_node() is called when adding device properties.

Bart
