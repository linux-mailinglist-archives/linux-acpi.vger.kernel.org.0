Return-Path: <linux-acpi+bounces-18103-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 27795BFCACD
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 16:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B9B64F488A
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 14:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CE834A3AC;
	Wed, 22 Oct 2025 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XI/uhcyF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02D833F8DC
	for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761144561; cv=none; b=mqPxcci2ZQIaMMGfeYw6UT2aZGpc1at0S6CE5/6FAOYk1FjGoo2n0syjaURJ1n1DuA4GkdIFbYtInjQFL2eJs4qMqZIzpgTYACMWMeu8CF6VpBuqfGBrEdF4g4WOjF5oda76pwirRFMReZYoU0Q57fvFQtvKY3TxRWMtflyh8kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761144561; c=relaxed/simple;
	bh=ImEiLm7Drt2dfsAciETP34uRxZUNKlR7SI51bEybZBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kVok+jxWbYAY77eBReP7s0IDloxAH0OH4bDoJrIG36bxtMJ/lNt9Me0VeaTxhpsJJb00g55+HyiDU8eMfTHb+Ek/A8pdT1OF2SRdjAXCB+yjr4knZOOe69u7ZjVTda9WFj/jwwukWgKVnSet1jXTKy7b8QSnNPWgVQIAnHl/3Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XI/uhcyF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CD5C113D0
	for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 14:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761144561;
	bh=ImEiLm7Drt2dfsAciETP34uRxZUNKlR7SI51bEybZBY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XI/uhcyFWN5+N44JeFwkXIpOOSVg743wVIpQcmJrjNe70kc3f83uPMsceYrzAGG6L
	 OU7CmJHSoxY6zUOqymxJo/ABH6858dmnxd+PMpA2ovp5kxwspBVa7c9FR8O/5K33QC
	 194/vSX1T6G9DM65gfGsUFlLvhT0iotFIb07I2/4dQmfcNx6zSsa5MSSTy5Bm4lVq1
	 vGyXjvAqZON7RxzYQoUirtfZ9hTSUoEs6uJr0/KK3D0djpN/8GW3YiRROJAbozyywf
	 1Hne/807eyE+LMKIsEaROO3taAjRpdIZAsq6Igvns3dBnjt32bo8tcdwWzhxwBFb8e
	 GWhMYlZlfUc6g==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-443afb2334bso2611965b6e.3
        for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 07:49:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXmccd9DTowd8eaL79u0O6thqkc3e/Ku1llU8mDAZXrakAGHOXXtu4qqc74hgurMMb1sYqNnCyhVFla@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyj6/EKiwEr7tdoaVHcHCQWrjOw8i+O/t+xFdKmYZpIgrPdafy
	Cmc6d+NNZmJvv1SHrkI4wT1lfYaHzSg9YjT8fgZyBGUG4YlwVyykox4XVctU/WUNjWxNaBWPRZY
	ekrOdAAWIZCkry66PQDZab1pQupaYli0=
X-Google-Smtp-Source: AGHT+IEi2AgiNYGLe+Y5LsmuUxd00vDbHtazsPbnZGEqn5G4oFCDEYtJ9h/inemvnNSvh7g83pOIB+d0kE/CsGuMT1c=
X-Received: by 2002:a05:6808:30a1:b0:43f:42d4:aca5 with SMTP id
 5614622812f47-443a309898fmr8052852b6e.37.1761144560573; Wed, 22 Oct 2025
 07:49:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929093754.3998136-1-lihuisong@huawei.com> <20250929093754.3998136-5-lihuisong@huawei.com>
In-Reply-To: <20250929093754.3998136-5-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 22 Oct 2025 16:49:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0htzNf2nPT2GQ8aaunp9gfrFbfZzMaMACA=JaXLBiqz9A@mail.gmail.com>
X-Gm-Features: AS18NWAvm7p6ma7WJj7phML1NVFtBll2ih0mDP2cJay9Ctfi3-ej0UTb3GVilHI
Message-ID: <CAJZ5v0htzNf2nPT2GQ8aaunp9gfrFbfZzMaMACA=JaXLBiqz9A@mail.gmail.com>
Subject: Re: [PATCH v1 4/9] ACPI: processor: idle: Move the initialization of
 state->flags to acpi_processor_setup_cstates
To: Huisong Li <lihuisong@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sudeep.Holla@arm.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 11:38=E2=80=AFAM Huisong Li <lihuisong@huawei.com> =
wrote:
>
> The acpi_processor_setup_cpuidle_cx() is called by
> acpi_processor_setup_cpuidle_dev() which is used to setup cpuidle device.
> However, acpi_processor_setup_cpuidle_cx() also initializes the states
> in acpi_idle_driver, which isn't good. And acpi_processor_setup_cstates()
> is aimed to initializes cstates in acpi_idle_driver. So the initializatio=
n
> of state->flags should be here.
>
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/acpi/processor_idle.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index f36f9514b6c7..5684925338b3 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -737,13 +737,11 @@ static int acpi_processor_setup_cpuidle_cx(struct a=
cpi_processor *pr,
>  {
>         int i, count =3D ACPI_IDLE_STATE_START;
>         struct acpi_processor_cx *cx;
> -       struct cpuidle_state *state;
>
>         if (max_cstate =3D=3D 0)
>                 max_cstate =3D 1;
>
>         for (i =3D 1; i < ACPI_PROCESSOR_MAX_POWER && i <=3D max_cstate; =
i++) {
> -               state =3D &acpi_idle_driver.states[count];
>                 cx =3D &pr->power.states[i];
>
>                 if (!cx->valid)
> @@ -751,15 +749,6 @@ static int acpi_processor_setup_cpuidle_cx(struct ac=
pi_processor *pr,
>
>                 per_cpu(acpi_cstate[count], dev->cpu) =3D cx;
>
> -               if (lapic_timer_needs_broadcast(pr, cx))
> -                       state->flags |=3D CPUIDLE_FLAG_TIMER_STOP;
> -
> -               if (cx->type =3D=3D ACPI_STATE_C3) {
> -                       state->flags |=3D CPUIDLE_FLAG_TLB_FLUSHED;
> -                       if (pr->flags.bm_check)
> -                               state->flags |=3D CPUIDLE_FLAG_RCU_IDLE;
> -               }
> -
>                 count++;
>                 if (count =3D=3D CPUIDLE_STATE_MAX)
>                         break;
> @@ -818,6 +807,15 @@ static int acpi_processor_setup_cstates(struct acpi_=
processor *pr)
>                 if (cx->type !=3D ACPI_STATE_C1 && !acpi_idle_fallback_to=
_c1(pr))
>                         state->enter_s2idle =3D acpi_idle_enter_s2idle;
>
> +               if (lapic_timer_needs_broadcast(pr, cx))
> +                       state->flags |=3D CPUIDLE_FLAG_TIMER_STOP;
> +
> +               if (cx->type =3D=3D ACPI_STATE_C3) {
> +                       state->flags |=3D CPUIDLE_FLAG_TLB_FLUSHED;
> +                       if (pr->flags.bm_check)
> +                               state->flags |=3D CPUIDLE_FLAG_RCU_IDLE;
> +               }
> +
>                 count++;
>                 if (count =3D=3D CPUIDLE_STATE_MAX)
>                         break;
> --

Applied with rewritten subject and changelog as 6.19 material, thanks!

