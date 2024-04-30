Return-Path: <linux-acpi+bounces-5477-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CB88B6977
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Apr 2024 06:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CEB2B21752
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Apr 2024 04:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D00511702;
	Tue, 30 Apr 2024 04:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mqr2oR39"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50A9205E0D
	for <linux-acpi@vger.kernel.org>; Tue, 30 Apr 2024 04:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714451500; cv=none; b=m0Fc0XwjWwFgw4e8qqSBy/LD/qIz81GP9S6kx/NZoHGjLi+mR/6QJCkwaLmlFQgZBtvYHNzCT39fYY6wNcPrykrIBKcFd4e2tejqMSSHxJpQjeG2faZt0NvTB1YbNEWsswFWUYeQevBMzq9KbZr99yxfEpCstxQLPpMRn90Pb/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714451500; c=relaxed/simple;
	bh=29uhAEoT45o4FIk7bCIeul9Jn+bmCAUKhTM2KMG4H2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tTv0gzSnpW8ff0flFQThTTUH4hwh7kEDU6n11kZNBK/Cuqy4vAysKk85She2BySu0RK2O6uiq/GobaswT2t/oCP1Rqz4WNix/fV2FUWnHZtFM7dWtvysCJ0Cd7IzPOFGlgyVB6Kxgg6cmHGr/GL25uXJsATCRZrNOAmEW0NvPPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mqr2oR39; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714451497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i13MtWkwJ9CzG5rHobsEqX+W2OhJEVkbAyH/jjvfJXM=;
	b=Mqr2oR39wqqAi08Vf/0O+YM8pAZlztNIwpQ9BZ9q8HZJk+AdBajMTET6AJlord1j8/7S+Q
	S7IonXP6Wk3fgFApeWxSOa4W7niuWOtEpIq+vtrKj9QWj7xjAevCVQuyYycgm7cRzJfjb6
	Cw9I7aS5GA/QFaRlPtidM3zDEAvPuyg=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-kuxJqVr6M_uO4Uh6qgCMtw-1; Tue, 30 Apr 2024 00:31:35 -0400
X-MC-Unique: kuxJqVr6M_uO4Uh6qgCMtw-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1eab16ca864so58944595ad.2
        for <linux-acpi@vger.kernel.org>; Mon, 29 Apr 2024 21:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714451494; x=1715056294;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i13MtWkwJ9CzG5rHobsEqX+W2OhJEVkbAyH/jjvfJXM=;
        b=Mr7CzSsUObA16IK9F4Yejn9Wdvdn6F4jG+B03L2Pvdpyu1LMrRF8OEM5unbxdwcfPT
         CJcSwe3b3NA9Rk0pFBeZJ7P0RJZ69Its22TmoxQZ2nKvLqSYWYnrVYeU0DXCuB77+l2x
         7xs7BkiDsbZKCOCz8xDzAaOrkaaL7TWG6P/kTVuYXUzKf/BcM3ziYdE64KMfSBC2rCAU
         eNJJj+mMD4RP63taS6btedn4jq3lhGfwVnOO5ZL96/Hxdi2GdhLt/Rld4Q/ZuUFaRUw0
         /5PM1rig4fpYrsliOAcsKLw43GVTaB7oHBxHJQFtbKSQG9Aqc2yL46XzNnTjKz93bqud
         tH6A==
X-Forwarded-Encrypted: i=1; AJvYcCWB9eIjGN/d2MgL9QCPJotPqyzmUsMosOzZSBBBzn5CQ/SnmUpea/xgzZLX57waJBeTGaIl1AX3ltIkLHBkrWpIh3kJPRvdy/DKhA==
X-Gm-Message-State: AOJu0Yzluiu1uim6+5w8yH35oBivBMDDcOehvG6na/Kd391fqHn3r0xe
	iWlclzUBalLNnjSrN2MPSiDY2wCGyCsXUteIxYgcCXoo0cyLhY+Ve8oX7F8lmLP4yqlhIsLYLOl
	CXmsRQyfHCjDOWQrvNJO4yD2v+EHOMBeBdrC/jYKJ39IXzetZTaMiJF9DBhA=
X-Received: by 2002:a17:902:d2c8:b0:1e4:4000:a576 with SMTP id n8-20020a170902d2c800b001e44000a576mr14606362plc.43.1714451494081;
        Mon, 29 Apr 2024 21:31:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAw003t6HOSoCLpW/XUCLqCM5arMxu8YIqu/zbz1Hwe4t+r/fC177o/TfutrGEBjD75Dh+aQ==
X-Received: by 2002:a17:902:d2c8:b0:1e4:4000:a576 with SMTP id n8-20020a170902d2c800b001e44000a576mr14606349plc.43.1714451493684;
        Mon, 29 Apr 2024 21:31:33 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id jv12-20020a170903058c00b001eab3baad5dsm8939394plb.4.2024.04.29.21.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 21:31:33 -0700 (PDT)
Message-ID: <fb40d212-2f70-46b3-8045-1f4d40df3f6d@redhat.com>
Date: Tue, 30 Apr 2024 14:31:22 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 13/16] arm64: arch_register_cpu() variant to check if
 an ACPI handle is now available.
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
 <20240426135126.12802-14-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240426135126.12802-14-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/26/24 23:51, Jonathan Cameron wrote:
> The ARM64 architecture does not support physical CPU HP today.
> To avoid any possibility of a bug against such an architecture if defined
> in future, check for the physical CPU HP case (not present) and
> return an error on any such attempt.
> 
> On ARM64 virtual CPU Hotplug relies on the status value that can be
> queried via the AML method _STA for the CPU object.
> 
> There are two conditions in which the CPU can be registered.
> 1) ACPI disabled.
> 2) ACPI enabled and the acpi_handle is available.
>     _STA evaluates to the CPU is both enabled and present.
>     (Note that in absence of the _STA method they are always in this
>      state).
> 
> If neither of these conditions is met the CPU is not 'yet' ready
> to be used and -EPROBE_DEFER is returned.
> 
> Success occurs in the early attempt to register the CPUs if we
> are booting with DT (no concept yet of vCPU HP) if not it succeeds
> for already enabled CPUs when the ACPI Processor driver attaches to
> them.  Finally it may succeed via the CPU Hotplug code indicating that
> the CPU is now enabled.
> 
> For ACPI if CONFIG_ACPI_PROCESSOR the only path to get to
> arch_register_cpu() with that handle set is via
> acpi_processor_hot_add_init() which is only called from an ACPI bus
> scan in which _STA has already been queried there is no need to
> repeat it here. Add a comment to remind us of this in the future.
> 
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> V8: No change. (tags collected only)
> ---
>   arch/arm64/kernel/smp.c | 53 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 53 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


