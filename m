Return-Path: <linux-acpi+bounces-12628-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B060CA7846A
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Apr 2025 00:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2B94188E809
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 22:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D6D1EF38D;
	Tue,  1 Apr 2025 22:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="t7lSHQeD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE944207F
	for <linux-acpi@vger.kernel.org>; Tue,  1 Apr 2025 22:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743545235; cv=none; b=sk/ZQ/463CGVSGKFFuplOncY89JF6MUBK5gcRYRcQO/c7+9wTRBB9Gj4q8aE4muFrPfo9ewXFM03H4YZPeq2d/5BIKQm7Hza6sBNok3e2+elhgkFtVmvtheGjt7icT7QnQXOPqPWy6ShyqYQQVCOl2XMx3vuPTVLKOShxbUMGTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743545235; c=relaxed/simple;
	bh=ERJtpUJ873yY69jfWdwUxKjKlc3BOnIi5cABaGmyHF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HsYVCbDGfPydlvJbCRgJcZCFKsrmxQY32UJGhKC7R4Ojdem23MBh8X18bcKY/K5Fm88JxfExsUwgvqIsZRSn89Y85OOX39l9NE70UIl7GUlqC40T8xL3otv4EorPNEnIMMCtcmDps3a+Ynmi52gveE31LezwF1obuEpilYOgzLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=t7lSHQeD; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 35A802E099BA
	for <linux-acpi@vger.kernel.org>; Wed,  2 Apr 2025 01:07:01 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1743545222;
	bh=XXmYRYQIBhZ1XpD+IkY8nP6xhZRwY3o1dTShg1bEVeU=;
	h=Received:From:Subject:To;
	b=t7lSHQeDzqSWOFjyX/P44YuwtgvFoEJHpVpmHD4G0fjdd/ZLtCMsMRy5a4IGRXBR4
	 3HUzmOq3e6OLBC97MxThL4yBNlWKWuvGYkB127+DzqoH9zrf+MJs54x76/ruCDorLm
	 HAhZ/t61XBmkrnR5RNXGjo8GK9s8tudDPGGgMnIE=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.180) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f180.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f180.google.com with SMTP id
 38308e7fff4ca-30dd5a93b49so40930651fa.0
        for <linux-acpi@vger.kernel.org>;
 Tue, 01 Apr 2025 15:07:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVNVkCub6dsgq46UmXJGEKFoOFLhtquqfnSTjaZ1CFd+JvbgH3kZy6pBYm5FBdY/wUk0EJCy4mV/8vD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw++UqI7oVuf+EFftTCB+Scf4cgqp1lwpXax94nt1QpSsNmyYUb
	WuAQRy+bhOMtX868dctpD3YhkVcWyi2EOTL/7uKup5Hfpa2gtfTbuSXRd3+OQWhXf5ANCW0xZAS
	XMFoh9M/AmbFYKJ41QoRYggx1cCw=
X-Google-Smtp-Source: 
 AGHT+IHZ9dnxsXYQl2sNMK8J7SVHGoWX1WHRs5Z9OBOCR6XP2ugobNKHHgFIyEy6gyU1vwtUKfocD6DnmVS+7eZ5SbI=
