Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8225C650D7A
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Dec 2022 15:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbiLSOi1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 19 Dec 2022 09:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbiLSOi0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Dec 2022 09:38:26 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26A12F0
        for <linux-acpi@vger.kernel.org>; Mon, 19 Dec 2022 06:38:24 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id z12so8321016qtv.5
        for <linux-acpi@vger.kernel.org>; Mon, 19 Dec 2022 06:38:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKqG8Fk58phXjItHVUvzhFmo7atfosqMC5aHN9WNUXY=;
        b=iVLKLUHIT35e6AGpap0hlXIDw0oCH1y2PYT7qF6qrkKzhcnJ/yAk3gJHHILp4uftJB
         aZ4tgKIP8xSi5C6Dnh7FCyJfJSwHyed10bgOfkNGvk5/wjpOfSUv/gK5CHb0Gj6zVR5y
         5eV7Nd0xixA5iFxZWulN8qlGbC/pa17HEbWd9a0hMvYnuyzN9B/euNx+VnoHbM8fepHV
         CVgP59XLy7tSabnxqqWLdM8nqRSRxfYRh5B2ncZv1S2/zoUAS/s718soBx/KQivmdT+Z
         4dxc4PQMh/8T6arR4f5x9Y35qLAkunLkGOuGdFH4wuaM1McZ+tXesPeApbvNfdEAp8gU
         NSIw==
X-Gm-Message-State: ANoB5pm6uQC6KCmPwUBR9iKG9C7gdYTdd5lcOqsCY7tPUjhMAl8X2iu2
        fw0C08rdX0jXEdwTfKqByvriX/zhVgYi27XT2yXwbsR1
X-Google-Smtp-Source: AA0mqf4bqZwZFhKulXTTCKL0qQeFu7NAHiWWmChbsHjpxnXo/Hx3djwLfY0VuZqZJ56Ag3dXOnuG2B4tMhFJJjUyBdk=
X-Received: by 2002:ac8:7dcb:0:b0:3a6:8dd0:4712 with SMTP id
 c11-20020ac87dcb000000b003a68dd04712mr33045246qte.411.1671460704114; Mon, 19
 Dec 2022 06:38:24 -0800 (PST)
MIME-Version: 1.0
References: <CADaG5hMao0nRXP9VrvVy__7H3vKUmQuH_rLVhy1m+GZdBGVJkQ@mail.gmail.com>
 <CADaG5hO1FsZ5JKEq4ZbM2j=xB7E-UheKxLB=k=QpEdDHKKBkuA@mail.gmail.com> <CADaG5hOc8f228Bmq7=aeA23SkbSuRdQUNSHLQqAS28iFXm0+FA@mail.gmail.com>
In-Reply-To: <CADaG5hOc8f228Bmq7=aeA23SkbSuRdQUNSHLQqAS28iFXm0+FA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 19 Dec 2022 15:38:08 +0100
Message-ID: <CAJZ5v0iUOn7w-RW4f71_80v301iwXzEYVxETjMcZ8n=8f-LEoA@mail.gmail.com>
Subject: Re: help with a sleep state bug (216424)
To:     shantzis62@gmail.com
Cc:     linux-acpi@vger.kernel.org, David Box <david.e.box@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On Sat, Dec 17, 2022 at 6:19 PM Michael Shantzis <shantzis62@gmail.com> wrote:
>
> [resending w/o HTML]
>
> On Sat, Dec 17, 2022 at 9:16 AM Michael Shantzis <shantzis62@gmail.com> wrote:
> >
> > Hello Rafael,
> >
> > I mailed you about this a few months ago and then I got caught up with other things. Adding linux-acpi@ to the email.
> >
> > I'm still trying to figure out what is going on with my computer's incomplete sleep state. I have the feeling that if someone who understands this looks at the logs, they may be able to tell me pretty quickly what is going on and how to proceed. If any of you can help me out with that, I'd really appreciate it.
> >
> > Thank you in advance for any help you can provide. I greatly appreciate it.
> >
> > Michael Shantzis
> >
> > On Sat, Sep 10, 2022 at 11:32 AM Michael Shantzis <shantzis62@gmail.com> wrote:
> >>
> >> Hi Rafael,
> >>
> >> I'm trying to get some help with this bug:
> >> Bug 216424 (see https://bugzilla.kernel.org/show_bug.cgi?id=216424)  - HP Spectre x360 incomplete sleep state
> >>
> >>
> >>
> >> Someone on the thread encouraged me to email you directly. The summary is that I have an HP Spectre x360 that doesn't entirely go into sleep state and its battery dies fairly quickly when the lid is closed (about 2x-3x more quickly than some of my other laptops/configurations).
> >>
> >> Any help you can give me in figuring this out would be greatly appreciated.
> >>
> >> Thanks so much, both for your contributions to linux (I never get to thank anyone personally :)) and in advance for any help you can give.

You're welcome.

According to the turbostat logs, the system doesn't reach the S0ix
platform state, even though the PC10 idle state is reached by the SoC.
The kernel does what it can do, but the hardware doesn't respond as
expected for some reason.  This type of failure is not particularly
easy to debug (I've added David Box who has some experience with
tracking similar issues to the CC list).

Can you please attach dmesg output without the initcall_debug command
line parameter to the bug entry?

Also, what's the latest kernel version you have tried?

Thanks!
