Return-Path: <linux-acpi+bounces-12842-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC804A7FA42
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 11:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19DA43A3C5C
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 09:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929A1265609;
	Tue,  8 Apr 2025 09:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kckkb1M/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50FB1990CD;
	Tue,  8 Apr 2025 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105848; cv=none; b=mINJxOPDCyCoyo/ZcZ5iHsTVproHfKGAEdaOe7YS9Q5z0sbyFAJVQnvtqdY2TA4EyckL3TVfMO6CuKtBmNvvIYPP4RN3v3Wny3vKRGOl3LgCmkrQNgIkMO3cwdeYw9k7tOBSYhQtRnevttpYOs+iava+LN2/vBF8aa9mWsSlrgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105848; c=relaxed/simple;
	bh=YHbID0FrCHDLzavxWJAhu47qwRiYUen8pQ4cY+Ru+ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVbWVcGdiFTLtDgUlTLFX7ljBEsK1hZkxg9v9auIgMftPP+5diS75bpL0VZyu4t80e1WDgdVxFYJ8Ciu3hPWHiiffTJXnjx73ufaIR2oXMT8tlIw1na6Nl/bQKSwigejQbBYSoKifBsGCnalNoYqMAi1E5VHvGo9KIG4k0uAn+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kckkb1M/; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744105847; x=1775641847;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YHbID0FrCHDLzavxWJAhu47qwRiYUen8pQ4cY+Ru+ZM=;
  b=Kckkb1M/zM9t9rhGOP5DeF/aL78VhfqLD5w+yE3jPEBfHmT7S4/IAvwH
   BHKXkKCKGN1HCTdQoaUUleD1DbxPI+DWooyl5LZ5gr40KAKGpahPfl6aE
   41dOiqZLVuA0aeWsjLGG3JIz+cLTgARAUjsWSlq0H2GT56cPuwwbTaAnN
   hf044yY26OY2AjyXJbNv7QrwpDQKY0/H4AALNBpjLXyAiHwNgsVKrAYqm
   eOpwfEphuXfMxVfy4lAFyxYGOcAwIsRNfKHPiLmcBaMGv1XMduly7yyg9
   pxt0Szy9LeVH45hPJ6AAeyO4neExZR2Jxztn/JDS5kpynzuvbN8aISI/O
   A==;
X-CSE-ConnectionGUID: cW8pPFPbSqSPEgmB+mIF8w==
X-CSE-MsgGUID: syydRR3eR2aaRJBoPN5Gbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56898627"
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; 
   d="scan'208";a="56898627"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 02:50:46 -0700
X-CSE-ConnectionGUID: W8KfBm36TpCiK1rUHeFj3A==
X-CSE-MsgGUID: hyc+BelCT6SHOihRe1cEmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; 
   d="scan'208";a="127960749"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 02:50:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u25bL-0000000AMHS-2SM2;
	Tue, 08 Apr 2025 12:50:39 +0300
Date: Tue, 8 Apr 2025 12:50:39 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Zijun Hu <quic_zijuhu@quicinc.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 1/1] device property: Add a note to the fwnode.h
Message-ID: <Z_Txb26PyxBPM5oU@smile.fi.intel.com>
References: <20250331163540.280606-1-andriy.shevchenko@linux.intel.com>
 <f6dd3667-8528-4597-963f-75e78d7be733@icloud.com>
 <Z--yNPfIz7TqqC42@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z--yNPfIz7TqqC42@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 04, 2025 at 01:19:32PM +0300, Andy Shevchenko wrote:
> On Fri, Apr 04, 2025 at 10:59:41AM +0800, Zijun Hu wrote:
> > On 2025/4/1 00:35, Andy Shevchenko wrote:

...

> > > + * The respective API headers should
> > > + * guarantee all the required data types and definitions without including
> > > + * this header directly into the driver.
> > 
> > device property(include/linux/property.h)
> > 	       ^
> > 	       |
> > firmware node(include/linux/fwnode.h)
> >    ^           ^         ^        ^
> >    |           |         |        |
> >    DT         ACPI     SWNODE    ...
> > 
> > For various firmware implementations(DT|ACPI|SWNODE...), i feel we may
> > allow them include fwnode.h by their header or source files.
> 
> That's the point, yes. And that's what exactly I put under the first sentence.
> The device property providers are not the leaf drivers in this sense.

FWIW, Rafael proposed better wording which I'm going to use in v3 in the header.
Commit message would be similar, though.

-- 
With Best Regards,
Andy Shevchenko



