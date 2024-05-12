Return-Path: <linux-acpi+bounces-5779-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D3A8C3811
	for <lists+linux-acpi@lfdr.de>; Sun, 12 May 2024 21:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10A7C28235F
	for <lists+linux-acpi@lfdr.de>; Sun, 12 May 2024 19:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF904F215;
	Sun, 12 May 2024 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QhMKvUsH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEFA21105
	for <linux-acpi@vger.kernel.org>; Sun, 12 May 2024 19:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715540743; cv=none; b=l6z3aLTuvzIYyalk8rV/RHaqVqPqvKjPTSsRmS8yJEuVKc9HNJdJzQqJZFAClM7YeepuLYFAqePpeQwb1zBeyebFoVlKsiz7xmSlNdA/t0sAIFnCrPgNnGDW6eMAGAldicQxBvWGQ2C+asfcCkvyZ/Gy5lQjW/b/vsSb1oRalkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715540743; c=relaxed/simple;
	bh=pkomJYxvfv/JiLzIcMVCtNIprrxagoRmun3EoHok+P8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WBejUxWMZnkD0qBNI9b40UXeaO/kkAKf/VA3kOybupByX0uAFBh61ugMyugIHwKNt3YUsyZTHv1UCSFNLAsYjB0IVIgn+JIBlHdA26fXfvghshxO+rSXMMwgf7EF432miPByNEZDb3K1WDhu9edfLINbmPjyExSg2iRvyO/YEP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QhMKvUsH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715540739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U2ZvKk0goms3sOklGnb97jJLKtlDNF6jzg0t5gZGpwo=;
	b=QhMKvUsHbGz5pWCA1GScGPHz6gPxOE6UZiENGCCn+zwKrUONpMQGIjAV1YRr3LAvSrXW3p
	JGajFGkpezsQaZYcZNHornUZu+nle/WK5Vzk1dgsnjYAvATfTn0+xlSVgUI0Rx+a7TeyTU
	Cj3jkS8NCuC0lv2JAfn2n4x6ffYfWf8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-LPkTGqWpOgOmNMTiDuXjfg-1; Sun, 12 May 2024 15:05:34 -0400
X-MC-Unique: LPkTGqWpOgOmNMTiDuXjfg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a5a194b34a6so202993266b.3
        for <linux-acpi@vger.kernel.org>; Sun, 12 May 2024 12:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715540733; x=1716145533;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U2ZvKk0goms3sOklGnb97jJLKtlDNF6jzg0t5gZGpwo=;
        b=mV3429rTUYaFDjHDz/sE49FLU6CA6NufDYyVc0py4Tm0+QQxFR4Goqh5Zsk1tz5ZSg
         t82Np3G1PIy6V3fOMPNuJPkbVVfMdRuDDhbbqo2Mhbb0q120gaAGAXQ/9Qu9GG495DSi
         yaFOH85rRv7Bf/pLAxxwXl9cVSou/HGZJU0innYe2BSUl/EmTrxhQXTD2QESlakB0NWq
         vh64OTjQlR4uh9PnbjEpYycBPsPvqIrc5neL4a6IfAW4R5TyaYpu3SDyzoDVwdwCXs6Y
         +/LIj+RgBw1LQayc2mlLakiShJwYInuPLMf/DIrY1BNKSnLbumsvbM6mfvvjhE6Ayftd
         mOew==
X-Gm-Message-State: AOJu0YwfqQCueBvLiIFmZGNTBD0fw5TQ2w43gkIv5QSh+lhxPgxYVr7H
	mRjhQ1ZJxXaFl0RUMxj6GhhV5eSIktPmu6Tdh0mP0jL1+KuK8HmJUfMwQyI/+Hp4QTdvuZA7i+n
	WcPtx1KHEXZK2uhwyR9ogINogdENtfl10PDNKY/CK0gcN3aPmcEQUUuc6W8k=
