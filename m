Return-Path: <linux-acpi+bounces-19456-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCF9CA9339
	for <lists+linux-acpi@lfdr.de>; Fri, 05 Dec 2025 21:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0B23300CA09
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Dec 2025 20:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E792E228C;
	Fri,  5 Dec 2025 20:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgNOv53L"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1DB2D7DE4
	for <linux-acpi@vger.kernel.org>; Fri,  5 Dec 2025 20:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764965105; cv=none; b=IO7s1Z8BQYCrSyJ7srFRhvn7iw9zNnm2f/ZrLdaB8kDKVvpWBNBPH/DJ9MgQKyfjG4B50UD3f1sjGp8L8g0yRJ009xz6FTPwoaSTYFmT7X2KBougalpSFv65PP7FiLZuGTRwqj3K4sEXnuRrXE1D5sFvES/eQ68DH6RzBAunWKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764965105; c=relaxed/simple;
	bh=oJHWZmYtKtdGfN3/J0+9CqVQp/l/Yo60QjKeU7MrpMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pQE54FoY/bMWffawZ4QUYNltfVJXISI5UbNkNHUS0sO9cbVxFULe4aEBZYh1kkTJ0ioTrcVapj7du1Ei9f5H5Ea0P1nbYqdHtP1NC6PX+UDk4pmHFWsN0yKeBQczbIUCNlo3W9ZpeBGTuj5R5XfC2yJdMJ1ZQJY64J2cVipgOjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgNOv53L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1E4C4CEF1
	for <linux-acpi@vger.kernel.org>; Fri,  5 Dec 2025 20:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764965104;
	bh=oJHWZmYtKtdGfN3/J0+9CqVQp/l/Yo60QjKeU7MrpMI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YgNOv53L4Tf5fRqPP9KmIW9a8bEpcF7E+mmNzSCq/61sIhxrrLmmAleE0m1o+N8kE
	 o69pQQlUUsQizUv3YUVS6i09jlEAeaAczVHCEfHYpujmunMWUW8gKz8iR4fGmwEFlj
	 a1VvYEGbr4+GcQAQ3R9ZEN5ZMGqgCIiL73aftA2d6T3TvVHTXQxQAMI8UJG73v0kAG
	 NNjZZ9uvjDji/8IKlbgT6N31AFJ8KYjXAyXCukdzfErR6j1875e68ElqsHsbZiar5t
	 dWox3ZCaKq65RajVndO9yUPX+tTxKVl4j9TXp65Gpoqa6No2xDM2ChpJm19loCwyYh
	 P9xaCgkf/wTNw==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-3f53ec0af62so185417fac.1
        for <linux-acpi@vger.kernel.org>; Fri, 05 Dec 2025 12:05:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUbYAUMCyjh+XjDHlPlhuGZsgNodOQp97e2P2zJxNLuyRKI826UvVNrJeR3F25I4FPHdZ5dbRsreWjc@vger.kernel.org
X-Gm-Message-State: AOJu0YwUHonKpdicRvrVXZIX5BZkDf3W42ac92TlSus4NgkvLSvnNaG4
	Hdrw+cffbdnILYFpiQ/4HCWooAPGD4HAYdZA2nRE1Ab1vxWYHjHDjReP0W1NkI10VrwnbV033LD
	NAuI0cOZS4RTSp74f+RdQmGZISQck7CI=
X-Google-Smtp-Source: AGHT+IF8ywEfZxZLXkVtIM/e3tWaSoroi/5O82i2gzZNTSZ5+MDoELcyDDRG9RxrkUQnh3EY+xOxafTYgoR7d6vp/zM=
X-Received: by 2002:a05:6820:6ac3:b0:659:9a49:8e0e with SMTP id
 006d021491bc7-6599a99f180mr188350eaf.80.1764965104107; Fri, 05 Dec 2025
 12:05:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4f534cc70650111e420d5ac9040df4e546eed336.camel@linux.intel.com>
 <20251126170031.145b6a56@kf-m2g5> <20251203113851.52bf872b@kf-m2g5>
 <849e7394b8c7c4b74d1d55648a8d4b55b49aa91a.camel@linux.intel.com>
 <CAJZ5v0hUc3oz=Z8UUv3n4rY3on1vZpCtSdKjgOFp+OWYC5D9tw@mail.gmail.com> <c7bdb6cb02437d1ab41495d526c3d2ee3f1f7c60.camel@linux.intel.com>
