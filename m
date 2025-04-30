Return-Path: <linux-acpi+bounces-13398-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC3EAA550C
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Apr 2025 21:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0AF4C72A6
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Apr 2025 19:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D59427817E;
	Wed, 30 Apr 2025 19:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrxWutFO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535411DC9B0;
	Wed, 30 Apr 2025 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746042805; cv=none; b=Ln99V6mEDvfOZlEmuFL1BUB0Mb/leWwDPtIiw2xY1MMU5WBW73s/xW9moZoPsDvDDUtCcE/ukHjmbc8KEBtLVHqkAiK/oR9G3vuthuU6aWxlfWkiErlQ3asSmBKMwDVMtgYwUWbJs46pWCXD44L5kgsCat0xeDJL/4m1Zdja638=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746042805; c=relaxed/simple;
	bh=gqZ1CjwIv4EHK/oTFgyY7+DEJwVrYndqB0zhX+oq5RI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+M3UZrFdkmvftVHun0UzgC6ValEZFA16RKwdqtOJgUjNFGbAAop+SxQHGkLM+Gcb+2KYL5+q3qgAGIBrj/bgB7+cDwl5karHCsGlHW/BseYc3p6iHyIKjMI5aOM9lU2hBsQwhQGMf0g0Q4/Urt/+roHglRuO5yVfHP0OmMXYF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrxWutFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF026C4CEEA;
	Wed, 30 Apr 2025 19:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746042804;
	bh=gqZ1CjwIv4EHK/oTFgyY7+DEJwVrYndqB0zhX+oq5RI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FrxWutFOC9cJUsdFL8LaPi52dwvvjXO1nq2X/WSPSDHAixjYiWji+vMdjVcJ5thd7
	 xLA9WAfdS4Q7/NEri36L/vKWzUUlXXiQKZ9n6EbubRN1/+a14HdzghnLDjt7gQBnux
	 0IXTts8xU3/OdRSvuQbforDjLb5wl4wqvU7Eb1mF/fn9blapl9aHxtKIONeL9URlKg
	 XJZ7QlhohYHxCRZPlMwyZKvfxNzVj/rWQqp0aDQPwP5futIUvgeHfrGyuhoDjybyGY
	 ozwNGgynGwrqjFaSFSaRJu4RX5LbniUpVZMNEeQUOHccDugJYx1j+QtJpu49+g+IEt
	 QgIKRndMlsIuA==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2d4f8c42f49so786790fac.1;
        Wed, 30 Apr 2025 12:53:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV3q2r5yJyo8IVV84OCPk1LnLnjRZNwWkh/V9dNe2WWFKr5FiJrj7kacpLBQUfGRodeKVDjEmxFrCg6URE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3HtGgjOHqymJ69CXjU9qfjeE7EPwYzEgp13OnZ/+JzYOSbrL2
	IoDe7dhJbSn4G6Zs+UDkr8cDUbEGn+mS5vZ6HBoBkwDRGAToU16eA2/cnYH1jBZCYjpkltI1QFi
	iSkeqtLSy9g80Yszf3mTjld7ORX4=
X-Google-Smtp-Source: AGHT+IH3q4EiGyGslpwH0HJ5nabe37gqDbI31XIQ2UrnCT6u7m2HkRASLjRSlIz74wCJrkCAACS/mA5/yXhfOIVW3Ek=
X-Received: by 2002:a05:6870:95a0:b0:2d5:307f:cc5f with SMTP id
 586e51a60fabf-2da8b020e14mr426310fac.12.1746042804078; Wed, 30 Apr 2025
 12:53:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411113144.1151094-1-sudeep.holla@arm.com>
