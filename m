Return-Path: <linux-acpi+bounces-6011-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 713BB8D0E5A
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 21:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF753B20C40
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 19:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25614160877;
	Mon, 27 May 2024 19:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mY4WexIp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A3517E8FC;
	Mon, 27 May 2024 19:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716839079; cv=none; b=sDKMltONTNYwdF/TBrJc12ev92S3Su49hF2+YQO9vWQCbcqtEanpq+Yh55jBGNd5Op+Y2WBEFWzYw0Pt+6diBwAIGRxtiQzJ1LCXjMOulUrZzWCdNd9hGFaheIHlJWxZVGtYS0bloDC+ikq+OtJR4rju6a7n3jVea5kDdjIkcuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716839079; c=relaxed/simple;
	bh=HLBysQ19YFHo8F8KB4gsrAUlc0wV9Cj9zKghrvonL+A=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WgkBAQ1GXq5gEJjvqkfFj/7fOv+jKM0s5xmcqJmv19Y+JJN6r/lsQeFWwNI1FjdPB51wCXnRXNo07lqmTauHkLOQeioxcsgQbkH07aUYsKfJar4a5U5IC3+kWvV1YlAlc5g0fAc+eqasCtTbiXNQMzRFdyZEtaEWEXCLjPfsQBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mY4WexIp; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-794cbdca425so11863385a.0;
        Mon, 27 May 2024 12:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716839076; x=1717443876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjq5tjwzvdH+BRd/8f1cet9dJrekncN/7BkMFy2h8t8=;
        b=mY4WexIpSKX9O4zJPv6zvaKgPZynocHG2LDji+3r+5xV59kNlYTxG3fRMAe/naiDZN
         Gijr4xJy3VxUmU11IHqZRTsLIQUMMRQRJpUiE1sgGJ28gbiCGjuSvAFB+7uVbaUiwcYt
         i3s5DTMJNdQuQnRyjqxJtCO9/ito4AFj1FG70nu4FY/p2drZ7B2FJAs336L5JubgVZM+
         UXlmTzHmzigz0BscNcFd3lmxJ6PBV1TXOUu6dK1IhGOzbRovQP5sQt6n8Z8pDYibfzz9
         8wGUjCltH1vWlv3aUF1bGtkeeCK1DDdvQM2d/mMR1kWFSfVNXyxWLreLKMAOWfsnl5Ep
         DSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716839076; x=1717443876;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qjq5tjwzvdH+BRd/8f1cet9dJrekncN/7BkMFy2h8t8=;
        b=L7ggcIhgIjzKWqatwCCcEEaydpZ9IBi/cOWsS6xg1iGwbYpFxo1eCYKKMkxakl0tbw
         vrU6MFimFnEA0uIxjGZZVd13/Jyp0Ps+N6oeQ7N6je0C/mA7x7+yubOmd1KeLPN3zgN/
         e2xslsp4bZk6nEYo5wung8f5ktjFv5Lwqh89D89xyJdqSsMjpaDuMueHOZSwfnsocKIZ
         G03NQ5rQkaWGKXeQd04NpUD+PcBTaArFmw4qqrMzY1LtKNGxkmnWzM1Jy2N957oOTg02
         7nvzftt2SI4KSyzevynpZVA96/7r9At3HvU9weXfk7K4bPw2+gf2U2YgPUhahJMQ//CJ
         1Qfg==
X-Forwarded-Encrypted: i=1; AJvYcCVc2ImRKqrIkB+iPPFTbDsmWlXEpFAm5NS2EvBh22Y3as8N1Z6CGIaqjXCpupHPxaJYPMWBH0DhLAp5xb2By599lTezXf2Zvi7BijRKHEh7JQ8JZlAgNX4uWNnTmhWzfp+YOkRoL6bNtqhD
X-Gm-Message-State: AOJu0YylgwqMkWwJpL4qiGISa1vy7dJ4CzXE+DDOBTVb7Ld8ftBgQERa
	r/g6ZvFBfJBTWrIzKyTMfBPb4aAx9ToK8f7wne3YmS0/ozEJIOI=
X-Google-Smtp-Source: AGHT+IEHEOkzsUc9ks53aRMP1DcBgMp4Mq7pnTVsKtvBheCkdD8g1Y0IiL00nKH1Edxq8CxrZsPx0w==
X-Received: by 2002:a05:620a:1270:b0:790:ed57:1354 with SMTP id af79cd13be357-794ab08d7c4mr1156185485a.6.1716839076381;
        Mon, 27 May 2024 12:44:36 -0700 (PDT)
