Return-Path: <linux-acpi+bounces-13557-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A752AADD52
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 13:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6251BA3956
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 11:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F2621B9F1;
	Wed,  7 May 2025 11:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G60fTpwd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD6B189B8C;
	Wed,  7 May 2025 11:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746617294; cv=none; b=kJxwSEt/H7/ktK4hAyXawFVQBhAQh6tP3XaIf5Wr6Cwc+zjkZjANT+gmOLmyGEqBcAJj/t7oIwoZtOuPPGwCR6u8rIjcLXHZK66Bx0+tZKtzpGjQ7HuLy1pr+bTUoQozcl8AOgQZjrdPyNFfniQEWxFeUKttIut0wYoQXw1CNHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746617294; c=relaxed/simple;
	bh=HfmCdpR1jMcJa0xZiMMQoKjNNijBKB7LRDECNdKSMM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mkx+sWj6klLVeUqQM7vRvkot/Q9c3QUzAb5WQTT7vBTx82fuoU1mhcFiTWIyezyChcQN29ur5/5K9be84eddLvnDqs34pQHxA2K3DDng14O+MzuxNzHEfTqaocARG6lO4HtJESBOD20qtz4Avxil4DNsoIUqu8hZ/J+nOTRvPX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G60fTpwd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7F8C4AF09;
	Wed,  7 May 2025 11:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746617294;
	bh=HfmCdpR1jMcJa0xZiMMQoKjNNijBKB7LRDECNdKSMM8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G60fTpwdxB4DrhwDlC6pQ9C6vyxxy0bnAjd38vIdvqFmDsGLYvBvOrCFN7tJ/h5IV
	 n1w4T3la8UoZ1LHDU/Ve311EBPcLa5ZswcMyQeMzuul8l9zp/chfMwt9Ckmv0Ry5aL
	 Ah5mOj51/xyLWcsTlAlKO8hj4mG3KguTBrpI5A546P+2uxFaj3XrcPsQHB7T1f3fcH
	 X2t8yJB+jwq8qVXA1n5VqysqIWuhVTJ5SG15ASMSNVH6ZiyRdCsGfwKKVsHbOEKzpi
	 39tdrqwikq0wmA8ZVLhPdnlwZNP0Oef9JS+wOv5NUoKzZqulc5YEwl6ZhPigdhqIrk
	 qAj8ZVW64WvvA==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-60638c07cabso3569017eaf.3;
        Wed, 07 May 2025 04:28:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkwm5mxVRl/JiRxo0YxprlygsP57TLXSIr7V+aixVhXww2T41456Oym61S3u10bG1Tzm1xU/60NorP@vger.kernel.org, AJvYcCXWxhCu/c9hnI0O5uCUhnuSS7hEsMpvfgpoA+Cr4nn5d9XstaFTK582Jc489F1bB1NE9ebCuCUDfHCEdHni@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8loKMNBwUu5vcBApUySiEXIu9t1gSe1T5d57MHbT+ZowS43/g
	K6mMi9YHUko02tO4iT33PuTK1fZK0UKNf+0sN2+G/j/0CYFIz4CHpfoiXx0xh6Ng0KCYCkIyL97
	Dx1B88ulOKdQ9GU+APEUfnDmZf14=
X-Google-Smtp-Source: AGHT+IH9dpOt8ykPZ4X61hGqLtB1axa+IgEZY/VpS1VjPcux8be01WF+JBufbkOlC0/Df9wd+bywXb7umglUaO6pi+Y=
X-Received: by 2002:a05:6870:e981:b0:2bc:6675:2043 with SMTP id
 586e51a60fabf-2db5be3c562mr1660253fac.14.1746617293252; Wed, 07 May 2025
 04:28:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506213814.2365788-1-zaidal@os.amperecomputing.com> <20250506213814.2365788-2-zaidal@os.amperecomputing.com>
