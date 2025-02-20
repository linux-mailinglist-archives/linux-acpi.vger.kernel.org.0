Return-Path: <linux-acpi+bounces-11354-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5D2A3E590
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Feb 2025 21:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F45F7A4B0A
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Feb 2025 20:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB1326388E;
	Thu, 20 Feb 2025 20:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRCLnbKx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89101E5B6C
	for <linux-acpi@vger.kernel.org>; Thu, 20 Feb 2025 20:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740081942; cv=none; b=llA/lTKBP7LZdx2NDfQIFXGi2d1+nMXrDlT0WNGJWzd4F4PigRCfbo9xF+Qgl3kt12jro8gaYw2KGYwXIi0DgwW+SuCwhF0k1DUD9vQBbMaugfZ64JrlLkvKCRpgH/mggT9kkLtU2Jv9wewRdYx7/o0fPicCcIqhCNE3MLVdQME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740081942; c=relaxed/simple;
	bh=cneBczFqEZsY53Bp4FSMhW8m9ELOKjM8GthMgtabB3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=btiHd6CndP4nejVsrlBtX9Cj76fYzQV1zJ3MNyexoC+WOIPntUcsWyQfHGR91aKaqkDXVYpxU3QwStX8rqkwT/DF7Ehp9WgyVs0Cwlqr9bqk7ZXZw9mwfOcYzt6UMJaq4EnI6nHpxyHujQeYBBPE4rTkBX6jf2CKXmYXcQubnrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRCLnbKx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F39C4CED1
	for <linux-acpi@vger.kernel.org>; Thu, 20 Feb 2025 20:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740081942;
	bh=cneBczFqEZsY53Bp4FSMhW8m9ELOKjM8GthMgtabB3o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KRCLnbKxHUB2igdo5CzeSihHvTU4gVUwv9YKzmVvo4f8vse7aZyNbXP8S3pwJuOFb
	 udi77tE/MyaNwm8+nHEo7YPURG/DNpMPXL1GRvps36+6KLzVtaGxT06pYmRUYV6KeQ
	 JAhw0YkyklepR+hgltUDjPG2122A+hhp//JkcBwa7senkwPzU2CIAILOfkdnRix3p5
	 PtN8CAMOfcm91FbDTr9Ayw6M0X3oQiJ+4dLvDCFKAUvTH4ZoVxveso5AN0feiEu9Pk
	 gDxqXdAX8qKmx0wYe4TFMMso0RC4W+TH4UTvYksvQ7r2APvqnf9YxxANfC8duX+Cor
	 YXq6Snsol3p5A==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5fcd665af4eso346967eaf.2
        for <linux-acpi@vger.kernel.org>; Thu, 20 Feb 2025 12:05:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUb20tiYxVLpAnVRE4jNS1BdsDPqUWQbvwxvYK2Taei5dZtfcgCnl7wRnblXT71ZKGcnIMILSlcSIhz@vger.kernel.org
X-Gm-Message-State: AOJu0YwgnVj3q6b3Mpj+v6SfRqe5TEphD5yWlPMOo/Ud+t8Ic5eyWvCE
	R0lG+xsR673CJOJYP68WLR6xfexkSxnmGmHSTw+GFBxKc+dD7630VkxU4TsG89XsmR8otWDNSuh
	Mb4iJOuJCwK7y4bkn+x38t+95zi0=
X-Google-Smtp-Source: AGHT+IFd3Di6J8FK0sjZTfII1XnRtDpXPhlwZemOGquVV4uXa20GEsW7Zf07ACnTbwJGwgkECPcJZ5zuXyqbdjI9ybM=
X-Received: by 2002:a05:6820:1e09:b0:5fc:d180:5a73 with SMTP id
 006d021491bc7-5fd1a9d54b4mr105142eaf.8.1740081941652; Thu, 20 Feb 2025
 12:05:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219145338.3306745-1-superm1@kernel.org> <20250219145338.3306745-2-superm1@kernel.org>
In-Reply-To: <20250219145338.3306745-2-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 20 Feb 2025 21:05:28 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gWAfP=2fr-db=zSUu2iHUdbEdNHACFbqof5zFcaCX3eQ@mail.gmail.com>
X-Gm-Features: AWEUYZl4y9xZiKcvl-Zdc7oUIBeF0ZSkQGXA0h1ddMlY8g12giffiinYheYOQ70
Message-ID: <CAJZ5v0gWAfP=2fr-db=zSUu2iHUdbEdNHACFbqof5zFcaCX3eQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ACPI: Add missing prototype for non
 CONFIG_SUSPEND/CONFIG_X86 case
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, rafael@kernel.org, 
	kernel test robot <lkp@intel.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 3:54=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> acpi_register_lps0_dev() and acpi_unregister_lps0_dev() may be used
> in drivers that don't require CONFIG_SUSPEND or compile on !X86.
>
> Add prototypes for those cases.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202502191627.fRgoBwcZ-lkp@i=
ntel.com/
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  include/linux/acpi.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 4e495b29c640f..8e16ca5046e45 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1130,6 +1130,13 @@ static inline int acpi_get_lps0_constraint(struct =
device *dev)
>  {
>         return ACPI_STATE_UNKNOWN;
>  }
> +static inline int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg=
)
> +{
> +       return -ENODEV;
> +}
> +static inline void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *=
arg)
> +{
> +}
>  #endif /* CONFIG_SUSPEND && CONFIG_X86 */
>  void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
>  #else
> --

Applied as 6.15 material, thanks!

