Return-Path: <linux-acpi+bounces-17525-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A5CBB5AC8
	for <lists+linux-acpi@lfdr.de>; Fri, 03 Oct 2025 02:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EC3718967A4
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Oct 2025 00:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C93F78C9C;
	Fri,  3 Oct 2025 00:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b34bfuQq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE483BB5A
	for <linux-acpi@vger.kernel.org>; Fri,  3 Oct 2025 00:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759451028; cv=none; b=VelGAyiezpjCK8zkkhalZd3nDqDnz/SkpBx0gavzECeb/VfPcKl5HPrGiK53BDJVx9/2NIkgMxHqWY6Qb9ktPw0Jr63xC4bQikHDGBSN0/yf/ozuiH/XaL84iKV6zU3hl30VGwGopt9xpn8rceuFzIfjv3hYr/RRrbBaC1o+qCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759451028; c=relaxed/simple;
	bh=zXZs1CtthDzGW2v/IfUMZJ7TaahHQ2FhRN4cM3MZucA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mtWY+s4TkzWOP8Ai7kRB6Bm0CMF2GCyd0lSu+cOYSnVIq30QfNRRa4X95yBu5xEyGhC8cLuiU6J6SEsERcPg8DcSA9UhSAod5zfNF90CRVgihVmNvybdmEpkXRDyAAXffxgCEj3SratDNiLvz+SWHel/UB76t8wanf5Ufl0ZLGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b34bfuQq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759451022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JJ4GF21x3yH2fxgUvO+kT4SV03dtv6uBvlTIWHIhWNI=;
	b=b34bfuQqMS5eB6X/+1fcjsKJkNbq18tyf2onXS7GAzBSBKM9Ykv+BVpRuz3bqYtrZrnAJV
	2/zDrBYbeAOsbR8nvDuJ3VsmiLE5lrRY8L8Oiekm1GgqImn6uZRbxypvAe1LpKyb9jpocN
	zW16elmyrb79b8I08HuNVdvaAdtHwgk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608--O9WhZT3N2iN2rTZYKOgZQ-1; Thu, 02 Oct 2025 20:23:40 -0400
X-MC-Unique: -O9WhZT3N2iN2rTZYKOgZQ-1
X-Mimecast-MFC-AGG-ID: -O9WhZT3N2iN2rTZYKOgZQ_1759451020
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-269939bfccbso18562025ad.1
        for <linux-acpi@vger.kernel.org>; Thu, 02 Oct 2025 17:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759451020; x=1760055820;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JJ4GF21x3yH2fxgUvO+kT4SV03dtv6uBvlTIWHIhWNI=;
        b=Lo5U1M3+qBnx+4CIWn6mgnMlSYjvi1kgZJnC77tL+u7Y1LYBiqdMulLIvxLMblvpnN
         IJf0wgJxTZmK9+h0RnPaiAGkVSql1AcyLVYxE6W2UprgM1s0dDA7bBoOuJWI1P0Mxjpe
         gakcTe22ZMgcu4WWdQVcZyXyJcQZery4MeAufcpmgnHkCZ1kZFiKUMXSGdM7bGzTmLbm
         /5tOM1KiYVd+5PmdP/5fV0AZI4WjjEYnsu7UX7TRwFIat5vYW5Ut2jr3yAw5nXhLczKz
         TIWPIvWe4p1ix/DhWNV5VqTEROIUT9mviQzFzx/iv9pyDb27H/ELalkc3E0I1+b++Cny
         bx1A==
X-Forwarded-Encrypted: i=1; AJvYcCWLZBB+s+Aso2ih9vEJyDcDWU3OO3rb9xEIJLtS3mjIlRep/eg0zOnTLCL6Bbs6YY5/edEsjJUhJF9A@vger.kernel.org
X-Gm-Message-State: AOJu0YzNSV7+ZfKtEuc6UGo+nfQ9xdmYnSfAgLGWli6Qvuq1VH00jzxh
	ezq59XEh8g/6xR+sMXIhqBhwRFy/5FfNUaoqdUo8u98XCP6qDLBOd2m68gKsFE21pNleBUkZdW+
	Kr/Tz2WJTNxEXVUnFr94ot8SxVqKibQ6yCQPhHYJSCWrQFWLffiFS15GFrZar+zg=
X-Gm-Gg: ASbGncussTqhCdGLUBCLwjQlLMCXBOZhgh8OMk0/ihrccDaQwXQ+vKuVaLjmdeynELM
	7ESuUs2GyYJFA1kceXu/2LGVO6+pKV1M8BfmElwxz2W4qrRLTzMWtM6vtdyxg1OcUJ4TPOA1hjl
	wF+h/mCNtREP4BKoOqeRELusf+ibKE7q4cgRe0lwoHrprILy7DPBUlhzI+ASsOkTP3AcMIc57xt
	N1uZEm0yPvKPIb0PrkQaxfljuvOHLKxIBgN34Ot11ZGSs9Va+gPhTz7rAJrGXIdQ99A9ztUCuWQ
	NMJTTMwNIM3HlKWEpi/r7TccG6g0h5zWIk1eVGss5vQgpU77YWVJ3Kth/Y6PPno/uUftNO9D37z
	HTl3DgSOhpg==
X-Received: by 2002:a17:903:3d07:b0:268:500:5ec7 with SMTP id d9443c01a7336-28e9a5b9441mr12159145ad.2.1759451019760;
        Thu, 02 Oct 2025 17:23:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5T0f61djQ+l8nuJX+LHXogclh1AUcAAg1KdLhGp2cAXJedAcNcCLa6griCMec76R0JF2mkw==
X-Received: by 2002:a17:903:3d07:b0:268:500:5ec7 with SMTP id d9443c01a7336-28e9a5b9441mr12158855ad.2.1759451019403;
        Thu, 02 Oct 2025 17:23:39 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d5e36sm32448375ad.114.2025.10.02.17.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 17:23:38 -0700 (PDT)
Message-ID: <81262452-d780-4e85-b153-b3b8d16eabae@redhat.com>
Date: Fri, 3 Oct 2025 10:23:26 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/29] ACPI / PPTT: Find cache level by cache-id
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 fenghuay@nvidia.com, baisheng.gao@unisoc.com,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Rob Herring
 <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-4-james.morse@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250910204309.20751-4-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/25 6:42 AM, James Morse wrote:
> The MPAM table identifies caches by id. The MPAM driver also wants to know
> the cache level to determine if the platform is of the shape that can be
> managed via resctrl. Cacheinfo has this information, but only for CPUs that
> are online.
> 
> Waiting for all CPUs to come online is a problem for platforms where
> CPUs are brought online late by user-space.
> 
> Add a helper that walks every possible cache, until it finds the one
> identified by cache-id, then return the level.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v1:
>   * Droppeed the cleanup based table freeing, use acpi_get_pptt() instead.
>   * Removed a confusing comment.
>   * Clarified the kernel doc.
> 
> Changes since RFC:
>   * acpi_count_levels() now returns a value.
>   * Converted the table-get stuff to use Jonathan's cleanup helper.
>   * Dropped Sudeep's Review tag due to the cleanup change.
> ---
>   drivers/acpi/pptt.c  | 62 ++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/acpi.h |  5 ++++
>   2 files changed, 67 insertions(+)
> 

With existing comments addressed, especially those from Lorenzo Pieralisi:

Reviewed-by: Gavin Shan <gshan@redhat.com>


