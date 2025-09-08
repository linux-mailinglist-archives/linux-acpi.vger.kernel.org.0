Return-Path: <linux-acpi+bounces-16514-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B84B49C44
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 23:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E125A188FFC3
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 21:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651B62E1C7A;
	Mon,  8 Sep 2025 21:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Vh0pxMpP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BDB2673A5
	for <linux-acpi@vger.kernel.org>; Mon,  8 Sep 2025 21:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367488; cv=none; b=OL36G580jX/+pSH7Pz+3GyvShCd/Rb/JTkeiFhlkfL4Yij/5xkdiIPPhqRftJnvHQlPmDDtKhHwafK513zj728DUk4W50JeECfgXclpxnv295w3oY4DXOaKBtD0wlhvKL36jDJE3ZRQsT8hiXmeIjzfGYiJiyK6ju9g+pHpISeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367488; c=relaxed/simple;
	bh=sGKAUSPWt72301AlV1XawXJ3CDU4bmDDcpLUoU+28l4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIUT/RaN5KaBcV4vxPJdZ9hu8NA5IhzDdkfsabonbdCaaLjTKMJ7tu50Ykjmmu3fyOSypXtDmWMdPGFzWoJJxqZ50oR3vaInnJoNRGOyhCD8YgtEyzI062WayZVYN7RsRDqOXfK9xx3kg9R9VRhyRMSBi/zSeEkOL7d/KN296iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Vh0pxMpP; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-80e3612e1a7so615916085a.0
        for <linux-acpi@vger.kernel.org>; Mon, 08 Sep 2025 14:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1757367485; x=1757972285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NtWqIRzbFovdcSLeep8mjuBoNwQeZf18KQ3SwdIPUDE=;
        b=Vh0pxMpP9cid/A5EtkxHj+Iii/llPJEjGsr7LVeNKO3UCU3jJB835m0RWCAVqDKFIM
         wd6oP2aWsKSuC8Y9ZyKjeVRxLlc4MSbW45zUtP3fQ0Jx+83JIBACtqLIYb7oC84w1poc
         Km6B7BbjJyEzoc+54ancWEoAeg8tfucaGsJb8vpbEBo4ye4qwjsbf336ocbhO2QQRqR3
         0lmfOS/+ERPmaShUEVapWj/epoxALYa7qtMNguaObmsupDTLrSuvTEaSM6FZxmy7FabJ
         crloxkg5SgUr41wl72O6XztRgzewNSOeiaWMQl0uEIns4gePL9+EpLpc1CHk4zc0dqPI
         +5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757367485; x=1757972285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtWqIRzbFovdcSLeep8mjuBoNwQeZf18KQ3SwdIPUDE=;
        b=VQctoApCpXxY+rCIvQ70LAdIdo+1DLwI4v7Rj6C97YS0ka3uhvO2XAzfJYF7lKAnQ0
         CbsJUeXnSBoR3beGdVkdxnQ+NEuqmKVwaKg96qxkuJxyQmatUE+nsroGrSu6BDroz2+Y
         df4jAOGYNK0vjxq/Kf+S9CdjFS9DYXjv1I9FH2U6nXssft5VfBtrdLRpFx0oXE4C4anf
         MxfEd7kXqpPA9cb4X10duk8Q5nBVUGxCcntuTlSyB2s3GyDOadeNdSWQz5dSMbFx0DrR
         eGR+gNFmleU2M0qM0we0ecoMc6XIuo2B0BlTJlGtoKd4kVg+yVws87hjAmpYM8FJzKHV
         LN4Q==
X-Forwarded-Encrypted: i=1; AJvYcCX++V4hyu4U8MclRJV8ir9i6IGpF3w8mhJDXMD0LdBLy1I7Z5BqGoUJLk7A5YAkNoc1peQjgD2Kx4vR@vger.kernel.org
X-Gm-Message-State: AOJu0YxXHwM1bB4GfK2AmHtJRXBeGTVGqkdqr5BkOgesrXI7rRtAcIkJ
	NXwtzZr/kMmK2/YIk0CAU+xX8tvUGrD6RXvfChjffKA3FtDVPfTCBbaesWlJJ7JsFh4=
X-Gm-Gg: ASbGncvCdQTmgHQJMV1aj3jSYjvjauj/g2cJoNxIfEZdgwLNi6vS1S6pxjqXFRGZC/g
	mtMx6/38/j6EJEqxYMrZBFvRx9fYcb6uZWNWbA6U7Tiz+sCQ70r4yONJ2qvrMs+KEoJJDNvD9Z1
	tUe3VRDtZneVkClKYvf9WubV305n/8UX9mJdj3NjgVeOJThsb61ZDF21ltYIbnq0Og2JS1GI+1I
	BlRYYKmVrEmvUJTuSVdAPtsOWLxl9Kv/88+RoKZAFloZ18QF+0IZGIeK8QIzD6HQyZ+DvCewdxD
	77FPNGvsY1KunjIs4h69e59cQyDwJfQuuAQCRPsKETKs5Zaf0iqBy78p+dD4hOav5pnkNrEUPEY
	et7nyq0RwXhW8o8UfR9vffL7AnECIte3FHGKkPkbUTXFs56Ggjas/sGSWefQbM07rN9+bNN2hEx
	wisC8V
X-Google-Smtp-Source: AGHT+IGlwkMwHqETiA01AKALwBe420gp98TAGKqwCprXx942usJ9cIL4QaLvUEMs6r4ETu/CxJ4FOw==
X-Received: by 2002:a05:620a:d81:b0:804:6af0:277a with SMTP id af79cd13be357-813c30f0e45mr946958585a.70.1757367484981;
        Mon, 08 Sep 2025 14:38:04 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (ip-185-104-139-70.ptr.icomera.net. [185.104.139.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b5ee69108sm9067585a.56.2025.09.08.14.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 14:38:04 -0700 (PDT)
Date: Mon, 8 Sep 2025 17:38:01 -0400
From: Gregory Price <gourry@gourry.net>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: rafael.j.wysocki@intel.com, dave.jiang@intel.com,
	dan.j.williams@intel.com, jonathan.cameron@huawei.com,
	alejandro.lucero-palau@amd.com, ira.weiny@intel.com,
	alison.schofield@intel.com, a.manzanares@samsung.com,
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] cxl/acpi: Rename CFMW coherency restrictions
Message-ID: <aL9MuRca9SfRAINy@gourry-fedora-PF4VCD3F>
References: <20250908160034.86471-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908160034.86471-1-dave@stgolabs.net>

On Mon, Sep 08, 2025 at 09:00:34AM -0700, Davidlohr Bueso wrote:
> ACPICA commit 710745713ad3a2543dbfb70e84764f31f0e46bdc
> 
> This has been renamed in more recent CXL specs, as
> type3 (memory expanders) can also use HDM-DB for
> device coherent memory.
> 
> Link: https://github.com/acpica/acpica/commit/710745713ad3a2543dbfb70e84764f31f0e46bdc
> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
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
> -- 
> 2.39.5
> 

