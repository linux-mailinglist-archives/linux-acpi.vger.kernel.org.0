Return-Path: <linux-acpi+bounces-6786-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3FA929363
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Jul 2024 13:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 202A21F21AF2
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Jul 2024 11:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C016CDB1;
	Sat,  6 Jul 2024 11:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n4O/mqhr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C407017FE;
	Sat,  6 Jul 2024 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720266992; cv=none; b=J1EY/RNu9Nuziwn+XxOd1e7wSANbBklyUGVeboVBfFeINg1JllWIhAiIG7Mw8D7Fb/IpWVCRgrtXFR+JTnHessnp5FFuDWxE7Byh9cVqXSlOcSRh3ygOxlDa4M9u7PCH+DHQELGd1514wFHIL7BcZpJBjyBigdlvx3Z37Jk4E7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720266992; c=relaxed/simple;
	bh=ARjV0ki1LvilIRr0R6Hk+0ITpkrI/3UyOdn6NyiOJfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCL7AEckY+X5zlLkT+xkANRWo0UUCT1GChSn2pAaxRu90Z5WRIgsHjtoAq8PhFBuDmXNAipc+ffZSRXu7y+fG4OQhVIk2HWLSNepUygQ/Xej5Ej/gaakhGYao/2NRuKyTJd7CPT8jhYP4Hnb6BBx9Idl2PPNKv0im7nwUdRKWnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n4O/mqhr; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720266991; x=1751802991;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ARjV0ki1LvilIRr0R6Hk+0ITpkrI/3UyOdn6NyiOJfE=;
  b=n4O/mqhrDtcYgTwMKVArcveVe4atKU7Lk4Fo9QjJYvqcyWMIFBb27zRW
   tvUY6ui43rH9E7W40mj40sUgfAlhZXOjlksblibGtmWo6nzJkitzMPKE+
   ilKdIcJ+7fdYl0TpXn4k4kmCNEYcniwaFc4VovzFN34zGlKPVuVyOz8S0
   eUrDXbYh4kmEj44DnqGzRWr5ypFQTEbIa8ZfQZ09WrLv5TU7Yl1q8CwNM
   EOfHmvQnI+MQGho/X7BknKI7NvBEgV5EK/O7cbyifs3G3l7yrGrXmvdub
   wgx7LzyvXoheAswRUX/QuJAhbzQC5qGOBmIihOdSrPWfCh7RB9lZmixO2
   g==;
X-CSE-ConnectionGUID: YKrn0MqASR2gbtRSO7rv6A==
X-CSE-MsgGUID: 3/LzdoM5ShCGJGMpVis6pQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="28929334"
X-IronPort-AV: E=Sophos;i="6.09,187,1716274800"; 
   d="scan'208";a="28929334"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 04:56:30 -0700
X-CSE-ConnectionGUID: lyJDeDLaTmGZgO9XLbOwdg==
X-CSE-MsgGUID: 1qkJ9utST6idDUTmacmRwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,187,1716274800"; 
   d="scan'208";a="47144908"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 04:56:28 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 921A411F7E7;
	Sat,  6 Jul 2024 14:56:25 +0300 (EEST)
Date: Sat, 6 Jul 2024 11:56:25 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Rajmohan Mani <rajmohan.mani@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] ACPI / PMIC: Remove unneeded check in
 tps68470_pmic_opregion_probe()
Message-ID: <Zokw6XRZxv0YqIiZ@kekkonen.localdomain>
References: <20240705113434.17249-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705113434.17249-1-amishin@t-argos.ru>

On Fri, Jul 05, 2024 at 02:34:34PM +0300, Aleksandr Mishin wrote:
> In tps68470_pmic_opregion_probe() pointer 'dev' is compared to NULL which
> is useless.
> 
> Fix this issue by removing unneeded check.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: e13452ac3790 ("ACPI / PMIC: Add TI PMIC TPS68470 operation region driver")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>

Thanks!

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

> ---
>  drivers/acpi/pmic/tps68470_pmic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/pmic/tps68470_pmic.c b/drivers/acpi/pmic/tps68470_pmic.c
> index ebd03e472955..f8de8d0a528b 100644
> --- a/drivers/acpi/pmic/tps68470_pmic.c
> +++ b/drivers/acpi/pmic/tps68470_pmic.c
> @@ -376,7 +376,7 @@ static int tps68470_pmic_opregion_probe(struct platform_device *pdev)
>  	struct tps68470_pmic_opregion *opregion;
>  	acpi_status status;
>  
> -	if (!dev || !tps68470_regmap) {
> +	if (!tps68470_regmap) {
>  		dev_warn(dev, "dev or regmap is NULL\n");
>  		return -EINVAL;
>  	}

-- 
Sakari Ailus

