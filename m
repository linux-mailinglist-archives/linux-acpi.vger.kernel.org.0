Return-Path: <linux-acpi+bounces-17057-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D875B7F477
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 15:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 065AA3B6A61
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 07:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2512D24B8;
	Wed, 17 Sep 2025 07:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XcrjAfIT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A53927CB35
	for <linux-acpi@vger.kernel.org>; Wed, 17 Sep 2025 07:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758092881; cv=none; b=YJjYea8GC1ETFaH9oJzE9YfxYOiulFSBLERjkQQt2ykTsKm0/PIUp02JYzBZYKQXMgWpxGUKkTjb4BD3GHSZuVBJxSjQ3Mu1FseZqG1j9uf/A34iLNNxy2ciVP5qEBuP3toZx1ItYkkBLGBoyn4SpqnHyqu7WmeT46+qX0EbtJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758092881; c=relaxed/simple;
	bh=aw/iFAGuvkdlfNo44zkDSRLoT+19Hs/dzuhSvlGQ0UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkqV9fs1qDbZkr53oK/z+s5hT7VzCCvdtPP420w+75AWwruRIaWH4YVvCQdSgxaADD9+E5aMX2nt/fCxS9Z9fZH6czQN7aymzoQMwpyXk11AaFhC+jY3ygSNkLzOHryNLjObVRJFKMAnplIWHnNDv+rTzmGEcV4+ztDcMzviQGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XcrjAfIT; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758092880; x=1789628880;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aw/iFAGuvkdlfNo44zkDSRLoT+19Hs/dzuhSvlGQ0UY=;
  b=XcrjAfITREV+hEof5HFaoH+v6lolGdzuClp9n/+hK6+aKISvQSS6+0mo
   uWz4vcK2D1PZnVNLIYJFrAkgbAyHEGRU/w3QQb1XFB+xgYXKRtibdLNmr
   v3Ll0OHLvmqKBdOQTfa58uI84WdPbVzIQ/DYL6LTAsqyYygnll/KsgsjI
   H9IS81ybhvN0p2dFmUZSgdxziaGUWKnwd238aKajQIQ4LckYJ/VhzzKHa
   bTfRt058NtJpgcTT3I0xfhg/Zf+R8hBC1I+V93OSGBQtHfNgEG8vuISl1
   7yfzcAkenvF7/CTeyF7dxXYAtYJNIyMWFx96OP22rbmci6vP+vIoNU1qS
   w==;
X-CSE-ConnectionGUID: UMQKjyY3QB+pJYEqlURchg==
X-CSE-MsgGUID: fwAByENxTCm1aEdxJC9pBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="60497815"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="60497815"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:07:59 -0700
X-CSE-ConnectionGUID: n6YLnHynTW2dORkUmz0IwQ==
X-CSE-MsgGUID: g+NPixTgSLmxbYdat9DJjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="174455894"
Received: from smile.fi.intel.com ([10.237.72.51])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:07:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uymGf-00000003jhd-3ThR;
	Wed, 17 Sep 2025 10:07:53 +0300
Date: Wed, 17 Sep 2025 10:07:53 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH 00/14] Align availability checks on fwnode child node
 enumeration
Message-ID: <aMpeSeKSFlyJSvQL@smile.fi.intel.com>
References: <20250916160129.3955410-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916160129.3955410-1-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

+Cc: Andrew
(as I know he is familiar with fwnode concept and related pieces in the net
 subsystem, he might be interested to see this series earlier).

On Tue, Sep 16, 2025 at 07:01:15PM +0300, Sakari Ailus wrote:
> Hello everyone,
> 
> Historically the fwnode property API has enumerated only available device
> nodes on OF whereas on ACPI, also nodes that haven't been present in the
> system have been provided. Both OF and ACPI have similar concepts of node
> availbility, on OF it's the "status" property present on device nodes and
> on ACPI the _STA object evaluates to device present, enabled and
> functional bits, of which the present and functional bits are currently
> being used to determine whether to enumerate a device.
> 
> Two additional functions, fwnode_get_next_available_child_node() and
> fwnode_for_each_available_child_node(), have been provided to enumerate
> the available nodes only on ACPI, whereas on OF the implementation has
> been the same on the non-available variants. The motivation for providing
> these has very likely been to provide fwnode variants of the similarly
> named functions but the difference isn't justifiable from API consistency
> viewpoint.
> 
> This set switches the users away from the "available" fwnode API functions
> and later on removes them, aligning the functionality on all fwnode
> backends.
> 
> I'm posting this to linux-acpi and a small set of reviewers for now and
> once we're happy with the ACPI / fwnode changes, to the full list.
> 
> Sakari Ailus (14):
>   ACPI: property: Use ACPI functions in acpi_graph_get_next_endpoint()
>     only
>   ACPI: property: Make acpi_get_next_subnode() static
>   ACPI: property: Return present device nodes only on fwnode interface
>   property: Drop DEVICE_DISABLED flag in
>     fwnode_graph_get_endpoint_by_id()
>   property: Drop DEVICE_DISABLED flag in
>     fwnode_graph_get_endpoint_count()
>   property: Document that fwnode API returns available nodes
>   driver core: Use fwnode_for_each_child_node() instead
>   net: lan966x: Use fwnode_for_each_child_node() instead
>   Input: touch-overlay - Use fwnode_for_each_child_node() instead
>   media: thp7312: Use fwnode_for_each_child_node() instead
>   leds: Use fwnode_for_each_child_node() instead
>   leds: Use fwnode_get_next_child_node() instead
>   property: Drop functions operating on "available" child nodes
>   spi: cadence: Remove explicit device node availability check

-- 
With Best Regards,
Andy Shevchenko



