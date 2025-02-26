Return-Path: <linux-acpi+bounces-11486-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E59EA45848
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Feb 2025 09:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EBDA173314
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Feb 2025 08:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC1F1E1E1C;
	Wed, 26 Feb 2025 08:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AgxYcLK+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0001E1E19;
	Wed, 26 Feb 2025 08:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558634; cv=none; b=Dc06yHHdXgOEVFvy896xfTl0zDu+TlX6L8P3xq/dHUwlzLDH0Fn8v2bqRczIUWUBFAHxQry45yrQyqLWr0aw1FqnMcX4F5roUXcLBRkT8A6JXpTjEInuOc1XWJCXmGmwyBa8iNjfmuT5cwip6jfCl+YWTA4DkgJzQuYNhvAabt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558634; c=relaxed/simple;
	bh=q18//s8n8pY2gsTThR86DC4iH15g7zncNdFsfg5rVOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/78sB/Yv4ANUudqbRXXLWU2q2WGzyfa+D9OrpdENaVd6xQD/9DlAxdVNNy7gBflyraHglKPAJgJHTw1yP9BoeGjwPFR1r+3GO3eA6DuTrX4bbku8wYtoUINpNoe+4+oivtA+FG7Qi7mIMS4fSC0YaFCpNwbf+Uv3BBhg0hm3nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AgxYcLK+; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740558633; x=1772094633;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q18//s8n8pY2gsTThR86DC4iH15g7zncNdFsfg5rVOY=;
  b=AgxYcLK+0pHsaVATMeM2yIoAEO4tyV8EOuIo41WoYQmfj2EpaKqWwC/D
   HGAlxj456cW0I59PD4de9w7gpjW5xQpLM+MHN3eNGayThGuBZ4pp6Bwms
   ASPhxg/HtpoJOMxktxCGXR6BumHrSIfp5icIFGsvqDaRQsXTRtWRypsZ1
   N1SUwz33VjFKqxL+DcQd/IA5WrfqhHKFA8gt76Kh6pXt6uSPGjqp48NJe
   s2m3MHZ0vltmmEdHSW5c7zB9PyedRhlX629g3Qw9Vv59WhMLGO3OEwgL3
   P3mFLOEOkhwkIYVoCckfO0g2Dr5P3AIvAwNlHJlceQKn/TIWgZXXT38GP
   A==;
X-CSE-ConnectionGUID: 0dHe5HTBTCOhv7EIhIM3bw==
X-CSE-MsgGUID: GI6edK7hToaujhlMD7M3Fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="45176357"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="45176357"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 00:30:32 -0800
X-CSE-ConnectionGUID: 2TV7sHHxSPShoc3oxu3twg==
X-CSE-MsgGUID: CnqJZI44QNizqN6m1bzo5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="117123195"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 00:30:28 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 06D0511F944;
	Wed, 26 Feb 2025 10:30:26 +0200 (EET)
Date: Wed, 26 Feb 2025 08:30:26 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v4 2/2] of: Align macro MAX_PHANDLE_ARGS with
 NR_FWNODE_REFERENCE_ARGS
Message-ID: <Z77RIg-i-_ZgMgJW@kekkonen.localdomain>
References: <20250225-fix_arg_count-v4-0-13cdc519eb31@quicinc.com>
 <20250225-fix_arg_count-v4-2-13cdc519eb31@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225-fix_arg_count-v4-2-13cdc519eb31@quicinc.com>

On Tue, Feb 25, 2025 at 09:58:07PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Macro NR_FWNODE_REFERENCE_ARGS defines the maximal argument count
> for firmware node reference, and MAX_PHANDLE_ARGS defines the maximal
> argument count for DT node reference, both have the same value now.
> 
> To void argument count inconsistency between firmware and DT, simply
> align both macros by '#define MAX_PHANDLE_ARGS NR_FWNODE_REFERENCE_ARGS'.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus

