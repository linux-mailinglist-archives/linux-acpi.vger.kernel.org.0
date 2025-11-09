Return-Path: <linux-acpi+bounces-18708-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFA4C449A7
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 00:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84A144E2F12
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Nov 2025 23:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E34C26ED2B;
	Sun,  9 Nov 2025 23:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XQwpWnDT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hI6N6PBY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DD6202979
	for <linux-acpi@vger.kernel.org>; Sun,  9 Nov 2025 23:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762729382; cv=none; b=G/NqKfkcGAzNwKtD27yaF075kpZ3qPtV2gqboTj+8iHjBt4Qm3PJ0pxkK9ZxovbATJ7+x2obR1EiKhtiyF8WHb1kd2U9uN4uL2AB4w7WNekQeSGoSZUIh0WdsewORaYBoZZCSI4OZCJJMxQxlf1Tl/2SLzoQNHQlZZUCceuOMGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762729382; c=relaxed/simple;
	bh=z8RZX8MXVeuszcAyx1k8iyhD9JjN0WdDm17h8P1J9Kc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ls6al4uKNQqgkSr2TfgsKKa0+fFafcTRzI3C2Z+lLmeACLG+1n37xw4OhWCh+lmVGhDWgKhDqNnaj51HD2H08u9p90Vn5sdHonZzGSPWYU74GZpyf5+j+ukf+tlCr63Lzf6md3jEfWzmfNjk4f0MAymlPKYOtPgFgvpUbhuw65E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XQwpWnDT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hI6N6PBY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762729379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NMwEg9W7YqoZw+J9iFMlmgMaSrnfv/cmFgFC+MG09ew=;
	b=XQwpWnDTzQFVXdc7YWaA1vtgHNBm0p/PxoSwPhSpX5YbzZoNlfcu48wK1e/hxcbn2OH3g6
	NzbBURiEayjjX0X3O9eqaIAfiSe55x3wiPk+4m359E1Gqq1F0pS4PoiwzQCYQU8QXlaiEE
	EpUk6KTVmlX+qjN1gG8NKrz1+eXk1ic=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-Zheo1NS3MnOEKq5gPK72-g-1; Sun, 09 Nov 2025 18:02:58 -0500
X-MC-Unique: Zheo1NS3MnOEKq5gPK72-g-1
X-Mimecast-MFC-AGG-ID: Zheo1NS3MnOEKq5gPK72-g_1762729376
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-78108268ea3so2143566b3a.1
        for <linux-acpi@vger.kernel.org>; Sun, 09 Nov 2025 15:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762729376; x=1763334176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NMwEg9W7YqoZw+J9iFMlmgMaSrnfv/cmFgFC+MG09ew=;
        b=hI6N6PBYwL3xVi4UJ2surCfNpzucI93EXi2nyNDzj/j5UsJY8CeDkLbZcuivLJtR0s
         nuLW23QNm49iNJUMuym665dDfJnDrmk4FCG0tXooCVcOHVDd088ryITw7OmMwlJMnth0
         iT3M5PFVkvvy3AqsRDv4V1eYNff6/nE5DEyn0H4gA3sRNjzewduPUmZNjnuOWNoxqdkt
         pv5MZANxQXjoZPkM0wkUekh+zqgyy+2xOND0MoWL8buGffIWL5Huu2kRi+/FrHt6S6hZ
         u+BaxB4JnFJA6/eKFts+JthAPBe5vlGfkUAQeVm82jv75gz72GPv9e5u1SpF7Yh267i8
         oJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762729376; x=1763334176;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NMwEg9W7YqoZw+J9iFMlmgMaSrnfv/cmFgFC+MG09ew=;
        b=Ufg9teguJkWvfZF7Wvhln9ZXpEe4XwnTk53Y7IwfI70cLabQsG+Uo2lI3h0WZqQ3f6
         DWfdXdPT94FijLwmqLrAbb5HGSoK2P+CoC1UuadkdwduxwJ+31UhO3Y8KwrXaoBfenW1
         gfGRUjjEIOZkz6DXbuCRmWZq8fizw1O30sCiq1IAyG++o7Gddg0sXooRhkEt0w3Uit+n
         eoZPI6L7tlE8pLPKJ7FNKbH3uYtZI63fTcY8rI9dolQjopb3kOyT78NTUHX0rIM5RXqg
         rmSbqZ9O+KDikWsRHyOnxZsqSLzJ3d4pev37dvBNLpEUBYnrrA0EUiHH5E6Uu1d2gBGK
         pQeg==
