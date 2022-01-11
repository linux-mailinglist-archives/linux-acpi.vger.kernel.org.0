Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6600D48B449
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jan 2022 18:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241318AbiAKRpS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 11 Jan 2022 12:45:18 -0500
Received: from mail-qk1-f175.google.com ([209.85.222.175]:43984 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344731AbiAKRoo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Jan 2022 12:44:44 -0500
Received: by mail-qk1-f175.google.com with SMTP id 82so1686258qki.10
        for <linux-acpi@vger.kernel.org>; Tue, 11 Jan 2022 09:44:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=75L9BV0EIW7g+MEZjOD0smDQs5qPQbIVHrR19cl1Lvg=;
        b=L52BMWlugbJ1unugMmzdC4vjC0VEJS9yF3prjADfb56QFslEAn9iPu9emL7X6w3J1D
         YDKwUOc6OKJTRFFA+Mpm4rRTnmeXN8uTiySgfIe5J6ulxI/KsmNo4Pp35UcSx4+dXZRw
         zFv+sghn9fOZh3MVxy/lauzXwEqf1WD9f5OAsYIByYiTbbJY4rq6n22REp3fFj8MYK4l
         hi0uZqGzyiM1VuYXWKFOXr0YTyh+3gyTrus6awTe+nwB81seScQrQ30NV1XVbJKFc76H
         YJ6qUf0WlUkABnMJ8u9PxjSUUI1R6ku82PPViVt+PGOIdTSvoxWgxkVJR1pczmWdp0Fn
         NwxQ==
X-Gm-Message-State: AOAM530mKnExtbIJ5KceCFSUTmG81ti+pFBadAquPj0T6e2KCc21+fE3
        mS32QtGbUaYmLcVL3ZZEcDWcwojB4kK2kfADFuc=
X-Google-Smtp-Source: ABdhPJyLiYVxq34ltJLLRx2vpejCcCfN0PjR5MZIPZMMM5UN3ihh4YOji2a4n6/WUGAWm3bNcyggEVpfJzig2xenzkg=
X-Received: by 2002:a37:dc45:: with SMTP id v66mr3859859qki.516.1641923083721;
 Tue, 11 Jan 2022 09:44:43 -0800 (PST)
MIME-Version: 1.0
References: <20220105193910.25678-1-mario.limonciello@amd.com>
 <CAJZ5v0g-q4SLfK65bvWum7+OQZgbNQs47Pu3y-BCs9Px2C3Jag@mail.gmail.com>
 <eb3a323a-a4bb-bf8a-e642-88a2f68eeda7@amd.com> <CAJZ5v0hCVUNNgxn3bnn-mDKuYwnHSnOjwwXWiMJrv41dWuqCJQ@mail.gmail.com>
 <BL1PR12MB51443949D250B3963AEC1224F7519@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB51443949D250B3963AEC1224F7519@BL1PR12MB5144.namprd12.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 Jan 2022 18:44:32 +0100
Message-ID: <CAJZ5v0iSR7rCpF3HKR_O0EUg7n80RM=oXm5MFh6f=DJZF+hWQg@mail.gmail.com>
Subject: Re: [PATCH 0/3] On AMD platforms only offer s2idle w/ proper FW
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "bjoern.daase@gmail.com" <bjoern.daase@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 11, 2022 at 6:32 PM Deucher, Alexander
<Alexander.Deucher@amd.com> wrote:
>
> [AMD Official Use Only]
>
> > -----Original Message-----
> > From: Rafael J. Wysocki <rafael@kernel.org>
> > Sent: Tuesday, January 11, 2022 12:06 PM
> > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Cc: Rafael J. Wysocki <rafael@kernel.org>; Rafael J . Wysocki
> > <rjw@rjwysocki.net>; ACPI Devel Maling List <linux-acpi@vger.kernel.org>;
> > S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>; Natikar, Basavaraj
> > <Basavaraj.Natikar@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; bjoern.daase@gmail.com
> > Subject: Re: [PATCH 0/3] On AMD platforms only offer s2idle w/ proper FW
> >
> > On Tue, Jan 11, 2022 at 5:23 PM Limonciello, Mario
> > <mario.limonciello@amd.com> wrote:
> > >
> > > +Alex
> > >
> > > On 1/11/2022 09:52, Rafael J. Wysocki wrote:
> > > > On Wed, Jan 5, 2022 at 8:39 PM Mario Limonciello
> > > > <mario.limonciello@amd.com> wrote:
> > > >>
> > > >> Currently the Linux kernel will offer s2idle regardless of whether
> > > >> the FADT indicates the system should use or on X86 if the LPS0 ACPI
> > > >> device has been activated.
> > > >>
> > > >> On some non-AMD platforms s2idle can be offered even without
> > proper
> > > >> firmware support.  The power consumption may be higher in these
> > > >> instances but the system otherwise properly suspends and resumes.
> > > >
> > > > Well, the idea is that s2idle should not require FW support at all.
> > > > >
> > >
> > > May I ask - why?  It's an intentional design decision?
> >
> > Yes, it is.
> >
> > > > It may not be possible to reach the minimum power level of the
> > > > platform without FW support, but that should not prevent s2idle from
> > > > being used.
> > > >
> > > >> On AMD platforms however when the FW has been configured not to
> > > >> offer s2idle some different hardware initialization has occurred
> > > >> such that the system won't properly resume.
> > > >
> > > > That's rather unfortunate.
> > > >
> > > > Can you please share some details on what's going on in those cases?
> > > >
> > > > Technically, without FW support there should be no difference
> > > > between the platform state reachable via s2idle and the platform
> > > > state reachable via runtime idle.
> > >
> > > During resume there is a number of page faults that occur and during
> > > initialization the ring tests fail.  The graphics is unusable at this
> > > time as a result.
> > >
> > > The amdgpu code actually *does* distinguish between the 3 different
> > > cases of S3, S0ix, and runtime suspend.
> >
> > But s2idle doesn't guarantee S0ix in any case.
> >
> > > The function "amdgpu_acpi_is_s0ix_active" causes different codepaths
> > > to be used during the suspend routine.
> >
> > Well, as I said, s2idle need not mean S0ix.
> >
> > > In this particular case that FADT doesn't set the low power idle bit
> > > and that function returns false meaning the s3 codepath is taken but
> > > the hardware didn't go through a reset.
> >
> > If there is a separate S3 code path, taking it when pm_suspend_target_state
> > == PM_SUSPEND_TO_IDLE is incorrect.
> >
> > > It *might* also be possible to solve this by mandating an ASIC reset
> > > in such a case (we didn't try).
> >
> > I'd rather do a PM-runtime path equivalent if the target sleep state is
> > PM_SUSPEND_TO_IDLE and there is no FW support for S0ix.
> >
> > > However it comes back to my first upleveveled question - is this a
> > > case we really want to support and encourage?  This type of bug and
> > > combination of codepaths is not a case that is going to be well tested.
> > > This patch series will align the kernel behavior to only what AMD validates.
> >
> > But this does not follow the definition of s2idle and its documentation.
>
> At least for devices integrated into the SoC, the power rails are controlled by the firmware in the SoC.  For S3, the power rails are cut by the FW when the platform enters S3.  For S0ix, the power rails are cut when all of the devices on the rail suspended and various conditions are met.  Also, in the case of some devices, the device has to be in a very specific state for s0ix to work properly.  The GPU is the big one here.  For S3, the entire GPU has to be re-initialized at resume.  For S0ix, the GPU's state is largely handled by the firmware and attempting to re-initialize it won't work unless you reset it.  Integrated AMD graphics don't support runtime power management, only dGPUs do.  For integrated graphics the firmware dynamically controls the power at runtime so there is no need to do anything special for runtime pm.  For dGPUs we support d3cold either via ACPI on platforms like all-in-ones and laptops or via a driver initiated sequence for add-in-cards.
>
> What does S2idle ultimately do when all devices have suspended?  Does it enter S0ix or S3 at the end when it want to ultimately suspend the platform, or is the assumption that if all devices have suspended, the that is equivalent to S0ix or S3?  For AMD platforms, either S3 or S0ix needs to be entered for the platform to actually power down most of the power rails.  It's not clear to me what we should do for s2idle.

s2idle will never enter S3, because that requires platform support and
generally is a different thing (eg. some devices need special upfront
preparation for S3, wakeup may need to be configured in a special way
etc.).

It will attempt to enter S0ix if possible, but otherwise it will just
put CPUs into the deepest available idle state and stay there until an
interrupt (or equivalent) triggers.

Physically, at a device level, s2idle is more similar to runtime
suspend than to S3, but it uses system-wide suspend callbacks and it
requires wakeup to be disabled for the devices that are not allowed to
wake up the system by user space, that is device_may_wakeup(0 returns
false (PM-runtime assumes wakeup to always be enabled for the
suspended devices that can signal wakeup).

In any case, the ACPI system state for s2idle is always S0.
