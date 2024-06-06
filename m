Return-Path: <linux-acpi+bounces-6235-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0703A8FF201
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 18:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60E18B2C9BB
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 16:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902D3199E81;
	Thu,  6 Jun 2024 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ndSWqezx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCF01993AB;
	Thu,  6 Jun 2024 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690245; cv=none; b=Vxx4ZJby7wx14DP1saG576cROlXJICbLliPIScAXfnoERf1UIrq7Uvebck+W6BHdzvaNlMuQ1OAYINftuPygGfizfGIkbnN/HK8qgu3lPW/RwMVqywXVELpBy2hFafJs+L8YEm8tEvwGYz6v4RvdIR3f9+1Q0Ppa6MTc9ACdZ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690245; c=relaxed/simple;
	bh=qv1pFXlcSgwYbKrQz9zbw//dFkZVqhId2iv4MglEBDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QpRwaB2nG3Pqw9eC3ja8AcMd5CpayHDjTT7RleSFqkbhhYQRhQdE/zQ/Zhgnh+5Si8S9h4d90bpBIg38fI8lndnxRS+Xq4YbagwMdpFyOGN1NUgHtRT+pML+wbiB+OSaXKMpAVx9lCtRryPiT1P8lI4UUDp40xxKUc2qOHTXHIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ndSWqezx; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717690244; x=1749226244;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qv1pFXlcSgwYbKrQz9zbw//dFkZVqhId2iv4MglEBDU=;
  b=ndSWqezxjb/BIV+jOmZLHU9R8TSYXdOqbNeA70s+BIKhxw/jKmfP78G4
   UN7tqe6opWbX3Bmw5SS4kf5m1YTOXkP+16HU/29pWbItbQBCM1pkA6EuX
   9jXWKmzRIs42aNmjX6MLHtyHKWsoItY88kjvExwqE2bb2bweqZBpQIkcG
   qHjUgWvJMVNPASnwmsOMHHW9hTVMsUB8CtSFTVNycP1EeB1fkBPD3O2hi
   mly0oqsv5Un2+JSma1Y7SzVIN/j5C3l8py4Fpl1qcX14oyIko8fClbReM
   NnRMlqWvy2lq92D/XikxfpLX9+cw1lSCtjQAWa6v1I2TEZtV0TBg063c3
   A==;
X-CSE-ConnectionGUID: uMU940J6R02cRdieFPLBlw==
X-CSE-MsgGUID: n28c+R0TTkKUxDwUNprqvw==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14525107"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14525107"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 09:10:44 -0700
X-CSE-ConnectionGUID: bvhW7S7sQSWtax5dU45RBQ==
X-CSE-MsgGUID: Tqx9REmTSsaOvs1iEkDMhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="38695769"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.109.168]) ([10.125.109.168])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 09:10:44 -0700
Message-ID: <5224f029-c156-4477-9823-54efd434af98@intel.com>
Date: Thu, 6 Jun 2024 09:10:42 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: NFIT: add missing MODULE_DESCRIPTION() macro
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20240603-md-drivers-acpi-nfit-v1-1-11a5614a8dbe@quicinc.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240603-md-drivers-acpi-nfit-v1-1-11a5614a8dbe@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/3/24 6:30 AM, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/acpi/nfit/nfit.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/acpi/nfit/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index d4595d1985b1..e8520fb8af4f 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -3531,5 +3531,6 @@ static __exit void nfit_exit(void)
>  
>  module_init(nfit_init);
>  module_exit(nfit_exit);
> +MODULE_DESCRIPTION("ACPI NVDIMM Firmware Interface Table (NFIT) module");
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Intel Corporation");
> 
> ---
> base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
> change-id: 20240603-md-drivers-acpi-nfit-e032bad0b189
> 

