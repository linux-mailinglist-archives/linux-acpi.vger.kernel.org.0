Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5A2332AD3
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Mar 2021 16:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhCIPoR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Mar 2021 10:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbhCIPoR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Mar 2021 10:44:17 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC2BC06174A;
        Tue,  9 Mar 2021 07:44:17 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id mz6-20020a17090b3786b02900c16cb41d63so5414758pjb.2;
        Tue, 09 Mar 2021 07:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3N05bm3ytJMFpuSnPE2S83gjNwx2II+qrX0PgT4wgXQ=;
        b=rR7qQ7zZWiWvrbGJhmuRux5YYUXnPn325ddHBLBHBIImQAJLZHgy2O4TJvLv/nKpOM
         vS356WojSHZXVMoSzeKKvyET/XYbg3BLOEpHdrt0NYBVFpVxECVUBXUd3wEbjAlDILDy
         o1FHRbTAidrp5rwGxOCrQPQCJf8vU/eUQMDtFD+98y6RtTqEbYZkox9w1Dtr/R0dl8B2
         n9mWGBlqeJyKTLM14IiPbNXl7f92HdwPP+eQOHlIF6yyoANQM/MEZac0q0qXuVn+OkRR
         weW1y5EHzTrJXJKA7NEHRdzsA/8PD58PQ2v+NXBbOaEC3bTkrNIfbp2VrTC+hlXBvWmA
         GKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3N05bm3ytJMFpuSnPE2S83gjNwx2II+qrX0PgT4wgXQ=;
        b=cg1GacD9aoJLjLXU5eFLB9hKe2M4TYaVJ1AINf5zE2qdk0ZI48nWq15y1CS0BGS++x
         K3/mR2+KIlKrj5WyhD6Pji5foM9kPCssB9IfoMtbYH4zuUIn71a38lLXPp7EGcp9+7Ot
         P2sJjm8h6kDaGDOiVFBXI5XKipk1vcEjH3dJouKAyYkpmm0J/RcKv9xUv6Ctwh/aXXFQ
         SzNUsc4//RjDloQmx9fYUsaTXkdvULnY7HF2/dQabhi0NebJ/9cIqmbhmr/BzF3kG+XG
         J0cxmMSAAUrXavb72L42q6JlPda3EDv00AtDJy1VUCSbAXKfA+awzS1VhrT93bs0Ebmr
         g6Pw==
X-Gm-Message-State: AOAM531LqwLERWLRghrl1z80nEEABvcgwrMFSHuvh6jrOZZ0C/7g4HO3
        6NhG5ys2hFEIUmmWrrEX791O7o/zi/jO0+xUIac=
X-Google-Smtp-Source: ABdhPJzBRc7AbYe2ybGdajI5bYQ5gbBoatR20cx/izz5O/M5VN4dceSwV3/BsodvRJ08SG5wr6sISfQPVxNoqHND2o4=
X-Received: by 2002:a17:902:ee02:b029:e6:5397:d79c with SMTP id
 z2-20020a170902ee02b02900e65397d79cmr861441plb.21.1615304656560; Tue, 09 Mar
 2021 07:44:16 -0800 (PST)
MIME-Version: 1.0
References: <YD9K8LzSFpuAhDvW@black.fi.intel.com> <CAMRc=Mf1MsRUGJN9Y09yVQ=OO41-kYRo8n3D3tyLpymnJ6_JvQ@mail.gmail.com>
 <YEX72lTYIwxc0I8O@smile.fi.intel.com> <CAMRc=MeWppCHTc5G3wu3MMb0ZvncbaNJfOLU=WFFTbaw7EVnXQ@mail.gmail.com>
 <CACRpkdZF2x-mAs3p=d1gx-rfrSGQA4J5v+-6WHOjFwt=62De5w@mail.gmail.com> <CAMRc=MftNQMNA4riDBkGBo0A1nmO808mux0fWf_inLzy8jfPnA@mail.gmail.com>
In-Reply-To: <CAMRc=MftNQMNA4riDBkGBo0A1nmO808mux0fWf_inLzy8jfPnA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Mar 2021 17:44:00 +0200
Message-ID: <CAHp75VfnJOE6FhKQwHka6cq_q5mr3VNkh=OMcqdAtbj0oGLZHA@mail.gmail.com>
Subject: Re: [GIT PULL] intel-gpio for 5.12-2
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux GPIO <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 9, 2021 at 5:38 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> On Tue, Mar 9, 2021 at 4:33 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Tue, Mar 9, 2021 at 4:24 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

...

> > Did you rebase the branch after pulling?
> >
> > That will drop the merge commit, and will also make linux-next
> > complain that the commiter has not signed off the commits.
> > (I.e. don't rebase a branch where you pulled in something.)
> >
> > Yours,
> > Linus Walleij
>
> Ah cr*p I did because of the v5.12-rc1 problem signalled by Linus Torvalds. :(
>
> And I already sent a PR to him too...
>
> Anything I can do now to fix that?

Yep!

Steps are easy:
0) tell Linus T. that you have to redo PR
1) take the base as
https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git/commit/?h=gpio/for-current&id=cf25ef6b631c6fc6c0435fc91eba8734cca20511
2) Merge my tag as I explained in the other mail thread
3) (re)apply https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git/commit/?h=gpio/for-current&id=b41ba2ec54a70908067034f139aa23d0dd2985ce
4) create a new tag
5) send PR to Linus T again

Yes, it will mess up the history, but it will fix the issue.

-- 
With Best Regards,
Andy Shevchenko