X-Received: by 2002:a2e:ad90:0:b0:30b:cd68:b68d with SMTP id
 38308e7fff4ca-30de024acbamr54522251fa.10.1743545220425; Tue, 01 Apr 2025
 15:07:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331204442.1727618-1-superm1@kernel.org>
 <CAGwozwHyRiyVkX8rsc69gkALScWdtXNAvAGn7c2aEXW_qgdWsA@mail.gmail.com>
 <CAGwozwEiCXFDi73qAPSm2K9A8OZutE7dbjFfCmbUSAOTaz8SEA@mail.gmail.com>
 <50cc3227-93eb-4cb8-8151-23e52ca91f80@kernel.org>
 <CAGwozwH7r-7uELUB1fiftAf3ziU6irgW92qiHHNOpuJ-87=WJw@mail.gmail.com>
 <90d704dc-51ea-4c98-ba4a-f95460f65061@kernel.org>
 <CAGwozwEoCc_nRodt2=6R5K5UOzhW+5Gx1uLS3H3ON4ZS_12gBg@mail.gmail.com>
 <1eb121e5-c0d3-49a8-9579-6ea5543ad4f9@kernel.org>
 <CAGwozwFgRO=6a=NNfbTtz1E5sroH27sxyXJQuV9QbTMfAttO6w@mail.gmail.com>
 <6a9268de-4072-4ef2-9f33-95cc783a8595@kernel.org>
 <CAGwozwF6iFkgvS54KYGMg554S9DTD83rq2ctH=UtFO-b8c1H1Q@mail.gmail.com>
 <dc2ae336-6a26-4e3e-a901-15afbe7fc611@kernel.org>
 <CAGwozwF=ZfJ31_UBXV==x_0og+yzf2nLnrb4xG9ca027y-S_Sg@mail.gmail.com>
 <8cdc5a58-2221-4332-9a47-e0f5b7832922@kernel.org>
In-Reply-To: <8cdc5a58-2221-4332-9a47-e0f5b7832922@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Wed, 2 Apr 2025 00:06:49 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwFoM+Wtd85Yx6_XxTv2e+qMY6wMRJSd2V+LsVn-GZUruA@mail.gmail.com>
X-Gm-Features: AQ5f1Joz1mwKPbNg_5NTEU796UOTENruql0krOWhjABiErcubMcAyBcvTdXRKgI
Message-ID: 
 <CAGwozwFoM+Wtd85Yx6_XxTv2e+qMY6wMRJSd2V+LsVn-GZUruA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: EC: Set ec_no_wakeup for Lenovo Go S
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, rafael@kernel.org,
	Xino JS1 Ni <nijs1@lenovo.com>, linux-acpi@vger.kernel.org,
	"derekjohn.clark@gmail.com" <derekjohn.clark@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <174354522176.19332.10003645816218780494@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Tue, 1 Apr 2025 at 22:54, Mario Limonciello <superm1@kernel.org> wrote:
>
> On 4/1/2025 1:39 PM, Antheas Kapenekakis wrote:
> > On Tue, 1 Apr 2025 at 17:24, Mario Limonciello <superm1@kernel.org> wro=
te:
> >>
> >> On 4/1/2025 10:03 AM, Antheas Kapenekakis wrote:
> >>> On Tue, 1 Apr 2025 at 16:09, Mario Limonciello <superm1@kernel.org> w=
rote:
> >>>>
> >>>> On 4/1/2025 7:45 AM, Antheas Kapenekakis wrote:
> >>>>> On Tue, 1 Apr 2025 at 14:30, Mario Limonciello <superm1@kernel.org>=
 wrote:
> >>>>>>
> >>>>>>>> Here are tags for linking to your patch development to be picked=
 up.
> >>>>>>>>
> >>>>>>>> Link:
> >>>>>>>> https://github.com/bazzite-org/patchwork/commit/95b93b2852718ee1=
e808c72e6b1836da4a95fc63
> >>>>>>>> Co-developed-by: Antheas Kapenekakis <lkml@antheas.dev>
> >>>>>>>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> >>>>>>>
> >>>>>>
> >>>>>> I don't believe that b4 will pick these up, so I will send out a v=
2 with
> >>>>>> them and mark this patch as superceded in patchwork so that Rafael
> >>>>>> doesn't have to pull everything out of this thread manually.
> >>>>
> >>>> FTR I don't have permission on patchwork for linux-acpi.
> >>>>
> >>>> I sent out v2 though.
> >>>>
> >>>>>>
> >>>>>>>
> >>>>>>> And to avoid having this conversation again, there is another Leg=
ion
> >>>>>>> Go S [3] patch you nacked and froze the testing for, so you could=
 go
