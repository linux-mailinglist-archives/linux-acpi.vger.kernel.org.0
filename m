Return-Path: <linux-acpi+bounces-20692-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INuQLX8peWkIvwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20692-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 22:09:19 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 235059A9CE
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 22:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFED9306A33F
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 21:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A70298CC0;
	Tue, 27 Jan 2026 21:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aT0osf5b"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF252957C2
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 21:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769547962; cv=none; b=BoC+yIeDUH+vl2tzpCoZ3XshtbViM5s9Ib62eD3BjalBsspNthFFRztFADEvf1DBTLmsYMHvN/YPPZJiaAT6S/PidrStK605zHGFoH5kvg54IilPpqjPTK9MqXv4S1qHkbPtwApet7MoiIyjyel2vt0HCmpWZ14zrpjHqo1fmao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769547962; c=relaxed/simple;
	bh=LZI99ZHcYEZqx7Bb9njG3BMt836bY314YrWdKlDmM2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=daA3cGeZ6fBZxHvuEilFLBK5hsLoEc/+ksgl0VkP0p8kevOx9n2sSCUaD0zC/8YTw+MGvPBmp1tuTsymPqncZr/6ZqXzdbc6hgvTRJZ6143rQ5qL8h1nbGn5FESjfpitH3nm6Uosui4sRlom5jpVkZiUQn5vmPNHl0YuOzDM9jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aT0osf5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA87C116C6
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 21:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769547961;
	bh=LZI99ZHcYEZqx7Bb9njG3BMt836bY314YrWdKlDmM2M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aT0osf5ba4PCf6rILAFrDCqufZfrVcjIQGbBhlxe/JcWfCzp8y4dz0s3bkPYE8beN
	 ZWpms0RLWDHquRZRtWb2cMOVbJ675AUv12CbOZh9NJLKNYVVlkQW4nhFWqi06MYd+p
	 hvh6BD2dDnYT1qBic8jKTY6lKuLgwETOPqI5PJXtFDSvxB36IuEyKUKAPHbMq3LjFH
	 kwRXRCI5Y4RZuKv1lPzgQsHSbu3g13bZaDquKThr5Sk28qeOlnerJhRey8supSRCwu
	 S4/iQzBr+z1cukYK05SQJ3NqfnrlnFVGYdKcjEMLnJtnJuPQTx8sZkBCtz8/5RH/Mj
	 wewq9hoWnxZBA==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-662cb4bef90so1715144eaf.0
        for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 13:06:01 -0800 (PST)
X-Gm-Message-State: AOJu0YwWJEhww+DuQ5K981hN7HKYC63yxAgtqtC0iv/N05c5Jzahrcq+
	yuPL9LI+Y+K620yk7bgLxBpfkc78RbLrUnjWBaeGEl/dvQmkNEbvZGZPqLjXw/RVt2OV/Y8ev2w
	D0+D1u2mMnotJoqedDwiZWwW02qcjp70=
X-Received: by 2002:a05:6820:c95:b0:659:9a49:8f4c with SMTP id
 006d021491bc7-662f2036262mr1570270eaf.17.1769547960929; Tue, 27 Jan 2026
 13:06:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127063216.240911-1-W_Armin@gmx.de>
In-Reply-To: <20260127063216.240911-1-W_Armin@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Jan 2026 22:05:49 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hWpp2M-uDGEpM-gzRSbtGGoBfJk6PVbT71iLsovTdxTg@mail.gmail.com>
X-Gm-Features: AZwV_QhrGywz7cJYJ8ioyPkNrpf8jKlwF7xsD1gDRYn0OOot6kFXdpJNrk8_YpI
Message-ID: <CAJZ5v0hWpp2M-uDGEpM-gzRSbtGGoBfJk6PVbT71iLsovTdxTg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: OSL: Panic when encountering a fatal ACPI error
To: Armin Wolf <W_Armin@gmx.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20692-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.de:email]
X-Rspamd-Queue-Id: 235059A9CE
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 7:32=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrote:
>
> The ACPI spec states that the operating system should respond
> to a fatal ACPI error by "performing a controlled OS shutdown in
> a timely fashion". Windows complies with this requirement by entering
> a BSOD upon executing the "Fatal()" ASL opcode, a implementation
> detail that is used by some firmware implementations for signaling
> fatal hardware errors.
>
> Comply with the ACPI specification by triggering a kernel panic
> when ACPICA signals a fatal ACPI error.

I'm not sure if a kernel panic really counts as "a controlled OS shutdown".

