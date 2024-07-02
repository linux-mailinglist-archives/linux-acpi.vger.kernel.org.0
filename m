Return-Path: <linux-acpi+bounces-6726-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6839391F020
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 09:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD7171F2239B
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 07:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F3C14A4EF;
	Tue,  2 Jul 2024 07:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fdb3KBO6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1676E14885D;
	Tue,  2 Jul 2024 07:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719905326; cv=none; b=Lyb3r0j0EAt8mL0T+B7xiFtsefKiBBhjyoMAaJHLAvEIh20Bv3ApmUfpE94qgV9HdrNAiUVsUXKG91esYPEomh/rzF7YeSrx8HIrrgYlTn3sTSXH4IIGVAxCmGDWKuvkPO5vghjv1bpfyv0BvdVwXyURzMI1tP9FG0wV57c9W2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719905326; c=relaxed/simple;
	bh=vsqePUHcK0fv7suLmKyy9AE69S893Nx2DFSfYA7/48Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O4zxKkJd9kMvkrzMMvTdL39FweuC3wqstzajoeBVStKRge57lPHaA9z5kMOhlNVtcIFyE5TeWoWTfU4rc3cqARGA9NUZpz3snSKnsQsdjJnE/xMlDoQ43jmM7x3ie/6vI7Z6qVgfcLjWexdkpeQwv3a+02Q4hNH+nhIAMKw/EuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fdb3KBO6; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7523f0870cso248783866b.3;
        Tue, 02 Jul 2024 00:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719905321; x=1720510121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZjkiIMimDM469BE4g0PtLb2eLPRo0mVKPcjnEkFhjs0=;
        b=Fdb3KBO6Jh7FeZJWQIdZf7+86ycNHbhm51rJ+V/KSA1Y47LVR2ruyNmExL5ck/g5rz
         sBl79Dfmtld50O/Sl+E46rJL4/xI3JrK5Ly9bdRnBfUo+gYcOQk249slh5NP0xM0yl60
         amQzOtTMjRVGBOl4VgsImIKtqMjDbC6dXtC5RgUoTM45LPhkyVV8YlYTHJTJaVmYYiXk
         QSjDfOMxyksN6yaVch3wo91Q57xH/6OjkB4raOVhxiBS5Y4p1eWtevzDkGeisVIXYV3Q
         BT9Ux8Hb3c+BA8MKRtkJKrOVk2yiL00O37v8lY+5h8a2gQtFFxMJZTvqHouDI6ivC8Q5
         ChDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719905321; x=1720510121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjkiIMimDM469BE4g0PtLb2eLPRo0mVKPcjnEkFhjs0=;
        b=IORYZy67U1waiDAZ/7VdBmSFRuS/WqE1nrvuvcGV1DyvbRIy0ih+A9Y0vSfV2uqweB
         K2arq4E/quEJ8Ph5u83iJehZEDx6Cy/mZtVywFOSSVny1wOichmHuRvJkwsDRU2PEso+
         5aeYFw0lfaS9ZYdMCDdni45hfPHN4mRdRNtqjuoKLi68pgBrrKNY29hVNG5VybCbTrXm
         9qPylnSjHQ361kBXg8t3DcaEDqZyYLD8RKbNahtHThpFcGonukB2jr1h2QRQ/ap0hRNY
         1m/mLXeFmLV1swiyuZmlcbqMn2Ind4aMaSSLBL0FzMfCfKObjqdxeSciHyPODpEfVRYG
         dXzA==
X-Forwarded-Encrypted: i=1; AJvYcCVHK1pjPpdT8xLLytwBD+B4MsklGa3gcl8eTCArPt9OLfOnMIdQV/+L9WzEdj+lwv5MZgBeG44drimUd32RgZkdUJCzCJLivxXDq0kFZlNn+sFbH5ECL8kkGWWDcOO73hER5D/hEafjruY0p+CszuZvwddA7Qp0QXoNKG5fB15aYA==
X-Gm-Message-State: AOJu0YwJu3riLyoGTdjvoQS60d2wzNpkd6W4bo2IZsAyjbGtDTzUKCeT
	Kq4KKMBLdVCiZhs9JEEWJ1C1Dd+obroka7XGzhfJA3kWoSy5aRHd
X-Google-Smtp-Source: AGHT+IEqfipeae6eXqvRg9I/YLGEBz4jcyUx09ob+ngbQXPCuRclXOGmihGS1vdIK2VK9uvDeeqapg==
X-Received: by 2002:a17:906:d7a2:b0:a72:7da4:267c with SMTP id a640c23a62f3a-a751440237fmr490569466b.12.1719905321190;
        Tue, 02 Jul 2024 00:28:41 -0700 (PDT)
