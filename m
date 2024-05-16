Return-Path: <linux-acpi+bounces-5865-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 777FF8C7493
	for <lists+linux-acpi@lfdr.de>; Thu, 16 May 2024 12:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182091F24B75
	for <lists+linux-acpi@lfdr.de>; Thu, 16 May 2024 10:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F10B14389D;
	Thu, 16 May 2024 10:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fNoQCKO4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6268214388A;
	Thu, 16 May 2024 10:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715855078; cv=none; b=jdjB3/qJ3gqmzdu9UWe46CFKapTNJylQ0yt76hKRGMrp2pjVZDAE/UNOtitzHgJ2JXx6HVGu6RyxXtvE46ePsKHxP1RgsbYlV1XG4II5MwfqTP9BdMHRKTEcKhbKomb1sN0TScdFpK13MFG/yNy59l7W2HOiIQnlTk2jXfQIyfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715855078; c=relaxed/simple;
	bh=tbwbFxoda4n29a6HTG7mVjGRU4BB+ruKHjA9NThZsSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaDKWbv8+lx87L+BCYhjC3dqj9J+7pOY8rRpJCdUdxEOFc8YPuVIsKq/4oj6m+a3kLgQaY2EMnzMYhLraHRPZO/TLMIIvhlVJCJdTr5RrHTpxujE+fh9lvC16Eb9PNgzy6ORZ/uk+Cz2STToQ/DQ4JeNHH2EOsSS9qjt5TAg7+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fNoQCKO4; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715855076; x=1747391076;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tbwbFxoda4n29a6HTG7mVjGRU4BB+ruKHjA9NThZsSE=;
  b=fNoQCKO4S7KE8+CJnN4Orp7L2Zf+kax2inBAFVmiswxNrWwRjo9Qh+uV
   9O2ab6PHKJC4KJaPM/JuKWFwYRxt9V9dlC5sU7LxsjrPG3BnwmkVafPCG
   PiNaQvbnTjk/WXuaM5w8FbAIVmaUFFrZTRfx+PO6HPcrOQR4Aa40K9czg
   GadY66ZLqNsGs98USC8vtiyk6gVBqE4Usrb/DjFmdV1hbgr1FIhHslxYu
   l7rCPcWC9eiFfEoQ+NlWqPWR7AiGfG/fpX/KjhM5JzpDfMHVG+Npe3uGb
   4sf7NcC5gTN2fj7WJNB77arlP4agMzKCW7hOaC+oTxSvNuGQCyJIjL8V0
   A==;
X-CSE-ConnectionGUID: pIC2bv+XS1i1b55+au/Pow==
X-CSE-MsgGUID: MCucpIL0Ssm3qXKr18mv4w==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="12165492"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="12165492"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 03:24:35 -0700
X-CSE-ConnectionGUID: pn2rNk/IQu6InMufb0x/nQ==
X-CSE-MsgGUID: cY4qZzFWSTmfooYOvVGIBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="35818983"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 03:24:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s7YHn-000000080Wy-0cni;
	Thu, 16 May 2024 13:24:31 +0300
Date: Thu, 16 May 2024 13:24:30 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Armin Wolf <w_armin@gmx.de>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2 0/2] ACPI: EC: Install EC address space handler at the
 namespace root
Message-ID: <ZkXe3m0DwToiixam@smile.fi.intel.com>
References: <12437901.O9o76ZdvQC@kreacher>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12437901.O9o76ZdvQC@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, May 15, 2024 at 09:39:15PM +0200, Rafael J. Wysocki wrote:
> Hi Everyone,
> 
> This is an update of
> 
> https://lore.kernel.org/linux-acpi/5787281.DvuYhMxLoT@kreacher/
> 
> which was a follow up for the discussion in:
> 
> https://lore.kernel.org/linux-acpi/CAJZ5v0hiXdv08PRcop7oSYqgr_g5rwzRTj7HgdNCCGjXeV44zA@mail.gmail.com/T/#t
> 
> Patch [1/2] has been updated to avoid possible issues related to
> systems with defective platform firmware and patch [2/2] is a resend
> with a couple of tags added.

FWIW, LGTM (and I followed the discussions around this)
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



