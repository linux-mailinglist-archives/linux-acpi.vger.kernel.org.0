Return-Path: <linux-acpi+bounces-13621-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD292AAEFF7
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 02:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A76177AE84E
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 00:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097678248C;
	Thu,  8 May 2025 00:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJ1Og3jl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD5778F58
	for <linux-acpi@vger.kernel.org>; Thu,  8 May 2025 00:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746663894; cv=none; b=r4Nwq/G0Vmgt8N2aX8riAKMCWJyIjWOAoeF/mDnfeNsMOkmvyA8NYHJwqCDsxCgKwUYStKEAxS4Jj/6tf2dIDS4xBJeQRLY5QQFjNrivxuHbA0e6Yaap/mBWX9clkXOfPmDENKNpfKyM/gP3vwY+gT2Vg+HhF7LLZpO6ViyHGTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746663894; c=relaxed/simple;
	bh=+M4FEN/6VWjOBMZr8f0YY21+Z/Xd00SqsGaVddREc0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZV7AZ91D9alvinmooLOeTb5AARpER/tsCZYOYV1tL3M5VBX4p+Zq4jcGXPOp3yf5HUPfk/jgGARPLKXNSsPcI5Fj5m1JFUvG8bVmJb/Enktu13dKl8sbaR7V3MqcXI7rfZA2wFz2fh5dTCsErFdYvcA5wA8arVsN/Du/GDC0KxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UJ1Og3jl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746663892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9HgcA+GEZvObAcEh2COOJwVolQxRQjimAkm+36NZ3tU=;
	b=UJ1Og3jl8lIQ4DqoeLKlmcAZoVzqdi0SDoOJSAU9c5diQMeZS/RIqXDWXWRYNqpzD+r65w
	HKsvLRw4zPeIz5nWCYI8R921hgY7nVbkvPjO4HU7ze9e1ffh40LwUphTRelYFriyKd1Knq
	aV+t1XW+eAX8vUUA/iUqj/goZJO9hbM=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-tXKIPq_NMgOlhpzQHYxE2A-1; Wed, 07 May 2025 20:24:50 -0400
X-MC-Unique: tXKIPq_NMgOlhpzQHYxE2A-1
X-Mimecast-MFC-AGG-ID: tXKIPq_NMgOlhpzQHYxE2A_1746663890
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b1d9f278aecso195230a12.2
        for <linux-acpi@vger.kernel.org>; Wed, 07 May 2025 17:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746663890; x=1747268690;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9HgcA+GEZvObAcEh2COOJwVolQxRQjimAkm+36NZ3tU=;
        b=UtWaHp8YYk879jReKCKoIxtgu8a2pw5SuEqros3mGEBmTO3BXZZWtcTFoUAqsm/CCo
         WrwQd93gzyeOfz2zZLZmt2m8aWkJlYlG31SMqSrXUz6NzxDV/ALz0JXRmcR7KxVkpt4H
         yfXOnj7ZPUbvpNKUM52jLg2C71SjVZYa9bhRmh3iKH8TJJAzSpLsVYfzL+eVjuSsdgpF
         a84OnIjcVNqArXUznXDiBIabVPrCcMEhsU20eHOW5/V4wqqrRvogYqY4FT4BZRDEdEL1
         Xgc8arfLUoxExOo/hP9RaBOGUrCfKGrpJstFK29D29D7cWSUW845+uei6vmVLAIiqDJ2
         sHQw==
X-Forwarded-Encrypted: i=1; AJvYcCWIH7WnvAtEqq+BSX0RnG0//8xlVO80C3w62MmG8RylJJWIoOasMxRlUtmvRCrmbU9Txa7C6qyL7Thn@vger.kernel.org
X-Gm-Message-State: AOJu0YzHUlKsmMScvbUutWpOTAbpJYZAer/AmO2pSEWjCn1XZ/MNNT6A
	3mHRDinIf6RRXm9zLTMiJ1QEThlY3VaB6fm+hQcIBmo7Axs+volaeorESqIW3/qpmX/K4PKU5Wa
	sscfe+SOH6qrtYfR4xTBjtsmtZ6LKipuHBzyob6prhO4feM81j11VpFdB/q8=
