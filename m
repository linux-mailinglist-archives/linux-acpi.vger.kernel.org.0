Return-Path: <linux-acpi+bounces-16619-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F5FB5225E
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 22:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 887455E0AA1
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 20:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA202F0689;
	Wed, 10 Sep 2025 20:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avp2rBjb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A9B276051;
	Wed, 10 Sep 2025 20:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757536735; cv=none; b=fcxQcWczLAC1Fb6gbvvLO6i0cpsIwb+030HZMKgM5rVnkvVK9tlmE9Ims7jAu9T3GlMpf/HQsW1Mt5+2awGYhAQwYWHt1aKbdH0g47ssstgPnUPFgro2Vn2hIiFsTonO4BtFW+3UL+Fhto3eWoumUj9JxUqoQB/oLt2Ax81NHnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757536735; c=relaxed/simple;
	bh=Qc7VVKLYxh1gMnE/3edQvIAPvq8WadMou5rsvxLU/Sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n9Tg8PMmyQOkikYn2Edum25pG6PkZFAHBwL5p/X2LQLUUHcfc+c/np/gSZgLt78BJ5HQdqX7itYdJLz5NKx/sOXsHFs9gyycly9chI9FAF5B5W12vJ9mdQdfh6HmDxJbXPn9ri4knCOvagC0wKORMEplNVqO17WSEWY/zUqsBH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avp2rBjb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5828DC4CEEB;
	Wed, 10 Sep 2025 20:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757536733;
	bh=Qc7VVKLYxh1gMnE/3edQvIAPvq8WadMou5rsvxLU/Sg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=avp2rBjbqBHsv4g/yv/iGYx+noNh/KdS1xlIekvozlyt5X+pCTma4TlOeJdlYP1st
	 jtbSOZdwCecEtOKyXDCKWi2nwyRVEyLTranTRPY/Xu2Y7KZEaoX3GsdZl7x837XksS
	 Eq7Hm2WxBoIhABU8Vd4XyQoeAJziIBxzmJp3n/RCK247jxLWGVThHXPrL2EjRDi3QC
	 3t4jOpjT3mupmmS4Aob2bS3bFY8U0UkBNap6/rM/nuaMVXOZPno/iHv5OMoSxpcFZH
	 bc2u2JmHAwXJbNlSXCkIX7alstaU0BlhLrD5neFIrYgH4125GyYS/xndWTNoPM7jPa
	 SZSCrv6y/TYNQ==
Message-ID: <bb565554-f7f8-4e40-8ca4-d265f59aec9e@kernel.org>
Date: Wed, 10 Sep 2025 15:38:52 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpufreq: ACPI: Use on_each_cpu_mask() in drv_write()
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "Gautham R . Shenoy" <gautham.sheoy@amd.com>
References: <2797300.mvXUDI8C0e@rafael.j.wysocki>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <2797300.mvXUDI8C0e@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/25 6:41 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make drv_write() call on_each_cpu_mask() instead of using an open-coded
> equivalent of the latter.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

I feel you should also update the comment before do_drv_write() to 
mention it's called with a NULL conditional to 
smp_call_function_many_cond(), or just drop that comment.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

>   drivers/cpufreq/acpi-cpufreq.c |    8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -335,14 +335,8 @@ static void drv_write(struct acpi_cpufre
>   		.val = val,
>   		.func.write = data->cpu_freq_write,
>   	};
> -	int this_cpu;
>   
> -	this_cpu = get_cpu();
> -	if (cpumask_test_cpu(this_cpu, mask))
> -		do_drv_write(&cmd);
> -
> -	smp_call_function_many(mask, do_drv_write, &cmd, 1);
> -	put_cpu();
> +	on_each_cpu_mask(mask, do_drv_write, &cmd, true);
>   }
>   
>   static u32 get_cur_val(const struct cpumask *mask, struct acpi_cpufreq_data *data)
> 
> 
> 


