Return-Path: <linux-acpi+bounces-18707-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DC8C44998
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 00:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 291624E107A
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Nov 2025 23:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B956522A7E9;
	Sun,  9 Nov 2025 23:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Azvuswhg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="X8rsmsWp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A5B202979
	for <linux-acpi@vger.kernel.org>; Sun,  9 Nov 2025 23:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762729291; cv=none; b=NZpRu46r0HqYriGI7gzkahmQTXAuwNXsbWPiku3ThFCC6W2a3eJo+rYFq3Et3owWCSh6yNPrhcgraGXMHhS6XEOqLng6WRNrlqFqfmw06zXKt4uaAE842pyrjKLWXeI2dSOCYYDYJJnD5AbnqFxlWT0QOecOUGnhlg6yxeLeTYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762729291; c=relaxed/simple;
	bh=1rNdMAgjQE4PmtU3Wz+uxvWLaXBXHlQhc67jVqw1EGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mcLGwnmcg0RJkaTx8xxXOBKiM0APHkCcpNLfFq36Emiln6dMseuD4CH5lY2BUhfO41hWEL6ouOela/MN04S05t0bYef2d+0e3D8sBF44G1Db3lovet4Mrb9AB6NRcrMfhsHv+RS7qDJ4yeUx5YcWiRL8rMJPeWK8CWrYSc/F9TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Azvuswhg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=X8rsmsWp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762729289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNXq3wDHifJe4Q3Rx2GNFT4RtaD6McNY3lm8qZQBNJU=;
	b=AzvuswhgG4/o95dAQIEd1TKGXVC0eHBf1hMNqr07O67VQBWuXAbcL72IFfJKEort/BbyLA
	gMep+05qp1agYOuL5tLc4uUabqizRj7ceP2aEUsEF25EOSMcJ4nG8lq+73cgu/PORlEXY3
	9WYWOCncXuvGD4x6q9TdKYqPI9APw0g=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-aZY_HbYxPDu7mxkeQYcqKA-1; Sun, 09 Nov 2025 18:01:27 -0500
X-MC-Unique: aZY_HbYxPDu7mxkeQYcqKA-1
X-Mimecast-MFC-AGG-ID: aZY_HbYxPDu7mxkeQYcqKA_1762729287
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2956cdcdc17so29564375ad.3
        for <linux-acpi@vger.kernel.org>; Sun, 09 Nov 2025 15:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762729287; x=1763334087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZNXq3wDHifJe4Q3Rx2GNFT4RtaD6McNY3lm8qZQBNJU=;
        b=X8rsmsWpIujK1qW0g9BhTMkXS5TOfR432xcJl+QHlAxZVsaMs4F46wHmeg00/sm39k
         ZE+T1ufWUGDVJIFZcvt6JZl6g6YXpUQFcUW/i2uhro0JLUTtBeYGmItXAyslJKNOEJYH
         xq3HjNfqSg0qqCR7Ld+Q7Zfvjuip9kEtjjuduznlsD5VBNqRkDX0oB8JkTwPfcgC+Lo6
         UagZgT78/Xs7x/dZ+DjK4PbUNixajoV6AjrPfqrkmYSBBsB3nRIiLUF5m/3vbxYoYDml
         496qdGL+2aymCfljhox46uPvRm2BDLgXMz56xtaDrPMILW/MOwlKA6FjXMfc2DB0vr7P
         fi+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762729287; x=1763334087;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZNXq3wDHifJe4Q3Rx2GNFT4RtaD6McNY3lm8qZQBNJU=;
        b=bLyeJO+byQ9R//ZgodrbjtBqEWVrgQAL1o+Bb0nGD1hx9vH8fY/s0yInOfTslzhh3v
         cGBLlm2Ty4CWM+Ywb0C4P6qlRk+amy9wiIhJ7AnnAgpmm4a6Q6CpRHtntt/kUC7vo+G2
         dpQBbaaxv8pZxJXHyzrdD8qzD0ryDUAD/yylYuGHz5L9U/NHo3YET40gVoRbrzSmRMcQ
         bsvFkgSLJ3U76sXF6icVTG6TVz8/iotEu3GyQv3fuesTm+s3+xZUlTVQ+9ulKYYcj8/m
         5V4HwgUWMbjA9vnwjvJy7kAoq3Ii4TsPi4McoWAS7vJxJ9PYVbMM6xu0YUBm3PY7YArT
         MeFg==
