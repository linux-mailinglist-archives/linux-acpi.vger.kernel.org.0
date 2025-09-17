Return-Path: <linux-acpi+bounces-17062-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD64B7CFD2
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 14:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13F543B7ACA
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 08:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5AB306B13;
	Wed, 17 Sep 2025 08:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L85ZhfES"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15582F60A2
	for <linux-acpi@vger.kernel.org>; Wed, 17 Sep 2025 08:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098376; cv=none; b=Wv962tNBQCaAzzR6vo1N3s4Cn+7Hx4fh+LXzJfqBq9VsU9RHDaqrrK7F6z77u5QOcMoOP26MuqPxofFHAFsikTNHqHTuKjLH464xO6IiSoLouS4//K2wmsCKwMXb6xcuEVj044T2iZo2V2NZbBykdW+EjkKDgOJLQ/ZTe3Fw2AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098376; c=relaxed/simple;
	bh=PgbFh0mmksBdHPBR79SOEGEu+PjGYwz1lesgOq8kIME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewQYYgvcBynoHsyjDMeFgXpNuUGwU7o2QN0r7+67C3FEIqQdTouk11grH2MzsHOSxnetQXlNPkgl3+0g1PYZeyXGQTMkm7dN8QqjUSYVySH2EDhhut4E2kIrp6cTzFR4Oof+4pQYfQ5dMGKD2tHancC0DKJE2uoX6zulwnJMNUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L85ZhfES; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758098375; x=1789634375;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PgbFh0mmksBdHPBR79SOEGEu+PjGYwz1lesgOq8kIME=;
  b=L85ZhfESJ5K6Mk3U6fpxd3TC/d7W+EmTb2tfuvvVE+2IY1LkITMvGp9n
   wYovtNPmw5pntP9rqCRE5wUrDL63oyBIamHNjhTSpQlayNlO6CyrhFwbe
   QjH9K/q/Lmx63UShP39YY0DeSv74cfhAFWNxmY/zoC07GKMf3IpTOG/Gc
   ITxbvQVW5fVF7hXUIgzgFIdZYtEs9VSr3sKj4iTx9iI2HKsgCOpuJ5DiL
   e+sQ/xfFi/XplKbw3WeTQYaP5wnXBqBcruAjiyMq3o/6Z2pZnoa0AwsOD
   zIziqolIGhYd24j+p9FrkBCyapt55EEdNzzM7Pg0kzIgrl8SQmvrgWnyQ
   Q==;
X-CSE-ConnectionGUID: tBPIJeK4QkyHQXw6+tAcCw==
X-CSE-MsgGUID: 1gtLSshDRSStrGI5uQSMSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64197174"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64197174"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 01:39:34 -0700
X-CSE-ConnectionGUID: 2PalGYhbRyqWn/wz76SnRw==
X-CSE-MsgGUID: NeJg4vhIQcqQTj0fYlnZdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="174754461"
Received: from smile.fi.intel.com ([10.237.72.51])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 01:39:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uynhK-00000003kyg-04qe;
	Wed, 17 Sep 2025 11:39:30 +0300
Date: Wed, 17 Sep 2025 11:39:29 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH 04/14] property: Drop DEVICE_DISABLED flag in
 fwnode_graph_get_endpoint_by_id()
Message-ID: <aMpzwU5VFWhqOL7h@smile.fi.intel.com>
References: <20250916160129.3955410-1-sakari.ailus@linux.intel.com>
 <20250916160129.3955410-5-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916160129.3955410-5-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 16, 2025 at 07:01:19PM +0300, Sakari Ailus wrote:
> No caller uses FWNODE_GRAPH_DEVICE_DISABLED flag when calling
> fwnode_graph_get_endpoint_by_id(). Drop support for the flag entirely and
> remove it from the documentation.

...

> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c

>   * If FWNODE_GRAPH_ENDPOINT_NEXT is passed in @flags and the specified endpoint
>   * has not been found, look for the closest endpoint ID greater than the
>   * specified one and return the endpoint that corresponds to it, if present.
> - *
> - * Does not return endpoints that belong to disabled devices or endpoints that
> - * are unconnected, unless FWNODE_GRAPH_DEVICE_DISABLED is passed in @flags.
>   */

Since you are touching a few kernel-doc descriptions, can you make sure that
they have Return sections where appropriate?

-- 
With Best Regards,
Andy Shevchenko



