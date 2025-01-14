Return-Path: <linux-acpi+bounces-10593-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACA5A107C3
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 14:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2465160551
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 13:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D09423242A;
	Tue, 14 Jan 2025 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Th2+swrA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D28232424;
	Tue, 14 Jan 2025 13:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736861244; cv=none; b=odYu5WysNHkiuKiF3G4z1YkYgarcQmUmx9rsVT5GadORwxzagUv54dz7tozRuz8NJ6kR1yjrA0fxnLE3KMaO+YnLQfp3AuicfEPPwX1pPjc4WnxmaXdPLEWLZV73moampkX8HxGQ6baF8uOKvvEZASpSVK4/Rjo8hQ6P0TAiDTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736861244; c=relaxed/simple;
	bh=eLc+q9S1jrqfKEh0Shy5K5yfQiiy8VjwTpD0Ol7oxo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fbv4/FRl8ullsw05p1CzmH+cfi28pwWt+6MdkDJNZSkr4nkQ7jP9fnwWLI43Lt7oMQI/YSLDDL4m9ZaZJW5HOyRCbIoIdC0LcePOBA6WKBNReRIGqLodz7/e26CaesVVmoMGznBERvuWEOjbB5zdftgbmoXqnf4+ysK+6STCTbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Th2+swrA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF97BC4CEE4;
	Tue, 14 Jan 2025 13:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736861243;
	bh=eLc+q9S1jrqfKEh0Shy5K5yfQiiy8VjwTpD0Ol7oxo4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Th2+swrA+f4hqIJCt6+/umIAMrtHCVhi9cd3Chl2vVpJt8RYmsKKyYxEW+17USVPz
	 Lsl1k4znjaUEGAA0hHOSFmuEv918VP5plSCeC3npxvIuUyjZC0zgxgAQYJmIJ/uik5
	 rYPkIl4w7wbJ5QG7hdB02tjA79n3Wm4c1P+rdpOdILEhB233wlqTm/NKWFCrbU59T0
	 gmx3djDhpMH0pssNjXAdMvERa5QZHNRJwz4N8AtHAMsgV+SxY4hOfWAfXIr+tfxHkd
	 YGUTGbAau7nVH2grbRyqVyNuG0M5eRZWs/vx2q5esJ4mhM9gRiKIVgIqD/inOPqGkz
	 ni85WRL8TuuEQ==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-29fe83208a4so2696875fac.0;
        Tue, 14 Jan 2025 05:27:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUtLy7eR9d5HOsOM+nrBigMqrFF8DVSxVA7/5bwQFLrHQvUgeovYHkvElM5h7FbPcLfcJxMHcWskgdvFCJT@vger.kernel.org, AJvYcCV1LiERKTtUtfwYFzA4sushC9Df0IiBLs53BmAvd9FlOMyyi/zhOdITyNmX7Qaj2/QftlEFEHu2YorV@vger.kernel.org, AJvYcCXxWByjIDkxy1EEJayZeWxlcnYwQQCjtFdFNX3KgFsA2OCEnsoyV3aB7rE2JPI5Ud3nXb6xng2AGqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKG8/7uDD6DJ3uRhrvuS9aZuyowZOr9AcPeOhTaDkvzg85QiaQ
	FbdZc75wVvPU3ME9cZSc/pI8Ap8iuOUe4R2VYv34yPQg3IyblKqwYat/cEVfl5kM6ybVa4a6p64
	/3cJ33t8OJBHyRu4coQxz31FvpcE=
X-Google-Smtp-Source: AGHT+IFqQ76W/O+kYshOg6zjtig0JEaVkHWcK8wO+TUwklW859PHlWhrWxjbqDONCXGyMjbNuAP8/Ne+16wXvsa6rkQ=
X-Received: by 2002:a05:6870:b9c4:b0:29f:b645:ce86 with SMTP id
 586e51a60fabf-2aae5aa8daemr12907467fac.12.1736861243031; Tue, 14 Jan 2025
 05:27:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113122104.3870673-1-zhenglifeng1@huawei.com> <20250113122104.3870673-2-zhenglifeng1@huawei.com>
In-Reply-To: <20250113122104.3870673-2-zhenglifeng1@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 14 Jan 2025 14:27:12 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ja7AaJza0PeNgutebXRV3tsgxZRwZUBcFksD9thyKg1Q@mail.gmail.com>
X-Gm-Features: AbW1kvYxFpUsEc9PFeMehAkFEsQFM5KZKo-OlX1ezuwCujGsEj_an0AKwqHVAyg
Message-ID: <CAJZ5v0ja7AaJza0PeNgutebXRV3tsgxZRwZUBcFksD9thyKg1Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] ACPI: CPPC: Add IS_OPTIONAL_CPC_REG macro
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com, 
	viresh.kumar@linaro.org, mario.limonciello@amd.com, gautham.shenoy@amd.com, 
	ray.huang@amd.com, pierre.gondois@arm.com, acpica-devel@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxarm@huawei.com, jonathan.cameron@huawei.com, 
	zhanjie9@hisilicon.com, lihuisong@huawei.com, hepeng68@huawei.com, 
	fanghao11@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 1:21=E2=80=AFPM Lifeng Zheng <zhenglifeng1@huawei.c=
om> wrote:
>
> Add IS_OPTIONAL_CPC_REG macro to judge if a cpc_reg is an optional one.

This requires a bit more explanation, especially what's the purpose of
it (ie. the "why").

> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/acpi/cppc_acpi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index f193e713825a..6454b469338f 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -129,6 +129,12 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_pt=
r);
>  #define CPC_SUPPORTED(cpc) ((cpc)->type =3D=3D ACPI_TYPE_INTEGER ?      =
   \
>                                 !!(cpc)->cpc_entry.int_value :          \
>                                 !IS_NULL_REG(&(cpc)->cpc_entry.reg))
> +
> +/* These indicate optional of the per-cpu cpc_regs[]. */

Again, you need to say more here, like how this is supposed to work.

> +#define REG_OPTIONAL (0b111111100011111010000)

A hex literal would work too AFAICS.

> +
> +#define IS_OPTIONAL_CPC_REG(reg_idx) (REG_OPTIONAL & (1U << (reg_idx)))

You need to explain what reg_idx is.

> +
>  /*
>   * Arbitrary Retries in case the remote processor is slow to respond
>   * to PCC commands. Keeping it high enough to cover emulators where
> --

