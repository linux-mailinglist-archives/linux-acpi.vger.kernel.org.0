Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055394DB721
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Mar 2022 18:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350712AbiCPR2j (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Mar 2022 13:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345228AbiCPR2i (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Mar 2022 13:28:38 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FF94DF71;
        Wed, 16 Mar 2022 10:27:23 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-2db2add4516so31797597b3.1;
        Wed, 16 Mar 2022 10:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=onr5Sf9KbINy9g//cHa4fdZ0fDooBmnqs8UgpV35m60=;
        b=5pWGOT8j8KyWiV+5fWiFe5WyM4DGODz4ltRxDAfYcZkdxEkkLLGhd7Zp09J9BYsvbw
         WE+hHUWBCJA1+iRGAaFuWQmvhk34gUOgSxYrbgmtwKridTGmWiAFJ9+xNjUP22ju+ixh
         gWhxSZQVQ9XDg+NK2HjZskNKDqMdqbaKiYlGfw4jeRfmPIGCVlPaE0U1ggHndAOl1QmS
         Cu5mh8Ig4RlPqKpm5q9t5ddSFhtO3LUnQw+CF5+duloxdmeVJeEsqc+G4owYMRl3oTK/
         qzAJLQ/Ur6XAR1wOk1LEUT3xYDz/WsvDLezVT+/Y1BnIkSizUyow7m1o4qa2fb95z36I
         OhnQ==
X-Gm-Message-State: AOAM530fODDDsOD2KciYjBNEuXGx1EBQjPYDUiBO3OOrWD5MEPRG+m51
        HRAyQAgIqkGUptFwCyc8+s+kvgv1/IRuFYFKc3c=
X-Google-Smtp-Source: ABdhPJzlT8vBkg0Ad8ovzaqzwZ+UWN2SOVlHMo4X4klfAGv1+7XD4p8N7BrvzZymnKAGY7r/TzFpL9P8/ZlbesoHTMY=
X-Received: by 2002:a81:508b:0:b0:2e5:9904:8655 with SMTP id
 e133-20020a81508b000000b002e599048655mr1345972ywb.196.1647451642645; Wed, 16
 Mar 2022 10:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220314050340.1176-1-mario.limonciello@amd.com>
 <0101142d-3ea6-a47b-be26-76aaaac46b0a@redhat.com> <BL1PR12MB5157664C2AA7D80E7DF48EC9E20F9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <8841ecb6-6c2c-164f-76df-54c4410faa20@redhat.com> <CAJZ5v0gFzDAKHxDLf7Wq52fcGPx+jTWMqBb9oNWuqOSDJrgb1g@mail.gmail.com>
 <CAJZ5v0jArF+J7UnpAkF-qzS1EqVxuaf7UZYYQV7T_XR3T5tTHw@mail.gmail.com>
 <BL1PR12MB51571612A9594F5B759EDD81E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <CAJZ5v0jQKPS-jfRC17SOr_YS=MjZ7Fi62zDyOcgYT4GSzdg-sQ@mail.gmail.com> <29058b59-80f8-b29a-c54c-b58779c329e0@amd.com>
In-Reply-To: <29058b59-80f8-b29a-c54c-b58779c329e0@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 16 Mar 2022 18:27:11 +0100
Message-ID: <CAJZ5v0hdbz4ktUQv=2WA99Tqnq-13we4Qk5z7i_OQmA-ZaQkWQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] ACPI / x86: Add support for LPS0 callback handler
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Goswami, Sanket" <Sanket.Goswami@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 16, 2022 at 5:43 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> >>>> My preference at this point would be to use a notifier chain, unless
> >>>> that's not sufficient for some reason, because it appears to match the
> >>>> notifier usage model.
> >>>
> >>> Well, I'm actually not sure about that.
> >>>
> >>>>> I pointed this out, because making this change would also make 4/5 a bit
> >>>>> cleaner. You are recreating the same struct lps0_callback_handler on
> >>>>> stack twice there, which looked weird to me.
> >>>>>
> >>>>> Note if Rafael wants to stick with the approach from this v3, then
> >>>>> I guess that the approach in 4/5 is fine.
> >>>>>> Rafael - can you please confirm which direction you want to see here
> >>> for this?
> >>>
> >>> So the idea is that the PMC driver's "suspend" method needs to be
> >>> invoked from acpi_s2idle_prepare_late(), so it doesn't interfere with
> >>> the suspend of the other devices in the system and so it can take the
> >>> constraints into account.
> >>
> >> The reason to do nothing (besides a debug level message right now) with the constraints
> >> information is that at least on today's OEM platforms there are some instances constraints
> >> aren't met on Linux that need to be investigated and root caused.  These particular constraints
> >> don't actually cause problems reaching s0ix residency though.
> >
> > Why are they useful at all, then?
> >
> >>>
> >>> What is it going to do, in the future, depending on whether or not the
> >>> constraints are met?
> >>
> >> The idea was that if constraints were met that it would send the OS_HINT as part of
> >> amd_pmc_suspend/amd_pmc_resume, and if they aren't met then skip this step.
> >>
> >> It would effectively block the system from getting s0ix residency unless the constraints
> >> are all met.
> >
> > Why do that?
>
> I guess to both of your above questions this begs a comparison of how
> things work in Windows versus Linux.
>
> Windows Modern Standby has this concept of "SW DRIPS" vs "HW DRIPS".
>  From an end user perspective you close your lid or you click Start
> button and hit sleep and the machine is in sleep.  Whether it's in the
> deepest state is "invisible" to you unless you're running a sleep study.
>
> Windows will at this time requests devices to go into their deepest
> states and will continue to monitor them against the constraints table.
> When the constraints table is matched a uPEP driver is notified (this is
> the _DSM stuff we have in Linux too for "deepest state") and then it can
> do as it pleases.   ON AMD's platform this sends OS_HINT.  OS_HINT is
> meant to be indicate that the OS is done with all it's suspend actions
> (caches flushed, devices in D3 etc) and the system can "try" to enter s0ix.
>
> Windows will then also distinguish between different types of wakeups
> and have different behaviors for them.   There are wakeups that can be
> treated as keep screen off, and then possibly go back into deepest state.
>
> "As soon as the SoC wakes and the platform exits the DRIPS state, the
> CPUs start running code again. However, the screen stays powered off
> unless the interrupt was a result of user input or connecting to a power
> source"
> https://docs.microsoft.com/en-us/windows-hardware/design/device-experiences/transitioning-between-idle-and-active-states
>
> "During the Sleep state, specific value-adding SW activity may run"
> https://docs.microsoft.com/en-us/windows-hardware/design/device-experiences/modern-standby-states
>
> So from the time that I clicked sleep in the OS, I might NOT get into
> the deepest state (HW DRIPS), or I might have gotten in and out several
> times.  If a device driver failed to put a PCI device in D3 for example
> I would not be able to enter HW DRIPS, but the suspend wouldn't "fail".

Right.  I'm aware of how this is expected to work in the Windows
Modern Standby context.

> Now to contrast this to Linux when I enter suspend all drivers will run
> their various PM callbacks and devices will go into their deepest states.
> * If a driver fails, the suspend actually fails and you get an error
> code to go investigate what happened.
> * If the devices don't get into their deepest state by the time you get
> to the s2idle loop you don't get s0ix residency.
>
> As you can see at least for AMD's platforms OS_HINT is sent too "early".
>   That's why this series exists in the first place.

Right.

> So with all that said; why look at constraints at all if stuff is working?
>  From this design at least on Windows constraints are supposed to be a
> safety guard that you don't start the HW process for s0i3 process "too
> early".
>
> The last commit that is getting reverted in this series is an example of
> what could happen if the process is started prematurely.

Well, it is not "the process started prematurely", but an ordering
issue in a process that's already under way.

The real difference is that Modern Standby is designed as an extension
of the system working state and things can go from "working" to
"sleeping" in a kind of transparent fashion, whereas in Linux the
system is either suspended or working, or going from one of these
states to the other.

From the Modern Standby POV it only makes sense to attempt to enter HW
DRIPS if all of the potentially involved entities are ready, and hence
the constraints.  In Linux, they all are expected to get ready during
transitions from "working" to "suspended".

> >
> >> Given we know some OEM platforms have problems in current generations
> >> with constraints it would probably need to be restricted to this behavior only on a future
> >> SOC that we are confident of all drivers and firmware are doing the right thing.
> >>
> >> By passing the information to amd_pmc we can keep that logic restricting the behavior to
> >> only those platforms that we're confident on that behavior.
> >
> > Honestly, I'm not quite sure why it is a good idea to prevent the
> > platform from attempting to get into S0ix via suspend-to-idle in any
> > case.
> >
> > You know you have to suspend.  You don't know how much time you will
> > be suspended.  The constraints can only tell you what's the
> > lowest-power state you can achieve at this point, but why is it
> > relevant?
>
> Having thought through and said all I did above, I do concede you're
> right with the Linux approach to sleep the constraints really don't add
> a lot of value.  If a device fails to enter it's intended sleep states
> the suspend will "fail".  If the suspend succeeds but the constraints
> table doesn't match, it's just a hint where to focus on problems.

Exactly.

> I appreciate your thoughts and I will drop the constraints passing patch
> in this series.

Thanks!

> With that intent of dropping that would you still like this reworked as
> a notifier chain or keep it as this design?

I would introduce something like

struct acpi_s2idle_dev_ops {
        struct list_head list_node;
        void (*prepare)(struct device *dev);
        void (*restore)(struct device *dev);
};

and let whoever wants to use one of these pass the pointer to it to a
"register" function (that will only do a "list add").  The reason why
I wouldn't allow ->prepare() to fail is that failing suspend at this
point isn't particularly useful (and arguably it isn't really useful
at all, but that's a whole different topic).

This can be a const struct in a driver, so it cannot be modified even
by mistake which reduces the attack surface a bit.

Then, make changes to acpi_s2idle_prepare_late() and
acpi_s2idle_restore_early() like in the $subject patch, except that
the extra locking may not be needed if the "register" function uses
lock_system_sleep() for mutual exclusion.
