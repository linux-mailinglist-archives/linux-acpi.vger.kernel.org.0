Return-Path: <linux-acpi+bounces-6718-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E498A91E745
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 20:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AD251C21004
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 18:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867AA47A4C;
	Mon,  1 Jul 2024 18:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvo9ApgF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626842BB04
	for <linux-acpi@vger.kernel.org>; Mon,  1 Jul 2024 18:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719857771; cv=none; b=pefwCv8YDjeCqPR/+FIM3R8O+Bhqsah2Dyx8q3BPSPJQbbPnduWmfxm4Wy7+WVYVCFbzY2OqnICLocALqjEHhE7bZBEy0WFgTe4OhIfyVhfFrKzZyU2cWeTxRQ20b9ihYlogPAqjLm4vPz9Jo1kGpxGiRo9aI9g3/Ty33CxEwRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719857771; c=relaxed/simple;
	bh=OtmMFvkYBbM0iWHuxuFadDgmRVK2Q3kzXubTin/P4Vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GIqvgfFRdyzoMxdSU9Xp+88Z/+5LvVc9cp7+6hMfqrYDm3aYr0qaU2G3V5LrO5rsidHEos0l8Zvc/Al/CmHy8zG3fwVMC6X8HDwK0LC04GMX/jKVk8fGKCfYgDdmSJvr/iayVGlv+3F/s3wBRlwyHytv9+XYvZYHoCkGvMyqaIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvo9ApgF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003B3C32781
	for <linux-acpi@vger.kernel.org>; Mon,  1 Jul 2024 18:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719857771;
	bh=OtmMFvkYBbM0iWHuxuFadDgmRVK2Q3kzXubTin/P4Vk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rvo9ApgF6jcbCVrrPqQ12itHECrKKUkkFz6dtPl4u+53WmtG9+XPlcwTomOpTYLnv
	 Cux/P6BX42f1ixb/xb5JcVdnKDn/r3Nh2ykFXUL29nXgJTlYCHfVfDxQpRRCUgZMlU
	 OWODJtf500kQ6v2mXe3FS5qpboygYPQ/hOPMJgTenUGbqZi/k7j2wDTukroPTMhEX3
	 HaaY3xN/eBXogh1hoYbKDy7iSBHNADmF6gD5HhKszU7ITvZohFZrMhk+2MSxmpNPVh
	 zr6VyhHx7SHNLr33E4R+0A5JUIorlMQfFFBifn7iroDLiwTNp6NprN/cUidfXuP7zp
	 yYicdPsJMRaaw==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-25cc44857a1so354753fac.3
        for <linux-acpi@vger.kernel.org>; Mon, 01 Jul 2024 11:16:10 -0700 (PDT)
X-Gm-Message-State: AOJu0YxKgpg5vys1dkqiwV8v2QMxpC9SBwBcRlK4Xu+iZrD8LIAx75Mu
	a5x7swPRIhQYuifvj+m7ebTKcJY2g2UArhpPg3VXEYdq5tyxIrUd6BdBmOY/o2LR+L0wm0mL1g8
	8bBFyD6jxx+3Fo2P+poJUnn+fUUQ=
X-Google-Smtp-Source: AGHT+IEdh6bLPuZotLPpl+VvzSJ16JHEWAql8hIA0DuNIAW1z59P2+0rBBVKWg3Wi/H6OaRwYUFQAUe7LQh8ph50v/o=
X-Received: by 2002:a05:6870:4195:b0:25d:d69:eaf with SMTP id
 586e51a60fabf-25db36406d0mr6294873fac.4.1719857770274; Mon, 01 Jul 2024
 11:16:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626135054.1527935-1-prabhakar.pujeri@gmail.com>
In-Reply-To: <20240626135054.1527935-1-prabhakar.pujeri@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Jul 2024 20:15:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gn23n_pvOp=V-Wh2Ec_QqPCrwroBAoBMiARw6XUaEkKg@mail.gmail.com>
Message-ID: <CAJZ5v0gn23n_pvOp=V-Wh2Ec_QqPCrwroBAoBMiARw6XUaEkKg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Optimize Namespace List Sorting in nsrepair2.c
To: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
Cc: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 3:51=E2=80=AFPM Prabhakar Pujeri
<prabhakar.pujeri@gmail.com> wrote:
>
> This patch optimizes the namespace list sorting in acpi_ns_sort_list by
> replacing the direct element swap with the swap() helper function. This
> approach maintains functionality while improving code clarity and
> potentially enhancing performance.
>
> this patch generated using coccinelle.
>
>
> Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
> ---
>  drivers/acpi/acpica/nsrepair2.c | 8 ++------

ACPICA code changes need to be submitted to the upstream ACPICA
project on GitHub.  Once accepted there, a Linux patch can be
submitted with a Link: tag pointing to the corresponding upstream
ACPICA commit.

>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepa=
ir2.c
> index 1bb7b71f07f1..5d56b2fd9151 100644
> --- a/drivers/acpi/acpica/nsrepair2.c
> +++ b/drivers/acpi/acpica/nsrepair2.c
> @@ -875,7 +875,6 @@ acpi_ns_sort_list(union acpi_operand_object **element=
s,
>  {
>         union acpi_operand_object *obj_desc1;
>         union acpi_operand_object *obj_desc2;
> -       union acpi_operand_object *temp_obj;
>         u32 i;
>         u32 j;
>
> @@ -891,11 +890,8 @@ acpi_ns_sort_list(union acpi_operand_object **elemen=
ts,
>                               obj_desc2->integer.value))
>                             || ((sort_direction =3D=3D ACPI_SORT_DESCENDI=
NG)
>                                 && (obj_desc1->integer.value <
> -                                   obj_desc2->integer.value))) {
> -                               temp_obj =3D elements[j - 1];
> -                               elements[j - 1] =3D elements[j];
> -                               elements[j] =3D temp_obj;
> -                       }
> +                                   obj_desc2->integer.value)))
> +                               swap(elements[j - 1], elements[j]);
>                 }
>         }
>  }
> --
> 2.45.2
>
>

