Return-Path: <linux-acpi+bounces-18684-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BE4C4278F
	for <lists+linux-acpi@lfdr.de>; Sat, 08 Nov 2025 06:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D37944E2F40
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Nov 2025 05:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67DD2D8391;
	Sat,  8 Nov 2025 05:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IdJywvRn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="C8kn+qWm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448EB22A4DB
	for <linux-acpi@vger.kernel.org>; Sat,  8 Nov 2025 05:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762578677; cv=none; b=DnZlqj6Q2Ge4pQxaCgolwYf3Ty5ffGysX6gwuThuMObvcaPSYBLgxXaf9oCvlX76qKSZATma7S8uewg7KUgevXcgA2+h8vRHWAXkQ19O8xk6dAmwBIqMplBQMoyTdrXb6x89LcetWFHieumGbf4DkakVb/iVu7wSwCT+nCTA/qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762578677; c=relaxed/simple;
	bh=X2j9RurZZ2lQAPVeaVJyZ9A4M+s8fzPu+nQ2gpSP1K0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tTh2qFNLMjURTfCXkysox5zU+f5zzbAbJDqcmnp7lqI2QqXqdHIrEwx5RIrJB90ZXwbd5EpUfbVErpJyvkZXpvR9hIOYxHL1KJdFLTgqJZyWZXgfJEejD89gLFTT4e37aTUnIQsQ2uy6z5dAiJ6G7bg3ie8jwE2LnHipyDjJgAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IdJywvRn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=C8kn+qWm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762578675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E5RVKnDwMe3MsMRRiwpHYF55d6WxBj8NQ/HClkP7h0s=;
	b=IdJywvRnVjAoVOmg/bjjc3fwfnzqQ1VCKrDwf/04swwNFfz7MhVd/M5v0C14G+ZKP4+rxN
	Vzj9c6cySl21LF2y1mfS8v+xS/Xe5kMUaQpAJKrV5PsDNDYGxRferpqVE91+aGaD1JgsnJ
	7mYAcbnTSeQIQ8jVuhVyNMxYiBe5328=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-EBHhD-OBMpCohimXgzmDTw-1; Sat, 08 Nov 2025 00:11:13 -0500
X-MC-Unique: EBHhD-OBMpCohimXgzmDTw-1
X-Mimecast-MFC-AGG-ID: EBHhD-OBMpCohimXgzmDTw_1762578672
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-ba795c4d4a2so1010305a12.3
        for <linux-acpi@vger.kernel.org>; Fri, 07 Nov 2025 21:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762578672; x=1763183472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E5RVKnDwMe3MsMRRiwpHYF55d6WxBj8NQ/HClkP7h0s=;
        b=C8kn+qWmFrzL2HWSH8iIVK22VNn5YHBWKNDQGNcDJiBTr8ltcxtIfPVz1FHYix4Qbt
         VqcZViB2ST+4gJD77Cj86AZIgra4NjL/f1W/eOvuooJpH2Ap45SDQb12Dz3jF47RkvBs
         cqNKB1KEcH1KvsOUsIMzjXDFxGgt4t3qpLO8nNqjweEvJEgOlHW3TeLcu9nkvde580u9
         yGUvLRaQPdZ47sQHE1J5/e9UpObemXYsM2/G0wrbfGZTkItdoCICDsUIKTf39WW8xKDK
         kByIsy7ktMBJRrY0sJohhVseULHDEkmW8XqrsszmCuyZGNdboOaKSEyH9xhp2IaPL+V4
         Bbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762578672; x=1763183472;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E5RVKnDwMe3MsMRRiwpHYF55d6WxBj8NQ/HClkP7h0s=;
        b=b2smKtKEDQEf+YQrpiuPjopYJga90/OHxmHmJZxdEfBn2oNDmaBU4Nrlxb5fTloFQs
         NrVlOzxn5ljJOO9YaE3/MVXwCMoRzcgIcCD+pnyeqBJXzjkL4YRE82ZguahJ9xwmux02
         rY1iMvHVrOFxt2YBttFyPFknRk3ZKoi8ze680kt4onOSSSTMtgLnSwzRPz7oRnokRioV
         PJyHVQFuJx2IzlGRoXXn3R/ONUIe3Jpu5xuVzHmnNyCSd5A3M+5nXQBhtozDd9DIufUh
         PrC7jDHKhV5Q6UZBfGDdwYGECECsDORrNIHjfkCrZOIrtGWR/wicQXlDwwn+MC/UPjU4
         +1/g==
