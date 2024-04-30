Return-Path: <linux-acpi+bounces-5476-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 412038B6974
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Apr 2024 06:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 544141C21B14
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Apr 2024 04:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFDF1401E;
	Tue, 30 Apr 2024 04:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fbEt3Zv+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFA812E4E
	for <linux-acpi@vger.kernel.org>; Tue, 30 Apr 2024 04:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714451368; cv=none; b=c7Eyu4BV6zyxMU1VN4LvqKAtKBx6nN56gAPiJNHBy7p6MawcFe7hemkVraiaRG+8Sgrtl6eiTLAeAvivtBV/OCe916QmlXgyN1aIw+HRw7muoBSVuI2d330w4rhiGhXSbG9gVmO+wBL23nzsaQ7JQ/0w59mnlOaxBY1OIhUxsi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714451368; c=relaxed/simple;
	bh=FEm1/PB329Jyi/kHvt9MX59QyNkI8IQyV5tTODOIcw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nFqjbm1VXh7Vg/0Rk0GijDoXzaVry+69DLjqxeZDSMSTT7EyTicRdql2cPhsZvx8HyNah2R9oHs/SJZ4lWFApXVJSByZQ6dGQqQlCX+MCKhj+VSvkJOlph1lzqu8TwUxtyUHYq6dsZV9KTGlgW7lTEDvbShm4PcJtnC5EQURtXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fbEt3Zv+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714451366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D1/gI69YXA+wRBrAlMSJILQJim8W89y0vmUYfYeJ+kM=;
	b=fbEt3Zv+ZavkHi7hEwx7lr/jbTd0F+cUZZ88CYGtT7Z/BE1khLhcaaeRLlUzJ4CXV4zJ0T
	Q94Y7kdZZXyHyAC3jZv8hr8R9Jqgb/RKcd8TKDCl8/uz0zUxNLybHXnRUekOF3rNZJcs0A
	m5hGsFX8mA/o0bONXeA3vHc3kAXJ48M=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-6UMP8kAfOquTlxA5-AB6ig-1; Tue, 30 Apr 2024 00:29:24 -0400
X-MC-Unique: 6UMP8kAfOquTlxA5-AB6ig-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3c7171db6ccso6106310b6e.2
        for <linux-acpi@vger.kernel.org>; Mon, 29 Apr 2024 21:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714451363; x=1715056163;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D1/gI69YXA+wRBrAlMSJILQJim8W89y0vmUYfYeJ+kM=;
        b=N0wnViYVZpOyqnA/WKl9r1puGfezBZQDQpwgsXr2gSiKrpqKCLT7+P3B8+xnOJ/n4t
         FtYYqiTAzdMtvZb3yMItjmy1JFBaNyOCye+KVzj5ZFAsG0dZSM8zBhXGh+2aQybHGTaP
         tzLQmyJY7Tu5cXFUKcPpASK5TbzxvfK6MzxeIXnbclRwLlv2cZ/LMff/EUV+SuTbAZgc
         w3Ns0zYnZfGpp7MmkqY1InJVC5U4q/0S+cVRteZwau1ZkSi9vEj04kRh0nWGVg+g3psC
         sINji4JgN4CYNViq/xcUGBu9RA32j2Cc+A3mD20LM6Geh4sWBg3CchWBAoMpQa2qflW8
         RTzA==
X-Forwarded-Encrypted: i=1; AJvYcCVKPrLe5rot52feAcRG/psj8AhqRoDOGYGJ1IQIOFGPpT4uvNSV+vHNTby+f4C4Qs44zska3+tt9MoO9r2lLgvpunEyX4wnrJFDVQ==
X-Gm-Message-State: AOJu0YyR3rBREn7T/yv8jdlrp7ZmZcpULYRPoMDZte1sY0qmVfdghS2l
	D84JNIDCvbesWk0t1rWJHssYSCd6nSwIefc43gShQM9QLjNDqqH/wwch+uf3vK1GMXg1jpAd8nL
	uo7L/mS22DaywQeKLT9dYfSXb9s1efKXmFuEAtZfNdPM6DKtkfKeCejYJ+Ao=
X-Received: by 2002:a05:6808:1b21:b0:3c8:42f1:40b2 with SMTP id bx33-20020a0568081b2100b003c842f140b2mr14918942oib.9.1714451363401;
        Mon, 29 Apr 2024 21:29:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEma/8noQWxcMSK7hzaRRVetUMUXvHfjFYfu5UCMsY0GiHyeLt76asSKvhJFyxiVUNt5H/EkA==
X-Received: by 2002:a05:6808:1b21:b0:3c8:42f1:40b2 with SMTP id bx33-20020a0568081b2100b003c842f140b2mr14918939oib.9.1714451363109;
        Mon, 29 Apr 2024 21:29:23 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id b16-20020a63d810000000b005e438fe702dsm19772604pgh.65.2024.04.29.21.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 21:29:22 -0700 (PDT)
Message-ID: <eaac4ff8-4e88-4f66-b4ab-975a5b77c3a9@redhat.com>
Date: Tue, 30 Apr 2024 14:29:11 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 12/16] arm64: psci: Ignore DENIED CPUs
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
 justin.he@arm.com, jianyong.wu@arm.com,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>
References: <20240426135126.12802-1-Jonathan.Cameron@huawei.com>
 <20240426135126.12802-13-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240426135126.12802-13-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/26/24 23:51, Jonathan Cameron wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> When a CPU is marked as disabled, but online capable in the MADT, PSCI
> applies some firmware policy to control when it can be brought online.
> PSCI returns DENIED to a CPU_ON request if this is not currently
> permitted. The OS can learn the current policy from the _STA enabled bit.
> 
> Handle the PSCI DENIED return code gracefully instead of printing an
> error.
> 
> Note the alternatives to the PSCI cpu_boot() callback do not
> return -EPERM so the change in smp.c has no affect.
> 
> See https://developer.arm.com/documentation/den0022/f/?lang=en page 58.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> [ morse: Rewrote commit message ]
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v8: Note in commit message that the -EPERM guard on the error print
>      only affects PSCI as other options never use this error code.
>      Should they do so in future, that may well indicate that they
>      now support similar refusal to boot.
> ---
>   arch/arm64/kernel/psci.c | 2 +-
>   arch/arm64/kernel/smp.c  | 3 ++-
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 

Thanks for the check and clarification that -EPERM is only sensible
to PSCI. With the clarification:

Reviewed-by: Gavin Shan <gshan@redhat.com>

Thanks,
Gavin


