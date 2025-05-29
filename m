Return-Path: <linux-acpi+bounces-13940-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1071EAC803B
	for <lists+linux-acpi@lfdr.de>; Thu, 29 May 2025 17:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D60941C05D9A
	for <lists+linux-acpi@lfdr.de>; Thu, 29 May 2025 15:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BD322CBE2;
	Thu, 29 May 2025 15:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UF+SWu1I"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F337122B5BC;
	Thu, 29 May 2025 15:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748532151; cv=none; b=Ls6Iisrwjk+Fx1b16NwgD+yLrjCvrs79dBxIOgCmXn2yodFeaPM1aEWvOi9ZKQvFu3xlqg5JHfXC/NOJ8UAtmCxpV/1toriBjqE9YKArJFQAajNsz6GYfcZmZLTT7cgY9PlV3xTezarIgpiYhazp4V0VazgtlEv7E1jiJe/ugpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748532151; c=relaxed/simple;
	bh=SadFqsuZhoGwR6YAWkirrQuAxEda7XZWIKw1aFQcYak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rX4TlQGYr2qnEEaibTH/5wz8qFjkN3AGRzA413Vod1ADvJ6oRIdRq0TPchf1LBfgohgNlnLuIg8R2+fEX3R8lHTXBYMkfANgayDi2Dgk7f8iFIcfD6HgH0jgCRHSfl5cEBwnEeiA+RmPD1HyM6QPeTXTdjRP45V/AZgliq/cZ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UF+SWu1I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7640DC4AF09;
	Thu, 29 May 2025 15:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748532150;
	bh=SadFqsuZhoGwR6YAWkirrQuAxEda7XZWIKw1aFQcYak=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UF+SWu1IAT6fOkpT7v77kYvVPrVpEUcpYw8okqjHX866lsjcv83rjGo3QMP8Lmi2f
	 YLGTAnN47oENpJNhRCKexvvB32noKfWh5uumpq9FCNC2Qy8W0FR8ZYLhMvI7Doa4fp
	 vp/KFoR13uLazNlpWm//OF8adMba5gTcueCnI6mcb0H1oXEfFR9sn6z3tpz83Zbp83
	 /TK3S3rastwbcoutJlqX/iCyJJhF6q+K+qFS9R+NuH5pqAGqlyOfb5CkBoTauGtXSZ
	 +iwVthHWxR5IHVzT8/dkyNL6iBVwikvTms8ZoRHGgZJoo66tqZz6j0xiSCtOROzf/l
	 jMw6GcMe6VFjA==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4064950cae4so556849b6e.2;
        Thu, 29 May 2025 08:22:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWixThi2OTRsj2qPseEgmbiHq3rpHa9IYrzwFIcZs7h++cNRgWShZCynB4xsZF++6R4YmIGLkqmSOlj@vger.kernel.org, AJvYcCXFa15XvYsdE0IMGTrCVeEnyEzedutyJcRc/5uUucGakkTP+CXqJ+704zfOQyBpNJYgP+11/E3fMmTHpY9C@vger.kernel.org
X-Gm-Message-State: AOJu0YzNjIFHNY/HmYtcTL1RrGdTjPuog0bN8smQe/gkxEDtNjGyeNzH
	3rsvEDI1h5ig75T62ShBuuJaADMHQcENGmMbzuDPism4mi4yP6fTcLFPEEQBR+aBp4TFbYiGvDT
	eFuWM1Ig9Vr1BhAdxqQbfdLKQ9EQ6q7w=
X-Google-Smtp-Source: AGHT+IEQz59ce5knxZS6Wfn79ML3SNb0NpVwpYS0CMfEWiRuspMtan8xdT7zcgrMvfRJiOCQ2oiscfwlf9JhBGqWyNo=
X-Received: by 2002:a05:6808:3c46:b0:406:6871:22e8 with SMTP id
 5614622812f47-406707a072amr1474609b6e.17.1748532149735; Thu, 29 May 2025
 08:22:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsOCGWeZgzsXwSSOFqNxetsJhRbvqHCSG1iuQ7jMuFdo8g@mail.gmail.com>
 <vkrdaqakxid6b4cmeknygxxstx2zerzuarryzwl66unce7jwe3@hbrlelzs4p7v>
In-Reply-To: <vkrdaqakxid6b4cmeknygxxstx2zerzuarryzwl66unce7jwe3@hbrlelzs4p7v>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 May 2025 17:22:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iKQx+6U1LiRNpOQ05UCStda_rVBM+zo3Q74tozYYah+Q@mail.gmail.com>
X-Gm-Features: AX0GCFt_kWiOgA0l0dwOgmGt8zkz_2KniogLoyKtzNGX32bogpII4v-EEQKSf1o
Message-ID: <CAJZ5v0iKQx+6U1LiRNpOQ05UCStda_rVBM+zo3Q74tozYYah+Q@mail.gmail.com>
Subject: Re: 6.16-rc0/regression/bisected - commit ebf27765421c introduced a
 new warning KASAN: global-out-of-bounds in acpi_ut_safe_strncpy+0x1b
