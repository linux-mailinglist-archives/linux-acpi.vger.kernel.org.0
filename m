Return-Path: <linux-acpi+bounces-19527-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D72E6CB1489
	for <lists+linux-acpi@lfdr.de>; Tue, 09 Dec 2025 23:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B78330C4071
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Dec 2025 22:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B31B2E6CD8;
	Tue,  9 Dec 2025 22:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXu0jcvm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764372E613B
	for <linux-acpi@vger.kernel.org>; Tue,  9 Dec 2025 22:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765319021; cv=none; b=d1/xGTPCjtnEcih4v24e+jfkTKQ1pWzSvPZc7x5SlEDls8V678tzjV/1eKaJPcoCQa9SEEjUwRBW3puikBoqsRAo7xCT+sMWxx80BrQuCVPDx1GrMhFnEZkNGj/ZVfZaxjSl+7lV1de8Waqc1Bm4fblcQEcNvWE7rMo75+qsEZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765319021; c=relaxed/simple;
	bh=XH7iFzVndiDecbAbmxtWIrlTlocj+lZPgt+eMTMBozw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SeNRy9q1XOVnDaNo/ZOXubGY4/q0OikKOPQ+4jHGdbsSs+VfHmRNiqeQPc05Zc7Eb36IE7mfNwxeao3GR7o/mhPYGhuje124jfzYDO0rtuAqcxk/vJxNnPuwaQK2f20xCOY8u/XeJNpYoSxfwUy9Cdo4m08WiRgi//+HWwct30I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXu0jcvm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B1EC4CEF5
	for <linux-acpi@vger.kernel.org>; Tue,  9 Dec 2025 22:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765319021;
	bh=XH7iFzVndiDecbAbmxtWIrlTlocj+lZPgt+eMTMBozw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FXu0jcvm4Os/NHNv3X6KyNSS7IaA3tRvLefRbT+b1DLO/b7trHB6RDPdq2M0rUPi1
	 4Aj0UgsvWRkV2Jl8xouqkKN4hn9n+DXwQCwaz/IR8vZFNKa+DfSB2B8cl3csXNzkm0
	 F2Ddc2ZWyggcaXQRgNpn3qOZkblfLnOkUTHUuIkxf0nBqRJbActS/EwFecKeD25N3e
	 yt4tZM48uOEuBdjbIXKPLjJtHcwzFPXiSFVICuXVP4vn5kxFMnGMga+I2rHtLODzYW
	 UfkiYZgdMaj6DtORXVQxQr36VzGDdWKCbudY6yeeFJJZHVX8Ba+VfLmVyIsR+TbhXU
	 SFei+/kCJ5kuQ==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-450be85b7d9so2825626b6e.0
        for <linux-acpi@vger.kernel.org>; Tue, 09 Dec 2025 14:23:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWZ6DyyGcn3vUUhJ/AT5vgw0H7hSQa9frSTENRw3dawEronvXxThzLNX2fLk/M1m1nqT4N+C8e4Wq5C@vger.kernel.org
X-Gm-Message-State: AOJu0YzAdLlMEQv0u+z3AWjBQ2cYqvT7apPskiQuzrlVSwdPdRKeKlm8
	rlHI6lQVy6pz74SEW/FQr1XwgmhfKkPi/PcsGA18IP04jVnW+sErXAoith1MhQl74Ej3VjEZBgc
	KeFhIDxzcevb0TKjemQf9m8QTxfXNquc=
X-Google-Smtp-Source: AGHT+IFFQy8pcgswLc2NI271PGrAcDWBNe+mUBRtDSlr9Sf7Ms88xdJ4CzEL74bJfQiw5XpeTomqHuqRk9ScWNZGieQ=
X-Received: by 2002:a05:6808:5191:b0:44d:a0ec:d9a5 with SMTP id
 5614622812f47-4558635f941mr299477b6e.1.1765319020155; Tue, 09 Dec 2025
 14:23:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202043416.2310677-1-dmitry.osipenko@collabora.com>
 <20251202043416.2310677-2-dmitry.osipenko@collabora.com> <CAJZ5v0hRiA_AFTsBL0Ud5vdDyyqSJcwLtKaVtpYareh4URS_CQ@mail.gmail.com>
 <479b4a5a-a792-4d3d-8bf1-59ef296b7e96@collabora.com> <CAJZ5v0h_8aA+VwBb5B1tKn5Y0Herb3dG=Qjy1uueA4V83FUcCg@mail.gmail.com>
 <CAGwozwF4Xv=ePdHhF6B6dFgHUES1vyoU6f5KrrzM7pU8tao2Gg@mail.gmail.com>
 <CAJZ5v0i63EwNxaYU8S9W5a3jpzQtCNxTH+0hsjO_xLf_wXd1Qw@mail.gmail.com>
 <CAGwozwHd5196hr7Ckvh9wVJiyw0MBUriz+oqNWhOSkEYbCVMtQ@mail.gmail.com>
 <CAJZ5v0j71mic4y2+TjZyNKe6NbSA8B74WHdyh_AxC-rZkQND5A@mail.gmail.com>
 <CAJZ5v0j3wNtqYQDsVr+74-Gn-WM9FDmoqxrLULVD+UJtfVgLtQ@mail.gmail.com>
 <CAGwozwEgfH+QRpBXNGhZG5hxNF28A3ALbrABGYJg7RuFKDrM0A@mail.gmail.com> <9e663a52-691c-4387-85b7-73e7f51086de@collabora.com>