> >>>>>>> on the manhunt for the real cause of this one. But it will probab=
ly be
> >>>>>>> needed and you will find that as you get TDP controls going. So i=
f you
> >>>>>>> want me to prepare that in a timely manner, because that one actu=
ally
> >>>>>>> needs rewriting to be posted, now is the time to say so.
> >>>>>>
> >>>>>> Can you please propose what you have in mind on the mailing lists =
to
> >>>>>> discuss?  It's relatively expensive (in the unit of tech debt) to =
add
> >>>>>> quirk infrastructure and so we need to make sure it is the right s=
olution.
> >>>>>>
> >>>>>> Derek is working on CPU coefficient tuning in a completely separat=
e
> >>>>>> driver.  If there are issues with that, I would generally prefer t=
he
> >>>>>> fixes to be in that driver.
> >>>>>
> >>>>> CPU coefficient tuning? If you mean the lenovo-wmi-driver, yes I wi=
ll
> >>>>> try to make sure the quirk can be potentially added there, or in an=
y
> >>>>> driver*.
> >>>>
> >>>> Yes things like fPPT, sPPT, STAPM, STT limits.
> >>>>
> >>>>>
> >>>>> The idea is to rewrite the patch series to just add a simple delay
> >>>>> field on the s2idle quirk struct. Then the biggest delay wins and g=
ets
> >>>>> placed in ->begin. We have been using that series for ~6 months now=
,
> >>>>> and it turns out that having a delay system for every call is quite
> >>>>> pointless. But there are also situations where you might have a dev=
ice
> >>>>> such as the Z13 Folio which looks like a USB device but listens to
> >>>>> s2idle notifications through ACPI, so the hid subsystem might need =
to
> >>>>> be able to inject a small delay there.
> >>>>
> >>>> So the "general" problem with injecting delays is they are typically=
 not
> >>>> scalable as they're usually empirically measured and there is no
> >>>> handshake with the firmware.
> >>>>
> >>>> Say for example the EC has some hardcoded value of 200ms to wait for
> >>>> something.  IIRC the Linux timer infrastructure can be off by ~13%. =
 So
