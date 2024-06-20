Return-Path: <linux-acpi+bounces-6548-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EF9910A2E
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 17:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F8D1C22127
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 15:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0021B0104;
	Thu, 20 Jun 2024 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFlYf4XA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201301AF6B6;
	Thu, 20 Jun 2024 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718898057; cv=none; b=AZg5hybyQaqo18ek2XxSCs6fjJHD9xgHoG7zLdOWCnvL2kXSWKc1H2UU6W8XMRwYsgGNuzHAsvk1t5hfBBkQQBqwTZhzshUQmvP+OJRhmVKOed7UGHs0nz1lpDyQzS/f0EQGBvJcr2qd9RPtdM97OxJ25LKamcM8BeiTE3vVGnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718898057; c=relaxed/simple;
	bh=5NRg4mklmcVDLa6pAbrcinNo9L7rLC5Vfgmi7UG6vnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F36ZF2q8CuG3TgPc16klyTK+CKsPMbn22GVbaty421c7NtntExLqTPsvmS2RSuNjm4gNc77QcMiKz2eETk4Gyv/v+yK2L0YlVaecuaxTWPjJNvEv1UNL6AKLEIRVhQY6Fys99p1glRj4pRugscV8ZDepM6Ffe1y8jRd/JMLexzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFlYf4XA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2D1C4AF0A;
	Thu, 20 Jun 2024 15:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718898056;
	bh=5NRg4mklmcVDLa6pAbrcinNo9L7rLC5Vfgmi7UG6vnM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tFlYf4XAhcnGaAocWpzl7eleVZbskpKwP9k4o8ttq2tGl5gNwLG9PGzGr20klImoK
	 81EYkQdXGXWE0u7zOMXfjWGRdUP1dlq25X5icPS1Agh5FCEjUAZiC2Tvecj3RHf5WF
	 U/un5hCJkG8cHXqRuaZgF6uBO+hz+x1yYqpmRiS10bP5q50louQIQwMgulsJBv9Zg3
	 PJBXGN0x+l3WC74Tbs5shR3PoIfwOBK6cWkL4v983dTOcc8uZmzB/vBj2nVrlAjhCN
	 KDHeL/K8OBfYRELlqfNlhrV1+1Jp7GKoISwqX1p8NHX3zG2LF6Iu5Wflj7+ojeZSiX
	 gCgjA0ette8SQ==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-254f646b625so152032fac.0;
        Thu, 20 Jun 2024 08:40:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXDxDw9sOFBR4+vezddYNxGu+G3zw1xXImFgf87YOZrC6F56MyEvn3I/6Sci7x5vdXKFSD/nb9nwS3MnmhQlu+zpB+JjubEdkbnxJPwnwoV++/95JYixEA7qjlhXKvBgCtm+yRfBRRUVw==
X-Gm-Message-State: AOJu0Yx5NzmSibkTz9jS1XY2BQAq1xJBVwaPJkpHjLMOVAPLNVoAJ52n
	qP6s1oZKc8XcmW5+WkX6NAmk0OhPCsSCHc4AQhcjzkikQnr18bbBl3PvhgJleXa2odtvG3kJReR
	/gID66LWfJGP8WhzC7CWbPr55+W0=
X-Google-Smtp-Source: AGHT+IEEbjG4U4hmoaWBonQYMHv3Lm5gg+atRAh7jRjhs1Zfdqy3tNiYdXwpvPVjtLaQfuhuFLrE2TzLDSnhk6exseI=
X-Received: by 2002:a05:6870:d1c9:b0:259:8928:85ec with SMTP id
 586e51a60fabf-25c9496379bmr6442865fac.2.1718898055795; Thu, 20 Jun 2024
 08:40:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b516084f-909e-4ea4-b450-3ee15c5e3527@amd.com> <ZnJfmUXmU_tsb9pV@kf-XE>
 <CAJZ5v0gOBH7OKF3KXwxYfWkGkC45rzDguR4VmSnoZDKpm+KPSg@mail.gmail.com>
 <12457165.O9o76ZdvQC@rjwysocki.net> <ZnNQF0ussBRSAt1g@kf-XE>
 <ZnNZgxDaXoCqkkJq@kf-XE> <ZnOAVWdBanvocb4D@kf-XE>
In-Reply-To: <ZnOAVWdBanvocb4D@kf-XE>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 20 Jun 2024 17:40:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g87Gmsi9HoPbNXO0Fu_sy+5MNGTjr_79UNOABNLmRn2Q@mail.gmail.com>
Message-ID: <CAJZ5v0g87Gmsi9HoPbNXO0Fu_sy+5MNGTjr_79UNOABNLmRn2Q@mail.gmail.com>
Subject: Re: [PATCH V3] acpi: Allow ignoring _OSC CPPC v2 bit via kernel parameter
To: Aaron Rainbolt <arainbolt@kfocus.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lenb@kernel.org, mmikowski@kfocus.org, 
	Perry.Yuan@amd.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 3:05=E2=80=AFAM Aaron Rainbolt <arainbolt@kfocus.or=
g> wrote:
>
> OK, we have done thorough benchmarking of the two patches. In summary,
> they both seem to provide exactly the same performance improvements.
> My initial worry that Rafael's patch didn't deliver the same performance
> improvements was unfounded.

Good to know, thanks!

> The following are the single-core and multi-core scores from running
> Geekbench 5 multiple times on a Carbon Systems Iridium 16 system. The
> first batch of tests was done with an Ubuntu kernel built with with my V3
> proposed patch, while the second batch was done with a kernel build with
> Rafael's proposed patch.
>
> Links to the Geekbench 5 reports can be shared if needed.
>
> _OSC CPPC bit ignore patch (written by Aaron Rainbolt):
> Kernel parameter 'ignore_osc_cppc_bit' set in
> '/etc/default/grub.d/kfocus.cfg'.
> '/sys/devices/system/cpu/cpu*/acpi_cppc' and
> '/proc/sys/kernel/sched_itmt_enabled' both present
>
> | Run | Single | Multi  |
> | --- | ------ | ------ |
> |  01 |   1874 |  10475 |
> |  02 |   1831 |  10132 |
> |  03 |   1858 |  10348 |
> |  04 |   1848 |  10370 |
> |  05 |   1831 |  10413 |
> | --- | ------ | ------ |
> | AVG |   1848 |  10348 |
>
>
> intel_pstate CPPC override patch (written by Rafael Wysocki):
> No special kernel parameters set.
> '/sys/devices/system/cpu/cpu*/acpi_cppc' ABSENT,
> '/proc/sys/kernel/sched_itmt_enabled' present
>
> | Run | Single | Multi  |
> | --- | ------ | ------ |
> |  01 |   1820 |  10310 |
> |  02 |   1870 |  10303 |
> |  03 |   1867 |  10420 |
> |  04 |   1844 |  10283 |
> |  05 |   1835 |  10451 |
> | --- | ------ | ------ |
> | AVG |   1847 |  10353 |

The problem with ignoring what the platform firmware is telling (or
not telling) the OS through ACPI is that only it knows the reason why
it is doing that.

It may be by mistake, but it also may be on purpose and it is hard to say.

However, intel_pstate already knows that HWP is enabled on the
processor, so it can be used directly regardless of whether or not
CPPC is enabled.  That is more appropriate and does not require users
to modify their kernel command line.

I'll add a changelog to the patch and submit it properly.

Thanks!

