Return-Path: <linux-acpi+bounces-14744-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE531AEA671
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 21:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34FB0562654
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 19:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1582EFDA5;
	Thu, 26 Jun 2025 19:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaAoUkSM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891972EFD9A;
	Thu, 26 Jun 2025 19:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750966139; cv=none; b=Y8z0UQ1V4m3kigOkjo1Ihg0h14n2oXbY0wXyIdHXZdjfHf1/VF31JyhPz45c6VHUq2zCa/u3SJccEUN9NOSEYUzZ3zaUQpvEA9sU2Szpfl9KKjZ6lqM76l1GKoyTw0oiEKuzMPK5n5auHdt79dQZc+00YIO2iE5TxMk8cLCl4VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750966139; c=relaxed/simple;
	bh=CQAIcm6sZF1IS3sqghp+KfRntjovpnLWUaMO0v55P7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XKVPSGa02TszhUfwIU0MTsHELsO5zxjp16Z7FFJ9sCpexYnhi5PL41noScRNQM0vbwIHQ8c3MyTU6YgsjPrj5Q9cOWMJiFhPxi2MzrwbtBHOqVT7pkeDKUNLR3TxeUhi2Ef6LvOPAke8B5ZBa1l+SA4qSkHCkbcrcezIRBj243M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaAoUkSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E384DC4CEF2;
	Thu, 26 Jun 2025 19:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750966138;
	bh=CQAIcm6sZF1IS3sqghp+KfRntjovpnLWUaMO0v55P7A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JaAoUkSMN/AtecgdSAZELuX6MMFhE77/sWzNzHBbNVBysHVdeqJILrNbDq0aoPQ5S
	 IhKPwJ0sYELZP2NIvUR2oJdODcJZGyj+Kog856uhbo8oqb4qaIW+O2jfcF8G6Xy+D4
	 QVIBECdFY/AJ8Y1/q2NSYjHQIv9/zpUOWW/MG9xgB8fQZVFdRuuNnEz+NbLypTaB4u
	 buaEjClT0uAMMQZnTn7ey/BiopFpDTcLgKH/SQqPZUaZdMJ+byBSSfoHQ11A1PbPRK
	 QqFgRLESCPdjJHQksev1uVbqSnW/QTWKCgjSHqcncG22zbJdj5VxpnLcOZR69hzMts
	 Qvq03n3/cKeoQ==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-610cbca60cdso834807eaf.0;
        Thu, 26 Jun 2025 12:28:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU263jKlfu2EUdmSvx315dPKClqpUpiHXj4FHdpyH3HA20h2tAq7FLSAFyhm4XIpCFZcQROya0D1QGK@vger.kernel.org, AJvYcCUC0TXBbgfjyzQLoDM8/SKWs+gGKUTDQu1Hx4K/ARfc+ns1tZq+BLYMQ728ZaxpxtOo70QXnwgXHprANvkT@vger.kernel.org, AJvYcCURz1d9yNKuMQdxe2O9VryulSQiRrGw2AHLr8xYHrxZuzd3oS5w1Mwd/0vf/yd5+ByKzq6hflMhbE5rtL0=@vger.kernel.org, AJvYcCV7Vdi774xpz397bKjjK74sBBk60IMhsoILDVZ24Lofn3WLiIHfJC7gPe9xmPjLzXeqThlc72dODKc4fA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIRNcFQKRnTaNm2JAP5qRowOKgFcViM2VfS6luHZbk/Omd3VU8
	TRffnuJYob4YOMaISoqHRkjolRRfQtsTWJVr0thl7CPsQLzqk3n8c11oFsTLWEbdmQYRH9jI7HB
	G2n0fQo8skYvawjSRbyS37TI4PtUrfaY=
