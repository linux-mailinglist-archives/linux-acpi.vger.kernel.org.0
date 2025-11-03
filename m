Return-Path: <linux-acpi+bounces-18467-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 229A0C2D295
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 17:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE18F1888B5E
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 16:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53FF31A058;
	Mon,  3 Nov 2025 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuWbkaSQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD26031DDB9
	for <linux-acpi@vger.kernel.org>; Mon,  3 Nov 2025 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187576; cv=none; b=Qc41qnnpzD0kh25bhEIiqcMOAS5hNtxhf44IVSCrZ7E5VZCzibuQxHrBDy+/MLTEhRpPn9Yr1mOO37+DPpxH2ba7oeFYNzYF2ah3MNQE/Y6bcT6AjZVv5togaWSvHjACo7AloyR2dsPf331pL7SvcaEKvWJBQWuGlbPyrPhR/+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187576; c=relaxed/simple;
	bh=hfsFJ0JmsaHcn92cUkxmK7bOCu0BvRvBVwUEixHaRuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BVWXR61TuOmmbNxiNGpQjSg2CXP07lRBD1E6MsSPGK4rOTc5xMSh5pIHTC1+llHy+F+6KrNpn6XVoMj79C05Qc+9UlKECF94h/JU9scmcpleJ2oaSkk00IEvHEIIbUk/zopQfKOTO2VJPlU+ZvWgXGgbBYRi8yF7TwT3rePXR/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuWbkaSQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61BABC16AAE
	for <linux-acpi@vger.kernel.org>; Mon,  3 Nov 2025 16:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762187576;
	bh=hfsFJ0JmsaHcn92cUkxmK7bOCu0BvRvBVwUEixHaRuo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RuWbkaSQnN9gm2oyfmOdumljiA2KF97l/oX2aKh4tbtTMH1WnUdrSCjEeUdvysg5u
	 nC3Qw6SxQT8sKwK6ffWnNP5keEOrqW52HbE3NDaRd9dbMSkcDIHjF6h276wJf6+sTz
	 P5tc4+Pmuyy/V2d5bMnDIjK1eFI1ZaNSuMzHPQ98SXcF8PnTuhCv8G2I0NmhnVeaPz
	 3vwAou38zbxobafSsG5olqCmjF+sHUfadvytjE2lrR/HApJXg4C0cvH+643J3BWAPB
	 bZKRQP0eQghuLTtKY5tG4yVMEBUh9+3ZdZ4+xB5oMKmskoZsyyCguv6adgkVJFneBZ
	 mnG9MINxZ/L1w==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3d1e68f7a6cso2798596fac.3
        for <linux-acpi@vger.kernel.org>; Mon, 03 Nov 2025 08:32:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUlEU/kfIqJKl8D9E3TXJSugj9AU7eIR+JGEOkH3xcU/0wmkRTs7TXz2LYzrTbsv2Vx5fcguvsJSvDu@vger.kernel.org
X-Gm-Message-State: AOJu0YwxrUZcVHpOpHYjfaWM2lFYk6Wy7pWikplDNaKBydgMCa1ylj45
	hsrgOTBzdIT5RaIfFDc0z+BMuHlMEH707TQg8ejMGZ/tpvrvC0HE7jeHwFMFX5LYzM9PwCH8qi3
	v1rVei4GjybhEApWcbuNefaaMyTnAcoc=
X-Google-Smtp-Source: AGHT+IGScnDEu+8/ixwFRFtuzjgUYukaYh32bsn+tYEEAv/30JtDZAtMc7syra+yFCuWLNC2D3p9QiuPabnNObc9z3w=
X-Received: by 2002:a05:6870:558a:b0:322:5678:8245 with SMTP id
 586e51a60fabf-3dacbfabc55mr5867463fac.31.1762187575743; Mon, 03 Nov 2025
 08:32:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aQSzr4NynN2mpEvG@stanley.mountain>
In-Reply-To: <aQSzr4NynN2mpEvG@stanley.mountain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 3 Nov 2025 17:32:44 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hi_Sa6KW=kOto0Hm5-D85=8z30Oobhtt3yKNwL9VZ6nw@mail.gmail.com>
X-Gm-Features: AWmQ_bkzBR_vT9YRBHw5a7-Ze_HqzL-yDSNjkE0Ua44s4bQH3pnPsI174Xdm5hE
Message-ID: <CAJZ5v0hi_Sa6KW=kOto0Hm5-D85=8z30Oobhtt3yKNwL9VZ6nw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: SBS: Fix present test in acpi_battery_read()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, 
	Harshit Mogalapalli <harshit.m.mogalapalli@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 2:03=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> The battery->present variable is a 1 bit bitfield in a u8.  This means
> that the "state & (1 << battery->id)" test will only work when
> "battery->id" is zero, otherwise ->present is zero.  Fix this by adding
> a !!.
>
> Fixes: db1c291af7ad ("ACPI: SBS: Make SBS reads table-driven.")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> This is a new static checker warning that Harshit and I wrote.  It's
> untested.
>
>  drivers/acpi/sbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
> index a3f95a3fffde..d3edc3bcbf01 100644
> --- a/drivers/acpi/sbs.c
> +++ b/drivers/acpi/sbs.c
> @@ -487,7 +487,7 @@ static int acpi_battery_read(struct acpi_battery *bat=
tery)
>                 if (result)
>                         return result;
>
> -               battery->present =3D state & (1 << battery->id);
> +               battery->present =3D !!(state & (1 << battery->id));
>                 if (!battery->present)
>                         return 0;
>
> --

Applied as 6.18-rc material, thanks!