Received: from ?IPV6:2a02:908:1980:aac0::f4a9? ([2a02:908:1980:aac0::f4a9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7525fb8387sm166302366b.94.2024.07.02.00.28.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 00:28:40 -0700 (PDT)
Message-ID: <81aa100e-044c-4ea8-a2ff-cd34711e137e@gmail.com>
Date: Tue, 2 Jul 2024 09:28:39 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ACPI: processor_idle: Fix invalid comparison with
 insertion sort for latency
To: Kuan-Wei Chiu <visitorckw@gmail.com>, rafael@kernel.org
Cc: lenb@kernel.org, mario.limonciello@amd.com, akpm@linux-foundation.org,
 jserv@ccns.ncku.edu.tw, alexdeucher@gmail.com, regressions@leemhuis.info,
 linux-acpi@vger.kernel.org, regressions@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <CAJZ5v0iY=S+WKWvDAAWxLcOwvpOG5Cck1gQv4p+FfW1Nca0Yqw@mail.gmail.com>
 <20240701205639.117194-1-visitorckw@gmail.com>
Content-Language: en-US
From: Julian Sikorski <belegdol@gmail.com>
In-Reply-To: <20240701205639.117194-1-visitorckw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 01.07.24 um 22:56 schrieb Kuan-Wei Chiu:
> The acpi_cst_latency_cmp comparison function currently used for sorting
> C-state latencies does not satisfy transitivity, causing incorrect
> sorting results. Specifically, if there are two valid acpi_processor_cx
> elements A and B and one invalid element C, it may occur that A < B,
> A = C, and B = C. Sorting algorithms assume that if A < B and A = C,
> then C < B, leading to incorrect ordering.
> 
> Given the small size of the array (<=8), we replace the library sort
> function with a simple insertion sort that properly ignores invalid
> elements and sorts valid ones based on latency. This change ensures
> correct ordering of the C-state latencies.
> 
> Fixes: 65ea8f2c6e23 ("ACPI: processor idle: Fix up C-state latency if not ordered")
> Cc: stable@vger.kernel.org
> Reported-by: Julian Sikorski <belegdol@gmail.com>
> Closes: https://lore.kernel.org/lkml/70674dc7-5586-4183-8953-8095567e73df@gmail.com/
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> v3 -> v4:
> - Rename the parameter 'arr' to 'states'.
> - Add empty lines to enhance readability.
> 
> Note: I only performed a build test and a simple unit test to ensure
>        the latency of valid elements is correctly sorted in the randomly
>        generated data.
> 

Hello,

thanks for the patch. I have tested this applied on top of Fedora 6.9.7 
kernel on my Asus laptop and the message about suspend not reaching the 
deepest state is gone. Thank you.
I wonder whether this will also fix random S3 suspend issues I have been 
seeing on my 5600x since 6.9 kernel too. I will definitely try.

Best regards,
Julian

Tested-by: Julian Sikorski <belegdol@gmail.com>

>   drivers/acpi/processor_idle.c | 37 +++++++++++++++--------------------
>   1 file changed, 16 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index bd6a7857ce05..831fa4a12159 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -16,7 +16,6 @@
>   #include <linux/acpi.h>
>   #include <linux/dmi.h>
>   #include <linux/sched.h>       /* need_resched() */
> -#include <linux/sort.h>
>   #include <linux/tick.h>
>   #include <linux/cpuidle.h>
>   #include <linux/cpu.h>
> @@ -386,25 +385,24 @@ static void acpi_processor_power_verify_c3(struct acpi_processor *pr,
>   	acpi_write_bit_register(ACPI_BITREG_BUS_MASTER_RLD, 1);
>   }
>   
> -static int acpi_cst_latency_cmp(const void *a, const void *b)
> +static void acpi_cst_latency_sort(struct acpi_processor_cx *states, size_t length)
>   {
> -	const struct acpi_processor_cx *x = a, *y = b;
> +	int i, j, k;
>   
> -	if (!(x->valid && y->valid))
> -		return 0;
> -	if (x->latency > y->latency)
> -		return 1;
> -	if (x->latency < y->latency)
> -		return -1;
> -	return 0;
> -}
> -static void acpi_cst_latency_swap(void *a, void *b, int n)
> -{
> -	struct acpi_processor_cx *x = a, *y = b;
> +	for (i = 1; i < length; i++) {
> +		if (!states[i].valid)
> +			continue;
>   
> -	if (!(x->valid && y->valid))
> -		return;
> -	swap(x->latency, y->latency);
> +		for (j = i - 1, k = i; j >= 0; j--) {
> +			if (!states[j].valid)
> +				continue;
> +
> +			if (states[j].latency > states[k].latency)
> +				swap(states[j].latency, states[k].latency);
> +
> +			k = j;
> +		}
> +	}
>   }
>   
>   static int acpi_processor_power_verify(struct acpi_processor *pr)
> @@ -449,10 +447,7 @@ static int acpi_processor_power_verify(struct acpi_processor *pr)
>   
>   	if (buggy_latency) {
>   		pr_notice("FW issue: working around C-state latencies out of order\n");
> -		sort(&pr->power.states[1], max_cstate,
> -		     sizeof(struct acpi_processor_cx),
> -		     acpi_cst_latency_cmp,
> -		     acpi_cst_latency_swap);
> +		acpi_cst_latency_sort(&pr->power.states[1], max_cstate);
>   	}
>   
>   	lapic_timer_propagate_broadcast(pr);


