Return-Path: <linux-acpi+bounces-15744-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0171B28679
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Aug 2025 21:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A01821CC757D
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Aug 2025 19:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE6327FB1E;
	Fri, 15 Aug 2025 19:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="lDtY5kvo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2405F2253E1
	for <linux-acpi@vger.kernel.org>; Fri, 15 Aug 2025 19:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755286621; cv=none; b=XI6Xemq4aWHfZYLsiuRqXs92Swc11apr1G7B+YHGL4+i9j8ugRlfjPxZWllpLJ8Vron9Pblga7aACPKa0x3w8FfeobB5+OjjfOCaXEaidE1cgJhNfoscmCW7oUJ7fdLxqmItyPBDUBToJc1fH2y1dquM5hMnbFLKJf+qoGz1E/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755286621; c=relaxed/simple;
	bh=TRnuJeJdiiXVSPt5A38b/HSMMuCr/JcWKJo0VgtOGZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Feq7Gb0xTUBglg9LDXOU/nejztbSDynC2w1k4Iufe9SyHYpvg5QjZ6yhwn80g/UKd3uV+1pDgdMTXHPwfFHuN+e47tIC5KUDwMDW6xrRB8DY1y5KaLMeLf4Emfxf8E8ld3/nRUPGK6SHa8rHXqTkZaYO4dRgt9v7rT9qSqoI6mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=lDtY5kvo; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3e5700a73e9so20345205ab.2
        for <linux-acpi@vger.kernel.org>; Fri, 15 Aug 2025 12:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755286618; x=1755891418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7DgASsy61mSObI5Zc/GrPmOkK9c4HSQIjPYfhAD6IUY=;
        b=lDtY5kvowA3DJCu5srHnylxJwPLwBCbwyaOVIacpbMx/9+QyQmxCdE9Q9xfiIMj4Ez
         9lh627g2D/owPQYYotbarJPU4bNY+/LJLczNluWmRe56pkICs+9qK2ZDuimR53eecORv
         93011szCbeR9ehqvCvL7TfahNDQZZdSTzp7u4h8TIR8Pa9V9VrpDwKdu/98G1DtHFhye
         /Nq5PZqmdO1J4zPMDoSXGMxrE5/6QeGw1nAbVNcWlnY/B3Ctk3mIov9WkoRsQZnuJSG5
         TU1FSa6BR2nlbbArjuad5VDQgOWfkxcRiUuGmSZP4eXNQDpZbwVFod4suvdN1FakGTUU
         xp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755286618; x=1755891418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DgASsy61mSObI5Zc/GrPmOkK9c4HSQIjPYfhAD6IUY=;
        b=vsOtm8f4QBtq6nsS8xOdFdCSPFZRzfyGqcKe3Rvo7UvZ+MCKJlvZU/5x7u/ghXsBfT
         acgtfWr/k3c5VpOcu/K161AuzWyjYkl/sNIKEQAPtNfw+z76jHiXP0HFH9X4XbqeDESk
         FblqgmbAPD9WZP/ks8+JCLZ9/KImd0FOXqcO9W2hwdfxHMGHHlNADMEFkfNJR3mPlA1J
         pa8EEesHaK/dy/GayQFJc/SuAWejGiQJNP2v7NQGyfLojX4+l4WUDN4NxdpiB9gMJQ8n
         LIN9oSgFHC9ROOZVcAq8COthQslWbiuXmaEdKOGiFAsJP/296J53Symrla6jPTr2vTlx
         hb0A==
X-Forwarded-Encrypted: i=1; AJvYcCVOGLtVUeumaqsXcGsvBOgPxs4zvJ6POpzSM5A8AXs7eZzx5E2h1s2CVbdtEeiAf+vBphDVoYw/Xezf@vger.kernel.org
X-Gm-Message-State: AOJu0YyAjXREQ1PWH11Hrz10mXrXkUfs8xt0XqOEPlOpcNXZ2vB4cW20
	xsd1tqmTuTOlFh3iAN4oEVppdBSfhVB8I+z12c0JDUH+NhZuCm6tUFNdvzegnKySfoI=
X-Gm-Gg: ASbGncsn7TdZSi43gFFE8C0WWLIsxAUctwve5jAvf4BkXF/5+Rd+VyV9aHLFUTbOduT
	UWnN9LLqYwWRzp3XJ9AsaxDRw4BSzR9r15S6flX5r7MA3cNwTa2K45wHWPXGi+2EcDBE5/u2a81
	NGHh5csbdJM7zowv7+TX2YAmN0D6dJu05P172wmRTySApT6wqQSgl782ZPE4S8EfETqfkoSdLA2
	pt8zNi+7NvztcoQOdML+bPSUtg/tamn6d90pBLXvRt4l4QyEh57mRN5yfbyUnMz1okanB3WUW+/
	Yeq3gW+kuuaFENnWO/KQcwjjzgeNZHgQxmoYIDkPQaY2mqzNXjOWo1hhHxudG1mLJybf+Q0mMYd
	cb3OR9Hwka1ZwoSsLhfKYqGwE
X-Google-Smtp-Source: AGHT+IH50HAImdgEzMYWVcKbXBtm0Htc491sbSs2fh8HxUr57vHHb8MC8O7OYnqjBnPqId7Doh1Eog==
X-Received: by 2002:a05:6e02:180a:b0:3e5:3520:4a75 with SMTP id e9e14a558f8ab-3e57e9c4f1dmr68415975ab.23.1755286617859;
        Fri, 15 Aug 2025 12:36:57 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e57e6cef44sm7903315ab.48.2025.08.15.12.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 12:36:57 -0700 (PDT)
Date: Fri, 15 Aug 2025 14:36:56 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Sunil V L <sunilvl@ventanamicro.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>, 
	Atish Patra <atish.patra@linux.dev>, Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ACPI: RISC-V: Fix FFH_CPPC_CSR error handling
Message-ID: <20250815-770a166e7b6f890d714dd4dd@orel>
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

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

