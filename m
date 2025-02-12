Return-Path: <linux-acpi+bounces-11101-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1F8A327DE
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 14:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C659D188C794
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 13:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A799D20E700;
	Wed, 12 Feb 2025 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLpxtGk2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E90220E6FF;
	Wed, 12 Feb 2025 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739368642; cv=none; b=LVcFnWqQ5CsFQfHy7abTpRLHNk7n8V92sfy5aluxIZ2UJAA10HiueZuabrRTjDeVVhtGgijxs33s8OOf8ec8BM2jgQzHnOT7LS5X20Ba/AZxOQf0R9iEd4FG2vxgWdEEhfxsfHqdSTYMO65KqfKGdSpKr/hJCT6+pGTJ0Ml2UMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739368642; c=relaxed/simple;
	bh=n3O4c5fvh5M04TdsNyeoIXrYlh7gJcLldyGVj/7plFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qeIjKUogWEdYUbvFcvLW21jjPazFlU3j0D4WcDTDrKH2T48bGpmlm5JQ3QU9bJ1h4KGDuxiXmieNyXidKfB3+R6Zr64NoNMMb5E0+CiEgC6+uy56scjtaZot3Q3rZg7K6QGbNECzrUfmK6kHXzFtuK3yCeikoGE7+QR6ThnXwGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLpxtGk2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F027BC4CEDF;
	Wed, 12 Feb 2025 13:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739368642;
	bh=n3O4c5fvh5M04TdsNyeoIXrYlh7gJcLldyGVj/7plFE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vLpxtGk2Gxq3mGnrMrlS50qicK1BxxmPCcaIxAqk3RMyp48ONjZJVsJRhYwVlxiQN
	 GSfS7MrnvQKvYS0Lmb/FJa1yWy4tGcMwd2rfqoAHcohQFfHskiZstkLGtbjH/8JhkA
	 VPdmjYxw6lrlPlyHMjKPuFLsIl1mT5cD35pvOvVyqFY/6iryUT9tNMs+h53NewhaI6
	 Qm2RIoItD+uQ481UnbfQvT6nEjXpGaTM1vyRsRPPZfQTmcwzpIxLeU2ztKOL/6dEyB
	 6RZzjaGW7jtr2QxFjjFj6U9GS4A9VR7ooKhrUJzNK9CHKE1jG+Dh6Q3vcJ8Lu2OZu2
	 0uzLA4+YoFt4w==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-71fbb0d035dso3819818a34.2;
        Wed, 12 Feb 2025 05:57:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWyMxWP7FeqOOtgn3nXKbKAW1sDRtTLG2TsQzCpODyDgbBe74n5be0QCYWPrVBMkPVtaCN6X9X5BV+l@vger.kernel.org, AJvYcCXqgeAgkiODvqEPIowdN7akRO3jVO6mOLoCRx8M/0yC6DlQSXs+BfO+K+uJnRbaVY5EpfNdrFbvsLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXk3GPxpzHP0lFrv6U8TnBVZnNKNJ83mm5SJZIcpM3wisURr26
	AbSLFZtojViPzJTFsEnVmvOpKjzW+8sQ1oxkqmGDeFfmO6BUSTdMlOdUW47KCr5pCEg1dCvdnnk
	sXqlmuckixOrJW8zdWG6ARb1ENLE=
X-Google-Smtp-Source: AGHT+IEBybnIF5K9wCf/EnvmIcG8fruNpEyQUW1zRB3WiNZru87p6saoKu+vyT0F6UmXkWqI6c2wiJQkHfUvBe8Ao6Q=
X-Received: by 2002:a05:6830:6dc3:b0:71e:1ff9:e91b with SMTP id
 46e09a7af769-726f1dc61c5mr2182723a34.27.1739368641324; Wed, 12 Feb 2025
 05:57:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208162210.3929473-1-superm1@kernel.org> <20250208162210.3929473-5-superm1@kernel.org>
 <CAJZ5v0j4+8nqQRtcAihpVgOHWUPE54nTWienCpFk1U7easVPnA@mail.gmail.com>
 <4e6cc95f-90dd-4f55-bb53-50de7d280d62@kernel.org> <dcbcbee9-7f1b-43ea-90ee-f863f4c6687f@gmx.de>
