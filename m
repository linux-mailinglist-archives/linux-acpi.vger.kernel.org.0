Return-Path: <linux-acpi+bounces-5306-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF0A8AE828
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Apr 2024 15:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7508C28634D
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Apr 2024 13:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EC3135A61;
	Tue, 23 Apr 2024 13:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z0cJSqw1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CAA6A03F
	for <linux-acpi@vger.kernel.org>; Tue, 23 Apr 2024 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713878983; cv=none; b=HG4ujnKNv9Be/z+BBxjni17664Md6uczdQSGN2EfWYi1R/hXz8XVR002cDUanuGTUUb8MLTAHQjjUiUlAaJ2YdUkkeFHBuFGA3UQCJ+J4cpwYSs2KBiTAR0NdDLiqcQUuPIv3DoEnJmNwiC0jpPjjYoPpEIicQWOY9u1O1/mtm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713878983; c=relaxed/simple;
	bh=yl9DW0ebbFk3z3GFnVqFjADXrYezulRUAe5oZAQQEXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASHoXymWa4d/vAY6j8cwxyTl7C5Md4pct7lnvw8QOpEoPkAETKgTjspPFt6PLsEp92wyt/uug4QJPW364whF6T/67uiirW1+aUduieOzEfk70FtcjKLgYt+zXq+U9P795HCPdC3cOTZgV1Dv3CF5GN2OEN4myipRQbxOK+qVNrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z0cJSqw1; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713878983; x=1745414983;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yl9DW0ebbFk3z3GFnVqFjADXrYezulRUAe5oZAQQEXg=;
  b=Z0cJSqw1ooXYQeo+IN7RfObfRT+yTA64kzAnHE6qx5/jH9+TAsTPWyoJ
   Y0/B/QpHlRTg4TQ6SpqvvJmfUTEiiKZvbL9+R1jSsWqll6FxCyweLQ+g6
   ue6KFhCSUT/sT2EeQ1Et+kRia0brbB0tiiyEqf9m/m4dUITZPa/aBbitB
   U3VjZtaC0gCz5hW3kEbUWKbtik3hWz5SWm3bCqCezWPmXNsMy2xF8DPLz
   PtjZj0Y/KkdUkoPRMD0sLdKOrquYRJJ+bX2xo+bCFcBj0HBssntaPM2XH
   DqFeNUBA9vbFpglRABEwCkwv3PnghTioxpFs2M02uo/d7DEE1DXe0WMi3
   g==;
X-CSE-ConnectionGUID: 4vMUPiP3Tw2YZlioKAidMw==
X-CSE-MsgGUID: U57oUkU+QO+h2VmW6JCZ4g==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="13294974"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="13294974"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 06:29:42 -0700
X-CSE-ConnectionGUID: PhvRZvAdRRClqAS6WbKJ/g==
X-CSE-MsgGUID: KAi+WOBERgaeftai8mzEZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="29033972"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 06:29:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rzGDJ-00000000LVf-3Hub;
	Tue, 23 Apr 2024 16:29:37 +0300
Date: Tue, 23 Apr 2024 16:29:37 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	mika.westerberg@intel.com, "Liao, Bard" <bard.liao@intel.com>,
	"Ujfalusi, Peter" <peter.ujfalusi@intel.com>
Subject: Re: [PATCH 1/1] ACPI: property: Add reference to UEFI DSD Guide
Message-ID: <Zie3wYZTub0mWTPC@smile.fi.intel.com>
References: <20240422181342.810350-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422181342.810350-1-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 22, 2024 at 09:13:42PM +0300, Sakari Ailus wrote:
> The UEFI DSD Guide specifies a number of GUIDs supported by the _DSD
> parser. Point to the DSD Guide in the documentation.

Makes sense to clarify, indeed.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



