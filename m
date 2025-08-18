Return-Path: <linux-acpi+bounces-15757-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4DDB297A8
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 06:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D99196154F
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 04:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834B92459DC;
	Mon, 18 Aug 2025 04:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="bD/89RYa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14659214228
	for <linux-acpi@vger.kernel.org>; Mon, 18 Aug 2025 04:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755490089; cv=none; b=cac5gsT0ViL5HjW/Eo2Al+LxWwSvAP+ngw3HOr8ymsmFcmsRWGd40ocOa33ObOCXtkqtnvH0yFBPfalmDFz0VzqWJJyVPOeSfEezS27F1aB8kojlvIJpIKkv47JuJDlvokWZilMhaQohxwd8IvYeaK+j/FiTc2xWo5DS/wJdnY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755490089; c=relaxed/simple;
	bh=8O7GqK435KZtTl8W855dePMkFjN3aUWnLH8hHcxBbKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPkgkxSQzmgDb9Jg6ZKfFW0myAtdIE/fgWIWByhTtN69mdZbvcxR70XfOZOD+5YP7MjClQ4AJYGZM5IU597ZbuvC+CTW4WXfVwIxf5zrgpY2n+e5GKKBF2UCcXZqSg90GEC3RB+jwpwo3O0TBWzXVxoqZDwm7PMk2o1YwCM+7VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=bD/89RYa; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2445826fd9dso40666615ad.3
        for <linux-acpi@vger.kernel.org>; Sun, 17 Aug 2025 21:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755490087; x=1756094887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HqYW3/niXX/hrER2h0jNeJd0YnT4zpM9DFH12VPKBec=;
        b=bD/89RYawBk7oQj6dpQxstQOi8RtNiDPYNQzBPVoh59XzqGBiZzahcV8bq2tj2HSfo
         9na6li54L3WqvMrLX+w3HMVdNi3riz+BT64+Dyry6AKaJzMIMKqe7YWV+YkfyZNCfC+g
         xbyAaec8z0XvXJ/udJhvKUMberg8aK3/NPmTvRkO69N1UaKz1VSzR3/hv0069IPJnWRN
         f+SbgDvYz8msHC2RxWDbnDGJk6gzuz881+iaIWeoFv0FMAoWHG8axqf3DKlaKdB675lH
         QDSFqV8iWQfTX/gud4AqZHFKqexJijoDN3O/+s2u5Gp+okObb6p9p5NME1VD+IDUMbqP
         aiFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755490087; x=1756094887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqYW3/niXX/hrER2h0jNeJd0YnT4zpM9DFH12VPKBec=;
        b=NoImzhljQ7DiCe/51tSZVATVytC41UYhdm0tiNhoWyzCHFH9i+luQLEzcpQry/Tsoj
         2vziDbeLPVOI6BJaLmFyFf9d9BXv1mHS8n3riBARchoeaqN35dwh+HyzpWwznmQG/WO6
         AdFAxJum/3eeos7L1OaHXgd2U450WiuNGk6cpIMIDhqQKwOv7nj40biZ5k7c+FYgSRYe
         OJkEuZrtERn2qG5HfLXd5LtMwDgtRtfBG3mM+GF5NCymOr6QTJrrnLA/gr8tSpmu0yk6
         ferS3aj/7TKqp/9/Ea0mJyDXq3BqnMNeT7XHsJALDN+HmJNuaqYUr9ysmEK91JmgpTlU
         JBhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWChb2RO8izBFdkUyEcZ66IPmodqfSY8ZViP6H+A+4grnArylyXMTbmjeoiybVfwssRIZgqycLoVQdk@vger.kernel.org
X-Gm-Message-State: AOJu0YyXl7WDRHgIalItkHqPhpzl5aIdlcwK+unXwWsbqqQiJrdX0pwE
	ScjYUYuCPG0I9E+rRyKAyRn/xFaXg8q04kbQ3U+4rkF9LkDTLn5dYxQkm4PjIzx/qTU=
X-Gm-Gg: ASbGncse00KhduPv3o4tXTGYDDlQTrk8hItfaU08q0S0xfZC1/VdWSfAkRTTmWWkPW+
	wUme4Sz64upu5gPzM+AjAkcdcF03PI7r9B1AGPssk1FoaxV9Z7TbOU5IMa98SBwpEVuJ5jO8+uR
	33BikgLtg75B4gM1GGmT3QkNOp7teUrXGW/8V4tCXBsxQtK1sDyY1Yl4xyQMhue2EuDuEDFcpjW
	4He4iwUxNIcJxJmLEzgBjlUMUBTqv0enwdOeDlJXPgM3U3NCBfbP+Ns/if/bc6RHfKRzDAxqxtp
	N89/u0Bmh5GMpzzk3fTxZ4qCQSURSikzM0LbXN+KvRDFdhDaLNAuvVXNhYoqt8xSsZxs5ugMHTH
	Rtt93FtE+ng2Jklh49r5si2sSgx4=
X-Google-Smtp-Source: AGHT+IFtt6MKC6uRsTqYvk5xcpF9n7P7wcfIkwiveUPUOkCEFAvbc2mFtbWODk1+Ww5xxAQfbkJcXw==
X-Received: by 2002:a17:903:2ac4:b0:23e:22dc:665c with SMTP id d9443c01a7336-2446d888ab1mr173360925ad.33.1755490087274;
        Sun, 17 Aug 2025 21:08:07 -0700 (PDT)
Received: from sunil-laptop ([106.51.199.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446cb065a6sm67472495ad.52.2025.08.17.21.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:08:06 -0700 (PDT)
Date: Mon, 18 Aug 2025 09:37:58 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ACPI: RISC-V: Fix FFH_CPPC_CSR error handling
Message-ID: <aKKnHltuYeTTB_pA@sunil-laptop>
References: <20250815161406.76370-1-apatel@ventanamicro.com>
 <20250815161406.76370-2-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815161406.76370-2-apatel@ventanamicro.com>

On Fri, Aug 15, 2025 at 09:44:05PM +0530, Anup Patel wrote:
> The cppc_ffh_csr_read() and cppc_ffh_csr_write() returns Linux error
> code in "data->ret.error" so cpc_read_ffh() and cpc_write_ffh() must
> not use sbi_err_map_linux_errno() for FFH_CPPC_CSR.
> 
> Fixes: 30f3ffbee86b ("ACPI: RISC-V: Add CPPC driver")
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  drivers/acpi/riscv/cppc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/riscv/cppc.c b/drivers/acpi/riscv/cppc.c
> index 440cf9fb91aa..42c1a9052470 100644
> --- a/drivers/acpi/riscv/cppc.c
> +++ b/drivers/acpi/riscv/cppc.c
> @@ -119,7 +119,7 @@ int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
>  
>  		*val = data.ret.value;
>  
> -		return (data.ret.error) ? sbi_err_map_linux_errno(data.ret.error) : 0;
> +		return data.ret.error;
>  	}
>  
>  	return -EINVAL;
> @@ -148,7 +148,7 @@ int cpc_write_ffh(int cpu, struct cpc_reg *reg, u64 val)
>  
>  		smp_call_function_single(cpu, cppc_ffh_csr_write, &data, 1);
>  
> -		return (data.ret.error) ? sbi_err_map_linux_errno(data.ret.error) : 0;
> +		return data.ret.error;
>  	}
>  
>  	return -EINVAL;
> -- 
> 2.43.0
> 
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