> >>>> if you put 175ms it might work sometimes.  You get some reports of t=
his,
> >>>> so you extend it to 200ms.  Great it works 100% of the time because =
the
> >>>> old hardcoded value in the EC was 200ms.
> >>>>
> >>>> Now say a new EC firmware comes out that for $REASONS changes it to
> >>>> 250ms.  Your old empirically measured value stops working, spend a b=
unch
> >>>> of cycles debugging it, measure the new one.  You change it to 250ms=
,
> >>>> but people with the old one have a problem now because the timing ch=
anged.
> >>>>
> >>>> So now you have to add infrastructure to say what version of the
> >>>> firmware gets what delay.
> >>>>
> >>>> Then you find out there is another SKU of that model which needs a
> >>>> different delay, so your complexity has ballooned.
> >>>>
> >>>> What if all these "delays" were FW timeouts from failing to service =
an
> >>>> interrupt?  Or what if they were a flow problem like the device expe=
cted
> >>>> you to issue a STOP command before a RESET command?
> >>>>
> >>>> So we need to be /incredibly careful/ with delays and 100% they are =
the
> >>>> right answer to a problem.
> >>>
> >>> I do get your points. In this case though we sideskirt through a lot
> >>> of the points because of where the delay is placed.
> >>>
> >>> If the instrumentation is in-place, this delay happens before sleep
> >>> after the screen of the device has turned off (due to early DPMS), th=
e
> >>> keyboard backlight has turned off (DIsplay off call), and the suspend
> >>> light pulses (Sleep Entry). So it does not affect device behavior and
> >>> you can be quite liberal. The user has left the device alone.
> >>>
> >>> If the device needs e.g., 250ms you will not put 250ms, you will put
> >>> 500ms. Still unsure, you bump it to 750ms. Also, even if the
> >>> manufacturer comes up with a new firmware that fixes this issue, you
> >>> can keep the delay for the life of the product, because keeping it
> >>> does not affect device behavior, and writing kernel patches takes tim=
e.
> >>>
> >>> This is how I think about it, at least. A universal delay might be
> >>> needed eventually. But for now, limiting the scope to some devices an=
d
> >>> seeing how that goes should be enough.
> >>>
> >>> Antheas
> >>
> >> My take is that "universal" delays are never popular.  IE hardware tha=
t
> >> "previously" worked perfectly is now slower.  So if there /must/ be a
> >> delay it should be as narrow as possible and justified.
> >>
> >> Let me give you an example of another case I'm *actively considering* =
a
> >> delay.
> >>
> >> I have an OEM's system that if you enter and exit s0i3 too quickly you
> >> can trigger the over voltage protection (OVP) feature of the VR module=
.
> >> When OVP is tripped the system is forced off immediately. This *only
> >> happens* on the VR module in that vendor's systems. "Normal" Linux
> >> userspace suspend/resume can't trip it.  But connecting a dock "does"
> >> trip it.
> >>
> >> If you look on a scope you can see SLP_S3# pin is toggling faster than
> >> spec says it should.  Na=C3=AFvely you would say well the easy solutio=
n is to
> >> add a delay somewhere so that SLP_S3# stays in spec.  I have a patch
> >> that does just that.
> >>
> >> diff --git a/drivers/platform/x86/amd/pmc/pmc.c
> >> b/drivers/platform/x86/amd/pmc/pmc.c
> >> index e6124498b195f..97387ddb281e1 100644
> >> --- a/drivers/platform/x86/amd/pmc/pmc.c
> >> +++ b/drivers/platform/x86/amd/pmc/pmc.c
> >> @@ -724,10 +724,20 @@ static void amd_pmc_s2idle_check(void)
> >>           struct smu_metrics table;
> >>           int rc;
> >>
> >> -       /* CZN: Ensure that future s0i3 entry attempts at least 10ms
> >> passed */
> >> -       if (pdev->cpu_id =3D=3D AMD_CPU_ID_CZN && !get_metrics_table(p=
dev,
> >> &table) &&
> >> -           table.s0i3_last_entry_status)
> >> -               usleep_range(10000, 20000);
> >> +       if (!get_metrics_table(pdev, &table) &&
> >> table.s0i3_last_entry_status) {
> >> +               switch (pdev->cpu_id) {
> >> +               /* CZN: Ensure that future s0i3 entry attempts at leas=
t
> >> 10ms passed */
> >> +               case AMD_CPU_ID_CZN:
> >> +                       usleep_range(10000, 20000);
> >> +                       break;
> >> +               /* PHX/HPT: Ensure enough time to avoid VR OVP */
> >> +               case AMD_CPU_ID_PS:
> >> +                       msleep(2500);
> >> +                       break;
> >> +               default:
> >> +                       break;
> >> +               }
> >> +       }
> >>
> >> This stops all the failures, but it also has an impact that any time t=
he
> >> EC SCI is raised for any reason (like plug in power adapter) the syste=
m
> >> will take 2.5s to go back into s0i3.
> >>
> >> Digging further - the intended behavior by the EC and BIOS was to wake
> >> the system when the dock is connected.
> >>
> >> That is the reason this happens is because the EC SCI is raised when t=
he
> >> dock is connected, but the Notify() the EC sent wasn't received by any
> >> driver.  I've got a patch I'll be sending out soon that adds support f=
or
> >> the correct driver to wake up on this event.
> >>
> >> This prevents the case of the OVP and now we don't *need* to penalize
> >> everyone to wait 2.5s after EC SCI events and going back to s0i3.  If =
I
> >> find out there are other ways to trip the problem I still have that
> >> option though.
> >
> > So you are talking about missing the AC/DC burst feature of Windows
> > here right? I do agree with you that yeah for most devices it is not
> > necessary.
>
> No; I wasn't talking about that, my point was that timing delays are a
> tempting to solution to a problem, but they're very often papering over
> something else and a hint to dive deeper.

What I gleaned from what you said is that X manufacturer has a problem
due to missing AC/DC bursts in linux, where all AC/DC burst is is a 5s
delay.

