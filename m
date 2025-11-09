Return-Path: <linux-acpi+bounces-18701-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F4AC448BA
	for <lists+linux-acpi@lfdr.de>; Sun, 09 Nov 2025 23:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DEEA1883895
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Nov 2025 22:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F02323C4E9;
	Sun,  9 Nov 2025 22:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3y9m4tb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8/MTURF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B94822652D
	for <linux-acpi@vger.kernel.org>; Sun,  9 Nov 2025 22:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762726307; cv=none; b=Plqmim3AgVQPnkC0v1xRVbCJwOK4ooNpD2Uw5n0g9vgsJhIepETB5mNtxrNVcRPL6USxHlgjKDZzoTjhZuVHwTm3bdDFlC4SNDemSa24NVRD56KYYb/xCrmtLTzMo9cxNdOardAsbs2xCXOCKV2v+kASI5nTWxNN59nw8Kc34i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762726307; c=relaxed/simple;
	bh=EhAKRO7WMDbjstmS/+6wn2u687jYKO5Z31A7AViGYek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4Im1GueGtjHw0SxE8g26t1UuxM5hrnC6JoV5ZLKv99l4vd3Fad8prQtbretIi2BoqzkVelshmLliA4vYPwlrosWi9b4NgiLlPLy3SLbdkySf0VR6ZmxPUvGmS0U6B6Kq4pRbA4KvMHRxy5cG17Z9hdSvwTBbNycEc/CPPdLR0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H3y9m4tb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=T8/MTURF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762726304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=torA9iD+O5YccAO+gDgO+OReSyG8Lrsf/jD8r76xtZI=;
	b=H3y9m4tboWoN6il60IqgvrfxB0vmJTtOyiSwVxPGrzQLbQCb5pHYKTGZnLcAb+UREHql7z
	E5E9Fy4tvbBY+yfdXWCaXMSRz6OffnVQA+2GVnl9XrZRN3nGXxGhclaa2NQ86EJFqgSlqE
	AI5T+7tXHt9ohUfVlefoSUFCGZEtR6A=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-8nMaaDfuNce3vmHp2NkAYA-1; Sun, 09 Nov 2025 17:11:43 -0500
X-MC-Unique: 8nMaaDfuNce3vmHp2NkAYA-1
X-Mimecast-MFC-AGG-ID: 8nMaaDfuNce3vmHp2NkAYA_1762726302
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3407734d98bso3022457a91.3
        for <linux-acpi@vger.kernel.org>; Sun, 09 Nov 2025 14:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762726302; x=1763331102; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=torA9iD+O5YccAO+gDgO+OReSyG8Lrsf/jD8r76xtZI=;
        b=T8/MTURFE8+I91YBXFIZft6kqCdFWRbqjPxQVa+0grGvSn2KJZoLfD++oF9ZWlOT4Y
         zxdh5MarVOPONf15MagbeUdPdqqSPqm7qY9xwQQMhv7lFAzBA/xUqdvcVV3cjmLwtU7Y
         ZRLIYVMeCxaK5BJi3N4r13ZgJDMoyFuo/o5LmRr73WkvPj4oXrkj7tQv+SptVMm5LFLD
         hqK/0x1Z/mZCcmfw3b5+QNfJOKlJWegHgKgSS03sIq0mskQ3ULw+K+9w2bdiq6kZtso3
         GOanm7QXFRbjSolvcin6tfLL+kmoBbycTWzSsK/Vi4+/yZrpM2Mo49spYosgr9fg6zMx
         IA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762726302; x=1763331102;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=torA9iD+O5YccAO+gDgO+OReSyG8Lrsf/jD8r76xtZI=;
        b=hgH9oTHLjkfTsVqQrHKByP60EDxRXQZmMhB8hRU0ACTh+wo94IF8MdCEdqtXjAlZeM
         GKtfow4C81coi34kt5b7E2n/Eadygrr6v0GM61MJjv4t8KAEbRR5m6hGMikg4H0CHSm0
         C0QX4lsbOyhaOuls1q9W6Y41JE4qJ5cqGfjrCXQc0iqKUar1RtpAVznyM11iYtfaEQox
         5qRWJ3srA7o9NSLYBlYBlkdiwM460EDsLS/PW1Gqf281SYPcyQQTbdAa8VyJFkvYkrTn
         InP3ZUtn0NMuTlpYJE+bozS7zslZgSWqUuMu2pH1vL4ODhNfy2QxAL+cV70YofOfA1XI
         neTA==
