Return-Path: <linux-acpi+bounces-20976-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FHSEAwgj2kuJgEAu9opvQ
	(envelope-from <linux-acpi+bounces-20976-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 13:58:52 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5F11362D3
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 13:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 154AF302C32D
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 12:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C0035F8BD;
	Fri, 13 Feb 2026 12:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQsHaeSR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0A035E557
	for <linux-acpi@vger.kernel.org>; Fri, 13 Feb 2026 12:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770987512; cv=none; b=eQ+3H6wkhJ0bs6S8aKpeAgap7KBqNr6qcIZAFHy7mj79cQjAtLqVFqob39VOYuKGed1Gf5Xi9PQO8tWoxdDUV5gejr/0zjQUSBi5oRTka7Hg7U/07pMy9nw0ssYl5h5Ho/sptLDTxNGXbU0BWeJOH2zMYRvW5/lNDAuBbQ9/kHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770987512; c=relaxed/simple;
	bh=ACjKR0hdQl4xOp/kq26MjMBCt4LpCNT0bAiqNHRzKG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E6AScrkXS+yUgpjZU8RGzJEil/FN3qt7ExMvlrhCSKgouGroo0F2/mnzR+qeNbMzXpErJkczmDSLhY0aOfWTgh1CwTFohCI6rC2RbAYbnB+m1gBI3O7N7MghG0mw0Mg70nmjdwz63s28Y0fMhmEhpPavaXsOoyzr8xTgky3vjOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQsHaeSR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFFFC2BC86
	for <linux-acpi@vger.kernel.org>; Fri, 13 Feb 2026 12:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770987512;
	bh=ACjKR0hdQl4xOp/kq26MjMBCt4LpCNT0bAiqNHRzKG0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CQsHaeSRVsMVln3ruuPtax1wPLhPfHNmYPlCSGOetaULeIPnxgeQ8TKMTo3sLqodQ
	 TyHzfipyIZxvGew/un4GbTfEo2TEJxF5MC27sZAaHwzNHUINwhglVi41wPEEJIVGhS
	 bPfDCqTQJfl9+coUVv6X7h8x/U21bbh1NPG+9Wq7vUGxTPgeJwFDyoad69lrEmw1S1
	 ZUdfXLGv+fneB9UbG1VPTVgpALZxNd4plFwB7SuoOW4V6gJmO144+/iwStWw9dvizF
	 zE/gyYA+yzzm3PyVZQYZyp4nRyiOyIAyuP+BQB+DPG45m1Kb4Y7cQW0Dhx9D3k3w98
	 VMkBL8VAzLmcQ==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d15b8feca3so888553a34.3
        for <linux-acpi@vger.kernel.org>; Fri, 13 Feb 2026 04:58:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUlyDMYiJefRZjY2QOvD28gdwUCDvgU14ND0VHk/Ycx6bT6ICDcoSOxXt0aBfvlhGSiIyLq5ZYCLpS4@vger.kernel.org
X-Gm-Message-State: AOJu0YyolIXlGI+G0i6bRRvtvA+HKYNYRKEcPAtSE7sxvebLMCJngltK
	rAJgdqSRZp+Gn+eXaPaafBPP0XbAVf7pfAkWkx6kjJzpfEhyK0PuM6aUVnzId9XycjcRGiCSOA9
	mPXVENnuSyDaM7lUfte3/5wTmbq2V/Lg=
X-Received: by 2002:a05:6820:229f:b0:662:8b01:c7cb with SMTP id
 006d021491bc7-67769d67cfdmr626143eaf.84.1770987511577; Fri, 13 Feb 2026
 04:58:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213065351.915707-1-corey@minyard.net> <20260213065351.915707-4-corey@minyard.net>
In-Reply-To: <20260213065351.915707-4-corey@minyard.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Feb 2026 13:58:20 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gGzF3p4sG8QS6rmAb52vm1UmCcdj2_wdSWSErfAFmFvQ@mail.gmail.com>
X-Gm-Features: AZwV_QhIXNhZ3V-MEfitSDk2dXXRBYipZ9UgqbxkDolFhOXqJNfE2LzaAj0SxEk
Message-ID: <CAJZ5v0gGzF3p4sG8QS6rmAb52vm1UmCcdj2_wdSWSErfAFmFvQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] ipmi:si: Fix check for a misbehaving BMC
To: Corey Minyard <corey@minyard.net>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>, 
	Guenter Roeck <linux@roeck-us.net>, Igor Raits <igor@gooddata.com>, linux-acpi@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, Daniel Secik <daniel.secik@gooddata.com>, 
	Zdenek Pesek <zdenek.pesek@gooddata.com>, Jiri Jurica <jiri.jurica@gooddata.com>, 
	Huisong Li <lihuisong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20976-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[minyard.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: ED5F11362D3
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 7:55=E2=80=AFAM Corey Minyard <corey@minyard.net> w=
rote:
>
> There is a race on checking the state in the sender, it needs to be
> checked under a lock.  But you also need a check to avoid issues with
> a misbehaving BMC for run to completion mode.  So leave the check at
> the beginning for run to completion, and add a check under the lock
> to avoid the race.
>
> Reported-by: Rafael J. Wysocki <rafael@kernel.org>
> Fixes: bc3a9d217755 ("ipmi:si: Gracefully handle if the BMC is non-functi=
onal")
> Signed-off-by: Corey Minyard <corey@minyard.net>

That's what I would do in sender(), more or less, so

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  drivers/char/ipmi/ipmi_si_intf.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si=
_intf.c
> index 3667033fcc51..6eda61664aaa 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -924,9 +924,14 @@ static int sender(void *send_info, struct ipmi_smi_m=
sg *msg)
>  {
>         struct smi_info   *smi_info =3D send_info;
>         unsigned long     flags;
> +       int rv =3D IPMI_CC_NO_ERROR;
>
>         debug_timestamp(smi_info, "Enqueue");
>
> +       /*
> +        * Check here for run to completion mode.  A check under lock is
> +        * later.
> +        */
>         if (smi_info->si_state =3D=3D SI_HOSED)
>                 return IPMI_BUS_ERR;
>
> @@ -940,18 +945,15 @@ static int sender(void *send_info, struct ipmi_smi_=
msg *msg)
>         }
>
>         spin_lock_irqsave(&smi_info->si_lock, flags);
> -       /*
> -        * The following two lines don't need to be under the lock for
> -        * the lock's sake, but they do need SMP memory barriers to
> -        * avoid getting things out of order.  We are already claiming
> -        * the lock, anyway, so just do it under the lock to avoid the
> -        * ordering problem.
> -        */
> -       BUG_ON(smi_info->waiting_msg);
> -       smi_info->waiting_msg =3D msg;
> -       check_start_timer_thread(smi_info);
> +       if (smi_info->si_state =3D=3D SI_HOSED) {
> +               rv =3D IPMI_BUS_ERR;
> +       } else {
> +               BUG_ON(smi_info->waiting_msg);
> +               smi_info->waiting_msg =3D msg;
> +               check_start_timer_thread(smi_info);
> +       }
>         spin_unlock_irqrestore(&smi_info->si_lock, flags);
> -       return IPMI_CC_NO_ERROR;
> +       return rv;
>  }
>
>  static void set_run_to_completion(void *send_info, bool i_run_to_complet=
ion)
> --
> 2.43.0
>

