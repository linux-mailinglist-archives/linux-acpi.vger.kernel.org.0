Return-Path: <linux-acpi+bounces-5946-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B1C8CC5A7
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 19:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F191C2104C
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 17:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D60142E8A;
	Wed, 22 May 2024 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="dxn/iv15"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42FD1422D5
	for <linux-acpi@vger.kernel.org>; Wed, 22 May 2024 17:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716399393; cv=none; b=cQtyCGK8CX+OkWR/RD8+z9EzWXsGxtn1y0Ibophgnvfkq/PYVQZGpst+bGHcfHod+w9abNhM3uglMBPUeWHpXsvSw/YxiJ1qL3tNH3lICtom+aZAYYKdSm7wdtKeJdpbWtckLo8o/umCOqcyUSUJk+B4tod9WptuqRpsZkEsAqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716399393; c=relaxed/simple;
	bh=Y48rB+eqfN+F9yAGBd3CkyYTUauUSy/FAiGo3hsm9gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bo355MdF6XsUM/tupP5XG6AUXgdpwguo7UB0YatF+EN/6yIkpVUW1tJeGX4V0htDbLVadOpK3w68KJMMGGk7WAhvSsSQVZX1nU/86PJC5fynrD5DuBeZX3FQQ9ZAW5baI8QTckJu3toqZkHZXgmVB4fuBsBDwBLFTpco60rjvsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=dxn/iv15; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so1238747a12.0
        for <linux-acpi@vger.kernel.org>; Wed, 22 May 2024 10:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1716399391; x=1717004191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fDl/ZkDPbSW3xCzUR/DuRNxJiVwY9Xt5ThAS5ddvXhg=;
        b=dxn/iv1503PJaGERtZxf5ZSfdWbcX960pdOB6Rhqe46LLk6RR400elvvV1I77Z2/n3
         aslNY7PXJ4FKRYXwbSPHZdWegVDK3DkEogCrEBPPJ8/tCgqxDxiyrBXR7jYEDcrDhNO3
         9RpzXQjPzDcjD1z8IwqxqF4XTayDXgDMajRxvLWIImoIwcXocgFIgWA6Fu41IGg6ySLl
         at4l1rcE76k1Wyoc7jIWuXmi2ep4j5u6ehvEr7nvzft2yqAU1NnR037y7h3sKjJDwWFL
         8zqv5KWaF0IMS6f1vdn13x/IzVSY5upGSlnD/+9wmV8+n/T/NouE+9rh7zDR0XiLrrW5
         4AwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716399391; x=1717004191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDl/ZkDPbSW3xCzUR/DuRNxJiVwY9Xt5ThAS5ddvXhg=;
        b=quYD4B4WPNYfRiHKtIGbYDBW3ij7/JoUhc60PDk2aoYZsay5bHpy3j+VguGb4VsJFZ
         cvLFjNr1wnHmZjMnl6D7+0k13imtE7bj1rVswO8zuT35ajVkgmLWw+7v3KW+ycGp5qWV
         iZtqJa217uXjJZGdyePY5GYa26ohxQt11UCbb4op/A1jloBGPKBTwDEEfv7dE6QRVq5e
         5+E7rS4XRunrXjDkHYP6Qv4cQsOYGoXL/SKTn/LMuhcq/2gIBwXBo869dcb3i86ZQ69w
         WOSxs5p50y8tIu9whU6aP20WYbmT2XPePkIHc7neYBG1HJQhyqZlVUaxpWNFKUc5+hWO
         k6Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWm8wR7ug5OQrBmh/Gv3xNAWAq4jUPv4/P9DjflhIZTwqFmoDnCLLNZCO40N4RqNuQq2rpMHyXeaUEtQAIeLaQZwu46gp7QIXE6Fw==
X-Gm-Message-State: AOJu0YxA2+24qrqlpjq400xBDaTV8ynvgbOnYghUf97oZy3Y+EPLIoI5
	yGV17iqzORbmr4+SMRJssMPN9nkeDk++nAHrIf8PA2vj+Ytpu5gI4aPLz7CkQjU=
X-Google-Smtp-Source: AGHT+IE/Z1uXsIhp0DCO9v3F7b1s/kf5KJKCU5p/KxlUXSDW4uxdWvE53WL9qx0kDHx4AoziD5mkTw==
X-Received: by 2002:a05:6a20:258e:b0:1ac:8824:156f with SMTP id adf61e73a8af0-1b1f88a30a9mr3119543637.33.1716399391193;
        Wed, 22 May 2024 10:36:31 -0700 (PDT)
Received: from sunil-laptop ([106.51.188.31])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2ae0fc9sm22689883b3a.132.2024.05.22.10.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 10:36:30 -0700 (PDT)
Date: Wed, 22 May 2024 23:06:13 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Haibo Xu <haibo1.xu@intel.com>
Cc: arnd@arndb.de, xiaobo55x@gmail.com, ajones@ventanamicro.com,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Guo Ren <guoren@kernel.org>, Greentime Hu <greentime.hu@sifive.com>,
	Baoquan He <bhe@redhat.com>, Charlie Jenkins <charlie@rivosinc.com>,
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	James Morse <james.morse@arm.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Evan Green <evan@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
	Tony Luck <tony.luck@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	Yuntao Wang <ytcoode@gmail.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v3 6/6] ACPI: NUMA: replace pr_info with pr_debug in
 arch_acpi_numa_init
Message-ID: <Zk4tDa0UPL3Xo/0H@sunil-laptop>
References: <cover.1713778236.git.haibo1.xu@intel.com>
 <70870d88a26f50677eb31ac72bd8c343f428e5b6.1713778236.git.haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70870d88a26f50677eb31ac72bd8c343f428e5b6.1713778236.git.haibo1.xu@intel.com>

On Wed, Apr 24, 2024 at 01:46:26PM +0800, Haibo Xu wrote:
> There are lots of ACPI enabled systems that aren't NUMA and If the
> firmware didn't provide the SRAT/SLIT, then there will be a message
> "Failed to initialise from firmware" from arch_acpi_numa_init() which
> adding noise to the boot on all of those kind of systems. Replace the
> pr_info with pr_debug in arch_acpi_numa_init() to avoid it.
> 
> Suggested-by: Sunil V L <sunilvl@ventanamicro.com>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  drivers/base/arch_numa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
> index 5b59d133b6af..555aee3ee8e7 100644
> --- a/drivers/base/arch_numa.c
> +++ b/drivers/base/arch_numa.c
> @@ -445,7 +445,7 @@ static int __init arch_acpi_numa_init(void)
>  
>  	ret = acpi_numa_init();
>  	if (ret) {
> -		pr_info("Failed to initialise from firmware\n");
> +		pr_debug("Failed to initialise from firmware\n");
>  		return ret;
>  	}
>  
LGTM. Thanks.

Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

