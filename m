Return-Path: <linux-acpi+bounces-5391-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D88C28B33C6
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Apr 2024 11:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1613A1C214C3
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Apr 2024 09:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF2813E043;
	Fri, 26 Apr 2024 09:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IAhn/Yoo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253E413DB90
	for <linux-acpi@vger.kernel.org>; Fri, 26 Apr 2024 09:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714123245; cv=none; b=Mvd+Er0V9JZYXvBsjkm3R6On4HFVwGwpE5SHOkm/jcFV6jdCJ2tCElJFIx7YYRO5trYdMHRpMeJr00cVD6iX5LKdbOYXI3PZPKfgfeeB/GTJVtg0IDA6DLhZSi0M7st6vQt3zy9JYLnjG37zaYSytHtIXqgSnMhlSsUW8VsU67U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714123245; c=relaxed/simple;
	bh=C3rHTvF9PHfzdrgv16HQit9eIpwFV1aeMPWDWLSjEDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vDg5aCga5gKEjPo8KjzDJCazasQ5nKj1qDLI9wucYSIPFH7U0cOUCIVgupbAeg04PEv/gtFqj3E1jAv8lHLqqQ3ikqdhQtt5ffMHVPlMUYMdznOKFA/YhZbXU+ivxdJqUgqG5z3Xt/Fi1pQBbZW7Okl+aqcx+8fz0/25IdVIhzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IAhn/Yoo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714123243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Dmcns0FZ9CNJhWQ+HJ61vRnl0WhR0+EUECBc2kBET0=;
	b=IAhn/YooqoL2D3dliVh5H5BQbk23zY+tyg9jtazYEfAIuPrJIQBWaAUqyS7AciLWQWk+u2
	nmLqvRhnyWmtmhtjP87SSYlx0Ou/TS4AcRvT2MpzIZdxB0M7kdCltCSPzs454lZHYmsNt5
	3dpbf1I53aAbwAaSPr4nh5WHGZRxpmA=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-6QlhX9_yNxaMLcujOmq97Q-1; Fri, 26 Apr 2024 05:20:41 -0400
X-MC-Unique: 6QlhX9_yNxaMLcujOmq97Q-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3c700dc69a9so2375423b6e.1
        for <linux-acpi@vger.kernel.org>; Fri, 26 Apr 2024 02:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714123240; x=1714728040;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Dmcns0FZ9CNJhWQ+HJ61vRnl0WhR0+EUECBc2kBET0=;
        b=Dd7ZHug2yHoijnUmdWUOBPfQmyWRV7pJVySrDasvExFr3s4qyt3JAUrcZRI2WoPybQ
         g9VP8y0Q+IKFbERnz2AUstx7Dch5ldY6+1n6aK/paQY8L25naYWnmoCEnqzNhrp/JLpY
         IWvkvnzVWzp5z0DRevwHH3U+sl8JIo3DS4T1FInl9dIFrjrvK0fMVST7ObygrHSZojR+
         cSY1Ej1CiYS0ysbk8WcQzj4VUHjUyGQYZSEk/zr1GAsKMOXtF8qa9jC02xvSbJ3fjmAb
         3AnBUVjPw850O9JUQ0Q5IgtDN2TuRADGpP6kPvnvZoWOBT8agupn9SOFgnQR9PwtnfQP
         g3Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXttH4erPF1Ou9N6Zqdjp5Zzv6ph826vxDunc5HSuRr24PrQEXAz61hvTn6gYj9JOUb2fz7A/QDtEwfn4LlFjyl4wf280Yk9vCDJw==
X-Gm-Message-State: AOJu0Ywjv0b7LN0NqbdNaZ7hQgzmZILhABefyO8hsJyE0DANn5OvWiKo
	sbf5LSepxfIpYZZZqCg0aD509yYiF4ViksgBtHdqNWp+toVYSIZZwVODaN5gXdsZaa39+9cLkb5
	A8x6pmCnu5UhwarrpehEpNxowQHlLAvPG4gz2PET9pjQQ5a87XRn1bJT200o=
X-Received: by 2002:a05:6808:1528:b0:3c7:dfb:a295 with SMTP id u40-20020a056808152800b003c70dfba295mr2563868oiw.55.1714123240344;
        Fri, 26 Apr 2024 02:20:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkmQHR4xd5DGzRLvfFnAFgkLJtQPF1g3QWZiwSfctnEJmyqeJV0jASxLHf/gm5VeDDfBboyg==
X-Received: by 2002:a05:6808:1528:b0:3c7:dfb:a295 with SMTP id u40-20020a056808152800b003c70dfba295mr2563855oiw.55.1714123239985;
        Fri, 26 Apr 2024 02:20:39 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id u9-20020a637909000000b006047eb9c7fcsm5263952pgc.34.2024.04.26.02.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 02:20:39 -0700 (PDT)
Message-ID: <0cf50b2f-999f-4aab-bc32-15549d48af2c@redhat.com>
Date: Fri, 26 Apr 2024 19:20:29 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/16] cpu: Do not warn on arch_register_cpu()
 returning -EPROBE_DEFER
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
 <20240418135412.14730-3-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240418135412.14730-3-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/18/24 23:53, Jonathan Cameron wrote:
> For arm64 the CPU registration cannot complete until the ACPI
> interpreter us up and running so in those cases the arch specific
               ^^
I guess it's a typo? s/us/is

> arch_register_cpu() will return -EPROBE_DEFER at this stage and the
> registration will be attempted later.
> 
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v7: Fix condition to not print the error message of success (thanks Russell!)
> ---
>   drivers/base/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 56fba44ba391..7b83e9c87d7c 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -558,7 +558,7 @@ static void __init cpu_dev_register_generic(void)
>   
>   	for_each_present_cpu(i) {
>   		ret = arch_register_cpu(i);
> -		if (ret)
> +		if (ret && ret != -EPROBE_DEFER)
>   			pr_warn("register_cpu %d failed (%d)\n", i, ret);
>   	}
>   }


