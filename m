Return-Path: <linux-acpi+bounces-21432-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKUwEgzKqWkAFAEAu9opvQ
	(envelope-from <linux-acpi+bounces-21432-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 19:23:08 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8D2216F2C
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 19:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 972F0303AF10
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 18:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E123E0C48;
	Thu,  5 Mar 2026 18:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6XPWmj9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121D63A872F
	for <linux-acpi@vger.kernel.org>; Thu,  5 Mar 2026 18:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772734984; cv=none; b=UF6gnZ7LyUyWrGgIzNIhfvU1MxbeQTZgaHHugPDfqyRt70nM2yZU+AUGqj+LmjKC7rghLPCYVaD/pnnrWcoiUmwVZ7Ufdl4kcYyl/S75qD48lOMnqrGSHR0+nB8vXm+1b0MJuZPAwkxRLz76vGkM73u3oKHsAwq1N6vZpOladI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772734984; c=relaxed/simple;
	bh=AmaY+4y5ScJk3236C8h+lJUiKycMwR16eX7fHh5Bwsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hh2NmRu1xWdkwqnbYS4a5JproGqI/nWUT7889LV0K6ftmqok3Pu4RSkfBJJZHnaGIwrYGycXHrqzl4pht98QZgXylObghS9kOx3e80n1HHsBSv8LxgU25xPHmj/+XlclgoN0I9sAm2YS6LWatu52brsCRBXfohZPScoRx5Efwv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6XPWmj9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DBDC19422
	for <linux-acpi@vger.kernel.org>; Thu,  5 Mar 2026 18:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772734983;
	bh=AmaY+4y5ScJk3236C8h+lJUiKycMwR16eX7fHh5Bwsc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=q6XPWmj9y5RU+syusHac55hUjkWwkqxNx2uVAvVttEdf52GaGJw8B+DHZVv1dJpnd
	 801KnuUGSX2tglpma2oCFmI1A74pAhY7nQsQW+1T/4SMIADLpTISLh31sDmf3qmGur
	 gvX1dVs65Jm1xV3p039btsqB7FzlqqETiHlznWvoy0Ei5R4sSOcif7SZkfQTC/RKOS
	 +j9mdQkHDKIJrp5YedeOpQpAUoMqzJ0JvooRVHjIFCfuDNkTzcb1vezwqW3cRlHT+c
	 8GUWrK7sbPqWcCU/JIw+RColPhTiafo3ExSXI40XodD0vPMgrJhoalOQ6QMojfli32
	 LENYwpSIVBgFw==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-40fb2789476so2821520fac.1
        for <linux-acpi@vger.kernel.org>; Thu, 05 Mar 2026 10:23:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXX/j/jaH6mzZkINl0DlVgkY22V9E5L12MUANJBM/PCQ9NIWWootilD3IcJEkwnAEdMOUtCNJkL9dkM@vger.kernel.org
X-Gm-Message-State: AOJu0YwSRCpVtysc7zZaoSF3gtAftVFJoDQBtn6xQ6HsyVFfWMeUaAYH
	Zy5IvbQnoNlq7Z9CRMLfMysTDayVj/q2y4jlI9szfxA1/ZTXlUT78AR3Qw7wFD4+eJVy1kP7B/H
	3gaE+0QO4ooG2bCA+gCrsrpv+IPTp+kg=
X-Received: by 2002:a05:6870:80c7:b0:3e7:eba8:327e with SMTP id
 586e51a60fabf-416c3da4803mr1975697fac.22.1772734982767; Thu, 05 Mar 2026
 10:23:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260215002608.54934-1-contact@jingk.ai>
In-Reply-To: <20260215002608.54934-1-contact@jingk.ai>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 5 Mar 2026 19:22:50 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gLHwfUifwahPmLWYp6EvMtY+nQca3WiOybR7KMcoe0HA@mail.gmail.com>
X-Gm-Features: AaiRm52TSGQGgCn13I9mubQLvVtroVN01QUj2vo4-6hcQJAuli-1bAs7QzSpPSw
Message-ID: <CAJZ5v0gLHwfUifwahPmLWYp6EvMtY+nQca3WiOybR7KMcoe0HA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor: idle: Add missing bounds check in flatten_lpi_states()
To: Jingkai Tan <contact@jingk.ai>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org, 
	Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9B8D2216F2C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21432-lists,linux-acpi=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Sun, Feb 15, 2026 at 1:26=E2=80=AFAM Jingkai Tan <contact@jingk.ai> wrot=
e:
>
> The inner loop in flatten_lpi_states() that combines composite LPI
> states can increment flat_state_cnt multiple times within the loop.
>
> The condition that guards this (checks bounds against ACPI_PROCESSOR
> _MAX_POWER) occurs at the top of the outer loop. flat_state_cnt might
> exceed ACPI_PROCESSOR_MAX_POWER if it is incremented multiple times
> within the inner loop between outer loop iterations.
>
> Add the same bounds check inside the inner loop to prevent
> flat_state_cnt from exceeding ACPI_PROCESSOR_MAX_POWER there as well
>
> Signed-off-by: Jingkai Tan <contact@jingk.ai>
> ---
> Hi,
>
> I'm still fairly new to kernel contributions, just looking for small
> fixes on the weekend to familarize myself with contributions, so hopefull=
y
> I am not making a mistake here. I was looking at other issues and came
> across the processor_idle function. While reading it, I noticed that the
> guard from L1048 to L1052 only checks at the beginning of the outer loop
> iteration and seems to be written with a singular increment in mind to
> check whether flat_state_cnt exceeds ACPI_PROCESSOR_MAX_POWER each time
> it loops around.
>
> The nested loop at L1064 possibly increments flat_state_cnt multiple time=
s
> depending on the composite_states_size. I'm not too familiar with this
> but flat_state_cnt looks to me like it might hypothetically
> increment more than once and exceed ACPI_PROCESSOR_MAX_POWER.
>
>  drivers/acpi/processor_idle.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index 81f372c64074..a27dab1ad78e 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1062,6 +1062,12 @@ static unsigned int flatten_lpi_states(struct acpi=
_processor *pr,
>                 }
>
>                 for (i =3D 0; i < prev_level->composite_states_size; i++)=
 {
> +                       if (flat_state_cnt >=3D ACPI_PROCESSOR_MAX_POWER)=
 {
> +                               pr_warn("Limiting number of LPI states to=
 max (%d)\n",
> +                                       ACPI_PROCESSOR_MAX_POWER);
> +                               pr_warn("Please increase ACPI_PROCESSOR_M=
AX_POWER if needed.\n");
> +                               break;
> +                       }

The issue addressed by this patch appears to be genuine to me, but (a)
flat_state_cnt need not be checked before incrementing it and (b) it
should be sufficient to break out of the inner loop when
flat_state_cnt becomes too large after incrementing it as that would
be caught by the check in the outer loop then.

>                         p =3D prev_level->composite_states[i];
>                         if (t->index <=3D p->enable_parent_state &&
>                             combine_lpi_states(p, t, flpi)) {
> --

