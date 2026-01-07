Return-Path: <linux-acpi+bounces-20017-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A7DCFFD66
	for <lists+linux-acpi@lfdr.de>; Wed, 07 Jan 2026 20:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AFE6230021F9
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Jan 2026 19:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE04832E6A3;
	Wed,  7 Jan 2026 19:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heQV1eGI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29FF26E6E8
	for <linux-acpi@vger.kernel.org>; Wed,  7 Jan 2026 19:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767815347; cv=none; b=IenhIqB4BzM0GqbYiu4xjoNQeJAlZmMXC+ue4vOlwxnEltPd9CGiVsYoflLMr99MM22QVC0rwEodnId0JtsZCGHFBop61TrU8bgCQxehyr9hKEzY1JYJmbTrHU12Pls2tF9jpOB6L+3VeLV/CfyfpGB7ioH15HbOLKkXp85sUjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767815347; c=relaxed/simple;
	bh=mz8YJmNMg9axppZD5Mkowwu9SHcTRUKTKAh/4XNozAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FMmGgAPXjTrHFRDOD3xXoROD2WUj1tRWqKLPp3Bt8H8Km/AZxzibOl0wItNpZVdyasULkqTT+VboaP0uozRFPGBV1ON+9iLBsFbqzS2//MD0/mb5atmAi5NJRD3479OKl+sQ7i8TWytQO+7cztF12Nz8daUBksgpvvHpVKotHEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heQV1eGI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09917C19423
	for <linux-acpi@vger.kernel.org>; Wed,  7 Jan 2026 19:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767815347;
	bh=mz8YJmNMg9axppZD5Mkowwu9SHcTRUKTKAh/4XNozAc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=heQV1eGIu3HPUISuHrm0EO8BfsIH9xuZMALJwd/FIvZeWCgzPHaYnMcpvgWt7QTqs
	 UFSCyurBn1QZ6Kqpmn8pYzQc0gCzoFzyaJtGWC09/Mklqjw40n5X0+YrGlvE8nO73O
	 MPQCFD/P8s/ha+j+egFgeXv0MAWobtgyG8w9ocuXlu0rF9TngEOzkffvrMWmRpdb+x
	 X4sSpEbRYT6BmzTmt2b1rVuwzS8HiX0miNAFWXVfIMAHGYFnGbdnoe6YF5/hDYA6vX
	 dp6S+rl3APn9Q7uH2DfYaUjYD+dt/y6gKB3W0Ym3MhqqZTtkbtJAg6O94rhmKGM/Lo
	 l+C7dUVbYz4/Q==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c6dbdaced8so1982910a34.1
        for <linux-acpi@vger.kernel.org>; Wed, 07 Jan 2026 11:49:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXgHku22A0SKa5jRfllk9VcDI5uQchwjfEnCl4hcJnCrupmap4l4vSvawP6WKlnmBGFCE2TWTcSD/6G@vger.kernel.org
X-Gm-Message-State: AOJu0YwA+5mpuyjIGnUcTn21KRHqiggr4jHu6jBa7NcwlNNdN90znCjj
	OjDLDmAiyTB9gnGu7C+Xu1POINYGWwblifpcFLdlie3lCK9Q8fz77AZ3678VBYk7B5qRRUiapSG
	KfFyR2K6ZYVIxH8AZOhBiV4PPHxrKt8E=
X-Google-Smtp-Source: AGHT+IEVVjTmgyrGLLr9drmZT8Bk/YxNSpF//ZxNjjlKxG1iyY++EwxxMM17zdnPVMl9XcwpEZrVZ09VNRLMI33uYVU=
X-Received: by 2002:a05:6820:615:b0:659:9a49:8f05 with SMTP id
 006d021491bc7-65f54f36f8cmr1608006eaf.22.1767815346098; Wed, 07 Jan 2026
 11:49:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219215900.494211-1-colin.i.king@gmail.com>
In-Reply-To: <20251219215900.494211-1-colin.i.king@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 Jan 2026 20:48:54 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ijqOXipqW4APEZb93Vas1ng_J_jXWdc2mrZBg0ZUAZdQ@mail.gmail.com>
X-Gm-Features: AQt7F2peqv02-kyxkAFPN6bu-FVu65CC--U-yiCrGha37tTGIfyuuztT7OL4fLA
Message-ID: <CAJZ5v0ijqOXipqW4APEZb93Vas1ng_J_jXWdc2mrZBg0ZUAZdQ@mail.gmail.com>
Subject: Re: [PATCH][next] ACPI: APEI: EINJ: make read-only array
 non_mmio_desc static const
To: Colin Ian King <colin.i.king@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 11:00=E2=80=AFPM Colin Ian King <colin.i.king@gmail=
.com> wrote:
>
> Don't populate the read-only array non_mmio_desc on the stack at run
> time, instead make it static const.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/acpi/apei/einj-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.=
c
> index 305c240a303f..f5bfdffe1e43 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -679,7 +679,7 @@ static bool is_allowed_range(u64 base_addr, u64 size)
>          * region intersects with known resource. So do an allow list che=
ck for
>          * IORES_DESCs that definitely or most likely not MMIO.
>          */
> -       int non_mmio_desc[] =3D {
> +       static const int non_mmio_desc[] =3D {
>                 IORES_DESC_CRASH_KERNEL,
>                 IORES_DESC_ACPI_TABLES,
>                 IORES_DESC_ACPI_NV_STORAGE,
> --

Applied as 6.20 material, thanks!

