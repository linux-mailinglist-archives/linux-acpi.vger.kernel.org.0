Return-Path: <linux-acpi+bounces-18691-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF086C436EC
	for <lists+linux-acpi@lfdr.de>; Sun, 09 Nov 2025 01:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B9623B08E3
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Nov 2025 00:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80354433A6;
	Sun,  9 Nov 2025 00:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ATd926b/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SpvVnK5/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D9B26299
	for <linux-acpi@vger.kernel.org>; Sun,  9 Nov 2025 00:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762649393; cv=none; b=famBMoWHhiAVcazU0CNHQOzkeUxKQZD38Cq5WZhTpkzUrDeuKFjcpwWrbAatvBbwI2FntcsdHp0lSwqjLtlDmQEbtcMfqKR1M87iji8cQVN4MQkAuCjxsQz2JljUj8TiYCVM1cY2b/70B+ggS/+eQJa6EKaVDRhLun2ydAI3j3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762649393; c=relaxed/simple;
	bh=35h9bHGswUlmXEswFD/hqaeKimDVcRaRKynaOdnE0zI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HHTQKrOOLumf7R8cyUylWhxtLWd/ikBwqSTowM4cy2A1hTI4lctuGwaciRZTZTBQ0D37lJQHpudGBCFNR13uavYA9mAHW/xlB4Qy5XhZg5LaG1Fz2cpeXhzvNkai2WLy/lF4ppujEVrKQlN17c03Ez5IccKYyWiA0aq7PT6BWJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ATd926b/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SpvVnK5/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762649390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t2Ymb42ZiTqgosmoR22d5OXXjmr+MiE+U60sgXdVW9Y=;
	b=ATd926b/TJplmbGaPBFskB5SW67wjCCSozoFacAt3MKwRXL6Q1/Jvl+PMRSc49M0suJMDK
	AUzR0HnocsTURMfnIb+Xvl2vKe9MtiKLUcAx1Vx25RXT6+h5iRQ9vH34RF4FhfE4H7JJML
	p8sZHRgY/ubSigKnY40S1k1Ao8N6cK4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-NUh3lTAhNwyKfHXTFeIl6Q-1; Sat, 08 Nov 2025 19:49:49 -0500
X-MC-Unique: NUh3lTAhNwyKfHXTFeIl6Q-1
X-Mimecast-MFC-AGG-ID: NUh3lTAhNwyKfHXTFeIl6Q_1762649388
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3418ada9e6cso2249360a91.1
        for <linux-acpi@vger.kernel.org>; Sat, 08 Nov 2025 16:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762649388; x=1763254188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t2Ymb42ZiTqgosmoR22d5OXXjmr+MiE+U60sgXdVW9Y=;
        b=SpvVnK5/RqiXeKFgDLbwwkU7MKfCYdswxCmDsVy3/gRSepH2NBqkATqBXQf56k++j4
         I8VYB2di1EDj8QsWo3pMVHkgNyNfiR916QNaPXzMxDLsNm1tro+QRVLZqdLX3dYh6x/f
         gBbU9ut3if0sgm8ZkAlqKxN/+v6SXJQdIdTOsELEwV1xSZuoYbbk6H6NhDRmgoJBz/fR
         kpCIrO51Mky4emu0onFAgITKIlpI1jr4cRhMxR62Vh1C6gcu9TSO4P7lGauiD1XqRE9w
         dvjK6O27wEpzV2UAiMPBp8vg1w3DDkeL9v5qC9OWvHIx98xhIrdTm9RTESPclmi4zoPN
         KJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762649388; x=1763254188;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t2Ymb42ZiTqgosmoR22d5OXXjmr+MiE+U60sgXdVW9Y=;
        b=BldB4GRl+2uj47Yx9jbMMN9Wlwo8C+MVffMNbsHfbYyggTaQkKBPf0eW78OwE+6kmH
         NuhfWH+X2nS+H58WdIQC9x09SzzT0NgkSjKaFUqhhmPR2sZQURA99FSvJr1uzVKEWCUl
         VAKg46Iz5aVIQbckrJ6yGqyMvaGxKfgNV7M5Q4FoO8tvoS1iixg7/OVic8kjk0tc2eML
         3ROoV0ZCofSl9Siotq/oaYlp9Kua+mJ5fy1hlWX8SM2yEAM8XKk2C8OMqCoQcS7lEUwL
         jjTzQNVCvWwwG9vhOgzWb9vwxJ5f0VRp/8J2y4VqhzYxXGFT2b45xWX4FsI/MbG63ABq
         7MpA==
