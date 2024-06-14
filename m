Return-Path: <linux-acpi+bounces-6425-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F64A908AA9
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Jun 2024 13:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1479EB24487
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Jun 2024 11:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFA51946CA;
	Fri, 14 Jun 2024 11:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBIBKGWS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E414812EBCC;
	Fri, 14 Jun 2024 11:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718363300; cv=none; b=AY3ecT9EbX6t+MxQ9ggAmNNVSoEkpAOK24hqkvcvVyMixnlmHQwRuE4xBehkp0Gm7SoQwXm9QQJ2EwJhKFSv2JO5mo26sOck6i5U/LyBz374SkkCKKj0JBFZY9KT2tCw5E6tn59Qfhcfue0AeYtsS4+KgoBfppYrGCE1leGE68A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718363300; c=relaxed/simple;
	bh=J3Z19esqkJSiD+J31FVHiY7rajAIJvecYRWlBUKaHdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MWxa3j9TE7Gay5mZWnYLs7wiC850wwRF/YYaZL+Lk8qunKYmEDg+R9FEfNNVbQLgz4cP4J0QsBl2Fjp8mbUtOMfxtjrBdAUJEF9CNbE7/+UhlJ/bP774WSc1vkZGccRsVMrIDDA8XqXfzy6CtB6aPnLynfKWIVtMGg1feXvHxjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBIBKGWS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65555C4AF1D;
	Fri, 14 Jun 2024 11:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718363299;
	bh=J3Z19esqkJSiD+J31FVHiY7rajAIJvecYRWlBUKaHdg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bBIBKGWSbksDxfjSKBvOAuBywyMdWhh84dpWfEclFSDTuki8iVwY+UgtgTaPB/d3o
	 +dPMVo/dKZRR7Wtnfj1rSJitdni6yAoH7aw1JV63Vaq6TtZC+QVGZFZGHhiv0TO1OK
	 xrAgebiE+GrWnK5XLN7v3YZH7mqgmKm3m9BPF5+AtxptCKF3ZFkMVTRDmKAVAbDD1U
	 PnMIqp4C/0YLCcU4v0wSRb/MXVp6w8mAzhogdYT0gVt0YyofUzxUjWaN7x1ZE1mYW/
	 Z8v/36BciI5UsF4DNB/SZ20793vkZzxIiROc/ZR7C15w3MfWTI/susyqL4mI99qwua
	 2F8A2um+qaUZQ==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5bafec9ad2eso84704eaf.0;
        Fri, 14 Jun 2024 04:08:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXZh3D7xmiexpCfG5Oz8MfGAJBd1R05I5jUk0OZ38ge/3hDr+44SfsjKSDfBJKnv7sczWuPt3JeBrAst7SrwdbujMFIIo+cSNPzlFMph0Qh//uS6Yo02QXU4aNiOEAoOje3ECp8
X-Gm-Message-State: AOJu0Yzr6dsWCRuvI9vdijWk2CxQ1D/C+Zcnl4hlMR//ul+Kw2PKGrDm
	s8qpu7ZYkgT9VfW7BnPdFo+rvO3CBT0yFnjIEzKUQCFLCobAOckvz4vlseU8kX8qopJAK0h1tOS
	dWKZToMNfCdIBwwVbibvEsiDEJW8=
X-Google-Smtp-Source: AGHT+IHbu0Wz338NoDGVXvE8vx4VwP6nzR5XDnCPXh+YmoBxMOtDP8iab9l7e+vYa0av/03GOX6so6ubej3scieU5/U=
X-Received: by 2002:a4a:e1da:0:b0:5ba:ead2:c742 with SMTP id
 006d021491bc7-5bdad9f0343mr2533730eaf.0.1718363298689; Fri, 14 Jun 2024
 04:08:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613211011.413120-1-surajjs@amazon.com>
In-Reply-To: <20240613211011.413120-1-surajjs@amazon.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 14 Jun 2024 13:08:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iLtYOWc0w202kq8Tb-n=8ToQj2xHQ2_socwqqTyXufSw@mail.gmail.com>
Message-ID: <CAJZ5v0iLtYOWc0w202kq8Tb-n=8ToQj2xHQ2_socwqqTyXufSw@mail.gmail.com>
Subject: Re: [PATCH] acpi: Support CONFIG_ACPI without CONFIG_PCI
To: Suraj Jitindar Singh <surajjs@amazon.com>
Cc: linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, sjitindarsingh@gmail.com, 
	robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, 
	okaya@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 11:10=E2=80=AFPM Suraj Jitindar Singh
<surajjs@amazon.com> wrote:
>
> Make is possible to use ACPI without having CONFIG_PCI set.
>
> When initialising ACPI the following call chain occurs:
>
>   acpi_init() ->
>     acpi_bus_init() ->
>       acpi_load_tables() ->
>         acpi_ev_install_region_handlers() ->
>
> acpi_ev_install_region_handlers() calls acpi_ev_install_space_handler() o=
n
> each of the default address spaces defined as:
>
>   u8 acpi_gbl_default_address_spaces[ACPI_NUM_DEFAULT_SPACES] =3D {
>           ACPI_ADR_SPACE_SYSTEM_MEMORY,
>           ACPI_ADR_SPACE_SYSTEM_IO,
>           ACPI_ADR_SPACE_PCI_CONFIG,
>           ACPI_ADR_SPACE_DATA_TABLE
>   };
>
> However in acpi_ev_install_space_handler() the case statement for
> ACPI_ADR_SPACE_PCI_CONFIG is ifdef'd as:
>
>   #ifdef ACPI_PCI_CONFIGURED
>                   case ACPI_ADR_SPACE_PCI_CONFIG:
>
>                           handler =3D acpi_ex_pci_config_space_handler;
>                           setup =3D acpi_ev_pci_config_region_setup;
>                           break;
>   #endif
>
> ACPI_PCI_CONFIGURED is not defined if CONFIG_PCI is not enabled, thus the
> attempt to install the handler fails.
>
> Fix this by ifdef'ing ACPI_ADR_SPACE_PCI_CONFIG in the list of default
> address spaces.

What if there are PCI operation regions in the AML on the platform?
How are they going to be handled?

> Fixes: bd23fac3eaaa ("ACPICA: Remove PCI bits from ACPICA when CONFIG_PCI=
 is unset")
> CC: stable@vger.kernel.org # 5.0.x-
> Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>
> ---
>  drivers/acpi/acpica/evhandler.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/acpica/evhandler.c b/drivers/acpi/acpica/evhand=
ler.c
> index 1c8cb6d924df..371093acb362 100644
> --- a/drivers/acpi/acpica/evhandler.c
> +++ b/drivers/acpi/acpica/evhandler.c
> @@ -26,7 +26,9 @@ acpi_ev_install_handler(acpi_handle obj_handle,
>  u8 acpi_gbl_default_address_spaces[ACPI_NUM_DEFAULT_SPACES] =3D {
>         ACPI_ADR_SPACE_SYSTEM_MEMORY,
>         ACPI_ADR_SPACE_SYSTEM_IO,
> +#ifdef ACPI_PCI_CONFIGURED
>         ACPI_ADR_SPACE_PCI_CONFIG,
> +#endif
>         ACPI_ADR_SPACE_DATA_TABLE
>  };
>
> --
> 2.34.1
>
>

