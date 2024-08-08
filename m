Return-Path: <linux-acpi+bounces-7440-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B34894B936
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Aug 2024 10:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A7F1F21906
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Aug 2024 08:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5E818950C;
	Thu,  8 Aug 2024 08:46:50 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C69525634
	for <linux-acpi@vger.kernel.org>; Thu,  8 Aug 2024 08:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723106810; cv=none; b=soLOsYaN6/fR3g11xB3YjWLXQv89PvIA5QKsuVbBqhyqk8racekwn/kIxwbHVIH1ti3QjtLPT9KYtJxs4PP7CopliW/qEuowq2GZSLCIEtxffkOm+tqEs5FWZAYH61fksRRPJkUESpJib0N6TthuCnVLDhcgYY97cY4upez8m20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723106810; c=relaxed/simple;
	bh=Vb9+V5rKj1QNZHb+8cAwnjuUwgrtuyBCac+ywYJJXVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=giZ43QWBXPe1MJhgraObeXpYF1yjPpaqeHAyAWUL7myCZrTCagl5IWTOfTqQVEdeneW8nFGeC6l5wCQGbsEKNJB2X+5cb1QInpmOAXolQYrQArHx1JhpW9o7wILE8iWjtK2rZU83LK2YCQpsAg0dvSP/iEnIBckWKebwCDIzito=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 887BCFEC;
	Thu,  8 Aug 2024 01:47:13 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE2423F71E;
	Thu,  8 Aug 2024 01:46:46 -0700 (PDT)
Date: Thu, 8 Aug 2024 09:46:44 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: shankerwangmiao@gmail.com
Cc: Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Sunil V L <sunilvl@ventanamicro.com>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] ACPI: introduce acpi_arch_init
Message-ID: <ZrSF9C0m7w3EsUI6@bogus>
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

Why is __init dropped or not needed above ?
Otherwise looks good. With the above __init fixed, you can add

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep

