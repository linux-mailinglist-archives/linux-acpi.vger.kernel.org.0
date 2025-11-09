Return-Path: <linux-acpi+bounces-18710-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A0DC449DA
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 00:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFAB7188B5DC
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Nov 2025 23:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3ED1891AB;
	Sun,  9 Nov 2025 23:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LbR65z6P";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GVf2eynK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0325A1E0083
	for <linux-acpi@vger.kernel.org>; Sun,  9 Nov 2025 23:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762730172; cv=none; b=tXmeC5My9gkZ450krx46wjP+H6GS+Lfz+jVeu8kw5bxeFAcJvOpCfdZEgM2/+yAEjfSpCWu39VhMKDI6UQH571uLvn+mSa+taaEcpeiNfa5njCUr/1CRR65zxv8xbWEHX94FnYpK1bcv3M3oeuYcDdTlLI4keEzw45l8VAr+LwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762730172; c=relaxed/simple;
	bh=LjcUFAc39TJn1U6bwkbkQQ6rbkMkbQsQNrXVyvLDfAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mJ3czwWVoZbyMRZ2CeDUkbvWKGkKjFDxy8kzTyPPlkMszLdXKJkhexMpQiMdZpv5L7GcpDaGIxi6fbM+NUC7jueptnZEKUkSwjzIqTEjlU0rLXMO8gXgLxn1D0Jot/NaNO92jX/x1YAFLQBncxJ6bD4cPbx3T3OpHtiSCMF+IvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LbR65z6P; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GVf2eynK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762730170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MDUv6je7Ohicz+smtRuBl6ZpYqiHtX0g/yyL+aPKMxc=;
	b=LbR65z6PKSl6IcCCe3OhDR8ROx9oiqKVw+GU/KIvWgCBclzUE13Xy6PE1tyYL4fc0YvR7w
	bqatD2ZgbHuTPqgeoZ8SZ51aOOI6ZVhvahruEuySVCXWl4FCihFH3uBAYPNkVAx9EQH31o
	F2GLFIregmd3oHZgyb8p+++W8eWcfHo=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-AIiBJehBOG6qSxnW8hdK1g-1; Sun, 09 Nov 2025 18:16:08 -0500
X-MC-Unique: AIiBJehBOG6qSxnW8hdK1g-1
X-Mimecast-MFC-AGG-ID: AIiBJehBOG6qSxnW8hdK1g_1762730168
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-295595cd102so64055525ad.3
        for <linux-acpi@vger.kernel.org>; Sun, 09 Nov 2025 15:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762730168; x=1763334968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MDUv6je7Ohicz+smtRuBl6ZpYqiHtX0g/yyL+aPKMxc=;
        b=GVf2eynKRoDNUL0uaTP3h1Sq9txbdks0i9iUrg3rJovZVuHJFh35DmXbQUyufivSgb
         AZLPPOt0aahR7Gj4u84DLGtL8OQAY/dfTZd4BBwEvidLW91mORMQteD1gvIOJiC+1dRt
         /7X+B5F6XAJHCtjH3ewjYTyaXfNG4TevwyQz/u7pUVnX6oT8LGYK3uzEqi8kanyAW0KZ
         9b4e8rutgNu4HV4ikLIPX+kzQSz5lf+seeef4k2g0li5zdfT3EBwv+LdRvDTMbjP2jR/
         A9cTUwx+WnsMJNB/TBcZFgJoDVIqCc/YNhPH/t51s51XVbbAeS9bZiMy6llY35otbXej
         bDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762730168; x=1763334968;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MDUv6je7Ohicz+smtRuBl6ZpYqiHtX0g/yyL+aPKMxc=;
        b=epPgi57PR88HTXu3ADC1LJo1ig7OKpb+4Qp2fCjcUK+Ep3WzVqkoxTRU2zCoNZnMYQ
         FTtvWaV2QmpFDj1aeGs4wJDp0mdE7TQTWhz3sf5JAXayU84wmW+J72sSTMOUSJyUmnGQ
         JkZGaS2uexZk2qwuZfYGLhyZ30OGhMV2hs27UQrduKJlC8ksCzhS/nmbn7Kh80qVbzQW
         VfCWIFPffweGjO/OLMeB6ltWgOqN3rUaFfCe0ZEtOXs1BaTCmE5frt5u+R7aQ81S6Nqf
         CRVIIKqQsjqaA4zdKHnWEBgudmAOOvS6ZEWaFFHv9tkEAzWloUMvEduycnJNHSYNJhHf
         2lOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwYTqbParvTdZVNBttIDb7CB7dQ1Q3J4g/lwGYseWmURE1DYTyY2a8eqBcz37G1Zk8iWfAQYB5zc1K@vger.kernel.org
