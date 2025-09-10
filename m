Return-Path: <linux-acpi+bounces-16578-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D78FFB517E7
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 15:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85B3A17F6CA
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 13:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363612D77E3;
	Wed, 10 Sep 2025 13:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NzbxX17/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF3F28C5D9
	for <linux-acpi@vger.kernel.org>; Wed, 10 Sep 2025 13:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757510981; cv=none; b=UBk7uLZfaItvpzJMZ85RjGQUCiIlLqWgyqoxgxcKFgSyfgEwYiYlO3paugID//PKD7YoD5eVQKA6Kk7Pt+sxm3HyuMoB08jRkwjUdlmOV9A457YwbA0SGgly0IgKYRkN03+NnS9UO/PmHlC4PpTeAvuG0qFlwIlNvpCurnr1+C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757510981; c=relaxed/simple;
	bh=ummYQlHD+Zi9f47ks9lb05+8D8/hSZq4RnitAF5O7u8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZymurcbgeZNzvnBRQQItdsdDFNjTf1QUo6H5E56pM6etpdgohGRvPpen9vY5hJ/f0Rdld2xJRPRvqi6Gs58lJYOR5hsZsw2aONKrMKq/lmxlXsRO3MmNUI8x9TV+wQi4bfLb4HpX910TY9ao+cyxmCCyA4inUWrSi6if4LMLexo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NzbxX17/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45dec1ae562so23791915e9.1
        for <linux-acpi@vger.kernel.org>; Wed, 10 Sep 2025 06:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757510977; x=1758115777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qlKGaH1d3s0RHZ4omQFOWJ+FEfeUfvKfp8hqseleBdI=;
        b=NzbxX17/5esenJJ7V5bJGlb0yuqpeiXJnnFgS5nLFDyHAsPqFwkmfQVkFZmF9EruyQ
         Cu2EMGGzbUqzYo5dJLjTUklAzVLeLnMRL9wYMu4GI5TebxegS/QzxPBYH49wwjkf5zUZ
         LyxX4EcC3fwp4g3/IBo2v17qXBALIMUYx+svRmNbXJAUEoxFfptYgKZEIKTHMI+YeHVC
         8pc20hZzgO406rgAuuvoYq3vPsrafaW8yz744QOjm2WVQNiX3Xd4DwNNOUjwrUMJwgzG
         aw3ewFWXkWobJEDBGJFunKHALD5t+JbzocfflfF9XS6TkI03xH1heMsFk4hwyl0rA4Qb
         4GoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757510977; x=1758115777;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qlKGaH1d3s0RHZ4omQFOWJ+FEfeUfvKfp8hqseleBdI=;
        b=QqfgxKKfrQk1+B3b+8cii5Nrl1Ijme36IwbtteMpd0ve38dFaDF8dIeG5GUFXzY+7o
         alxS7ZbYyQLZa8QcsmfMwkikQ3Ls39GrUbSsX4KuAQzzm7pGYGTXmBhfM9H47cIlvn2N
         ezh0Yy3DaupNWt950qyfEMFyAZBSG0sKwFS/UxZlmZv4r/2f3QAJ9lzS2EPRxwNeete+
         drASUb0GBA6S61Ap41puxcAblAnXLQy/lrakt1KrDZkxN7GJ2NW3W+KbCwAueYJp8n39
         mbHVsMCVkoQr71ylPHUF2DezZWx8cDatu/sHsKXJrFC8lFiNhbONbCDLhzfePxZsgskZ
         4KSw==
X-Forwarded-Encrypted: i=1; AJvYcCX0SuuHgdhcXQzKmPDSz4+y9k8nuZf8rAY16XERzZeq1zgjzdHUur0MFD+wiYDFNcUQewigfmVNEh5u@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2EPjbVdjPc+4KsxYV9UMCd+mtLhZ3fOemlrQiai+IxzQWGADq
	8XIeKn8yiLYbnP8jivot8L7LW0wsrJrcb5CUF5UK1EIgntKIGUSq4NXeCOSs6DsmCq0=
X-Gm-Gg: ASbGnct5vxZDURRvjXSQs3ZZMiflxanhmox0wWOtCU3EBL8Fu22sJr6ljoCFYpey3iQ
	EIwT9xQw6HoGyNm2cMOe27hVNgBXR4m2QQ3dMiaJaDHaFKEm6IjjabHKoFIlFoL9eTnsT9VL7+0
	jCZ5bSmuASlUm9Wdpy03guxVpqsfiD07mey1j55O6Pq0MiJY+Ne7aIfiOW9YdB4p4fYaC5awNJG
	9iRC5amVj6leP3cP9slqXEmOFJYeTpqH+8dr3j3MnOGjxHo7zeNFzC3RSDjPEQ3Ay0KXvIITXsr
	Ubvqmcyw8ACRwlsy3o1ctXQD0Vxm23N3vFR/NaGS/NHkixXkB8hlhqg/chzOFcrWYiqLKAjXgt6
	g7yACEgkcIzWXhYbAXlmq+ayYQY0TihWcNIn2nHQ0N0aHww==
X-Google-Smtp-Source: AGHT+IGqaolibMl01HDsfx6w/vwOU7QUB/JY1ULsIM13HTYf1eE/9UqxSorRgHaJZ96041ndQjfP8g==
X-Received: by 2002:a05:6000:2389:b0:3b7:9929:871c with SMTP id ffacd0b85a97d-3e642f90df2mr10709983f8f.37.1757510977136;
        Wed, 10 Sep 2025 06:29:37 -0700 (PDT)
Received: from [10.20.0.214] (ivokam.ddns.nbis.net. [109.121.139.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df81fcb04sm28019515e9.8.2025.09.10.06.29.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 06:29:36 -0700 (PDT)
Message-ID: <b669a4a9-ce0e-4906-96c9-689d69a66c23@suse.com>
Date: Wed, 10 Sep 2025 16:29:32 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/15] x86/mce: Separate global and per-CPU quirks
To: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
 Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 Smita.KoralahalliChannabasappa@amd.com, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 linux-acpi@vger.kernel.org
References: <20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.com>
 <20250908-wip-mca-updates-v6-5-eef5d6c74b9c@amd.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20250908-wip-mca-updates-v6-5-eef5d6c74b9c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8.09.25 г. 18:40 ч., Yazen Ghannam wrote:
> Many quirks are global configuration settings and a handful apply to
> each CPU.
> 
> Move the per-CPU quirks to vendor init to execute them on each online
> CPU. Set the global quirks during BSP-only init so they're only executed
> once and early.
> 
> Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Tested-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>


Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

