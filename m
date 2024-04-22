Return-Path: <linux-acpi+bounces-5222-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEB78AC33B
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Apr 2024 05:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A39C28122A
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Apr 2024 03:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0792101D5;
	Mon, 22 Apr 2024 03:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d70w0kk1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B93FBFC
	for <linux-acpi@vger.kernel.org>; Mon, 22 Apr 2024 03:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713758012; cv=none; b=cmckWMylWwH/q7Niph2HZn/DcSp4X2aw3aVynfVCDSU77P0KaTtGpP0zKoT3M8v3Obpl1SsPC6P4nefVgqOG17YnskfrW8EYCuNNYn9avZX3UQ9w0SkE9lctql2l7UgFvDtuIEOFuufGS3Ba3OMXMMyPddy/o/P3mJS5KOz8Sjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713758012; c=relaxed/simple;
	bh=tD6kiqMKmO+1my/aa9P9n8z6J8qrVBho+qlOdcCPRLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QhVEY9mYVPS0FKTwiUYQYG5j6GlRAE9kFxgtgcRKgX0Lk40BePsKWcy3ri19TRgHLRfWywLTYavDHINdIE1HzwcILMFGXgd0zq6mVXbt1LIrK7EJqzsy2O2f1Jkmz+rYcEtWM/FM/uV2GHdvinMMvkHLcSR6Qtt2+uvyZJgF/Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d70w0kk1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713758010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m0XyZSlHJbiwL8Fk8e6Ao9ghbhjrrj0okROdeEG3PeA=;
	b=d70w0kk19VpTPCBkAaFUGai+6OlJ3t/h4Ad8vX9O3a6ullyACRzb6iU0N+wnHhXZ+SJUcm
	PQkxDtp1A2nOu1NtjQMorTXEDYjVnWbJvwWFWHL1YNHyDsdIQbOrtzFl6ecnjqQa3hQdkB
	DDYh+XdLKWHPkUIlMUcjfaC8nw8aTro=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-3Jk4sNdHMGqa9ceHF_X2lA-1; Sun, 21 Apr 2024 23:53:28 -0400
X-MC-Unique: 3Jk4sNdHMGqa9ceHF_X2lA-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3c5f32f91d4so6035694b6e.2
        for <linux-acpi@vger.kernel.org>; Sun, 21 Apr 2024 20:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713758007; x=1714362807;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m0XyZSlHJbiwL8Fk8e6Ao9ghbhjrrj0okROdeEG3PeA=;
        b=NlbdhtugyAkJC2VhreCunIg8rTtPZ2kmVsMmEw5XkW2d1ZST2drosCbgDp/28eG0lc
         jZrl7KPZAcfgHALJMTdeL8w4nH31OsVFu1LTWYFsFl/LszbFeOpI+egXmreNrRFxpzK8
         ElPt6QyH2Zt6VsmwMEARy/xlCd92oJqJpCozWGKRP0F+dC926MhY3h1pEA4xY+JNdAq4
         iiJrIJh6WMqRkFb7MIG3IhUUkk3OMJBOFtpacka4KXVRT7B3xfIWIaNPmGDjehdhW/fH
         xssQPeKsX6b1593hkC2EN9MngQ62fNlF0aRXRUVSuy16ZKG7hf0WIdzxrGzUBizA55XT
         X59w==
X-Forwarded-Encrypted: i=1; AJvYcCVSEZYOHXYh96IW39e7eupazRIyQPUfo9BLZ4XVuKcuLQXEmps1qJ78ZeuHza2ifkyoqDwa9NMj331+wZgOpk72SsVmVshTqp1DJQ==
X-Gm-Message-State: AOJu0Yy4p6W6VBqvPtKDdjvx71KnDKl+ecX2rLpqdxbcAVLgJrjdssRB
	/QwJDpuPYxTobuMRHtbE2EZCNJVh/EYIUrK0Ph+fDdgrPq/t/09wUdMKyp44wjmxH0GnD35BeOi
	KWcX6Wpyovv6TTVxf0x8UxjAxgdXr/8Q4+rEt2GOE9/pzZrhFDKWuWRF98b8=
X-Received: by 2002:a05:6808:124a:b0:3c7:51f:156c with SMTP id o10-20020a056808124a00b003c7051f156cmr12703900oiv.29.1713758007413;
        Sun, 21 Apr 2024 20:53:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkZ3BNLKQwXsjKmL+OZ/4pqOa0EAKdoGoRtaqIZBDJxdFy4L8f2LFmwwMaKdJQp7E0m+dRqg==
X-Received: by 2002:a05:6808:124a:b0:3c7:51f:156c with SMTP id o10-20020a056808124a00b003c7051f156cmr12703871oiv.29.1713758007141;
        Sun, 21 Apr 2024 20:53:27 -0700 (PDT)
Received: from [192.168.68.51] ([43.252.115.31])
        by smtp.gmail.com with ESMTPSA id lo8-20020a056a003d0800b006ed4823671csm7078329pfb.15.2024.04.21.20.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 20:53:26 -0700 (PDT)
Message-ID: <8c3efa79-53ef-40d1-a701-5c88447c95cb@redhat.com>
Date: Mon, 22 Apr 2024 13:53:16 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/18] cpu: Do not warn on arch_register_cpu()
 returning -EPROBE_DEFER
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-pm@vger.kernel.org,
 loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Miguel Luis <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>,
 Salil Mehta <salil.mehta@huawei.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linuxarm@huawei.com, justin.he@arm.com, jianyong.wu@arm.com
References: <20240412143719.11398-1-Jonathan.Cameron@huawei.com>
 <20240412143719.11398-2-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240412143719.11398-2-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/13/24 00:37, Jonathan Cameron wrote:
> For arm64 the CPU registration cannot complete until the ACPI intepretter
> us up and running so in those cases the arch specific
   ^^

typo: s/us/is

> arch_register_cpu() will return -EPROBE_DEFER at this stage and the
> registration will be attempted later.
> 
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v5: New patch.
>      Note that for now no arch_register_cpu() calls return -EPROBE_DEFER
>      so it has no impact until the arm64 one is added later in this series.
> ---
>   drivers/base/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


