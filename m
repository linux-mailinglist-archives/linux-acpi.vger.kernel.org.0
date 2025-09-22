Return-Path: <linux-acpi+bounces-17171-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FEEB8F656
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 10:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352913A5B2C
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 08:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033E2261B71;
	Mon, 22 Sep 2025 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QjTtRuvG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE96219A7D
	for <linux-acpi@vger.kernel.org>; Mon, 22 Sep 2025 08:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758528218; cv=none; b=YO+yDzC43YxYyDld7Ao08I5VqoJ67127fZMKVgs7WcVDEEZoOpYUJsMkqszWcHw0NUXt10IB11hNTE2DidysIb7K4N5SyKV8ScqoLdcruXDHthRFzLjaPTK1rPR9ISIvqgiH5R+/KLKZOtQDzkbC2CfDgy+kKbzzlfHVVPW0kfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758528218; c=relaxed/simple;
	bh=NRSIzWoIRujQLA9etY6a6nHx0k+mhGmF3AGfbifPezw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LuSDYZ2fow+3LWlq3VFcy7h0MMI8dE3LyjVDzT1g3jQGArQ8tD+Ns8PM7sj0k8gnIACZkTeiLyB6VfrOHZy+dUEra5+RGks+cNcQ4+aI9NWCXRGQooF0nfsr40mQs+uVppgHUU4CCe4mkwRdqAD3sQO6CXS2na6XxcISYcSgBEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QjTtRuvG; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758528217; x=1790064217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NRSIzWoIRujQLA9etY6a6nHx0k+mhGmF3AGfbifPezw=;
  b=QjTtRuvGeCO84aBvtQUQQZhPookJJ91KTC9svZ3/kTKjtR/Dk5opR4Ie
   rpw8B285r8K4gc2OPmJrLW9oPLV36BtPT71PqetZnIbITDgnZvuG3d1Fc
   pkdxo3VJgfPND6nstSvZh0JoLndHj2EFUcgqhbOpB+cGLhWnWm4WvULtP
   v2SKfYV9LbACHCyEb4EACq0wc7DjxQJ8rQtSLtmx8OvIJbbj/Mw1qyw2O
   5NlaSP4d5lItHFdfblYQe7sHLQwZT6vyCy1YLJLZYjjPzpaAxok9Qs6iD
   M/EnF6TN9oKbxbyVI3pTWEzWV0hVlcS4NqFKhPhTaKLZL0QFG/BqsWuCk
   A==;
X-CSE-ConnectionGUID: cAh41B5hR4C2pCiv+V43CA==
X-CSE-MsgGUID: OlTkNYUzRV6WJKLmMtzidw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64589070"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64589070"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 01:03:36 -0700
X-CSE-ConnectionGUID: 3GaIie4QTWK1V0PHv+ojKQ==
X-CSE-MsgGUID: DiPyNWeqRy67Rjaqsu80Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,284,1751266800"; 
   d="scan'208";a="175688924"
Received: from smile.fi.intel.com ([10.237.72.51])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 01:03:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1v0bWG-000000054Cw-02hC;
	Mon, 22 Sep 2025 11:03:32 +0300
Date: Mon, 22 Sep 2025 11:03:31 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH 06/14] property: Document that fwnode API returns
 available nodes
Message-ID: <aNEC02ZRdwVcA6mr@smile.fi.intel.com>
References: <20250916160129.3955410-1-sakari.ailus@linux.intel.com>
 <20250916160129.3955410-7-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916160129.3955410-7-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 16, 2025 at 07:01:21PM +0300, Sakari Ailus wrote:
> The fwnode API has historically provided two functions to iterate over a
> fwnode's child nodes, fwnode_get_next_child_node() and
> fwnode_get_next_available_child_node() whereas all of the fwnode API has
> always worked on available nodes, apart unavailable ACPI child device
> nodes could have been returned by fwnode_get_next_child_node().
> 
> Now that the availability check has been added to ACPI side as well,
> document that the functions in the fwnode API return available nodes.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



