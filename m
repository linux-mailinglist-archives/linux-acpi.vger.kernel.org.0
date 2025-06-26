Return-Path: <linux-acpi+bounces-14742-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D70AEA643
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 21:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16C2189A465
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 19:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7082EF9B4;
	Thu, 26 Jun 2025 19:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoV6kTQt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772F22EF66F;
	Thu, 26 Jun 2025 19:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750965548; cv=none; b=ny3Gw04SsJ1X3qSj9Kw/34XZ0EMOtVoDmBP0ztT4cj71OvhAY5np3Xe9Krf8o5xNtgfNvoZQSKjOZDDV7BfpP2qIHf2Imnk0Tay64PfMwe9LOE8tNBjC54pUyu95OT6eG9zJSpiq4kiYt99GLig2FZFXY95bynV/VmASoTe3J8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750965548; c=relaxed/simple;
	bh=VkX5ZuHS/bXV97AUrIGdGTgdrkQP8GvbiWckmjBNkIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qAzuMlqIpX0BHu6Kul3m2hWNubrOTxrjql0ajVIDOk1fq/blM//5rnMQDA7Lk/EsZyvVSY8WlpNsRUKl0LNTRA7XNtqY+WhDV5v9PztI46dlUd4g+cEIAc5M0M7ceCmXiHYBtZoC9xplAh84+IAJEdOIn1h+P9kTuyamo2M5Jt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoV6kTQt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F7FC4AF0B;
	Thu, 26 Jun 2025 19:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750965548;
	bh=VkX5ZuHS/bXV97AUrIGdGTgdrkQP8GvbiWckmjBNkIQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MoV6kTQt/MIZrbtDjtfMdN8xlyvtKinhJDyXfVV3CAeKRQm7CvCUkxgM6yfF2vHc4
	 G6gHwtMHXwu9xhJb6Olp6+cVu/kZY7W3WT+uxHDzDrEBg3kvJRfh/LmkG4k+HNkclc
	 k93AmoLxs4cXsx19g45diS1Gb0lPnPcM8XwThAcTMgktUQ4Zh0aWlfJy9eib1E9Puu
	 U/6kGtWY8yjygihVK3GunULdFqUAFPEnb7ROM4eWKbDEX6zIuBuG8x+KT5W54LtWCB
	 vWY4NKMaMitYHk8Nzn3ktwlZmhP3FEkPzpRM9ptk7OdIVP5TPJmBkDCqhrx+zQbjt7
	 PjGt/rhgUR4GQ==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-610db3f3f90so712319eaf.2;
        Thu, 26 Jun 2025 12:19:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV8UtJiXZK1+U2N0l7HvzbQMl3Y0JTskokhPCDBbTrAOnRgtw83lxEVsiTX+qUENp9daiPjceZX/f2I@vger.kernel.org, AJvYcCVesDujmLJGUeAGxYgP+HYqVhVo3aH5nIE7gV+Tz9B2OB7a/znrtcUQJXgj8q2aykzcIbCShuQG317RqRM=@vger.kernel.org, AJvYcCVoPuM2Ktc1HIbRdrwlRwwWQQ2TqRybCIp9e3tojTuhYbhdT7cVBEotHpXqonD+K1+E34auoZi9UgqoZd+u@vger.kernel.org, AJvYcCWdtICzJV1APDCyrvxvboee3N87OUR3BgP/LLFeouItquxrN7RBnnSHbktb+IZj3k919TzoUdb2y23nPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZlpw2LCOHT+DO6VkOFzKlRxS0Dl717fOFbxqWmIgVxeCdD0cu
	DUWI5kRkdDZa35S/C80kXnRCN28WKhoK3megy8+ylGvI9UhZuG/S0kXd6nIe7i/X8+567wJNBDz
	t2kyaO+iyR8hnLJplkD1xXcoIPZUuuAo=
X-Google-Smtp-Source: AGHT+IEf8+Nk3mb1VVGmWBipvoc78JKfPHDCIcW4oYXWUF1PzlrpPecW83KkWJVeTPUxs5NdH3Wl2IBL5jwi24CoVCM=
X-Received: by 2002:a05:6820:180c:b0:611:b85f:b159 with SMTP id
 006d021491bc7-611b9015d61mr397663eaf.1.1750965547237; Thu, 26 Jun 2025
 12:19:07 -0700 (PDT)
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
 <0d71a686-da67-4686-8976-a17d0d1ca923@kernel.org>
In-Reply-To: <0d71a686-da67-4686-8976-a17d0d1ca923@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Jun 2025 21:18:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gKUN1OdqAHnXNcFUAOfhpdRfa_o=L6TA2GZTpe1bMaNQ@mail.gmail.com>
X-Gm-Features: Ac12FXxSdOjDJ8hZfsVdmlh0vRBQMtPgyURvdzpvkVcVLQ-9eoMVTSQOIi6KsFI
Message-ID: <CAJZ5v0gKUN1OdqAHnXNcFUAOfhpdRfa_o=L6TA2GZTpe1bMaNQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] Input: Don't send fake button presses to wake system
To: Hans de Goede <hansg@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mario Limonciello <superm1@kernel.org>, 
	Mika Westerberg <westeri@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	"open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>, 
	"open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 9:16=E2=80=AFPM Hans de Goede <hansg@kernel.org> wr=
