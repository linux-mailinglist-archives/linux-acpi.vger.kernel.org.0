Return-Path: <linux-acpi+bounces-9793-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBA49DB86D
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Nov 2024 14:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81A2EB21269
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Nov 2024 13:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D269C1A0BC9;
	Thu, 28 Nov 2024 13:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RoYHjJ8A"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534A719884B;
	Thu, 28 Nov 2024 13:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732800016; cv=none; b=DSZ8RZls6PSjYHDWQebFEnadnP1yHbCbggi0zSA7WqsVYrnIGNRPtNUVlb8f+lS+VFW6sbZyJFK3XSb0feLUb1caIvln1KPiWVSkD9mELQMHbX9EnrTdzEsR/BcSMwVbA8IbYyudAvo+ZtzUsmkWRZLfUKDpxpx4hEy0q73FMn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732800016; c=relaxed/simple;
	bh=ZO3kQSSjHxzoq0EpVMfp7zDaDq3eheQLCnZ0Xr9PHzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzAw06t2aOuXxCJHO9q20TXIynglXCJaTzMzIBidecVNV2BIgSFvzMKoZ5KRO/H8hOEOd8HHAjWPmOw2ECz1CTz7RLnWWnSrfbaml7iXuM2Q7ChSPiVOOJrSr8Ms/tOoKq2ANcLp63aJSLLwwb7tccWLIBak7W+5hidW7TjoqOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RoYHjJ8A; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732800016; x=1764336016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZO3kQSSjHxzoq0EpVMfp7zDaDq3eheQLCnZ0Xr9PHzM=;
  b=RoYHjJ8AeoFXsfTqtpd1DcBn0FXTZdeZA1qYoqTts1hJQwKHw5wUT7ty
   zSr+WQWpImXMmfaqZxwORT1yv5UXb4DGCMWUKAtXBPaa7EPrdLxxj4su1
   t+OXH0s2YdJyf5yqE0koT2z53F8MSP588/TLBLgbtJ9hEwqGHpDFIwOo1
   b5q7YNRM2S4DssLBJKw+kXGKFdo7qDm9WvQnRerqBcCmcu2MXoiYw87pE
   tmisu/f1VbDrux0o/QK6kBP89uPUfbxCKyeSLJ2g9TAlRHl9jkaLuh/d9
   mqw2TuiStKovouNRGLBYKPFoodV4G4uCVfeRX18p476p/o6C9/ar0gz2o
   A==;
X-CSE-ConnectionGUID: r6iAN35pTVm/vBCM8WiOFg==
X-CSE-MsgGUID: mgQJBW5GSMWWdBwPHcHsiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="32779723"
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="32779723"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 05:20:15 -0800
X-CSE-ConnectionGUID: 2gQF/BbXRUyVwFV3Sa4YoA==
X-CSE-MsgGUID: JPDBSJNgR9GvWvarcxKtWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="97292865"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 05:20:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tGeRG-00000001vtu-00sN;
	Thu, 28 Nov 2024 15:20:10 +0200
Date: Thu, 28 Nov 2024 15:20:09 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] device property: fix UAF in
 device_get_next_child_node()
Message-ID: <Z0huCS4Z7dkgpCQ8@smile.fi.intel.com>
References: <20241128053937.4076797-1-dmitry.torokhov@gmail.com>
 <20241128053937.4076797-2-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128053937.4076797-2-dmitry.torokhov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Nov 27, 2024 at 09:39:35PM -0800, Dmitry Torokhov wrote:
> fwnode_get_next_child_node() always drops reference to the node passed
> as the "child" argument,

As commented previously,it might be just a documentation bug. So, please
elaborate on the use case before this patch that leads to an issue.

> which makes "child" pointer no longer valid
> and we can not use it to scan the secondary node in case there are no
> more children in primary one.
> 
> Also, it is not obvious whether it is safe to pass children of the
> secondary node to fwnode_get_next_child_node() called on the primary
> node in subsequent calls to device_get_next_child_node().
> 
> Fix the issue by checking whether the child node passed in is indeed a
> child of primary or secondary node, and do not call
> fwnode_get_next_child_node() for the wrong parent node. Also set the
> "child" to NULL after unsuccessful call to fwnode_get_next_child_node()
> on primary node to make sure secondary node's children are scanned from
> the beginning.

To me it sounds over complicated. Why not just take reference to the child once
more and put it after we find next in either cases? Current solution provides
a lot of duplication and makes function less understandable.

-- 
With Best Regards,
Andy Shevchenko



