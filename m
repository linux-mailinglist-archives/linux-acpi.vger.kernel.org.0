Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C979332A52
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Mar 2021 16:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbhCIPYt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Mar 2021 10:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbhCIPYU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Mar 2021 10:24:20 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515FBC06175F
        for <linux-acpi@vger.kernel.org>; Tue,  9 Mar 2021 07:24:20 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id x9so20881424edd.0
        for <linux-acpi@vger.kernel.org>; Tue, 09 Mar 2021 07:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GopuZyg5YHEXuIPIU2+0iXZVgjkZyI/sNfxjE+oPyFs=;
        b=M4YqV58UnS11Q0AEJWjZirDj7bHlekszkgIcvXMQuO7buvLJovDD0mIj7n+pnkCEqT
         uQOMOagL0Ur92R9emeWHDkYCIqAeU4jCtFQ5GXCJb85AGKaGxx46b595q1Y2i4G+i2j9
         FiN4eyClFgu0fe55xO3ml5TqkMzBaXajMm99rknRAqVwn0FVCtXT+N5JF39V2aFzdJy/
         7+NV2mkiX13ireGvZthXXaHDXdpwYtpKXzU1HMkUEGDl7yht0sJT/aSdNouTf0oJVtPa
         kK/FaW4EUwsks5PyBJLWJlRh720F31lIv50D7FBvIIt+Muqg+ZDL/59ZNBa0imM0c3Wl
         3aWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GopuZyg5YHEXuIPIU2+0iXZVgjkZyI/sNfxjE+oPyFs=;
        b=b6LjK5+EAZmNdidy54SiiZqQnVgqlquAkille/NcsSb8O2dJp78d55G+KRTj5Nxa4D
         2LMo1GRCOJMrBLbkCSs/+T8VggCHXATmHKMIXT0aUK81HqkVmUuqBqTgDDn3GzIyNKGA
         WREoMyf0Ux0UqdudT5YJFEbjaS/kp5REvAD2XMBXciRz7xprN3Ycbez9hH+rFUAqhVLX
         SrFwHqfkf8iItcNcWxcBcMFPUBfWQD5+++JVlMkXD4DuyKGwoEZWFvIFqDmGIrx2MSCs
         QEh+1heizJRHhR9JHuY1CrrB7+xqEbDaBhd6oWeurrTBj0mjN9qvB9Q4AfWZd4McmV4o
         1wvQ==
X-Gm-Message-State: AOAM530iXbOh0aCt7DYfMTBsBOiiSczRu1+DD/v4DJlRvVQUyCUiG4F2
        P5A37Su3GCzgZ6gmyWoSDoX1G+7SG1jf8gC9CzVBxQ==
X-Google-Smtp-Source: ABdhPJwQvrNCSDqNBqy1qEv7FZmMTyhL+ZdhXQGWT2bGcZYT0Voyo4m7TuW+5Bdt1q3/3Rj9UeQ8S5hfAg4gW23PlYA=
X-Received: by 2002:a05:6402:3550:: with SMTP id f16mr4700945edd.134.1615303459027;
 Tue, 09 Mar 2021 07:24:19 -0800 (PST)
MIME-Version: 1.0
References: <YD9K8LzSFpuAhDvW@black.fi.intel.com> <CAMRc=Mf1MsRUGJN9Y09yVQ=OO41-kYRo8n3D3tyLpymnJ6_JvQ@mail.gmail.com>
 <YEX72lTYIwxc0I8O@smile.fi.intel.com>
In-Reply-To: <YEX72lTYIwxc0I8O@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 9 Mar 2021 16:24:08 +0100
Message-ID: <CAMRc=MeWppCHTc5G3wu3MMb0ZvncbaNJfOLU=WFFTbaw7EVnXQ@mail.gmail.com>
Subject: Re: [GIT PULL] intel-gpio for 5.12-2
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux GPIO <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 8, 2021 at 11:26 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sat, Mar 06, 2021 at 12:38:33PM +0100, Bartosz Golaszewski wrote:
> > On Wed, Mar 3, 2021 at 3:09 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > Hi Linux GPIO and ACPI maintainers,
> > >
> > > This is material for v5.12-rcX (presumably -rc2). Since it touches ACPI, this
> > > PR is to both subsystems.
>
> > Pulled, thanks!
>
> Thanks! Though I don't see it in your repository.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

For some reason the merge commit doesn't show up but I do have the
patches. Strange, I remember seeing the merge commit when I pulled it.

Bart
