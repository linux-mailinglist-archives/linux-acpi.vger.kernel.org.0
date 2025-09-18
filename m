Return-Path: <linux-acpi+bounces-17111-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC63B86AB1
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Sep 2025 21:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C975C566959
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Sep 2025 19:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA9C2D24B2;
	Thu, 18 Sep 2025 19:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Li4f3g/9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995772D0C8F
	for <linux-acpi@vger.kernel.org>; Thu, 18 Sep 2025 19:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758223400; cv=none; b=R5aucKkxzFu9aH7MdfOwOg2EMo6p+a7X8OA6dOKgNlUztEbfF0qqKcppetUj1X11fzTgTtF1mew/BjNSXrnb4UjynA9mOIxchpnLzgi6hz2or1JTw+KUTin0R2pEqqLuWIirQFr2ZXZFgKJrpO/B4yzZsESPr/nzqNwkkVgSOj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758223400; c=relaxed/simple;
	bh=EClpaoVLPlWdCRwjLld3IR0XZog5Jy34keoMrvOziMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5xKbqsjeN1B9Pf2wLdoYQhm6cTA2hv2HGJnRJQSRxkU8qnpIFi+xWyyBtaDUE3A1cg2/jRolQsAH9KaZcpOgWOkFTLXpvAiB/18x0SNC1I2v9Vw/b7BsKYbcjZFXKIh9VKw9PZJuBdYuS+5V6MGArV91IgYwRps6hnr5qTUwic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Li4f3g/9; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758223399; x=1789759399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EClpaoVLPlWdCRwjLld3IR0XZog5Jy34keoMrvOziMY=;
  b=Li4f3g/9+XgPYPLjcxo3beJO2tmRrHruq9b3r6pS8THXigae4mxL95iy
   VRL0F9rbUSK7VOP4WQcs5WKNOJ31lATPAsu47qkvMhW9aVg8xyb+SgZ2b
   gM9lHB3KZozcKfcFBSz0lUybzZhvL9/0/urp/C64ZsBM0M1qPlk+jrbH9
   4NpgC/MAxx2IoyqzfxzjPSeFGD24akaaX+/ZIlTJSJaXK4cusBIr2dl6T
   6aZTyEZhlEc7bVpr0nXRzIVjdyex3No8thbtGsMSIjJmZOMkW00SZlZ5A
   sNGlYf6P4aI+ktyDCYLa8vWeu8gVMp9prQy3JpRWMTFDTUGI67sBsUxst
   A==;
X-CSE-ConnectionGUID: hX+zFGlmTTegV9dtdAqkAQ==
X-CSE-MsgGUID: cO6jLAPqR3iNTk2rbnsK2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="63195405"
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="63195405"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 12:23:18 -0700
X-CSE-ConnectionGUID: c5pbjAosQD6hj14rLIeo/Q==
X-CSE-MsgGUID: m0Qe2tZdR8CeDS2/lkDx4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="175191728"
Received: from smile.fi.intel.com ([10.237.72.51])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 12:23:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uzKDp-00000004Axh-0m9d;
	Thu, 18 Sep 2025 22:23:13 +0300
Date: Thu, 18 Sep 2025 22:23:12 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH 05/14] property: Drop DEVICE_DISABLED flag in
 fwnode_graph_get_endpoint_count()
Message-ID: <aMxcID3zlI7SBBXP@smile.fi.intel.com>
References: <20250916160129.3955410-1-sakari.ailus@linux.intel.com>
 <20250916160129.3955410-6-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916160129.3955410-6-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 16, 2025 at 07:01:20PM +0300, Sakari Ailus wrote:
> FWNODE_GRAPH_DEVICE_DISABLED flag isn't used anywhere, drop the flag and
> support for it in fwnode_graph_get_endpoint_count().

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