In-Reply-To: <c7bdb6cb02437d1ab41495d526c3d2ee3f1f7c60.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Dec 2025 21:04:52 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h1JKg9i8yKuyuPnPToQij5d4Rv=87fE2yxHiY_U1NEOg@mail.gmail.com>
X-Gm-Features: AWmQ_bnePO3wgmS4yj2Utwk-w1FdPaCSvQdc45d18ZQ50BcgjKg69Hh_Wps14bQ
Message-ID: <CAJZ5v0h1JKg9i8yKuyuPnPToQij5d4Rv=87fE2yxHiY_U1NEOg@mail.gmail.com>
Subject: Re: [BUG] intel_pstate: CPU frequencies miscalculated/incorrectly
 detected on Arrow Lake hardware
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Aaron Rainbolt <arainbolt@kfocus.org>, 
	kernel-team@lists.ubuntu.com, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, rjw@rjwysocki.net, mmikowski@kfocus.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 8:50=E2=80=AFPM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Fri, 2025-12-05 at 20:28 +0100, Rafael J. Wysocki wrote:
> > On Fri, Dec 5, 2025 at 8:11=E2=80=AFPM srinivas pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > >
> > > Hi Aaron,
> > >
> > > On Wed, 2025-12-03 at 11:38 -0600, Aaron Rainbolt wrote:
> > > > On Wed, 26 Nov 2025 17:00:31 -0600
> > > > Aaron Rainbolt <arainbolt@kfocus.org> wrote:
> > > >
> > > >
> > > >
> > > ...
> > >
> > >
> > >
> > > There are too many platforms here, don't have time to get to all.
> > > So
> > > let's focus on one first.
> > >
> > > ## Clevo | X580WNT-G  | Ultra 9 275HX | 6.18.0-061800rc7-generic
> > >
> > > Summary:
> > > There is no scaling factor related issue as reported before on
> > > ASROCK
> > > platform before. The achieved maximum frequencies are correct.
> > >
> > > The base_freq display is wrong (see below because of BIOS config).
> > > The cpuinfo_max_freq wrong display is not related to scaling factor
> > > but
> > > something else
> > >
> > >
> > > To check, I need dump of:
> > > m=3D$(getconf _NPROCESSORS_ONLN); for ((i=3D0; i<m; i++)); do echo
> > > CPU$i;
> > > sudo rdmsr -p $i 0x771;  sudo rdmsr -p $i 0x774; done
> > >
> > > But I expect them to match the acpi_cppc/highest_perf, which is
> > > showing
> > > 3.9GHz.
> > >
> > > What command you to report " M-Test  . Id"?
> > >
> > > I think some busy 100% workload running on a single CPU.
> > >
> > >
> > >
> > > Analsis:
> > >
> > > Intel=C2=AE Core=E2=84=A2 Ultra 9 Processor 275HX
> > > 8+16 no HT
> > > Performance-core Base Frequency : 2.7 GHz
> > > Efficient-core Base Frequency : 2.1 GHz
> > >
> > >
> > > P-cores: 0-7
> > > Nominal freq: 2700
> > > Nominal perf: 43
> > > Scaling : ~1.6 (correct)
> > >
> > > E-cores:
> > > 8-
> > > Nominal freq: 2100
> > > Nominal perf: 29
> > > Scaling : ~1.38 (close to 1.4 so there will be some rounding issue)
> > >
> > > So,  this is not related to scaling factor as before like on ASROCK
> > >
> > >
> > > The P-cores under report `base_frequency` and `cpuinfo_max_freq`.
> > >
> > > - FAIL: With Turbo ON or off, the claimed `base_freqency` (B-Claim)
> > > of
> > > 2000000 does
> > >   NOT match the Intel spec (B-Spec) of 2700000.
> > >
> > > From CPPC:
> > >
> > > /sys/devices/system/cpu/cpu0/acpi_cppc/guaranteed_perf:32
> > > The base freq reported by cpufreq: 3200/1.6 =3D 2000
> > >
> > >
> > >
> > >
> > > - FAIL: With Turbo off, the claimed `cpuinfo_max_freq` (M-Claim) of
> > > 2000000 does
> > >   NOT match the Intel spec (M-Spec) of 2700000.
> > >
> > > We don=E2=80=99t depend on ACPI CPPC to achieve the measured value. W=
hen
> > > you
> > > are busy you are getting 2700, so the behavior is correct as the
> > > per
> > > the CPU spec.
> > >
> > >
> > >
> > > - FAIL: With Turbo ON, the claimed `cpuinfo_max_freq` (M-Claim) of
> > > 3900000 does
> > >   NOT match the Intel spec (M-Spec) of 5400000.
> > >
> > > ACPI CPPC also tells 3.9 GHz as max. But we don=E2=80=99t depend on i=
t.
> >
> > But we depend on HWP_CAP.highest_perf =3D=3D CPPC.highest_perf (because
> > the CPPC value comes from HWP).
>
> That's why asked for dump of MSRs above. This should match CPPC value.
> But seems setting HWP_REQ.max_perf=3D61 or 62 on P-core still results in
> 5.4 Ghz.

It looks like HWP_CAP.highest_per and HWP_CAP.guaranteed_perf are off
on this platform.

