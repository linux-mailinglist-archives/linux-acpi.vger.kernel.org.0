Return-Path: <linux-acpi+bounces-5553-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB548B8911
	for <lists+linux-acpi@lfdr.de>; Wed,  1 May 2024 13:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDBAE1F219BA
	for <lists+linux-acpi@lfdr.de>; Wed,  1 May 2024 11:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCBC6518F;
	Wed,  1 May 2024 11:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mn1S7oKr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF8B5EE80
	for <linux-acpi@vger.kernel.org>; Wed,  1 May 2024 11:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714562045; cv=none; b=tOVD7QZ+spDDVvRb5sFAgUfuyd/ngx+U2KrZ1J1WSjcwPACn5aIql7BvhK2ILRoECpRU0wmTToOXraeoHFBuwIPHqRaLhw02VekXP9ovmoMkKNx+e5p5e+Bu7dJ4Xyes7k6T9zQXGcJxjd1R6QJgc4f0E9tcc1k8uBC9fruhiZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714562045; c=relaxed/simple;
	bh=Gn2C+fSEj9oEgEcKRZTFnYTq392nKVc8ox1XVnAtZ4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ufOJ7eAyYUgIMf7LgwP6M0oMe6j/AOeJCOQjNuzQQsZnkE/CVd3TwtUTZXE6Tl4IDkzD6Pqi4f55H37fCxOO1eogZuovf2nKDvhXHtx4iB3jxKuyJYeQe3LHrX4RuDbvY6kiVoBMSVsI2nC6ZjxoLC341qy+PEFXv9332V+pxT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mn1S7oKr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714562041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=klJb2Hbg7SNB5TUedK1etVELNa99mZOeY3ik6uIdHp8=;
	b=Mn1S7oKr/1xzktHLy1feMGlyjOkRxjBHkbV8MQXb4EvF6OtL5hgHewni6Ei1annBH/RYWL
	v8sWCCYD9AHet1z6eZ71uc2H9MKnpSnUbzW4ApjgJqv5cH6JCur3gI422Bc8kdtR9/wMvO
	OCSep325u677seCinRpdBzWHMmo8WMQ=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-wVO5dPjFNz220_MGIxt2-Q-1; Wed, 01 May 2024 07:13:59 -0400
X-MC-Unique: wVO5dPjFNz220_MGIxt2-Q-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-604dea821d3so5719538a12.1
        for <linux-acpi@vger.kernel.org>; Wed, 01 May 2024 04:13:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714562038; x=1715166838;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=klJb2Hbg7SNB5TUedK1etVELNa99mZOeY3ik6uIdHp8=;
        b=V/xUjmPaepsZAGW1MC9500+2hDe8kjwsk5+ecWGMijtR+5Ii3s/YjQcz1maklq7kNz
         XUTukTg5mbnwWdR+gev+1dMZ19g6w3q9mJAnKQ+AL+zP8X8k4n6fUrqaaKy9okDzkq+h
         rND9cfVFeZQOnVvH44Q4UkpcDTZRIZkgBTT7uO5jZRMwXLuWQA0hQWVnWR+qupPHWbk1
         fGnZoVVWTC51xwkUc4t1+TuIuDvY5MSJDG4yhC6f+2BsJW54RgN3i/Xe5YTtXbZuFQPx
         GPbp4Sa4l9F+Tpb3auGjRTCjAiAI36SNcKKQSImmBTx/urEDL7kGc+sXEV9qzL+d0TYU
         zpuA==
X-Forwarded-Encrypted: i=1; AJvYcCWYb6yaEtY2z8kHj2hbrD3T9isJNvcMFwuZSMvJBW94joELyxQsElUcgHVJWF9eKsC3vywsN61nj9lG3fBkhaaPgTMHcqMn94wgUQ==
X-Gm-Message-State: AOJu0Yyt4uw3YMoiy5bcxo29NIygzK89v5CAVSt8V6h+ahF6Kiu6bOnI
	9/Xgx9E+OCd0Q+c/dANIKUxHCK3gFLwhej4F1MOrjaNqu7KceHvazf3uH1xJ0YZcVODEwasD2cg
	QkccUoXAc1TlJCZZpprtNXuJsK+2y3U+n0JQdvGVsUPcYI0T6oS79B2pXSzo=
X-Received: by 2002:a05:6a20:551d:b0:1ad:9413:d5c3 with SMTP id ko29-20020a056a20551d00b001ad9413d5c3mr1712258pzb.17.1714562037863;
        Wed, 01 May 2024 04:13:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHk8RZbujTlZAxMHP0HYG36OV8O8L5/EuxcrJRH9h3TeGMjvsyX78a8rPdkWjXbbD+MV6exNg==
X-Received: by 2002:a05:6a20:551d:b0:1ad:9413:d5c3 with SMTP id ko29-20020a056a20551d00b001ad9413d5c3mr1712231pzb.17.1714562037414;
        Wed, 01 May 2024 04:13:57 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id h9-20020a17090a050900b002a55198259fsm3245338pjh.0.2024.05.01.04.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 04:13:56 -0700 (PDT)
Message-ID: <114fcd7e-33e3-4741-936f-21b0576c59e4@redhat.com>
Date: Wed, 1 May 2024 21:13:46 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 17/19] arm64: Kconfig: Enable hotplug CPU on arm64 if
 ACPI_PROCESSOR is enabled.
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
 <20240430142434.10471-18-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240430142434.10471-18-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/24 00:24, Jonathan Cameron wrote:
> In order to move arch_register_cpu() to be called via the same path
> for initially present CPUs described by ACPI and hotplugged CPUs
> ACPI_HOTPLUG_CPU needs to be enabled.
> 
> The protection against invalid IDs in acpi_map_cpu() is needed as
> at least one production BIOS is in the wild which reports entries
> in DSDT (with no _STA method, so assumed enabled and present)
> that don't match MADT.
> 
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> V9: No change.
> 
> ---
>   arch/arm64/Kconfig       |  1 +
>   arch/arm64/kernel/acpi.c | 22 ++++++++++++++++++++++
>   2 files changed, 23 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


