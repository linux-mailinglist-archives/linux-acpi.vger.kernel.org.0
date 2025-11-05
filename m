Return-Path: <linux-acpi+bounces-18530-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA91C34E61
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 10:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D1B818971CB
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 09:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA57330146A;
	Wed,  5 Nov 2025 09:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uwvFbrf3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC783B7A8
	for <linux-acpi@vger.kernel.org>; Wed,  5 Nov 2025 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762335572; cv=none; b=VQ/Z6HdcI2sE4P53tRqIIs6O0e0OlzMrPXGtiDZEMeGIv3PuSv+gZ/WLyyhj4K9yXHhPZOul96X72RsXlNNsnh4wzQARv+FMH5t3y8Z6LVRPfcmuuMV15hlNlMRRvgiJIc9J1yznVavJ+9gYdkea7AolpFZ1F1YzJ37HlpyaQk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762335572; c=relaxed/simple;
	bh=Y/QVCwFtVcVhOhNLbuFaTdUxlvuy4RuJBGe1iwHRH8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRCbrIg5Gd3tgnKHsszlPjvXQZ1pgwjgZelxkgkNp1AeKB9oXA1nVi+QiKPnmbO+vO1snfy+N4bW07JAy4pY8E+d8N8iSMsxFUdybXddT0Ml0BsvEiADUlfBHca+B2sdB05Y8IZNByBYXCdI9KNg6lznHIi6VRpg/bDl39D1mVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uwvFbrf3; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-94822ad1baeso484233539f.2
        for <linux-acpi@vger.kernel.org>; Wed, 05 Nov 2025 01:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762335570; x=1762940370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IokSDhSQKkPKqVDUsmpbY8pfE2HypH7GPpU5B3pqfWE=;
        b=uwvFbrf3NiaVbtAzqSQEwUUwJvd8WqUf0lHYCRuU5lAhEO1U2iz8Xz8jYuwfBwwLI0
         ofNkIntyllgXrbPtwlAc5zErZX2vVie3QJzkQ2s5WYAGlgUhIxcKy9V516BAc+fDJZLj
         50F834mmXxI4h13/lN+kKdrrxbTjpovriW0RYhKlvX4PnXnLtlNOYOdOSjEgDwkC7UEB
         ym6o68i2HVfmp19LWruWEOPr4wj34OfgADz+IxBgIGJsFGwWiqwuZHAUtt1GQrsBjnya
         pU4y7qM1Xomfgjp8XTrGlLX63UElP/Bs4rVy63PdyLeNYmszcRECy+Ap6e7Jlpl0j9rI
         7Lhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762335570; x=1762940370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IokSDhSQKkPKqVDUsmpbY8pfE2HypH7GPpU5B3pqfWE=;
        b=SqUSJ7T9odnVNKOdcomgH4M9FFSj07t5RXBuzVE0ZDQk5ts0xJCJ35KFVJgevfr5wu
         Z66QwXQeymZQA1kha+wMf+tkY9+9tGm1WgVKgUMeXieDuCw2zamKX2K6D7FgAPu88Nnn
         z1w2UpBCjEwFNaNr8vOsFJbs3oNZCce+FHedC5TNx7pkX+UK9NU4/hsHl557hYpfkHDZ
         M6poSXRyWgdHOjzEysawM3ogZbwUIOmfX8I3nP2NwZj5Lqqzxjnbzzl0kHexJaKyCrtp
         nhoCxZkZ1yQUQ5zqr0IRNh2w5mVXyN0zkc7yx7EQKbS13ZukMU9pdWm4M7UP5ql1oTXS
         5CJA==
X-Forwarded-Encrypted: i=1; AJvYcCUGnLVHvz9DwbvkqpTgiB+lo42ZMEZUpwSLTr8vXVXWDVfR59aC9CV7YvdOY+44rHvxSSnDLAEKa3ci@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1WNkVNbBRsKXAPuG5AGX5uf8AYYkLnx59KgRJ/bM4Xb0HCFX7
	wJV09lI0TA/MlZCS4FHtRw5FNTuEDEHt35D4IyDWM1n1S6QvaKIdG6MwDLZML8X2SqldR1UxcbY
	+gkzuCQq32gUElOlLMVb2+B9r66hf4bn3K+H9M7Pd
X-Gm-Gg: ASbGnctdw9stSjqbzfhaChGRwb5L8lvPC4Mag68HwAQUV8Vf1VVresYn9x50MXAy6jN
	ye+mswCZbPMzZHAwn8NiyuPJzgcwBD8yyley+r/TtAKQaUMXv0brQkCM8Z2+8lrmnSqd4DP16RB
	8iw2BbuP5tjL8TJVNYK/zU2NowNYvODjgscKhDwXnjddhTbHevn3Mwlvz1v/6+7lrhTHb3u5Zgt
	S7Ns8doU/HJ2RxjSzDYIW2sJSxAwyvu03kyvizxt5sGzmCsXnrmAHtqEAXgnJudUfvnBfd5k1Jz
	zBXXhSO8sd4eRZrmfg18W659lA==
X-Google-Smtp-Source: AGHT+IGXLbbRU5MhL2X6azrT9+Ed7fePpTvasCLz4jFrgzitDBWxITHaWT5lJQbLWmk2HCxh3hRCi/RttZSE4Xvr3cw=
X-Received: by 2002:a05:6e02:221a:b0:425:7534:ab09 with SMTP id
 e9e14a558f8ab-4334078f120mr35093715ab.7.1762335569928; Wed, 05 Nov 2025
 01:39:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017185645.26604-1-james.morse@arm.com>
In-Reply-To: <20251017185645.26604-1-james.morse@arm.com>
From: Peter Newman <peternewman@google.com>
Date: Wed, 5 Nov 2025 10:39:17 +0100
X-Gm-Features: AWmQ_bn8Nja5HuwDjw2eZbobrBQf02LNxNGny9JK1-OjQ312TKkOMmFAuKxVAX4
Message-ID: <CALPaoCjbDyvRbW2bcrhB3opF1ieDLhv1961Gr7vYv=k-nzC27Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/29] arm_mpam: Add basic mpam driver
To: James Morse <james.morse@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-acpi@vger.kernel.org, 
	D Scott Phillips OS <scott@os.amperecomputing.com>, carl@os.amperecomputing.com, 
	lcherian@marvell.com, bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com, 
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>, 
	Xin Hao <xhao@linux.alibaba.com>, dfustini@baylibre.com, amitsinght@marvell.com, 
	David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, 
	Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com, baisheng.gao@unisoc.com, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Rob Herring <robh@kernel.org>, 
	Rohit Mathew <rohit.mathew@arm.com>, Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>, Gavin Shan <gshan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi James,

On Fri, Oct 17, 2025 at 8:57=E2=80=AFPM James Morse <james.morse@arm.com> w=
rote:
>
> Hello,
>
> A slew of minor changes, nothing really sticks out.
> Changes are noted on each patch.
>
> ~
>
> This is just enough MPAM driver for ACPI. DT got ripped out. If you need =
DT
> support - please share your DTS so the DT folk know the binding is what i=
s
> needed.
> This doesn't contain any of the resctrl code, meaning you can't actually =
drive it
> from user-space yet. Because of that, its hidden behind CONFIG_EXPERT.
> This will change once the user interface is connected up.
>
> This is the initial group of patches that allows the resctrl code to be b=
uilt
> on top. Including that will increase the number of trees that may need to
> coordinate, so breaking it up make sense.
>
> The locking got simplified, but is still strange - this is because of the=
 'mpam-fb'
> firmware interface specification that is still alpha. That thing needs to=
 wait for
> an interrupt after every system register write, which significantly impac=
ts the
> driver. Some features just won't work, e.g. reading the monitor registers=
 via
