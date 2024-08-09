Return-Path: <linux-acpi+bounces-7464-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA0C94D181
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 15:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A3402844D7
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 13:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D854194AD5;
	Fri,  9 Aug 2024 13:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lIUPkj1D"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE661922FE;
	Fri,  9 Aug 2024 13:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723211186; cv=none; b=qEZjgpWzTVV4zsdUmveVqufrUNGq2hVvX2ftBAd7Pt8Gvfi5vsNA6HkkMEaSqPrY2ZLy2dKIbOihDwo90UbR0ph1ynaGNbS50A1hlTkS7/WZ7yeTo09491l5JoBBALnkN3eKJSEAzsMGSwdS5UHohJ4F3zVl/WQ3fzoooNxbT/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723211186; c=relaxed/simple;
	bh=Lj8I2YczpRsBV40NdoxOlV7wrxbePVYqrhgx8G3OmJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKdEQG40H7tO+fIaaHzHveG2f7bFKa9iZeDNaYD6ftjVsfeQUFNsTHnFuh1TtYBq7y5wkUIFLdTxLCBeqGSAR1FxAycr+pK/C/zw/CXFo21nCvxRr1OBZIj7tfXw9xYfDKTbaohpfxlkCthX2Bfbpng96iUgpSVlz2ztcVPb+tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lIUPkj1D; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723211184; x=1754747184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lj8I2YczpRsBV40NdoxOlV7wrxbePVYqrhgx8G3OmJo=;
  b=lIUPkj1DJdUvrdSFlhogQ8UA3sHTOO0OqMfboDwj8QxfWAwK9ZJUO7ET
   JYVCb1VPw44TW9UB2BmYpHMHDZckoa/RVpseh5KqZUGhUJxYh4CnajKgx
   hJNhzrSz/beHWmlYvNNw/+9Z8WPgN7UsFmKrX8gP3ACE/LcEJhW0OZ6vR
   W7oGk+L57tbcxJKrDRyxAg3pYd16GsMOLoaMURD7IX6Mqgoca3gUY1W7O
   BMcQ/FTQbG3KccmSoUG6lWmFPCZyJvz7R4rQgrBjJuYrmKOvFgTqVIwbq
   5u9SwKsUaTlYC0q+IyOhIdHERRYWPeEiO4l9F3z0qxCv9jQWRB4vOHXXe
   g==;
X-CSE-ConnectionGUID: N5d95tKOTkyU56Nq2mnzQw==
X-CSE-MsgGUID: d3+7hgkUQPWB8UkGX9GBbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21267380"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="21267380"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 06:46:24 -0700
X-CSE-ConnectionGUID: xUV0/ViAQ+qeSL8ISxUVlg==
X-CSE-MsgGUID: DSSgbbbDQlaFdRenmTm7AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="88206956"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 06:46:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1scPwg-0000000DQnq-2IVN;
	Fri, 09 Aug 2024 16:46:18 +0300
Date: Fri, 9 Aug 2024 16:46:18 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 1/1] ACPI/IORT: Switch to use kmemdup_array()
Message-ID: <ZrYdqnhNQlhValcs@smile.fi.intel.com>
References: <20240606165005.3031490-1-andriy.shevchenko@linux.intel.com>
 <3a1e0ffe-db11-d18f-db33-881df7d9b18d@huawei.com>
 <2edd3b72-24a4-8b19-8738-cc82dc4fae6c@huawei.com>
 <ZrYIosRuNG9S-SqM@smile.fi.intel.com>
 <ZrYRIPYv8euBkStd@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrYRIPYv8euBkStd@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Aug 09, 2024 at 01:52:48PM +0100, Catalin Marinas wrote:
> On Fri, Aug 09, 2024 at 03:16:34PM +0300, Andy Shevchenko wrote:

...

> Ah, sorry, I missed this. Since it doesn't look like a fix, I guess it's
> fine to go in 6.12.

No, it's definitely not a fix, it's a simple cleanup.
Hence v6.12 is quite okay, thanks!

-- 
With Best Regards,
Andy Shevchenko



