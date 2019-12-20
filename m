Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91D69127974
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2019 11:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfLTKd3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Dec 2019 05:33:29 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29367 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727258AbfLTKd3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 20 Dec 2019 05:33:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576838007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dmt13RMD5aQ2MYXVw19Ilk0o7Wyai72pdtMpv4qPTtU=;
        b=hBKQr+y4+6FO4sHP5+9GyMU/52ETm7S+SwZT2IJQWFqyICE9/qPBgsWB78eypF6wgckJvt
        p/6WqZJiPaIjFWZ/WJYDnqYBVYj8jQDPoAACXArxftkqiIfUALoIRYul9xw5ZA+Fb2/w46
        b4SExcIvZbuoLoYS9fIvkeGcy+U/zYs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-d_l4o8_uPjekWdyYlhF8uw-1; Fri, 20 Dec 2019 05:33:26 -0500
X-MC-Unique: d_l4o8_uPjekWdyYlhF8uw-1
Received: by mail-wm1-f69.google.com with SMTP id p2so2369487wma.3
        for <linux-acpi@vger.kernel.org>; Fri, 20 Dec 2019 02:33:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dmt13RMD5aQ2MYXVw19Ilk0o7Wyai72pdtMpv4qPTtU=;
        b=fy8Fz9NYRBQZkZqLQtk3D+vVWC1QUpyeJOy7zq43zgzYux5x12x7JmxEm0dMaTlaof
         ezSIYyuR8IrJ9g0wQ8Y8djnMA7YtxWeOLoMbD6yqqJNQ7sbLjSU/3HB1Bo6cwm2hMWV1
         u7vkymoOiiHFmI7XEp1as3SGLLoq1ppHL8hSftoJyLTejIWJwksrJ4HMi8k1byOqXtkT
         fm+CubG1DhxeiyumUE6CYaVQ2TtXRrvpglRcc5rgUqM35jdKnctBuU2r8velr86CDSKE
         V9hi+kSaeNYEvdtyD7ja81ESwxwu9FR6NyU2aGLD9vosd6F7nqruqz3Jc3B6Ng1LskRT
         8zGQ==
X-Gm-Message-State: APjAAAVvyJLvwlBsp2ZBcTQ3Al3ohYLijRO8VO0/w7I4JX0I7+PylaVF
        dOpiCDWwCXO4VzbEoMCREwcFAXZlowObT+NHmrB3ybSEIAngCOV2r6UKAnv6C5rcOjFFvCJ8ilx
        gTOIu2dGQ7dYkbXv7vcxJsQ==
X-Received: by 2002:a1c:f008:: with SMTP id a8mr15213397wmb.81.1576838005181;
        Fri, 20 Dec 2019 02:33:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqyB4vPOIpSM6TUqmZkQcgXydkp+Elfj9aDQamKhs/Gp3u5seTgc+/4nLCHzGTUPriKNTsW42w==
X-Received: by 2002:a1c:f008:: with SMTP id a8mr15213377wmb.81.1576838004922;
        Fri, 20 Dec 2019 02:33:24 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id v188sm9858559wma.10.2019.12.20.02.33.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2019 02:33:24 -0800 (PST)
Subject: Re: [PATCH] ACPI: button: Add a DMI quirk for Razer Blade Stealth 13
 late 2019 lid-switch
To:     Jason Ekstrand <jason@jlekstrand.net>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20191206175409.335568-1-jason@jlekstrand.net>
 <3565c99f-3cc4-32cb-1cac-98c7b0392e5c@redhat.com>
 <CAOFGe95h-eKPiS-7D8_Lg3wcOR-yuQQNkunw21K_rQ64DtCMJw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a6a75a89-5650-8e50-ec2b-f5da8b633b81@redhat.com>
Date:   Fri, 20 Dec 2019 11:33:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAOFGe95h-eKPiS-7D8_Lg3wcOR-yuQQNkunw21K_rQ64DtCMJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 20-12-2019 04:02, Jason Ekstrand wrote:
> Sorry for the late reply.  The e-mail got filtered and I didn't see it until now. :-(

