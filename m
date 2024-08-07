Return-Path: <linux-acpi+bounces-7426-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1A694A446
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Aug 2024 11:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5E771C20B0F
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Aug 2024 09:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C661C9DFD;
	Wed,  7 Aug 2024 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ST1pbZZM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BD96D1B4
	for <linux-acpi@vger.kernel.org>; Wed,  7 Aug 2024 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723022930; cv=none; b=HjHh/HawFiqvy/F32mC8aMIDprMhTJPICLuBmG2vRUyquVx7IujZvmBvtg8F9GrT/4TAIeBm9Hww7FupNfwqh48+UwyMf9kXPe5fq2iYq8RX0oCSwhpvS3joQ3KvdlIjmJu9FzG3Xu5VIIrDqYNA65Iopa3Q/WCEuMNwAAiIZsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723022930; c=relaxed/simple;
	bh=0KRdcQMjdm9x6CHQf2eXXB1QhdvR6b+8UEvgQ0kVBEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXWjWzjPZb0dR5mMy69PVEUWxoNJino2ptb2dHMqZ5+2/9g9wEPLYMsgVkGmO22dQc5e2kiM/SpXE6VqJQBD9doSR4mbARb1CcCvhWNhqxCR0lpwi9ZyyFHNZw346TI2esyCbAfwyqvOGVdQ4VZH4Xp0EHptII6OkLhF7nqBpWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ST1pbZZM; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-39adbfafde5so6226395ab.0
        for <linux-acpi@vger.kernel.org>; Wed, 07 Aug 2024 02:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723022928; x=1723627728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=alrAEwTk/9ZGL+1f7lSqNYp1lnxaGoa+HaCOobuYYh0=;
        b=ST1pbZZMohKGSIuM0a2Qbs0pjDyCfY9v8jP/PCBDlCK7ugQM6hUlDF+kfZaIhLcLIx
         6COg0zYjbSlaDmEP1QvuYcEcpAEnecWYSk11CWSeMpORLN2l9uxlHpZ907MW3MAELG72
         y2woh/4fA7gghv0WTmdZkF3Hj/wqaPm7kWzNOeSt/ap2I74VALHVp1msXfXa8Fplz04M
         uZiLtI+ne/ORZrcvUcaXF6iL3SQdM4GiggWVigs5XbadPsqc/l2fVMAvsB2EHeTeBNa+
         DjNkym67BoNDmnVrgeGgaxM/n2HkxQvWfq6ovy0KWCx1dCcZDM/KfIk1TrBNFijHeNC9
         Wl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723022928; x=1723627728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alrAEwTk/9ZGL+1f7lSqNYp1lnxaGoa+HaCOobuYYh0=;
        b=uUtgdsF2AtsnAp0S2WAZw3ElaEJKVS0BYagGun/Gx14feseIeHd08FXzqD/Dhdxc7U
         KwM40yoB74Xye+yB8e3iyp8e8Qrcgg9wKxzybvJzCwK5pDYCjf4Oz0fBCXp5pB0AtJo/
         bAJrfE10ilZ5ZEqCeqknrhGMUu8V69nWJKYGfUZEdsnnCOfResEDajCjbQ7WOof9iNmw
         yWjE+IyqlpVxrPXlokmaPWklXgfReB0jjWgNzpyvYMY2SD5Bvf+CY+YaJFYneLI3gMv0
         UsD/aaOo05eslSI/Bl+WxPfHw7PKb9jz5/ylJhY5zuA9xgHC7k4QajmwlN3B3udA8zb/
         vrOw==
X-Forwarded-Encrypted: i=1; AJvYcCXp8Ns5AzGVu3a0Ujd0T58irSmKFKG9wvWEyHx4IV+B/Q7ZSAOfwr4Zq2YbLs3F2owGXxVihFmUCvLi4v54I7MSamO8pBQqVlxITA==
X-Gm-Message-State: AOJu0YxixCv/kHVxYI1aHuwNp62OOD1B1CzTEopJaa3TYjKWQM9E5Tc5
	XuFyGu6yN3zvkk4/oCfbaj5btThjJzgDl0fgh/itl/wPhyaZLy70VKj8AMX1jaM=
