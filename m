Return-Path: <linux-acpi+bounces-10761-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A443A16B2E
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Jan 2025 12:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00C761884339
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Jan 2025 11:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DCC1BAEF8;
	Mon, 20 Jan 2025 11:04:31 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714001991CD;
	Mon, 20 Jan 2025 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737371071; cv=none; b=pnJPRtOI7qy2P2JgITjTYCT9yyuK8eToOdcomR5X0OKYOYN4r3zx3PNn27rYikRKcrdn5mqHAejAjfZjlAdIeqwlWh0XIrKbnPYmlzrLqxUNlDR60eFOLBJRoPHK4YzgMQfeODqN5QUPzQhDdMEkcrsiqjpOJpAprYBAr1PfYvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737371071; c=relaxed/simple;
	bh=cvUT28iw+/vEv8DA4s+cn/LI/U9h+RSpwFF+CmyOf4g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sLYw2g6gSzX3zT10Pm699sQOWyJ1Ayvv4MX1Mw31/lBRH7V4vmkfoCK79nH0mxPnlXAf0vhB+wzUudp/tDvyHW3rQJKjw7xNRC36I447GJZjJ3AB0jPOpFE7D+ZIpT1WCPs86VQmEQUaSqATdiE01AT18NBBNTkW5wGBrpNW7aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yc6ql0BJDz6M4PB;
	Mon, 20 Jan 2025 19:02:27 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 82681140736;
	Mon, 20 Jan 2025 19:04:19 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 20 Jan
 2025 12:04:18 +0100
Date: Mon, 20 Jan 2025 11:04:17 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Xiaofei Tan <tanxiaofei@huawei.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mchehab+huawei@kernel.org>,
	<roberto.sassu@huawei.com>, <shiju.jose@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v3] acpi: Fix HED module initialization order when it is
 built-in
Message-ID: <20250120110417.00000a57@huawei.com>
In-Reply-To: <20250117022957.25227-1-tanxiaofei@huawei.com>
References: <20250117022957.25227-1-tanxiaofei@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 17 Jan 2025 10:29:57 +0800
Xiaofei Tan <tanxiaofei@huawei.com> wrote:

> When the module HED is built-in, the module HED init is behind EVGED
> as the driver are in the same initcall level, then the order is determined
> by Makefile order. That order violates expectations. Because RAS records
> can't be handled in the special time window that EVGED has initialized
> while HED not.
> 
> If the number of such RAS records is more than the APEI HEST error source
> number, the HEST resources could be occupied all, and then could affect
> subsequent RAS error reporting.
> 
> Change the initcall level of HED to subsys_init to fix the issue. If build
> HED as a module, the problem remains. To solve this problem completely,
> change the ACPI_HED from tristate to bool.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Given the change in approach (even though I reviewed this internally)
should probably have dropped my RB.   Anyhow, consider this me
giving it again on list.

Thanks,

Jonathan

> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
> ---
>  drivers/acpi/Kconfig | 2 +-
>  drivers/acpi/hed.c   | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index d81b55f5068c..7f10aa38269d 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -452,7 +452,7 @@ config ACPI_SBS
>  	  the modules will be called sbs and sbshc.
>  
>  config ACPI_HED
> -	tristate "Hardware Error Device"
> +	bool "Hardware Error Device"
>  	help
>  	  This driver supports the Hardware Error Device (PNP0C33),
>  	  which is used to report some hardware errors notified via
> diff --git a/drivers/acpi/hed.c b/drivers/acpi/hed.c
> index 7652515a6be1..677dfcce2990 100644
> --- a/drivers/acpi/hed.c
> +++ b/drivers/acpi/hed.c
> @@ -81,6 +81,7 @@ static struct acpi_driver acpi_hed_driver = {
>  	},
>  };
>  module_acpi_driver(acpi_hed_driver);
> +subsys_initcall(acpi_hed_driver_init);
>  
>  MODULE_AUTHOR("Huang Ying");
>  MODULE_DESCRIPTION("ACPI Hardware Error Device Driver");


