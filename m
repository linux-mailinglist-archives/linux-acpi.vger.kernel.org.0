Return-Path: <linux-acpi+bounces-20666-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIyaMcHQeGmNtQEAu9opvQ
	(envelope-from <linux-acpi+bounces-20666-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 15:50:41 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 148209604F
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 15:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4DA5300FEF7
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 14:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DAD35772C;
	Tue, 27 Jan 2026 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIbbpNvg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1BA13AF2
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769525435; cv=none; b=Sy8iFKwh2ik/ekj7kjoEu6rPDACeo0s8b7YqOWwoqD+Vk87hmyTFoJd8y7eqHFn7PslLA83EmuYHa9Z4JQbiMNoG81lKkfoRWXMdu39SuV0QVgcgdQf39bM+NwdI8NFxEeB+azjUqo5vvR2y3AX10u/N6vH4cYRz+whHpegekLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769525435; c=relaxed/simple;
	bh=EeqKI2o35Ae4Csy94t4wPy5vnzMq7ch4hVlfCZYKDZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWUwR4ep4r2TJ1TNnVD1eKrpHaxGHaZMccRlW5xIUbYnqHM096+vIpNkSzYWjzFj6OdWh1muGVO0Vnikw0IFhHnrlX7+UEW8CUb5FGwneLeFp+cFy9uLs9Z7207Ht0iMhlH3PQI+B4frnpQ5JS3zlMaz2If8xYsjAh97tCR9pnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIbbpNvg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E0BC19422
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 14:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769525435;
	bh=EeqKI2o35Ae4Csy94t4wPy5vnzMq7ch4hVlfCZYKDZo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SIbbpNvgthoL4TP4xEWFOsn/rMObzPfU1bcJIWh3HMFlgWMjn6cC9tbq1GPg30mys
	 p+XNBsmOP2HTuTyIAbChoo3W3GNjS1RGziyP/HbX2A85fSXtttWzDjWRR3YwVLTUxD
	 rafkE4sSPVorkKo6C3CV/b1yHH6FWjJ7VfoBu+inSECkDPOGPJon/XewGgnr36e4DZ
	 UHsC5dTrB/LPxJtNhVlILhXj+JYg5Z01o7+DOnVUWI7ml5LGjAIhIDFVEploEo9MiZ
	 IPICb9AL4gwWm2Ay1U22oaAf2HEE+Dk7Kl3/Ri/HpCqA3UvjqB2WAYE2ezipPH4iT/
	 D1c8jEoHWS2tg==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-409470ad5bbso168272fac.0
        for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 06:50:35 -0800 (PST)
X-Gm-Message-State: AOJu0Ywv/wBNcHYHT+BI3mlc2Z+D5zrTq8MqQWz2F1zlo2UKTMmOQPlN
	KDNxQS3Ak1T73HyVqhhz7otqD8O0k/8bleLnY4KFg7q0ARIPs3lYCBB1U1UWry3tjx+YEFK97HG
	6TKNFqoc6kO65opoUNS5o8C2n4Q1injE=
X-Received: by 2002:a05:6870:d154:b0:3ec:9c0c:283a with SMTP id
 586e51a60fabf-4093fce6000mr1036990fac.24.1769525434241; Tue, 27 Jan 2026
 06:50:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107154015.322698-1-jriemenschne@student.ethz.ch>
In-Reply-To: <20260107154015.322698-1-jriemenschne@student.ethz.ch>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Jan 2026 15:50:23 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gj6YmypO7B-FpjPKc3WK3R5HSso0RaMBER9FMripYCaA@mail.gmail.com>
X-Gm-Features: AZwV_Qg5CbLMfmjtUAwtpNOzj395M57og76ozBECdefEkWdV5Kw1B2w3RCjE2Po
Message-ID: <CAJZ5v0gj6YmypO7B-FpjPKc3WK3R5HSso0RaMBER9FMripYCaA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: x86: s2idle: Invoke Microsoft _DSM Function 9 (Turn
 On Display)
To: Jakob Riemenschneider <riemenschneiderjakob@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Osipenko <dmitry.osipenko@collabora.com>, Antheas Kapenekakis <lkml@antheas.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20666-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 148209604F
X-Rspamd-Action: no action

On Wed, Jan 7, 2026 at 4:40=E2=80=AFPM Jakob Riemenschneider
<riemenschneiderjakob@gmail.com> wrote:
>
> Windows 11, version 22H2 introduced a new function index (Function 9) to
> the Microsoft LPS0 _DSM, titled "Turn On Display Notification".
>
> According to Microsoft documentation, this function signals to the system
> firmware that the OS intends to turn on the display when exiting Modern
> Standby. This allows the firmware to release Power Limits (PLx) earlier,
> improving resume latency on supported OEM designs. Without this call,
> some devices may remain in a throttled power state longer than necessary
> during resume.

Has this been observed in the field?

Any examples?

> This patch defines the new function index (ACPI_LPS0_MS_DISPLAY_ON) and
> invokes it in acpi_s2idle_restore_early_lps0() immediately after the
> screen-on notification, provided the firmware supports the function in
> its mask.
>
> Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-ex=
periences/modern-standby-firmware-notifications#turn-on-display-notificatio=
n-function-9
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D220505
> Signed-off-by: Jakob Riemenschneider <jriemenschne@student.ethz.ch>
> ---
>  drivers/acpi/x86/s2idle.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 6d4d06236..4ce4cc8a0 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -45,6 +45,7 @@ static const struct acpi_device_id lps0_device_ids[] =
=3D {
>  #define ACPI_LPS0_EXIT         6
>  #define ACPI_LPS0_MS_ENTRY      7
>  #define ACPI_LPS0_MS_EXIT       8
> +#define ACPI_LPS0_MS_DISPLAY_ON 9
>
>  /* AMD */
>  #define ACPI_LPS0_DSM_UUID_AMD      "e3f32452-febc-43ce-9039-932122d3772=
1"
> @@ -352,6 +353,8 @@ static const char *acpi_sleep_dsm_state_to_str(unsign=
ed int state)
>                         return "lps0 ms entry";
>                 case ACPI_LPS0_MS_EXIT:
>                         return "lps0 ms exit";
> +               case ACPI_LPS0_MS_DISPLAY_ON:
> +                       return "lps0 ms display on";
>                 }
>         } else {
>                 switch (state) {
> @@ -618,9 +621,14 @@ static void acpi_s2idle_restore_early_lps0(void)
>         }
>
>         /* Screen on */
> -       if (lps0_dsm_func_mask_microsoft > 0)
> +       if (lps0_dsm_func_mask_microsoft > 0) {
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON,
>                                 lps0_dsm_func_mask_microsoft, lps0_dsm_gu=
id_microsoft);
> +                               /* Modern Turn Display On */
> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_DISPLAY_ON,
> +                               lps0_dsm_func_mask_microsoft, lps0_dsm_gu=
id_microsoft);

Is the ordering right with respect to the non-MSFT screen-on
notifications below?

I would expect it to be done after all of the screen-on notifications,
so is there a specific reason to do it earlier?

> +       }
> +
>         if (lps0_dsm_func_mask > 0)
>                 acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
>                                         ACPI_LPS0_SCREEN_ON_AMD :
> --

Also, this kind of clashes with the "dark mode" work in progress, see
for example:

https://lore.kernel.org/linux-acpi/20251226102656.6296-1-lkml@antheas.dev/

