Return-Path: <linux-acpi+bounces-12616-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34868A7825B
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 20:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DDE31892EB8
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 18:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541BB1DB54C;
	Tue,  1 Apr 2025 18:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="EgW0X7hO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906F21494DB
	for <linux-acpi@vger.kernel.org>; Tue,  1 Apr 2025 18:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743532797; cv=none; b=ZGfIcPrnKkG6OgpJGd6j4C3QvhjzFdJ9DOte1kxwRvlXB2uXAbKD32mph0+QCd9wEziP+Iw7WQfBxgW3SL41UU7UysEV+RCo8JPNtU977afD5DIrsWju4qtW1RQj2d0fMA15uIji3HgM0vWxzHhL2CGJSvbsmh/m12tENL7bGS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743532797; c=relaxed/simple;
	bh=M2/TyoHE59+utPY+2QsJEEWds74HzRoP4frz/T5fMek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CcIwoM60eyE7XKHJFiVyw8Xj0LQlVJYEqrRJC6RyOo3cxLH+ssd0C2CQ1Zoiz7p+AfsznyX96IEDXFaGBU2ivk+UTxdrp04tzhlWbcEJB7DF7AZCYIutBrBq72LRuXfc1+aXK3ZznDmJZ3NOQJQK3FjyCwvIb0+9wEB/S3L8k5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=EgW0X7hO; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 2D6082E08EE6
	for <linux-acpi@vger.kernel.org>; Tue,  1 Apr 2025 21:39:50 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1743532790;
	bh=EKYyyTg5wWHPqVL+yQIJ25rXfFqWY8VXQ6i4SJJPY3I=;
	h=Received:From:Subject:To;
	b=EgW0X7hOO3W4JdtqCJxiJp3GynELwppNIApBP1ePGm99WYfJ22WNs8uoym7B/qtAv
	 HdwJ74Ph5NOB/yPQnonHVYRNL5uA2xmeVi2U0xbNeE+Iyeay1o3yjLAEXSRB5/WTeu
	 2dNp0FzVqin+S332ZlfrqNjsCMjSeOzuBZxEDP1c=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.182) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f182.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-30bf7d0c15eso60022941fa.0
        for <linux-acpi@vger.kernel.org>;
 Tue, 01 Apr 2025 11:39:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCViDSPs2iTylezi7QK4KzVcyIDi8ycQx9GGJm4O/j8cAXI3pA6J1kZkAEdQA1XP1t4U73+k01l47FZS@vger.kernel.org
X-Gm-Message-State: AOJu0YwqNJpo/atXYK739vnLhorJ44s5tJyuxWwVs6GcgvwVa+HvEgG2
	dYzxdazSjQFJ+69XLHaGrYCAaLEg5iQxF/bbhPe6kDtnSV2s6cvh1neejbA2etUyYOvbUu8Hj6+
	wFdlhSAecq1BCAXkxPttR/UkIdmQ=
X-Google-Smtp-Source: 
 AGHT+IGR6rG5BZ3smV0I6nkwqAzx4mhgDMliSTI6IQ3QwuIK49TcnSKXI8C2UW87396aUDQ4Orhhobl+qZGtcmEHNN0=
X-Received: by 2002:a2e:9a0a:0:b0:30c:c7a:dcc with SMTP id
 38308e7fff4ca-30de0278444mr44208371fa.20.1743532789330;
 Tue, 01 Apr 2025 11:39:49 -0700 (PDT)
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
In-Reply-To: <dc2ae336-6a26-4e3e-a901-15afbe7fc611@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 1 Apr 2025 20:39:36 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwF=ZfJ31_UBXV==x_0og+yzf2nLnrb4xG9ca027y-S_Sg@mail.gmail.com>
X-Gm-Features: AQ5f1JqbSh38mCH39yjzOcebIYY5e-KBfvh9BD-XzlZqu5boCL_buWtqP8HHg-Q
Message-ID: 
 <CAGwozwF=ZfJ31_UBXV==x_0og+yzf2nLnrb4xG9ca027y-S_Sg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: EC: Set ec_no_wakeup for Lenovo Go S
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, rafael@kernel.org,
	Xino JS1 Ni <nijs1@lenovo.com>, linux-acpi@vger.kernel.org,
	"derekjohn.clark@gmail.com" <derekjohn.clark@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <174353279056.7286.13492431771493396299@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Tue, 1 Apr 2025 at 17:24, Mario Limonciello <superm1@kernel.org> wrote:
