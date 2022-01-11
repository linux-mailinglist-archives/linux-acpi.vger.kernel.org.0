Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845F148B79F
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jan 2022 20:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238704AbiAKTtK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Jan 2022 14:49:10 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]:46698 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239066AbiAKTtJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Jan 2022 14:49:09 -0500
Received: by mail-qt1-f172.google.com with SMTP id v7so413051qtw.13
        for <linux-acpi@vger.kernel.org>; Tue, 11 Jan 2022 11:49:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TeFVIYnmoZ2Wtzy9Qa2fKz0J7zlV2F1damFAkkMLnBA=;
        b=jibjirF4Qhp8pa/LDqTmRbnJA0U3PMAVykmhoxHbSpLtDl7hlWghuwe8jZtIgeDu4Z
         YKUxvEAHKYCTcfZlYIhg0ABd6ck2jGdMBILQVOxk3/E/1jiQb5IXB+TnX0GSLIo783Lk
         0Al6YL9aqJeAeScnIXUdVmIEXPmBppqqFDSq4TEan+0orvvBp+MeG2Y7SrTzz+tqh+VU
         Pu4xYBrWlmF3JhH+/xVrZhzkANxnRG83YhDNCpSgmKKowF0la13/SMSUfxO8ecnOziG6
         PAU85dKnRAhtOP+rzA4+Rw+QjSG7YuMR0hTC7pDqo1FXfeq2F6WIZQ66Hcmw2paYRn6R
         9AVQ==
X-Gm-Message-State: AOAM533PlSre33HPhiPqrtqnDHvT/oGhQ03C6nWiSBOp1upaZyz4iJpB
        TDV2Bg6uQTu9ARPnDBtpjXWTGM5RnnX9lNKvy1Mb65Xf
X-Google-Smtp-Source: ABdhPJxxSiwAGKbCXrXrDjouWrOweCiOh4JDzf2iVURY/dpXsJdht2gFxUh7gg3saFe21+3G1r+5QTna4UlkcA+ZWZY=
X-Received: by 2002:ac8:5991:: with SMTP id e17mr5116440qte.344.1641930549095;
 Tue, 11 Jan 2022 11:49:09 -0800 (PST)
MIME-Version: 1.0
References: <20220105193910.25678-1-mario.limonciello@amd.com>
 <CAJZ5v0g-q4SLfK65bvWum7+OQZgbNQs47Pu3y-BCs9Px2C3Jag@mail.gmail.com>
 <eb3a323a-a4bb-bf8a-e642-88a2f68eeda7@amd.com> <CAJZ5v0hCVUNNgxn3bnn-mDKuYwnHSnOjwwXWiMJrv41dWuqCJQ@mail.gmail.com>
 <BL1PR12MB51443949D250B3963AEC1224F7519@BL1PR12MB5144.namprd12.prod.outlook.com>
 <CAJZ5v0iSR7rCpF3HKR_O0EUg7n80RM=oXm5MFh6f=DJZF+hWQg@mail.gmail.com>
 <BL1PR12MB5144434DE31017304CAA43FBF7519@BL1PR12MB5144.namprd12.prod.outlook.com>
 <e1a43f9b-e4d0-5df6-cd32-1843a1bd1b29@amd.com> <CAJZ5v0jiKfFE1pFS-vGefYpHdsUvRxrzUY-dbyvkPA1Ehssg-g@mail.gmail.com>
 <3e09ef49-6645-59d8-5e66-1640c4ca91de@amd.com>
In-Reply-To: <3e09ef49-6645-59d8-5e66-1640c4ca91de@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 Jan 2022 20:48:58 +0100
Message-ID: <CAJZ5v0jHO598k7f-QUfKLqtJ0hOwM9jABnG62QJM+1fnY_vJOQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] On AMD platforms only offer s2idle w/ proper FW
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "bjoern.daase@gmail.com" <bjoern.daase@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 11, 2022 at 8:35 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> >>
> >> That's why I thought my patch series made sense.
> >>
> >> I guess another (antisocial) response would be to to return false when
> >> the suspend callback for amdgpu happens and dev_err mentioning that
> >> firmware support is needed for suspend.
> >
> > If you want to avoid exposing s2idle at all in some cases, you need to
> > change the sysfs I/F in /sys/power/ so that it doesn't expose "s2idle"
> > in mem_sleep or "freeze" in state at all.
>
> Right now they make it so that s2idle isn't exposed in "mem_sleep", but
> "freeze" is still exposed in "state".
>
> I'd be worried about breaking userspace with taking "freeze" out of state.
>
> > That's much more intrusive
> > than just failing every s2idle attempt (which is what the patches do
> > AFAICS)
> As they stand right now when the BIOS is set to S3:
> # cat /sys/power/mem_sleep
> [deep]
>
> # echo freeze > /sys/power/state
> Returns a failure though.
>
> And then when it's set to Modern Standby :
>
> # cat /sys/power/mem_sleep
> [s2idle]
>
> # echo freeze > /sys/power/state
> Works
>
> >
> > Do you want to do that for platforms supporting S3, or for platforms
> > that don't support any kind of suspend at all?
>
> You know since this series went out
> 6dc8265f9803ccb7e5da804e01601f0c14f270e0 was merged.  This will probably
> have cleaned up the problem state that Bjoern found in the first place.
>
> So this is really a philosophical discussion now if it's worth offering
> s2idle in /sys/power/mem_sleep on AMD systems.

Well, if "freeze" is present in "state", then "s2idle" needs to be
there in "mem_sleep", because they are clearly documented as
alternative paths to the same functionality.

> Admittedly this has been an APU notebook oriented discussion.  Platforms
> that don't support any kind of suspend (like servers) will get caught up
> in this and could no longer do s2idle either.
>
> With the assumption that 6dc8265f9803ccb7e5da804e01601f0c14f270e0 helps
> the problem state I'm leaning back on we should add some warnings to let
> people know how to help themselves for power consumption if they did this.
>
> We can probably put those in amdgpu though.

Sounds like a better direction to me, honestly.
