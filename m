Return-Path: <linux-acpi+bounces-13073-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 853F9A8B0B3
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Apr 2025 08:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4893B5A11E7
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Apr 2025 06:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D4822D4E0;
	Wed, 16 Apr 2025 06:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i43feLzF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798C422FAC3;
	Wed, 16 Apr 2025 06:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744785719; cv=none; b=EuHXuOwcJmRFV0MQwXkKRjLmr+kbVj28CYsFENW9xflonqLczFC04o2CIcLfTtZzTCG/aBBMBPPFkY85vZKFa1uwixm6w4EBsQzh0lSoKXH5MSOf74jG2x3RFg4NTUG5n+ST3+wg/OOk56/EC03L+ZfoZ9vvOwGblIUsmUNRpFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744785719; c=relaxed/simple;
	bh=AeRn7fulkB1n4W59L2MZEekvvgPH6zRJiKzKmIqW6aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWmFCOQ2xocPqvW0D67L/W2DfU1rdfq8yQj+Qn+NtzV5meYMy/ECxbDVLCL1JBeMCUYFDu1viiwrTSIVnwgD+Cb+Y77/u7MLWui8Pl3tFVa1bw9FE5MGQ9eO9NvWN6PuWMHW7ZB1VrzOgvP9v1IDfkdWbe7/sxlzQpcWka0N4P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i43feLzF; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744785717; x=1776321717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AeRn7fulkB1n4W59L2MZEekvvgPH6zRJiKzKmIqW6aw=;
  b=i43feLzFrzNVTW7HzRcWcCLwZTSirESmYfvi5RF8MsU3yMxKiypWmCjo
   jBqr7YXEqUTJ4wJuTXVXfIwD3A6aMtoSVNRnfpNcxZQ7P4R0IBAPQwKGh
   9sIl72dsaoQyme9r6tlgb2uk+rJc46pZIORu26U0JJHnTueDP5UXB983r
   pNkROESlDSlPJqvKcRYbNvL2qtGXOKJmZcAHh2sGWdIhsaWI/enrl+HvD
   qNjMbJZaWUlOr+cbXVBgz3hqud5kkyzkQPx9fcnDsxM/Xf+9Ib50KCZY6
   GSmgkZky5q4Xa8nyIHnk2t/iU0MnVMziXhTsPWSRtGHJPOnQPvfiyQuWq
   w==;
X-CSE-ConnectionGUID: R8/3wUfRTdWSRrxufGfmgA==
X-CSE-MsgGUID: Plx0TIWzR/SAgT0EJPD2AQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="46207923"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="46207923"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 23:41:56 -0700
X-CSE-ConnectionGUID: Tt4BfcoNTQmyzsjcWD/akw==
X-CSE-MsgGUID: oaqcrxsxRXGfJoFx3e1ATw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="131262498"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 23:41:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u4wT1-0000000Clfh-27jh;
	Wed, 16 Apr 2025 09:41:51 +0300
Date: Wed, 16 Apr 2025 09:41:51 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] property: Use tidy for_each_named_* macros
Message-ID: <Z_9RL4knM4vXrOff@smile.fi.intel.com>
References: <Z_ew4DN0z71nCX3C@mva-rohm>
 <Z_yvNl23GcEpOkK1@smile.fi.intel.com>
 <Z_yvkKTgI4XSlGya@smile.fi.intel.com>
 <20250414201450.43fb8d9c@jic23-huawei>
 <0d470203-fe9c-4bc0-b487-6d638c006232@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d470203-fe9c-4bc0-b487-6d638c006232@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 16, 2025 at 08:55:13AM +0300, Matti Vaittinen wrote:
> On 14/04/2025 22:14, Jonathan Cameron wrote:

...

> > Definitely not going to take anything
> > through IIO that hasn't been on the iio list btw.
> 
> Ah. Thanks for pointing this out Jonathan! I just used the get_maintainer.pl
> - and added You. I definitely should have added the IIO-list!

Also a side note, the Subject should start with "device property: ...".

-- 
With Best Regards,
Andy Shevchenko



