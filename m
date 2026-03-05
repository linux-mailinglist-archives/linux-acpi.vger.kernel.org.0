Return-Path: <linux-acpi+bounces-21433-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GB+zOK7NqWnkFQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21433-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 19:38:38 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FA42170E7
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 19:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72BBE3040FAD
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 18:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F983E95A7;
	Thu,  5 Mar 2026 18:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBBZS9Mp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56E53E7177
	for <linux-acpi@vger.kernel.org>; Thu,  5 Mar 2026 18:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772735881; cv=none; b=Z702Ek/gGa1L0xBa2EBQg3p97/GWKkoe4cJmev0Ov4Xt7UCa43XLe+wky0iQazf6YBupQz5cHPaq01CM2eltia9kL70gZjW9ZKmPRNl0WJ/KkIzUsLsJ4vse6Z6eaYK29FKnWcJrSDlQdRjq4TczMBeXpM+cJnAy5L/Xf/qUki0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772735881; c=relaxed/simple;
	bh=A2K0gpB3CUwXpZuZFC1FlH+kv8a/EelGblysJ35epDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=foLVPeUx91tJ9hhi61Mo726og7sJAv0wpWvgHx44j3kyzJot/fY2G39Kb2EsYKiZ5KPCOpZ1NRCe7R3Nk/YjtEp8m9wCLDxte3znec/n8BSICLLRffNCJ4v9T5aKhK86M6LJlgVIwAshfi0H2mQ0zRCxVOtOgGYZWLNr12As4MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBBZS9Mp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74AE7C116C6
	for <linux-acpi@vger.kernel.org>; Thu,  5 Mar 2026 18:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772735881;
	bh=A2K0gpB3CUwXpZuZFC1FlH+kv8a/EelGblysJ35epDI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DBBZS9MpKACoqCBJLLrTG4uVHoDHPjQXmzOH/6cCMWmy77UNDAvbaDATVm/d5HSSl
	 V2g6Hwi3W3NpMBy5eJ4hxTAg70+9BNgTMsCNHVqjSdPqhUrSt56d0WcZYN2tNBekWu
	 PgFGrZKrXMPQSeDsYflE/QXYACcGCcanWHUcQ0nBWNb0lfT7jYtRGY2DTJgWi+CXku
	 I8r5D/X2HR3PO5FlsnArLfJStJCMHR2oWtKzFxNJec+C1KDcjMIA5UL0GfFaafPVzy
	 vz+rHVx9lg3x7OyiZVwJwm3gGfaGB55w7dEDLSN38EVnpeegvnVIWqNFqz4cftSPak
	 I/18n0L4j2qSQ==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-409de4132b5so2383751fac.1
        for <linux-acpi@vger.kernel.org>; Thu, 05 Mar 2026 10:38:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUw7A0TV7yLuZY8OeS7dbwvgjurue0hLPqgF3vr8TglGxu1ZJp8NUrKyuYmipm2ccuWbq8o0pagn9wu@vger.kernel.org
X-Gm-Message-State: AOJu0YwppRJEKv4SYZO3jdQL0VoQwo4en3CmvmRYP3HZRjq9ZK/FEl7m
	dlF2t6qr0POjtq1iJVhszYXF+PDv+6tZJoy1TrjZyeMUWwdmjm3HiisDum5la/6BjW7Hub2Ot5/
	O4gB+g6va0yOf+GplXujKgzH99WEkRJY=
X-Received: by 2002:a05:6871:8788:b0:409:81eb:cf56 with SMTP id
 586e51a60fabf-416abb66748mr3989211fac.27.1772735878567; Thu, 05 Mar 2026
 10:37:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129041433.3458902-1-lihuisong@huawei.com> <20260129041433.3458902-3-lihuisong@huawei.com>
In-Reply-To: <20260129041433.3458902-3-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 5 Mar 2026 19:37:47 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gfH3+W0tqDytNxiJC0i2sFBMfQ7BsRCHmn-n+2jJo=Bw@mail.gmail.com>
X-Gm-Features: AaiRm52-DYM7jNeQZq3obaItCzG_Ad65vnqSKyzEAX5XHGkxlGHwbgyRbjwJJEw
Message-ID: <CAJZ5v0gfH3+W0tqDytNxiJC0i2sFBMfQ7BsRCHmn-n+2jJo=Bw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ACPI: processor: Remove redundant static variable and
 rename cstate check function
To: Huisong Li <lihuisong@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, bp@alien8.de, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com, zhangpengjie2@huawei.com, wangzhi12@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 64FA42170E7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21433-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 5:14=E2=80=AFAM Huisong Li <lihuisong@huawei.com> w=
rote:
>
> The function acpi_processor_cstate_first_run_checks() is currently called
> only once during initialization in acpi_processor_register_idle_driver().

Not really, it is called in every iteration of the
for_each_possible_cpu() loop in there.

You need to move it out of that loop so the static var can be dropped from =
it.

> Because its execution is already limited by the caller's lifecycle, the
> internal static 'first_run' variable is redundant and can be safely
> removed.  Additionally, the current function name is no longer descriptiv=
e
> of its behavior.  Rename the function to acpi_processor_update_max_cstate=
()
> to better reflect its actual purpose.
>
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/acpi/processor_idle.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index 083f85c0d530..35b55081bc10 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -819,19 +819,13 @@ static void acpi_processor_setup_cstates(struct acp=
i_processor *pr)
>         drv->state_count =3D count;
>  }
>
> -static inline void acpi_processor_cstate_first_run_checks(void)
> +static inline void acpi_processor_update_max_cstate(void)
>  {
> -       static int first_run;
> -
> -       if (first_run)
> -               return;
>         dmi_check_system(processor_power_dmi_table);
>         max_cstate =3D acpi_processor_cstate_check(max_cstate);
>         if (max_cstate < ACPI_C_STATES_MAX)
>                 pr_notice("processor limited to max C-state %d\n", max_cs=
tate);
>
> -       first_run++;
> -
>         if (nocst)
>                 return;
>
> @@ -840,7 +834,7 @@ static inline void acpi_processor_cstate_first_run_ch=
ecks(void)
>  #else
>
>  static inline int disabled_by_idle_boot_param(void) { return 0; }
> -static inline void acpi_processor_cstate_first_run_checks(void) { }
> +static inline void acpi_processor_update_max_cstate(void) { }
>  static int acpi_processor_get_cstate_info(struct acpi_processor *pr)
>  {
>         return -ENODEV;
> @@ -1391,7 +1385,7 @@ void acpi_processor_register_idle_driver(void)
>                 if (!pr)
>                         continue;
>
> -               acpi_processor_cstate_first_run_checks();
> +               acpi_processor_update_max_cstate();
>                 ret =3D acpi_processor_get_power_info(pr);
>                 if (!ret) {
>                         pr->flags.power_setup_done =3D 1;
> --
> 2.33.0
>
>

