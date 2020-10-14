Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC43D28E5A7
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Oct 2020 19:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgJNRol (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Oct 2020 13:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgJNRol (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Oct 2020 13:44:41 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BA9C061755;
        Wed, 14 Oct 2020 10:44:41 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id z22so241984wmi.0;
        Wed, 14 Oct 2020 10:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ieO/NF4wG/IXmQnKsMTVrsYB1eWpln7oBpB9WVl/evk=;
        b=Cbs+M08d4iOdIl5TmpItA92P0UNO6oXeCqIWzdRSvrWp75MLKBPEG+uOztpGCTQ+y0
         dpF0u+CFI6a8QweEt7BwE9kNZdPhqgLuLGqWnN6qjPV0yXTqEleR01Tq6At2O0APgoz8
         Dj6FmDjOMUjtrwRhbqEZl1yx7QcKFrxS+UwF0ooFH5e7JX189HbjVDNNaeY5dLvl/C1R
         PG6+M9GTqxbwVPGQbQhglB1Gnp1+uUXGlVExRv7H1Cmw6zj3nOfuOnd8olzxO7gauKsR
         X7C5sP2HPHXL69CTZ+HMT6kMEBisTnh0v1O/eJCyMjymaO8ZXzLFCPFCIwGioHZ7++5h
         epUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ieO/NF4wG/IXmQnKsMTVrsYB1eWpln7oBpB9WVl/evk=;
        b=DD0KB1FWpKsoqxfpWEEQN/g23onk/JHRUV/9NDL5I2NfROthRQP95M+Ei/jEd4EiwI
         GDa/T3vDkrQohO3YZbkRNGVcy196hBxcAfcNzhtcPN9g+SE7WT8s+lcnkNAQEcdpV2/u
         lOAMxkQtFyM7DlDifRiJ+aMHJTEguTIIfuGs3HzHaT2HHWapHM69VnDK6mY7rPkr7ob6
         AdZbQYtIWU4NofYjuioR6KTtm3PGjT/8xf5WBbcQAi2zZheg0mtQKCXZTDw7emgrngbX
         u3ppbxaSLQpXK/cgNcnTa0h0g5+Yxa37L5YBlhhdpxc7WF31FEufgp9XKTnoSlVwSHSe
         Aedg==
X-Gm-Message-State: AOAM5325Ql1k8gPVj2+5q1bZ28RD25IWboq6n0NWE7Qzy7Gx4r1OCKwY
        8UzmGvVrqmbz958atoTCrLO8m1ImwSQOCw==
X-Google-Smtp-Source: ABdhPJxPKEJG+UaVy0v9/mLZ1Q/pjma68YnqojCmkWEivNPYEmskssCJsBkZUFOCJrLqOvx3+oYsgg==
X-Received: by 2002:a05:600c:2211:: with SMTP id z17mr44597wml.92.1602697479007;
        Wed, 14 Oct 2020 10:44:39 -0700 (PDT)
Received: from pce.localnet (host-80-117-125-178.retail.telecomitalia.it. [80.117.125.178])
        by smtp.gmail.com with ESMTPSA id f189sm251878wmf.16.2020.10.14.10.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 10:44:37 -0700 (PDT)
From:   Elia Devito <eliadevito@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Bastien Nocera <hadess@hadess.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mgross@linux.intel.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Benjamin Berg <bberg@redhat.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Pearson <markpearson@lenovo.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [RFC] Documentation: Add documentation for new performance_profile sysfs class
Date:   Wed, 14 Oct 2020 19:44:35 +0200
Message-ID: <1834022.taCxCBeP46@pce>
In-Reply-To: <CAJZ5v0gbQ=4bp22p3oM22zY+_1h-asYja1+CBbvtySzAY1p_+Q@mail.gmail.com>
References: <20201003131938.9426-1-hdegoede@redhat.com> <fec6eaeb-cc40-a2d2-87cb-bcae338bbe80@redhat.com> <CAJZ5v0gbQ=4bp22p3oM22zY+_1h-asYja1+CBbvtySzAY1p_+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

In data mercoled=EC 14 ottobre 2020 17:46:43 CEST, Rafael J. Wysocki ha scr=
itto:
> On Wed, Oct 14, 2020 at 4:16 PM Hans de Goede <hdegoede@redhat.com> wrote:
> > Hi,
> >=20
> > On 10/14/20 3:55 PM, Rafael J. Wysocki wrote:
> > > On Tue, Oct 13, 2020 at 3:09 PM Hans de Goede <hdegoede@redhat.com>=20
wrote:
> > >> Hi,
> > >>=20
> > >> On 10/12/20 6:42 PM, Rafael J. Wysocki wrote:
> > >>> On Wed, Oct 7, 2020 at 8:41 PM Limonciello, Mario
> > >>>=20
> > >>> <Mario.Limonciello@dell.com> wrote:
> > >>>>> On Wed, 2020-10-07 at 15:58 +0000, Limonciello, Mario wrote:
> > >>>>>>> On Mon, 2020-10-05 at 12:58 +0000, Limonciello, Mario wrote:
> > >>>>>>>>> On modern systems CPU/GPU/... performance is often dynamically
> > >>>>>>>>> configurable
> > >>>>>>>>> in the form of e.g. variable clock-speeds and TPD. The
> > >>>>>>>>> performance
> > >>>>>>>>> is often
> > >>>>>>>>> automatically adjusted to the load by some automatic-mechanism
> > >>>>>>>>> (which may
> > >>>>>>>>> very well live outside the kernel).
> > >>>>>>>>>=20
> > >>>>>>>>> These auto performance-adjustment mechanisms often can be
> > >>>>>>>>> configured with
> > >>>>>>>>> one of several performance-profiles, with either a bias towar=
ds
> > >>>>>>>>> low-power
> > >>>>>>>>> consumption (and cool and quiet) or towards performance (and
> > >>>>>>>>> higher
> > >>>>>>>>> power
> > >>>>>>>>> consumption and thermals).
> > >>>>>>>>>=20
> > >>>>>>>>> Introduce a new performance_profile class/sysfs API which
> > >>>>>>>>> offers a
> > >>>>>>>>> generic
> > >>>>>>>>> API for selecting the performance-profile of these automatic-
> > >>>>>>>>> mechanisms.
> > >>>>>>>>=20
> > >>>>>>>> If introducing an API for this - let me ask the question, why
> > >>>>>>>> even let each
> > >>>>>>>> driver offer a class interface and userspace need to change
> > >>>>>>>> "each" driver's
> > >>>>>>>> performance setting?
> > >>>>>>>>=20
> > >>>>>>>> I would think that you could just offer something kernel-wide
> > >>>>>>>> like
> > >>>>>>>> /sys/power/performance-profile
> > >>>>>>>>=20
> > >>>>>>>> Userspace can read and write to a single file.  All drivers can
> > >>>>>>>> get notified
> > >>>>>>>> on this sysfs file changing.
> > >>>>>>>>=20
> > >>>>>>>> The systems that react in firmware (such as the two that promp=
ted
> > >>>>>>>> this discussion) can change at that time.  It leaves the
> > >>>>>>>> possibility for a
> > >>>>>>>> more open kernel implementation that can do the same thing tho=
ugh
> > >>>>>>>> too by
> > >>>>>>>> directly modifying device registers instead of ACPI devices.
> > >>>>>>>=20
> > >>>>>>> The problem, as I've mentioned in previous discussions we had
> > >>>>>>> about
> > >>>>>>> this, is that, as you've seen in replies to this mail, this wou=
ld
> > >>>>>>> suddenly be making the kernel apply policy.
> > >>>>>>>=20
> > >>>>>>> There's going to be pushback as soon as policy is enacted in the
> > >>>>>>> kernel, and you take away the different knobs for individual
> > >>>>>>> components
> > >>>>>>> (or you can control them centrally as well as individually). As
> > >>>>>>> much as
> > >>>>>>> I hate the quantity of knobs[1], I don't think that trying to
> > >>>>>>> reduce
> > >>>>>>> the number of knobs in the kernel is a good use of our time, and
> > >>>>>>> easier
> > >>>>>>> to enact, coordinated with design targets, in user-space.
> > >>>>>>>=20
> > >>>>>>> Unless you can think of a way to implement this kernel wide
> > >>>>>>> setting
> > >>>>>>> without adding one more exponent on the number of possibilities
> > >>>>>>> for
> > >>>>>>> the
> > >>>>>>> testing matrix, I'll +1 Hans' original API.
> > >>>>>>=20
> > >>>>>> Actually I offered two proposals in my reply.  So are you NAKing
> > >>>>>> both?
> > >>>>>=20
> > >>>>> No, this is only about the first portion of the email, which I
> > >>>>> quoted.
> > >>>>> And I'm not NAK'ing it, but I don't see how it can work without
> > >>>>> being
> > >>>>> antithetical to what kernel "users" expect, or what the folks
> > >>>>> consuming
> > >>>>> those interfaces (presumably us both) would expect to be able to
> > >>>>> test
> > >>>>> and maintain.
> > >>>>=20
> > >>>> (Just so others are aware, Bastien and I had a previous discussion=
 on
> > >>>> this topic that he alluded to here:
> > >>>> https://gitlab.freedesktop.org/hadess/power-profiles-daemon/-/issu=
es
> > >>>> /1)
> > >>>>=20
> > >>>> In general I agree that we shouldn't be offering 100's of knobs to
> > >>>> change
> > >>>> things and protect users from themselves where possible.
> > >>>>=20
> > >>>> Whether the decisions are made in the kernel or in userspace you
> > >>>> still have a matrix once you're letting someone change 2 different
> > >>>> kernel devices that offer policy.  I'd argue it's actually worse if
> > >>>> you let userspace change it though.
> > >>>>=20
> > >>>> Let's go back to the my GPU and platform example and lets say both
> > >>>> offer the new knob here for both.  Userspace software such as your
> > >>>> PPD picks performance.  Both the platform device and GPU device get
> > >>>> changed, hopefully no conflicts.
> > >>>> Then user decides no, I don't want my GPU in performance mode, I o=
nly
> > >>>> want my platform. So they change the knob for the GPU manually, and
> > >>>> now you have a new config in your matrix.
> > >>>>=20
> > >>>> However if you left it to a single kernel knob, both GPU and platf=
orm
> > >>>> get moved together and you don't have these extra configs in your
> > >>>> matrix anymore.
> > >>>>=20
> > >>>> The other point I mentioned, that platform might also do something=
 to
> > >>>> GPU via a sideband and you race, you can solve it with kernel too =
by
> > >>>> modifying the ordering the kernel handles it.
> > >>>>=20
> > >>>> Userspace however, you give two knobs and now you have to worry ab=
out
> > >>>> them getting it right and supporting them doing them in the wrong
> > >>>> order.
> > >>>>=20
> > >>>>>> The other one suggested to use the same firmware attributes class
> > >>>>>> being
> > >>>>>> introduced by the new Dell driver (
> > >>>>>> https://patchwork.kernel.org/patch/11818343/)
> > >>>>>> since this is actually a knob to a specific firmware setting.
> > >>>>>=20
> > >>>>> This seemed to me like an implementation detail (eg. the same
> > >>>>> metadata
> > >>>>> is being exported, but in a different way), and I don't feel
> > >>>>> strongly
> > >>>>> about it either way.
> > >>>>=20
> > >>>> OK thanks.
> > >>>=20
> > >>> IMV there are two choices here:  One is between exposing the low-le=
vel
> > >>> interfaces verbatim to user space and wrapping them up into a certa=
in
> > >>> "translation" layer allowing user space to use a unified interface =
(I
> > >>> think that is what everybody wants) and the other  boils down to how
> > >>> the unified interface between the kernel and user space will look
> > >>> like.
> > >>>=20
> > >>> Personally, I think that something line /sys/power/profile allowing
> > >>> drivers (and other kernel entities) to register callbacks might work
> > >>> (as stated in my last reply to Hans).
> > >>=20
> > >> Note to others reading along I pointed to this thread in this thread:
> > >> https://lore.kernel.org/linux-pm/20201006122024.14539-1-daniel.lezca=
no@
> > >> linaro.org/T/#t and Rafael's "last reply" above refers to his reply =
in
> > >> that thread.
> > >>=20
> > >> For the sake of people reading along I'm reproducing my reply
> > >> there below.
> > >=20
> > > For completeness, my response in the other thread is here:
> > >=20
> > > https://lore.kernel.org/linux-pm/CAJZ5v0jpYpu3Tk7qq_MCVs0wUr-Dw0rY5EZ=
ELr
> > > VbQta0NZaoVA@mail.gmail.com/T/#t> >=20
> > >> Rafael, it seems more appropriate to continue this discussion
> > >> in this thread, so lets discuss this further here ?
> > >=20
> > > And because I sent it before reading this message, let me reproduce it
> > > below (with some additions).
> >=20
> > And I just did the same thing (replied to your reply in the other threa=
d),
> > I guess I was too quick.
>=20
> Well, same here.
>=20
> > So I too will reproduce my reply here.
>=20
> And so I'm doing below.
>=20
> > And I still believe it is best to then stick to this thread from now on,
> > because this reproducing thing is not really productive...
> >=20
> > >> My reply to Rafael from the other thread:
> > >>=20
> > >> First of all thank you for your input, with your expertise in this
> > >> area your input is very much appreciated, after all we only get
> > >> one chance to get the userspace API for this right.
> > >>=20
> > >> Your proposal to have a single sysfs file for userspace to talk
> > >> to and then use an in kernel subscription mechanism for drivers
> > >> to get notified of writes to this file is interesting.
> > >>=20
> > >> But I see 2 issues with it:
> > >>=20
> > >> 1. How will userspace know which profiles are actually available ?
> > >>=20
> > >> An obvious solution is to pick a set of standard names and let
> > >> subscribers map those as close to their own settings as possible,
> > >> the most often mentioned set of profile names in this case seems to =
be:
> > >>=20
> > >> low_power
> > >> balanced_power
> > >> balanced
> > >> balanced_performance
> > >> performance
> > >>=20
> > >> Which works fine for the thinkpad_acpi case, but not so much for
> > >> the hp-wmi case. In the HP case what happens is that a WMI call
> > >> is made which sets a bunch of ACPI variables which influence
> > >> the DPTF code (this assumes we have some sort of DPTF support
> > >> such as mjg59's reverse engineered support) but the profile-names
> > >> under Windows are: "Performance", "HP recommended", "Cool" and
> > >> "Quiet".  If you read the discussion from the
> > >> "[RFC] Documentation: Add documentation for new performance_profile
> > >> sysfs class" thread you will see this was brought up as an issue
> > >> there.
> > >=20
> > > Two different things seem to be conflated here.  One is how to pass a
> > > possible performance-vs-power preference coming from user space down
> > > to device drivers or generally pieces of kernel code that can adjust
> > > the behavior and/or hardware settings depending on what that
> > > preference is and the other is how to expose OEM-provided DPTF system
> > > profile interfaces to user space.
> >=20
> > I was hoping / thinking that we could use a single API for both of
> > these. But I guess that it makes sense to see them as 2 separate
> > things, esp. since DPTF profiles seem to be somewhat free-form
> > where as a way to pass a performance-pref to a device could use
> > a fixes set of values.
> >=20
> > So lets say that we indeed want to treat these 2 separately,
> > then I guess that the issue at hand / my reason to start a
> > discussion surrounding this is allowing userspace to selecting
> > the DPTF system profile.
> >=20
> > The thinkpad_acpi case at hand is not using DPTF, but that is
> > because Lenovo decided to implement dynamic DPTF like behavior
> > inside their embedded controller (for when running Linux) since
> > DPTF is atm not really supported all that well under Linux and
> > Lenovo was getting a lot of complaints about sub-optimal
> > performance because of this.
> >=20
> > So the thinkpad_acpi solution is in essence a replacement
> > for DPTF and it should thus use the same userspace API as
> > other mechanisms to select DPTF system profiles.
> >=20
> > And if we limit this new userspace API solely to setting DPTF
> > system profiles, then their will indeed be only 1 provider for
> > this for the entire system.
> >=20
> > > The former assumes that there is a common set of values that can be
> > > understood and acted on in a consistent way by all of the interested
> > > entities within the kernel and the latter is about passing information
> > > from user space down to a side-band power control mechanism working in
> > > its own way behind the kernel's back (and possibly poking at multiple
> > > hardware components in the platform in its own way).
> >=20
> > Ack.
> >=20
> > > IMO there is no way to provide a common interface covering these two
> > > cases at the same time.
> >=20
> > I see your point, esp. the free form vs common set of values
> > argument seems to be exactly what we have been going in circles
> > about during the discussion about this so far.
> >=20
> > >> The problem here is that both "cool" and "quiet" could be
> > >> interpreted as low-power. But it seems that they actually mean
> > >> what they say, cool focuses on keeping temps low, which can
> > >> also be done by making the fan-profile more aggressive. And quiet
> > >> is mostly about keeping fan speeds down, at the cost of possible
> > >> higher temperatures.
> > >>=20
> > >> <edit in this version of the reply:>
> > >> I wonder if the HP profiles are actually just fan speed profiles ?
> > >> Elia do you know ?
> > >> </edit>
> > >=20
> > > I don't think so.
> > >=20
> > > AFAICS, in both the Thinkpad and HP cases the profile covers the
> > > entire platform, which in particular means that they cannot co-exist.
> >=20
> > Ok.
> >=20

As far as I know, the profiles affect  the thermal behavior like "how long =
to=20
wait before starting the fan and at what temperature" or "how fast to run t=
he=20
fan with the current cpu load and temperature".

The only way that firmware uses to "control" performance should be the odvp=
0=20
DPTF variable.

On Windows HP expose  both "Cool" and "Quiet" profile respectively as "Idea=
l=20
for when the computer feels warm to the touch" and "Ideal for quiet=20
environments".

more detail: https://support.hp.com/in-en/document/c06063108

To be precise "Quiet" profile should be available only on platform without=
=20
dedicate GPU (I'm investigating if there is other case), instead the other =
3=20
profiles ("HP Recommended", "Performance" and "Cool") are available on all=
=20
platform that support thermal profile.

reading here seems that Dell offer identical profiles:
https://www.dell.com/support/manuals/it/it/itbsdt1/dell-command-power-manag=
er-v2.2/userguide_dell/thermal-management?guid=3Dguid-c05d2582-fc07-4e3e-91=
8a-965836d20752&lang=3Den-us=20

Regards,

Elia


