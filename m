Return-Path: <linux-acpi+bounces-4579-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01ED5893885
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Apr 2024 09:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED681C20975
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Apr 2024 07:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5ED9468;
	Mon,  1 Apr 2024 07:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="egK3d1qg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579F38F7A
	for <linux-acpi@vger.kernel.org>; Mon,  1 Apr 2024 07:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711954875; cv=none; b=a69cEW3APhrRNrbhltiSCW+dEemNg4daIhWcDjso4klsRIVmcoO7Cl+4H8oTs7YRJyPVN4/D9EB4fSfDv0PvnoUBnrRcKe30sOBWZxjv6I2LvC7CLxdn/bLo2/lExAK1CpZ60/oQIM7eEGQtmkugpndzml+9SoY70oegiJDee3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711954875; c=relaxed/simple;
	bh=0UxXqbvneBknkvUjHFo+1LfyNPC9qRMw/RiQNbhnucc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ul/nKzaM1BqdSjX820p778deMKhhHWi4AcRYsb6/nRJCuY53Td8ji4ZT7RDb9B+t0fDION+ZoZfVslo/KOvCWbKUct/qwFky/5N95UFbJsVMgVAbnxbvyunU0DzCnf1qgDbehJtKjG9Kd9Do8MfyB53NW0idXqjW92brT/6at+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=egK3d1qg; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bbd6ea06f5so1582825b6e.1
        for <linux-acpi@vger.kernel.org>; Mon, 01 Apr 2024 00:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1711954873; x=1712559673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CR3iwkHe4Np8Vng7wVF9RKBPosLNIp8pBnmcewjQ5aU=;
        b=egK3d1qg4W4lD4JFjbAq+9xx5AxNe4XE4FYQiK9xs7kThX7CJlt+53zfl2w1jpiSgB
         wCjDC+X0oc/rI9qmtrACpQrcllt3LOCQo2XkuCCnq7L9E8BQ9OJyCHJbm0QOxLorJ6TH
         fWt0nLTWVvtHMytpmaJvbuNo15RXQgXekAcwAqkddvFwBVwF9LrPZh13SytEfQv2Emss
         zn3bfybg21YGOh87dab2DZpFongr7rK65dCr0mOYyfJ9nvBIDt+dCNpYiCAQKruKcx9N
         haPaQ+6Vdl5jnC0/thwUEph6pgG8sb/mV9wbwJyJm6jtQGBm5JmxpfXGKHDzyY++zKOP
         BC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711954873; x=1712559673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CR3iwkHe4Np8Vng7wVF9RKBPosLNIp8pBnmcewjQ5aU=;
        b=royMLzbpDKvne580BU6ir2+BuhEDP/S9WX7Q1IfAhymGi5338jhaFzM1nsQEdXflHN
         1XPKptoZnP5XoaX69OxcCwypg9TgrQpyuMGPXH0zfThEf0IEIzeYCz6tnm0JhuaYUz1U
         ron2pJuEgRHIR2n39oZ90t8JgcsXPV+mbtbAw4gUMGUfWPNt8NvMP+Oh6S+iI0cCxxO0
         bZYCbO4NocTH3N7FQEsZfLqR+AoIkXWx7f7dhFW5dtYH16XZ9n9K68iL8gwpJ5J2r2Tr
         0pJiyo/R+zw8kBfMSQqArtEfTOd8GKCn8jP/p/gj6zjrwI2VkqV+OgKVC+k/mcSRgC6x
         AdKQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5KoB+MJBTwfNsykkJtCaRb0apc4G/jWIFqE5R6JTYbE7p72+JUBQlP6f+j8tYC3S/52B1lLalk/U+BWlTvjCGq5i3NIK3E3OQew==
X-Gm-Message-State: AOJu0YxELUunH+KDMZlRMNEsaQreIYCUEcip+hHpGu+IcKqSHdPySPtq
	g6GnJjxmgVF8zm61dYVSGfvUQ4MbKSixdVdO5T8Djm7kYD6+e7KhXgiqRbZ9Rlo=
X-Google-Smtp-Source: AGHT+IHNVXbtf4nFi0CjQtWkGz+KO+8YX+Nli7rw8a7TjQYiIWVV4PVHNMdRC2/hIgsRYyvZbdhOXQ==
X-Received: by 2002:a05:6808:309c:b0:3c3:c157:5dc7 with SMTP id bl28-20020a056808309c00b003c3c1575dc7mr3557976oib.13.1711954873346;
        Mon, 01 Apr 2024 00:01:13 -0700 (PDT)
Received: from sunil-laptop ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id l7-20020a056808020700b003c4dac3b55dsm1018840oie.3.2024.04.01.00.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 00:01:12 -0700 (PDT)
Date: Mon, 1 Apr 2024 12:30:56 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Haibo Xu <haibo1.xu@intel.com>
Cc: xiaobo55x@gmail.com, ajones@ventanamicro.com,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Guo Ren <guoren@kernel.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Anup Patel <apatel@ventanamicro.com>, Zong Li <zong.li@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Jisheng Zhang <jszhang@kernel.org>, Baoquan He <bhe@redhat.com>,
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>, James Morse <james.morse@arm.com>,
	Evan Green <evan@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Tony Luck <tony.luck@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	Yuntao Wang <ytcoode@gmail.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v2 4/6] ACPI: NUMA: Make some NUMA related parse
 functions common
Message-ID: <ZgpbqAraGbQqZv5d@sunil-laptop>
References: <cover.1709780590.git.haibo1.xu@intel.com>
 <c8b86184d9e6d078e9b9949d4837bc6e392c3f52.1709780590.git.haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8b86184d9e6d078e9b9949d4837bc6e392c3f52.1709780590.git.haibo1.xu@intel.com>

On Thu, Mar 07, 2024 at 04:47:56PM +0800, Haibo Xu wrote:
> The acpi_numa_slit_init(), acpi_numa_memory_affinity_init()
> and acpi_parse_cfmws() functions are common enough to be used
> on platforms that support ACPI_NUMA(x86/arm64/loongarch).
> Remove the condition to avoid long defined(CONFIG_ARCH) check
> when new platform(riscv) support was enabled.
> 
> Suggested-by: Sunil V L <sunilvl@ventanamicro.com>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  drivers/acpi/numa/srat.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 1946431c0eef..938c4adb7ec4 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -219,7 +219,6 @@ int __init srat_disabled(void)
>  	return acpi_numa < 0;
>  }
>  
> -#if defined(CONFIG_X86) || defined(CONFIG_ARM64) || defined(CONFIG_LOONGARCH)
>  /*
>   * Callback for SLIT parsing.  pxm_to_node() returns NUMA_NO_NODE for
>   * I/O localities since SRAT does not list them.  I/O localities are
> @@ -351,13 +350,6 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  	(*fake_pxm)++;
>  	return 0;
>  }
> -#else
> -static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
> -				   void *arg, const unsigned long table_end)
> -{
> -	return 0;
> -}
> -#endif /* defined(CONFIG_X86) || defined (CONFIG_ARM64) */
>  
>  static int __init acpi_parse_slit(struct acpi_table_header *table)
>  {
LGTM.
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

