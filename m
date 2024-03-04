Return-Path: <linux-acpi+bounces-4091-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D99A870AF9
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Mar 2024 20:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6311C21099
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Mar 2024 19:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B22679DA5;
	Mon,  4 Mar 2024 19:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NHOnYNAQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551371E4AA
	for <linux-acpi@vger.kernel.org>; Mon,  4 Mar 2024 19:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709581751; cv=none; b=Xz++CbC4cDg0GmdHb48qsKGe4gFkhwbME4bfaExwPxvmYgdRwVstV83Yn7U7kmbE0jmGrSNOyIj0mk8EBy0leEPBAIJEdX6+bZpFTgkqlwZZptB6k87IPWNbfrBFYjNOnu82mpsEnX++ctPIrlVGUgEFWkzHfqbHFM9ne6yPlGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709581751; c=relaxed/simple;
	bh=YymLEp5xgfp+/jJESUfZXJFpxpEALaYNn+Msrd+/gwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tY7THE+57LYsGBeMAJDmW6aV1c6Q1vvV/010zpvcBXCzi/1xytT4YFTmHmozjvHvHC9i5vOQ+XrPs/yDZiLbkBL7a/iouI8YIFCzQuBtB7DVY09+oG4oY/CFCTCVWv5DhpKIkZjMprGbMChugLLlvrxVVNyQ/u6OFVkTcmo+7EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NHOnYNAQ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709581749; x=1741117749;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YymLEp5xgfp+/jJESUfZXJFpxpEALaYNn+Msrd+/gwE=;
  b=NHOnYNAQH+abghcgz8oHegWghQV5GzSAJRaO7QaiS8+Ss6XojBwP+JdR
   Hc2f7D907483NGgt9VExv4EFD0tE6EAQkOSdN6gkEa+lTlnW3d3vXJ/r/
   sjNTacr+YcCAxzyekZjmWkbxDkhCjlUchCMco9gIezvgHvGv0ecNa/jZ7
   mfou4ql4oUd4p+Pd7cerA2m+vFslyO6yY/X5hFNlRnypTO2v0di/RJ6FZ
   mr2fFwp1QAeT/VGwvXDhw4wCLmj7qpUT/ep/7J/+HWJEj8/jpzl+mwagk
   nyUk1yizhni7FZgBw7mGKj/2390zOB0t4sCVD7ozLaNnv4S5mYmbfIq93
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="29521735"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="29521735"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 11:49:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="914114146"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="914114146"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 11:49:06 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rhEJ6-00000009o62-1EaG;
	Mon, 04 Mar 2024 21:49:04 +0200
Date: Mon, 4 Mar 2024 21:49:03 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, rafael@kernel.org,
	linux-acpi@vger.kernel.org, robert.moore@intel.com,
	amadeuszx.slawinski@linux.intel.com
Subject: Re: [PATCH v5 1/4] ACPI: NHLT: Reintroduce types the table consists
 of
Message-ID: <ZeYlrwqDQLAcFcnl@smile.fi.intel.com>
References: <20240304161335.1734134-1-cezary.rojewski@intel.com>
 <20240304161335.1734134-2-cezary.rojewski@intel.com>
 <0d1b777e-bd95-4755-8e4c-ee37640d155b@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d1b777e-bd95-4755-8e4c-ee37640d155b@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 04, 2024 at 10:57:39AM -0600, Pierre-Louis Bossart wrote:
> > +/* Values for link_type field above */
> > +
> > +#define ACPI_NHLT_LINKTYPE_HDA			0
> > +#define ACPI_NHLT_LINKTYPE_DSP			1
> > +#define ACPI_NHLT_LINKTYPE_PDM			2
> > +#define ACPI_NHLT_LINKTYPE_SSP			3
> > +#define ACPI_NHLT_LINKTYPE_SLIMBUS		4
> > +#define ACPI_NHLT_LINKTYPE_SDW			5
> > +#define ACPI_NHLT_LINKTYPE_UAOL			6
> 
> More than half of those values are not used. Is there really any benefit
> in exposing them?

Sometimes a code is the (only) documentation. Since it's a global header and
part of ACPICA we probably better to expose all bits that are defined.

-- 
With Best Regards,
Andy Shevchenko



