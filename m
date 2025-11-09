Return-Path: <linux-acpi+bounces-18705-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BA6C448FA
	for <lists+linux-acpi@lfdr.de>; Sun, 09 Nov 2025 23:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA2801887297
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Nov 2025 22:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55E0263F5F;
	Sun,  9 Nov 2025 22:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QjfgvLd6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+PDUrU9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B2123D28B
	for <linux-acpi@vger.kernel.org>; Sun,  9 Nov 2025 22:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762726832; cv=none; b=HCj9nbuOxTSJE2Rs7dHuA29j+AqjdjmUIa2KvLq3xf9B52AQ9+ZF21DPbgK2Uw0+TPat0w7D6GGTQYtTTB0Sho+hcVnnn/uFEpdSdRMaEQyItNu+7OVJHvPVsH/btV1gKLUDs9lVTaSgUzEe1X6gHB3GRziMXnRNYLJL6hFZInI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762726832; c=relaxed/simple;
	bh=9luPoLzeiDoXjZ1ghvRixZ9O4UWqQdIzzwf5oTAyncI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUjNAl7rW1DuUUQbPwzND1a0jIOVbXWMk40a10f9M0O61P4DcuwfwXHstd/cypX/J+bmTpc7MI9zHdRtl+y/mgpoeyZE+eVSsH3Pte+lGC82gZAvv5uz2fENwLEibymsi9Um3JJuuq6wncOW+HoblNDQhn8mMf3phYkQcw1izEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QjfgvLd6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=P+PDUrU9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762726830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z9Vrh4hLm6Gal4VfKPd/BvcKzpt3wbNXvBBiFNbMLpY=;
	b=QjfgvLd672QWUWqDpV2bHwa6+jHSUIYZ1Zt2AWp/yEMdHXFrOY9EuBXpwH9J0uFEcEfNJQ
	3cxiGnvkSxwFDJW7IFafVyQX5cgKpUB91q7NsX5osi/SuQnQdZp0AEM1PBeQSlVCh9grPL
	7P2Tmya0kmp+3aUr5qYJmfJ+aezB3gI=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-Lidy5uNaPaasZM86UiHakw-1; Sun, 09 Nov 2025 17:20:28 -0500
X-MC-Unique: Lidy5uNaPaasZM86UiHakw-1
X-Mimecast-MFC-AGG-ID: Lidy5uNaPaasZM86UiHakw_1762726828
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b6ceeea4addso2156681a12.1
        for <linux-acpi@vger.kernel.org>; Sun, 09 Nov 2025 14:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762726827; x=1763331627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z9Vrh4hLm6Gal4VfKPd/BvcKzpt3wbNXvBBiFNbMLpY=;
        b=P+PDUrU9oqsaTb0jWZjyVemEm9K4cJGex8JFYXM1v0Q0CZ37rrGYUU9A2cEObRiKoE
         GnCwg28TEVUtFjTrL1mW9bAIGBW/JQYnnu2NAiZPV8yTJDKZdgGLA8zTmIWQMAvAdlfX
         hF23sXUrvDG1wAQRDbOIwpgvGiw5maQMyH702TP2ifz88H6o+ilIqErcNC/ZWvuj5B1A
         jTWVFGoi+RL6c4BLm4RkeAA+5RBCTMZnTvNZfG6qf47m1e2JVH9Ljrm/VPu67GqH4O0R
         dKEdoSJ+d9rKN4/LLJDxGv6qMlhKVdSaIGvEQ9zM2wpYvYwDhOD4kzkWV+2ko3BYjbN2
         QfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762726827; x=1763331627;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9Vrh4hLm6Gal4VfKPd/BvcKzpt3wbNXvBBiFNbMLpY=;
        b=uSmzNbSJI5C/OebJmAfZ4z0AmvSGWNsREuzL1wW+7dDWSAufP4hqOUmV5OmNLRbo8x
         Dr0D7m+RHa1GihQTDVB7U3vQ31T6zDsfUY0ka8SpU1x0gcq3CP9f5CmhHEyDpAfS5RSG
         vHLkJ5YFbXvkeJXsgIwbwb7VmYmcbXvENiE2yETAVRTvn2aHVuUbKaSXLuQiCsMzYXHT
         PBlWIT2pE6PZSDp3RcIvN9vqJ+o7ibVWWhQX1J8ZJ0eApBVmko1DKcNORcweyoucBXZa
         Ef5p2szRZejYXU8+1zn9X27Xw8sTDG2t75znmwwZc+JNV37Q1cpvlIEHBpPLq8Dp7u48
         E/xA==
X-Forwarded-Encrypted: i=1; AJvYcCX2ZwS9+M8qBgcsrs3g7doJuw+ATf5cltlILRx97PSqoNFpYg6uMdmlEL0FP9liunLt66fgQ+PYIe1c@vger.kernel.org
X-Gm-Message-State: AOJu0YyCIY3uD0ejlfTKJMHuA3h5TdRbWprcpXbSEAKr0q+f4dOfB8D0
	u9ACegaP1pL0emoNJkjAeiY+ex5BkHBRlYrr/5LPKythzGX/wkM7t5qD1AwiVUvO2nINtzSjQLa
	V1M7TIJhJnPbktdsFyEfcawuBPiCjee4ogI1hu144WbKDNE3yCGqdpj4xf1J+IuQ=
X-Gm-Gg: ASbGnct32soQXvx9t93E5ZTlAyqVVa99ZSK9ChAXjAtRUsulYqVkmNtvYd6fG5gddcO
	qVhVWHzBs04WEghAASDa5617giCnhIAJ1x4gEJbPJeW1ofD9vG5ZdMgAvXOPdUdyb7HtAEmikrP
	yCCwMglYeZtFgPmf5V9YP/0pdlp4itr3io6fZ6ZlCRDjQnvS2TlPJEuKmexbGBqd1+q7UBUmHEx
	LGTXnPX2a/oG0PpV37hcp32qNta8uRXvgqdrPf5uzEV7uT99F2dMJNKjGr/85QtAU3oY8bBzMSQ
	HlQZXByA/en2ecvRzJGu7x0AlsOsItoRhzOCMhjuW+p6XIkve1bCoa/3IcnQPqVsCt4VZG0F2Rq
	UV3AYpLlfNVjf5f1qdTRfZSEtuKdp+iIcdGRIfnE=
X-Received: by 2002:a17:902:e5cb:b0:295:b7a3:30e6 with SMTP id d9443c01a7336-297e562871cmr79572435ad.18.1762726827624;
        Sun, 09 Nov 2025 14:20:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwTISJ2La5PhmrXo8AgSy/Yt85FoIYmCW5lG5+yT/l4xv4t8A7YS357AfTy+jnJLHP7TlYiQ==
X-Received: by 2002:a17:902:e5cb:b0:295:b7a3:30e6 with SMTP id d9443c01a7336-297e562871cmr79571975ad.18.1762726827220;
        Sun, 09 Nov 2025 14:20:27 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096b90asm121886565ad.23.2025.11.09.14.20.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 14:20:25 -0800 (PST)
Message-ID: <0d3b5565-4f38-4af5-80b6-66d230b68edc@redhat.com>
Date: Mon, 10 Nov 2025 08:20:12 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/33] arm_mpam: Use a static key to indicate when mpam is
 enabled
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
 <20251107123450.664001-23-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-23-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 10:34 PM, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> Once all the MSC have been probed, the system wide usable number of
> PARTID is known and the configuration arrays can be allocated.
> 
> After this point, checking all the MSC have been probed is pointless,
> and the cpuhp callbacks should restore the configuration, instead of
> just resetting the MSC.
> 
> Add a static key to enable this behaviour. This will also allow MPAM
> to be disabled in response to an error, and the architecture code to
> enable/disable the context switch of the MPAM system registers.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
>   drivers/resctrl/mpam_devices.c  | 12 ++++++++++++
>   drivers/resctrl/mpam_internal.h |  8 ++++++++
>   2 files changed, 20 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


