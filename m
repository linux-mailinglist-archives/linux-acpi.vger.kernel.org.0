Return-Path: <linux-acpi+bounces-11554-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E31A47E59
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 13:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF7073AEF59
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 12:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D242A22DF99;
	Thu, 27 Feb 2025 12:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="bk5yk4pz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2832F22D7A3
	for <linux-acpi@vger.kernel.org>; Thu, 27 Feb 2025 12:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740661068; cv=none; b=R8Jt20laLerAO2x3YKE6KJx/w/7MgyD51kfNrSwyBwqhoDFM8sdZ6Ix+iwsuUF9aOQW/270so1Nd905L5HZuZ1R/LZKRgglbGvZOxtAxlnT8lyiJwXwP4p0sXVU8r/pGCnZZH9dvVerAfEnXXlRZolxc8M+4ERqGNuYtgHenC/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740661068; c=relaxed/simple;
	bh=+rMrTSbujll9t1goCljjQZX7rGGUeT4ByaL+2IU1WjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iqVMfj2Wshx5sX/b+wVHRaU/nzxyloBGNSccFfBh6Qom2YOrpqDrENyuFrBz1UQp5z9NrqTJnAd7rh0NKucnLiIVvcwYYGNUNNePmiTyvPch0RUQVM09tG6zQK5bR02YcGUqtYSr4LGL8uBW4IZplBztMrfsXXNwQLAXEcVQZb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=bk5yk4pz; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22349dc31bcso14096735ad.3
        for <linux-acpi@vger.kernel.org>; Thu, 27 Feb 2025 04:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1740661066; x=1741265866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pf96MEttABttkon6JyPzDs9JgVTWCcxQW9KTdzVlvqQ=;
        b=bk5yk4pzjXG4HwuYyKM9b/NxZ2LememcHrSb71jaJOO0SyGkGb6dtyW290Yu6O2sT5
         /lEy+/sgau97K7y138QvVduNVqIfTKEn3Ccc0lSz4pUBZuTYghBY9iR/ErAXCVoiVQ9y
         1lEQXhzTY2M0wb7ABM2vs5ACXKHLDUBgi8XUP0Y6Supr85iqym4MbEj1xU+7lu4/d2lC
         +hqMzqb0KPVed+xQZFf2YTE1qIX+MpHB6qUNITLZJ49Vzn9+y6cflbE/1I6YUJluGxPu
         3aQj6D5mk1kcpB0d1xSLjkkA0gnpj087a2PeqaRu2BxhiNmQw1LFK78mWZZW+PMnb2OF
         v2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740661066; x=1741265866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pf96MEttABttkon6JyPzDs9JgVTWCcxQW9KTdzVlvqQ=;
        b=ndonhi4ctM8/+A45u40f3wKMxicrCrtVKxLvyIxemANVWzYFYSYEs8qXiMrherWBf6
         anPa/ixs8y0/1oSCGmlQ1IOsTn7EozGA/OeyUiEziKDcQ2gcT2dxgu0zJHBf8+iBKI6V
         6TjllL7WKUlLGkaIbdmmdOoe/ukLNaFQ5JorBEAlhSsVuMUYNrSQmWFuDInY4bJ2fyDi
         d/8tHojCQAvFQvmvuyArdlsStqqJUnpLYjU+iiqJgRDMr7X+jbuaQcZWU8LSlMCMWhZU
         mWfIwBcGFirNG+l0QEWsdiL5CuSp47YNRmKqf2ytE2mLZEuDSbH2V4hgAqKm9/wNtAP3
         IOQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsHLqFrbBUyOBtu+FtPxUeFNN9bVFl2WsYspEBz7SVV/YtB7spFEh/LtvaQJB9y2NxE3S+o/UU8tF0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/c1KRs1kN0NrtYHYdjtYkmQg/uwmmGC8nv4yYv9uztebC1iKW
	Wa8luySRURx8yOBFjsP/rY+PsK9VQIcvJmeoB4G5zFLlShbNFbxCyLOLF1JhMVs=
