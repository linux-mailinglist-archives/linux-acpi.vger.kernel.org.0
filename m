Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AF5694DD5
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Feb 2023 18:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjBMRVE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Feb 2023 12:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBMRU5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Feb 2023 12:20:57 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AF31A65B
        for <linux-acpi@vger.kernel.org>; Mon, 13 Feb 2023 09:20:56 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id i18so5760753pli.3
        for <linux-acpi@vger.kernel.org>; Mon, 13 Feb 2023 09:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u3UYU5VuDwql0z0bUwRUw+J5kKvLOo1Kd32ar3uMe8A=;
        b=oJ0JFVaFMr3+pu4NOs0ksHekVlOalYOzWxvNeNXGda9+dVBL+b8Ppr1JC7xg9b/FN+
         pv9/leOpH7vul2MMWpO00p1cI0dW5p5Vkn4h+F8zpaWjzbrCaVAtSHXaR2eZg0UdNuNm
         UW+D2fn74Xm417lK6Yp6Yrvh3rIcc5+R4vkRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u3UYU5VuDwql0z0bUwRUw+J5kKvLOo1Kd32ar3uMe8A=;
        b=QSggyxbpuvxV9SHTqdmzBebG0pZzIhITeep/UABR7GNNdB33SBD7dD7cZ4avPRsiGC
         gq/hThNtFNLsqxuxTAw2gMd0iq/OZmGsLrXIR3gwmb9RiHPoNAdCbVNo3/qYDv+ehUq5
         8yLAnA0QhML6k/SOXZE1yIdOlIMukkVJC/B955lkwK50GAAAUN5t/DT6h3lmmPYHhBdu
         gyIMjtIWQOtFavf8CuB680k/HNsDAAnHc5M/oyJ9SKlbknOia3E9qLSeWCOQoTWlX9ok
         DsZ0FNxRyckdLJ4eI1xVtP8XMRdJaUCLV5XklogpIGWlvtwZI0cCNyxLQQ/DiJYOgL8M
         9jyA==
X-Gm-Message-State: AO0yUKXmd2foAw2vSiA8fWyoEHGE9wLDv3i15E2pL5nAzGNRAvY4Pk+Z
        e41Ukn3WN49jJyUS/lfKIQr9WsH7mqaaxzf7
X-Google-Smtp-Source: AK7set9WfeGg3JU8U2i6Soxq15MZYQtKdwEmjvygAiBa0ZDuxIfqLh72GJD/+VLimgOoOct7YB4Y9g==
X-Received: by 2002:a17:90b:3b49:b0:233:cbb9:968e with SMTP id ot9-20020a17090b3b4900b00233cbb9968emr8649943pjb.9.1676308855398;
        Mon, 13 Feb 2023 09:20:55 -0800 (PST)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com. [209.85.215.169])
        by smtp.gmail.com with ESMTPSA id g2-20020a633742000000b004f2c088328bsm7492815pgn.43.2023.02.13.09.20.54
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 09:20:54 -0800 (PST)
Received: by mail-pg1-f169.google.com with SMTP id 78so8563799pgb.8
        for <linux-acpi@vger.kernel.org>; Mon, 13 Feb 2023 09:20:54 -0800 (PST)
X-Received: by 2002:aa7:9795:0:b0:5a8:5b4e:908e with SMTP id
 o21-20020aa79795000000b005a85b4e908emr2958698pfp.10.1676308853423; Mon, 13
 Feb 2023 09:20:53 -0800 (PST)
MIME-Version: 1.0
References: <20230210164636.628462-1-wse@tuxedocomputers.com>
 <Y+Z5OSa6hepQBOyc@smile.fi.intel.com> <029b8d80-db28-cdb2-5c39-334be6968fad@tuxedocomputers.com>
 <Y+owDqifuU9nf+1i@smile.fi.intel.com> <86db79fa-5efb-caad-3310-60928907cc58@amd.com>
 <Y+pLLzLDotZQLpdA@smile.fi.intel.com> <97026dc5-e92e-62fe-43ae-33533125d900@tuxedocomputers.com>
In-Reply-To: <97026dc5-e92e-62fe-43ae-33533125d900@tuxedocomputers.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Mon, 13 Feb 2023 10:20:41 -0700
X-Gmail-Original-Message-ID: <CAHQZ30Cs+kp82coR10Wat7q3S_8+pFf=5=44kMEMcjBOjmn=6A@mail.gmail.com>
Message-ID: <CAHQZ30Cs+kp82coR10Wat7q3S_8+pFf=5=44kMEMcjBOjmn=6A@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: Add a ignore wakeup quirk for Clevo NH5xAx
To:     Werner Sembach <wse@tuxedocomputers.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        mika.westerberg@linux.intel.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SUSB#_EN

