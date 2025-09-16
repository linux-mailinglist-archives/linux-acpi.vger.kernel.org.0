Return-Path: <linux-acpi+bounces-17015-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7656B59512
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 13:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47DE31BC747C
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 11:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1E82BF3CA;
	Tue, 16 Sep 2025 11:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIKp7cKT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E9328CF42
	for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2025 11:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758021855; cv=none; b=uSI129XX55DnkqsH4jbCbb4fd5HUPcTeklNjmE4OKD19t9yjgFecKSpHgtbNuOrzCpaquFa7Fs+Y+kN+ICNspZoRcHa3STRV5tLf0UUiKdj8zNYoFfQCeou+gFnU4Em3fqtIasIeAxvkWWpGO46Sz6ONwtkob9uuYw1zAd2bP+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758021855; c=relaxed/simple;
	bh=ri6AVRKXyTKBgCwmHI/SW4DVsnfpryJDU41ilbjXu4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VWjUBlxaeFUh2SAZnKYBx/1kerYdlcre45P+uJJAgvARt3CmgJCJGYiQJtszR7btCpKSEE6u6qbl2fFyTZCTCVBYkOO5AMtorTsfBVtePU9ecqAJED8x9HG3H9zP2kKVBTNeCsDxMAuuUR1JOSMvoMegVTfgYSnmPa2lT3CIKsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIKp7cKT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9CDC4CEF0
	for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2025 11:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758021854;
	bh=ri6AVRKXyTKBgCwmHI/SW4DVsnfpryJDU41ilbjXu4A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KIKp7cKTNu+C7bqB59oli4SG0muh6v73HVG6FS7dwrFtfFPCOwykxL6w2EMc18XH1
	 T3+1+weZ4mwzgTFri6SF8zn/F+OND1wm7xXJq5+jwb0TZGAgp3Zv1pbodCnR7UgK2I
	 iNd6Xhyqk28rf7GyKUy5lmpbLRWZm1O0HLO1GfmTiCqIjEEkf8x2npilwV/5re8fNF
	 ljrszUgUNLvZy5i9u9PkyyVjCbFAjeoPvKubOTi6QjCS44XcatYoCatkfReGh/8MdP
	 7IsFDernnusRGcCMgZ68S9Xj8iZ6fIQR0v+i3L7lDr1KI34XiUh6MnN0UUA3kKsafA
	 h8Z6Uy2GA1/mA==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6234b7bdf3dso637766eaf.0
        for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2025 04:24:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWwjVi1YbjLBBqyXnK9qU1CK1LGYkjZ1GKfGqnQL6CYI2PJ2pChrbvjb1CSnWaC+2j+pUCP8I16QUus@vger.kernel.org
X-Gm-Message-State: AOJu0YyPnt43N/61khNc5J0YvKXdTK/vVe6rdJ0kNQVtBwMtqR3NiSqe
	+M8QBCijTUpxtpImXXQxGSIjJ8JWhbAsofWjo7oE4Xe0thlNSRdSN9KlyKbNwbtGOvuL0Wyx7kJ
	g5faBFtbELvBQphggJ3bfEHIc8joUD4s=
X-Google-Smtp-Source: AGHT+IF1t6zEKkRBl06Nw5QW5hjVAyjkmaJDelIaS5kyId5hNLkCVS1AY4hIFc6WhMqubozU+x0DTfa8tO91qWrE8o4=
X-Received: by 2002:a05:6820:618:b0:621:aadc:8d28 with SMTP id
 006d021491bc7-621bed8ff65mr6961935eaf.4.1758021853902; Tue, 16 Sep 2025
 04:24:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915204318.696058-1-superm1@kernel.org> <20250915204318.696058-3-superm1@kernel.org>