X-Google-Smtp-Source: AGHT+IEBUgMhB3Cs/XVfGwL3Ni4bgX6QqmijQD2zt3mHOab+YTE6R+MhUiwglk8DCiWfnVf7XsTGi+/C0MSY22OPFqg=
X-Received: by 2002:a4a:ec42:0:b0:610:cf37:fa99 with SMTP id
 006d021491bc7-611b909648amr393575eaf.4.1750966138090; Thu, 26 Jun 2025
 12:28:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625215813.3477840-1-superm1@kernel.org> <20250625215813.3477840-5-superm1@kernel.org>
 <710f7c04-0099-4611-b2ea-4dd4219ad5e2@kernel.org> <23f30094-68cc-47fe-86e0-5289cb41e940@kernel.org>
 <rn2kp5tog2agvswva2ipqq2ytiqdcgccnocudsg6ckwfh4roei@provk2g6dita>
 <363c2b92-4bfc-4537-9fca-025eef09526f@kernel.org> <nxticocp26r5mmpkttritw76h5igw7bdpus6zaf5krkso2h5xy@wna6m2quekfi>
 <cbbf0caf-82ce-4427-9844-b11e0f5cacdb@kernel.org> <obpakvzyludc4jskqzyxf65dhqds7ie3jkbfsqdve32ouuaili@xvogkmwvbmbf>
 <284ea5c0-dca5-4e9e-a3e7-705eca794010@kernel.org> <vkau25ybcx3bcoa2jmxlukumunzii5h6em43anh6mmzk2kyiv7@kyych4kxc4zo>
 <0d71a686-da67-4686-8976-a17d0d1ca923@kernel.org> <CAJZ5v0gKUN1OdqAHnXNcFUAOfhpdRfa_o=L6TA2GZTpe1bMaNQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gKUN1OdqAHnXNcFUAOfhpdRfa_o=L6TA2GZTpe1bMaNQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Jun 2025 21:28:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gXRQGzYmEKYzbH4YuHnKEf-zqAm=SmTTW6+qtraz-5xw@mail.gmail.com>
X-Gm-Features: Ac12FXzFsZGyacsqf-wl_GFk-0UQj0Crrc5u0iRbVxF4iWHCdkfom3I7Zv_Z7aE
Message-ID: <CAJZ5v0gXRQGzYmEKYzbH4YuHnKEf-zqAm=SmTTW6+qtraz-5xw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] Input: Don't send fake button presses to wake system
To: Hans de Goede <hansg@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mario Limonciello <superm1@kernel.org>, 
	Mika Westerberg <westeri@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	"open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>, 
	"open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, 
	Ken Xue <Ken.Xue@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 9:18=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Jun 26, 2025 at 9:16=E2=80=AFPM Hans de Goede <hansg@kernel.org> =