In-Reply-To: <9e663a52-691c-4387-85b7-73e7f51086de@collabora.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 9 Dec 2025 23:23:28 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hCXGL7Zc1=x3utjhMMRMLyyb+7icetMdkJu0ngThd9iw@mail.gmail.com>
X-Gm-Features: AQt7F2qEzvTuTLl18s_5nVQjhOvbKS-Onrh-1RNCSnIvt6oGefeClD_RPQTWEdM
Message-ID: <CAJZ5v0hCXGL7Zc1=x3utjhMMRMLyyb+7icetMdkJu0ngThd9iw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] ACPI: PM: s2idle: Add lps0_screen_off sysfs interface
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Antheas Kapenekakis <lkml@antheas.dev>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Mario Limonciello <superm1@kernel.org>, Robert Beckett <bob.beckett@collabora.com>, 
	linux-acpi@vger.kernel.org, kernel@collabora.com, 
	linux-kernel@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Xaver Hugl <xaver.hugl@gmail.com>, 
	Richard Hughes <richard@hughsie.com>, William Jon McCann <mccann@jhu.edu>, 
	"Jaap A . Haitsma" <jaap@haitsma.org>, Benjamin Canou <bookeldor@gmail.com>, 
	Bastien Nocera <hadess@hadess.net>, systemd-devel@lists.freedesktop.org, 
	Lennart Poettering <lennart@poettering.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 11:14=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> ...
> >> So let me repeat for extra clarity.
> >>
> >> The only change related to the LPS0 "screen off" and "screen on"
> >> notifications that would be tentatively acceptable to me ATM, would be
> >> to modify the suspend-to-idle flow to do the "screen off" notification
> >> earlier (possibly even at the start of it) and the corresponding
> >> "screen on" notification later (possibly at the end of it), provided
> >> that one can convincingly argue that this should not introduce
> >> regressions.
> >>
> >
> > From what I recall that was my original plan.
> >
> > Yeah, it is a fair way forward. @Dmitry how would you like to approach
> > this? SInce you re-started the discussion. What is your timeline/KPIs
> > for this.
> >
> > I could personally try to whip up a small series after the merge
> > window by rewriting what I have[1]. I have more experience now in
> > drafting this kind of thing and that series added some cruft to the pm
> > core with multiple additions to platform_s2idle_ops
> >
> > There is a _small_ quantitative difference due to moving the calls.
> > Specifically, the power light responds a tad slower when waking a
> > device. For the legion go (non-s) devices, Lenovo added a dummy 5
> > second timer to resuming the controllers because of some Windows bugs,
> > and moving the calls causes the timer to start later. But that's the
> > OEM intended behavior...
> >
> > Antheas
> >
> > [1] https://github.com/bazzite-org/patchwork/commits/pm-bleeding/modern=
-standby/
>
> Am I understanding correctly that the plan is to have a 2-stage freezer
> for suspend-to-idle + standby mode? Rafael, could you please confirm
> that you're fine with this 2-stage freezer part of the proposal from
> Antheas?

I still need to get to the details there, but I don't think that a
2-stage freezer is a good idea.  There is enough fragility in the
freezer that we have already.

> What you expect to be a proper way of implementing a 2-stage freezer?
> Would it be a new executable capability, a new syscall or extension of
> existing one, a new cgroup type? How would you mark processes that
> should not be frozen on the first stage? Or it would be only the process
> that writes to /sysfs/power?
>
> Thanks everyone for the very detailed input. It is all very productive,
> helps a lot with adjusting my understanding of the modern suspend feature=
s.
>
> Agree that the usefulness of the visual aspect of the Display
> notification is questionable. Previously I thought this mode involves
> power-limiting. The Sleep notification might be much more interesting the=
n.

Well, the problem is that the Sleep notification has ordering
assumptions AFAIK and it really cannot be triggered from user space.

All really depends on what the goal is, but in any case I think that
the required preliminary step would be to move the "screen off" and
"screen on" notifications in the current suspend-to-idle flow, so they
occur earlier and later, respectively.

