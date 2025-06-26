Return-Path: <linux-acpi+bounces-14690-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C06AE9E9E
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 15:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9D2A7B4056
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 13:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002F028BAAF;
	Thu, 26 Jun 2025 13:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lhmF4cTC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1306E28BAAD;
	Thu, 26 Jun 2025 13:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750944253; cv=none; b=sTSVgt2ahJ1dOhgKIcXRIjS3W5VgVCB4NrhJonbpGtzHCaZAiT6FYJnB8nvftMtQ9HDghfwKCyWLVnJjdNYTihK5oDElrI0NGbgQFBNTSQGFaLd2Cww4kih4VobMtjJzKR2P827Qd2HMvUEVASx7igrv/PpB9ulPNeGoxb232jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750944253; c=relaxed/simple;
	bh=3al9fOG3/r7w7sBJN6SUAg1aITJLdTwo3biIRx5Cp+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/Ps0GbVOvogZSkgwV7QsRIvmUcQhJ66n2PkUB6CUM6ZX8XxkrStkXmKgTF6hiOuCGhEE1lHwdliwVGrnXnYY5cry6bJi3p/WHrs1LA+s6z2bw/UwV9r4378jFsiEWjrD/3lYB2n8ohIVGEBLsXA/xKM83KWxTt4bo+kk5daWsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lhmF4cTC; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750944252; x=1782480252;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3al9fOG3/r7w7sBJN6SUAg1aITJLdTwo3biIRx5Cp+E=;
  b=lhmF4cTCNIWHg5JwaVmW+mZrhgP/4tUeLdDXfYx/OOZ1kHfsSUzUfttk
   NMobL7zVFeMBf1J26Z/rR7F0qM1Blm/ja9RVpqAIktKms24gtAgXs9OQN
   p9fT7X7WNKOCTX/24B1/9YZgV6sKEYzW+fVftgbu7EVFinMN++J6C7Ivt
   be9R+M1Q6UxlA9oKgxAuckomA+l2GUCI9kjE7fjnKOhzDi1hg5KQvD0fJ
   jTJPWGyMOq0L9OtqLcu3/B8PArZoppJKGsqt8n+knvS4c7v62wZcXlf/E
   dn1YBQoG2xU6gCyce5K07JcE3b3WYS8Qs41paTtAgqTM+T7Ur/SG/T9KY
   g==;
X-CSE-ConnectionGUID: NDYX5TiPTRicvkQBCrmpYQ==
X-CSE-MsgGUID: Nvid1xegRs+IZpKNEXMc3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="64593631"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="64593631"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 06:24:11 -0700
X-CSE-ConnectionGUID: kVjD+i/TS0yhD6Z2zO2w/w==
X-CSE-MsgGUID: uxmeEAUDQGyjLyb+vdrXnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="156552267"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 06:24:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uUmaF-0000000ABaz-1YJs;
	Thu, 26 Jun 2025 16:24:07 +0300
Date: Thu, 26 Jun 2025 16:24:07 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] ACPI: LPSS: Remove AudioDSP related ID
Message-ID: <aF1J95lLvRFC55NT@smile.fi.intel.com>
References: <20250625172133.3996325-1-andriy.shevchenko@linux.intel.com>
 <38ab3fb5-6d1a-491b-ad20-08066b007a28@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38ab3fb5-6d1a-491b-ad20-08066b007a28@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 26, 2025 at 09:54:21AM +0200, Cezary Rojewski wrote:
> On 2025-06-25 7:21 PM, Andy Shevchenko wrote:
> > The AudioDSP drivers are in control for all functions of the hardware
> > they have (they are multi-functional devices). The LPSS driver prepares
> > for enumeration only single devices, such as DMA, UART, SPI, I²C. Hence
> > the registration of AudioDSP should not be covered. Moreover, the very
> > same ACPI _HID has been added by the catpt driver a few years ago.
> > 
> > And even more serious issue with this, is that the register window at
> > offset 0x800 is actually D-SRAM0 in case of AudioDSP and writing to it
> > is a data corruption.
> > 
> > That all being said, remove the AudioDSP ID from the LPSS driver,
> > where it doesn't belong to.
> > 
> > Fixes: fb94b7b11c6a ("ASoC: Intel: Remove SST firmware components")
> > Fixes: 05668be1b364 ("ASoC: Intel: Remove SST ACPI component")
> > Fixes: 7a10b66a5df9 ("ASoC: Intel: catpt: Device driver lifecycle")
> 
> Hi Andy,
> 
> A nitpick:
> 
> The fixes tags used here seem incorrect. The catpt-driver replaced its
> predecessor (the haswell driver) providing no interface changes. Usage of
> INT3438 ID has been introduced with commit c2f8783fa2d0 ("ASoC: Intel: Add
> common SST driver loader on ACPI systems"), if that's what you have been
> looking for.

Okay, thanks for a hint. I will use that in v2.

> In regard to the code - the change has been reviewed by me and tested in our
> CI, no regression on the audio side observed:
> 
> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
> Tested-by: Cezary Rojewski <cezary.rojewski@intel.com>

-- 
With Best Regards,
Andy Shevchenko