ote:
>
> Hi,
>
> On 26-Jun-25 21:14, Dmitry Torokhov wrote:
> > On Thu, Jun 26, 2025 at 08:57:30PM +0200, Hans de Goede wrote:
> >> Hi,
> >>
> >> On 26-Jun-25 20:48, Dmitry Torokhov wrote:
> >>> On Thu, Jun 26, 2025 at 01:20:54PM -0500, Mario Limonciello wrote:
> >>>> On 6/26/2025 1:07 PM, Dmitry Torokhov wrote:
> >>>>> On Thu, Jun 26, 2025 at 12:53:02PM -0500, Mario Limonciello wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 6/26/25 12:44 PM, Dmitry Torokhov wrote:
> >>>>>>> Hi Mario,
> >>>>>>>
> >>>>>>> On Thu, Jun 26, 2025 at 06:33:08AM -0500, Mario Limonciello wrote=
:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On 6/26/25 3:35 AM, Hans de Goede wrote:
> >>>>>>>>> Hi Mario,
> >>>>>>>>>
> >>>>>>>>> On 25-Jun-25 23:58, Mario Limonciello wrote:
> >>>>>>>>>> From: Mario Limonciello <mario.limonciello@amd.com>
> >>>>>>>>>>
> >>>>>>>>>> Sending an input event to wake a system does wake it, but user=
space picks
> >>>>>>>>>> up the keypress and processes it.  This isn't the intended beh=
avior as it
> >>>>>>>>>> causes a suspended system to wake up and then potentially turn=
 off if
> >>>>>>>>>> userspace is configured to turn off on power button presses.
> >>>>>>>>>>
> >>>>>>>>>> Instead send a PM wakeup event for the PM core to handle wakin=
g the system.
> >>>>>>>>>>
> >>>>>>>>>> Cc: Hans de Goede <hansg@kernel.org>
> >>>>>>>>>> Fixes: 0f107573da417 ("Input: gpio_keys - handle the missing k=
ey press event in resume phase")
> >>>>>>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >>>>>>>>>> ---
> >>>>>>>>>>     drivers/input/keyboard/gpio_keys.c | 7 +------
> >>>>>>>>>>     1 file changed, 1 insertion(+), 6 deletions(-)
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/inpu=
t/keyboard/gpio_keys.c
> >>>>>>>>>> index 773aa5294d269..4c6876b099c43 100644
> >>>>>>>>>> --- a/drivers/input/keyboard/gpio_keys.c
> >>>>>>>>>> +++ b/drivers/input/keyboard/gpio_keys.c
> >>>>>>>>>> @@ -420,12 +420,7 @@ static irqreturn_t gpio_keys_gpio_isr(int=
 irq, void *dev_id)
> >>>>>>>>>>              pm_stay_awake(bdata->input->dev.parent);
> >>>>>>>>>>              if (bdata->suspended  &&
> >>>>>>>>>>                  (button->type =3D=3D 0 || button->type =3D=3D=
 EV_KEY)) {
> >>>>>>>>>> -                    /*
> >>>>>>>>>> -                     * Simulate wakeup key press in case the =
key has
> >>>>>>>>>> -                     * already released by the time we got in=
terrupt
> >>>>>>>>>> -                     * handler to run.
> >>>>>>>>>> -                     */
> >>>>>>>>>> -                    input_report_key(bdata->input, button->co=
de, 1);
> >>>>>>>>>> +                    pm_wakeup_event(bdata->input->dev.parent,=
 0);
> >>>>>>>
> >>>>>>> There is already pm_stay_awake() above.
> >>>>>>
> >>>>>> But that doesn't help with the fact that userspace gets KEY_POWER =
from this
> >>>>>> and reacts to it.
> >>>>>>
> >>>>>>>
> >>>>>>>>>>              }
> >>>>>>>>>>      }
> >>>>>>>>>
> >>>>>>>>> Hmm, we have the same problem on many Bay Trail / Cherry Trail
> >>>>>>>>> windows 8 / win10 tablets, so  this has been discussed before a=
nd e.g.
> >>>>>>>>> Android userspace actually needs the button-press (evdev) event=
 to not
> >>>>>>>>> immediately go back to sleep, so a similar patch has been nacke=
d in
> >>>>>>>>> the past.
> >>>>>>>>>
> >>>>>>>>> At least for GNOME this has been fixed in userspace by ignoring
> >>>>>>>>> power-button events the first few seconds after a resume from s=
uspend.
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> The default behavior for logind is:
> >>>>>>>>
> >>>>>>>> HandlePowerKey=3Dpoweroff
> >>>>>>>>
> >>>>>>>> Can you share more about what version of GNOME has a workaround?
> >>>>>>>> This was actually GNOME (on Ubuntu 24.04) that I found this issu=
e.
> >>>>>>>>
> >>>>>>>> Nonetheless if this is dependent on an Android userspace problem=
 could we
