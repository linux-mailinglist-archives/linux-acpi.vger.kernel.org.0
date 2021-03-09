Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26EB2332AA8
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Mar 2021 16:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhCIPhO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Mar 2021 10:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbhCIPgt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Mar 2021 10:36:49 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3353C06174A
        for <linux-acpi@vger.kernel.org>; Tue,  9 Mar 2021 07:36:48 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id h10so21032342edl.6
        for <linux-acpi@vger.kernel.org>; Tue, 09 Mar 2021 07:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KKcarZ2k6Lx/lnZwiK8L/SyUqa/Q4iYnjTfXMDBPoZg=;
        b=agYiDO1bSAcBw9v1uDAJmiUR3YYiPF8kVgj1iAC10LRQb230SauWwrtY9GswV9dt4J
         65DXAtgB2OHz4hi5R9HAQKEFt31CvL4AirAsLPn2ImQmPGvkdfuiNf4ZOulPuZGwNEWL
         saUPy5GxI3m4IDbkky+WoY8iyRTFNRDyUxCOtkOSnR/ZiRTYnzvb8yhhawVD0LdwRPMb
         GoW1j+RP1jY4TjTggZ74HklZIEXscuA8wT48hq8BH//5GxiJ89rl/GIcYUVNpggsY4u7
         TFNYZl7uHKkSIQ8E+YsUxcyiqi+KER0HMnt5/vcKto5gvJ5Go6dSBETPKT1oRYOeFDzr
         CaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KKcarZ2k6Lx/lnZwiK8L/SyUqa/Q4iYnjTfXMDBPoZg=;
        b=Vojk1KKrFOv5DPxIXnfLWcr6bTOjZeCHk9V8uJGy1GFFLKVGMdCLHa68xaGA6E0w1g
         IX2tzeZmXzBn05pNw/8T5GsmetC5pW0Y8sgflvjNNjRdC4zK7XgmVXQ7mAndJTvhNhgx
         T/D1gmZWv5XTOLVsWGp7F/UecE9zinYftutzc34WiF2EfT7Kg+YJLeBjIMbvnMP8+Cfh
         pS7N46qgI9nQg+kbLAy2xRiLoQ0dTEvkD4MlUUSWZsHT4KG99iujhpnkSMsEh/8aJ1Ui
         oOMkdIx4a1ZJ8s1J1nQU5BTguIuAi7nOFuBY3FJcNPR73rP2MU1KQsmmEF7PeWzExZOZ
         yU+A==
X-Gm-Message-State: AOAM531rdeYXa0PLDylS8t3d16Je+t23yubkH/v9kmGa12o1PRgJT7tP
        qv5dCfy904CATFd8wkciQnp+lnTFkIsL7PQD5+8RyA==
X-Google-Smtp-Source: ABdhPJxHDck94uqnY+JMNKZkOg7mR+iDFSn15ZNz91KzTkwKiGGyTnj32npsAExezKG/EDA35JMP5+vA7YaWAZgPyRo=
X-Received: by 2002:a50:ee05:: with SMTP id g5mr4786047eds.164.1615304207767;
 Tue, 09 Mar 2021 07:36:47 -0800 (PST)
MIME-Version: 1.0
References: <YD9K8LzSFpuAhDvW@black.fi.intel.com> <CAMRc=Mf1MsRUGJN9Y09yVQ=OO41-kYRo8n3D3tyLpymnJ6_JvQ@mail.gmail.com>
 <YEX72lTYIwxc0I8O@smile.fi.intel.com> <CAMRc=MeWppCHTc5G3wu3MMb0ZvncbaNJfOLU=WFFTbaw7EVnXQ@mail.gmail.com>
 <CACRpkdZF2x-mAs3p=d1gx-rfrSGQA4J5v+-6WHOjFwt=62De5w@mail.gmail.com>
In-Reply-To: <CACRpkdZF2x-mAs3p=d1gx-rfrSGQA4J5v+-6WHOjFwt=62De5w@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 9 Mar 2021 16:36:36 +0100
Message-ID: <CAMRc=MftNQMNA4riDBkGBo0A1nmO808mux0fWf_inLzy8jfPnA@mail.gmail.com>
Subject: Re: [GIT PULL] intel-gpio for 5.12-2
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux GPIO <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 9, 2021 at 4:33 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, Mar 9, 2021 at 4:24 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > On Mon, Mar 8, 2021 at 11:26 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Sat, Mar 06, 2021 at 12:38:33PM +0100, Bartosz Golaszewski wrote:
> > > > On Wed, Mar 3, 2021 at 3:09 PM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > >
> > > > > Hi Linux GPIO and ACPI maintainers,
> > > > >
> > > > > This is material for v5.12-rcX (presumably -rc2). Since it touches ACPI, this
> > > > > PR is to both subsystems.
> > >
> > > > Pulled, thanks!
> > >
> > > Thanks! Though I don't see it in your repository.
> > >
> > > --
> > > With Best Regards,
> > > Andy Shevchenko
> > >
> > >
> >
> > For some reason the merge commit doesn't show up but I do have the
> > patches. Strange, I remember seeing the merge commit when I pulled it.
>
> Did you rebase the branch after pulling?
>
> That will drop the merge commit, and will also make linux-next
> complain that the commiter has not signed off the commits.
> (I.e. don't rebase a branch where you pulled in something.)
>
> Yours,
> Linus Walleij

Ah cr*p I did because of the v5.12-rc1 problem signalled by Linus Torvalds. :(

And I already sent a PR to him too...

Anything I can do now to fix that?

Bartosz
