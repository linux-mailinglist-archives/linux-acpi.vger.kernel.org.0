Return-Path: <linux-acpi+bounces-20340-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 475C7D2088F
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 18:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BEE6830090C8
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 17:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA992FF64C;
	Wed, 14 Jan 2026 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBYzHTr4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215CA2F83A7
	for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2026 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768411670; cv=none; b=q7OeEaEGE5Ia+COEC5OtcqBQ2WfuguL/qJUmR2d3Tk2G/Rdvl12xfi5oZ44KMiwlcCSd+TiQe8fYZ/3RxjQpmfvC1uUdY12MxhuJFjssxgtgL13Rs2sGTHDyr+utqTO7sEY58yMxghH2n+fNoavIXKzDDsNDQ7yBPZ4HSOnJqHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768411670; c=relaxed/simple;
	bh=AtMBJUFjx0Qk66tkyHs8WgONAbRSYD0h4JNYvJ2KboE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PSdfqLp1SAR7LsiJsFUDUUZzBs2PTX8HEpLfx3ptlZOQlnR+K1Gm1TpQgsAHPhkt0YW1qs2lPbK7XghxrFMLh1P29IfsZxKpBG1NYrB5+D5CP56SJrycinnyxjU2r68N0HsMQ79I8EUlHz4WkVIys59+G1k0WCMmwqv7wbvst9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBYzHTr4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB64EC19424
	for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2026 17:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768411669;
	bh=AtMBJUFjx0Qk66tkyHs8WgONAbRSYD0h4JNYvJ2KboE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uBYzHTr4AifLiy+uyJydBo4wScNCiSDfbrI5DIFNS+PZyykv0fQduEkCtXQLyIYRZ
	 joL3pwq+aXfm6wfQ7U0JUXceLpfosXJ7MvabUl4jRP2WQ2JmmckWh6Yz8Fk+R/Zj4v
	 hE/YHAtQh3pjLzW8Vpl3XUbgO3O+H31QuHUClxTs8a1V7GCVoNJOJWr0M0u0S/nFUy
	 eP/tWtrEImAZN54cCxOrLPJszwUgIX+zZTmnEuTnkEuYJAfBP0tDH+5tOlvAXjhr2c
	 uFzfVUcbMv8In3gMQQbud2rWi9rNH3efezIDHc6F6lSjBDIsQvaGR53FGk4yZAi+/Y
	 6uojgpszvJjiA==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7c76f65feb5so40401a34.0
        for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2026 09:27:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX+fUYdo8eZRtUVD59G2Pyz6ptgEOqjGLfNOXNbPs880mWrSuUy5dJV5DX7BampyM7TbFd1ZVCVIouM@vger.kernel.org
X-Gm-Message-State: AOJu0YwcWevHYJ9/DOYyQBwrCwaVV7hcPU10KSnCfQimpgvuaqpy1aEb
	R6stGNhkwzyunwY2xdVPyomQqDFULcEoUYXjJtBTsAoyC9rRi/AJ1U/2fa2uv56wih3vVNjILOL
	MCpb8fqdInLXWgfAHsPTX+CgNXxD6GgA=
X-Received: by 2002:a05:6808:181c:b0:459:b564:e20e with SMTP id
 5614622812f47-45c715f3054mr2307374b6e.61.1768411668785; Wed, 14 Jan 2026
 09:27:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125065210.3670266-1-lihuisong@huawei.com> <20251125065210.3670266-2-lihuisong@huawei.com>
In-Reply-To: <20251125065210.3670266-2-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 14 Jan 2026 18:27:37 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j9Mp5AqQwpakVLWDmK10cjOOiKtetfCr2OSSukekdPhQ@mail.gmail.com>
X-Gm-Features: AZwV_Qi7R05XMd3z26R9JiGwThWiB2y_V23dGi_OzYFUWXEpTzExrje2-HIS-AE
Message-ID: <CAJZ5v0j9Mp5AqQwpakVLWDmK10cjOOiKtetfCr2OSSukekdPhQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] ACPI: processor: idle: Relocate and verify acpi_processor_ffh_lpi_probe
To: Huisong Li <lihuisong@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sudeep.Holla@arm.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 7:52=E2=80=AFAM Huisong Li <lihuisong@huawei.com> w=
rote:
>
> The platform used LPI need check if the LPI support and the entry
> method is valid by the acpi_processor_ffh_lpi_probe(). But the return
> of acpi_processor_ffh_lpi_probe() in acpi_processor_setup_cpuidle_dev()
> isn't verified by any caller.
>
> What's more, acpi_processor_get_power_info() is a more logical place for
> verifying the validity of FFH LPI than acpi_processor_setup_cpuidle_dev()=
.
> So move acpi_processor_ffh_lpi_probe() from the latter to the former and
> verify its return.
>
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/acpi/processor_idle.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index 5f86297c8b23..cdf86874a87a 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1252,7 +1252,7 @@ static int acpi_processor_setup_cpuidle_dev(struct =
acpi_processor *pr,
>
>         dev->cpu =3D pr->id;
>         if (pr->flags.has_lpi)
> -               return acpi_processor_ffh_lpi_probe(pr->id);
> +               return 0;
>
>         acpi_processor_setup_cpuidle_cx(pr, dev);
>         return 0;
> @@ -1264,7 +1264,13 @@ static int acpi_processor_get_power_info(struct ac=
pi_processor *pr)
>
>         ret =3D acpi_processor_get_lpi_info(pr);
>         if (ret)
> -               ret =3D acpi_processor_get_cstate_info(pr);
> +               return acpi_processor_get_cstate_info(pr);
> +
> +       if (pr->flags.has_lpi) {
> +               ret =3D acpi_processor_ffh_lpi_probe(pr->id);
> +               if (ret)
> +                       pr_err("Processor FFH LPI state is invalid.\n");
> +       }
>
>         return ret;
>  }
> --

Please reorder this behind the next patch in the series.