In-Reply-To: <20250411113144.1151094-1-sudeep.holla@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 30 Apr 2025 21:53:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gOCX5GGS8F6HidNM46wuKmUE5CdSGtxAm2v3-a-s80Og@mail.gmail.com>
X-Gm-Features: ATxdqUGUVNMHxO4y2wB0ManCGHv-kmnnDPikxM1LO43IIRBXcL1lScsipTWKt7Q
Message-ID: <CAJZ5v0gOCX5GGS8F6HidNM46wuKmUE5CdSGtxAm2v3-a-s80Og@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: PCC: Simplify PCC shared memory region handling
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Adam Young <admiyo@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 1:31=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> The PCC driver now handles mapping and unmapping of shared memory
> areas as part of pcc_mbox_{request,free}_channel(). Without these before,
> this ACPI PCC opregion driver did handling of those mappings like several
> other PCC mailbox client drivers.
>
> There were redundant operations, leading to unnecessary code. Maintaining
> the consistency across these driver was harder due to scattered handling
> of shmem.
>
> Just use the mapped shmem and remove all redundant operations from this
> driver.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Tested-by: Adam Young <admiyo@os.amperecomputing.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/acpi/acpi_pcc.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
>
> Hi Rafael,
>
> This is just resend of the couple of patches that was part of a series [1=
][2].
> Only core PCC mailbox changes were merged during v6.15 merge window.
> So dropping all the maintainer acks and reposting it so that it can
> be picked up for v6.16 via maintainers tree.
>
> [1] https://lore.kernel.org/all/20250313-pcc_fixes_updates-v3-12-019a4aa7=
4d0f@arm.com/
> [2] https://lore.kernel.org/all/20250313-pcc_fixes_updates-v3-13-019a4aa7=
4d0f@arm.com/

Both applied as 6.16 material, thanks!

> diff --git a/drivers/acpi/acpi_pcc.c b/drivers/acpi/acpi_pcc.c
> index 07a034a53aca..97064e943768 100644
> --- a/drivers/acpi/acpi_pcc.c
> +++ b/drivers/acpi/acpi_pcc.c
> @@ -31,7 +31,6 @@
>
>  struct pcc_data {
>         struct pcc_mbox_chan *pcc_chan;
> -       void __iomem *pcc_comm_addr;
>         struct completion done;
>         struct mbox_client cl;
>         struct acpi_pcc_info ctx;
> @@ -81,14 +80,6 @@ acpi_pcc_address_space_setup(acpi_handle region_handle=
, u32 function,
>                 ret =3D AE_SUPPORT;
>                 goto err_free_channel;
>         }
> -       data->pcc_comm_addr =3D acpi_os_ioremap(pcc_chan->shmem_base_addr=
,
> -                                             pcc_chan->shmem_size);
> -       if (!data->pcc_comm_addr) {
> -               pr_err("Failed to ioremap PCC comm region mem for %d\n",
> -                      ctx->subspace_id);
> -               ret =3D AE_NO_MEMORY;
> -               goto err_free_channel;
> -       }
>
>         *region_context =3D data;
>         return AE_OK;
> @@ -113,7 +104,7 @@ acpi_pcc_address_space_handler(u32 function, acpi_phy=
sical_address addr,
>         reinit_completion(&data->done);
>
>         /* Write to Shared Memory */
> -       memcpy_toio(data->pcc_comm_addr, (void *)value, data->ctx.length)=
;
> +       memcpy_toio(data->pcc_chan->shmem, (void *)value, data->ctx.lengt=
h);
>
>         ret =3D mbox_send_message(data->pcc_chan->mchan, NULL);
>         if (ret < 0)
> @@ -134,7 +125,7 @@ acpi_pcc_address_space_handler(u32 function, acpi_phy=
sical_address addr,
>
>         mbox_chan_txdone(data->pcc_chan->mchan, ret);
>
> -       memcpy_fromio(value, data->pcc_comm_addr, data->ctx.length);
> +       memcpy_fromio(value, data->pcc_chan->shmem, data->ctx.length);
>
>         return AE_OK;
>  }
> --
> 2.34.1
>

