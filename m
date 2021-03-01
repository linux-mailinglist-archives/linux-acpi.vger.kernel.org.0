Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D900B328021
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Mar 2021 14:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbhCAN6q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Mar 2021 08:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236120AbhCAN6q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Mar 2021 08:58:46 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FC3C061756
        for <linux-acpi@vger.kernel.org>; Mon,  1 Mar 2021 05:58:05 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id p1so16334026edy.2
        for <linux-acpi@vger.kernel.org>; Mon, 01 Mar 2021 05:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nKuWC3rVV9sra+4DDgdLnle85IT4vlB1n7DPoNwpayo=;
        b=STgKjcbbPqlcVj+Yg1do/AfuQIj/wmBwy56Kj0C4VQoXnZHFAiF79BD5kiIcPWzgDB
         /ZXT0GpsZgkfB8E5WMMZcT285MlbPXod+cZrK1EXjwzKrhy35bATHm0CPmObm0oq2iwE
         oEI+69fCBlum8d1WP/UXUJFU4vArguEIHlK4IC8nudxpjtvVAcAyL0j06R8Zfiu+2jag
         SuVppZD1+mT0+pC3MHTdWLPRlXomrKYGro0wq7F2vycFK/G5nxbDhmwfPKJpv0RT4Ihn
         5eUckBWRXm8wdtgsfsoDYYpwSvGKOLFIDSToQdvRq+F7T+vF6H2YKs+tBmUrTssHgTFq
         mByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nKuWC3rVV9sra+4DDgdLnle85IT4vlB1n7DPoNwpayo=;
        b=CXpu0haUZmdzjBkmOarzOvrVHuqsRlnZKqJ8qJ8V1UDJhrcS5UCDqaIE7ZF/+X0oZk
         Yowdbp1jF1SAX0h9K9RiZrboIVGQgzzC8LndxZGeHd1KFApre+fQYY3cuIHTtnn1/hHZ
         sQDuFgEDRyYyXRkOiyDCvfIRErgM4V+Ihln5y2fYzrTKlhCc9+z383VRHTYrQJOqxWgL
         U+gdIHmGGAERlu+TipJ67M0KRRqk0JL2Q6+CAoWI+aIRQtuZ7o43i7dUZb5TuIp650dc
         PR7IJC+GB54VSMWgxASWUH/mDOIaJEFdqDs9v7ATdH1dnl3V9/eGMn8iS8TiOD21eEI3
         jsNw==
X-Gm-Message-State: AOAM532QC9HP/zVKnWdnZTIv7v8bS0gLkejgHk0DCcHvSVKuXEe7uBAY
        Qqrqu6OtGZOIb4OciJ3xhHPvVRQEtbnaZmLT406rOA==
X-Google-Smtp-Source: ABdhPJwYJDxPiEv3ADUo2gt/NLH8qTuwvXhaLRKLrw+7IP/68NCdtzYiQfFshSLhg0rbOrVB84ornicr77iSkLSXmE0=
X-Received: by 2002:a05:6402:35c8:: with SMTP id z8mr3291764edc.341.1614607083797;
 Mon, 01 Mar 2021 05:58:03 -0800 (PST)
MIME-Version: 1.0
References: <1614069358-50943-1-git-send-email-yang.lee@linux.alibaba.com>
 <YDTsWR/kXhd96ICI@smile.fi.intel.com> <YDe8/2toCGEH2Mf1@smile.fi.intel.com>
In-Reply-To: <YDe8/2toCGEH2Mf1@smile.fi.intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 1 Mar 2021 14:57:53 +0100
Message-ID: <CAMpxmJV5go-fHR2RWWdyi5a6ONeXrhC5c958oNZNzszt2aGN9A@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: Add missing IRQF_ONESHOT
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Yang Li <yang.lee@linux.alibaba.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Feb 25, 2021 at 4:07 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Feb 23, 2021 at 01:51:53PM +0200, Andy Shevchenko wrote:
> > On Tue, Feb 23, 2021 at 04:35:58PM +0800, Yang Li wrote:
> > > fixed the following coccicheck:
> > > ./drivers/gpio/gpiolib-acpi.c:176:7-27: ERROR: Threaded IRQ with no
> > > primary handler requested without IRQF_ONESHOT
> > >
> > > Make sure threaded IRQs without a primary handler are always request
> > > with IRQF_ONESHOT
> >
> > Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Bart, I guess I will collect this in my branch and send you a PR.
> I have more fixes to that file anyway.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Fine with me!
