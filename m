Return-Path: <linux-acpi+bounces-8222-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6C1974217
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Sep 2024 20:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E5CE1C256A0
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Sep 2024 18:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E551A4E70;
	Tue, 10 Sep 2024 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0xMwiaQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3017816F27F;
	Tue, 10 Sep 2024 18:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725992813; cv=none; b=CdoE64E8g5fvasVuoivjCq5BIZ/WgBTSJj0PNksXL29Gk7dYdXXJHJA1jKkU9onNvjocaMipBewljkJBHtM7fmyeeJSAh2yIolCnV1eX6muoidP6DzbNjDJA/6A7vjmYLs7rTSW4aQC6Fuw62rtTlmefnbdpw1Lsjl4Q7zilRUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725992813; c=relaxed/simple;
	bh=jz3VZRhNBfWywJI7JxqA/XXrvUS86hBZ1FzrBWdED0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aJrZFb+brm737ugBfuHxo9JHa5ATF6c40NzOutUou08KUvba9kK6MRa6FiIlS1P4SbGYOqU7ZhRHfMD9IXsYVMWWxCAfF7r2zrQVPzEzI+AzxkIfuz7R1QLs8AWT78gDLIa79mQVF3LtFjEfE0El6Fim/bzP7Ca2nRU0vlrw7q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0xMwiaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7241C4CEC4;
	Tue, 10 Sep 2024 18:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725992812;
	bh=jz3VZRhNBfWywJI7JxqA/XXrvUS86hBZ1FzrBWdED0g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V0xMwiaQhkzzx0QTztQsm/Bmi9IJL+LAwDYVp08Y9zxetqJk9GSQnOr1SfPKJxLY/
	 JcekjeuQgJtW+VnYZdcitu9KJA18vaTYUQlswI0SnnYWYNMK6TNRx8YbuW65SsvYhs
	 1WqJ1d36Hrg3mKSEIogQdtOYYJzVN22I+8pxZl37BwPbAnRj02wOJs1WZgdULg0QqY
	 MACd4vgqg0UDjc+w1CkPGcqUE5HUuId/fKnpwtTQNQQQbfFCkmuw5i1ntbi2KEvUSX
	 7a5Z0NivoXQC3YOS8LL8EAZDDSRPilT9eRxGyBUxBMeIMrycZWqaRg7AMoklaG6Vac
	 aFT4onAnehcuQ==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5e1d5acb04bso1465649eaf.0;
        Tue, 10 Sep 2024 11:26:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX7ljuxE3E9y5KIyXOCMZ3nzDcAERzqtG8DBkmqYyHOklfJqBTjT2QsW6qdo/MJHN3LwaZDxm8fNAn9@vger.kernel.org, AJvYcCXEaPj9xeFb+FawiwPvX548ubieUAUOP37AYAY0k6/odXmzq6S58+MoR6HiBPdZDeFPMKvkXRCvpHx5+Q+l@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7N7nFyIVzKw+zOJJ7BIxR1wfYT2/JeTymR68eyay0cUUZVZiH
	y8bjsEadNGavW3R8yE6qd+m/+pItHJxrUE0JNo6OcOBDWgVNaFFcEUo/J581gjLeIVqqxG/4KWD
	56p/wnUTJHSd9HWAYg8WnCM+LPxQ=
X-Google-Smtp-Source: AGHT+IG/DhjptzeoHT8dxB/41EeapT55Z7O/b5vx8QovBr1jkm+ujEdksGh9VIDEj0+wfRAwy9a62vc2ahVXoQauxkA=
X-Received: by 2002:a05:6870:9a96:b0:268:2189:f0d with SMTP id
 586e51a60fabf-27b82fc5ab6mr15855374fac.33.1725992811995; Tue, 10 Sep 2024
 11:26:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910031524.106387-1-superm1@kernel.org>
In-Reply-To: <20240910031524.106387-1-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Sep 2024 20:26:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gvGyrT854c7jE0x8uLP246TowxURAGo785GXEvaAvXAQ@mail.gmail.com>
Message-ID: <CAJZ5v0gvGyrT854c7jE0x8uLP246TowxURAGo785GXEvaAvXAQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: CPPC: Add support for setting EPP register in FFH
To: Mario Limonciello <superm1@kernel.org>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, perry.yuan@amd.com, gautham.shenoy@amd.com, 
	luke@ljones.dev, Mario Limonciello <mario.limonciello@amd.com>, al0uette@outlook.com, 
	vderp@icloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 5:15=E2=80=AFAM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> Some Asus AMD systems are reported to not be able to change EPP values
> because the BIOS doesn't advertise support for the CPPC MSR and the PCC
> region is not configured.
>
> However the ACPI 6.2 specification allows CPC registers to be declared
> in FFH:
> ```
> Starting with ACPI Specification 6.2, all _CPC registers can be in
> PCC, System Memory, System IO, or Functional Fixed Hardware address
> spaces. OSPM support for this more flexible register space scheme
> is indicated by the =E2=80=9CFlexible Address Space for CPPC Registers=E2=
=80=9D _OSC
> bit.
> ```
>
> If this _OSC has been set allow using FFH to configure EPP.
>
> Reported-by: al0uette@outlook.com
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218686
> Suggested-by: al0uette@outlook.com
> Tested-by: vderp@icloud.com
> Tested-by: al0uette@outlook.com
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/cppc_acpi.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index dd3d3082c8c7..3b5b695bb80b 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -103,6 +103,11 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_pt=
r);
>                                 (cpc)->cpc_entry.reg.space_id =3D=3D     =
   \
>                                 ACPI_ADR_SPACE_PLATFORM_COMM)
>
> +/* Check if a CPC register is in FFH */
> +#define CPC_IN_FFH(cpc) ((cpc)->type =3D=3D ACPI_TYPE_BUFFER &&         =
   \
> +                               (cpc)->cpc_entry.reg.space_id =3D=3D     =
   \
> +                               ACPI_ADR_SPACE_FIXED_HARDWARE)
> +
>  /* Check if a CPC register is in SystemMemory */
>  #define CPC_IN_SYSTEM_MEMORY(cpc) ((cpc)->type =3D=3D ACPI_TYPE_BUFFER &=
&  \
>                                 (cpc)->cpc_entry.reg.space_id =3D=3D     =
   \
> @@ -1486,9 +1491,12 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ct=
rls *perf_ctrls, bool enable)
>                 /* after writing CPC, transfer the ownership of PCC to pl=
atform */
>                 ret =3D send_pcc_cmd(pcc_ss_id, CMD_WRITE);
>                 up_write(&pcc_ss_data->pcc_lock);
> +       } else if (osc_cpc_flexible_adr_space_confirmed &&
> +                  CPC_SUPPORTED(epp_set_reg) && CPC_IN_FFH(epp_set_reg))=
 {
> +               ret =3D cpc_write(cpu, epp_set_reg, perf_ctrls->energy_pe=
rf);
>         } else {
>                 ret =3D -ENOTSUPP;
> -               pr_debug("_CPC in PCC is not supported\n");
> +               pr_debug("_CPC in PCC and _CPC in FFH are not supported\n=
");
>         }
>
>         return ret;
> --

Applied as 6.12 material, thanks!