X-Forwarded-Encrypted: i=1; AJvYcCUNyJ5nHo8Zc/FV0Olj4EnS3RZ/SbpuiJu9hA58juf43WKpYLIbTnZlzaf+CbMCr/tIUQC5fs6SuprN@vger.kernel.org
X-Gm-Message-State: AOJu0YyFZ9uf2DtcgrZdN2bTIQmijSyIPJT3E+jxQ8+JaNyVPkyPB9EI
	jNbO0P0PrOd161Cx87ejDLWZohiYS8sSUIvSHiGRp/6qWZMNIaUxYh1TsPWQq0G7/bnO8kyzBVx
	GkQEx3DXbSMz+YCW2RG6Bwx4u3Dgjh2E+mHL6tEgWnvR8X77S6m868b8F0gt0MFY=
X-Gm-Gg: ASbGncuBpSEYNDgB5TSxUntkc+AwNIjaOJHQ5oYHrYoJPwz7+0GmY92uFx0HdkJ2BpH
	BSPSkbqImM1y2bP54hQWhCD0VO2j35NiSKhj+8QYP5MICvG4r6/CFgdPts8D9R2rI6IrYxVmolz
	hIbftirMILnEODNelLuZ5FHJryklV0t6nuga/esM+GSbCeSKEwdB72eH5PtC4NFO7Br2jUg8mFg
	Fv6dAhwzEqH3X3pjAotWLBWArndbBx/OZirelCUmptJKoXAQdCTiEejUhv+goi+ntUpoSS9YVCu
	bls+0FJ2RMBxbc128oCNJ84EUD+KdEY8BO2tPQ+VfNM/j0vPneKnBbmHoNGCW0BgrENdslj2+OB
	CBPCZnJ8ull4fnZIzHo0b4K1ZG1zFSm2wlWv5PRg=
X-Received: by 2002:a05:6a20:7fa7:b0:342:fa5:8b20 with SMTP id adf61e73a8af0-3538bc22aa9mr8426681637.30.1762729376392;
        Sun, 09 Nov 2025 15:02:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGp7sab9vPtmKVuWXAe17LWaZN9aEJbpEu9mpXkKjVJgK+RBmFSSONqLnlckjEp75q+9i7CjA==
X-Received: by 2002:a05:6a20:7fa7:b0:342:fa5:8b20 with SMTP id adf61e73a8af0-3538bc22aa9mr8426642637.30.1762729375982;
        Sun, 09 Nov 2025 15:02:55 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c953e2a4sm9725756b3a.6.2025.11.09.15.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 15:02:55 -0800 (PST)
Message-ID: <bf04a6a4-7fac-4186-b26b-558151783b2e@redhat.com>
Date: Mon, 10 Nov 2025 09:02:42 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/33] arm_mpam: Add helpers to allocate monitors
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
 <20251107123450.664001-26-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-26-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 10:34 PM, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> MPAM's MSC support a number of monitors, each of which supports
> bandwidth counters, or cache-storage-utilisation counters. To use
> a counter, a monitor needs to be configured. Add helpers to allocate
> and free CSU or MBWU monitors.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
>   drivers/resctrl/mpam_devices.c  |  2 ++
>   drivers/resctrl/mpam_internal.h | 35 +++++++++++++++++++++++++++++++++
>   2 files changed, 37 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