X-Forwarded-Encrypted: i=1; AJvYcCVlo9K625Blzh93igiDcsExuW+tRIJE7b3LaCmAdUarQFk2rqu9WEzuxWBv7dEoRgweRt4Q2zEWrZWt@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyp3aLsOng94lkNvWOFYmwZv15KWwqOG0MbzbsfGT3IIFvScl1
	ECGWCn3r7syav+G7qiyloC7qWkX/7UjJBtlJHb5BWHEUs9KWHui/NY+L7DOIPY8wdCbXI8YesDS
	VU5i5RCmAfCZe5wkYpf8CeSHy+OevvUEnFdmJk2CBHvyHBNaKLsc/O3nY7ZIpNmw=
X-Gm-Gg: ASbGncsRaWVYmAL96wCfVT1S7+7W/eDoah9L97riNzpxfDoLHeuqPC7FSgUpFiZ8bEo
	F9kuJKtMnthU2XyJGEY0CJGs9aN79JendLQqkcXKFsDnQ5Wj86TPcUXQXzdrfBG/UqaeU4OOuvU
	FMZs0+urT9uxNz32f/BUTFtgOqq87Fh6jdKoaGZBsy/3j1eosVBGqbI3Sted5OZc7On5KGHPkqL
	KwHVnluKZ4X0ibSUjL886lzYIoPemEBBzPPaz71fwJ/IK8kmCOHL9vOK0C0PlH1u4B3QAVTRRoq
	VVemSquC9F3XUP1yBIPyRjcXsjRLTTHmwa8pVygyMe6vV0RNL4reqtK1RsPht83+Lmwa9+23xd7
	k43nlwixfYsvZem9ko7o7CDzL6ShKqZ2hGgWawTk=
X-Received: by 2002:a05:6a20:6a08:b0:344:97a7:8c68 with SMTP id adf61e73a8af0-353a448bd92mr1787256637.54.1762578672051;
        Fri, 07 Nov 2025 21:11:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoYg32blcZZ9sLbQSYNsjasNR+q+OXQEln3dsLqwv+tsm09w3tu1QPNPDwtq+FZYazc0/esQ==
X-Received: by 2002:a05:6a20:6a08:b0:344:97a7:8c68 with SMTP id adf61e73a8af0-353a448bd92mr1787215637.54.1762578671653;
        Fri, 07 Nov 2025 21:11:11 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8ffe36a9dsm6671472a12.17.2025.11.07.21.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 21:11:11 -0800 (PST)
Message-ID: <74c37bd9-bf73-42ff-a9e9-dc55cc192c50@redhat.com>
Date: Sat, 8 Nov 2025 15:10:57 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/33] ACPI / PPTT: Add a helper to fill a cpumask from a
 cache_id
To: Ben Horgan <ben.horgan@arm.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 fenghuay@nvidia.com, gregkh@linuxfoundation.org, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-6-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-6-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 10:34 PM, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> MPAM identifies CPUs by the cache_id in the PPTT cache structure.
> 
> The driver needs to know which CPUs are associated with the cache.
> The CPUs may not all be online, so cacheinfo does not have the
> information.
> 
> Add a helper to pull this information out of the PPTT.
> 
> CC: Rohit Mathew <Rohit.Mathew@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v3:
> Equivalent changes to the previous patch:
>   Tags dropped due to rework
>   Fallout/simplification from adding acpi_pptt_cache_v1_full
>   Look for each cache type before incrementing level
> ---
>   drivers/acpi/pptt.c  | 62 ++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/acpi.h |  6 +++++
>   2 files changed, 68 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