Shouldn't this be treated in a similar way to crossing a critical
thermal trip point?

Also, is there a reason beyond "follow Windows" to do this?

> Users can still disable
> this behavior by using the acpi.panic_on_fatal kernel option to
> work around firmware bugs.

This is not enough.  You are talking about throwing away user data if
the firmware asks the kernel to do so.

> Link: https://uefi.org/specs/ACPI/6.6/19_ASL_Reference.html#fatal-fatal-e=
rror-check
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
> Changes since v1:
> - use IS_ENABLED() for checking the presence of CONFIG_ACPI_PANIC_ON_FATA=
L
> ---
>  .../admin-guide/kernel-parameters.txt         |  9 +++++++++
>  drivers/acpi/Kconfig                          | 11 +++++++++++
>  drivers/acpi/osl.c                            | 19 ++++++++++++++++++-
>  3 files changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 1058f2a6d6a8..140bb239857f 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -187,6 +187,15 @@ Kernel parameters
>                         unusable.  The "log_buf_len" parameter may be use=
ful
>                         if you need to capture more output.
>
> +       acpi.panic_on_fatal=3D    [ACPI]
> +                       {0 | 1}
> +                       Causes the kernel to panic when the ACPI bytecode=
 signals
> +                       a fatal error. The default value of this setting =
can
> +                       be configured using CONFIG_ACPI_PANIC_ON_FATAL.
> +                       Overriding this value should only be done for dia=
gnosing
> +                       ACPI firmware problems, as some firmware implemen=
tations
> +                       use this mechanism to signal fatal hardware error=
s.
> +
>         acpi_enforce_resources=3D [ACPI]
>                         { strict | lax | no }
>                         Check for resource conflicts between native drive=
rs
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index df0ff0764d0d..7139e7d8ac25 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -65,6 +65,17 @@ config ACPI_THERMAL_LIB
>         depends on THERMAL
>         bool
>
> +config ACPI_PANIC_ON_FATAL
> +       bool "Panic on fatal ACPI error"
> +       default y
> +       help
> +         The ACPI bytecode can signal that a fatal error has occurred us=
ing the Fatal()
> +         ASL operator, normaly causing a kernel panic. Disabling this op=
tion causes such
> +         a condition to be treated like a ordinary ACPI error.
> +
> +         This setting can also be overridden during boot using the acpi.=
panic_on_fatal
> +         kernel parameter.
> +
>  config ACPI_DEBUGGER
>         bool "AML debugger interface"
>         select ACPI_DEBUG
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 05393a7315fe..6375db6d22ea 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -11,7 +11,9 @@
>
>  #define pr_fmt(fmt) "ACPI: OSL: " fmt
>
> +#include <linux/kconfig.h>
>  #include <linux/module.h>
> +#include <linux/panic.h>
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/mm.h>
> @@ -70,6 +72,10 @@ static bool acpi_os_initialized;
>  unsigned int acpi_sci_irq =3D INVALID_ACPI_IRQ;
>  bool acpi_permanent_mmap =3D false;
>
> +static bool panic_on_fatal =3D IS_ENABLED(CONFIG_ACPI_PANIC_ON_FATAL);
> +module_param(panic_on_fatal, bool, 0);
> +MODULE_PARM_DESC(panic_on_fatal, "Trigger a kernel panic when encounteri=
ng a fatal ACPI error");
> +
>  /*
>   * This list of permanent mappings is for memory that may be accessed fr=
om
>   * interrupt context, where we can't do the ioremap().
> @@ -1381,9 +1387,20 @@ acpi_status acpi_os_notify_command_complete(void)
>
>  acpi_status acpi_os_signal(u32 function, void *info)
>  {
> +       struct acpi_signal_fatal_info *fatal_info;
> +
>         switch (function) {
>         case ACPI_SIGNAL_FATAL:
> -               pr_err("Fatal opcode executed\n");
> +               fatal_info =3D info;
> +               if (panic_on_fatal) {
> +                       panic("Fatal ACPI BIOS error (type 0x%X code 0x%X=
 argument 0x%X)",
> +                             fatal_info->type, fatal_info->code, fatal_i=
nfo->argument);
> +               } else {
> +                       pr_emerg("Fatal ACPI BIOS error (type 0x%X code 0=
x%X argument 0x%X)\n",
> +                                fatal_info->type, fatal_info->code, fata=
l_info->argument);
> +                       add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STIL=
L_OK);
> +               }
> +
>                 break;
>         case ACPI_SIGNAL_BREAKPOINT:
>                 /*
> --
> 2.39.5
>
>

