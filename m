Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45A3332A83
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Mar 2021 16:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhCIPcz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Mar 2021 10:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbhCIPcl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Mar 2021 10:32:41 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1721C06174A;
        Tue,  9 Mar 2021 07:32:41 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso5395498pjb.3;
        Tue, 09 Mar 2021 07:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BePRG7c7k9kiWCyMlIxrT3Z+uhfA3XI1iMPCbgmftGY=;
        b=NjzGn1ygui/9m28aO40I70EsJwdpFG57X06IMCEHo8riOksOkbyj9948I0ernOcmIg
         LzVFvTOGDC0ftvdCK4C4JoHqj1uCGG6W1lOAOAPSIsBMIN6WjNIrwEfCzNtwEA280zLZ
         xWwsRuPJ76gk4W5Th+e92UOYWj4UyaX/oh77Pg2e8D4e+ND813zMLINZIcDvJRCP+kkC
         MCu7B+eSu9Jc2fq9qrDF2Izrpiuoj70pqm8N6o/2tl2Q1adrcxfcsrxrFGNGoMabwS1b
         dTQwOr/eb5WlgM6YCkm/ExwjjbR+eLZBD8lZVRsZNOGaAifxiPPdP5zJOiEkMk4SIwnH
         mEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BePRG7c7k9kiWCyMlIxrT3Z+uhfA3XI1iMPCbgmftGY=;
        b=F6gy/w2eNvo6/+RLgwbwbd6mrn3cG3DONBL98BUyNB4FGKDbKMdRVJqIGMp+LVwKGO
         lQNHHWgQayIbV25QD96kRuthMPAS9tbUIt8kVznqBs2qsDTe/OAH4AT3mjS9qTBxqwXc
         GF3GeDzGIJoRXtKigx3MF/muaZSo3M76YIF3FToYxa8WJ12sjpkfAZ5OO28tYELTp72P
         YClbqduYaQIXgQ+n2OSf83Bs8q1LmaI7A5oGZeEP5VbSVB/xslJh3Oo1N959HJ5lBZfe
         hgfxAFNPEy6WNvAooMQIq0nXk+YGefyptwfsXGSPd9i3twCw33TMcQwgU5pO+aSfVUh9
         ++Uw==
X-Gm-Message-State: AOAM5321wYrAYulxqSDMLMIwU8V13hVFIjasdoN2p0vTwYJIqdalj/Zs
        4JuHoOQJJR551dTCERDVABHcKYTmzMLKl2WbaCCd2h2XmZaaJY1Z
X-Google-Smtp-Source: ABdhPJygZA3l0vXf9psM+zNrEd/CsmQjqLje0qvEzY6s5AuJMaoMEQBLL0gGvhitmbMHUqa1oMy8dV5OWts9ju+/bms=
X-Received: by 2002:a17:902:c808:b029:e6:4204:f62f with SMTP id
 u8-20020a170902c808b02900e64204f62fmr4413892plx.0.1615303961374; Tue, 09 Mar
 2021 07:32:41 -0800 (PST)
MIME-Version: 1.0
References: <YD9K8LzSFpuAhDvW@black.fi.intel.com> <CAMRc=Mf1MsRUGJN9Y09yVQ=OO41-kYRo8n3D3tyLpymnJ6_JvQ@mail.gmail.com>
 <YEX72lTYIwxc0I8O@smile.fi.intel.com> <CAMRc=MeWppCHTc5G3wu3MMb0ZvncbaNJfOLU=WFFTbaw7EVnXQ@mail.gmail.com>
In-Reply-To: <CAMRc=MeWppCHTc5G3wu3MMb0ZvncbaNJfOLU=WFFTbaw7EVnXQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Mar 2021 17:32:25 +0200
Message-ID: <CAHp75VdMpkJY1C56eoWH4OqYnW2id9q4fOZ+_M7N1cH0CVoGyA@mail.gmail.com>
Subject: Re: [GIT PULL] intel-gpio for 5.12-2
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux GPIO <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 9, 2021 at 5:25 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Mon, Mar 8, 2021 at 11:26 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Sat, Mar 06, 2021 at 12:38:33PM +0100, Bartosz Golaszewski wrote:
> > > On Wed, Mar 3, 2021 at 3:09 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > Hi Linux GPIO and ACPI maintainers,
> > > >
> > > > This is material for v5.12-rcX (presumably -rc2). Since it touches ACPI, this
> > > > PR is to both subsystems.
> >
> > > Pulled, thanks!
> >
> > Thanks! Though I don't see it in your repository.

> For some reason the merge commit doesn't show up but I do have the
> patches. Strange, I remember seeing the merge commit when I pulled it.

Hmm... I have rebased recently _after_ I saw these patches in your
branch. In any case It seems you need to rebase for-current due to
issues Stephen noticed.
Note, it's a tag, not a branch. It's still there and available.
https://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-gpio-intel.git/tag/?h=intel-gpio-v5.12-2


-- 
With Best Regards,
Andy Shevchenko
