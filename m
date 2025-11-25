Return-Path: <linux-acpi+bounces-19255-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 615A2C85105
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 14:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06FEE4EA315
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 12:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45731322C97;
	Tue, 25 Nov 2025 12:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4+Fckf5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198FA2ED870
	for <linux-acpi@vger.kernel.org>; Tue, 25 Nov 2025 12:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764075582; cv=none; b=rlhkBIJlDNCJXlUG1BF7eoHDy5uxmuKVGZUaA0cJ9/grztfe/Hn7Lgb8xitV9XH5Pknvk4sgrxHQ6OfOiIGHL7uwvdYHxW/WHWpEoB/IrMuhPoGCirXFhlgke4VWT//0qoiC9qfpfwNsmrQrx8iUJyvBKku+J7assIOgKAoMGOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764075582; c=relaxed/simple;
	bh=rQyKMfAOFRiwTsS20vKpOjYl+9HbSV45rLfTdrvzi1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oa5B88wTEiU+6Oly3kd0XAkA4DUS2B8nXiTcFr6vbcwK70yB51tC6IUYDigLC9BNqUp9IhOjD6wjBQzQ0BJyYr3cfQ419YtW5dfrvhBHbthY+EpgsbPRn60o3efs3uteGuUgLjcwZLHHzfiXlwS5/Xqdq9CxpS3aLD/A4sBli4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4+Fckf5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB687C116B1
	for <linux-acpi@vger.kernel.org>; Tue, 25 Nov 2025 12:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764075581;
	bh=rQyKMfAOFRiwTsS20vKpOjYl+9HbSV45rLfTdrvzi1g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O4+Fckf5zE6k20574ZCuM9+EW/94tcGClTDaiRbwC5IpAkJToJ0axC9MDt3oXYUmk
	 haQIdnxUnhES7ibLIikB/68B/UAXxCj9kEPsxwkZwpVAJwlfwS+DKxIhaSCIAdBld6
	 XkgGeeQQN+DR0VV8QZolcQvLkPpSgM6uO0DfSqDGhufJPxy8CnF5y3itKempZw0Z/j
	 o6cXmkE4HXGOL38Htpq6Whtk8DZA8aFPlB4X8TJLSFQGoFUygxBPXhXY0jCrGKYvuw
	 8bn70iL+bRhe7LVv8OCwvVcq3Jk7ocpMiUK1Zyws5t4UzHOWvBz/7LDj/Z7V4dgJ13
	 Rk9VJxGpS7ONw==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-65744fbb2e4so2159220eaf.1
        for <linux-acpi@vger.kernel.org>; Tue, 25 Nov 2025 04:59:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVLwcqneprZmUhX2HrLEBXhqfDA9oIhOJkt8T1GqmXtAjiPdFxP9U/ukQTdU+5/WDMUWbXF2z/5nMGm@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ0JbwhmV04lm1+ib5AF6O78D89B2Ea1zACyHclmBCNmZ6i/d2
	vAcl/oPyTxq3nD1+uBqQGusUUeozqBogVaWoFAUhiN9tYi4+9BVD02jW8DLwDDZAeF8P/CjwsdN
	RKYoT3OFqYruFJDjIWdoOZb/AGZfBU0g=
X-Google-Smtp-Source: AGHT+IFuN2ejJWSBLEaumBoB4YS1kb8mtSJoF4mJaslScfPlYPrSEuXfFLC0bQQpU2rhTVIvXb7XHFRjsoNqo81nBj0=
X-Received: by 2002:a05:6808:894c:b0:450:3ff9:f501 with SMTP id
 5614622812f47-4511290fd1dmr7475751b6e.7.1764075581061; Tue, 25 Nov 2025
 04:59:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107184438.1328717-1-usama.anjum@collabora.com>
 <20251107184438.1328717-5-usama.anjum@collabora.com> <CAJZ5v0iucMXFkKuRxtAUyAqW11NHHGVuYnjJNbroeMgJoGY1kw@mail.gmail.com>
 <b71b3e35-fc76-4397-9d60-20778685e37c@collabora.com>