wrote:
> >
> > Hi,
> >
> > On 26-Jun-25 21:14, Dmitry Torokhov wrote:
> > > On Thu, Jun 26, 2025 at 08:57:30PM +0200, Hans de Goede wrote:
> > >> Hi,
> > >>
> > >> On 26-Jun-25 20:48, Dmitry Torokhov wrote:
> > >>> On Thu, Jun 26, 2025 at 01:20:54PM -0500, Mario Limonciello wrote:
> > >>>> On 6/26/2025 1:07 PM, Dmitry Torokhov wrote:
> > >>>>> On Thu, Jun 26, 2025 at 12:53:02PM -0500, Mario Limonciello wrote=
:
> > >>>>>>
> > >>>>>>
> > >>>>>> On 6/26/25 12:44 PM, Dmitry Torokhov wrote:
> > >>>>>>> Hi Mario,
> > >>>>>>>
> > >>>>>>> On Thu, Jun 26, 2025 at 06:33:08AM -0500, Mario Limonciello wro=
te:
> > >>>>>>>>
> > >>>>>>>>
> > >>>>>>>> On 6/26/25 3:35 AM, Hans de Goede wrote:
> > >>>>>>>>> Hi Mario,
> > >>>>>>>>>
> > >>>>>>>>> On 25-Jun-25 23:58, Mario Limonciello wrote:
> > >>>>>>>>>> From: Mario Limonciello <mario.limonciello@amd.com>
> > >>>>>>>>>>
> > >>>>>>>>>> Sending an input event to wake a system does wake it, but us=
erspace picks
> > >>>>>>>>>> up the keypress and processes it.  This isn't the intended b=
ehavior as it
> > >>>>>>>>>> causes a suspended system to wake up and then potentially tu=
rn off if
> > >>>>>>>>>> userspace is configured to turn off on power button presses.
> > >>>>>>>>>>
> > >>>>>>>>>> Instead send a PM wakeup event for the PM core to handle wak=
ing the system.
> > >>>>>>>>>>
> > >>>>>>>>>> Cc: Hans de Goede <hansg@kernel.org>
> > >>>>>>>>>> Fixes: 0f107573da417 ("Input: gpio_keys - handle the missing=
 key press event in resume phase")
> > >>>>>>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > >>>>>>>>>> ---
> > >>>>>>>>>>     drivers/input/keyboard/gpio_keys.c | 7 +------
> > >>>>>>>>>>     1 file changed, 1 insertion(+), 6 deletions(-)
> > >>>>>>>>>>
> > >>>>>>>>>> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/in=
put/keyboard/gpio_keys.c
> > >>>>>>>>>> index 773aa5294d269..4c6876b099c43 100644
> > >>>>>>>>>> --- a/drivers/input/keyboard/gpio_keys.c
> > >>>>>>>>>> +++ b/drivers/input/keyboard/gpio_keys.c
> > >>>>>>>>>> @@ -420,12 +420,7 @@ static irqreturn_t gpio_keys_gpio_isr(i=
nt irq, void *dev_id)
> > >>>>>>>>>>              pm_stay_awake(bdata->input->dev.parent);
> > >>>>>>>>>>              if (bdata->suspended  &&
> > >>>>>>>>>>                  (button->type =3D=3D 0 || button->type =3D=
=3D EV_KEY)) {
> > >>>>>>>>>> -                    /*
> > >>>>>>>>>> -                     * Simulate wakeup key press in case th=
e key has
> > >>>>>>>>>> -                     * already released by the time we got =
interrupt
> > >>>>>>>>>> -                     * handler to run.
> > >>>>>>>>>> -                     */
> > >>>>>>>>>> -                    input_report_key(bdata->input, button->=
code, 1);
> > >>>>>>>>>> +                    pm_wakeup_event(bdata->input->dev.paren=
t, 0);
> > >>>>>>>
> > >>>>>>> There is already pm_stay_awake() above.
> > >>>>>>
> > >>>>>> But that doesn't help with the fact that userspace gets KEY_POWE=
R from this
> > >>>>>> and reacts to it.
> > >>>>>>
> > >>>>>>>
> > >>>>>>>>>>              }
> > >>>>>>>>>>      }
> > >>>>>>>>>
> > >>>>>>>>> Hmm, we have the same problem on many Bay Trail / Cherry Trai=
l
> > >>>>>>>>> windows 8 / win10 tablets, so  this has been discussed before=
 and e.g.
> > >>>>>>>>> Android userspace actually needs the button-press (evdev) eve=
nt to not
> > >>>>>>>>> immediately go back to sleep, so a similar patch has been nac=
ked in
> > >>>>>>>>> the past.
> > >>>>>>>>>
> > >>>>>>>>> At least for GNOME this has been fixed in userspace by ignori=
ng
> > >>>>>>>>> power-button events the first few seconds after a resume from=
 suspend.
> > >>>>>>>>>
> > >>>>>>>>
> > >>>>>>>> The default behavior for logind is:
> > >>>>>>>>
> > >>>>>>>> HandlePowerKey=3Dpoweroff
> > >>>>>>>>
> > >>>>>>>> Can you share more about what version of GNOME has a workaroun=
d?
> > >>>>>>>> This was actually GNOME (on Ubuntu 24.04) that I found this is=
sue.
> > >>>>>>>>
> > >>>>>>>> Nonetheless if this is dependent on an Android userspace probl=
em could we
> > >>>>>>>> perhaps conditionalize it on CONFIG_ANDROID_BINDER_DEVICES?
> > >>>>>>>
> > >>>>>>> No it is not only Android, other userspace may want to distingu=
ish
> > >>>>>>> between normal and "dark" resume based on keyboard or other use=
r
> > >>>>>>> activity.
> > >>>>>>>
> > >>>>>>> Thanks.
> > >>>>>>>
> > >>>>>> In this specific case does the key passed up to satisfy this use=
rspace
> > >>>>>> requirement and keep it awake need to specifically be a fabricat=
ed
> > >>>>>> KEY_POWER?
> > >>>>>>
> > >>>>>> Or could we find a key that doesn't require some userspace to ig=
nore
> > >>>>>> KEY_POWER?
> > >>>>>>
> > >>>>>> Maybe something like KEY_RESERVED, KEY_FN, or KEY_POWER2?
> > >>>>>
> > >>>>> The code makes no distinction between KEY_POWER and KEY_A or KEY_=
B, etc.
> > >>>>> It simply passes event to userspace for processing.
> > >>>>
> > >>>> Right.  I don't expect a problem with most keys, but my proposal i=
s to
> > >>>> special case KEY_POWER while suspended.  If a key press event must=
 be sent