To: Ahmed Salem <x0rw3ll@gmail.com>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, rafael.j.wysocki@intel.com, 
	linux-acpi@vger.kernel.org, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 5:15=E2=80=AFPM Ahmed Salem <x0rw3ll@gmail.com> wro=
te:
>
> Hi Mike,
>
> On 25/05/29 07:17PM, Mikhail Gavrilov wrote:
> > Hi,
> >
> > Yesterday, after booting fresh kernel feacb1774bd5,
> > I spotted a new error message in the kernel log with the following stac=
k trace:
> >
> > [    3.032828] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [    3.032832] BUG: KASAN: global-out-of-bounds in
> > acpi_ut_safe_strncpy+0x1b/0x60
> > [    3.032839] Read of size 16 at addr ffffffffa9d32760 by task swapper=
/0/1
> >
> > [    3.032846] CPU: 16 UID: 0 PID: 1 Comm: swapper/0 Not tainted
> > 6.15.0-feacb1774bd5+ #2 PREEMPT(lazy)
> > [    3.032849] Hardware name: ASUS System Product Name/ROG STRIX
> > B650E-I GAMING WIFI, BIOS 3222 03/05/2025
> [snip]
> > git blame says the first bad commit is ebf27765421c:
>
> That is correct. This was a very shortsighted and uninformed commit on
> my part, and we had this very same discussion on upstream ACPICA. Kernel
> test robot also reported the same issue earlier[1].
>
> The issue was that I mistakenly switched to `memcpy` in the
> `acpi_ut_safe_strncpy` function in drivers/acpi/acpica/utnonansi.c, which
> would have caused the buffer to be terminated one byte shorter than it
> should really be. It's been rectified since, and should be pulled back
> into mainline once it's cleared. I do apologize for the massive
> inconvenience!
>
> Rafael, is there a possibility this upstream commit[2] gets pulled into
> mainline before the next cycle?
>
> Link:
> https://lore.kernel.org/oe-lkp/202505081033.50e45ff4-lkp@intel.com/ [1]
> Link:
> https://github.com/acpica/acpica/pull/1024/commits/b90d0d65ec97ff8279ad82=
6f4102e0d31c5f662a
> [2]

Sure.  Thanks for the pointer.

> >
> > commit ebf27765421c9238b7835d32a95e4a7fb8db26a4
> > Author: Ahmed Salem <x0rw3ll@gmail.com>
> > Date:   Fri Apr 25 21:32:12 2025 +0200
> >
> >     ACPICA: Replace strncpy() with memcpy()
> >
> >     ACPICA commit 83019b471e1902151e67c588014ba2d09fa099a3
> >
> >     strncpy() is deprecated for NUL-terminated destination buffers[1].
> >
> >     Use memcpy() for length-bounded destinations.
> >
> >     Link: https://github.com/KSPP/linux/issues/90 [1]
> >     Link: https://github.com/acpica/acpica/commit/83019b47
> >     Signed-off-by: Ahmed Salem <x0rw3ll@gmail.com>
> >     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >     Link: https://patch.msgid.link/1910878.atdPhlSkOF@rjwysocki.net
> [snip]
> >  drivers/acpi/acpica/utnonansi.c | 2 +-
> >
> > And yes, I can confirm this catch.
> > The kernel with ebf27765421c reverted no longer triggers this error mes=
sage.
> >
> > > sh /usr/src/kernels/6.16.0-0.rc0.250528gfeacb1774bd5.5.fc43.x86_64+de=
bug/scripts/faddr2line /lib/debug/lib/modules/6.16.0-0.rc0.250528gfeacb1774=
bd5.5.fc43.x86_64+debug/vmlinux acpi_ut_safe_strncpy+0x1b
> > acpi_ut_safe_strncpy+0x1b/0x60:
> > acpi_ut_safe_strncpy at drivers/acpi/acpica/utnonansi.c:172
> >
> > Ahmed, Let me know if you need further logs or help reproducing.
>
> Thank you so much! No further action's needed on your part, and I
> appreciate your effort, sincerely!
>
> --
> Best regards,
> Ahmed Salem
> >
> > Full hardware specs are here:
> > https://linux-hardware.org/?probe=3D1244406425
> >
> > I=E2=80=99m also attaching build config, full bisect logs, and kernel l=
ogs
> > from each bisect step in archives.
> >
> > --
> > Best Regards,
> > Mike Gavrilov.
>
>
>