The intended behavior of AC/DC bursts is to fully wake up the kernel
for 5 seconds, and then sleep again. In windows, if a power supply is
connected, userspace wakes up too, and then the Windows power manager
sleeps the system again if there is no user activity for 5 seconds.
However, this should not affect device drivers, so we may consider it
optional on the Linux side until DEs get support for it and enable it
themselves I would say.

So in effect, AC/DC bursts are Windows' solution to problems like the
one you faced.

I am not saying penalize everyone. If I do make a patch for AC/DC it
will be device specific. But after a point, if random devices start
getting issues and the quirk list starts to grow, it might become
inevitable to force it for all of them.

I do get what you are saying with delays though. We had to merge one
of the initial SOF delay patch variants for the Steam Deck which
prevents audio crashing on resume, and that was definitely a bandage.

> >
> > But Microsoft guarantees 5 seconds. We already have the original Ally
> > unit which gets stuck in prochot due to this so it would be nice to
> > fix. For the Ally X I am unsure what Asus did but it stays awake for a
> > nice three seconds after you plug/unplug the charger so it has no
> > issues.
> >
> > So if devices keep getting issues like we will have to eat it and do
> > AC/DC bursts with all of them.
> >
> > And it is the same with entering s0i3 too fast. Some devices just need
> > a tiny amount of time to do whatever it is their manufacturer
> > programmed them to do after the Modern Standby notifications. For
> > handhelds, it is to turn off the controllers because XInput. Asus put
> > the fade animation so that takes 300ms and if you do it earlier the
> > controller gets cut before it saves its state and starts to do weird
> > RGB stuff. Other manufacturers typically do not malfunction but they
> > still use the notification.
> >
> > Only MSI does not, but that controller is quirky before/after sleep
> > and they released a firmware update today saying something about
> > controller S3/S4 improvements so they probably do that too now, I need
> > to check.
> >
> > For the Go S, it sets itself to 5W after sleep entry and turns off the
> > fan. A little delay went a long way in fixing the hang there, which I
> > suspect is due to aggressive tuning. But I do not know if you guys get
> > that. We did when we did the initial testing for it and carry the
> > delay now so I cannot tell you either way. So you should max out the
> > TDP, run stress -c 16, and make the device sleep 100-200 times to make
> > sure that is not an issue.
> >
> > I do have a plan for trying to rework AC/DC bursts, but first the
> > s2idle ordering needs to be fixed and I need to rewrite the series for
> > that. The series we have for that works _fine_ so it is not a priority
> > to rework but it is not upstreamable in its current state so if you
> > need that (for the Go S) I need to know now.
> >
> > For ACDC my idea would be after the reordering is done to have a quirk
> > that makes the kernel resume, fire the sleep exit notification, loop
> > for 5 (maybe 3?) seconds inside the device suspend section prior to
> > userspace resume, and then as long as a wakeup did not arrive restart
> > the suspend sequence to sleep again. I would also combine that with
> > the little s2idle wakeup device you made, so that userspace can enable
> > wakeups for that if it wants to do resume on dock connection. But that
> > has a lot of moving parts, including moving the DPMS action to happen
> > even earlier than your patch does and making sure display on/off does
> > not fire so that the keyboard backlight does not do weird stuff.
> >
> > Antheas
>
> I think a good start for what you're talking about would be to rebase
> your series that reworked s2idle flow on 6.15 code (maybe it's a clean
> rebase, idk) and then if/when all of us on LKML are happy with it we can
> layer other concepts on top of that.

Yeah, I will try to do that. However, I have around 30 submitted
patches in the air right now, and we are about to add another 5-6 to
the list for the Claw. So it will probably be after a bunch of those
merge. For the interest of sustainability, if nothing else. So let's
put a dot on this and pick up the discussion again mid 6.16 in a month
or so.

Unless you need this series for the Go S, in which case I can try to
re-order stuff around. So, one of you should use the red light TDP
mode with an artificial load (or actual, such as a game) and see if
sleep works properly. Do that on battery.

I would do at least 100 suspends with this, as most users do 50-70
suspends per reboot. I think I did around 300 to validate the Go S
quirk.

Antheas

