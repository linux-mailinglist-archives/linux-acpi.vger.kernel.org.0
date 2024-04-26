Return-Path: <linux-acpi+bounces-5394-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4960C8B33E1
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Apr 2024 11:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 053BA284943
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Apr 2024 09:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E7B13D89C;
	Fri, 26 Apr 2024 09:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EpLXYj4M"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E605513C838
	for <linux-acpi@vger.kernel.org>; Fri, 26 Apr 2024 09:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714123550; cv=none; b=nP6NyDvqNxkWULc7xEuqX81jueIjuIGEpnDYDM9TQRBfD6Cr1dx9P0/NrnZcP++hiRhXP0FZQPf/pyS/76lYbMzo1S409Wc2TfkTTWfW/NoQHwwgdGCoF3Ri+fVPALN9Q1kxWAet7Emu2N/MaZiyMcfREvFldQbeFjzbsfeRIp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714123550; c=relaxed/simple;
	bh=v/8fP7ljlfNYu8p9ZmxbNzZV08oGzX9HMMT08K/tl/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lHjx/CjjrsriSEnQAYyveGDg45rHBOPrrlb99zSEnEwNU4TQfGbqjCY4wq9zfgGE0zHT/UAD3F9+AZd8LrLzWQSA2pKl9EHU+4r+TFJtbT2+DpnVXKU4FUS751R7UBbiCXxu0+QQNBiAzU54gN6b4mFnR0Sb9vEzW0x4KGKSi3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EpLXYj4M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714123548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aI+0tk0N0rfZ0+RaTapxWMbQJR8XZdeH/fzJ04k7BlA=;
	b=EpLXYj4Modg5E4H1cHYXLiUvQmHYFUwXMGkBmNlMPmwg4B4X93C5/kdcJMbSYgh8vb3kaV
	4M/hH0+2obn04u8QRmNkfJOI5E16aZZcQln9QNxf4cLgGiEho9zUhA5KZpmaifM6ogdfxX
	jcaBs/cjHHbcgiJ/cc8KMreXeIgt06I=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-V0Wt-5_DPQK8Py2bpx5r2Q-1; Fri, 26 Apr 2024 05:25:46 -0400
X-MC-Unique: V0Wt-5_DPQK8Py2bpx5r2Q-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5dbddee3694so1440782a12.1
        for <linux-acpi@vger.kernel.org>; Fri, 26 Apr 2024 02:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714123545; x=1714728345;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aI+0tk0N0rfZ0+RaTapxWMbQJR8XZdeH/fzJ04k7BlA=;
        b=qoW48xzn0Kc2aEnJyphfbsx45/2YcUyfFyCqqEYITW6NeuHwSFUoFWuVEbARvAOPm7
         d0uSVXBIwQymdb/xKwffjWPQaDsHAWO6vSOIbC5mDl+kP5AD+IJMdptiN/EPy6y/nwkq
         zKnp4d04tMbUWKdi2cdSgqgt/RcAwj0iCRcjZ83OEcaUwsek5yMAkYpT6Ydp2JGmRiHC
         n16mg+zlXffP6HHs0QYo/hN5GudTwC0aj3fruJBhqH9IxB6aqiMrQBkIpLlpjSpXXf1o
         fIMUFm8S431H9G2K9Y/x/Z7JLB47FSHHUDUk7onmJe9lPi/f/otPuFq59eL8+zw93HaP
         m+Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVc2g6MG0Lzzg70RcqOb9SibnpBsHRomeyErmh94fjWgmBMkTXjKH8ASULe6NQ9mPKI9gWv/g0Aqv8PCCAAgdSkoq3DXw4Ry1gD9g==
X-Gm-Message-State: AOJu0YydCMJR/dFTwspFM9kaqx4z6YRTpZsuTfYwQGDqQLkjy32+Fiex
	FZF1sDA2hlpBTpDZ0HXNYW2x/sUgFrxxiwUILomEzQjLIyE0B0n7FlbYdFAqnVos8Ud6uqyGxmk
	XGdH5HT2Ve9NF10jhm6935CT5LFEOvcIMnoWi3+JLwPpGwFmRM+3CAOMhTYk=
X-Received: by 2002:a17:902:cec3:b0:1ea:482f:f41e with SMTP id d3-20020a170902cec300b001ea482ff41emr9963264plg.15.1714123545332;
        Fri, 26 Apr 2024 02:25:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvlGXSv/tKHY50Dw7+RKb6bmu/jV2eWJbng5XCKDvWXp8D8BnGzOt+jBjaEMTVQZ+CP26+DQ==
X-Received: by 2002:a17:902:cec3:b0:1ea:482f:f41e with SMTP id d3-20020a170902cec300b001ea482ff41emr9963218plg.15.1714123545006;
        Fri, 26 Apr 2024 02:25:45 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id r3-20020a170902be0300b001e27462b988sm15054500pls.61.2024.04.26.02.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 02:25:44 -0700 (PDT)
Message-ID: <0a96abc4-8205-447d-9e7d-03397de5ada8@redhat.com>
Date: Fri, 26 Apr 2024 19:25:36 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/16] ACPI: scan: switch to flags for
 acpi_scan_check_and_detach()
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
 <20240418135412.14730-8-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240418135412.14730-8-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/18/24 23:54, Jonathan Cameron wrote:
> Precursor patch adds the ability to pass a uintptr_t of flags into
> acpi_scan_check_and detach() so that additional flags can be
> added to indicate whether to defer portions of the eject flow.
> The new flag follows in the next patch.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v7: No change
> v6: Based on internal feedback switch to less invasive change
>      to using flags rather than a struct.
> ---
>   drivers/acpi/scan.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


