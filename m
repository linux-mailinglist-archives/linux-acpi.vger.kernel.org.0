Return-Path: <linux-acpi+bounces-19452-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C956CA910E
	for <lists+linux-acpi@lfdr.de>; Fri, 05 Dec 2025 20:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F42B3021688
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Dec 2025 19:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCBA27EFFA;
	Fri,  5 Dec 2025 19:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcO5C3KJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB8A26560A
	for <linux-acpi@vger.kernel.org>; Fri,  5 Dec 2025 19:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764962911; cv=none; b=HXGudp8Ye66YcyAtEqDkhm1tl9+nw5hWec8E5eC3Td0Ucd8GRzRFt8WDTFdekrvR4XwSwsFRWfaYubMkUwUkZTY3KysPDdZh+I8eGumjxtuFkK6TzqkXj8ICYUtiOGceTewaQSSRUhOPzbCHxRRtUesqTpWpNTBK+GcnGofWQEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764962911; c=relaxed/simple;
	bh=+ZydZENrJ/o1f8l/C5k8KPPOEzcoH5udzy3jsq6uMP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PmJAURgPLY4Y8BWTIsjz58fBPdAXbZj935ucWXuxhEXnagigoDh3w1pOrNX5+iaiihP3F8dDDAgGU/sN5xELqV7qwscdcN5F69deG3D2Rd7B/moXDiiUJJZWfbc3Iqc8FD4i/FBIfg5z0nBwklOuAFQk5qdCVF6wFrSeGZ8Jrsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcO5C3KJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F46C116B1
	for <linux-acpi@vger.kernel.org>; Fri,  5 Dec 2025 19:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764962911;
	bh=+ZydZENrJ/o1f8l/C5k8KPPOEzcoH5udzy3jsq6uMP8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TcO5C3KJTvEnQ5subjonPC1ngXXsB/MSEs9E9YIa0wofUzCywkHknnEafVLK5ILSW
	 nI7eG6s3sM+xg9NhPvvyJpnMGj0vBPzYwRxUnlKCs0MljP0/M83rQP94c7omPFbbmB
	 w2gTHSGkyMBjVve+Z4jeQV+0Am7vUOnVQhiwYhkMplS5fKgd6fEGNsBupQrE8++a7J
	 gwtYTgkVkp8nA1EFfgO3GlYoBZd3iJf7qXiW2+P8s4uS2IC2wRSSpH0H2BOiWS7+9N
	 XZyB9+5oruYhBoDewNvtJeLL041UrQTeJEEyllkdd3oaYQru8o0jouI0WDqZrZwQK9
	 HTWVWoN9EOwxA==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-65968986a0cso1343217eaf.3
        for <linux-acpi@vger.kernel.org>; Fri, 05 Dec 2025 11:28:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWW/G47W+En5m0SZ0b6sF9yR7h+HYQT4/YCba+m/Ip2NPc+P2n8J8g93T5ffG9KFtiRUXIpZC9zfuSM@vger.kernel.org
X-Gm-Message-State: AOJu0YyloGGNdjNX0/3QZmuNzqo/LKMaZFDiq79RVq9USpk9zv5CueO1
	mAN6pKtjEpW3PM0RDRz6GVB0VrHyVJh42kGpt1OIvv0azve3ksxv6PzfwohA5ucDImZytONAkHp
	olFN9oLNI/Zf5zYhT3EATMNd3woDu/Kc=
X-Google-Smtp-Source: AGHT+IFoPpIUBwxKFatmVHTKYNK+BIXykx5Kjw6K+0cefKdBwWa0qUPZQgpV/NxRpdwfxg8dmVrJBfL7uRFThzxCfE8=
X-Received: by 2002:a05:6820:999:b0:659:9a49:9054 with SMTP id
 006d021491bc7-6599a8ea084mr157037eaf.31.1764962910609; Fri, 05 Dec 2025
 11:28:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4f534cc70650111e420d5ac9040df4e546eed336.camel@linux.intel.com>
 <20251126170031.145b6a56@kf-m2g5> <20251203113851.52bf872b@kf-m2g5> <849e7394b8c7c4b74d1d55648a8d4b55b49aa91a.camel@linux.intel.com>
