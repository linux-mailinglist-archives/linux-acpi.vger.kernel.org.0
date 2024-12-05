Return-Path: <linux-acpi+bounces-9939-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7240B9E5321
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 11:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CD1C16721B
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 10:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3348C1DACBB;
	Thu,  5 Dec 2024 10:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpHHat8j"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013B71DA634;
	Thu,  5 Dec 2024 10:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733396223; cv=none; b=Q4rJW9FqWiorM6NCgjtAI+gWV3Ze0+35WHIlX/LGtAoInNR9y9HBYNfCq6YVJgRsc0CRGdktyeZz9unzOv9STunLAnu4Du9wCqfWOwWmiDWyxkOQxdiN6xQDnx4bB0LLfDiRDjnX41AMuW4UXs9AOEUXyfp0mS62T2izVyTMtt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733396223; c=relaxed/simple;
	bh=6kRllVnfwcu5TGBiLiC1h5yQU5pzrxdhDoaU3LZA5sQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQpO+VnWtfZzUNpIYDxEZMHvkShCQmtvcnCNlBTo5aIytbj3VNFCvpg0AVlc7Y6BDzWEqE0DSdEOy8O45i1G0iPrr8OBm2T1WRS8OtE64NEG43Zg8+cU/ItUevDDG3ljpO19hkYUUnJM1CRxYSztrY6OLZgnyst6NbRyw3IGI1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpHHat8j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82246C4CEDE;
	Thu,  5 Dec 2024 10:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733396222;
	bh=6kRllVnfwcu5TGBiLiC1h5yQU5pzrxdhDoaU3LZA5sQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LpHHat8jlUvC2RvdsBaxsPhWFrR5FOi0j2bh+OmZIqrLXRS29BhPJhHeTatXihsfK
	 a5r0QhoeB2fdziyY0nzIMQK4g/f4c65WLoGAeGncHH3PEpyPtKmIkBjzZK8tDlL8fT
	 1JkF/Lka1XJtVRmQylp2yqfkAyfCzF/DKr3o/VeUhX3YF40CSLFrnzXIQC/hKl656Y
	 7OOL9iHPBUe5KywfPpmjr95oGrxxrkOD+2FCBYCIzMlLvqVzgjcIfahqSPyd5bhKAN
	 UH2bbTkg5p1XSVG+ZjwoaTEyRtaVB2OnVzq3Hs3vDJYvWA7K3TDwle6Nk+QrMdNTnI
	 FTs6rRHC0yl5g==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-29e2e768952so555706fac.3;
        Thu, 05 Dec 2024 02:57:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU6GMaALuqWdqVqpNU9Tqgh6hdMABtVUslHDKOGECys9jbLf+hzG9p4vXFwq1xToXEl/VNmx4MyzXU=@vger.kernel.org, AJvYcCVE3xz3WXicXoRJTaot+kaYZrJwgmgMuq4FNzuxnWd9cTbjP/ACpnbYUsPsCVIBiLFlBGIfg4wIMUCug7Mm@vger.kernel.org, AJvYcCVK+EoTgVqQN3SFO3Q7T443xR/AJM1vvBEPHbJhJeX4P72b1/BJ84nMnNzMXpkeNK43nB6cuOFpWe46@vger.kernel.org
X-Gm-Message-State: AOJu0YzjBgUxc7iFPJrkvr8WJvAwlUaZHRChmQMfv2ZsL51iHoBD7k0E
	ngbi/X78VYB73Ed1vjMMxYrL3gTbkp1JwzF8t7Y8AaMxLrvtzKHAHE5uybcLKENzWf7It3OnVEr
	JiCsFP9/rBczG42Ajyk+My46Xmk8=
X-Google-Smtp-Source: AGHT+IEBhDb774kuTMEXvIw3iQI6Z6uT2XhUQ6Oq/3PIm7kHDHLw4Lr3Y9TLCfDOBFAM4M1j1i5HAhTilnR+x2ZiLBs=
X-Received: by 2002:a05:6870:798f:b0:29e:3701:47c3 with SMTP id
 586e51a60fabf-29e8891ba52mr8780289fac.42.1733396221840; Thu, 05 Dec 2024
 02:57:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5839859.DvuYhMxLoT@rjwysocki.net> <CAJvTdKm4Fermz1zgTWohEGSoGpoB3CJL2FF-u6y9FAEBwBbcnQ@mail.gmail.com>
