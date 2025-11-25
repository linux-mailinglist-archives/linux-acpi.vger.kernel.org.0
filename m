Return-Path: <linux-acpi+bounces-19254-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCF3C84F50
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 13:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C243B07A3
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Nov 2025 12:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C9C283124;
	Tue, 25 Nov 2025 12:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5QtxH08"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F89A1A9B58
	for <linux-acpi@vger.kernel.org>; Tue, 25 Nov 2025 12:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764073570; cv=none; b=Xce8DmeZaLHnb1sedR9JTcOcXBOUR+zv7Tx3QorWmhvk9GGrKEeSk5Zf43GOzw1xHMuYVfkC8jBI7wI2sZk1l7N6IpwWD//TKJc9J5s3Bce5HdBCPBf+HgUF4ueT+l9vG4pP6d8D1TicUQPL1KAPJ8C43K43zmZshIwI6Wno0g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764073570; c=relaxed/simple;
	bh=Zvrwnbbw/3orNTGSrOMAUA5Y/Het52/a2ovrMrjm5ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2gmMb9gjcVFPIhNkm88rPSh6AT1LwcseadAMd1rUWG6zOyezof76qWGSSrY3Os2lsS3jeU5FjjfGrS7O1SaYgnUlaDOFgUytXbQ7wTzu7DYdRZRcMfoBP/cKwr+Xe81ml33lbDAJjC+SCbyw1yoJwJnX1iDOGLe2bC5wEGzd84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5QtxH08; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F49C19423
	for <linux-acpi@vger.kernel.org>; Tue, 25 Nov 2025 12:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764073569;
	bh=Zvrwnbbw/3orNTGSrOMAUA5Y/Het52/a2ovrMrjm5ek=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G5QtxH08EzHMgZiGK+QFhhvwUS3GHyO6m87xJxD49GA9vM6DN59Jh3m0Xgvy6FycP
	 qU94QhS6l0ueNnuiK/n5GrmWVRIsnSRVTpXRyF83zxaDVpLxHWpB/I8ZgaErA4Ve1F
	 1GCc+/85owQbsqlcnSS6JWJSEqBkRXn2V3jCH0yxPjUXRYqpeBl2/gr+TXeBN9u33x
	 EYYzzTsyJC8e/QcELc6ElTYlQ/vhyIrjVrvbJkcluMJjPeYT+dJTBk2euOd0qHSUrn
	 6kKgT+TOjmSw79UKrUGcjbCl4Ea/lKbQUHUPqOkyPoeY8Q9/egSqQdPbu7wBxh8wer
	 xwWQlEuuuHXxA==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-451183d1081so438162b6e.3
        for <linux-acpi@vger.kernel.org>; Tue, 25 Nov 2025 04:26:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUfbuZIbInCu+tIRGH6utBHwbVDjeDNLAaCIneIxg1FM0QIF92GOe8P7K4+o7GcikuDaT1iP1CNZtHG@vger.kernel.org
X-Gm-Message-State: AOJu0YwhFiiTGb/iNUskNrDZDc+Hpcaqat0MVHi3H3TRhQUNVdJezKYQ
	KvF8fNx66xUyrxmK38OUkSyeM6Cp5Z6Rdo77zvtZcIJfV+Hy9WWq5LH5jj9xJJk+KRFyjWm+bMo
	HmHeLUxnE5JOwCxMxg504T9tmKvsizEA=
X-Google-Smtp-Source: AGHT+IGYguZlNaP1Qrg6qHtt+XGD/CWfI1p4aoYHhE0zHc88503s37W5EZKx023bHPOtiCTf9Je+0Zcu3TCCmNUIDNU=
X-Received: by 2002:a05:6808:1a1d:b0:450:4cbc:b20c with SMTP id
 5614622812f47-45115aa5eadmr4879327b6e.37.1764073569139; Tue, 25 Nov 2025
 04:26:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107184438.1328717-1-usama.anjum@collabora.com>
 <20251107184438.1328717-4-usama.anjum@collabora.com> <CAJZ5v0gtGjE-rSwM4Kom4cDEhp3eSOkLCmbLwrt_9u9a7VP6zQ@mail.gmail.com>
 <6f1f3210-47c6-4c00-8fb9-35f48bae2581@collabora.com>
In-Reply-To: <6f1f3210-47c6-4c00-8fb9-35f48bae2581@collabora.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 25 Nov 2025 13:25:56 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iDUPB9s2fPJxqVqPGj5wbw54tR4thmDD2V-r4+Q2prwg@mail.gmail.com>
X-Gm-Features: AWmQ_bmYzcRJtuYDmncfjUQOlIEg9cepukxFQx45jUU5lmAWTSjkDX0FX6bWCqk
Message-ID: <CAJZ5v0iDUPB9s2fPJxqVqPGj5wbw54tR4thmDD2V-r4+Q2prwg@mail.gmail.com>
Subject: Re: [PATCH 3/4] Input: Ignore the KEY_POWER events if hibernation is
 in progress
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-input@vger.kernel.org, kernel@collabora.com, superm1@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 11:23=E2=80=AFAM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> On 11/24/25 11:50 PM, Rafael J. Wysocki wrote:
> > On Fri, Nov 7, 2025 at 7:45=E2=80=AFPM Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> >>
> >> Input (Serio) drivers call input_handle_event(). Although the serio
> >> drivers have duplicate events, they have separate code path and call
> >> input_handle_event(). Ignore the KEY_POWER such that this event isn't
> >> sent to the userspace if hibernation is in progress.
> >
> > Your change affects suspend too.
> >
> > Also, what's the goal you want to achieve?
> Two goals:
> * Don't send event to userspace
> * Set pm_wakeup for hibernation cancellation for non-acpi devices (This a=
pi
>   call should be tested on non-acpi devices such as arm board to see if i=
t
>   helps. I don't have an arm board in hand)
>
> >
> >> Abort the hibernation by calling pm_wakeup_dev_event(). In case of ser=
io,
> >> doesn't have wakeup source registered, this call doesn't do anything.
> >> But there may be other input drivers which will require this.
> >>
> >> Without this, the event is sent to the userspace and it suspends the
> >> device after hibernation cancellation.
> >
> > I think that's because user space handles it this way, isn't it?
>
> Yes, it depends on how userspace handles such events. There are different=
 settings
> configured for systemd-logind when power event is received. The purpose i=
s to consume
> this event to cancel the hibernation without letting userspace know about=
 it.
>
> Thinking more about it, I wasn't sure if all of such events are compulsor=
y to be
> delivered to userspace. But then I found an example: In acpi_button_notif=
y(), all
> such events are not sent to userspace if button is suspended. So it seems=
 okay to
> not send this as well and just consume in the kernel.

You want the given key (and it doesn't matter whether or not this is
KEY_POWER or something else) to play two roles.  One of them is to
send a specific key code to user space and let it handle the keypress
as it wants.  This is how it works most of the time.  The second one
is to wake up the system from sleep (and I'm not sure why you want to
limit this to hibernation) in which case the key code will not be sent
to user space.

For this to work, you need to switch between the two modes quite
precisely and checking things like pm_sleep_transition_in_progress()
(which is only used for debug and its raciness is not relevant there)
is not sufficient for this purpose.  That's what the "suspended" flag
in the ACPI button driver is for.

