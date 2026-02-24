Return-Path: <linux-acpi+bounces-21141-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oENWDCMvnmmkTwQAu9opvQ
	(envelope-from <linux-acpi+bounces-21141-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 00:07:15 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D5E18E0CF
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 00:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79D853020FC6
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 23:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CED6343D71;
	Tue, 24 Feb 2026 23:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="TmmUKsl4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A0D29E113;
	Tue, 24 Feb 2026 23:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771974362; cv=none; b=oOUYQzbpu3c1Tl0TkIhky5p/N8br/nRwkrPff8ybzxjD+jW/syjETxSumjauESr4I80Noxyhmynknl0erFLrKXudXjq5zzuivwK5Rl4mWZE1ievoGfzGHric9YeVZCwLXkV7hCPXOz+J1+d9iOY9RG15nO3H+dQ5CAspM167Wrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771974362; c=relaxed/simple;
	bh=3IlEnfeTl5A8RtXHNUgLItLqk8NlROW/Ya2uGnNdw0Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DFjV+49tolmRzR7n0JNPWnRh42t5JSwuTDR81ygdzSjwLI8hgUUKDylu8bKmyptLJ5A3SKITsRPaUZZ7F9B/IOv9/uHKmhXMPhpZulEvcld58f6NoWK6K0KtMgvFoNBBUgqUiZulEixKnKVmwgiP1hMGa+S5zX7ATZb97afHo6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=TmmUKsl4; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1771974358; x=1772579158; i=w_armin@gmx.de;
	bh=MEg/YbMkczQIK3AfSTjpfZZJSwyNo/fwALJW8Z7w/34=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TmmUKsl4CqDbHcyoZysDyLcThux2earZ/SXZS54ZkhjKt8zhjGUQdAWRTF5s+4rF
	 0HFO7h3vxDbMDpWcjBbdQ5LWzf2if9ilA69k46Pr1bnEm4LcEFRVeN2Qkc837CbpX
	 DHUsgNthpPBHdw+MMJ9a9/ux1Tl21mH7jigJ1drggutawv5iKXffQvxlFfzAxkX0u
	 VFPuvLjZtlZ8oiYaPjXaUiH5HED1D+YQIgtcz/+9QVD0dvdPAdETdyh5O9S0Hw3fs
	 hiXNFjUgerr4m0JfkmAQaYyqa+uKeHzd+bOe/8IA9ic7YyXN+yMEQlL5OSyFnfsda
	 sWgU5awS0ygEG1n09Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([91.14.226.35]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3lYB-1vukMQ3LJj-00CCvB; Wed, 25
 Feb 2026 00:05:58 +0100
Message-ID: <c5d23d8a-8f58-48c3-90ca-5d1a46964280@gmx.de>
Date: Wed, 25 Feb 2026 00:05:56 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ACPI: OSL: Poweroff when encountering a fatal ACPI
 error
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260204212931.3860-1-W_Armin@gmx.de>
Content-Language: en-US
In-Reply-To: <20260204212931.3860-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xuiNHYal4xvtuxoRYoDccyEdTomsEDt0x5uMqo7m1duEjfIPTB2
 x/2xTMMmqmWslOboVIODLQE7DwnuaKqRg2Xeh/V4OIlQ0hzMshCQfvfNOPozmcG/NqJ8jkw
 0vHxfL1dUJ9R0t2mHc2r2/I0pDCuh56R40yFZkpx8G/cuNGB4mWeDaCmIE6KwIptRB2MHBk
 apamGpsqW8n/2eS6AO5Ow==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zQGfdKF67Kk=;kZnWTe9J1cKNNUWTyjPtMu1FSl3
 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
 /evfbNCHfbaYVEKTCWFa
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21141-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[gmx.de:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[W_Armin@gmx.de,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gmx.de:mid,gmx.de:dkim,gmx.de:email,uefi.org:url]
X-Rspamd-Queue-Id: 98D5E18E0CF
X-Rspamd-Action: no action

Am 04.02.26 um 22:29 schrieb Armin Wolf:

> The ACPI spec states that the operating system should respond
> to a fatal ACPI error by "performing a controlled OS shutdown in
> a timely fashion". Comply with the ACPI specification by powering
> off the system when ACPICA signals a fatal ACPI error. Users can
> still disable this behavior by using the acpi.poweroff_on_fatal
> kernel option to work around firmware bugs.

Any updates on this?

Thanks,
Armin Wolf

> Link: https://uefi.org/specs/ACPI/6.6/19_ASL_Reference.html#fatal-fatal-=
error-check
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
> Changes since v2:
> - poweroff instead of triggering a kernel panic
>
> Changes since v1:
> - use IS_ENABLED() for checking the presence of CONFIG_ACPI_PANIC_ON_FAT=
AL
> ---
>   .../admin-guide/kernel-parameters.txt         |  9 +++++++++
>   drivers/acpi/Kconfig                          | 11 +++++++++++
>   drivers/acpi/osl.c                            | 19 ++++++++++++++++++-
>   3 files changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documenta=
tion/admin-guide/kernel-parameters.txt
> index 1058f2a6d6a8..1f2eaa0ec424 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -187,6 +187,15 @@ Kernel parameters
>   			unusable.  The "log_buf_len" parameter may be useful
>   			if you need to capture more output.
>  =20
> +	acpi.poweroff_on_fatal=3D	[ACPI]
> +			{0 | 1}
> +			Causes the system to poweroff when the ACPI bytecode signals
> +			a fatal error. The default value of this setting can
> +			be configured using CONFIG_ACPI_POWEROFF_ON_FATAL.
> +			Overriding this value should only be done for diagnosing
> +			ACPI firmware problems, as the system might behave erratically
> +			after having encountered a fatal ACPI error.
> +
>   	acpi_enforce_resources=3D	[ACPI]
>   			{ strict | lax | no }
>   			Check for resource conflicts between native drivers
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index df0ff0764d0d..1610dd4c8278 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -65,6 +65,17 @@ config ACPI_THERMAL_LIB
>          depends on THERMAL
>          bool
>  =20
> +config ACPI_POWEROFF_ON_FATAL
> +	bool "Poweroff on fatal ACPI error"
> +	default y
> +	help
> +	  The ACPI bytecode can signal that a fatal error has occurred using t=
he Fatal()
> +	  ASL operator, normaly causing the system to poweroff. Disabling this=
 option causes
> +	  such a condition to be treated like a ordinary ACPI error.
> +
> +	  This setting can also be overridden during boot using the acpi.power=
off_on_fatal
> +	  kernel parameter.
> +
>   config ACPI_DEBUGGER
>   	bool "AML debugger interface"
>   	select ACPI_DEBUG
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 05393a7315fe..f2b45fa4a752 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -11,8 +11,10 @@
>  =20
>   #define pr_fmt(fmt) "ACPI: OSL: " fmt
>  =20
> +#include <linux/kconfig.h>
>   #include <linux/module.h>
>   #include <linux/kernel.h>
> +#include <linux/reboot.h>
>   #include <linux/slab.h>
>   #include <linux/mm.h>
>   #include <linux/highmem.h>
> @@ -70,6 +72,10 @@ static bool acpi_os_initialized;
>   unsigned int acpi_sci_irq =3D INVALID_ACPI_IRQ;
>   bool acpi_permanent_mmap =3D false;
>  =20
> +static bool poweroff_on_fatal =3D IS_ENABLED(CONFIG_ACPI_POWEROFF_ON_FA=
TAL);
> +module_param(poweroff_on_fatal, bool, 0);
> +MODULE_PARM_DESC(poweroff_on_fatal, "Poweroff when encountering a fatal=
 ACPI error");
> +
>   /*
>    * This list of permanent mappings is for memory that may be accessed =
from
>    * interrupt context, where we can't do the ioremap().
> @@ -1381,9 +1387,20 @@ acpi_status acpi_os_notify_command_complete(void)
>  =20
>   acpi_status acpi_os_signal(u32 function, void *info)
>   {
> +	struct acpi_signal_fatal_info *fatal_info;
> +
>   	switch (function) {
>   	case ACPI_SIGNAL_FATAL:
> -		pr_err("Fatal opcode executed\n");
> +		fatal_info =3D info;
> +		pr_emerg("Fatal error while evaluating ACPI control method\n");
> +		pr_emerg("Type 0x%X Code 0x%X Argument 0x%X\n",
> +			 fatal_info->type, fatal_info->code, fatal_info->argument);
> +
> +		if (poweroff_on_fatal)
> +			orderly_poweroff(true);
> +		else
> +			add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
> +
>   		break;
>   	case ACPI_SIGNAL_BREAKPOINT:
>   		/*