Received: from [120.7.1.23] (198-84-205-203.cpe.teksavvy.com. [198.84.205.203])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abd0740csm320873385a.81.2024.05.27.12.44.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 12:44:35 -0700 (PDT)
Subject: Kernel 6.10-rc1 b,Build error with [PATCH v5 2/3] serial: port: Add
 support of PNP IRQ
To: Guanbing Huang <albanhuang@outlook.com>, gregkh@linuxfoundation.org,
 andriy.shevchenko@intel.com, rafael.j.wysocki@intel.com
Cc: linux-acpi@vger.kernel.org, tony@atomide.com, john.ogness@linutronix.de,
 yangyicong@hisilicon.com, jirislaby@kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 lvjianmin@loongson.cn, albanhuang@tencent.com, tombinfan@tencent.com
References: <cover.1712472167.git.albanhuang@tencent.com>
 <PSAPR06MB4952C4112E75D882AC61CA5EC9002@PSAPR06MB4952.apcprd06.prod.outlook.com>
From: Woody Suwalski <terraluna977@gmail.com>
Message-ID: <cc8a93b2-2504-9754-e26c-5d5c3bd1265c@gmail.com>
Date: Mon, 27 May 2024 15:44:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 SeaMonkey/2.53.18.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <PSAPR06MB4952C4112E75D882AC61CA5EC9002@PSAPR06MB4952.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Guanbing Huang wrote:
> From: Guanbing Huang <albanhuang@tencent.com>
>
> The function __uart_read_properties doesn't cover PNP devices, so add IRQ
> processing for PNP devices in the branch.
>
> Signed-off-by: Guanbing Huang <albanhuang@tencent.com>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Reviewed-by: Bing Fan <tombinfan@tencent.com>
> Tested-by: Linheng Du <dylanlhdu@tencent.com>
> ---
> v4 -> v5: change "pnp" and "irq" in the commit message to uppercase, modify the subject
>            to start with "serial: port:", modify the location of the header file pnp.h
>
>   drivers/tty/serial/serial_port.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/serial_port.c b/drivers/tty/serial/serial_port.c
> index 22b9eeb23e68..8504bae1d2c9 100644
> --- a/drivers/tty/serial/serial_port.c
> +++ b/drivers/tty/serial/serial_port.c
> @@ -11,6 +11,7 @@
>   #include <linux/of.h>
>   #include <linux/platform_device.h>
>   #include <linux/pm_runtime.h>
> +#include <linux/pnp.h>
>   #include <linux/property.h>
>   #include <linux/serial_core.h>
>   #include <linux/spinlock.h>
> @@ -221,7 +222,11 @@ static int __uart_read_properties(struct uart_port *port, bool use_defaults)
>   
>   	if (dev_is_platform(dev))
>   		ret = platform_get_irq(to_platform_device(dev), 0);
> -	else
> +	else if (dev_is_pnp(dev)) {
> +		ret = pnp_irq(to_pnp_dev(dev), 0);
> +		if (ret < 0)
> +			ret = -ENXIO;
> +	} else
>   		ret = fwnode_irq_get(dev_fwnode(dev), 0);
>   	if (ret == -EPROBE_DEFER)
>   		return ret;

Hello all, trying to build 6.10-rc1 fails for me in serial_base.o:
   CALL    scripts/checksyscalls.sh
   DESCEND objtool
   INSTALL libsubcmd_headers
   CC [M]  drivers/tty/serial/serial_port.o
   LD [M]  drivers/tty/serial/serial_base.o
   MODPOST Module.symvers
ERROR: modpost: "pnp_bus_type" [drivers/tty/serial/serial_base.ko] 
undefined!
make[2]: *** [scripts/Makefile.modpost:145: Module.symvers] Error 1
make[1]: *** 
[/woody/src/kernels/linux-6.10-pingu/work/linux-6.10/Makefile:1892: 
modpost] Error 2
make: *** [Makefile:246: __sub-make] Error 2

Reversing the patch "fixes" the problem :-(
I am building on a Debian bookworm system, gcc 12.2

Any suggestions  how to make it work?

Thanks, Woody



