Return-Path: <linux-acpi+bounces-8871-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C68059A660C
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 13:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C2E1C21DB6
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 11:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652A71E500F;
	Mon, 21 Oct 2024 11:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c35tI+wI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A7539FD6
	for <linux-acpi@vger.kernel.org>; Mon, 21 Oct 2024 11:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729509158; cv=none; b=BpqhNaeusDZZE/MAIM6/uY5eVK/lW3aoUbqfuRxCKDpVy1rO/EOR2G5373+g3IarugnOWGiqZLgrfBt7ecmDcLpyKHjDHZPl5SRv+kuerZTlkF3s803ehBB6rPtU+yS4ShxsYRnG1UQW34nBWkSD4OcQgPrMO2rp7eWCNFVCcfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729509158; c=relaxed/simple;
	bh=pUN1oDTgXpxMIKsHHSGG0fFYnRsnYumXx+HYjZo8ZD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X0KWPq2aGuL8nMPAt9/LyKan4jqgBCapd3usKUpP/Bn8rjEpCr0k0hQ61brqnjzK+AIgfdyDee6jB5e4bjPBBQC0wc/3rPoQJhqYJi7qC6lVZtDhLAQIBw/HaYg6A760aRM8RWcBl2m12CHSMl/kTUewY2R6loi/vf4QHGs7abk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c35tI+wI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729509155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fbws/WxUwNejDptwzJqGW+4L+Nq8J7RK8+TX0K4g9ys=;
	b=c35tI+wIYDJ/vaNjVIp6i0Q8liPMMBnOq5PGx0mx1PfbVUeUMjJcZzS5Aj8i5/qWRplBDv
	Dl8Y0pyXGyyGoQulZqXcBTuvyp7TRIfDGF3pGbF4Mj5JKf4S5ltGT1j44dyD+knM2/8GZW
	7X3dLbwA4B07zQguoQecUBqpZmcA3Ms=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-JkQCnXsGM6aKEK8Ww5Y0kw-1; Mon, 21 Oct 2024 07:12:32 -0400
X-MC-Unique: JkQCnXsGM6aKEK8Ww5Y0kw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7a7fa073718so851909285a.3
        for <linux-acpi@vger.kernel.org>; Mon, 21 Oct 2024 04:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729509152; x=1730113952;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fbws/WxUwNejDptwzJqGW+4L+Nq8J7RK8+TX0K4g9ys=;
        b=q8opRFT5k4p/stfVucq9zFFO3wi8MbC5bHJrVaC/O1P5PAtIzb9J7rvQD/b1XIXvb+
         ksLifKxlVaV/skI0o7WzvEJCGFhkqbGGih+yNHFrg+bYc1kfAew6FqubWBqB0arlS5Jy
         7bxdJK+q5Zq+23ZZiTMmRHg2DGQiJS9Axv/lQX9zwarJJ8xo4tRGSpBszaJHJMzq4Mv8
         uZbDTFVDO+vdn0o6OysSfTi7VeJANOJQoG4lKXT99nHkgpiSheWwhhJtM7FdugXa8sP3
         0zfd3zzLYUMszfvN6M63jsxyIP5a6V5mFGDsAjSiC1Kk0MTlGxyZJmHtsvs/m/1gyv9s
         XS/A==
X-Forwarded-Encrypted: i=1; AJvYcCWWiSuRvHbbN/ws0FnFGtGTui8j7BT+xi6hb8nJcB3WQH6Zd68rQS/ZtAZihCsVYt99wSimTVTGsqz/@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy9hk7HDvJKqAFySy7wAGUtFfyda0ZG/gEbzbPIWZ/fpe5ExWC
	Isc+dfQdz/5au+KBzxpK03Q5HjPOUWv2lV2kEHERWTgtgjvK2G1VO+ODevwCg5A+n4DAh3WNLmu
	2CREXFZAISS+XJO/GcBiCfbT64hcnbiXCJSIru86W0J/TGea4gqhjnpvInjU=
