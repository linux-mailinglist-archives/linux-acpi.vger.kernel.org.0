Return-Path: <linux-acpi+bounces-7457-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDBF94CFF4
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 14:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ACB91F23307
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 12:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50207194089;
	Fri,  9 Aug 2024 12:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QBfChtI9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EAC18CBFA;
	Fri,  9 Aug 2024 12:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723205802; cv=none; b=Dfa1VKFX7R0FR7zqzjPjGnWFchUtGvPwhgLISl+oTf1ah1lPL2setCaGn6Kv7UwojgUoQOxYiJI6TAhNzQN2vCcHNJJ1HaEUQgAxa6oEilairrL7QdeKKkTSp2IKlMH0XxN+5LA9CT/blDZxDd5Nia8WYWxXeoPaQLybtXVmW5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723205802; c=relaxed/simple;
	bh=JP8VCxbNq7CBoSPJbq8/KBX4hfxCfPDfHkMylr4pZvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHdJP6yvPCl+QQm6tMV64cmU5ChElk10ia2PnfitQrix09uAdGrgBZjr318ZoVMluCGYuw76Am2khSNPYr/DdmBAMSA0mLDew5FsziRXe+sq0/Q7TRpZMUQmovuDPlXJlwrgeEBlKW+v89gZU7Zflh721NdPZ0inYYxipqnRDP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QBfChtI9; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723205800; x=1754741800;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JP8VCxbNq7CBoSPJbq8/KBX4hfxCfPDfHkMylr4pZvU=;
  b=QBfChtI9702Fkgu43iFu36OqbukCPGGAfTw/seWGWmPhU/d21BKJ13pQ
   Nyyu6YX1BnNswT6pJbmRSxdmZaRPzfIZrkM9YjK/ZcFC/4Ut7ZtFNwOlZ
   rC1KpJOPfF5sTDKF7cGXtBwPE5g7dSZekhBUa/+mvboQ14+fB/ZbSY2G8
   Afxah01r1sQ0D4eGTYhQZs+eFaJUf/qYjNEPf8L5Z8OF1eVw1ANAVSliQ
   HReIFy949YrOYZAA8z3Fnsx1Zt8htvSMvED80j7+5m2vHRNF3NjPqUSz5
   gc3afekXV/sf755yD8Br++SoOBRAebGMiKHlTj97XyONJveRgvxMH7QiF
   g==;
X-CSE-ConnectionGUID: RR+n4EMzSFuPyn+YV/zyJw==
X-CSE-MsgGUID: rvV9RMlQS1qe42beJaSr5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21550995"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="21550995"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 05:16:39 -0700
X-CSE-ConnectionGUID: yyOzs8w9SnW3By1qr2Qtlg==
X-CSE-MsgGUID: E8YCVP4kRnmavvFOSJKCHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="88187943"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 05:16:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1scOXq-0000000DPav-1keS;
	Fri, 09 Aug 2024 15:16:34 +0300
Date: Fri, 9 Aug 2024 15:16:34 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hanjun Guo <guohanjun@huawei.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v1 1/1] ACPI/IORT: Switch to use kmemdup_array()
Message-ID: <ZrYIosRuNG9S-SqM@smile.fi.intel.com>
References: <20240606165005.3031490-1-andriy.shevchenko@linux.intel.com>
 <3a1e0ffe-db11-d18f-db33-881df7d9b18d@huawei.com>
 <2edd3b72-24a4-8b19-8738-cc82dc4fae6c@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2edd3b72-24a4-8b19-8738-cc82dc4fae6c@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Jun 14, 2024 at 08:54:39AM +0800, Hanjun Guo wrote:
> +Cc Catalin
> 
> On 2024/6/11 18:42, Hanjun Guo wrote:
> > On 2024/6/7 0:50, Andy Shevchenko wrote:
> > > Let the kememdup_array() take care about multiplication and possible
> > > overflows.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >   drivers/acpi/arm64/iort.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > > index c0b1c2c19444..e596dff20f1e 100644
> > > --- a/drivers/acpi/arm64/iort.c
> > > +++ b/drivers/acpi/arm64/iort.c
> > > @@ -822,7 +822,7 @@ static struct iommu_iort_rmr_data *iort_rmr_alloc(
> > >           return NULL;
> > >       /* Create a copy of SIDs array to associate with this rmr_data */
> > > -    sids_copy = kmemdup(sids, num_sids * sizeof(*sids), GFP_KERNEL);
> > > +    sids_copy = kmemdup_array(sids, num_sids, sizeof(*sids),
> > > GFP_KERNEL);
> > >       if (!sids_copy) {
> > >           kfree(rmr_data);
> > >           return NULL;
> > 
> > Looks good to me,
> > 
> > Acked-by: Hanjun Guo <guohanjun@huawei.com>
> 
> Catalin, would you mind pick this up as well?

Any news?

I do not see this even in Linux Next...

-- 
With Best Regards,
Andy Shevchenko



