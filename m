Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279162603C3
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Sep 2020 19:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgIGRyZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Sep 2020 13:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbgIGLWc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Sep 2020 07:22:32 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C290C0617AA
        for <linux-acpi@vger.kernel.org>; Mon,  7 Sep 2020 04:06:05 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id r25so2590692ioj.0
        for <linux-acpi@vger.kernel.org>; Mon, 07 Sep 2020 04:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=og92g0L7hPgsl8mDF4E0oRjHENzkIz2/kCylVnn3aEQ=;
        b=VSQj3CfqsFG0w0R6IxVFzdq16ii5bv8V7LWtx8mdfazpSH82uYeoie36r4Ix/aZNjm
         rmVIDi989E2n1MmojSJDRlZiGBvVEppkRQQqi+m2pKrwISBsxj1Lyea4x+266sVik2qY
         OA2+Cm2PT2j/75XX1RvwMBLLB+a1zyBDo/aP4SupJprcZ0fs8AlJMMAoFxNbUoXlo2Q/
         cPLuCtWe3tFYJQWyLmkPdYjafhnQ3Ma9gOcMyXCU1Q+FffNcDNQpPq4dyoC3Qf+Glj82
         PPSJeJjKB5BAqYlhuj7vUVP+okdpZmjCcraoI8gLNg5Ltv/AR8UzUnwVVaXtjr5r889n
         9JmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=og92g0L7hPgsl8mDF4E0oRjHENzkIz2/kCylVnn3aEQ=;
        b=okgnKCMPLZVd5/YsmPvo4Kz7U+B6JiptOzGUCwRly5IAKYpg9qtj7ObOl+494Gx3C0
         zouVJglVB6DOWn7W8RgDGR35yCwd0wS0erhl5rHiQF3VLSJ2M4NyhXmEUxhwV6nE+N2t
         5bND9WZz2NzSKFPr6nWIynFAC0FfS2xJrzBHIGCz6bBGx0/EOurwYS3/nO1wgXoYwckk
         Nh6G1L5UXT5HEyUlLE/DFqJzMPvItCKNUrjfxEpVIpD2cvicL8QwjiCn0U9HiXoDUjXu
         gKzYwFzRmA/F8Y0RrLlP2zyeCtolG6AwwTLvQfMQJFS763kwUMMXDSqx2+XlyG37j40h
         l6Zg==
X-Gm-Message-State: AOAM53041ax1uYuvcPrGSOrS7UQsv5hCyExjiQuq23hd1AbRyIvzbu80
        9WnzK2zo6bAcMbsQ60rF6uLAyw/KLk5dwr4fjKSvjw==
X-Google-Smtp-Source: ABdhPJyod5VJBi59vRhPy1AeFPICUDWH+c8TTmKc169CEOJtj3iVYBKBHtDG0vSqtP6YjcYurac6iPQb5KedcXxThBY=
X-Received: by 2002:a5d:8352:: with SMTP id q18mr3579085ior.31.1599476765032;
 Mon, 07 Sep 2020 04:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200904154547.3836-1-brgl@bgdev.pl> <20200904154547.3836-17-brgl@bgdev.pl>
 <20200904165029.GD1891694@smile.fi.intel.com>
In-Reply-To: <20200904165029.GD1891694@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 7 Sep 2020 13:05:54 +0200
Message-ID: <CAMRc=MfrYJrkX2RfjXkCLtyzkM8MemTuUgEu_n-E+2mngk9mbA@mail.gmail.com>
Subject: Re: [PATCH 16/23] gpio: mockup: refactor the module init function
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

On Fri, Sep 4, 2020 at 6:57 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Sep 04, 2020 at 05:45:40PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > This is in preparation for dynamically created chips.
> >
> > Let's split out the code that can be reused when creating chips at
> > run-time. Let's also move the code preparing the device properties into
> > a separate routine. This has the advantage of simplifying the error
> > handling.
>
> Almost all contents of this patch should go to proposed helper as I mentioned
> before. Will make this patch quite small and understandable.
>

Sorry, I'm not sure what you're referring to.

Bart