X-Gm-Gg: ASbGnctNyxNuYuUpOnHAEE0zYsvx3WS8+PFDjxqA7IW8Hshub5Y0R2+xVOJD4IOxAtJ
	YmoF0tsT9OJ79vTn74XrH1IGsaLrPLw543S+3YTeGw1mgKppHxk9a+xk020Dtx2S5jngGgVctAx
	hRNQB2S7fQaGqymRbIwcNCAaom0YN2h9nYeqkP9BO3CZVkS0qyP1MI3/TbrKdXFLSWeC8X5RJWq
	rskuCW9Y5OLNtS9sCawxwMPQMm+IV0oOKehCcEhXdeewgmpvVBJtKVUaY7fqcHE87HdrMY8E99G
	Xe4ASe61vIiC
X-Received: by 2002:a05:6a20:ce47:b0:1f5:8153:93fb with SMTP id adf61e73a8af0-2148bc11565mr7275548637.10.1746663889866;
        Wed, 07 May 2025 17:24:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkSEc0BIT0XhNYV17IYbaP5fkwntd9qeYQtp9PZH0RGNmeuFUv+jl9d36QtCKWb7HSgaLewg==
X-Received: by 2002:a05:6a20:ce47:b0:1f5:8153:93fb with SMTP id adf61e73a8af0-2148bc11565mr7275523637.10.1746663889500;
        Wed, 07 May 2025 17:24:49 -0700 (PDT)
Received: from [192.168.68.51] ([180.233.125.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fb3c697a6sm10158269a12.63.2025.05.07.17.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 17:24:48 -0700 (PDT)
Message-ID: <5b8ea515-788e-44b8-b7d3-a85329b584dc@redhat.com>
Date: Thu, 8 May 2025 10:24:42 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] firmware: SDEI: Allow sdei initialization without
 ACPI_APEI_GHES
To: Huang Yiwei <quic_hyiwei@quicinc.com>, will@kernel.org,
 rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
 tony.luck@intel.com, bp@alien8.de
Cc: xueshuai@linux.alibaba.com, quic_aiquny@quicinc.com,
 quic_satyap@quicinc.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@quicinc.com, kernel@oss.qualcomm.com
References: <20250507045757.2658795-1-quic_hyiwei@quicinc.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250507045757.2658795-1-quic_hyiwei@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/7/25 2:57 PM, Huang Yiwei wrote:
> SDEI usually initialize with the ACPI table, but on platforms where
> ACPI is not used, the SDEI feature can still be used to handle
> specific firmware calls or other customized purposes. Therefore, it
> is not necessary for ARM_SDE_INTERFACE to depend on ACPI_APEI_GHES.
> 
> In commit dc4e8c07e9e2 ("ACPI: APEI: explicit init of HEST and GHES
> in acpi_init()"), to make APEI ready earlier, sdei_init was moved
> into acpi_ghes_init instead of being a standalone initcall, adding
> ACPI_APEI_GHES dependency to ARM_SDE_INTERFACE. This restricts the
> flexibility and usability of SDEI.
> 
> This patch corrects the dependency in Kconfig and splits sdei_init()
> into two separate functions: sdei_init() and acpi_sdei_init().
> sdei_init() will be called by arch_initcall and will only initialize
> the platform driver, while acpi_sdei_init() will initialize the
> device from acpi_ghes_init() when ACPI is ready. This allows the
> initialization of SDEI without ACPI_APEI_GHES enabled.
> 
> Fixes: dc4e8c07e9e2 ("ACPI: APEI: explicit init of HEST and GHES in apci_init()")
> Cc: Shuai Xue <xueshuai@linux.alibaba.com>
> Signed-off-by: Huang Yiwei <quic_hyiwei@quicinc.com>
> ---
>   drivers/acpi/apei/Kconfig   |  1 +
>   drivers/acpi/apei/ghes.c    |  2 +-
>   drivers/firmware/Kconfig    |  1 -
>   drivers/firmware/arm_sdei.c | 11 ++++++++---
>   include/linux/arm_sdei.h    |  4 ++--
>   5 files changed, 12 insertions(+), 7 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