> >>>>>>>> perhaps conditionalize it on CONFIG_ANDROID_BINDER_DEVICES?
> >>>>>>>
> >>>>>>> No it is not only Android, other userspace may want to distinguis=
h
> >>>>>>> between normal and "dark" resume based on keyboard or other user
> >>>>>>> activity.
> >>>>>>>
> >>>>>>> Thanks.
> >>>>>>>
> >>>>>> In this specific case does the key passed up to satisfy this users=
pace
> >>>>>> requirement and keep it awake need to specifically be a fabricated
> >>>>>> KEY_POWER?
> >>>>>>
> >>>>>> Or could we find a key that doesn't require some userspace to igno=
re
> >>>>>> KEY_POWER?
> >>>>>>
> >>>>>> Maybe something like KEY_RESERVED, KEY_FN, or KEY_POWER2?
> >>>>>
> >>>>> The code makes no distinction between KEY_POWER and KEY_A or KEY_B,=
 etc.
> >>>>> It simply passes event to userspace for processing.
> >>>>
> >>>> Right.  I don't expect a problem with most keys, but my proposal is =
to
> >>>> special case KEY_POWER while suspended.  If a key press event must b=
e sent
> >>>> to keep Android and other userspace happy I suggest sending somethin=
g
> >>>> different just for that situation.
> >>>
> >>> I do not know if userspace specifically looks for KEY_POWER or if it
> >>> looks for user input in general, and I'd rather be on safe side and n=
ot
> >>> mangle user input.
> >>>
> >>> As Hans mentioned, at least some userspace already prepared to deal w=
ith
> >>> this issue. And again, this only works if by the time ISR/debounce
> >>> runs the key is already released. What if it is still pressed? You st=
ill
> >>> going to observe KEY_POWER and need to suppress turning off the scree=
n.
> >>>
> >>>>
> >>>> Like this:
> >>>>
> >>>> diff --git a/drivers/input/keyboard/gpio_keys.c
> >>>> b/drivers/input/keyboard/gpio_keys.c
> >>>> index 773aa5294d269..66e788d381956 100644
> >>>> --- a/drivers/input/keyboard/gpio_keys.c
> >>>> +++ b/drivers/input/keyboard/gpio_keys.c
> >>>> @@ -425,7 +425,10 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, =
void
> >>>> *dev_id)
> >>>>                          * already released by the time we got inter=
rupt
> >>>>                          * handler to run.
> >>>>                          */
> >>>> -                       input_report_key(bdata->input, button->code,=
 1);
> >>>> +                       if (button->code =3D=3D KEY_POWER)
> >>>> +                               input_report_key(bdata->input, KEY_W=
AKEUP,
> >>>> 1);
> >>>
> >>> Just FYI: Here your KEY_WAKEUP is stuck forever.
> >>>
> >>>> +                       else
> >>>> +                               input_report_key(bdata->input, butto=
n->code,
> >>>> 1);
> >>>>                 }
> >>>>         }
> >>>>
> >>>>
> >>>>
> >>>>>
> >>>>> You need to fix your userspace. Even with your tweak it is possible=
 for
> >>>>> userspace to get a normal key event "too early" and turn off the sc=
reen
> >>>>> again, so you still need to handle this situation.
> >>>>>
> >>>>> Thanks.
> >>>>>
> >>>>
> >>>> I want to note this driver works quite differently than how ACPI pow=
er
> >>>> button does.
> >>>>
> >>>> You can see in acpi_button_notify() that the "keypress" is only forw=
arded
> >>>> when not suspended [1].  Otherwise it's just wakeup event (which is =
what my
> >>>> patch was modeling).
> >>>>
> >>>> https://github.com/torvalds/linux/blob/v6.16-rc3/drivers/acpi/button=
.c#L461
> >>>> [1]
> >>>
> >>> If you check acpi_button_resume() you will see that the events are se=
nt
> >>> from there. Except that for some reason they chose to use KEY_WAKEUP =
and
> >>> not KEY_POWER, oh well. Unlike acpi button driver gpio_keys is used o=
n
> >>> multiple other platforms.
> >>
> >> Interesting, but the ACPI button code presumably only does this on res=
ume
> >> for a normal press while the system is awake it does use KEY_POWER, ri=
ght ?
> >
> > Yes. It is unclear to me why they chose to mangle the event on wakeup,
> > it does not seem to be captured in the email discussions or in the patc=
h
> > description.
>
> I assume they did this to avoid the immediate re-suspend on wakeup by
> power-button issue. GNOME has a workaround for this, but I assume that
> some userspace desktop environments are still going to have a problem
> with this.

It was done for this reason IIRC, but it should have been documented
more thoroughly.

