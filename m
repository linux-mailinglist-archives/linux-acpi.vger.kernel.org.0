Return-Path: <linux-acpi+bounces-19155-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3726AC746C4
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Nov 2025 15:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4A968345653
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Nov 2025 13:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A7734679C;
	Thu, 20 Nov 2025 13:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFPBozye"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16480346773;
	Thu, 20 Nov 2025 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763647107; cv=none; b=GBLqp+xWFnVwXndTUINPOC34d3kF2mWOj8m/q8b+0oOyWEbWE1Pnx4PJH9/wy342ynMp/u9FzEXhHjgDYwHDGASw1cc1/HQDYPJFywyvwoqeC5uKiAVdyIp+8xXh3RlTa/3HzQWgO5D9g2BRKxHKyaM9V7SWJFdCZhmmX4vBhg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763647107; c=relaxed/simple;
	bh=KR/hesnZY4RTTEFQQlrM9muuVYaRuwrKNiMApHbbzY0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=cWhxm9gQ5ZGbYWSuxiaVFh17Liy1jzAygjScrf0aTN3aNDm4mKPoL5g6tBtBQ6lZJMQacPDqDBZoh3sqcs4jxNzZbkCtqBQdLBXZB15wEqOyvwRtI11AntbjtybT30obAHlaVUT4uAP1hKpWNdSBmjbF4Lpkmxv2H8mKrXSVdFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFPBozye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79843C4CEF1;
	Thu, 20 Nov 2025 13:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763647106;
	bh=KR/hesnZY4RTTEFQQlrM9muuVYaRuwrKNiMApHbbzY0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iFPBozyeyYp09OkHTOu+zLEMGPr/BveXSLgVFa7QtLaXHMmLIwH9KJB1QRjRPpP+U
	 IIl7uQCMr3CTchViPETT73sw0LwNGfFOs54lcIsWyhXJnqvGFFP8G+Y4rCGP0JZefC
	 5POloPxuY+Kb2zK0PDFcpD5hWRMNK6b2gFnScwKS7Pt91915RjP0ZP2+9QYuHay2vn
	 5mLOLIne2F3P3mZhNepO+F58WEPXaySidcVTbTHZ3DqfTwpEo9jLkLwRjWfh03Z1ag
	 lIQDPuT4GLgnptJQWFAkonqlEGiUCRbYU23abdckkkdQoT4On7AerPzH2gqxuWoRJd
	 BnIyK+dLxMyxQ==
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vM5B2-00000006u14-1zXj;
	Thu, 20 Nov 2025 13:58:24 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 20 Nov 2025 13:58:24 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] ACPI: GTDT: Correctly number platform devices for MMIO
 timers
In-Reply-To: <20251030110115.1842961-1-maz@kernel.org>
References: <20251030110115.1842961-1-maz@kernel.org>
Message-ID: <5a60d5e8b9cf0fabfaf8b2bc1449d842@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, pavan.kondeti@oss.qualcomm.com, guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de, mark.rutland@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On 2025-10-30 11:01, Marc Zyngier wrote:
> Use the actual timer counter instead of the watchdog counter.
> 
> Fixes: 5669d92f3efa4 ("ACPI: GTDT: Generate platform devices for MMIO 
> timers")
> Reported-by: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
>  drivers/acpi/arm64/gtdt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
> index fd995a1d3d248..8cc8af8fd408c 100644
> --- a/drivers/acpi/arm64/gtdt.c
> +++ b/drivers/acpi/arm64/gtdt.c
> @@ -430,10 +430,10 @@ static int __init gtdt_platform_timer_init(void)
>  				continue;
> 
>  			pdev = platform_device_register_data(NULL, "gtdt-arm-mmio-timer",
> -							     gwdt_count, &atm,
> +							     mmio_timer_count, &atm,
>  							     sizeof(atm));
>  			if (IS_ERR(pdev)) {
> -				pr_err("Can't register timer %d\n", gwdt_count);
> +				pr_err("Can't register timer %d\n", mmio_timer_count);
>  				continue;
>  			}

Any chance for this to be picked before 6.18 is fully baked?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

