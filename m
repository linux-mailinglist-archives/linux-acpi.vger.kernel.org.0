Return-Path: <linux-acpi+bounces-15826-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE2CB2B85A
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 06:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE98A4E3B1A
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 04:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C24225A331;
	Tue, 19 Aug 2025 04:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="NNOW1dDN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C63723D2AB
	for <linux-acpi@vger.kernel.org>; Tue, 19 Aug 2025 04:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755577517; cv=none; b=Xm3UqCEhh5ZoLrPk2UWCA8ZIIi4qEpPAKFaGdl731Z4WTSor+zP6LQ+bHujHLb1YsiHYXWth2/9G9XIVRjJ98uMu6GCrmf2whyTgq5xp4QAcTZdS2TeBQw/BlpU4cARZOW+G813FIDIHQcFX4FdVGAAXXtSSl/1XQTnQxreeDzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755577517; c=relaxed/simple;
	bh=o+uhgZHnwmlv4SFLXrZCsBXHw6Z+Ig1wv1N10D205SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIMgzdU/5H5wICBr1I3NHkxWIxwUpIWjO51uhsBRtwjGOJAQVtcUW8YYTPQTDQe3Nbnc6hPNi0U1ZUa5t8l/721uHZHSfGYP2dJko+jaLiaayFVO7SQXtiWyO8fYgKwsJQQYtBIoLkLmHoxbKHfNtc/+LxVsPmOKHad3hyKXgis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=NNOW1dDN; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e2e8bb2e5so5215279b3a.1
        for <linux-acpi@vger.kernel.org>; Mon, 18 Aug 2025 21:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755577515; x=1756182315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=65Uzbt8ZenEFcFURL2MqIdAtkcFnwdoUoUCUj4Jj5Bo=;
        b=NNOW1dDNBo/FO3NpLVwrJZEJJSGxKLWz87n0+JiVDLLbjDZGbAPL8uDW6CC2T/s8CE
         aKpFLQHnw6O9nTJbB305zQE2n0/FC0cWWxTtQ7fOjEAlOErbsQbXoStn72Kx/3b+X8eP
         wt2HfyyQUjIkc3NJJEutE6Kca8J6/ch8PKevtFFyPCwR2wPMCjs4qjmftdD2kEpeBXo5
         JItzEzBL7Ivo3NB9wawdL0rUh4eQiEoGT/eIgGJHIeK13fiph0iAY2FpeW+QfW5sR16F
         jAx51UvPzunGyEexQje6/CrmQ674Xu2OqVln6VgajNYPNqo6cdKXNz3/LrsVRhmd8ll3
         8iow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755577515; x=1756182315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65Uzbt8ZenEFcFURL2MqIdAtkcFnwdoUoUCUj4Jj5Bo=;
        b=V8woWtIwR9ng54onJaa2X+nzbBjIw02Yhtgmrc3PyqyZ90ygkqA6yzOnsa06hugMB0
         9IwAa2JDbPXnhXIBxkI3q2N3D/KOuCa4siK7vWVEAF9TcHkeS3GzNWGcIO/dPWmw9Nnr
         WVjOqVB/uzxcoKjPCneyX7svN6CFZeVXRD9fPO9qtHDbaEc3KAkwvvQRDSR9zlQHS+vw
         fT0RnLi4IoELEjQBEv2JIYBATDvThtbPXDfoLHpeG5t36mXBr0yUNS8s7s/8IjPQPfSd
         2cvw/fYmDMtlOgHh4vFiW241QCcNyjTQJk5T5YLK5Wd5FGuWrobhUOychp1ulGFXPrU/
         YTVA==
X-Forwarded-Encrypted: i=1; AJvYcCWEiUzk2mhqesnopnCsrZDXwzne3mQLf4JwHmyOxnEut9TLGW0bl0zzZ6pwjY1pVfFNNniw+lL7QMIu@vger.kernel.org
X-Gm-Message-State: AOJu0YypcxDbXcidatMkEaLc3I+srlkc1BLsRrPfvkpP4Amu/go4wJQT
	/7HXW8vJbFqUSCHHgv1J2KY6vfd1i/K+Zy2sOj4GTEbMTm0lXY6P/o1Rlvq0gNMh49Y=
X-Gm-Gg: ASbGncvjHXNL7Wu5ylQyuVy6ET0h5v0tI0XOGSSO0GhjXXnJucJLcugkyyQYMXYRgv1
	mRJynhoQHpxFzDt7sCH1YrSFrvz/8Za0dFo2YrMx/tMwGW7wH+L8aorr5+jX3VSDBi0wSdbvJni
	6G7AH+ny2W3iONAAmfQJ6AjXdXb0xrwek4B9z/esRgKHXgkvWNRoy7xoCKBhglL0TaMw1iEofgk
	AH7xkUv9jJyF7YcHdrimfdtML44EY8933j40TxaXi22rk/IX9TbGcPr2jH8xXWNlCpswUXyYa2O
	5KDKU7RgbgMyxFMKWmDPmaxb0GJ+1he4cPJwrokRpYEHnP/75wpEhvwMARUaMLa7TPwUyIWZLY8
	RKwJ4qBQX8NCicdUKZSc+BRswteg=
X-Google-Smtp-Source: AGHT+IF2A+y+SDR52L5ETqk7iiqm/dYRVBF8hu1uj4PHA6PM0xk2a8CSw259kIHYfi9AilP5yR50nQ==
X-Received: by 2002:a05:6a20:3d05:b0:240:11b3:bef3 with SMTP id adf61e73a8af0-2430d4a6febmr1790210637.38.1755577515368;
        Mon, 18 Aug 2025 21:25:15 -0700 (PDT)
Received: from sunil-laptop ([106.51.199.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d13ebdcsm1154638b3a.47.2025.08.18.21.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 21:25:14 -0700 (PDT)
Date: Tue, 19 Aug 2025 09:55:05 +0530
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
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Troy Mitchell <troy.mitchell@linux.dev>
Subject: Re: [PATCH v2 1/2] ACPI: RISC-V: Fix FFH_CPPC_CSR error handling
Message-ID: <aKP8oeKDwXGMmonO@sunil-laptop>
References: <20250818143600.894385-1-apatel@ventanamicro.com>
 <20250818143600.894385-2-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818143600.894385-2-apatel@ventanamicro.com>

On Mon, Aug 18, 2025 at 08:05:59PM +0530, Anup Patel wrote:
> The cppc_ffh_csr_read() and cppc_ffh_csr_write() returns Linux error
> code in "data->ret.error" so cpc_read_ffh() and cpc_write_ffh() must
> not use sbi_err_map_linux_errno() for FFH_CPPC_CSR.
> 
> Fixes: 30f3ffbee86b ("ACPI: RISC-V: Add CPPC driver")
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Troy Mitchell <troy.mitchell@linux.dev>
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

