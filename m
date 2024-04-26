Return-Path: <linux-acpi+bounces-5393-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D2A8B33DB
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Apr 2024 11:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A2021C22652
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Apr 2024 09:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4363B13E8A9;
	Fri, 26 Apr 2024 09:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bWeOtios"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD83713DDC7
	for <linux-acpi@vger.kernel.org>; Fri, 26 Apr 2024 09:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714123462; cv=none; b=lL7YYvJJzSHrPIaPudHyewSbffXfOSbGwLdoRU38IgHSLF2tCOtb7Uu4QannIGc8JtafqpJN+etzVZlQsJ2pdFO/18Q1TyNmMKii9WFbeiNz7L8QftpJf8QGzn//TKlyWmzm085RKkfu901Ut5QTNnUopKUaqGmZpf/rdoDaVX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714123462; c=relaxed/simple;
	bh=3prmVvb4CSFrMQtGQGohzxkB5EGRjQF5LNfCJibjaRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YlnfYegfCg8v3PL4KTdar089JM48xRD9x+iAzxaTjE3VOtNndrRqqK4eg8tLQz+jz5fh4DtuCXLFNoobnNihuadAZNMO5kxvvjlWLjvNanEypE+X8HL+ywwv/DVA0o68xSbT7ZVGVw86ucxRFcj77uA1e38Cjn0eNCT2M7EFGmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bWeOtios; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714123459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wDf1iJ0rcFw5r9tjCYtJ1fcG4v1z0nEnImYLXEpzCjM=;
	b=bWeOtios20C3eqi+Q4VeUWCZXhWTd7xhoCJO6XcYib8pofcXg58PMuBt/wGWhHDsmd7qcm
	X0JemTsn3VlQxeyN3cPwDoCxkI92oZDfP2ceji57H0/x20hRM5D+uONsZpbB7XYSo4iq9Y
	kimwgenCglgLBsq4bKVVQiJl2dC5ZSE=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-IXVejeZtNFG6Z6gSwlS-bw-1; Fri, 26 Apr 2024 05:24:17 -0400
X-MC-Unique: IXVejeZtNFG6Z6gSwlS-bw-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-6089c86e4d9so2148174a12.0
        for <linux-acpi@vger.kernel.org>; Fri, 26 Apr 2024 02:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714123456; x=1714728256;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDf1iJ0rcFw5r9tjCYtJ1fcG4v1z0nEnImYLXEpzCjM=;
        b=CzzS9qOLBhDGfKEtJRR7zmOOnVMthMmLQraefGSCaedjYb8wsxVl3Q6z5Y8tZX6IO3
         cso8TrBQ8Z9sRwM9HlTzREi11LoShMOlv5Q9ld7HuX6r+2q66YelOiHYDF4YLWUpsMW1
         wX1Eg7WHNhk1Duw/ScjGXTP5l0trOl3xuOer1wf3u4yk26+LQ0VpqxPZESgSI7ZYubSS
         AikExO3UxUomUjCUcpCcX/K4+AGDK1tsPmR9/XxGWr5IHy5VVNctTn1UMJGAK0J6t/1i
         omj3q1L+/RSMdTXKOyjFbVTm+Jj/jxxJBRibtIsEhyL9UCH6Ro8K8VYARXa24u5bOzBV
         5gBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnrKS3hzZfHuihhqO2+W7PUse4sIkDQZeKEqzMYS7NZSQ7kPXufavkFW4g3CI0EtYno9toQxgCZ8Qp1P0tgt78jK/JXN4n27kcWA==
X-Gm-Message-State: AOJu0Yz3AYOEV9sZTHckI9BKDiuOQHy73KKp8aeyvsrn1ixH8Jd9oQDg
	fhi3DLSR+93UAbGcKYvZbkQsOnDj54Pqb12NDXElfLN5sB3h6MI60L407oSUS5saij4RPwHcUQN
	y9OLyK15ygzm+rrCV+TYLoEUQQ2YH5JQRoHZ3iUdIz2E5HbK2EEPY1lmSlQY=
X-Received: by 2002:a05:6a21:3a44:b0:1a7:7b92:e0ed with SMTP id zu4-20020a056a213a4400b001a77b92e0edmr2325185pzb.51.1714123456724;
        Fri, 26 Apr 2024 02:24:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxVT+GN5mxbf+mMtYjbokc8FhufYwX7eAOxYXMmkBU6lBE5Xi1LluATczohJhaBcs7ECSJrQ==
X-Received: by 2002:a05:6a21:3a44:b0:1a7:7b92:e0ed with SMTP id zu4-20020a056a213a4400b001a77b92e0edmr2325150pzb.51.1714123456389;
        Fri, 26 Apr 2024 02:24:16 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id r3-20020a170902be0300b001e27462b988sm15054500pls.61.2024.04.26.02.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 02:24:15 -0700 (PDT)
Message-ID: <e3fb151e-8d79-439d-9eea-131a23f1d48c@redhat.com>
Date: Fri, 26 Apr 2024 19:24:07 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/16] ACPI: processor: Drop duplicated check on _STA
 (enabled + present)
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
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, linuxarm@huawei.com,
 justin.he@arm.com, jianyong.wu@arm.com
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
 <20240418135412.14730-4-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240418135412.14730-4-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/18/24 23:53, Jonathan Cameron wrote:
> The ACPI bus scan will only result in acpi_processor_add() being called
> if _STA has already been checked and the result is that the
> processor is enabled and present.  Hence drop this additional check.
> 
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v7: No change
> v6: New patch to drop this unnecessary code. Now I think we only
>      need to explicitly read STA to print a warning in the ARM64
>      arch_unregister_cpu() path where we want to know if the
>      present bit has been unset as well.
> ---
>   drivers/acpi/acpi_processor.c | 6 ------
>   1 file changed, 6 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


