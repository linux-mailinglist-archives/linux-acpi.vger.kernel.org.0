Return-Path: <linux-acpi+bounces-17072-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91955B7D573
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 14:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24DC464177
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 12:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5454D30BF5A;
	Wed, 17 Sep 2025 12:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D4DbMPUC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BBC30CB35
	for <linux-acpi@vger.kernel.org>; Wed, 17 Sep 2025 12:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111559; cv=none; b=HMdFRdaxOAcTNi5GN9RT10Uh6HrrbW00Le5yq+/AS5xLdeTGduORXzfyZw6DHmtFW1+PUQec8vGEM6nFDTVJkjsuXs3Raq+OHV3afUMLkkol4oAP0c+QtQIgQMv39lwlpi2zTeK/hrzH9X2FDJgbc8OiwnnIblPlcZz/puxsz4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111559; c=relaxed/simple;
	bh=j93u0NbcWFEIj3rk9RhwttbkM5b1M8g0p2WHH0SL1Ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4oxC0ZEN/GS09fnUoeEcpZhF5bykSTh2hwpbveqqxR/44ZNs7Y/L+2h9JVcHH9Qa3YBnztmhkxcAQJK6PxggOG3tnsb8ed9XXMChaF5R3BqPUnZ6Ty3/NxDXBkZ76Y/r+0vspQdYu8+H+NZXHA8hW4A521kSL3MhFKnlAik7XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D4DbMPUC; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758111557; x=1789647557;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j93u0NbcWFEIj3rk9RhwttbkM5b1M8g0p2WHH0SL1Ig=;
  b=D4DbMPUCLYBh7i8wmWY/vMbNc5mhueJof47hQ+/YjhW/zQQ4q8r6q68I
   xeWUsVKq7i+WOq1YAeY84trY3zhEw5Z2JLJ8ad1hitWgH6LA93Avghnq3
   xxHVClYAy1DiOHoHvVNTeBGOm2+l79VyOdiumY2B+mSEosf2/fpwQGyKY
   //ZMBbBgVK3QiMl7VmFDbsnyQMff2likVqqEvMTnYz4avsniHgcKW5sFf
   3C/E4f+LBTAMaOE3iBTpT/I9nL2DybOhZCfEmATlsJYRu+4MKoU/L3ztc
   KGFJW+mCY2BnKmYY4BJxYp805ydebv0Qt+gDWnjeftckFP7SbE/DV2TN+
   Q==;
X-CSE-ConnectionGUID: l5ITm2uoSL62S9CSFrHZsw==
X-CSE-MsgGUID: XmYDMNitQzOfRGcmZslB7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="59459255"
X-IronPort-AV: E=Sophos;i="6.18,272,1751266800"; 
   d="scan'208";a="59459255"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 05:19:16 -0700
X-CSE-ConnectionGUID: G7Jgd1DYRXaGkmy1HvZMTg==
X-CSE-MsgGUID: 8Jd2w/y1Tj+w13gtuVikHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,272,1751266800"; 
   d="scan'208";a="179637986"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.41])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 05:19:15 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 2E6A011FC22;
	Wed, 17 Sep 2025 15:19:12 +0300 (EEST)
Date: Wed, 17 Sep 2025 15:19:12 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH 04/14] property: Drop DEVICE_DISABLED flag in
 fwnode_graph_get_endpoint_by_id()
Message-ID: <aMqnQNSRloDjneTa@kekkonen.localdomain>
References: <20250916160129.3955410-1-sakari.ailus@linux.intel.com>
 <20250916160129.3955410-5-sakari.ailus@linux.intel.com>
 <aMpzwU5VFWhqOL7h@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMpzwU5VFWhqOL7h@smile.fi.intel.com>

Hi Andy,

On Wed, Sep 17, 2025 at 11:39:29AM +0300, Andy Shevchenko wrote:
> On Tue, Sep 16, 2025 at 07:01:19PM +0300, Sakari Ailus wrote:
> > No caller uses FWNODE_GRAPH_DEVICE_DISABLED flag when calling
> > fwnode_graph_get_endpoint_by_id(). Drop support for the flag entirely and
> > remove it from the documentation.
> 
> ...
> 
> > --- a/drivers/base/property.c
> > +++ b/drivers/base/property.c
> 
> >   * If FWNODE_GRAPH_ENDPOINT_NEXT is passed in @flags and the specified endpoint
> >   * has not been found, look for the closest endpoint ID greater than the
> >   * specified one and return the endpoint that corresponds to it, if present.
> > - *
> > - * Does not return endpoints that belong to disabled devices or endpoints that
> > - * are unconnected, unless FWNODE_GRAPH_DEVICE_DISABLED is passed in @flags.
> >   */
> 
> Since you are touching a few kernel-doc descriptions, can you make sure that
> they have Return sections where appropriate?

This one does but it's not at the end of the description. I'll move it
there in a separate patch.

-- 
Sakari Ailus

