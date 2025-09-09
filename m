Return-Path: <linux-acpi+bounces-16539-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1E4B500EA
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 17:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66E407A7A61
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 15:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D94350824;
	Tue,  9 Sep 2025 15:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X578MZGR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40FF2BB17;
	Tue,  9 Sep 2025 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431259; cv=none; b=hNpFS0jUmjaFroTtw6ltrxDYkM+eUxxZ1B68pyXAHnWyablEdD6WzxFi0Gz26eoTdrVUAdgfDzd1BOGUHq38XXaIHiq0yKo0aKrjutAbS9yu7iBgTVoOBujSieNSLptpVNcvvlXZ70Mov/Wo/iBs4RqMbWwgJUkjuFGBczxk/5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431259; c=relaxed/simple;
	bh=6dE8tTYFfSRz+eND7aMx57+ZIN/66TRTxHDqxR4MiZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rgZGk1HuG7ud4b5PI47/gwOexzDQRyE4I4THqZKfAkVUcwgiJTrYs1KBZzcgGlu/RpG2Kc0g23FwVAaHVAHUmcuVs/HV7E+aomEv3P+uen33ou5/jIJmpSVmveUXc6cdXUIbq2riDTg6wjGiTElAGk9gs+Tpe8vt+j2sbJXegHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X578MZGR; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757431258; x=1788967258;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6dE8tTYFfSRz+eND7aMx57+ZIN/66TRTxHDqxR4MiZ0=;
  b=X578MZGRe3X1cEBsiq4NYUlSE2PCDU8LSUW0OqaqDcwlOHq8MkZpWj5K
   pE1nU+Dlr2sEsEJgLyonC0+e6Ns/AQ6tciTlqLWeiBYfR0lt0rT6GOaNc
   LKLqo+szk9g74/ypsdGFGZZPzO2IcHja3/Xlc7oYTb+Fr7uQJUNDtGa4D
   svnAlqTXaBY8giWyBbr8xiPLOkkKEyeqXgaAvNCCr450kfCV/BVMdNl69
   uWijE7Nv0QiapbrceZ8Dx0YMhq6WQMrmTjKgtyeAjzaSGKRzvJAs1OaSu
   cQo8YopW+JconombNKqOUm+ghLXeKXv47xARxV5FACgJCL2qTrJA73xiV
   Q==;
X-CSE-ConnectionGUID: gvZcuGYaRHyvnSvyPgKyOQ==
X-CSE-MsgGUID: g3MqDzk9SKiaGcL2vtQoSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="62349678"
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="62349678"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 08:20:57 -0700
X-CSE-ConnectionGUID: DLAa/rvFRtiA8JizlwlKHg==
X-CSE-MsgGUID: zwgFx2bqTf2K9B2dseqCNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="177402733"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.110.155]) ([10.125.110.155])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 08:20:55 -0700
Message-ID: <6a4fe054-fbb3-42d1-9b9c-01a502de9edd@intel.com>
Date: Tue, 9 Sep 2025 08:20:54 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/acpi: Rename CFMW coherency restrictions
To: Davidlohr Bueso <dave@stgolabs.net>, rafael.j.wysocki@intel.com
Cc: dan.j.williams@intel.com, jonathan.cameron@huawei.com,
 alejandro.lucero-palau@amd.com, ira.weiny@intel.com,
 alison.schofield@intel.com, a.manzanares@samsung.com,
 linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>
References: <20250908160034.86471-1-dave@stgolabs.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250908160034.86471-1-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/8/25 9:00 AM, Davidlohr Bueso wrote:
> ACPICA commit 710745713ad3a2543dbfb70e84764f31f0e46bdc
> 
> This has been renamed in more recent CXL specs, as
> type3 (memory expanders) can also use HDM-DB for
> device coherent memory.
> 
> Link: https://github.com/acpica/acpica/commit/710745713ad3a2543dbfb70e84764f31f0e46bdc
> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Applied to cxl/next
58b3de3bf52315f3b30075fd2b077ec8d2c4f0ca