X-Forwarded-Encrypted: i=1; AJvYcCW6wQ8Ol9dPHTkbBdAWz5kHD5sNhQb43noJW9z6mkaK1SjmMhDzIqBBpx60a/T4dmTrVdSAEOuC3J7z@vger.kernel.org
X-Gm-Message-State: AOJu0YyOdC90MsqflqOa9a2e1lBDV+SqCcb0i6SS3180jIG/X5pJHR6S
	IDvwnlWqWCFE7EiN8NCNy5/PS0OpAhZbXEGw0gzAYyPKTg9auDtV8/sVj2JYb02savsa6Ybxt/E
	Z43VnVtFLPvdDsrYQWXoznPjarzwR33aFMZBzgIaISFstV4t83eKBAiJoEvIvsWc=
X-Gm-Gg: ASbGncuWywQm1XgbB4V1YDY3QVk+0VY31raWQXW0V2HcklUgYOnhCrOqvdbTTN6AMZw
	ADEvZEQdSkClFYYLXM6MSp77V4SM54NxZInA1CmPNcrRkijq1KhFxh3uHvWTkblXWsVqRH0duAr
	AkpSk0WIjIzfLNe9NwWVcmOsdpe6wKrH38x//RIfNk3b2LYfZxtP0VhHM/qaOiMDwucsC50Pfj9
	W0OlS6N6vQ/otYUiHMUJQ9FjGfFLSshpcUjmf/b6tmpu6zYqwpbXWMYQfdwzr3xHSz0CjVD8aJY
	D/EiXMVNKvt68FPCECFwM4dM75Y9EJBGzy69aC9aSS3uk28DvX3ojyQczCvpYG7eW/hikksPDUg
	gtRmYA/2GvdYv3GsMMMJQ7yqi9Ek3640R6U07xbQ=
X-Received: by 2002:a17:90b:3811:b0:330:7ff5:2c58 with SMTP id 98e67ed59e1d1-3436cb7a977mr8352230a91.7.1762726302244;
        Sun, 09 Nov 2025 14:11:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkgqRagTj1BsYFqTTiIN11rDYYz+ULLJjYUpCoKdSxULvZJZQzp6ZykLD3a8LycOtC3JeYVA==
X-Received: by 2002:a17:90b:3811:b0:330:7ff5:2c58 with SMTP id 98e67ed59e1d1-3436cb7a977mr8352208a91.7.1762726301879;
        Sun, 09 Nov 2025 14:11:41 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3436c3d7dddsm5430819a91.7.2025.11.09.14.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 14:11:41 -0800 (PST)
Message-ID: <a4ee3610-5a5a-494c-b994-28447535f25c@redhat.com>
Date: Mon, 10 Nov 2025 08:11:28 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/33] arm_mpam: Reset MSC controls from cpuhp callbacks
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
 <20251107123450.664001-19-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-19-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 10:34 PM, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> When a CPU comes online, it may bring a newly accessible MSC with
> it. Only the default partid has its value reset by hardware, and
> even then the MSC might not have been reset since its config was
> previously dirtied. e.g. Kexec.
> 
> Any in-use partid must have its configuration restored, or reset.
> In-use partids may be held in caches and evicted later.
> 
> MSC are also reset when CPUs are taken offline to cover cases where
> firmware doesn't reset the MSC over reboot using UEFI, or kexec
> where there is no firmware involvement.
> 
> If the configuration for a RIS has not been touched since it was
> brought online, it does not need resetting again.
> 
> To reset, write the maximum values for all discovered controls.
> 
> CC: Rohit Mathew <Rohit.Mathew@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v3:
> Add tags - thanks!
> ---
>   drivers/resctrl/mpam_devices.c  | 109 ++++++++++++++++++++++++++++++++
>   drivers/resctrl/mpam_internal.h |   3 +
>   2 files changed, 112 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>




