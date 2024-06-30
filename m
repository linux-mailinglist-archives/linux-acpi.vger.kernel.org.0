Return-Path: <linux-acpi+bounces-6690-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB5391D421
	for <lists+linux-acpi@lfdr.de>; Sun, 30 Jun 2024 23:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0B302812DD
	for <lists+linux-acpi@lfdr.de>; Sun, 30 Jun 2024 21:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586674EB45;
	Sun, 30 Jun 2024 21:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UU1MkyTk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F27259C;
	Sun, 30 Jun 2024 21:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719782028; cv=none; b=LBoLcauGPxTqCTlpnuycS/0ISlyiQN6t1IwzY8v2sOWNpTe73vIuzVBSUbRgfSiEamM8g+5mw1A2pGcEWFcO8WHsajW/ZXexLrgXp+UinuFOXCSWNEcKIpiREN8MfUOdtMmbWCGBsbE4wLIjagmrYZNG0YLmllX0wOkhfvxFiIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719782028; c=relaxed/simple;
	bh=rrGAkHp6yz56bzzoabSlg7wA/pYZ84y3v4eNyqhO+18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYF/9jH6bhU3YlIk+bs6b7+LKc8Kte8Ibuh7PpoXjjb1Kjc0b4SQcTPp34XTXgIvxFIk0FTSMi6c40WnRn91a8Kg+QLcMkxpiKK9W7MFbOROD3wWrS/4NISsEc5/o0uSiD1yPlsIeF95PXOXQ+Mf4OdzCuQ1AZMNmW1UmlDUMD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UU1MkyTk; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c7af3116aaso460859a91.2;
        Sun, 30 Jun 2024 14:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719782026; x=1720386826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KWboog+rqvm9Ox6aVkr8ZlT55isuINvZAP74QVmennY=;
        b=UU1MkyTkQx5U1I3ILtGXX3cls6Cft4lE9sUQ6LxLjgdjS/tL6msV3cl3pWpFZB6CIp
         0IttR38QdreuIDtx5yAvPii7csprD95Gu22MoTtJGkNTQTjtf/EMxBXTS/NscbD8uHIj
         MxMqVVP+c30869mLYA9esRUET+KmviFJaEb/aylNP6YM1Dl1CNtGdJvaOls+zwICqRgz
         IDGMlIIrxDyje8Y0DPpgD5Q6CSeVZ9XFtfj+KmTH/qPj6mUSCPV0kGmF4zsd29+9Jb4H
         0b2Bczbzfl+QaQ10EXfMO4KB84VjCcqzFtdd0E2bZfajgOLjEHdBYfwNk2tmjbP6ckls
         w96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719782026; x=1720386826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWboog+rqvm9Ox6aVkr8ZlT55isuINvZAP74QVmennY=;
        b=usmeNFKakSJWQ6Aq3sGCMEuvhDmYEIJvDTa31G5sxyF6cOkJZHSBg8XAORUG/q1mSh
         HghCeEUH9ZTqySdxE7SzUbO5iwiAnxrqMNti/2xbvuVV6PdTRsEldsWGDHxeAYTL9owh
         PQegoKRbDuvt3FSJSYKxwSkbTlxEunRCDXUfYYdLpIktYS3xxiXJFkIPDm6baAxFISms
         vHnzG8h0gDwTpFOGHw7uY5sXeSc8ReGskXLizvjWyUBkbPPCQoWoeI99R7UnIWFkddHS
         pNREu0cVVVCSS5aHL+ip8Zddi6c1FvS8+tiZXc8aoR+GWy/ruSsW9frNRpLnYunwOr5O
         nw3w==
X-Forwarded-Encrypted: i=1; AJvYcCW9Ct23NKr6JlOzfYdlPjhBs6oaDQoFRB5uTxJrPCn+QO+ZWlikE3vp93bIdpLn3oR/LuucBOeeieW9szpe5+TvwV5lvfPsdULeSqVM9WQ3SZkcquQQ94VeU+naLUI9+13dK89394uGbw==
X-Gm-Message-State: AOJu0YzKRL+0B4DwZmojKV1A2VkQgc1v3OcTux3OOWCVE2D3Yhls9xCQ
	yRxyCHJoQ/EC/ltghuVO+eiEzcG0Bw4m+/9hRDjSLTYgfjshzEXq
X-Google-Smtp-Source: AGHT+IEAORVQLS8cR6dbwN7ffYUcCD5We/uJF3ts8HFuUIw4j+xA3za4nZQWDIJsz/TIawY3K6lm1w==
X-Received: by 2002:a17:902:ec88:b0:1fa:ab25:f634 with SMTP id d9443c01a7336-1fadbd13592mr49994765ad.3.1719782026060;
        Sun, 30 Jun 2024 14:13:46 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72d8e3f0e11sm3918263a12.87.2024.06.30.14.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 14:13:45 -0700 (PDT)
Date: Mon, 1 Jul 2024 05:13:42 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: rafael@kernel.org
Cc: lenb@kernel.org, mario.limonciello@amd.com, akpm@linux-foundation.org,
	jserv@ccns.ncku.edu.tw, alexdeucher@gmail.com, belegdol@gmail.com,
	linux-acpi@vger.kernel.org, regressions@lists.linux.dev,
	regressions@leemhuis.info, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: processor_idle: Fix invalid comparison with
 insertion sort for latency
Message-ID: <ZoHKhr9896+Kf65F@visitorckw-System-Product-Name>
References: <c6f4cca2-9258-4dc9-8d4e-96ab7c587783@leemhuis.info>
 <20240630210809.37550-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240630210809.37550-1-visitorckw@gmail.com>

+ linux-kernel@vger.kernel.org

On Mon, Jul 01, 2024 at 05:08:09AM +0800, Kuan-Wei Chiu wrote:
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
> I do not have the appropriate AMD hardware to reproduce this issue and
> test the patch. However, if the aforementioned reason is indeed the
> source of the problem, I believe this patch might help.
> 
>  drivers/acpi/processor_idle.c | 33 ++++++++++++---------------------
>  1 file changed, 12 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index bd6a7857ce05..d58a7c64d80b 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -386,25 +386,19 @@ static void acpi_processor_power_verify_c3(struct acpi_processor *pr,
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
> @@ -449,10 +443,7 @@ static int acpi_processor_power_verify(struct acpi_processor *pr)
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