X-Google-Smtp-Source: AGHT+IGFi2yTi8mjGa/JDQgJ5ePUMCC2uiP0+ISk+Z8ei9aOJgQKjnFm1sJATScT5YUF9A+EBCrw2g==
X-Received: by 2002:a92:d8d1:0:b0:39a:e9c4:6baf with SMTP id e9e14a558f8ab-39b1fc37596mr158866065ab.26.1723022927664;
        Wed, 07 Aug 2024 02:28:47 -0700 (PDT)
Received: from sunil-laptop ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b762e9f5aasm8091871a12.6.2024.08.07.02.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 02:28:47 -0700 (PDT)
Date: Wed, 7 Aug 2024 14:58:42 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: shankerwangmiao@gmail.com
Cc: Hanjun Guo <guohanjun@huawei.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] ACPI: introduce acpi_arch_init
Message-ID: <ZrM-SmLGpgO0gLsg@sunil-laptop>
References: <20240807-intro-acpi-arch-init-v2-1-9231e23a7721@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807-intro-acpi-arch-init-v2-1-9231e23a7721@gmail.com>

On Wed, Aug 07, 2024 at 02:36:12PM +0800, Miao Wang via B4 Relay wrote:
> From: Miao Wang <shankerwangmiao@gmail.com>
> 
> To avoid arch-specific code in general ACPI initialization flow,
> we introduce a weak symbol acpi_arch_init. Currently, arm64 can
> utillize this to insert its specific flow. In the future,
> other architectures can also have chance to define their own
> arch-specific acpi initialization process if necessary.
> 
> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
> ---
> Changes from v1
> - Change acpi_arch_init from a static inline stub to a weak function
>   according to Haijun Guo's advice
> ---
>  drivers/acpi/arm64/init.c | 2 +-
>  drivers/acpi/bus.c        | 4 +++-
>  include/linux/acpi.h      | 6 +-----
>  3 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/init.c b/drivers/acpi/arm64/init.c
> index d0c8aed90fd1..7a47d8095a7d 100644
> --- a/drivers/acpi/arm64/init.c
> +++ b/drivers/acpi/arm64/init.c
> @@ -2,7 +2,7 @@
>  #include <linux/acpi.h>
>  #include "init.h"
>  
> -void __init acpi_arm_init(void)
> +void __init acpi_arch_init(void)
>  {
>  	if (IS_ENABLED(CONFIG_ACPI_AGDI))
>  		acpi_agdi_init();
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 284bc2e03580..b47541e45a5a 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -1431,6 +1431,8 @@ static int __init acpi_bus_init(void)
>  struct kobject *acpi_kobj;
>  EXPORT_SYMBOL_GPL(acpi_kobj);
>  
> +void __weak acpi_arch_init(void) { }
> +
>  static int __init acpi_init(void)
>  {
>  	int result;
> @@ -1458,7 +1460,7 @@ static int __init acpi_init(void)
>  	acpi_viot_early_init();
>  	acpi_hest_init();
>  	acpi_ghes_init();
> -	acpi_arm_init();
> +	acpi_arch_init();
>  	acpi_scan_init();
>  	acpi_ec_init();
>  	acpi_debugfs_init();
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 0687a442fec7..52862c377747 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1523,11 +1523,7 @@ static inline int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
>  }
>  #endif
>  
> -#ifdef CONFIG_ARM64
> -void acpi_arm_init(void);
> -#else
> -static inline void acpi_arm_init(void) { }
> -#endif
> +void acpi_arch_init(void);
>  
LGTM.

Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

Thanks,
Sunil