X-Forwarded-Encrypted: i=1; AJvYcCWv05DH+gVTJEedPqc0bkhyFdjVPerSoRk7+fffWF9Jwt4miwp+SQfoIWQuNm9vExhkHYL1f0t5ylQ1@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm1TGf1mDRlu9TkF3/q+jPp5Lo15SHn5qAwmCSgwtRyoItB9VH
	Z4XCnd8/9iT4XpMczTxsVWCb9ErLcro5iXIcoE2EaUznsbKV98/VT6op5CNE16k+oNznoGx8s1n
	pNDLo/P2CieBz/tOYYxDy4IrFT41alPwU1mw4g2H/SozoLOH1AN2SDweCu0bqXHE=
X-Gm-Gg: ASbGncuIhxJiWlFWC2EE4Wyfwaeq5tpIU5eRc99ZSc8pIDaaU5MnvSrSmGJ0VAR2r9e
	LI4n1R5Q5Kg2jONg7833Y2rj1V5xlk3hCuqPglDnarScOvt+19o+yRtWlzYBaOxXM8lk9ClOwUL
	npkTPZLT0y7XVoasWOk5/c9H2Pbe/wHr+Lt9GoIdCtF/roomH9mKMCfQS5g643DgaS93nWnsxJt
	jhFMWQmosBqvwh78Tp/cbeKTFtX+nrSemoVSIFWqBiRdnt0n66ifDzSFnqn8M81GDp9j47WI2ea
	d0b9gWGyQHgnB4ERgS5YER4ZlbMT66HAnMOQK2jDmnt2rKlEZMdZCCeisRYMxvTIVrm7s9A5ULE
	DfqEN0TBNMr2zHq8Qy19BBtV0H3wP1avJ0+77ahM=
X-Received: by 2002:a17:902:d485:b0:295:28a4:f0b7 with SMTP id d9443c01a7336-297e571abdcmr84706415ad.60.1762729286670;
        Sun, 09 Nov 2025 15:01:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH20FeHF0gFMlacoNiycg6+34EAdYTYpIb2C+WuBML627rkfNSdBeqyaZRt/itc5uhGL0htSQ==
X-Received: by 2002:a17:902:d485:b0:295:28a4:f0b7 with SMTP id d9443c01a7336-297e571abdcmr84706025ad.60.1762729286232;
        Sun, 09 Nov 2025 15:01:26 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c740b5sm125699615ad.70.2025.11.09.15.01.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 15:01:25 -0800 (PST)
Message-ID: <9c744ab8-d555-4202-905f-015a13c377da@redhat.com>
Date: Mon, 10 Nov 2025 09:01:12 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/33] arm_mpam: Probe and reset the rest of the features
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
 Zeng Heng <zengheng4@huawei.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-25-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-25-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 10:34 PM, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> MPAM supports more features than are going to be exposed to resctrl.
> For partid other than 0, the reset values of these controls isn't
> known.
> 
> Discover the rest of the features so they can be reset to avoid any
> side effects when resctrl is in use.
> 
> PARTID narrowing allows MSC/RIS to support less configuration space than
> is usable. If this feature is found on a class of device we are likely
> to use, then reduce the partid_max to make it usable. This allows us
> to map a PARTID to itself.
> 
> CC: Rohit Mathew <Rohit.Mathew@arm.com>
> CC: Zeng Heng <zengheng4@huawei.com>
> CC: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v3:
> enum order and commas
> ---
>   drivers/resctrl/mpam_devices.c  | 188 ++++++++++++++++++++++++++++++++
>   drivers/resctrl/mpam_internal.h |  18 +++
>   2 files changed, 206 insertions(+)
> 
Reviewed-by: Gavin Shan <gshan@redhat.com>