X-Received: by 2002:ad4:410a:0:b0:6cc:2bff:59ef with SMTP id 6a1803df08f44-6cde159f200mr128252816d6.32.1729509151702;
        Mon, 21 Oct 2024 04:12:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/Myrk7JQKGKcX2DwyI+RFEzwP7PtOkGIb/F7m2G4o82Hac+RLHvXfLdMtzCiV+zSpAtATcw==
X-Received: by 2002:ad4:410a:0:b0:6cc:2bff:59ef with SMTP id 6a1803df08f44-6cde159f200mr128252616d6.32.1729509151376;
        Mon, 21 Oct 2024 04:12:31 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:36d3:2b96:a142:a05b? ([2a09:80c0:192:0:36d3:2b96:a142:a05b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce009dd27fsm16042386d6.109.2024.10.21.04.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 04:12:30 -0700 (PDT)
Message-ID: <7b877356-f5c5-4996-904b-6c3b71389255@redhat.com>
Date: Mon, 21 Oct 2024 13:12:26 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] x86: probe memblock size advisement value during
 mm init
To: Gregory Price <gourry@gourry.net>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 rafael@kernel.org, lenb@kernel.org, rppt@kernel.org,
 akpm@linux-foundation.org, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, rrichter@amd.com, ytcoode@gmail.com,
 haibo1.xu@intel.com, dave.jiang@intel.com
References: <20241016192445.3118-1-gourry@gourry.net>
 <20241016192445.3118-3-gourry@gourry.net>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
In-Reply-To: <20241016192445.3118-3-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



Am 16.10.24 um 21:24 schrieb Gregory Price:
> Systems with hotplug may provide an advisement value on what the
> memblock size should be.  Probe this value when the rest of the
> configuration values are considered.
> 
> The new heuristic is as follows
> 
> 1) set_memory_block_size_order value if already set (cmdline param)
> 2) minimum block size if memory is less than large block limit
> 3) [new] hotplug advise: lesser of advise value or memory alignment
> 4) Max block size if system is bare-metal
> 5) Largest size that aligns to end of memory.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>   arch/x86/mm/init_64.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index ff253648706f..b72923b12d99 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1439,6 +1439,7 @@ static unsigned long probe_memory_block_size(void)
>   {
>   	unsigned long boot_mem_end = max_pfn << PAGE_SHIFT;
>   	unsigned long bz;
> +	int order;
>   
>   	/* If memory block size has been set, then use it */
>   	bz = set_memory_block_size;
> @@ -1451,6 +1452,21 @@ static unsigned long probe_memory_block_size(void)
>   		goto done;
>   	}
>   
> +	/* Consider hotplug advisement value (if set) */
> +	order = memblock_probe_size_order();

"size_order" is a very weird name. Just return a size?

memory_block_advised_max_size()

or sth like that?

> +	bz = order > 0 ? (1UL << order) : 0;
> +	if (bz) {
> +		/* Align down to max and up to min supported */
> +		bz = 
> +		/* Use lesser of advisement and end of memory alignment */
> +		for (; bz > MIN_MEMORY_BLOCK_SIZE; bz >>= 1) {
> +			if (IS_ALIGNED(boot_mem_end, bz))
> +				goto done;

This looks like duplicate code wit the loop below.

Could we refactored it into something like:

advised_max_size = memory_block_advised_max_size();
if (!advised_max_size) {
	bz = MAX_BLOCK_SIZE;
	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR)
		goto done,
} else {
	bz = max(min(advised_max_size, MAX_BLOCK_SIZE), MIN_MEMORY_BLOCK_SIZE);
}

for (; bz > MIN_MEMORY_BLOCK_SIZE; bz >>= 1) {
	if (IS_ALIGNED(boot_mem_end, bz))
		break;



-- 
Cheers,

David / dhildenb