> > >>>> to keep Android and other userspace happy I suggest sending someth=
ing
> > >>>> different just for that situation.
> > >>>
> > >>> I do not know if userspace specifically looks for KEY_POWER or if i=
t
> > >>> looks for user input in general, and I'd rather be on safe side and=
 not
> > >>> mangle user input.
> > >>>
> > >>> As Hans mentioned, at least some userspace already prepared to deal=
 with
> > >>> this issue. And again, this only works if by the time ISR/debounce
> > >>> runs the key is already released. What if it is still pressed? You =
still
> > >>> going to observe KEY_POWER and need to suppress turning off the scr=
een.
> > >>>
> > >>>>
> > >>>> Like this:
> > >>>>
> > >>>> diff --git a/drivers/input/keyboard/gpio_keys.c
> > >>>> b/drivers/input/keyboard/gpio_keys.c
> > >>>> index 773aa5294d269..66e788d381956 100644
> > >>>> --- a/drivers/input/keyboard/gpio_keys.c
> > >>>> +++ b/drivers/input/keyboard/gpio_keys.c
> > >>>> @@ -425,7 +425,10 @@ static irqreturn_t gpio_keys_gpio_isr(int irq=
, void
> > >>>> *dev_id)
> > >>>>                          * already released by the time we got int=
errupt
> > >>>>                          * handler to run.
> > >>>>                          */
> > >>>> -                       input_report_key(bdata->input, button->cod=
e, 1);
> > >>>> +                       if (button->code =3D=3D KEY_POWER)
> > >>>> +                               input_report_key(bdata->input, KEY=
_WAKEUP,
> > >>>> 1);
> > >>>
> > >>> Just FYI: Here your KEY_WAKEUP is stuck forever.
> > >>>
> > >>>> +                       else
> > >>>> +                               input_report_key(bdata->input, but=
ton->code,
> > >>>> 1);
> > >>>>                 }
> > >>>>         }
> > >>>>
> > >>>>
> > >>>>
> > >>>>>
> > >>>>> You need to fix your userspace. Even with your tweak it is possib=
le for
> > >>>>> userspace to get a normal key event "too early" and turn off the =
screen
> > >>>>> again, so you still need to handle this situation.
> > >>>>>
> > >>>>> Thanks.
> > >>>>>
> > >>>>
> > >>>> I want to note this driver works quite differently than how ACPI p=
ower
> > >>>> button does.
> > >>>>
> > >>>> You can see in acpi_button_notify() that the "keypress" is only fo=
rwarded
> > >>>> when not suspended [1].  Otherwise it's just wakeup event (which i=
s what my
> > >>>> patch was modeling).
> > >>>>
> > >>>> https://github.com/torvalds/linux/blob/v6.16-rc3/drivers/acpi/butt=
on.c#L461
> > >>>> [1]
> > >>>
> > >>> If you check acpi_button_resume() you will see that the events are =
sent
> > >>> from there. Except that for some reason they chose to use KEY_WAKEU=
P and
> > >>> not KEY_POWER, oh well. Unlike acpi button driver gpio_keys is used=
 on
> > >>> multiple other platforms.
> > >>
> > >> Interesting, but the ACPI button code presumably only does this on r=
esume
> > >> for a normal press while the system is awake it does use KEY_POWER, =
right ?
> > >
> > > Yes. It is unclear to me why they chose to mangle the event on wakeup=
,
> > > it does not seem to be captured in the email discussions or in the pa=
tch
> > > description.
> >
> > I assume they did this to avoid the immediate re-suspend on wakeup by
> > power-button issue. GNOME has a workaround for this, but I assume that
> > some userspace desktop environments are still going to have a problem
> > with this.
>
> It was done for this reason IIRC, but it should have been documented
> more thoroughly.

Actually, I'm thinking that this should only be done on S3 resume, not
on s2idle resume.

On S3 resume, there is no indication from the kernel to user space
which event has caused the wakeup if it is the power button and so
commit 16f70feaabe9 ("ACPI: button: trigger wakeup key events")
attempted to mitigate this.

However, on s2idle wakeup the actual input event is sent to user
space, so there is no need to make up one.

