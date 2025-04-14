Return-Path: <linux-acpi+bounces-13001-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE847A878A2
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 09:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8854A1891892
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 07:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906C4257AF9;
	Mon, 14 Apr 2025 07:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MUkPppkn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2768D1A262D;
	Mon, 14 Apr 2025 07:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744615427; cv=none; b=RAef56NVJfgduEfdl34QrhCwKQ/aOkGw+Zi8LxkWxB699TZNabZ9webWTdNBTFJJh2avcW1sxKrZCfSCWj4g58A63J770tx3Ub0BUUvGHnaBeb/CrS8YrdL344IZVPAZ7HY3wU+FhkBhkl0vhAyMwruvbRmzsLuilCNnvxJXij0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744615427; c=relaxed/simple;
	bh=cUrt5mJLbXrKmQGMvJKk7JPkt3sc9/OHg4xCrAJQAZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WntWj9Bv5S/5CC6mvJpzJuyRlXdGL+ZFY3WTvMQHVIfJHKrtDxlto47+cRnGKJYbjS/PBC/rxEEcan4m6vbxQF1OGnO+cgbXtEdXW0TyagpFQYUA7W2ggjbOAAonvqyqMFUqbonpW0tmx7LQSwvNLnw9JmzlykiReFGkfRqN+Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MUkPppkn; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744615426; x=1776151426;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cUrt5mJLbXrKmQGMvJKk7JPkt3sc9/OHg4xCrAJQAZE=;
  b=MUkPppkn7H2w4dUx5qJddn8VgN7rxk2ekNCiclEK+6LHyfmdkB7ak6tJ
   zQusHQnccfCFAJYpHq9ljAULItu1qti3zDmjWKhBlKV9gWJx2dl0LMzem
   hfJAkPCUJL+9H+x3raqIajlN9eiJJpjEs1LSnlfw5NdGLZMIrGKHN4xFN
   Z8kybeYXa7f55YIC2hi8+4iAwFyV3yG73AvY+jVZfJwW1bs6O5cEvZmMW
   Rmx1fcQ/aBWz2z7+I+yaOTj8she3ON1dfN8btcS8OHX07mt1TXHXVz5M4
   IvkUR9BqVYbnO3ibfUyRv47c2XGJe2AwyGeek6qzSVoz6OB4XWPnsP9Ig
   A==;
X-CSE-ConnectionGUID: dvtqQdZpR+ucv1VQUf6l/Q==
X-CSE-MsgGUID: jnAGB5gHTq6zOgV/7eg1Kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="57440912"
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="57440912"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 00:23:45 -0700
X-CSE-ConnectionGUID: I8bsgI+zRQ2cbudfBXJ1hw==
X-CSE-MsgGUID: zpkY+x8lRsyylCFNEbgZJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="130290763"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 00:23:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u4EAO-0000000CAA8-06Bi;
	Mon, 14 Apr 2025 10:23:40 +0300
Date: Mon, 14 Apr 2025 10:23:39 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH 0/2] software node: bug fixes
Message-ID: <Z_y3--XmbgLHjTKq@smile.fi.intel.com>
References: <20250410-fix_swnode-v1-0-081c95cf7cf9@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410-fix_swnode-v1-0-081c95cf7cf9@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 10, 2025 at 09:12:10PM +0800, Zijun Hu wrote:

If it's a series, cover letter is on purpose. Please, explain what's going on here.

> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

-- 
With Best Regards,
Andy Shevchenko