X-Forwarded-Encrypted: i=1; AJvYcCXFzl4aC+OysKLJc+yaDu1XiRaDoOPVngHD49m8cLK8yZ4hYOcDVwAFRNWtabwpjhH4GsqQhcjVF0IP@vger.kernel.org
X-Gm-Message-State: AOJu0YwgD7M9EHbwp1SnpgF6yCjISNoPEZU7Rx1ikrdhI86Xe5+rk3pA
	DtHytvjZ+aQWTcf92nrHKFK6Z1B4XrNnKvjQqg+BNqLBkUWyuTjWiLKq4X9GtTVkgAp4S0I8EK4
	HWIC4zlGMUk3hdDAzSvtfcYU3Iwf8h//M2tK76E4HTXbKztV3k2bRukzmx6ufgf8=
X-Gm-Gg: ASbGncsWWK2I2PEv3XwuPz/jiaFZQw+0cyPDw1gwjmPsQ1WDxUoFvNxRq55TvURW0oJ
	TlUqwoooFUz8f4SK3FPaZXlh8MthkjE+JS8es8ee+rY8c4q/QdVadBjSEPWOlfGGsaOIn0tyIL3
	gXzGAKlI1BPR61m4ftfNgdMRhyA71Dxfq0EdcwyEwHpRlWD5oXLRwK9f6KZHW4/G1BLvNPsW+Sd
	TjL9wPw3xgd49K2m5Ua7nSj4upcqPsrZ6jnuFDElG+GG2WNBvkY1eiHyGMX6tLqjbKWP9XBV/Iy
	+XiyS37KbYJ4TIIJTZX4gTaZC8lIfSJ7yQvqvAIEXSZZZDus0XoLvEwrtNoTeNrCT5eAftLkd2G
	vDCSzDI6IxoJHIrpi4eWNqa1vIkQlGICcDpNoPSc=
X-Received: by 2002:a17:90b:4b0e:b0:341:6dc2:b9ac with SMTP id 98e67ed59e1d1-3436cb8c701mr4940947a91.24.1762649387986;
        Sat, 08 Nov 2025 16:49:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxUd/wYJQeZzGolYs8k/2NsUqG16JqtEd2OP0c4YL/uDiW0Lj6J6MWRmIO/rzOZX+Ke6CUTw==
X-Received: by 2002:a17:90b:4b0e:b0:341:6dc2:b9ac with SMTP id 98e67ed59e1d1-3436cb8c701mr4940908a91.24.1762649387566;
        Sat, 08 Nov 2025 16:49:47 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c344838sm6476363a91.15.2025.11.08.16.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Nov 2025 16:49:46 -0800 (PST)
Message-ID: <e94b7dc4-1141-4fcf-ba8f-65d5cd0e67a7@redhat.com>
Date: Sun, 9 Nov 2025 10:49:32 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/33] arm_mpam: Add helpers for managing the locking
 around the mon_sel registers
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
 <20251107123450.664001-16-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-16-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 10:34 PM, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> The MSC MON_SEL register needs to be accessed from hardirq for the overflow
> interrupt, and when taking an IPI to access these registers on platforms
> where MSC are not accessible from every CPU. This makes an irqsave
> spinlock the obvious lock to protect these registers. On systems with SCMI
> or PCC mailboxes it must be able to sleep, meaning a mutex must be used.
> The SCMI or PCC platforms can't support an overflow interrupt, and
> can't access the registers from hardirq context.
> 
> Clearly these two can't exist for one MSC at the same time.
> 
> Add helpers for the MON_SEL locking. For now, use a irqsave spinlock and
> only support 'real' MMIO platforms.
> 
> In the future this lock will be split in two allowing SCMI/PCC platforms
> to take a mutex. Because there are contexts where the SCMI/PCC platforms
> can't make an access, mpam_mon_sel_lock() needs to be able to fail. Do
> this now, so that all the error handling on these paths is present. This
> allows the relevant paths to fail if they are needed on a platform where
> this isn't possible, instead of having to make explicit checks of the
> interface type.
> 
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v3:
> use devm_mutex_init()
> include tiying
> stray comma (Jonathan)
> ---
>   drivers/resctrl/mpam_devices.c  |  2 ++
>   drivers/resctrl/mpam_internal.h | 39 +++++++++++++++++++++++++++++++++
>   2 files changed, 41 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>



