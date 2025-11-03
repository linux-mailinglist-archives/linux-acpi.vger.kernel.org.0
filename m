Return-Path: <linux-acpi+bounces-18469-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF3FC2D896
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 18:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F27A7189841D
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 17:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A55623236D;
	Mon,  3 Nov 2025 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQG7OQpq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D940C21E0BB
	for <linux-acpi@vger.kernel.org>; Mon,  3 Nov 2025 17:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762192210; cv=none; b=HBdR/i8zGS5fUTZgTqC2Imvr0EuZ9hsc/5uwO+MxdWiBlymcRqBjbHkTueCER+MZnllSxkO7l3ceomILd712shC1oibgrnSoOWeBqhMlZTPM6nNGp5JJixqfvkTulqQgTZ3d2QROd2kRI0sq8Kcyb8tPyaxab0c/VNHWhP17qH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762192210; c=relaxed/simple;
	bh=3RDSJO3dW79ZO7QawchirhZsh2Mwn+dhYIq6GuY+Ws0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/GAN1cdhduYLpmHB4A7lv49ZIepTjdlvWu6nQt58lnRpBGlTk/zwPT/9Sc1OhV3L/47efhmblE8k2pFMtFTrMdCyfAafaSyR5Dr9QnxKb+OktABwvBICQi3uFlwXIXEoubHQGk/u/r7/8YfvkE9fS4axC2dygpFm0i8ilMoDe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQG7OQpq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E85BC4CEE7
	for <linux-acpi@vger.kernel.org>; Mon,  3 Nov 2025 17:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762192210;
	bh=3RDSJO3dW79ZO7QawchirhZsh2Mwn+dhYIq6GuY+Ws0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vQG7OQpqSoUnlWt10/m5/D/mokdpIGi65qlkBFvXaYhqzVgjFXlLy2wsYTQlOv+h/
	 g/cO1orjbLH80gQSNzWmcUKCPHJemB+skQSzPWKu+fh39aXeYedL2i0pqS+PMw4fb4
	 laaJ05qKUqTmouOQjYV+GessdR2aWamoqyzc2YW/bchIsoj/k/ZgvzPL+PZPd/bF2N
	 cXbUMns1ESBosODyL/wCNPmVn7BJO/h8LyhUG639rIBeWUAmeuZU6V0FKYNHyJ8Clb
	 /3WCS9zFC2kOPYNX5rtTTnQWbDOo99urPoDTvCIFTIVyx9yaMeHprTcDiIp9zCbUw4
	 rH86ThoYIIVmg==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-654ecc2af8eso1270255eaf.1
        for <linux-acpi@vger.kernel.org>; Mon, 03 Nov 2025 09:50:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUNNptqpHPEJiDB+aMT9XsYcDB7djVXHhZ5qN1JJtO9J3OBuHe7mBOlsIOODTa3tqKeMvfSFX+8hgyy@vger.kernel.org
X-Gm-Message-State: AOJu0YzNlK98+5qTT1QosI4ybZh3xRBaRMuH03ulR5IQyYuh+AND77cj
	oEJ+5uYBPeKPGLky9SZneIO+igsmTjI8lo5e8itfyzUvAZYNlTbIbb3QnvwjrEO31Lm4XTVZfIA
	1/11zXhoDyqxRrOQ7wXHm0UGpqKwjbtU=
X-Google-Smtp-Source: AGHT+IHZiMJX3Ug70TwzaSeN/dUlQ3+MqhN+V/T0B5U8eh1hGH8ikUPu69epuWzWoQb5+05tmXPc1l4NTMXMJhboGns=
X-Received: by 2002:a05:6808:3a0f:b0:44d:bedc:4af5 with SMTP id
 5614622812f47-44f95df9edcmr5589796b6e.6.1762192209733; Mon, 03 Nov 2025
 09:50:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103084244.2654432-1-lihuisong@huawei.com> <20251103084244.2654432-2-lihuisong@huawei.com>
In-Reply-To: <20251103084244.2654432-2-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 3 Nov 2025 18:49:57 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j5_+gOuuW8PdyzjOJ+Q__k9PrpM3X6=Q0d50u+d8SPpg@mail.gmail.com>
X-Gm-Features: AWmQ_blStaHSC75ar4xN4HXlun_ZKlvmyE_0Z32Z95x6ZxrtoYEIUoEo3LqN5cc
Message-ID: <CAJZ5v0j5_+gOuuW8PdyzjOJ+Q__k9PrpM3X6=Q0d50u+d8SPpg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] ACPI: processor: idle: Mark the state as invalid
 if its entry method is illegal
To: Huisong Li <lihuisong@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sudeep.Holla@arm.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 9:42=E2=80=AFAM Huisong Li <lihuisong@huawei.com> wr=
ote:
>
> According to ACPI spec, entry method in LPI sub-package must be buffer
> or integer. And the entry method is very key in cpuidle. So mark the stat=
e
> as invalid.
>
> Fixes: a36a7fecfe60 ("ACPI / processor_idle: Add support for Low Power Id=
le(LPI) states")
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/acpi/processor_idle.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index 341825e8ac63..9f1040eac051 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -956,6 +956,9 @@ static int acpi_processor_evaluate_lpi(acpi_handle ha=
ndle,
>                         lpi_state->entry_method =3D ACPI_CSTATE_INTEGER;
>                         lpi_state->address =3D obj->integer.value;
>                 } else {
> +                       pr_debug("Entry method of state-%d is illegal, di=
sable it.\n",
> +                                state_idx);
> +                       lpi_state->flags =3D 0;

Why does lpi_state->flags need to be cleared, isn't it 0 already?

>                         continue;
>                 }
>
> --

