Return-Path: <linux-acpi+bounces-15400-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA7CB148E8
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jul 2025 09:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BF9318A011A
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jul 2025 07:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F08E256C9B;
	Tue, 29 Jul 2025 07:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0upti.me header.i=@0upti.me header.b="NJOwyYUm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net [178.154.239.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF04C1F874F;
	Tue, 29 Jul 2025 07:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753772843; cv=none; b=azZ5cJcWcQZAYGDLpVGAjJ8uiU7QfYU4OXzj0Cnblg9Laubo3Ao1/nDOHqNKAZKOtWrgmevQSb0HXcpN9OCp6a6niqa1kHZX44Xamtwp8ESNarEbVsZuZf+1qjOqhvedyjwIXoCcFkikSrP4J/68tGfZC/6x4bU0yH6agT6Z3Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753772843; c=relaxed/simple;
	bh=1TfdvzGT+nwpn2cSdU76FR+epNvzw84ISJiVRYDwLGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vF4BKvCxXXpVgYnu8xr3EBMrBcySyyjvhjZU5AdUPPXvG+S8BsOIrj0lRuRZ+ddH/r4Ro5grkxS4gEbnpZuOYGUrVvB9Iqg2q6AJlqcN40L0+5pdqwgguL54ZnLVTMy7CLaqj3UZrdyx+UjA8Een6s48cmY0gKAlE/9ijsWMV8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=0upti.me; spf=pass smtp.mailfrom=0upti.me; dkim=pass (1024-bit key) header.d=0upti.me header.i=@0upti.me header.b=NJOwyYUm; arc=none smtp.client-ip=178.154.239.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=0upti.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0upti.me
Received: from mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:16c5:0:640:b9af:0])
	by forward501d.mail.yandex.net (Yandex) with ESMTPS id E774781C12;
	Tue, 29 Jul 2025 10:00:53 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id p0TZYSMIm0U0-yBcThmRl;
	Tue, 29 Jul 2025 10:00:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0upti.me; s=mail;
	t=1753772453; bh=nvCU/Cru1rShKUWctXKkh21j8jRPqnuBB6hEKKhcS1M=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=NJOwyYUmzeLh+Z4QPdedyXiPN139pwgkoPGUdlyJOQstv5OR82QuCvMTZTUT0kA7g
	 gYz8LkLNhl3UJljfeWmjAUV8GImBGbHAs4lof/ZsA/BHro3ZP7kYADcvCfqrOntxss
	 XN3kbueGmUqnjxrTO6W4KScmf7tYLSniP4xQr+Pw=
Authentication-Results: mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net; dkim=pass header.i=@0upti.me
Message-ID: <e911ca96-fe8f-4cc5-bf68-f20ec7da46be@0upti.me>
Date: Tue, 29 Jul 2025 10:00:50 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: EC: Relax sanity check of the ECDT ID string
To: Armin Wolf <W_Armin@gmx.de>, rafael@kernel.org, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250729062038.303734-1-W_Armin@gmx.de>
Content-Language: en-US
From: Ilya K <me@0upti.me>
In-Reply-To: <20250729062038.303734-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-07-29 09:20, Armin Wolf wrote:
> It turns out that the ECDT table inside the ThinkBook 14 G7 IML
> contains a valid EC description but an invalid ID string
> ("_SB.PC00.LPCB.EC0"). Ignoring this ECDT based on the invalid
> ID string prevents the kernel from detecting the built-in touchpad,
> so relax the sanity check of the ID string and only reject ECDTs
> with empty ID strings.
> 
> Compile-tested only.
> 
> Reported-by: Ilya K <me@0upti.me>
> Fixes: 7a0d59f6a913 ("ACPI: EC: Ignore ECDT tables with an invalid ID string")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/acpi/ec.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 

Thanks, this works!

Tested-by: Ilya K <me@0upti.me>

> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 75c7db8b156a..7855bbf752b1 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -2033,7 +2033,7 @@ void __init acpi_ec_ecdt_probe(void)
>  		goto out;
>  	}
>  
> -	if (!strstarts(ecdt_ptr->id, "\\")) {
> +	if (!strlen(ecdt_ptr->id)) {
>  		/*
>  		 * The ECDT table on some MSI notebooks contains invalid data, together
>  		 * with an empty ID string ("").
> @@ -2042,9 +2042,13 @@ void __init acpi_ec_ecdt_probe(void)
>  		 * a "fully qualified reference to the (...) embedded controller device",
>  		 * so this string always has to start with a backslash.
>  		 *
> -		 * By verifying this we can avoid such faulty ECDT tables in a safe way.
> +		 * However some ThinkBook machines have a ECDT table with a valid EC
> +		 * description but an invalid ID string ("_SB.PC00.LPCB.EC0").
> +		 *
> +		 * Because of this we only check if the ID string is empty in order to
> +		 * avoid the obvious cases.
>  		 */
> -		pr_err(FW_BUG "Ignoring ECDT due to invalid ID string \"%s\"\n", ecdt_ptr->id);
> +		pr_err(FW_BUG "Ignoring ECDT due to empty ID string\n");
>  		goto out;
>  	}
>  

Would it maybe make sense to also log a warning for the old case? Maybe a vendor will notice it and fix the firmware...
(yeah yeah fat chance)