No problem.

> On Sun, Dec 8, 2019 at 8:05 AM Hans de Goede <hdegoede@redhat.com <mailto:hdegoede@redhat.com>> wrote:
> 
>     Hi,
> 
>     On 06-12-2019 18:54, Jason Ekstrand wrote:
>      > Running evemu-record on the lid switch event shows that the lid reports
>      > the first close but then never reports an open.  This causes systemd to
>      > continuously re-suspend the laptop every 30s.  Resetting the _LID to
>      > open fixes the issue.
> 
>     Sorry to be a bit nitpicky here, but the LID does work normally right,
>     so it does signal an event when it gets closed a second time right.
> 
> 
> What I observed with evemu-record is exactly what I wrote above.  Without this patch, I see one LID event when I close the laptop lid the first time and never see another LID event again, either open or close.

Right, but I assume that with the fix to assume the LID is "open" on resume, that
suspending by LID does work a second (and third, etc.) time, so the LID is
sending events more then once, it just is only sending close events. Where as
your current comment and commit messages to me sound as if it only sends an
event once.

If closing the LID does properly suspend a second time, then the issue is
that it always reports close, even when queried to sync the state on resume,
so in essence the same as on the Medion Akoya E2215T, which uses the following
comment in its dmi entry:

         {
                 /*
                  * Medion Akoya E2215T, notification of the LID device only
                  * happens on close, not on open and _LID always returns closed.
                  */
                 .matches = {
                         DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
                         DMI_MATCH(DMI_PRODUCT_NAME, "E2215T MD60198"),
                 },
                 .driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
         },

So assuming that I have correctly understood that the LID does suspend the
system a second time when closed a second time (and a third, etc.) then
IMHO the comment for the Razer Blade Stealth 13 late 2019 should be
something like the above comment (and idem for the commit msg).

I hope this explains better what I tried to say in my first email,
if not let me know.

Regards,

Hans



> 
>     Your current commit message and comment suggest closing the LID only
>     works once. So perhaps something like this for the comment:
> 
> 
> The commit message and comment are different from our IRC conversations because I updated them after running evemu-record and seeing slightly different behavior than we discussed on IRC.  Our earlier conversations were based mostly on guesses from me seeing spurious suspend issues and looking at the types of ACPI bugs I'd seen reported for other machines.
> 
> --Jason
> 
>     /*
>        * Razer Blade Stealth 13 late 2019, _LID always reports closed,
>        * even when opened.
>        */
> 
>     And adjust the comment accordingly.
> 
>     Regards,
> 
>     Hans
> 
> 
> 
>      > Signed-off-by: Jason Ekstrand <jason@jlekstrand.net <mailto:jason@jlekstrand.net>>
>      > ---
>      >
>      > Re-sending due to a typo in my own e-mail address. :(
>      >
>      >   drivers/acpi/button.c | 11 +++++++++++
>      >   1 file changed, 11 insertions(+)
>      >
>      > diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
>      > index 662e07afe9a1..f7ca94e41c48 100644
>      > --- a/drivers/acpi/button.c
>      > +++ b/drivers/acpi/button.c
>      > @@ -122,6 +122,17 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
>      >               },
>      >               .driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
>      >       },
>      > +     {
>      > +             /*
>      > +              * Razer Blade Stealth 13 late 2019, _LID reports the first
>      > +              * close but never resets to open.
>      > +              */
>      > +             .matches = {
>      > +                     DMI_MATCH(DMI_SYS_VENDOR, "Razer"),
>      > +                     DMI_MATCH(DMI_PRODUCT_NAME, "Razer Blade Stealth 13 Late 2019"),
>      > +             },
>      > +             .driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
>      > +     },
>      >       {}
>      >   };
>      >
>      >
> 

