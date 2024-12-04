Return-Path: <linux-acpi+bounces-9922-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 782E69E470A
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Dec 2024 22:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53BFB16790F
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Dec 2024 21:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D1E1922C6;
	Wed,  4 Dec 2024 21:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtnTQzqc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EF918FC9F;
	Wed,  4 Dec 2024 21:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733348517; cv=none; b=Jj27IQdOeAkYzqJvjkbRS+ccS17c1jyl0S8GyZyNdG0M3YLInb7WxlZOhPS0yCl2JLoCrv7R7MWtumO97V045vj7ZqsMRDhdADQSKsejs2QO6Q1xrlhI5KLnWOpcPtykigw0OIjUXwnm6dxpR1i86/NLYn1IJJQEfdixlbVE21w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733348517; c=relaxed/simple;
	bh=L+MXiSrlAdeLzXu2q7KS7LTJbiV6hJ7FNtxsnAgyNcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SiPv5gXTclDfsijcWSdmRaK1BFhgvRxgKk7qQXtw3kyKlMOO5feEsQujkDMWj7fvFcVvkHv1LfBnAQVnuTCTyGIqQMV7G0c6sGX6krdOc9X9FavY/ZuU7AtOxZnABLpVs9glJv+2J/ArbB3seO++iJsnj5FdCCmIkkacE3xwrL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtnTQzqc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47428C4AF09;
	Wed,  4 Dec 2024 21:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733348516;
	bh=L+MXiSrlAdeLzXu2q7KS7LTJbiV6hJ7FNtxsnAgyNcc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GtnTQzqcklmOErMSkXxjbNWK7Ek5JkdzQJKWaDrPjZ5zbDC/BZdbJ4q2M9CFGnwfJ
	 pYegjtrE8zKvicVOQkY9RqlNe8/x3BQ6FPaxQJpWafpy4v/YytZV96cjW4UzoEaW31
	 3fd+GXymWy3vGOVLYGoBj5f8NJNncThN7zOVQK/KlEvgRl/43DWI692B2S2cGhbpCC
	 /chZWbWXbVWAYUA+Zr+7+k3L9TBNMEjj/nplo5KEn2rHuC9L339RXOZJr2PKe/XPBp
	 Btam+AgdvJjcPLk8ACS7FVCyYoV2QOgwuf6I2NT58KSPLvtdXxBHwlA/KEVz6hp8XU
	 dfFZYS2/nn0zQ==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3ea49150430so207402b6e.1;
        Wed, 04 Dec 2024 13:41:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/hF19VJRR3IWBCTCAXb0M5MfxG4bZdoKsjiwQe8u+3pksE1LeZsYOcg5pnmrtHLjvUHwN94GvWvjPkK0=@vger.kernel.org, AJvYcCW2o7XT6mOFjUUqjM5CPI/kx5Yi6AHbKGvbpivr3XNHAqc+3zou1LHU2p6dyEL+ZCtS1yUPTOnT90Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIqKHnfsDf8wpGaOkPHVISzeezYp9QV3aqSMrdU646iujD/JFM
	0ZIZjGvcqcpOyhui3xShDlM0uT1+VR6MnHkoVmocKzRC72xcGMfGRVHbYBCm2iq4CDAlzu2r7Bj
	ubR7p+JGgWktGoe2+mUeDuKP8OpI=
X-Google-Smtp-Source: AGHT+IE2Y9fFiN5Lqdk+EEY5xp07PQODyKcqal+d0LX+D3tS2vLCiPjO3uaVoBhtjCh3hIVLrk3A++1UpJqLGOy5oAo=
X-Received: by 2002:a05:6808:1c0d:b0:3ea:4bcc:4d9b with SMTP id
 5614622812f47-3eae4f3b758mr10479653b6e.18.1733348515605; Wed, 04 Dec 2024
 13:41:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5839859.DvuYhMxLoT@rjwysocki.net>
In-Reply-To: <5839859.DvuYhMxLoT@rjwysocki.net>
From: Len Brown <lenb@kernel.org>
Date: Wed, 4 Dec 2024 16:41:43 -0500
X-Gmail-Original-Message-ID: <CAJvTdKm4Fermz1zgTWohEGSoGpoB3CJL2FF-u6y9FAEBwBbcnQ@mail.gmail.com>
Message-ID: <CAJvTdKm4Fermz1zgTWohEGSoGpoB3CJL2FF-u6y9FAEBwBbcnQ@mail.gmail.com>
Subject: Re: [RFC/RFT][PATCH v0.1] ACPI: OSL: Use usleep_range() in acpi_os_sleep()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, 
	Arjan van de Ven <arjan@linux.intel.com>, Pierre Gondois <pierre.gondois@arm.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Hans de Goede <hdegoede@redhat.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 8:15=E2=80=AFAM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> As stated by Len in [1], the extra delay added by msleep() to the
> sleep time value passed to it can be significant, roughly between
> 1.5 ns on systems with HZ =3D 1000 and as much as 15 ms on systems with
> HZ =3D 100, which is hardly acceptable, at least for small sleep time
> values.

Maybe the problem statement is more clear with a concrete example:

msleep(5) on the default HZ=3D250 on a modern PC takes about 11.9 ms.
This results in over 800 ms of spurious system resume delay
on systems such as the Dell XPS-13-9300, which use ASL Sleep(5ms)
in a tight loop.

(yes, this additional cost used to be over 1200 ms before the v6.12
msleep rounding fix)

> -       msleep(ms);
> +       u64 usec =3D ms * USEC_PER_MSEC, delta_us =3D 50;

> +       if (ms > 5)
> +               delta_us =3D (USEC_PER_MSEC / 100) * ms

I measured 100 resume cycles on the Dell XPS 13 9300 on 4 kernels.
Here is the measured fastest kernel resume time in msec for each:

1. 1921.292 v6.12 msleep (baseline)
2. 1115.579 v6.12 delta_us =3D (USEC_PER_MSEC / 100) * ms (this patch)
3. 1113.396 v6.12 delta_us =3D 50
4. 1107.835 v6.12 delta_us =3D 0

(I didn't average the 100 runs, because random very long device
hiccups  throw off the average)

So any of #2, #3 and #4 are a huge step forward from what is shipping today=
!

So considering #2 vs #3 vs #4....

I agree that it is a problem for the timer sub-system to work to
maintain a 1ns granularity
that it can't actually deliver.

I think it is fine for the timer sub-system to allow calls to opt into
timer slack --
some callers may actually know what number to use.

However, I don't think that the timer sub-system should force callers to gu=
ess
how much slack is appropriate.  I think that a caller with 0 slack
should be internally
rounded up by the timer sub-system to the granularity that it can
actually deliver
with the timer that is currently in use on that system.

Note also that slack of 0 doesn't mean that no coalescing can happen.
A slack=3D0 timer can land within the slack another timer, and the other
timer will be pulled forward to coalesce.

The 50 usec default for user timer slack is certainly a magic number born
of tests of interesting workloads on interesting systems on a certain date.
It may not be the right number for other workloads, or other systems
with other timers on other dates.

My opinion...

I don't see a justification for increasing timer slack with increasing dura=
tion.
User-space timers don't pay this additional delay, why should the ASL
programmer?

Also, the graduated increasing slack with duration is a guess no more
valid than the guess of a flat 50 usec.

A flat 50 or a flat 0 have the virtue of being simple -- they will be simpl=
er
to understand and maintain in the future.

But I can live with any of these options, since they are all a big step for=
ward.

thanks,
Len Brown, Intel Open Source Technology Center