>
> On 4/1/2025 10:03 AM, Antheas Kapenekakis wrote:
> > On Tue, 1 Apr 2025 at 16:09, Mario Limonciello <superm1@kernel.org> wro=
te:
> >>
> >> On 4/1/2025 7:45 AM, Antheas Kapenekakis wrote:
> >>> On Tue, 1 Apr 2025 at 14:30, Mario Limonciello <superm1@kernel.org> w=
rote:
> >>>>
> >>>>>> Here are tags for linking to your patch development to be picked u=
p.
> >>>>>>
> >>>>>> Link:
> >>>>>> https://github.com/bazzite-org/patchwork/commit/95b93b2852718ee1e8=
08c72e6b1836da4a95fc63
> >>>>>> Co-developed-by: Antheas Kapenekakis <lkml@antheas.dev>
> >>>>>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> >>>>>
> >>>>
> >>>> I don't believe that b4 will pick these up, so I will send out a v2 =
with
> >>>> them and mark this patch as superceded in patchwork so that Rafael
> >>>> doesn't have to pull everything out of this thread manually.
> >>
> >> FTR I don't have permission on patchwork for linux-acpi.
> >>
> >> I sent out v2 though.
> >>
> >>>>
> >>>>>
> >>>>> And to avoid having this conversation again, there is another Legio=
n
> >>>>> Go S [3] patch you nacked and froze the testing for, so you could g=
o
> >>>>> on the manhunt for the real cause of this one. But it will probably=
 be
> >>>>> needed and you will find that as you get TDP controls going. So if =
you
> >>>>> want me to prepare that in a timely manner, because that one actual=
ly
> >>>>> needs rewriting to be posted, now is the time to say so.
> >>>>
> >>>> Can you please propose what you have in mind on the mailing lists to
> >>>> discuss?  It's relatively expensive (in the unit of tech debt) to ad=
d
> >>>> quirk infrastructure and so we need to make sure it is the right sol=
ution.
> >>>>
> >>>> Derek is working on CPU coefficient tuning in a completely separate
> >>>> driver.  If there are issues with that, I would generally prefer the
> >>>> fixes to be in that driver.
> >>>
> >>> CPU coefficient tuning? If you mean the lenovo-wmi-driver, yes I will
> >>> try to make sure the quirk can be potentially added there, or in any
> >>> driver*.
> >>
> >> Yes things like fPPT, sPPT, STAPM, STT limits.
> >>
> >>>
> >>> The idea is to rewrite the patch series to just add a simple delay
> >>> field on the s2idle quirk struct. Then the biggest delay wins and get=
s
> >>> placed in ->begin. We have been using that series for ~6 months now,
> >>> and it turns out that having a delay system for every call is quite
> >>> pointless. But there are also situations where you might have a devic=
e
> >>> such as the Z13 Folio which looks like a USB device but listens to
> >>> s2idle notifications through ACPI, so the hid subsystem might need to
> >>> be able to inject a small delay there.
> >>
> >> So the "general" problem with injecting delays is they are typically n=
ot
> >> scalable as they're usually empirically measured and there is no
> >> handshake with the firmware.
> >>
> >> Say for example the EC has some hardcoded value of 200ms to wait for
> >> something.  IIRC the Linux timer infrastructure can be off by ~13%.  S=
o
> >> if you put 175ms it might work sometimes.  You get some reports of thi=
s,
> >> so you extend it to 200ms.  Great it works 100% of the time because th=
e
> >> old hardcoded value in the EC was 200ms.
> >>
> >> Now say a new EC firmware comes out that for $REASONS changes it to
> >> 250ms.  Your old empirically measured value stops working, spend a bun=
ch
> >> of cycles debugging it, measure the new one.  You change it to 250ms,
> >> but people with the old one have a problem now because the timing chan=
ged.
> >>
> >> So now you have to add infrastructure to say what version of the
> >> firmware gets what delay.
> >>
> >> Then you find out there is another SKU of that model which needs a
> >> different delay, so your complexity has ballooned.
> >>
> >> What if all these "delays" were FW timeouts from failing to service an
> >> interrupt?  Or what if they were a flow problem like the device expect=
ed
> >> you to issue a STOP command before a RESET command?
> >>
> >> So we need to be /incredibly careful/ with delays and 100% they are th=
e
> >> right answer to a problem.
> >
> > I do get your points. In this case though we sideskirt through a lot
> > of the points because of where the delay is placed.
> >
> > If the instrumentation is in-place, this delay happens before sleep
> > after the screen of the device has turned off (due to early DPMS), the
> > keyboard backlight has turned off (DIsplay off call), and the suspend
> > light pulses (Sleep Entry). So it does not affect device behavior and
> > you can be quite liberal. The user has left the device alone.
> >
> > If the device needs e.g., 250ms you will not put 250ms, you will put
> > 500ms. Still unsure, you bump it to 750ms. Also, even if the
> > manufacturer comes up with a new firmware that fixes this issue, you
> > can keep the delay for the life of the product, because keeping it
> > does not affect device behavior, and writing kernel patches takes time.
> >
> > This is how I think about it, at least. A universal delay might be
> > needed eventually. But for now, limiting the scope to some devices and
> > seeing how that goes should be enough.
> >
> > Antheas
>
> My take is that "universal" delays are never popular.  IE hardware that
> "previously" worked perfectly is now slower.  So if there /must/ be a
> delay it should be as narrow as possible and justified.
>
> Let me give you an example of another case I'm *actively considering* a
> delay.
>
> I have an OEM's system that if you enter and exit s0i3 too quickly you
> can trigger the over voltage protection (OVP) feature of the VR module.
> When OVP is tripped the system is forced off immediately. This *only
> happens* on the VR module in that vendor's systems. "Normal" Linux
> userspace suspend/resume can't trip it.  But connecting a dock "does"
> trip it.
>
> If you look on a scope you can see SLP_S3# pin is toggling faster than
> spec says it should.  Na=C3=AFvely you would say well the easy solution i=
s to
> add a delay somewhere so that SLP_S3# stays in spec.  I have a patch
> that does just that.
>
> diff --git a/drivers/platform/x86/amd/pmc/pmc.c
> b/drivers/platform/x86/amd/pmc/pmc.c
> index e6124498b195f..97387ddb281e1 100644
> --- a/drivers/platform/x86/amd/pmc/pmc.c
> +++ b/drivers/platform/x86/amd/pmc/pmc.c
> @@ -724,10 +724,20 @@ static void amd_pmc_s2idle_check(void)
>          struct smu_metrics table;
>          int rc;
>
> -       /* CZN: Ensure that future s0i3 entry attempts at least 10ms
> passed */
> -       if (pdev->cpu_id =3D=3D AMD_CPU_ID_CZN && !get_metrics_table(pdev=
,
> &table) &&
> -           table.s0i3_last_entry_status)
> -               usleep_range(10000, 20000);
> +       if (!get_metrics_table(pdev, &table) &&
> table.s0i3_last_entry_status) {
> +               switch (pdev->cpu_id) {
> +               /* CZN: Ensure that future s0i3 entry attempts at least
> 10ms passed */
> +               case AMD_CPU_ID_CZN:
> +                       usleep_range(10000, 20000);
> +                       break;
> +               /* PHX/HPT: Ensure enough time to avoid VR OVP */
> +               case AMD_CPU_ID_PS:
> +                       msleep(2500);
> +                       break;
> +               default:
> +                       break;
> +               }
> +       }
>
> This stops all the failures, but it also has an impact that any time the
> EC SCI is raised for any reason (like plug in power adapter) the system
> will take 2.5s to go back into s0i3.
>
> Digging further - the intended behavior by the EC and BIOS was to wake
> the system when the dock is connected.
>
> That is the reason this happens is because the EC SCI is raised when the
> dock is connected, but the Notify() the EC sent wasn't received by any
> driver.  I've got a patch I'll be sending out soon that adds support for
> the correct driver to wake up on this event.
>
> This prevents the case of the OVP and now we don't *need* to penalize
> everyone to wait 2.5s after EC SCI events and going back to s0i3.  If I
> find out there are other ways to trip the problem I still have that
> option though.