In-Reply-To: <CAJvTdKm4Fermz1zgTWohEGSoGpoB3CJL2FF-u6y9FAEBwBbcnQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 5 Dec 2024 11:56:50 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hyY6v2ZV-h0KMX_ehmJa38K1oQgSnNU4Mvab2Vv8y=-A@mail.gmail.com>
Message-ID: <CAJZ5v0hyY6v2ZV-h0KMX_ehmJa38K1oQgSnNU4Mvab2Vv8y=-A@mail.gmail.com>
Subject: Re: [RFC/RFT][PATCH v0.1] ACPI: OSL: Use usleep_range() in acpi_os_sleep()
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Len Brown <len.brown@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Hans de Goede <hdegoede@redhat.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 10:41=E2=80=AFPM Len Brown <lenb@kernel.org> wrote:
>
> On Thu, Nov 21, 2024 at 8:15=E2=80=AFAM Rafael J. Wysocki <rjw@rjwysocki.=
net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > As stated by Len in [1], the extra delay added by msleep() to the
> > sleep time value passed to it can be significant, roughly between
> > 1.5 ns on systems with HZ =3D 1000 and as much as 15 ms on systems with
> > HZ =3D 100, which is hardly acceptable, at least for small sleep time
> > values.
>
> Maybe the problem statement is more clear with a concrete example:
>
> msleep(5) on the default HZ=3D250 on a modern PC takes about 11.9 ms.
> This results in over 800 ms of spurious system resume delay
> on systems such as the Dell XPS-13-9300, which use ASL Sleep(5ms)
> in a tight loop.

Sure, I can add this information to the changelog.

> (yes, this additional cost used to be over 1200 ms before the v6.12
> msleep rounding fix)
>
> > -       msleep(ms);
> > +       u64 usec =3D ms * USEC_PER_MSEC, delta_us =3D 50;
>
> > +       if (ms > 5)
> > +               delta_us =3D (USEC_PER_MSEC / 100) * ms
>
> I measured 100 resume cycles on the Dell XPS 13 9300 on 4 kernels.
> Here is the measured fastest kernel resume time in msec for each:
>
> 1. 1921.292 v6.12 msleep (baseline)
> 2. 1115.579 v6.12 delta_us =3D (USEC_PER_MSEC / 100) * ms (this patch)
> 3. 1113.396 v6.12 delta_us =3D 50
> 4. 1107.835 v6.12 delta_us =3D 0
>
> (I didn't average the 100 runs, because random very long device
> hiccups  throw off the average)
>
> So any of #2, #3 and #4 are a huge step forward from what is shipping tod=
ay!
>
> So considering #2 vs #3 vs #4....
>
> I agree that it is a problem for the timer sub-system to work to
> maintain a 1ns granularity
> that it can't actually deliver.
>
> I think it is fine for the timer sub-system to allow calls to opt into
> timer slack --
> some callers may actually know what number to use.
>
> However, I don't think that the timer sub-system should force callers to =
guess
> how much slack is appropriate.  I think that a caller with 0 slack
> should be internally
> rounded up by the timer sub-system to the granularity that it can
> actually deliver
> with the timer that is currently in use on that system.
>
> Note also that slack of 0 doesn't mean that no coalescing can happen.
> A slack=3D0 timer can land within the slack another timer, and the other
> timer will be pulled forward to coalesce.
>
> The 50 usec default for user timer slack is certainly a magic number born
> of tests of interesting workloads on interesting systems on a certain dat=
e.
> It may not be the right number for other workloads, or other systems
> with other timers on other dates.
>
> My opinion...
>
> I don't see a justification for increasing timer slack with increasing du=
ration.
> User-space timers don't pay this additional delay, why should the ASL
> programmer?
>
> Also, the graduated increasing slack with duration is a guess no more
> valid than the guess of a flat 50 usec.
>
> A flat 50 or a flat 0 have the virtue of being simple -- they will be sim=
pler
> to understand and maintain in the future.
>
> But I can live with any of these options, since they are all a big step f=
orward.

All right, thanks!