X-Gm-Message-State: AOJu0YydDefA2lsjNxheugZIwFEtCvu1QYaZAxvxQ+g0GqW5QMeHiGmG
	iMT4mWhAtvUMPTTwf2h80f86YL5kyuoo/qcL6T8kBp3RnEN82ADLwSNZXxDbRGfjPs7q/uzpdVS
	wxMDjrKxXfh+tNjApYfwknqTBy61UsK2aa4rmn4Za9+PY8wmS3fFkHlPtvsOqEO8=
X-Gm-Gg: ASbGnctQ5cej4jQqqjd6HidLQc+Y71776PlWds9HND7TTQiptG4zncj4HouScQZhZrk
	UBAaL8vnfgJRQMW6A7JDPWbystUujt5LiozdYiwNS3Qxm8YWPJ3wniM67Bf39Nyl4hjxeNGdGBX
	9qiwnQH6AeVgQqP5bzM82wLvwNi1T6IAIwR/I4LO6cKDIiXkh13MVw1yprpyCzRxNPLf4jxPPpz
	7P6+JL7MrWYTdP2jrPlArYqNgmrPHaPGCDG8StLo/8n3cqak+kxXGVW8YY0ICyIRtHekIv8oSYf
	PoTLZqPWetMUcg+pUhp9Z9Q+UbJr0f24jcKDEFa9fj8cv8quwXC3xj8PhwiP3zOi5Wk+2Zxnq/D
	oRj7g2bqcEmy4n5FSlgKaX5TsuOrSQ5s9FzPnJSA=
X-Received: by 2002:a17:902:c952:b0:295:21ac:352b with SMTP id d9443c01a7336-297e560ec1cmr78399515ad.15.1762730167690;
        Sun, 09 Nov 2025 15:16:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGKFONVz/PdrHijdKUAMC7ZFvcfTvFflkxdMQ1OwyAkmY8Q3jbTVUYQNkRAQk/zZ/9eJe8Fg==
X-Received: by 2002:a17:902:c952:b0:295:21ac:352b with SMTP id d9443c01a7336-297e560ec1cmr78399125ad.15.1762730167302;
        Sun, 09 Nov 2025 15:16:07 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ccec04sm123053925ad.102.2025.11.09.15.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 15:16:06 -0800 (PST)
Message-ID: <6f36dcda-ec5c-46f2-9e22-7e4334cc554b@redhat.com>
Date: Mon, 10 Nov 2025 09:15:53 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/33] arm_mpam: Track bandwidth counter state for power
 management
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
 Zeng Heng <zengheng4@huawei.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-28-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-28-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 10:34 PM, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> Bandwidth counters need to run continuously to correctly reflect the
> bandwidth.
> 
> Save the counter state when the hardware is reset due to CPU hotplug.
> Add struct mbwu_state to track the bandwidth counter. Support for
> tracking overflow with the same structure will be added in a
> subsequent commit.
> 
> Cc: Zeng Heng <zengheng4@huawei.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v3:
> Drop tags
> Fix correction accounting
> Split out overflow checking
> ---
>   drivers/resctrl/mpam_devices.c  | 126 +++++++++++++++++++++++++++++++-
>   drivers/resctrl/mpam_internal.h |  21 +++++-
>   2 files changed, 145 insertions(+), 2 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


