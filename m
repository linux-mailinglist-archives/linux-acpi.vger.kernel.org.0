Return-Path: <linux-acpi+bounces-17064-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B65FB7C588
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 13:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C25481B22253
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 11:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F62630C34D;
	Wed, 17 Sep 2025 11:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="no+4Ujwj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7F120E03F
	for <linux-acpi@vger.kernel.org>; Wed, 17 Sep 2025 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758109824; cv=none; b=aZiKzJmX7fPR8dGZ2YHaIbjVsxn4FZw/K6w+n3jkg2ZyNFKoCVIh8YPmv+fBIRqKIU1yNCqoZJNs/ie0vQQO6lKISOkF+c0wpyAwrKkgbSvaVS+ihHlBMktqxJExZtJPIgdTGqAibDneXitS2h2nIdHDy8GwIaoHxFMqgksR1oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758109824; c=relaxed/simple;
	bh=txSmwm2j6Zl1pcSFer6xbvZBSggokUYwbhElGuzRcLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmsVL4YmVx2yu7Yb/J7LkJSZ9h0aMxNdIv1yHvWKcfCH5Js2/h5FKa5QsO3+Px8awTbJTWkc+6ONTzTrUYhWsh/UDlcW0fxlYruzQ573d+9l3kMrULnEd+0i4NRzQDye9la6fRsOFzzxPUJdeXYCod/I5kDOe0s+39oV/4SfdDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=no+4Ujwj; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758109822; x=1789645822;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=txSmwm2j6Zl1pcSFer6xbvZBSggokUYwbhElGuzRcLw=;
  b=no+4Ujwj8PFZGeCn62cKdGSTHGoAnXgTb5L3PRyQQSzFb08VSrcXjnpG
   VTy8XFLA/Rzqn+gxqgQdn+7oltzpJPTAAu/h7SnjrHwgbwln9Fl+jgZCG
   bCbeWcftetBl4eYyAyERXAlD5Cxm+GiVWu/v95fwKxIRnP4YgaweDv6ZU
   3msrN2Boh1UL4TUpH4fun5sNS1BCqPWIJH4flvRZ++baOxUmglVEgIIdU
   ARLeGLSgApIEzZvM5dtdg4NiQTNZj0z5WrqXzbY9sOsNSIVyRqetE3WlW
   EQCjR9QX5VW1PbY8DqtlM04ZEcdT9PfIBVyXuk6JximCjMKqZLgGkqZkQ
   Q==;
X-CSE-ConnectionGUID: ovOyTt4gTYqtjEaH3EpEyw==
X-CSE-MsgGUID: H8Dm7lKhRHWJYU9fBj3abw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64212554"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64212554"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 04:50:21 -0700
X-CSE-ConnectionGUID: C8p6KyraR0mivQsvC8kcxQ==
X-CSE-MsgGUID: qOr30b/yQK2Gx0Mx2SxClQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="179508737"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.41])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 04:50:19 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 1A30311FC22;
	Wed, 17 Sep 2025 14:50:16 +0300 (EEST)
Date: Wed, 17 Sep 2025 14:50:16 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH 01/14] ACPI: property: Use ACPI functions in
 acpi_graph_get_next_endpoint() only
Message-ID: <aMqgeIHAaRw47B50@kekkonen.localdomain>
References: <20250916160129.3955410-1-sakari.ailus@linux.intel.com>
 <20250916160129.3955410-2-sakari.ailus@linux.intel.com>
 <aMpgltQIdbLKZRv0@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMpgltQIdbLKZRv0@smile.fi.intel.com>

Hi Andy,

Thank you for the review.

On Wed, Sep 17, 2025 at 10:17:42AM +0300, Andy Shevchenko wrote:
> On Tue, Sep 16, 2025 at 07:01:16PM +0300, Sakari Ailus wrote:
> > Calling fwnode_get_next_child_node() in ACPI implementation of the fwnode
> > property API is somewhat problematic as the latter is used in the
> > impelementation of the former. Instead of using
> > fwnode_get_next_child_node() in acpi_graph_get_next_endpoint(), call
> > acpi_get_next_subnode() directly instead.
> 
> ...
> 
> > -	endpoint = fwnode_get_next_child_node(port, prev);
> > +	endpoint = acpi_get_next_subnode(port, prev);
> >  	while (!endpoint) {
> > -		port = fwnode_get_next_child_node(fwnode, port);
> > +		port = acpi_get_next_subnode(fwnode, port);
> >  		if (!port)
> >  			break;
> >  		if (is_acpi_graph_node(port, "port"))
> > -			endpoint = fwnode_get_next_child_node(port, NULL);
> > +			endpoint = acpi_get_next_subnode(port, NULL);
> >  	}
> 
> Can this be refactored to
> 
> 	do {
> 		endpoint = acpi_get_next_subnode(port, prev);
> 		if (endpoint)
> 			break;
> 
> 		port = acpi_get_next_subnode(fwnode, port);
> 		if (is_acpi_graph_node(port, "port"))
> 			prev = NULL;
> 	} while (port);
> 
> (but it might be a material for further cleanups)?

I think the above should work. I'd also do the change after this set.

-- 
Kind regards,

Sakari Ailus