> ---
>  drivers/cxl/acpi.c           |  4 ++--
>  include/acpi/actbl1.h        |  4 ++--
>  tools/testing/cxl/test/cxl.c | 18 +++++++++---------
>  3 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 26c494704437..2cf75b553f26 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -128,9 +128,9 @@ static unsigned long cfmws_to_decoder_flags(int restrictions)
>  {
>  	unsigned long flags = CXL_DECODER_F_ENABLE;
>  
> -	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE2)
> +	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_DEVMEM)
>  		flags |= CXL_DECODER_F_TYPE2;
> -	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE3)
> +	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM)
>  		flags |= CXL_DECODER_F_TYPE3;
>  	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE)
>  		flags |= CXL_DECODER_F_RAM;
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 99fd1588ff38..eb787dfbd2fa 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -560,8 +560,8 @@ struct acpi_cedt_cfmws_target_element {
>  
>  /* Values for Restrictions field above */
>  
> -#define ACPI_CEDT_CFMWS_RESTRICT_TYPE2      (1)
> -#define ACPI_CEDT_CFMWS_RESTRICT_TYPE3      (1<<1)
> +#define ACPI_CEDT_CFMWS_RESTRICT_DEVMEM      (1)
> +#define ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM (1<<1)
>  #define ACPI_CEDT_CFMWS_RESTRICT_VOLATILE   (1<<2)
>  #define ACPI_CEDT_CFMWS_RESTRICT_PMEM       (1<<3)
>  #define ACPI_CEDT_CFMWS_RESTRICT_FIXED      (1<<4)
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 6a25cca5636f..ba50338f8ada 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -210,7 +210,7 @@ static struct {
>  			},
>  			.interleave_ways = 0,
>  			.granularity = 4,
> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
>  			.qtg_id = FAKE_QTG_ID,
>  			.window_size = SZ_256M * 4UL,
> @@ -225,7 +225,7 @@ static struct {
>  			},
>  			.interleave_ways = 1,
>  			.granularity = 4,
> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
>  			.qtg_id = FAKE_QTG_ID,
>  			.window_size = SZ_256M * 8UL,
> @@ -240,7 +240,7 @@ static struct {
>  			},
>  			.interleave_ways = 0,
>  			.granularity = 4,
> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>  			.qtg_id = FAKE_QTG_ID,
>  			.window_size = SZ_256M * 4UL,
> @@ -255,7 +255,7 @@ static struct {
>  			},
>  			.interleave_ways = 1,
>  			.granularity = 4,
> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>  			.qtg_id = FAKE_QTG_ID,
>  			.window_size = SZ_256M * 8UL,
> @@ -270,7 +270,7 @@ static struct {
>  			},
>  			.interleave_ways = 0,
>  			.granularity = 4,
> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>  			.qtg_id = FAKE_QTG_ID,
>  			.window_size = SZ_256M * 4UL,
> @@ -285,7 +285,7 @@ static struct {
>  			},
>  			.interleave_ways = 0,
>  			.granularity = 4,
> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
>  			.qtg_id = FAKE_QTG_ID,
>  			.window_size = SZ_256M,
> @@ -302,7 +302,7 @@ static struct {
>  			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
>  			.interleave_ways = 0,
>  			.granularity = 4,
> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>  			.qtg_id = FAKE_QTG_ID,
>  			.window_size = SZ_256M * 8UL,
> @@ -318,7 +318,7 @@ static struct {
>  			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
>  			.interleave_ways = 1,
>  			.granularity = 0,
> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>  			.qtg_id = FAKE_QTG_ID,
>  			.window_size = SZ_256M * 8UL,
> @@ -334,7 +334,7 @@ static struct {
>  			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
>  			.interleave_ways = 8,
>  			.granularity = 1,
> -			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
> +			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>  			.qtg_id = FAKE_QTG_ID,
>  			.window_size = SZ_512M * 6UL,


