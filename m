Return-Path: <linux-acpi+bounces-5555-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D3E8B8945
	for <lists+linux-acpi@lfdr.de>; Wed,  1 May 2024 13:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAE0EB227ED
	for <lists+linux-acpi@lfdr.de>; Wed,  1 May 2024 11:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5537FBD3;
	Wed,  1 May 2024 11:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="drxtlTYy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D7A6166E
	for <linux-acpi@vger.kernel.org>; Wed,  1 May 2024 11:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714563145; cv=none; b=r3eM9doqY7ANdwDJXaNZc4nwavC3dt9OQIYkb9lRVlTn1Zqbt8z74pfhaoutWRVouAfuA7JW1xiPtKhTiI1GB+MK3huIt9LtHZVtANkaPkOMXgzr+umUPnnp4/xKqIaF/PvJ4ltLfSSzXJuPmCKgCHwTtyIykO7Xv1RtUy3pm8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714563145; c=relaxed/simple;
	bh=6F3ISMAbsRLy7q+h/9yXAkPtqY1kgaNN+BV2pg4j5gI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gjb3+AMmJhL7Mu7kPALzKbA3NGZAPuQ+8vB5148HNKIiaTIwNqlELqBU/1BtmCBgNVviIZMdKKgpNMBY7vTzW2HTP4s99Tif0aTnDREtPwcf8N8rtPH27OsVdZVDfnE1VGmMS84zS+ODNb3JHqN8s/yeVv7dRwsQEJwysVSmQHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=drxtlTYy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714563142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NvY4677tvfuT/jSAqPXkUvL4xI6+hoEBXpkjqJe2TxE=;
	b=drxtlTYy8YrX81DrwyzVgoqqDJ11JHAqkkRsPvV8O+49Es7ta4Go/K+44QXy5VePjotDLH
	kfLvciMIJh7IHi9OU+JTedHkeSUU9VPL+9VXbY1QULEVBLe8EBMfo+/vHbamHfnorsArE4
	Ef8B8sIL1DHcD/X2JYIxRchx5jfVHMI=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-8WDBjwqyO0mV4U43MbYz-Q-1; Wed, 01 May 2024 07:32:21 -0400
X-MC-Unique: 8WDBjwqyO0mV4U43MbYz-Q-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1ec5ce555f6so13467025ad.2
        for <linux-acpi@vger.kernel.org>; Wed, 01 May 2024 04:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714563140; x=1715167940;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NvY4677tvfuT/jSAqPXkUvL4xI6+hoEBXpkjqJe2TxE=;
        b=jD7b8qtmnjACWwmAuSu5SuGQ3wr69lqCK7FvCPIT38kmQ60ORGY+OLYctLu1d46cKE
         pP6KABBG2+FU2mNIBEOO4qg/4vNRAJ109PcrEMn8WCMcv3jGJvYW4RW+W6mIaCnVZswD
         wbCdoT9ysKGVENYZPLL3wzyTmLrApOiG2HIx5cXC2MenMfguxcKNWAAgqj79/W8OfdzL
         ho8MG9iTKhH6+r4QUI50O2F0wSMTTH+/X2/hId1iDIJYz41r1v/3/GnMGFnJAhG8WHS8
         bSvZtozskJf3BDdq2FjY7jeNXCNC/j5HOd9einhzeB9+G1LuudYG4G95rXVBQHWXFFyX
         byEg==
X-Forwarded-Encrypted: i=1; AJvYcCVqFuUPDRbuvP7k52O2QX1Vhjsjy3i7UDWVnSrEFwwz6JkWEZCOTUrNW/AS2y7iF1ZHfpCj79cSOtienaZ77nnA0JB64Fz/0c8Bxg==
X-Gm-Message-State: AOJu0YwG5cXaLWWDqxqeDlBqfRmUaiv8zvvnYPcMMtA4mRGtqewdeV9L
	zNZPtseIYzrPJnmsfNYisrd8ex7HRkS4WsAdanSIoDfel/x8rKx+XlHfEvOb6vB2zmu9p8wvm/k
	7dD7Vd9HKTEpxxuwC3qgbpSDKn3DI3HTxzSpKCNn86HRGjsaXDyJy9x6aTs0=
X-Received: by 2002:a17:903:22cb:b0:1dd:6ce3:7442 with SMTP id y11-20020a17090322cb00b001dd6ce37442mr2025089plg.39.1714563139918;
        Wed, 01 May 2024 04:32:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHn/GVXiGegFVOAaktJ4SFkKCrfxZSExdPxCeZLOx/YtG8arQj1wuv7wQDNju0KSdPBov9xtA==
X-Received: by 2002:a17:903:22cb:b0:1dd:6ce3:7442 with SMTP id y11-20020a17090322cb00b001dd6ce37442mr2025049plg.39.1714563139450;
        Wed, 01 May 2024 04:32:19 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id j14-20020a170903024e00b001e4753f7715sm23973521plh.12.2024.05.01.04.32.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 04:32:19 -0700 (PDT)
Message-ID: <0f635267-d296-467a-a337-34192c35164b@redhat.com>
Date: Wed, 1 May 2024 21:32:06 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 18/19] arm64: document virtual CPU hotplug's
 expectations
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
 <20240430142434.10471-19-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240430142434.10471-19-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/24 00:24, Jonathan Cameron wrote:
> From: James Morse <james.morse@arm.com>
> 
> Add a description of physical and virtual CPU hotplug, explain the
> differences and elaborate on what is required in ACPI for a working
> virtual hotplug system.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v9: No change
> ---
>   Documentation/arch/arm64/cpu-hotplug.rst | 79 ++++++++++++++++++++++++
>   Documentation/arch/arm64/index.rst       |  1 +
>   2 files changed, 80 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