X-Gm-Gg: ASbGncsRZ5h+P78uahHIW+eDkJ1rnh+fwgYa7AUx87jDzBLADyvF7mK8+q6p4fy8Z4W
	7wt73pW+Cf4bk4+z7jBZ+2D5gqOiIBekvDRbwCS5+y+bdJ37cochpa64QcFWmPUC1SpltCVdpZs
	K76A6T9MKSAZucqjArJliP9UygXTsNsvf6EJ5k+UkVKBy50GQn1FaWTShrDzLQWqTknN78BvTXh
	LS4UCdcyq+9ptXg80QqziOyq4A6+kBHiy2L84ZvyjWMh9+LHXLu5zpOM1gyTAtCEuWFfH1Y/WMQ
	bjnNrwO9x5sBUSWVwDdhqesjzqNjTSOhj9ZTSjHxskIHMEZXi3AF0VffYBKEP8E1QbItO9Y=
X-Google-Smtp-Source: AGHT+IFx4pIh3JIPBr0kkMiUgEYGJKIIZ775OsAddLWn3ffImcN2wl1+nGQSMf4FINEK1qVgjm20Mw==
X-Received: by 2002:a05:6a21:6d9a:b0:1ee:d6da:b646 with SMTP id adf61e73a8af0-1eef52d935emr44541622637.11.1740661066261;
        Thu, 27 Feb 2025 04:57:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe48865sm1508632b3a.50.2025.02.27.04.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 04:57:45 -0800 (PST)
Message-ID: <cf568ee0-8baf-4701-9e22-0b71792cf329@rivosinc.com>
Date: Thu, 27 Feb 2025 13:57:31 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 02/10] riscv: Define arch_apei_get_mem_attribute
 for RISC-V
To: Himanshu Chauhan <hchauhan@ventanamicro.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
 acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, lenb@kernel.org,
 james.morse@arm.com, tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
 robert.moore@intel.com, sunilvl@ventanamicro.com, apatel@ventanamicro.com
References: <20250227123628.2931490-1-hchauhan@ventanamicro.com>
 <20250227123628.2931490-3-hchauhan@ventanamicro.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20250227123628.2931490-3-hchauhan@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 27/02/2025 13:36, Himanshu Chauhan wrote:
> ghes_map function uses arch_apei_get_mem_attribute to get the
> protection bits for a given physical address. These protection
> bits are then used to map the physical address.
> 
> Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
> ---
>  arch/riscv/include/asm/acpi.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> index 6e13695120bc..0c599452ef48 100644
> --- a/arch/riscv/include/asm/acpi.h
> +++ b/arch/riscv/include/asm/acpi.h
> @@ -27,6 +27,26 @@ extern int acpi_disabled;
>  extern int acpi_noirq;
>  extern int acpi_pci_disabled;
>  
> +#ifdef	CONFIG_ACPI_APEI
> +/*
> + * acpi_disable_cmcff is used in drivers/acpi/apei/hest.c for disabling
> + * IA-32 Architecture Corrected Machine Check (CMC) Firmware-First mode
> + * with a kernel command line parameter "acpi=nocmcoff". But we don't
> + * have this IA-32 specific feature on ARM64, this definition is only

Hi Himanshu

s/ARM/RISC-V

Thanks,

Clément

> + * for compatibility.
> + */
> +#define acpi_disable_cmcff 1
> +static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
> +{
> +	/*
> +	 * Until we have a way to look for EFI memory attributes.
> +	 */
> +	return PAGE_KERNEL;
> +}
> +#else /* CONFIG_ACPI_APEI */
> +#define acpi_disable_cmcff 0
> +#endif /* !CONFIG_ACPI_APEI */
> +
>  static inline void disable_acpi(void)
>  {
>  	acpi_disabled = 1;


