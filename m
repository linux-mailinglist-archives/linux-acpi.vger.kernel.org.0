Return-Path: <linux-acpi+bounces-6693-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E0491D746
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 07:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98881F21E6B
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 05:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E992C22075;
	Mon,  1 Jul 2024 05:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rsj1X60r"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5112F29;
	Mon,  1 Jul 2024 05:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719810378; cv=none; b=A5Gzfx4Ko8nQ4Qe8dlWFCXqSzPFI9vACsEc4cwVK5/Wd7llr3Us3xdMzlrGGz9pDhspoUkpdsCpwdCqEVV8HiR2y5b1ltg3ms1f2vgTQ2kG4QME6CxUr+VS9BjDsbxAqdmWiyMMsAD14tg1QTkg3AiN97EdHjQjcoW0dohuaBl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719810378; c=relaxed/simple;
	bh=nTVRxiCIHz9LY6D6rR9agA7CNvFvd2tSLrxtF3txtyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ts5zjAE/jeM1SGxlc9SoZ/mCR8p0j30oOKzRNCEk/Mq3T2OZ85VG2UeNQ0qZUdej/mRGYnVRse03rXobxqs/sovsxyCteF7+y5ctAkq5llxAJeGs4syrWmnMIStEDn/ioT6GE53ZTLbmFO4iKOR7At6SrgOIUX0dTrHVreKFx/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rsj1X60r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1EF9C116B1;
	Mon,  1 Jul 2024 05:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719810378;
	bh=nTVRxiCIHz9LY6D6rR9agA7CNvFvd2tSLrxtF3txtyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rsj1X60r5k8zoOZ/tMjPj3MEpSt29Ik/CKAZFecM6Ah22Hlw235MtTmJjnKDaiEph
	 hGGJJegMH85RkxbVEcbcr5PRR167fxuaKkN2nGi4ekEWMaruAglDJvv0lkz6ubQ45h
	 q7IuooW9Xzvd8Hxw+scIOS5OGIK05SqHjhr76Q24=
Date: Mon, 1 Jul 2024 07:06:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, mario.limonciello@amd.com,
	akpm@linux-foundation.org, jserv@ccns.ncku.edu.tw,
	alexdeucher@gmail.com, belegdol@gmail.com,
	regressions@leemhuis.info, linux-acpi@vger.kernel.org,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: processor_idle: Fix invalid comparison with
 insertion sort for latency
Message-ID: <2024070102-overvalue-barber-806a@gregkh>
References: <ZoHKhr9896+Kf65F@visitorckw-System-Product-Name>
 <20240701044232.42266-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701044232.42266-1-visitorckw@gmail.com>

On Mon, Jul 01, 2024 at 12:42:32PM +0800, Kuan-Wei Chiu wrote:
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
> Reported-by: Julian Sikorski <belegdol@gmail.com>
> Closes: https://lore.kernel.org/lkml/70674dc7-5586-4183-8953-8095567e73df@gmail.com/
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> v1 -> v2:
> - Avoid swapping if arr[i] is an invalid element.
> 
> I do not have the appropriate AMD hardware to reproduce this issue and
> test the patch. However, if the aforementioned reason is indeed the
> source of the problem, I believe this patch might help.
> 
>  drivers/acpi/processor_idle.c | 35 ++++++++++++++---------------------
>  1 file changed, 14 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index bd6a7857ce05..813c718b9108 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -386,25 +386,21 @@ static void acpi_processor_power_verify_c3(struct acpi_processor *pr,
>  	acpi_write_bit_register(ACPI_BITREG_BUS_MASTER_RLD, 1);
>  }
>  
> -static int acpi_cst_latency_cmp(const void *a, const void *b)
> +static void acpi_cst_latency_sort(struct acpi_processor_cx *arr, size_t length)
>  {
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
> -
> -	if (!(x->valid && y->valid))
> -		return;
> -	swap(x->latency, y->latency);
> +	for (i = 1; i < length; i++) {
> +		if (!arr[i].valid)
> +			continue;
> +		for (j = i - 1, k = i; j >= 0; j--) {
> +			if (!arr[j].valid)
> +				continue;
> +			if (arr[j].latency > arr[k].latency)
> +				swap(arr[j].latency, arr[k].latency);
> +			k = j;
> +		}
> +	}
>  }
>  
>  static int acpi_processor_power_verify(struct acpi_processor *pr)
> @@ -449,10 +445,7 @@ static int acpi_processor_power_verify(struct acpi_processor *pr)
>  
>  	if (buggy_latency) {
>  		pr_notice("FW issue: working around C-state latencies out of order\n");
> -		sort(&pr->power.states[1], max_cstate,
> -		     sizeof(struct acpi_processor_cx),
> -		     acpi_cst_latency_cmp,
> -		     acpi_cst_latency_swap);
> +		acpi_cst_latency_sort(&pr->power.states[1], max_cstate);
>  	}
>  
>  	lapic_timer_propagate_broadcast(pr);
> -- 
> 2.34.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