On Mon, Feb 13, 2023 at 7:47 AM Werner Sembach <wse@tuxedocomputers.com> wrote:
>
> Am 13.02.23 um 15:37 schrieb Andy Shevchenko:
> > On Mon, Feb 13, 2023 at 07:20:48AM -0600, Mario Limonciello wrote:
> >> On 2/13/23 06:41, Andy Shevchenko wrote:
> >>> On Mon, Feb 13, 2023 at 12:30:08PM +0100, Werner Sembach wrote:
> >>>> Am 10.02.23 um 18:04 schrieb Andy Shevchenko:
> >>>>> On Fri, Feb 10, 2023 at 05:46:36PM +0100, Werner Sembach wrote:
> >>>>>> commit 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
> >>>>>> changed the policy such that I2C touchpads may be able to wake up the
> >>>>>> system by default if the system is configured as such.
> >>>>>>
> >>>>>> However on Clevo NH5xAx/TUXEDO XA15 Gen10 there is a mistake in the ACPI
> >>>>>> tables that the TP_ATTN# signal connected to GPIO 10 is configured as
> >>>>>> ActiveLow and level triggered but connected to a pull up.
> >>>>> I'm not sure I understand the issue here. From what you say here it seems
> >>>>> correct ACPI description.
> >>>> TBH I copied the commit description from https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4cb786180dfb5258ff3111181b5e4ecb1d4a297b
> >>>> which is for a different device having the exact same problem.
> >>> Yeah, and I reviewed that and seems paid no attention to this detail.
> >>>
> >>> So, ActiveLow + PullUp is the _right_ thing to do in ACPI.
> >>> The problem seems somewhere else.
> >>>
> >>> Mario, can we have an access to the schematics of the affected pin to
> >>> understand better what's going on?
> >>>
> >>> Or is that description missing some crucial detail?
>
> Schematics for the NH5xAx can also be found on this unofficial clevo mirror
> (service manuals, scroll to end for schematics):
>
> http://repo.palkeo.com/clevo-mirror/NH5xACx_AFx_ADx/NH50AC.zip
>
> http://repo.palkeo.com/clevo-mirror/NH5xACx_AFx_ADx/NH50AF1.zip
>
> User: repo
>
> PW: repo
>
> >> The schematics were shared by the reporter for the original issue which is
> >> how we reached the conclusion there was a mistake.
> >>
> >> As they're both Clevo designs it's certainly possible they have the same
> >> mistake in two systems.

> > Thank you!
> > I have looked at the schematics and read discussion.
> >
> > So, the conclusion that this is a BIOS bug is incorrect in my opinion.
> > The problem is either in the PMIC/EC firmware that shouldn't shut down 3.3VS
> > signal for a while or on the PCB level, so that pull up should be connected
> > to another power source that stays on.
> >
> > This means the description on the initial patch with the same issue is
> > incorrect.
> >
> > Do we know the power sequence on the suspend to see which and how on the
> > time line the power sources are off/on?
> >

If you look at the load switch for 3.3VS, its EN2 pin is connected to
SUSB#_EN which is connected to SUSB# which is connected to
AND(SUSB#_PCH -> SLP_S3_L, PM_SLP_S0 -> S0A3_GPIO). So there is no
PMIC/EC firmware that is incharge of this. I guess I'm not quite sure
how they have S0A3_GPIO configured, so maybe I have an invert wrong.

The EC does control DD_ON which controls the 3.3V and 5V rails.

> >>>>>> As soon as the
> >>>>>> system suspends the touchpad loses power and then the system wakes up.
> >>>>>>
> >>>>>> To avoid this problem, introduce a quirk for this model that will prevent
> >>>>>> the wakeup capability for being set for GPIO 10.
> >>>>> I'm not against fixing this, but wouldn't be better to actually target the root
> >>>>> cause and have a different quirk? Or is it me who didn't get what is the root
> >>>>> cause?
> >>>>>
> >>>> I missed to reference the original discussion while copying the description:
> >>>> https://gitlab.freedesktop.org/drm/amd/-/issues/1722#note_1720627 (Note that
> >>>> it's a somewhat convoluted issue spanning multiple bugs when you scroll up
> >>>> from that particular linked comment, which are however irrelevant for this
> >>>> patch)
> >>>>
> >>>> I'm not deep into how ACPI defined IRQ work so maybe not a good idea for me
> >>>> summing it up, as I might have misunderstood parts of it ^^
> >>> The GpioIo() and GpioInt() resources have gaps in them, due to this some
> >>> additional information is required or some heuristics is used to deduct
> >>> the settings.
> >>>
> >>> All this is described in
> >>> https://www.kernel.org/doc/html/latest/firmware-guide/acpi/gpio-properties.html
> >>>
> >>>> I added the other ones from there to the cc.
> >>> Thank you.
