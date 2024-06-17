Return-Path: <linux-acpi+bounces-6468-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A1590BAAF
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 21:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EE51B21F7E
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 19:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE12188CBD;
	Mon, 17 Jun 2024 19:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7qv6dOG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0FB17F36D
	for <linux-acpi@vger.kernel.org>; Mon, 17 Jun 2024 19:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718651735; cv=none; b=UnJmfd8/cEnvqtFGB9fQz+uhBeLAitgaVgI0IFW3ZtVX4yWdjd1H8KmAJ1njUSepMC7ysgDYwBsqy0Sv3qO/fwDMYlmmt/aWKz65HCN2j46OBOGO0/s4KlhVkpL5nK3tWHI5c2mwRN52Yvqx91BmHsltdIRTjli89UQPuWGDrxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718651735; c=relaxed/simple;
	bh=dnlNd17/svFd5fenxaaZoQ28/SFGQa8CfmhdYUXsd6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nbsJh6wpJQ9HjSpUySZxK5GIQSAhLsMCaUXSgPiHaaiVyt8UimVwOGNZL1T6MWNvfsf/Y+NCY8f7QFzT7I3SpzI6zHSVPtVV+Zx5nSV8o2eDRDR3yssu4VcizMR9pOWySW7Y+1zn/K4Be5KHKaYdWPk0oWvYl6PHpBf1sJRTb54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7qv6dOG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8CB9C2BD10
	for <linux-acpi@vger.kernel.org>; Mon, 17 Jun 2024 19:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718651734;
	bh=dnlNd17/svFd5fenxaaZoQ28/SFGQa8CfmhdYUXsd6c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=H7qv6dOGnWtEyHQvOWgx/5b5blkSVAoIvycgrMWhSwwqrNk573v5Nh6EifzCIPjAT
	 V4bsl1FrNv6L1XUGmM8vnE8IkkGkqTFK6jLtSTAK+edggd8pNtGjaOikiZxRhGzxj4
	 xTUXyqxiR/VpnjSHBWNbw5O0wlIKtOBCDpx5+KNec4fPhU5Lo+szW2Zwxy/+gYQLHX
	 EQIJKSY8DALXoreEZQGuGykRdsVz0vovdmwg1cAd3izxYUdigxq7Thn6XdQQ1ycX6o
	 SzTCZtXKP9dLb/QY0V9pCnPEF5ssyG5Hzj+8iwZB79QD4S8zf4pBqQjML7Jl4aux97
	 lmn+ruuwnozkw==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-25944fb6f47so257249fac.3
        for <linux-acpi@vger.kernel.org>; Mon, 17 Jun 2024 12:15:34 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyq6ucP386T6uKjdxbFO2k8hGT8COkFPw1tDrjhi5YQw4jj0hkU
	/MNb2gJiKdwRYjFMs/rixDhHe0UTe9cavNO+XBrQhhYTJo8X6yJZEEbY6YgJJlH8q7p2gUFw9VZ
	a8DdZv4FZ3JHC1gv+HPRow+3rNhk=
X-Google-Smtp-Source: AGHT+IFYUMxBX9XmaMwgZEfnCDAoYsyqLr4CgXr0vHSQ/5hsWUhDcPhaHaEAjoHt7pBYz1O/Mkld/yWc80SC7Ddvl/Q=
X-Received: by 2002:a05:6870:9707:b0:258:4dcb:7d51 with SMTP id
 586e51a60fabf-2584dcb8546mr10291563fac.1.1718651734047; Mon, 17 Jun 2024
 12:15:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614140149.1654251-1-Raju.Rangoju@amd.com>
In-Reply-To: <20240614140149.1654251-1-Raju.Rangoju@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 17 Jun 2024 21:15:22 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jT_brwZFqvoYthjEe_noUXWmp0K9QKxL1gVvmJJbWY9A@mail.gmail.com>
Message-ID: <CAJZ5v0jT_brwZFqvoYthjEe_noUXWmp0K9QKxL1gVvmJJbWY9A@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Revert "ACPICA: avoid Info: mapping multiple
 BARs. Your kernel is fine."
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	robert.moore@intel.com, rafael.j.wysocki@intel.com, 
	Sanath S <Sanath.S@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 4:02=E2=80=AFPM Raju Rangoju <Raju.Rangoju@amd.com>=
 wrote:
>
> Undo the modifications made in commit d410ee5109a1 ("ACPICA: avoid
> "Info: mapping multiple BARs. Your kernel is fine.""). The initial
> purpose of this commit was to stop memory mappings for operation
> regions from overlapping page boundaries, as it can trigger warnings
> if different page attributes are present.
>
> However, it was found that when this situation arises, mapping
> continues until the boundary's end, but there is still an attempt to
> read/write the entire length of the map, leading to a NULL pointer
> deference. For example, if a four-byte mapping request is made but
> only one byte is mapped because it hits the current page boundary's
> end, a four-byte read/write attempt is still made, resulting in a NULL
> pointer deference.
>
> Instead, map the entire length, as the ACPI specification does not
> mandate that it must be within the same page boundary. It is
> permissible for it to be mapped across different regions.
>
> Link: https://github.com/acpica/acpica/pull/954
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218849
> Fixes: d410ee5109a1 ("ACPICA: avoid "Info: mapping multiple BARs. Your ke=
rnel is fine."")
> Co-developed-by: Sanath S <Sanath.S@amd.com>
> Signed-off-by: Sanath S <Sanath.S@amd.com>
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---
>  drivers/acpi/acpica/exregion.c | 23 ++---------------------
>  1 file changed, 2 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregio=
n.c
> index 8907b8bf4267..c49b9f8de723 100644
> --- a/drivers/acpi/acpica/exregion.c
> +++ b/drivers/acpi/acpica/exregion.c
> @@ -44,7 +44,6 @@ acpi_ex_system_memory_space_handler(u32 function,
>         struct acpi_mem_mapping *mm =3D mem_info->cur_mm;
>         u32 length;
>         acpi_size map_length;
> -       acpi_size page_boundary_map_length;
>  #ifdef ACPI_MISALIGNMENT_NOT_SUPPORTED
>         u32 remainder;
>  #endif
> @@ -138,26 +137,8 @@ acpi_ex_system_memory_space_handler(u32 function,
>                 map_length =3D (acpi_size)
>                     ((mem_info->address + mem_info->length) - address);
>
> -               /*
> -                * If mapping the entire remaining portion of the region =
will cross
> -                * a page boundary, just map up to the page boundary, do =
not cross.
> -                * On some systems, crossing a page boundary while mappin=
g regions
> -                * can cause warnings if the pages have different attribu=
tes
> -                * due to resource management.
> -                *
> -                * This has the added benefit of constraining a single ma=
pping to
> -                * one page, which is similar to the original code that u=
sed a 4k
> -                * maximum window.
> -                */
> -               page_boundary_map_length =3D (acpi_size)
> -                   (ACPI_ROUND_UP(address, ACPI_DEFAULT_PAGE_SIZE) - add=
ress);
> -               if (page_boundary_map_length =3D=3D 0) {
> -                       page_boundary_map_length =3D ACPI_DEFAULT_PAGE_SI=
ZE;
> -               }
> -
> -               if (map_length > page_boundary_map_length) {
> -                       map_length =3D page_boundary_map_length;
> -               }
> +               if (map_length > ACPI_DEFAULT_PAGE_SIZE)
> +                       map_length =3D ACPI_DEFAULT_PAGE_SIZE;
>
>                 /* Create a new mapping starting at the address given */
>
> --

Applied as 6.10-rc material, thanks!