In-Reply-To: <20250506213814.2365788-2-zaidal@os.amperecomputing.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 May 2025 13:28:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gjbhyN4Nw-pFG6jYzZhbTaxi7JEB5KsowQus-2OoxsRQ@mail.gmail.com>
X-Gm-Features: ATxdqUHI_n3dC0DHMjHUzLZN9seLPsHoJsaWrZRzQbGEaqPxpgqx3p4ZcR_5dgM
Message-ID: <CAJZ5v0gjbhyN4Nw-pFG6jYzZhbTaxi7JEB5KsowQus-2OoxsRQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/9] ACPICA: Update values to hex to follow ACPI specs
To: Zaid Alali <zaidal@os.amperecomputing.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com, 
	tony.luck@intel.com, bp@alien8.de, robert.moore@intel.com, 
	Jonathan.Cameron@huawei.com, ira.weiny@intel.com, Benjamin.Cheatham@amd.com, 
	dan.j.williams@intel.com, arnd@arndb.de, Avadhut.Naik@amd.com, 
	u.kleine-koenig@pengutronix.de, john.allen@amd.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 11:38=E2=80=AFPM Zaid Alali
<zaidal@os.amperecomputing.com> wrote:
>
> ACPI specs[1] define Error Injection Actions in hex values.
> This commit intends to update values from decimal to hex to be
> consistent with ACPI specs. This commit and the following one are
> not to be merged and will come form ACPICA project see pull request[2].
>
> Link: https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html [=
1]
> Link: https://github.com/acpica/acpica/pull/977 [2]
>
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>

An equivalent patch is already there in linux-next:

https://web.git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/com=
mit/?h=3Dlinux-next&id=3D5d2f7e76b70121fe06fd12315a6ea439e3bf0414

> ---
>  include/acpi/actbl1.h | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 387fc821703a..c701c434976c 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -1024,18 +1024,18 @@ struct acpi_einj_entry {
>  /* Values for Action field above */
>
>  enum acpi_einj_actions {
> -       ACPI_EINJ_BEGIN_OPERATION =3D 0,
> -       ACPI_EINJ_GET_TRIGGER_TABLE =3D 1,
> -       ACPI_EINJ_SET_ERROR_TYPE =3D 2,
> -       ACPI_EINJ_GET_ERROR_TYPE =3D 3,
> -       ACPI_EINJ_END_OPERATION =3D 4,
> -       ACPI_EINJ_EXECUTE_OPERATION =3D 5,
> -       ACPI_EINJ_CHECK_BUSY_STATUS =3D 6,
> -       ACPI_EINJ_GET_COMMAND_STATUS =3D 7,
> -       ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS =3D 8,
> -       ACPI_EINJ_GET_EXECUTE_TIMINGS =3D 9,
> -       ACPI_EINJ_ACTION_RESERVED =3D 10, /* 10 and greater are reserved =
*/
> -       ACPI_EINJ_TRIGGER_ERROR =3D 0xFF  /* Except for this value */
> +       ACPI_EINJ_BEGIN_OPERATION =3D             0x0,
> +       ACPI_EINJ_GET_TRIGGER_TABLE =3D           0x1,
> +       ACPI_EINJ_SET_ERROR_TYPE =3D              0x2,
> +       ACPI_EINJ_GET_ERROR_TYPE =3D              0x3,
> +       ACPI_EINJ_END_OPERATION =3D               0x4,
> +       ACPI_EINJ_EXECUTE_OPERATION =3D           0x5,
> +       ACPI_EINJ_CHECK_BUSY_STATUS =3D           0x6,
> +       ACPI_EINJ_GET_COMMAND_STATUS =3D          0x7,
> +       ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS =3D 0x8,
> +       ACPI_EINJ_GET_EXECUTE_TIMINGS =3D         0x9,
> +       ACPI_EINJ_ACTION_RESERVED =3D             0xA,    /* 0xA and grea=
ter are reserved */
> +       ACPI_EINJ_TRIGGER_ERROR =3D               0xFF    /* Except for t=
his value */
>  };
>
>  /* Values for Instruction field above */
> --
> 2.43.0
>

