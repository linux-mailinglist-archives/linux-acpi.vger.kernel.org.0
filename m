Return-Path: <linux-acpi+bounces-18699-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (unknown [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC4CC4488C
	for <lists+linux-acpi@lfdr.de>; Sun, 09 Nov 2025 22:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6A53AA19C
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Nov 2025 21:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34FC26CE39;
	Sun,  9 Nov 2025 21:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/goHjhJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MRhElRWE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA8E246BA8
	for <linux-acpi@vger.kernel.org>; Sun,  9 Nov 2025 21:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762725378; cv=none; b=LUWmvhJJ8INaiF08PBe8NndN/UFA6N6iD63QC0dTK1Pc60hp7xyUC+IeGpfrJeLOEfbeMBu2Ootvf2XLakw/FwpJ2uQbGolMB0h3VRSmVDx+4U+4PjTSE6HCeBTsjXjyyYD11qd1RC3ckGqPRPtKliahu4VRsdfvtDnADftWNhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762725378; c=relaxed/simple;
	bh=RJ6pxCqG6BxVkkIZQOEZtLfkxAeHk4urUpxfJNnK2l4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qn8TiRUHdrYv2eso3pr6MjRUyAd8qGvq0Nj0CANdW4cd8FRtpJh6B48P5aj9JhlbiD8Y8rP6++CGjQIbp2dv+LmuieSsXGZdmzxPZmKGQE7wjZDL77HIrF5Afl3Xo4ErCAtw/XY7XuvAhrUYO9vNMaJ0qzWz2rfEGPbJJwl0tlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B/goHjhJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MRhElRWE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762725376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FhpPhNi4Zx3/6UZKrb/xpV5iwVuaKBA/NFjZxSosM94=;
	b=B/goHjhJjVyCwcP9iFaF4CYkLjcDkdkI32jVbBOmShevlnD6XF43pUPQ5th8i9Sba8PbyH
	85lI4ApRa/McxVP4W6wzrN4MdOne2RdI/uIK+OmSCWPFH6RpliUQmEg2tHPXuUrtdLZAI5
	5fyF/xXpPhG0FoBXtzju7E9mQVJm0hk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-jcyj98fjOZaUiEPlXSHTEw-1; Sun, 09 Nov 2025 16:56:14 -0500
X-MC-Unique: jcyj98fjOZaUiEPlXSHTEw-1
X-Mimecast-MFC-AGG-ID: jcyj98fjOZaUiEPlXSHTEw_1762725374
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-297f587dc2eso11698255ad.2
        for <linux-acpi@vger.kernel.org>; Sun, 09 Nov 2025 13:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762725374; x=1763330174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FhpPhNi4Zx3/6UZKrb/xpV5iwVuaKBA/NFjZxSosM94=;
        b=MRhElRWE/QHgpj2PL7SQDkHbg9Q4nJILdN/MZ5TWmcbjpB15Pp7vQiZG79mZTRCe4o
         qbk0OEnw5AeyAkrffdrHZE6mo7Mie384kSTa7h+qesaieXdyg3moJ2wYq2oJj+cR/NAL
         LjNY/BVAO7PkAlckmpF3KSVwBS5+rTVRVD9dys6AGRiOohSrmcFsjiDF/7M4hCq4yvOc
         owOCGDu8NhRMcHMBsyHvI+3m2dFs54lIxax4hvPHt8Mnf2QOCmJ+p1InoyNY2Ioz9ej5
         gTxPlomvzANI/T5XDKdA8sSIlxxe66jS6mRfPslCaJOrdTC6Wv1aQ0cL1/JQVnskDv/q
         TYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762725374; x=1763330174;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FhpPhNi4Zx3/6UZKrb/xpV5iwVuaKBA/NFjZxSosM94=;
        b=Ui4ylwMsfBYx7Zou5Re9jaMNCoWVeyWtFRCIsOxuEq5qwmUJANnwxSjZh60UqwnzQ7
         LTgtOFX0sQ/03IZcaR1/jxeERsuGqlJunDpY9xo5PwnZ/VbXHR1VRMB3V/ZKxRHfb/FL
         vJS+zB3XbTgxfUwf5vE1CPpNhLr+ThBHktpAwLgr0+P4/4iNdY+hEx/67cZfSWe/ek6i
         zjTz5+XcUpnaEXv72MV99tii2GaoEuHMWWVcdMNT/lOhcAzvm7r4F7UVyu4VMT/hE//M
         xIc5H4Z2SxrPahd64LpEvLN8PJnIZTgiaq4L0R+ooeuhbl78IVgH22GobiwGSMVsXNkz
         kZRg==
X-Forwarded-Encrypted: i=1; AJvYcCUJRLQy7L0pjecBH0SmL5+8wNjzBr68vnaJhQ/ow1WTSUXaWfHFMJRHPN0InkOQIPEeS0k4FF/KX+Op@vger.kernel.org
X-Gm-Message-State: AOJu0YwN9QISNC/Lgrv0PEb+L+bpC+an4y0F8c/aBDydYYab1w1FbdD6
	hph+KSVryfRODO6PS6MgVcHmZZGdvPbS3DrcuOKelEt4e/ndbFySS+kicELDejwHBixdMtJDDAk
	1uCLcq2A80Jv+5SoBhfnBUvzfwcIj/NSD5J8j1KDWVSIbMTdDe4ehwc6X9tE32e0=
X-Gm-Gg: ASbGncvvGPIlrQ6jUSWVl4wBd+angM50Gck0dzd5wELGaCsZj4A6+mlUgHZIJjcVH0q
	/Xj3QI/G+5eac8Q4jPSyeMoFPDP0tBbXTiXpH7OL9mERkx1UXiB8yC1BDFV8IvrjOKnnoskM0rY
	I53jqSSYZce2N3QKKMCGfw/Zd19BvCgfvO6HpHUjpsxuDcCnINc6XOR9tPZYmx9sY2YwZ8F3sx9
	5Jxe5JkwS3UCSscdUBzYZxwVafZBf8xh2rs95IQFdu04YDY91NMS89uGV4LRRaeaQHD7EdCQJGP
	EhUlYf9MKiIUh9CPMJC6znj4Z+QZJWIE3CUhrbZLd/F4ip6ex6bGMgQ2T/uRUqiYwYTPnknyHoL
	8CMFsV1uYv/hb3VXAhm5eWB7hfK3ZV8pIk4PSXTw=
X-Received: by 2002:a17:902:da4b:b0:250:1c22:e78 with SMTP id d9443c01a7336-297e540b22amr85533485ad.1.1762725373693;
        Sun, 09 Nov 2025 13:56:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9zBiRG6e1hawt36vRNvVq/h+yltgd6w60xqY2Wc25Pn1yNF2w3fM8lwcZqfnQwOslEQEL4Q==
X-Received: by 2002:a17:902:da4b:b0:250:1c22:e78 with SMTP id d9443c01a7336-297e540b22amr85533115ad.1.1762725373347;
        Sun, 09 Nov 2025 13:56:13 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5e3c5sm123508965ad.43.2025.11.09.13.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 13:56:12 -0800 (PST)
Message-ID: <c4abf4ca-9bcd-4edf-a291-4363f8643386@redhat.com>
Date: Mon, 10 Nov 2025 07:55:58 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/33] arm_mpam: Probe the hardware features resctrl
 supports
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
 <20251107123450.664001-17-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-17-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 10:34 PM, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> Expand the probing support with the control and monitor types
> we can use with resctrl.
> 
> CC: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v3:
> Drop the =0 in the enum (Jonathan)
> ---
>   drivers/resctrl/mpam_devices.c  | 149 ++++++++++++++++++++++++++++++++
>   drivers/resctrl/mpam_internal.h |  33 +++++++
>   2 files changed, 182 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


