Return-Path: <linux-acpi+bounces-18713-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 110ACC449ED
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 00:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A807F1885430
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Nov 2025 23:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83120261573;
	Sun,  9 Nov 2025 23:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SRRp9Kkk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="r1uediy2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B7272602
	for <linux-acpi@vger.kernel.org>; Sun,  9 Nov 2025 23:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762730246; cv=none; b=DBDZBaqCzJEYSSPzk0Re77BRTMJn6KIaGNEaDJ+TSOBQu90dBt5bom7W7m6t0G4O+wNbsW5BQb0GKhIyZJEAIPjeEXod4Zr6HUyB8elwgNkSoDTog8dnP8SIGfpvJm+Rbke3AEZeKny9AnJuQ+y9hkdp/yOquQHntgDr6ZoKiuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762730246; c=relaxed/simple;
	bh=9HPccSaRODowbMJetF9HS+q1lefUwxe9mdTxG+/vhyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nrl+SPmYsSpd/lxxaz8vruAL9UWCfp581vROLiFrbkEB/HPMWHGOBU0R9AocVfAuuLS8x47/Buas3DrAgtVnITpZMvcjdEy+v6y3oNkBdNGrKzFJfTCh2zWYjomPvGcoUBrC7CA7zQgchclt8yQpFnG5tYbO/xfTTfNhPhCD0/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SRRp9Kkk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=r1uediy2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762730243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rSDHOW5XasPVJqQA0pLiGIBUxgDXQ6cYHB9Lnz+lgvk=;
	b=SRRp9KkkdMBcttx0I7aIGfW8n6Q/JQwQEoKCdomnleVmmVm5ZKR+YG8mcDyuuJf/YSwTsT
	yfgt+gwAAbbHr1pt5MKmm23R8lp/lyHCviAqIIn46iAKYxoREBM+z5QbrohC/NmpaURc7m
	xQCwDHsziv9fwoPWpVSzsCwuSrJfDyg=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-VyReXqGlMP6tQHjnjBnFhA-1; Sun, 09 Nov 2025 18:17:22 -0500
X-MC-Unique: VyReXqGlMP6tQHjnjBnFhA-1
X-Mimecast-MFC-AGG-ID: VyReXqGlMP6tQHjnjBnFhA_1762730241
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7af85c822c7so2466563b3a.2
        for <linux-acpi@vger.kernel.org>; Sun, 09 Nov 2025 15:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762730241; x=1763335041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rSDHOW5XasPVJqQA0pLiGIBUxgDXQ6cYHB9Lnz+lgvk=;
        b=r1uediy2qQtwLAqRsY66nmNKoJuEWGHWBuYW1+EVOFzZNAGrSxuM0ufISN9CCQzgyv
         z5zjIbfwd5qzA3gXUWSh83ll3K3e0njyG8NHPjGlmwIfmml3O+9FmS0sBDSu8MC8ZrHV
         0zVQLRAedFi8lvoS514LCaE+WIYV5j00bo+15KXKM3VjQ5TZb8NkNeK6WeM9bNud9gw5
         D98IoEfWKJfEIQhqOdUPaWnVIKA3/nDBrIO4x5p6IQz/2QJ1DmD4OyjrtnCbGbjFKe62
         joZC1b9ziZ897leMKffz4g1oGaXNAvRizi8o04NF+O1isGLc/sxpMSZ77lTPZiS1U1gW
         7QNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762730241; x=1763335041;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rSDHOW5XasPVJqQA0pLiGIBUxgDXQ6cYHB9Lnz+lgvk=;
        b=hUT7oyAZb3KB8L7Jsg/agwvHTIwjm+3ggT5MzqfSkNGxej8h5nbhTxsGnAeM707cM7
         1i7mGhXE1VsCUkA1vyB/swMnrN9UzGmnf0a0Zv3lUFHSBQBUuUqOPeU6Y0MaEZBrO4aF
         jWMxzREffRdkzt4ogI4iTn6xchE5wZieIKdBCPajvo+TT3LS5ti0Onp4YanjmQxC2D6X
         iA29EH3o813pDVnkh7Y5VwA18f7tjV8uE4QDKQBsIM1lOw8hQMiOmiEEqhDhVTuHJHk0
         2SiiqIgjEzPganwy8zgVg0ltcCEi/9kmNNixhCeWXUg5EgaMsBvZJuauK6viPJsEwuFO
         0Vgg==