In-Reply-To: <b71b3e35-fc76-4397-9d60-20778685e37c@collabora.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 25 Nov 2025 13:59:29 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0icvqaL1YwBGYrF9K_hKwPjwYmP50Js61Ru3pphpjmBwg@mail.gmail.com>
X-Gm-Features: AWmQ_bn8LoiEt60nvIoyaBzSeBB1pR0advvfqMPPwry2P7-hg61XGbJUbXFjk-w
Message-ID: <CAJZ5v0icvqaL1YwBGYrF9K_hKwPjwYmP50Js61Ru3pphpjmBwg@mail.gmail.com>
Subject: Re: [PATCH 4/4] PM: sleep: clear pm_abort_suspend at suspend
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-input@vger.kernel.org, kernel@collabora.com, superm1@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 10:54=E2=80=AFAM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> Hi Rafael,
>
> Thank you for reviewing.
>
> On 11/24/25 11:54 PM, Rafael J. Wysocki wrote:
> > On Fri, Nov 7, 2025 at 7:45=E2=80=AFPM Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> >>
> >> Clear pm_abort_suspend counter in case a wakeup is detected during
> >> hibernation process. If this counter isn't reset, it'll affect the
> >> next hibernation cycle and next time hibernation will not happen as
> >> pm_abort_suspend is still positive.
> >>
> >> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> >> ---
> >>  drivers/base/power/main.c | 2 ++
> >>  kernel/cpu.c              | 1 +
> >>  kernel/power/hibernate.c  | 5 ++++-
> >>  kernel/power/process.c    | 1 +
> >>  4 files changed, 8 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> >> index 5760abb25b591..84e76f8df1e02 100644
> >> --- a/drivers/base/power/main.c
> >> +++ b/drivers/base/power/main.c
> >> @@ -1642,6 +1642,7 @@ static void device_suspend_late(struct device *d=
ev, pm_message_t state, bool asy
> >>                 goto Complete;
> >>
> >>         if (pm_wakeup_pending()) {
> >> +               pm_wakeup_clear(0);
> >>                 WRITE_ONCE(async_error, -EBUSY);
> >>                 goto Complete;
> >>         }
> >> @@ -1887,6 +1888,7 @@ static void device_suspend(struct device *dev, p=
m_message_t state, bool async)
> >>
> >>         if (pm_wakeup_pending()) {
> >>                 dev->power.direct_complete =3D false;
> >> +               pm_wakeup_clear(0);
> >>                 WRITE_ONCE(async_error, -EBUSY);
> >>                 goto Complete;
> >>         }
> >> diff --git a/kernel/cpu.c b/kernel/cpu.c
> >> index db9f6c539b28c..74c9f6b4947dd 100644
> >> --- a/kernel/cpu.c
> >> +++ b/kernel/cpu.c
> >> @@ -1921,6 +1921,7 @@ int freeze_secondary_cpus(int primary)
> >>
> >>                 if (pm_wakeup_pending()) {
> >>                         pr_info("Wakeup pending. Abort CPU freeze\n");
> >> +                       pm_wakeup_clear(0);
> >>                         error =3D -EBUSY;
> >>                         break;
> >>                 }
> >> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> >> index e15907f28c4cd..1f6b60df45d34 100644
> >> --- a/kernel/power/hibernate.c
> >> +++ b/kernel/power/hibernate.c
> >> @@ -349,8 +349,10 @@ static int create_image(int platform_mode)
> >>                 goto Enable_irqs;
> >>         }
> >>
> >> -       if (hibernation_test(TEST_CORE) || pm_wakeup_pending())
> >> +       if (hibernation_test(TEST_CORE) || pm_wakeup_pending()) {
> >> +               pm_wakeup_clear(0);
> >>                 goto Power_up;
> >> +       }
> >>
> >>         in_suspend =3D 1;
> >>         save_processor_state();
> >> @@ -660,6 +662,7 @@ int hibernation_platform_enter(void)
> >>                 goto Enable_irqs;
> >>
> >>         if (pm_wakeup_pending()) {
> >> +               pm_wakeup_clear(0);
> >>                 error =3D -EAGAIN;
> >>                 goto Power_up;
> >>         }
> >> diff --git a/kernel/power/process.c b/kernel/power/process.c
> >> index dc0dfc349f22b..e935b27a04ae0 100644
> >> --- a/kernel/power/process.c
> >> +++ b/kernel/power/process.c
> >> @@ -67,6 +67,7 @@ static int try_to_freeze_tasks(bool user_only)
> >>                         break;
> >>
> >>                 if (pm_wakeup_pending()) {
> >> +                       pm_wakeup_clear(0);
> >>                         wakeup =3D true;
> >>                         break;
> >>                 }
> >> --
> >
> > I don't think pm_wakeup_clear() needs to be called in so many places.
> >
> > Any why isn't it sufficient to call it in freeze_processes()?  For
> > suspend, it is sufficient, so what's different about hibernation in
> > that respect?
>
> It seems this patch was written by me when [1] was added which removed th=
e
> unconditional call pm_wakeup_clear(0) from freeze_processes(). It was lat=
er
> reverted [2].

OK, I see.

> I've removed this patch and tested again to find out:
> - try_to_freeze_tasks() gets called from freeze_process() after
>   unconditional clearing of pm_wakeup. So pm_wakeup doesn't get cleared
>   until next hibernation or any other similar operation. So for hibernati=
on
>   cancellation this patch isn't required. I'll drop it.
>
> But shouldn't this wakeup event be consumed without waiting for next hibe=
rnation
> (or similar operation to happen)?

I'm not sure what you mean.

Consuming an event is not related to calling pm_wakeup_clear().

pm_wakeup_clear() is related to wakeup IRQ handling, see pm_system_irq_wake=
up().

This takes place after IRQs have been suspended (that's what the
"noirq" suspend phase is about).