In-Reply-To: <dcbcbee9-7f1b-43ea-90ee-f863f4c6687f@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Feb 2025 14:57:10 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jmYda_OiFQTrtca-Z=W=AL5L-5gnsEE6oj_MoubW5fXA@mail.gmail.com>
X-Gm-Features: AWEUYZlcsdhBGkKJiVsCaizffxhm0HrhtyYkEr3XyR0cwGyyDI7sGGkf-UkxlB4
Message-ID: <CAJZ5v0jmYda_OiFQTrtca-Z=W=AL5L-5gnsEE6oj_MoubW5fXA@mail.gmail.com>
Subject: Re: [PATCH 4/4] ACPI: battery: Wake system on AC plug or unplug in
 over s2idle
To: Armin Wolf <W_Armin@gmx.de>, Mario Limonciello <superm1@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	"open list:ACPI" <linux-acpi@vger.kernel.org>, 
	"open list:HIBERNATION (aka Software Suspend, aka swsusp)" <linux-pm@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 2:49=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 09.02.25 um 14:14 schrieb Mario Limonciello:
>
> >
> >
> > On 2/8/25 11:59, Rafael J. Wysocki wrote:
> >> On Sat, Feb 8, 2025 at 5:22=E2=80=AFPM Mario Limonciello <superm1@kern=
el.org>
> >> wrote:
> >>>
> >>> From: Mario Limonciello <mario.limonciello@amd.com>
> >>>
> >>> On Windows the OS will wake up when plugged or unplugged from AC
> >>> adapter.
> >>> Depending upon whether the system was plugged in or unplugged will
> >>> determine whether the "display turns on".  If there is no user activi=
ty
> >>> for some time then it goes back to sleep.
> >>>
> >>> In Linux plugging or unplugging an adapter will wake the SoC from HW
> >>> sleep but then the Linux kernel puts it right back into HW sleep
> >>> immediately unless there is another interrupt active (such as a PME o=
r
> >>> GPIO).
> >>>
> >>> To get closer to the Windows behavior, record the state of the batter=
y
> >>> when going into suspend and compare it when updating battery status
> >>> during the s2idle loop. If it's changed, wake the system.
> >>>
> >>> This can be restored to previous behavior by disabling the ACPI batte=
ry
> >>> device `power/wakeup` sysfs file.
> >>
> >> Why is this desirable?
> >>
> >> What if the AC is connected to a suspended laptop when the lid is
> >> still closed?  Is it really a good idea to resume it then?
> >
> > Yes; that's the exact situation I wanted this to work.  I have a dock
> > connected to some monitors, power supply, keyboard, and mouse.  I want
> > the machine to wake up when it's connected to the dock but still closed=
.
> >
> > That's how Windows works at least.
> >
> >>
> >> Frankly, I'd prefer the existing behavior to be still the default.
> >
> > Since this is hooking into the existing wakeups that can happen for
> > battery I guess that there isn't a good way to configure one but not
> > the other.
> >
> > Would it be better to do something similar in the ACPI power supply
> > device?
>
> Hi,
>
> i believe that handling the wakeup inside the ACPI power supply device wo=
uld make more sense, because the current patch will also cause the machine =
to wake up
> if the battery has finished charging. This behavior would be quite counte=
rintuitive.

Good point.

Also, in Linux there is a concept of "system wakeup devices" which
IIUC is not present in (current) Windows, at least not in this form.
That is, the user can select devices that are allowed to wake up the
system from sleep via the /sys/dev/ces/.../power/wakeup attributes
(all wakeup-capable devices should have them).

If this is enabled, device_may_wakeup() returns true and this is the
case when the given device is expected to wake up the system from
sleep.

