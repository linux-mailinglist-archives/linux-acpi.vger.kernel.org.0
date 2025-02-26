Return-Path: <linux-acpi+bounces-11484-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBEFA4583E
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Feb 2025 09:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E15823AA315
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Feb 2025 08:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8ED520E302;
	Wed, 26 Feb 2025 08:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hLWhrehT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A8B1E1DE7;
	Wed, 26 Feb 2025 08:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558603; cv=none; b=EDw7Fc9zkME2Epc1YT9wZDUGjboxcwaFZ8AYR2CU9c6TU2LV4ODw1D10gxhMZ/HkKQoZusQsuCIAqm3sp2tJsqTzgrkhYG990Ql3pSS6dMCeAdrTtCXsOHcXuC6Z2Sh2QCjajsScVFEocGih/9KPl7g7rDMzfGZycZZqvEsM45Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558603; c=relaxed/simple;
	bh=EWSFMdl7MyfvZpem9KnI1HkP52VZvCbh4E+n398y4Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+A0HevZvQRjrgHzR9qB/DFiu1waI0/XVVZSvW+fXpsKJXNYzE847mY9OinoGUDGHk0ySYqIbd78zXwieVVP18fZAHfx+7Kl+ZITGUfUrvNjScr44jxJ+hOay0GmWSg9GopNbmoeH1TMTLIbSE03a6jg5dXUTDQlt0xvCxcpj3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hLWhrehT; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740558602; x=1772094602;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EWSFMdl7MyfvZpem9KnI1HkP52VZvCbh4E+n398y4Do=;
  b=hLWhrehT8JTN9Al+AEz4I0TvDCRQ1xIAEOsT0lwGAoKGRcjhdB7vCFm/
   sOOqzWxpZkmF0BjC/GbXcsfVhL0wwaSy1eUO3WHQi50jwx/ab6pFEVPOM
   XRF7F7kW7lXAyTZEEOZPb8OWOU8vnOyzh0/TwDLf9qQOkwRp0WMzIEhVe
   RDPTMSpR2wWYMLA8S7tbYpinp86OJEtsiikOxjBqIDELLL6/YtJ46HQAB
   a+bhIjiiDQ6t5KIM50DBIMTpXu8HqEINXydrFAiVsAxyzdaQZPkPghR/v
   XKAbcPTHiD+WwmZWZ42LaZgfivYPgrzKPc4jsHqfvullpznk3xtweDfD/
   A==;
X-CSE-ConnectionGUID: AftabeZOQryHc1Ei71TQMA==
X-CSE-MsgGUID: rPdsB4ORT/O/3umkm5AilA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41273001"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="41273001"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 00:29:55 -0800
X-CSE-ConnectionGUID: 7mrxZqYCTQepd9Hs2hE5GQ==
X-CSE-MsgGUID: LZ/rF57nSNi8xIEK6qegrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="116639621"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 00:29:48 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id B3A6411F944;
	Wed, 26 Feb 2025 10:29:45 +0200 (EET)
Date: Wed, 26 Feb 2025 08:29:45 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, Daniel Scally <djrscally@gmail.com>,
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
Message-ID: <Z77Q-eAGUayQdfpu@kekkonen.localdomain>
References: <20250225-fix_arg_count-v4-0-13cdc519eb31@quicinc.com>
 <20250225-fix_arg_count-v4-2-13cdc519eb31@quicinc.com>
 <Z73RssDaLZ1NLpSZ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z73RssDaLZ1NLpSZ@smile.fi.intel.com>

Hi Andy, Zijun,

On Tue, Feb 25, 2025 at 04:20:34PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 25, 2025 at 09:58:07PM +0800, Zijun Hu wrote:
> > From: Zijun Hu <quic_zijuhu@quicinc.com>
> > 
> > Macro NR_FWNODE_REFERENCE_ARGS defines the maximal argument count
> > for firmware node reference, and MAX_PHANDLE_ARGS defines the maximal
> > argument count for DT node reference, both have the same value now.
> > 
> > To void argument count inconsistency between firmware and DT, simply
> > align both macros by '#define MAX_PHANDLE_ARGS NR_FWNODE_REFERENCE_ARGS'.
> 
> I would add here that the of.h includes fwnode.h already, so it doesn't
> add any new compile time dependency.

It's included via property.h but I think that's fine.

> 
> Both patches LGTM,
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
Sakari Ailus

