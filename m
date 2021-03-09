Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B64F332AB1
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Mar 2021 16:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhCIPiR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Mar 2021 10:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbhCIPiA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Mar 2021 10:38:00 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EACC06174A;
        Tue,  9 Mar 2021 07:38:00 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id c16so6773374ply.0;
        Tue, 09 Mar 2021 07:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rCgDylN9h5YyAnaseTEpuLEiO2u2MBRnHcdV2qbADU8=;
        b=WIQftWX11GpzIWeG6cBbpnW+ymTLq4JyNHpe0zov6vHyMthS9C6hcqZ5c5i3qWS3Ai
         eia4Q2QcewY2RboHhqH5Rq5HoCkfzZNvhTBjBpaxEJibOa6GiikrtqYtMCLxVjuJLrXu
         ICghPwNSE/7pkUfSHZgwdGEV9c4Ky8UNVpKD8VQzju2eDrabsiR3xDpLQZrwHTI6efj7
         oW023F5+qxTFpy+8c3p/vg6W1KFqdc/B2bEc9MKwYvumPDN+Pvfprmm8CIxsBNKpSfOu
         KVbXOcfe787T15kB8z1d8Hn4YQaHcqaKfWe9Agl8jee1JO/nER6liHNa3lnfWCebuKlW
         cRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rCgDylN9h5YyAnaseTEpuLEiO2u2MBRnHcdV2qbADU8=;
        b=rhZ+fsqXy1mtidpMfmCfsFu//0y9/KsgOm/VGL+1Pbi3nFW5QTPnMhnsHZ5KUsuIwz
         FNVSjVw1GcUA2l7hy7YBC55JyyImRYzYT1maUrPaQpGsJcQakRP0MF29Cw53/caORyjD
         iksuNKaMn6antNdz0vHmD5om0uA57bqIscJjsFzUwCESb/8tmJDrh0FJtF6SvZqNbYvL
         QJp3fogDMFgukR84potHguFAXHpvUP81d8s+DEn9/mQjPeyYtDMq3YXs/sCEi0Eh1D2k
         eMMh2xqvJqfzCXZd5bz0EyTH6Ieh6xkT5YmNP64BI7p8g2LXMeRAUCX24K8F8A0X5ifW
         JvMA==
X-Gm-Message-State: AOAM530HnOr3HpVAG1fnKcOHESj09QIUzznnPudIZpg/nD9Tp0CtVlTt
        4RAHk0RQygRUE4j7IRxLOkJNIclDjXtA9dPBkAo=
X-Google-Smtp-Source: ABdhPJyfL28bIg7FuwHqkfe+lzqzQU/mxfkd8LJvFtYUDiKd7QdGaeAH6t2onha1VecyF/v7IUxH5rDF2BQYrNG6iDk=
X-Received: by 2002:a17:902:c808:b029:e6:4204:f62f with SMTP id
 u8-20020a170902c808b02900e64204f62fmr4434162plx.0.1615304280436; Tue, 09 Mar
 2021 07:38:00 -0800 (PST)
MIME-Version: 1.0
References: <YD9K8LzSFpuAhDvW@black.fi.intel.com> <CAMRc=Mf1MsRUGJN9Y09yVQ=OO41-kYRo8n3D3tyLpymnJ6_JvQ@mail.gmail.com>
 <YEX72lTYIwxc0I8O@smile.fi.intel.com> <CAMRc=MeWppCHTc5G3wu3MMb0ZvncbaNJfOLU=WFFTbaw7EVnXQ@mail.gmail.com>
 <CACRpkdZF2x-mAs3p=d1gx-rfrSGQA4J5v+-6WHOjFwt=62De5w@mail.gmail.com>
In-Reply-To: <CACRpkdZF2x-mAs3p=d1gx-rfrSGQA4J5v+-6WHOjFwt=62De5w@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Mar 2021 17:37:44 +0200
Message-ID: <CAHp75Vej=CTUgixN6m_=4bhkUoVRZQ6JvsRp63Nj+4hSsO4Ypg@mail.gmail.com>
Subject: Re: [GIT PULL] intel-gpio for 5.12-2
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux GPIO <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 9, 2021 at 5:34 PM Linus Walleij <linus.walleij@linaro.org> wrote:
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

> > For some reason the merge commit doesn't show up but I do have the
> > patches. Strange, I remember seeing the merge commit when I pulled it.
>
> Did you rebase the branch after pulling?
>
> That will drop the merge commit, and will also make linux-next
> complain that the commiter has not signed off the commits.
> (I.e. don't rebase a branch where you pulled in something.)

Actually one may use --rebase-merges (that's my default option after I
learn it, okay, I actually learnt its predecessor).

-- 
With Best Regards,
Andy Shevchenko
