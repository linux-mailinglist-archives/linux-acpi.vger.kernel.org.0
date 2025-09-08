Return-Path: <linux-acpi+bounces-16510-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B017B49B29
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 22:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC8064E3CC3
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 20:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6F52D4B5A;
	Mon,  8 Sep 2025 20:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g9EMn6uL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E2A1C863B;
	Mon,  8 Sep 2025 20:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757364175; cv=none; b=bN7Qcvkzkh1pf6t49mHO97VUJxUw1Q6LoseYIHB8GUwa+sZhQmH44akJygp+MLSlFKFEhlSWwrkwMSFY6Mn97wBgORbOpGd+ek4qkH434lwTk/3hPm+SS6eilL6mUjwaRkyIhAPNNUqviBRAqkYOyroa2Jat0KzybsnNrD/Lh50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757364175; c=relaxed/simple;
	bh=JY3EMgyH0fhIQk4c8zaI/9MVdKtSrKHC2bX7J7U9MF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vabz1dE2BW7eayAiiDpiLVbliv09rujW06Gd28TUcWhq2ULNoyI9OMOjPI7SqyodF/AnXJPtfArE7K/N/6qLp3+T4WrQl4REzBdKpdosGI+v+pEvEN875CNJe76DI2kV7cGXnC6eF5ND8haUUeiVgOAMI+9P3z8SWstCXisjptU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g9EMn6uL; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757364173; x=1788900173;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JY3EMgyH0fhIQk4c8zaI/9MVdKtSrKHC2bX7J7U9MF4=;
  b=g9EMn6uL2c1UwOzh9x3qBTBh4b84088fJJxDO6AP/xJavJ9tnm/xOsv+
   SHyGIIETybTqb6EuuMLUgbCN53D5lfIFMEfZC69s/8IE8u5IRR9Q79TXJ
   XdnfmWPWh6/Fj/vPoZXlb868Ds/KKm0gkrRTvOHcb182xBfVZ+jTtUtDT
   jET9O8HG7NbXA1XmBfeJOQsTBPpFE+oEhQ4BYROpKlNQMgCW1KiiitYY3
   n8p9JjbTxSOURtm6pMraUb558csmBkxNSGjTfelnwZ+yatlrBtRbu5Ugg
   cIctf25xspWVKUcGUCVj/hqwskOkiWf2T9m2dVyVIXZgU0k8TF3S36u3h
   A==;
X-CSE-ConnectionGUID: Lsp+fXT3SbO9q1dYOlekSg==
X-CSE-MsgGUID: i1Cr0vzSSgWygaRMWVlhCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="63276546"
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="63276546"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 13:42:52 -0700
X-CSE-ConnectionGUID: xDdTXpQ4TFieBaTwCROrsg==
X-CSE-MsgGUID: AakUd3bjSx60Xl63Mxcc6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="173256764"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.110.113]) ([10.125.110.113])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 13:42:51 -0700
Message-ID: <fee4cf88-3101-4b0d-88f0-fb5a632f83c9@intel.com>
Date: Mon, 8 Sep 2025 13:42:49 -0700
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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
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