> perf.
>
> I've not found a platform that can test all the behaviours around the mon=
itors,
> so this is where I'd expect the most bugs.
>
> The MPAM spec that describes all the system and MMIO registers can be fou=
nd here:
> https://developer.arm.com/documentation/ddi0598/db/?lang=3Den
> (Ignored the 'RETIRED' warning - that is just arm moving the documentatio=
n around.
>  This document has the best overview)
>
> The expectation is this will go via the arm64 tree.
>
>
> This series is based on v6.18-rc4, and can be retrieved from:
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/driv=
er/v3
>
> The rest of the driver can be found here:
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snap=
shot/v6.18-rc1
>
> What is MPAM? Set your time-machine to 2020:
> https://lore.kernel.org/lkml/20201030161120.227225-1-james.morse@arm.com/
>
> This series was previously posted here:
> [v2] lore.kernel.org/r/20250910204309.20751-1-james.morse@arm.com
> [v1] lore.kernel.org/r/20250822153048.2287-1-james.morse@arm.com
> [RFC] lore.kernel.org/r/20250711183648.30766-2-james.morse@arm.com
>
>
> James Morse (27):
>   ACPI / PPTT: Add a helper to fill a cpumask from a processor container
>   ACPI / PPTT: Stop acpi_count_levels() expecting callers to clear
>     levels
>   ACPI / PPTT: Find cache level by cache-id
>   ACPI / PPTT: Add a helper to fill a cpumask from a cache_id
>   arm64: kconfig: Add Kconfig entry for MPAM
>   ACPI / MPAM: Parse the MPAM table
>   arm_mpam: Add probe/remove for mpam msc driver and kbuild boiler plate
>   arm_mpam: Add the class and component structures for firmware
>     described ris
>   arm_mpam: Add MPAM MSC register layout definitions
>   arm_mpam: Add cpuhp callbacks to probe MSC hardware
>   arm_mpam: Probe hardware to find the supported partid/pmg values
>   arm_mpam: Add helpers for managing the locking around the mon_sel
>     registers
>   arm_mpam: Probe the hardware features resctrl supports
>   arm_mpam: Merge supported features during mpam_enable() into
>     mpam_class
>   arm_mpam: Reset MSC controls from cpuhp callbacks
>   arm_mpam: Add a helper to touch an MSC from any CPU
>   arm_mpam: Extend reset logic to allow devices to be reset any time
>   arm_mpam: Register and enable IRQs
>   arm_mpam: Use a static key to indicate when mpam is enabled
>   arm_mpam: Allow configuration to be applied and restored during cpu
>     online
>   arm_mpam: Probe and reset the rest of the features
>   arm_mpam: Add helpers to allocate monitors
>   arm_mpam: Add mpam_msmon_read() to read monitor value
>   arm_mpam: Track bandwidth counter state for overflow and power
>     management
>   arm_mpam: Add helper to reset saved mbwu state
>   arm_mpam: Add kunit test for bitmap reset
>   arm_mpam: Add kunit tests for props_mismatch()
>
> Rohit Mathew (2):
>   arm_mpam: Probe for long/lwd mbwu counters
>   arm_mpam: Use long MBWU counters if supported
>
>  arch/arm64/Kconfig                  |   25 +
>  drivers/Kconfig                     |    2 +
>  drivers/Makefile                    |    1 +
>  drivers/acpi/arm64/Kconfig          |    3 +
>  drivers/acpi/arm64/Makefile         |    1 +
>  drivers/acpi/arm64/mpam.c           |  384 ++++
>  drivers/acpi/pptt.c                 |  248 ++-
>  drivers/acpi/tables.c               |    2 +-
>  drivers/resctrl/Kconfig             |   22 +
>  drivers/resctrl/Makefile            |    4 +
>  drivers/resctrl/mpam_devices.c      | 2701 +++++++++++++++++++++++++++
>  drivers/resctrl/mpam_internal.h     |  661 +++++++
>  drivers/resctrl/test_mpam_devices.c |  389 ++++
>  include/linux/acpi.h                |   26 +
>  include/linux/arm_mpam.h            |   58 +
>  include/linux/platform_device.h     |    1 +
>  16 files changed, 4519 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/acpi/arm64/mpam.c
>  create mode 100644 drivers/resctrl/Kconfig
>  create mode 100644 drivers/resctrl/Makefile
>  create mode 100644 drivers/resctrl/mpam_devices.c
>  create mode 100644 drivers/resctrl/mpam_internal.h
>  create mode 100644 drivers/resctrl/test_mpam_devices.c
>  create mode 100644 include/linux/arm_mpam.h
>
> --
> 2.39.5
>

I applied this series and booted the kernel on a Google Cloud C4A host
(baremetal) and confirmed through sysfs that all MSCs were probed
successfully.

Tested-by: Peter Newman <peternewman@google.com>

Thanks!
-Peter