X-Forwarded-Encrypted: i=1; AJvYcCUQdZP3ly+u7aBbrgvsltdXrJxYKkka362pgLkel0bjPKrWqc9GhWFm9IBVuYew/QaBjvjHYzyi/kwY@vger.kernel.org
X-Gm-Message-State: AOJu0YyabG3EdbwmanIEWAOMvuwggx/LYlpbOHhRbVwb0FJ41WrYtIft
	9sW55y7/GE9mfD02jyjNZLEiaR/dn6RZQV2ds0JWS53SADNKVLW8I9F+pXNs5rVt8bLPSyeod04
	RhnkYqnUSXNY/RaNZfXjAQF+k6Rb2VEwzdM63mOXEYJn+gd/qFE9noBcSoR/YGKw=
X-Gm-Gg: ASbGncsCJ6l/pZtIGfQ/FJLPFGQOkl+yGSjJJfqzIrqqcSEHy1EQhCiNJQZvxyMDWRa
	hZA9Dt6dy79/gyO/EFUaRiSpnDNAVQEXT1KQcnfwXm3b6TOhcx6Pdg/c6uYTi/ARKHj26MSF1/I
	yhsfgKSN5FbV9nMJmiqlp7mxYQBqDwaKxwlzHOKW8mIzrpanTT8iLlt1mRd9AQ1kJ2p339pdDJ3
	eUsYmoBU+rVgj0vqvrjwc5ROnNoP8MqzPiu5SjIdaJkZWUS5+I8JYvYCHH314GjR1FjdIRWGJQh
	m8P0Cr9oum40cWKS6A6tOKtfEVGJyDR2wZj5pwIRKRyP3WjZru7NpKy/nlLgBiGRc5crqSDtFmt
	4lSvoWennHPRv8y/E5DFLULcAyJFdT0KaWPtwPs0=
X-Received: by 2002:a05:6a00:92a5:b0:7a5:9cf5:b34c with SMTP id d2e1a72fcca58-7b22699a31bmr6235515b3a.23.1762730241539;
        Sun, 09 Nov 2025 15:17:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyJ8mJuDYzT0bH6fnz8FfZfCseiPLOpolrjUCoQmaU79/ynR3kBTkMtZAcp2qilkrB0mYBjw==
X-Received: by 2002:a05:6a00:92a5:b0:7a5:9cf5:b34c with SMTP id d2e1a72fcca58-7b22699a31bmr6235495b3a.23.1762730241214;
        Sun, 09 Nov 2025 15:17:21 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0ccc59e44sm9611875b3a.64.2025.11.09.15.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 15:17:20 -0800 (PST)
Message-ID: <06833ea2-0f9a-4429-8f29-4a41f462c0c9@redhat.com>
Date: Mon, 10 Nov 2025 09:17:07 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/33] arm_mpam: Use long MBWU counters if supported
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
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-31-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-31-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 10:34 PM, Ben Horgan wrote:
> From: Rohit Mathew <rohit.mathew@arm.com>
> 
> Now that the larger counter sizes are probed, make use of them.
> 
> Callers of mpam_msmon_read() may not know (or care!) about the different
> counter sizes. Allow them to specify mpam_feat_msmon_mbwu and have the
> driver pick the counter to use.
> 
> Only 32bit accesses to the MSC are required to be supported by the
> spec, but these registers are 64bits. The lower half may overflow
> into the higher half between two 32bit reads. To avoid this, use
> a helper that reads the top half multiple times to check for overflow.
> 
> Signed-off-by: Rohit Mathew <rohit.mathew@arm.com>
> [morse: merged multiple patches from Rohit, added explicit counter selection ]
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Cc: Peter Newman <peternewman@google.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v3:
> Peter:
> Fix type checking, use mpam_feat_msmon_mbwu_<n>counter
> Reset/configuration order of long counters
> ---
>   drivers/resctrl/mpam_devices.c | 145 ++++++++++++++++++++++++++++-----
>   1 file changed, 126 insertions(+), 19 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