X-Received: by 2002:a17:906:b7d7:b0:a59:b02a:90e7 with SMTP id a640c23a62f3a-a5a2d6a1708mr592290466b.64.1715540732949;
        Sun, 12 May 2024 12:05:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbenhfTHA/KvUCUg6h3R8WehVM4X/zv74O4qoM8gXL6m4GDTkjKiz7B0Mmx6Hqu19HHA5ruQ==
X-Received: by 2002:a17:906:b7d7:b0:a59:b02a:90e7 with SMTP id a640c23a62f3a-a5a2d6a1708mr592289166b.64.1715540732556;
        Sun, 12 May 2024 12:05:32 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781ce3fsm488215066b.4.2024.05.12.12.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 May 2024 12:05:30 -0700 (PDT)
Message-ID: <c9e4b02d-6e3a-4813-8c87-769944176ff2@redhat.com>
Date: Sun, 12 May 2024 21:05:29 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: x86: Force StorageD3Enable on more products
To: Mario Limonciello <mario.limonciello@amd.com>, rafael@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yilin.Chen@amd.com, Randy.Perez@amd.com, Michael.Chiu@amd.com,
 stable@vger.kernel.org
References: <20240509184502.52480-1-mario.limonciello@amd.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240509184502.52480-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5/9/24 8:45 PM, Mario Limonciello wrote:
> A Rembrandt-based HP thin client is reported to have problems where
> the NVME disk isn't present after resume from s2idle.
> 
> This is because the NVME disk wasn't put into D3 at suspend, and
> that happened because the StorageD3Enable _DSD was missing in the BIOS.
> 
> As AMD's architecture requires that the NVME is in D3 for s2idle, adjust
> the criteria for force_storage_d3 to match *all* Zen SoCs when the FADT
> advertises low power idle support.
> 
> This will ensure that any future products with this BIOS deficiency don't
> need to be added to the allow list of overrides.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Thanks, patch looks good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  drivers/acpi/x86/utils.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index 90c3d2eab9e9..7507a7706898 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -197,16 +197,16 @@ bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *s
>  }
>  
>  /*
> - * AMD systems from Renoir and Lucienne *require* that the NVME controller
> + * AMD systems from Renoir onwards *require* that the NVME controller
>   * is put into D3 over a Modern Standby / suspend-to-idle cycle.
>   *
>   * This is "typically" accomplished using the `StorageD3Enable`
>   * property in the _DSD that is checked via the `acpi_storage_d3` function
> - * but this property was introduced after many of these systems launched
> - * and most OEM systems don't have it in their BIOS.
> + * but some OEM systems still don't have it in their BIOS.
>   *
>   * The Microsoft documentation for StorageD3Enable mentioned that Windows has
> - * a hardcoded allowlist for D3 support, which was used for these platforms.
> + * a hardcoded allowlist for D3 support as well as a registry key to override
> + * the BIOS, which has been used for these cases.
>   *
>   * This allows quirking on Linux in a similar fashion.
>   *
> @@ -219,19 +219,15 @@ bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *s
>   *    https://bugzilla.kernel.org/show_bug.cgi?id=216773
>   *    https://bugzilla.kernel.org/show_bug.cgi?id=217003
>   * 2) On at least one HP system StorageD3Enable is missing on the second NVME
> -      disk in the system.
> + *    disk in the system.
> + * 3) On at least one HP Rembrandt system StorageD3Enable is missing on the only
> + *    NVME device.
>   */
> -static const struct x86_cpu_id storage_d3_cpu_ids[] = {
> -	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 24, NULL),  /* Picasso */
> -	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 96, NULL),	/* Renoir */
> -	X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 104, NULL),	/* Lucienne */
> -	X86_MATCH_VENDOR_FAM_MODEL(AMD, 25, 80, NULL),	/* Cezanne */
> -	{}
> -};
> -
>  bool force_storage_d3(void)
>  {
> -	return x86_match_cpu(storage_d3_cpu_ids);
> +	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
> +		return false;
> +	return acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0;
>  }
>  
>  /*