In-Reply-To: <849e7394b8c7c4b74d1d55648a8d4b55b49aa91a.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Dec 2025 20:28:18 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hUc3oz=Z8UUv3n4rY3on1vZpCtSdKjgOFp+OWYC5D9tw@mail.gmail.com>
X-Gm-Features: AWmQ_bnL-jdt_AOPDwqrhDQD4a2YqMip2xco13cxfiDxZ4zsiO6D-dJ1SB3S2Y4
Message-ID: <CAJZ5v0hUc3oz=Z8UUv3n4rY3on1vZpCtSdKjgOFp+OWYC5D9tw@mail.gmail.com>
Subject: Re: [BUG] intel_pstate: CPU frequencies miscalculated/incorrectly
 detected on Arrow Lake hardware
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Aaron Rainbolt <arainbolt@kfocus.org>, kernel-team@lists.ubuntu.com, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, 
	mmikowski@kfocus.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 8:11=E2=80=AFPM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Hi Aaron,
>
> On Wed, 2025-12-03 at 11:38 -0600, Aaron Rainbolt wrote:
> > On Wed, 26 Nov 2025 17:00:31 -0600
> > Aaron Rainbolt <arainbolt@kfocus.org> wrote:
> >
> >
> >
> ...
>
>
>
> There are too many platforms here, don't have time to get to all. So
> let's focus on one first.
>
> ## Clevo | X580WNT-G  | Ultra 9 275HX | 6.18.0-061800rc7-generic
>
> Summary:
> There is no scaling factor related issue as reported before on ASROCK
> platform before. The achieved maximum frequencies are correct.
>
> The base_freq display is wrong (see below because of BIOS config).
> The cpuinfo_max_freq wrong display is not related to scaling factor but
> something else
>
>
> To check, I need dump of:
> m=3D$(getconf _NPROCESSORS_ONLN); for ((i=3D0; i<m; i++)); do echo CPU$i;
> sudo rdmsr -p $i 0x771;  sudo rdmsr -p $i 0x774; done
>
> But I expect them to match the acpi_cppc/highest_perf, which is showing
> 3.9GHz.
>
> What command you to report " M-Test  . Id"?
>
> I think some busy 100% workload running on a single CPU.
>
>
>
> Analsis:
>
> Intel=C2=AE Core=E2=84=A2 Ultra 9 Processor 275HX
> 8+16 no HT
> Performance-core Base Frequency : 2.7 GHz
> Efficient-core Base Frequency : 2.1 GHz
>
>
> P-cores: 0-7
> Nominal freq: 2700
> Nominal perf: 43
> Scaling : ~1.6 (correct)
>
> E-cores:
> 8-
> Nominal freq: 2100
> Nominal perf: 29
> Scaling : ~1.38 (close to 1.4 so there will be some rounding issue)
>
> So,  this is not related to scaling factor as before like on ASROCK
>
>
> The P-cores under report `base_frequency` and `cpuinfo_max_freq`.
>
> - FAIL: With Turbo ON or off, the claimed `base_freqency` (B-Claim) of
> 2000000 does
>   NOT match the Intel spec (B-Spec) of 2700000.
>
> From CPPC:
>
> /sys/devices/system/cpu/cpu0/acpi_cppc/guaranteed_perf:32
> The base freq reported by cpufreq: 3200/1.6 =3D 2000
>
>
>
>
> - FAIL: With Turbo off, the claimed `cpuinfo_max_freq` (M-Claim) of
> 2000000 does
>   NOT match the Intel spec (M-Spec) of 2700000.
>
> We don=E2=80=99t depend on ACPI CPPC to achieve the measured value. When =
you
> are busy you are getting 2700, so the behavior is correct as the per
> the CPU spec.
>
>
>
> - FAIL: With Turbo ON, the claimed `cpuinfo_max_freq` (M-Claim) of
> 3900000 does
>   NOT match the Intel spec (M-Spec) of 5400000.
>
> ACPI CPPC also tells 3.9 GHz as max. But we don=E2=80=99t depend on it.

But we depend on HWP_CAP.highest_perf =3D=3D CPPC.highest_perf (because
the CPPC value comes from HWP).

