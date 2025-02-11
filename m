Return-Path: <linux-acpi+bounces-11014-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DBFA30BB1
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 13:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EE2C1889093
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 12:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A0E1FECDB;
	Tue, 11 Feb 2025 12:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G3Ze19AU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85361FCF74;
	Tue, 11 Feb 2025 12:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739276701; cv=none; b=eMksGiVxLsABu2l4PGgg0erR4h3qJuAC0S7NGQQOxzK9Nk/BqObqBj3Ca2ip691IkxKniubbgeNo0w+TjslBF842GCQbOZeZvjfXPdjY/ZZYYE+vknSz5xvbS3E5ULhRWtezMBDo4EImwP7QCnnzuHY6670GkLzB5C2gXvXUkgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739276701; c=relaxed/simple;
	bh=KKwH8cTWQdg72u9iuV44XMyK60o1CkTP3rPPIH2xEJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpgTS5lCfhQkhIlR3w1fsec8K7rSsl/H5cVER5bnhcSr85EHo8uJRdXucc35Rupflb1tzCk9Dv1eCW4k3xZ9oyGA1LrAZzSJNj8kgqtQRB0eK0W1nKU45fTDtcrs/+EAO2CQ2jkUgDWjrY50IIlGd18gRFJaChBhBEVyDJjnOW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G3Ze19AU; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739276700; x=1770812700;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KKwH8cTWQdg72u9iuV44XMyK60o1CkTP3rPPIH2xEJ4=;
  b=G3Ze19AUyoTbLa9I5p6Oz885CnzR+/itgz00J7YMKzC+V54d+sm+oJgS
   i84M0hi+AJdMrK/I/lJUgYliTs6XDscQMGQN7TNUxbCMmywknwwKETgED
   HpnSKp/fFmjJRWZiz7jYTooCB4Pgtbp88fLV8HhttU3biNyHQY/1hCbAP
   i4rsOJvgudV3QqZhnPZC9VfidyTroNjs+bpr/mL7Oh16eNf0RUmjHGKMA
   xpylVU1acubFdmdj1fOmdLcJ9m6YwCSv0DDQHQBOX/QvppH3i3fca9sik
   olTdfG+JNJLhpMDZgkZ3Q/s7cpt6OSg0E9V88THSXenbULqs7ic4W4RVB
   g==;
X-CSE-ConnectionGUID: /q2qBiPATzWaED3T6iworA==
X-CSE-MsgGUID: zCEfB2RcQ+CWH48YGfph/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="50526934"
X-IronPort-AV: E=Sophos;i="6.13,277,1732608000"; 
   d="scan'208";a="50526934"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 04:24:59 -0800
X-CSE-ConnectionGUID: tOPkTJt2RCKKUDh+wkannQ==
X-CSE-MsgGUID: g8czO5c8TRunR88KbGD3Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116580780"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 04:24:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1thpJt-0000000AV65-2ynZ;
	Tue, 11 Feb 2025 14:24:53 +0200
Date: Tue, 11 Feb 2025 14:24:53 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>, Len Brown <lenb@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v3] of: property: Increase NR_FWNODE_REFERENCE_ARGS
Message-ID: <Z6tBlfmTFu9916LA@smile.fi.intel.com>
References: <20250210-fix_arg_count-v3-1-a084a5013008@quicinc.com>
 <Z6oclML_DC1Vnf6z@smile.fi.intel.com>
 <73eb84f3-8b9d-41f4-9b59-d059111a3d03@icloud.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73eb84f3-8b9d-41f4-9b59-d059111a3d03@icloud.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 11, 2025 at 08:20:03PM +0800, Zijun Hu wrote:
> On 2025/2/10 23:34, Andy Shevchenko wrote:
> >> It may cause firmware node reference's argument count out of range if
> >> directly assign DT node reference's argument count to firmware's.
> >>
> >> drivers/of/property.c:of_fwnode_get_reference_args() is doing the direct
> >> assignment, so may cause firmware's argument count @args->nargs got out
> >> of range, namely, in [9, 16].
> >>
> >> Fix by increasing NR_FWNODE_REFERENCE_ARGS to 16 to meet DT requirement.

...

> >> -#define NR_FWNODE_REFERENCE_ARGS	8
> >> +#define NR_FWNODE_REFERENCE_ARGS	16
> > Thinking of the case, perhaps you also want
> > 
> > static_assert(NR_FWNODE_REFERENCE_ARGS == MAX_PHANDLE_ARGS);
> > 
> > to be put somewhere, but I don't think we can do it in this header file.
> 
> thank you Andy for code review.
> 
> yes. it seems there are good location to place the static_assert().
> 
> is it okay to associate two macros by
> #define MAX_PHANDLE_ARGS NR_FWNODE_REFERENCE_ARGS

I was thinking about this and I don't see how it can be done without
introducing more chaos (dependency hell) into the headers. So, I won't
take this path or even consider it deeper.

> OR
> replace all MAX_PHANDLE_ARGS instances with NR_FWNODE_REFERENCE_ARGS
> ?

This sounds plausible to me, but you need a blessing from OF people as
the naming may be a bit confusing (for them) as "phandle" is well established
term in OF realm.


-- 
With Best Regards,
Andy Shevchenko



