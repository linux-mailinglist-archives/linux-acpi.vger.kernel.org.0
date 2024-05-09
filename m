Return-Path: <linux-acpi+bounces-5676-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A03858C0A58
	for <lists+linux-acpi@lfdr.de>; Thu,  9 May 2024 06:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CA912826B9
	for <lists+linux-acpi@lfdr.de>; Thu,  9 May 2024 04:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF591482F1;
	Thu,  9 May 2024 04:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="imqr+ZwP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2628E26AE0
	for <linux-acpi@vger.kernel.org>; Thu,  9 May 2024 04:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715227786; cv=none; b=qDVaJx0hovHKIUt3hutbMGtdE5E2qQX9YWezrG78EeKw17rhJ+tJOW4Lu/x7iQUSoGU3PQifow4hFTelQckDFiHuAcJQ7BMYBPIKPXRIMgT7i7tB3vV5xO8VJBkPRrkn7CFidWRl8c7F5lI20vfLNlrq3SsGB/9BPWT1VJby9F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715227786; c=relaxed/simple;
	bh=23vCA1XKs+nRdjU1pvcA/EBdpT4zwEbG7+QpaozbrTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfSAINjNfHOzelVr7dKCiOdn/c69NPc/ovDDXDCMjplSKb1u4Xs6OoOgujSIhNFnOr6SZP06Egpcvgmbw9f+DZBjDoZS1qAwBLp/B6g6dADPSzDRMao3htLr+XoRgPXnpi7pPB5NklyqOB6qCmTUxj7silQM8iyzDFztuDDHoPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=imqr+ZwP; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5aa28cde736so257798eaf.1
        for <linux-acpi@vger.kernel.org>; Wed, 08 May 2024 21:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1715227783; x=1715832583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9sruuI+Av6fzoUWEPO1CK46vHbYhEGu93ccm0253NU=;
        b=imqr+ZwPGLv/6rXFy6q1dYONo6UN0plgd+k6rhDs9cWFQn/9EHDh0YpCu79ABSx7Rp
         8wDsol/x35erWf0PQLvL5i3CyNHlsOcjZ19kucCBXw7KeT2YR+DFzfUzvkrYhBCUsuVS
         TRGcTgi4ZItun3EoiZBApAwV4lraVKjKTfBJIVXQJGXg4lih7nsITigaNNcpTqS0n3LY
         fRWzPETqKApmlKKPVM0Z14sKTA769bPez5qm7cfCtJEkdtW8m3OBAsuI7kg3bQgjVjwg
         rO00ZNemshBE2bkyoUicxXXLCXmA5/Y8LXQvU1lJqvt50swSmDkmpvfgHQubnvUQQDPf
         wR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715227783; x=1715832583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9sruuI+Av6fzoUWEPO1CK46vHbYhEGu93ccm0253NU=;
        b=I0KU2l+gIKEmo9wuI3Zcgt6NJN9YzfmZd6ySVV4GKgaz5N84h1/CBpkjOqZqHWFx3U
         fSOpCTepcUee0XoH/BQfHutCbFmxn5cEJuJb5ioNn9kCap3RGz9bWjTH9RDo1uSLw9dB
         ovWdkemdPVYivWh+Jhhu8TMEFlByQnzyXY3LOmnuwBC+Jfu9j3VITNd1PuPQYHyuA/Nl
         in/vipbK/LpEjo7f24uIqj90xHjHKEk6R5fEIo6Mt0JzBFsKmCyb83GPxdL4dXPRYIWD
         vNlS4HAsXJTRsQZoV/bZ1zom71j6KsvvZYwummuiMtwShL+BrJJIGNZaQpGANex18Qhh
         GTdw==
X-Forwarded-Encrypted: i=1; AJvYcCWSmm4evqzQ1vzp35u58/40RswVQFmTKxTxAL7U+ZZnICBUHhzKKu+TgS08+/hlg+oo/lFeZKCtmZ1XeUT0coKdqxSOe9SAgy1s8w==
X-Gm-Message-State: AOJu0YzOtNtdbbC2fTCUp7o3QPguTv3xhFTQyX4f6tHzRVo5IQ7CI+Cv
	RomeWGMu6XofkzXTqJcjMMVQVoX6V8R2s73opapoyk+7h+VsiwOWYCd7tHyHEbU=
X-Google-Smtp-Source: AGHT+IHnfdRkD37024/1NkpgcVLNuDSAm5SAjj46xEeBcOG4M0xTGOaXer2jGvjhTifAxtxNdttDAg==
X-Received: by 2002:a05:6358:c90:b0:18d:9d6a:e484 with SMTP id e5c5f4694b2df-192d290f02emr675633955d.6.1715227783188;
        Wed, 08 May 2024 21:09:43 -0700 (PDT)
Received: from sunil-laptop ([106.51.188.31])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340b767b36sm343814a12.32.2024.05.08.21.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 21:09:42 -0700 (PDT)
Date: Thu, 9 May 2024 09:39:33 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org, bhelgaas@google.com,
	james.morse@arm.com, jhugo@codeaurora.org, jeremy.linton@arm.com,
	john.garry@huawei.com, Jonathan.Cameron@huawei.com,
	pierre.gondois@arm.com, sudeep.holla@arm.com, tiantao6@huawei.com
Subject: Re: [PATCH v4 2/3] riscv: cacheinfo: initialize cacheinfo's level
 and type from ACPI PPTT
Message-ID: <ZjxMfQOqc8ML8nrD@sunil-laptop>
References: <20240418034330.84721-1-cuiyunhui@bytedance.com>
 <20240418034330.84721-2-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418034330.84721-2-cuiyunhui@bytedance.com>

On Thu, Apr 18, 2024 at 11:43:29AM +0800, Yunhui Cui wrote:
> Before cacheinfo can be built correctly, we need to initialize level
> and type. Since RSIC-V currently does not have a register group that

NIT: Typo RISC-V

> describes cache-related attributes like ARM64, we cannot obtain them
> directly, so now we obtain cache leaves from the ACPI PPTT table
> (acpi_get_cache_info()) and set the cache type through split_levels.
> 
> Suggested-by: Jeremy Linton <jeremy.linton@arm.com>
> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  arch/riscv/kernel/cacheinfo.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
> index 30a6878287ad..e47a1e6bd3fe 100644
> --- a/arch/riscv/kernel/cacheinfo.c
> +++ b/arch/riscv/kernel/cacheinfo.c
> @@ -6,6 +6,7 @@
>  #include <linux/cpu.h>
>  #include <linux/of.h>
>  #include <asm/cacheinfo.h>
> +#include <linux/acpi.h>
>  
Can this be added in the order? Like, include acpi.h prior to cpu.h?

>  static struct riscv_cacheinfo_ops *rv_cache_ops;
>  
> @@ -78,6 +79,27 @@ int populate_cache_leaves(unsigned int cpu)
>  	struct device_node *prev = NULL;
>  	int levels = 1, level = 1;
>  
> +	if (!acpi_disabled) {
> +		int ret, fw_levels, split_levels;
> +
> +		ret = acpi_get_cache_info(cpu, &fw_levels, &split_levels);
> +		if (ret)
> +			return ret;
> +
> +		BUG_ON((split_levels > fw_levels) ||
> +		       (split_levels + fw_levels > this_cpu_ci->num_leaves));
> +
> +		for (; level <= this_cpu_ci->num_levels; level++) {
> +			if (level <= split_levels) {
> +				ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
> +				ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
> +			} else {
> +				ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
> +			}
> +		}
> +		return 0;
> +	}
> +
Other than above nits, it looks good to me. Thanks for the patch!

Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

