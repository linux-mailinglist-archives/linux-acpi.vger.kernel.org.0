Return-Path: <linux-acpi+bounces-12492-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13680A72BB8
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Mar 2025 09:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDA583A6023
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Mar 2025 08:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8172080CD;
	Thu, 27 Mar 2025 08:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g4khsnWq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F62207E1A;
	Thu, 27 Mar 2025 08:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743064955; cv=none; b=g4Cdisp+yo6vTh/jUDSKtt1tnEdBUCgCyaw81Aoc9icD7XSsz43J8bpm81u3EIMbB8WPlUu8QD6ckVn1xC6mDdhj2B3tsQqrlxQPNB4YC+j3TyvP0oPNAOFsi8g/cppSUEIwybCVsLhbz9rrMN7pL5OotBL97SfcrQ9V1OViMb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743064955; c=relaxed/simple;
	bh=5tSCaAz2NsJi6ahE7aTkD3g57B970/0hHF2vx/pkedg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bh+2xTcs/WhItN93b5w1J4bsZVBRDFsjbUtrruQQYVa6556NqMYB2/Hm5Rw8X9OCrr7j6q9RgkvHY5UxV9O9ywvcI4qiC/MPzPIA0af74XILmrilB4HX+x8INluDXJdmU+/9b8AsF/GdYsLulEnIOIe2yknBOT0G69Oc5oO3U/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g4khsnWq; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743064954; x=1774600954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5tSCaAz2NsJi6ahE7aTkD3g57B970/0hHF2vx/pkedg=;
  b=g4khsnWqleLFCjFTanTsrf/aNl1XC9Xpm7L46f7h9mtyCBeUGEjrvCPd
   734OzS3OecmaAFCHeAmclZCVlMoGTDHPuwpxuMLEfTVZv5v/FPnHdRzBB
   e6EzpA0usNALHYNqsE0QMvCGRipJdHMZkxEzL7CwNvbW0CvLxAO7914Q/
   /n4ZKxCRfByojmwqKw2Tg0Ew2sxZZYgb68DuL+Ko+E0MHJOENDWFsnWUF
   0zXZMlaGWP/34BG/I03bTIa0NOyWZHb5HptkHQEA5hLdRKdews7iMjKxq
   9tIBvZXZ4vMkLoK5Gy3Z6tCNYBAviQXhZiCOga57O2f9J6u/3MHh1PKNq
   A==;
X-CSE-ConnectionGUID: DiqsYHLfRROv3sMHJSXw/g==
X-CSE-MsgGUID: js+ctgFETca6el5/RNVdyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44400683"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="44400683"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 01:42:34 -0700
X-CSE-ConnectionGUID: Ya0FaBlRQZOrqf4c4pQvaQ==
X-CSE-MsgGUID: rvLpX4iAR1G4OXYfWZCaCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="125003028"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 01:42:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1txioi-00000006KcK-2t3D;
	Thu, 27 Mar 2025 10:42:24 +0200
Date: Thu, 27 Mar 2025 10:42:24 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andrew Ballance <andrewjballance@gmail.com>
Cc: remo@buenzli.dev, a.hindborg@kernel.org, alex.gaynor@gmail.com,
	aliceryhl@google.com, benno.lossin@proton.me,
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@kernel.org,
	devicetree@vger.kernel.org, dirk.behme@de.bosch.com,
	djrscally@gmail.com, gary@garyguo.net, gregkh@linuxfoundation.org,
	heikki.krogerus@linux.intel.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojeda@kernel.org, rafael@kernel.org,
	robh@kernel.org, rust-for-linux@vger.kernel.org,
	sakari.ailus@linux.intel.com, saravanak@google.com,
	tmgross@umich.edu
Subject: Re: [PATCH 0/10] More Rust bindings for device property reads
Message-ID: <Z-UPcB6vnwBUs3FP@smile.fi.intel.com>
References: <20250326171411.590681-1-remo@buenzli.dev>
 <20250326205409.694744-1-andrewjballance@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326205409.694744-1-andrewjballance@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 26, 2025 at 03:54:09PM -0500, Andrew Ballance wrote:
> Hi thanks for sending these in.
> 
> On Wed, Mar 26, 2025 at 12:13 PM Remo Senekowitsch Wrote: 
> > This is my first time posting to the mailing list, please let me know if
> > I did anything wrong.
> 
> you probably will have to resubmit in the patch canonical format[1]
> 
> I would recomend reading the docs but in summary:
>  - all of your patches should have the subsystem in the subject line.
>  - patch 6 is missing a commit message
>  - commit messages should be written in the imperitive tone
>  - a couple of your commit messages give a reason for the changes but
>    do not have a summary of the changes

>  - for your v2 you should add a diffstat to your cover letter running
>    `git format-patch --base=auto --cover-letter` does this automatically
>    for you

Also -v<X> gives the proper versioning.

> [1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-canonical-patch-format

-- 
With Best Regards,
Andy Shevchenko