In-Reply-To: <20250915204318.696058-3-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 16 Sep 2025 13:24:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0haE_XDZa8r+Dy_jrtGhqqgwDZVJMnpapA7xdESycWWrQ@mail.gmail.com>
X-Gm-Features: AS18NWBtbQNDUTtPjjj_MK_lIwISjmKDtgatKOIxtoWR-vTtivac9kYkKyQzgXw
Message-ID: <CAJZ5v0haE_XDZa8r+Dy_jrtGhqqgwDZVJMnpapA7xdESycWWrQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ACPI: processor: Add support for ACPI C4 state
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 10:43=E2=80=AFPM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> The _CST object described in the ACPI specification [1] allows processors
> to support any arbitrary number of power states that are described by
> a package describing the register used, the type of C-state, latency
> and the power consumption.
>
> Currently the Linux kernel supports up to ACPI C3, and if a system
> supports any further states they are ignored.  This causes problems on
> some AMD hardware which can support up to ACPI C4.
>
> AMD systems that support up to C3 will enter CPUOFF and VDDOFF
> when entering C3. Systems that support up to C4 will enter CPUOFF
> when going to C3 and will enter VDDOFF when entering into C4.
>
> The existing semantics for bus mastering around C3 are also valid for C4,
> so instead of hardcoding to C3, map then >=3D C3. In the case of s2idle
> detect the deepest C-state supported and enter the deepest.
>
> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/08_Processor_Configur=
ation_and_Control/declaring-processors.html?#cst-c-states [1]
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  drivers/acpi/processor_idle.c | 10 +++++++---
>  include/acpi/actypes.h        |  5 +++--
>  2 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index 5dacf41d7cc0a..537b0119535ea 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -444,6 +444,10 @@ static int acpi_processor_power_verify(struct acpi_p=
rocessor *pr)
>                 case ACPI_STATE_C3:
>                         acpi_processor_power_verify_c3(pr, cx);
>                         break;
> +               case ACPI_STATE_C4:
> +                       if (!cx->latency || !cx->address)
> +                               break;
> +                       cx->valid =3D 1;
>                 }
>                 if (!cx->valid)
>                         continue;
> @@ -685,7 +689,7 @@ static int __cpuidle acpi_idle_enter(struct cpuidle_d=
evice *dev,
>                 return -EINVAL;
>
>         if (cx->type !=3D ACPI_STATE_C1) {
> -               if (cx->type =3D=3D ACPI_STATE_C3 && pr->flags.bm_check)
> +               if (cx->type >=3D ACPI_STATE_C3 && pr->flags.bm_check)
>                         return acpi_idle_enter_bm(drv, pr, cx, index);
>
>                 /* C2 to C1 demotion. */
> @@ -708,7 +712,7 @@ static int __cpuidle acpi_idle_enter_s2idle(struct cp=
uidle_device *dev,
>  {
>         struct acpi_processor_cx *cx =3D per_cpu(acpi_cstate[index], dev-=
>cpu);
>
> -       if (cx->type =3D=3D ACPI_STATE_C3) {
> +       if (cx->index =3D=3D drv->state_count - 1) {
>                 struct acpi_processor *pr =3D __this_cpu_read(processors)=
;
>
>                 if (unlikely(!pr))
> @@ -754,7 +758,7 @@ static int acpi_processor_setup_cpuidle_cx(struct acp=
i_processor *pr,
>                 if (lapic_timer_needs_broadcast(pr, cx))
>                         state->flags |=3D CPUIDLE_FLAG_TIMER_STOP;
>
> -               if (cx->type =3D=3D ACPI_STATE_C3) {
> +               if (cx->type >=3D ACPI_STATE_C3) {
>                         state->flags |=3D CPUIDLE_FLAG_TLB_FLUSHED;
>                         if (pr->flags.bm_check)
>                                 state->flags |=3D CPUIDLE_FLAG_RCU_IDLE;
> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
> index 8fe893d776dde..6c9f472af482c 100644
> --- a/include/acpi/actypes.h
> +++ b/include/acpi/actypes.h
> @@ -600,8 +600,9 @@ typedef u64 acpi_integer;
>  #define ACPI_STATE_C1                   (u8) 1
>  #define ACPI_STATE_C2                   (u8) 2
>  #define ACPI_STATE_C3                   (u8) 3
> -#define ACPI_C_STATES_MAX               ACPI_STATE_C3
> -#define ACPI_C_STATE_COUNT              4
> +#define ACPI_STATE_C4                   (u8) 4
> +#define ACPI_C_STATES_MAX               ACPI_STATE_C4
> +#define ACPI_C_STATE_COUNT              5

Don't you need to update ACPICA accordingly?

>
>  /*
>   * Sleep type invalid value
> --

The current point in the cycle is kind of unsuitable for changes like
this.  I'd prefer to revisit it after 6.18-rc1.

