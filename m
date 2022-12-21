Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD04F6532C8
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Dec 2022 15:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbiLUO5K (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 21 Dec 2022 09:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiLUO5J (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Dec 2022 09:57:09 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D351BB
        for <linux-acpi@vger.kernel.org>; Wed, 21 Dec 2022 06:57:08 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id b16so16823275yba.0
        for <linux-acpi@vger.kernel.org>; Wed, 21 Dec 2022 06:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASAmxtzr5KDkYvNYhSu+ifwNyTKiPQHYSw8iTP+L3PE=;
        b=UPGNT1faM2dX79HhwfctBXk0mHNohLnRhkBetBRRCngrOBWavDNRWr+XE6RZpIGSoO
         ZiIFPr6QL0TxRwERN0DtIfck/XEW7vb8qF/pMwir80UYCqYBjWZmG3l354f30UMIvXt1
         18AukyLtmp9XfVd4YAekwKAA/fxDvqQoWz0y01ot7fx5vK1gb7Xnxw49m1JTQabi3d7H
         IFp9Z0DrFN+KCTkbFiLr/OtXsIsLNE9DC4dwwOTvHk6txKwG5sHtz7TJs9WtJUi6fXQy
         53a5B3ACdZFtrX1zfs0yGEO8q9YosapQOsTnd/B8kMJnaRWAZxTpIPXnyfKQNFpcTfjZ
         UdYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASAmxtzr5KDkYvNYhSu+ifwNyTKiPQHYSw8iTP+L3PE=;
        b=F0zfeYK1A5Q5Ox1creKh1CAEEtxtK9jcgHBM3eoVWN+nGVbHLlOC3eMVSSwSegDq60
         4+os6dFw4ffJy/7J1jAtCK+adrg3cvo/7G68xcMG1RRy1msrooEZc933MueFL2i4IqFT
         9y7dq+FJDi42mDR3egoHtW7HTWDBSNkWE9e4eCeRHW9FgOM0vSrwqWM+PERFCmT0Dp2R
         cfuTvcJ6Y3VzP0VeD823y9/o6qft4guoe0AUlmp/U07twnQgNHRyeEWbzex5IUipAIx/
         T/Ngsf4dnN3CybvTWNeiKq2JGJPfgge9rFtoOBph8EfvLhop6K3zd5dB947oiGyAxT1h
         Mjqg==
X-Gm-Message-State: AFqh2kphgZP5NoqTz7LxYgu9wjzXQloAb9n+ELhVjeTXmmFeWZMminXa
        pxLSa4mABAhgKArkKFwui8sj98T7QDQ+SHM16ypggMJGuTk=
X-Google-Smtp-Source: AMrXdXtgAvVOZzAHranGaEjNdDaUZNT3uF1OASse3dVO6jR6YThuKEg4VeibJf/rnzY46YHpsUNzkQdaSe1PTcY3ZHI=
X-Received: by 2002:a05:6902:128d:b0:6f9:fd74:22f with SMTP id
 i13-20020a056902128d00b006f9fd74022fmr204422ybu.100.1671634627841; Wed, 21
 Dec 2022 06:57:07 -0800 (PST)
MIME-Version: 1.0
References: <CADaG5hMao0nRXP9VrvVy__7H3vKUmQuH_rLVhy1m+GZdBGVJkQ@mail.gmail.com>
 <CADaG5hO1FsZ5JKEq4ZbM2j=xB7E-UheKxLB=k=QpEdDHKKBkuA@mail.gmail.com>
 <CADaG5hOc8f228Bmq7=aeA23SkbSuRdQUNSHLQqAS28iFXm0+FA@mail.gmail.com> <CAJZ5v0iUOn7w-RW4f71_80v301iwXzEYVxETjMcZ8n=8f-LEoA@mail.gmail.com>
In-Reply-To: <CAJZ5v0iUOn7w-RW4f71_80v301iwXzEYVxETjMcZ8n=8f-LEoA@mail.gmail.com>
From:   Michael Shantzis <shantzis62@gmail.com>
Date:   Wed, 21 Dec 2022 06:56:56 -0800
Message-ID: <CADaG5hPECCbzGBiK_eUwi+QdMH3kfuZr6cZ4VaoM-+YfK2mQMQ@mail.gmail.com>
Subject: Re: help with a sleep state bug (216424)
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org, David Box <david.e.box@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Thanks, Rafael (and David, in advance).

I attached the new dmesg to the bug entry. Just for convenience, it's
found here:
https://bugzilla.kernel.org/attachment.cgi?id=3D303447

I also added the comment about the kernel version I used for
debugging: 5.19.0-rc1.

I have not tried the latest kernel version. I'll do this and get back to yo=
u.

m

On Mon, Dec 19, 2022 at 6:38 AM Rafael J. Wysocki <rafael@kernel.org> wrote=
:
>
> Hi,
>
> On Sat, Dec 17, 2022 at 6:19 PM Michael Shantzis <shantzis62@gmail.com> w=
rote:
> >
> > [resending w/o HTML]
> >
> > On Sat, Dec 17, 2022 at 9:16 AM Michael Shantzis <shantzis62@gmail.com>=
 wrote:
> > >
> > > Hello Rafael,
> > >
> > > I mailed you about this a few months ago and then I got caught up wit=
h other things. Adding linux-acpi@ to the email.
> > >
> > > I'm still trying to figure out what is going on with my computer's in=
complete sleep state. I have the feeling that if someone who understands th=
is looks at the logs, they may be able to tell me pretty quickly what is go=
ing on and how to proceed. If any of you can help me out with that, I'd rea=
lly appreciate it.
> > >
> > > Thank you in advance for any help you can provide. I greatly apprecia=
te it.
> > >
> > > Michael Shantzis
> > >
> > > On Sat, Sep 10, 2022 at 11:32 AM Michael Shantzis <shantzis62@gmail.c=
om> wrote:
> > >>
> > >> Hi Rafael,
> > >>
> > >> I'm trying to get some help with this bug:
> > >> Bug 216424 (see https://bugzilla.kernel.org/show_bug.cgi?id=3D216424=
)  - HP Spectre x360 incomplete sleep state
> > >>
> > >>
> > >>
> > >> Someone on the thread encouraged me to email you directly. The summa=
ry is that I have an HP Spectre x360 that doesn't entirely go into sleep st=
ate and its battery dies fairly quickly when the lid is closed (about 2x-3x=
 more quickly than some of my other laptops/configurations).
> > >>
> > >> Any help you can give me in figuring this out would be greatly appre=
ciated.
> > >>
> > >> Thanks so much, both for your contributions to linux (I never get to=
 thank anyone personally :)) and in advance for any help you can give.
>
> You're welcome.
>
> According to the turbostat logs, the system doesn't reach the S0ix
> platform state, even though the PC10 idle state is reached by the SoC.
> The kernel does what it can do, but the hardware doesn't respond as
> expected for some reason.  This type of failure is not particularly
> easy to debug (I've added David Box who has some experience with
> tracking similar issues to the CC list).
>
> Can you please attach dmesg output without the initcall_debug command
> line parameter to the bug entry?
>
> Also, what's the latest kernel version you have tried?
>
> Thanks!