So you are talking about missing the AC/DC burst feature of Windows
here right? I do agree with you that yeah for most devices it is not
necessary.

But Microsoft guarantees 5 seconds. We already have the original Ally
unit which gets stuck in prochot due to this so it would be nice to
fix. For the Ally X I am unsure what Asus did but it stays awake for a
nice three seconds after you plug/unplug the charger so it has no
issues.

So if devices keep getting issues like we will have to eat it and do
AC/DC bursts with all of them.

And it is the same with entering s0i3 too fast. Some devices just need
a tiny amount of time to do whatever it is their manufacturer
programmed them to do after the Modern Standby notifications. For
handhelds, it is to turn off the controllers because XInput. Asus put
the fade animation so that takes 300ms and if you do it earlier the
controller gets cut before it saves its state and starts to do weird
RGB stuff. Other manufacturers typically do not malfunction but they
still use the notification.

Only MSI does not, but that controller is quirky before/after sleep
and they released a firmware update today saying something about
controller S3/S4 improvements so they probably do that too now, I need
to check.

For the Go S, it sets itself to 5W after sleep entry and turns off the
fan. A little delay went a long way in fixing the hang there, which I
suspect is due to aggressive tuning. But I do not know if you guys get
that. We did when we did the initial testing for it and carry the
delay now so I cannot tell you either way. So you should max out the
TDP, run stress -c 16, and make the device sleep 100-200 times to make
sure that is not an issue.

I do have a plan for trying to rework AC/DC bursts, but first the
s2idle ordering needs to be fixed and I need to rewrite the series for
that. The series we have for that works _fine_ so it is not a priority
to rework but it is not upstreamable in its current state so if you
need that (for the Go S) I need to know now.

For ACDC my idea would be after the reordering is done to have a quirk
that makes the kernel resume, fire the sleep exit notification, loop
for 5 (maybe 3?) seconds inside the device suspend section prior to
userspace resume, and then as long as a wakeup did not arrive restart
the suspend sequence to sleep again. I would also combine that with
the little s2idle wakeup device you made, so that userspace can enable
wakeups for that if it wants to do resume on dock connection. But that
has a lot of moving parts, including moving the DPMS action to happen
even earlier than your patch does and making sure display on/off does
not fire so that the keyboard backlight does not do weird stuff.

Antheas

