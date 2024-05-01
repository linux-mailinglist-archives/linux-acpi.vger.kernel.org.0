Return-Path: <linux-acpi+bounces-5550-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED928B887B
	for <lists+linux-acpi@lfdr.de>; Wed,  1 May 2024 12:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F8ABB22750
	for <lists+linux-acpi@lfdr.de>; Wed,  1 May 2024 10:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA15153802;
	Wed,  1 May 2024 10:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AdmfrsHl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8C951C54
	for <linux-acpi@vger.kernel.org>; Wed,  1 May 2024 10:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714558778; cv=none; b=k+aOCr/OIEbwMUvvnr3ce/SqhTs0TqO0zL3+Y0VhkTbwHuicAOHxQgkrtRkk3xkGTAFSnRfrwyfKl2vlofqvlA9+mNZUATMwIMtVjNPBWbdh74qOkJU+f+wuXJenM+B4NvVdGz1IYLS4DrbFxkqvXvTEzlnHujDrqm7r6PPNhMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714558778; c=relaxed/simple;
	bh=DXhxznU9JjmpSNzg1wHRqUCO05ryVh2E1hgdKVJ0r/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q90A0YA6jGNdx/5WaFOEzKskpoIyaUbpqokVcX84Z45yClTFuro1iuEl331iWA+sUlE99smP2J8w91HwJs0wl7mhRGqjDwxycBNLOnOLToWuLyPHsChjUMFRJkawTpxEfK9kresWXj/SO3G/cw0FG7wFj3LDSZW1xPgrdCkeWug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AdmfrsHl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714558775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mmEGz0tj7kIblBaqJ9h8gJzxXs1BObonWK5NXhTXy2g=;
	b=AdmfrsHlXaTnQk1wpxyiZrYV4pCG1hKqgnBgc0yCbmDKFwZhy21nZo0BcyE5+JOspYWgOB
	pdosOxTTznrRW1kK/lwNLPdWjXpnJhDRYM/F5F28ncJ0F5a/zjzLJOVQF3Lab34DtPY3zR
	M1XWBsZBaNXI0sIA315CMWcNLXP9KI4=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-thaKxhDUOoa_7zt90KhlEQ-1; Wed, 01 May 2024 06:19:33 -0400
X-MC-Unique: thaKxhDUOoa_7zt90KhlEQ-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5aa33fd1935so11219082eaf.2
        for <linux-acpi@vger.kernel.org>; Wed, 01 May 2024 03:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714558773; x=1715163573;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mmEGz0tj7kIblBaqJ9h8gJzxXs1BObonWK5NXhTXy2g=;
        b=rUay5V4RcWmiQCJDdoSLmcGkz/YPCWG7K35ZOzqEhtB7YYHvijFxt4xs4Qe5hLP0ZZ
         Zxkn2y0UrzdaHiSuUU07HIPGXC3kG9CC2titB0jKq60Jd51Kz99IvWWXND1HV5S7Cy5T
         rC6LrdXn2+cRuAV0c9guIwwubz4XAvd8s+5jjvvBp8MoYlagnR+gsp3ryeMWyBCt94+j
         fAzUTkhRWd7HUy7QYHT1xfsv0m5BZ9uavR8M1R9nhLoG/JKKDi4Txe/u4Dj/At+pw1PE
         LfG53Ts0b8xlcpK7gjPKDrVcpjzfeGZRPCw/q9NIifdrFdqkwgZqppuEC6SEXZts5Aq6
         DmDg==
X-Forwarded-Encrypted: i=1; AJvYcCX9pt1dDO0bmF6i8lMG34F6a/TpjTN3yZ7qd0VK16AEiYgZJETifFFGsi4Qm9lQQEzlVNKr+VT4SbNYJWJG9+bEarYCUsmHmW2nLw==
X-Gm-Message-State: AOJu0YwbnJmCHUKSEy796wJxd/jbnMQ2xYqz7kWZKmtByeo7jCLS5WdW
	6UgaLlSQCtLbF6rkqx4jwxfpjQoKVXvH4uyAItzC2bx/gjE4MRwRyFKylSQFp2bgS1+Rup6IU8u
	PjF5b9wHMa5RTd72ghLZk1WNmLN+Zz7SZ2U7Ed12pCS74awQMcZVRpXxxbJ8=
X-Received: by 2002:a05:6358:b3c2:b0:186:d3c9:fc0b with SMTP id pb2-20020a056358b3c200b00186d3c9fc0bmr2565150rwc.30.1714558772864;
        Wed, 01 May 2024 03:19:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH109ZEmrs8b6zIYcwGCPZVYbwoFohFQfuWKsDp3G4uwsHjXJPYYLUDItsMWRt9l+MVNm+LjQ==
X-Received: by 2002:a05:6358:b3c2:b0:186:d3c9:fc0b with SMTP id pb2-20020a056358b3c200b00186d3c9fc0bmr2565125rwc.30.1714558772433;
        Wed, 01 May 2024 03:19:32 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id x71-20020a63864a000000b00606dd49d3b8sm12183225pgd.57.2024.05.01.03.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 03:19:31 -0700 (PDT)
Message-ID: <02922d47-6bb9-4865-b13f-b3a6972853a6@redhat.com>
Date: Wed, 1 May 2024 20:19:23 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 05/19] ACPI: processor: Fix memory leaks in error paths
 of processor_add()
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, x86@kernel.org, Russell King
 <linux@armlinux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Miguel Luis <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>,
 Salil Mehta <salil.mehta@huawei.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Hanjun Guo <guohanjun@huawei.com>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, linuxarm@huawei.com,
 justin.he@arm.com, jianyong.wu@arm.com
References: <20240430142434.10471-1-Jonathan.Cameron@huawei.com>
 <20240430142434.10471-6-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240430142434.10471-6-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/24 00:24, Jonathan Cameron wrote:
> If acpi_processor_get_info() returned an error, pr and the associated
> pr->throttling.shared_cpu_map were leaked.
> 
> The unwind code was in the wrong order wrt to setup, relying on
> some unwind actions having no affect (clearing variables that were
> never set etc).  That makes it harder to reason about so reorder
> and add appropriate labels to only undo what was actually set up
> in the first place.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v9: New patch in response to Gavin noticing a memory leak later in the
>      series.
> ---
>   drivers/acpi/acpi_processor.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


