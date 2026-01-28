Return-Path: <linux-acpi+bounces-20705-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMqeFcrSeWlCzwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20705-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 10:11:38 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9139EACB
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 10:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E7EC300139C
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 09:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA62D33F37C;
	Wed, 28 Jan 2026 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jr4POA5p"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653AF33F375;
	Wed, 28 Jan 2026 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769591452; cv=none; b=OJBpenrtHeC1p7FyKAnHPSzaRKeQipnUtZfoTgzkxTTDrZmxPlNq+trlWHsdloAPt/M6btoEluNkZrrhZzB8rtpImRkl//S3lZa6qF4jLd0GNLSdNI3xRnaYHWgqfxjC/K0YkQ2vEIbcGqBbBSIW9m0xTfPx82vnVtFR9WJQo18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769591452; c=relaxed/simple;
	bh=ZjvafvHGrsoREp76sQmuFuxDf9DKKzuVLt4vSY5tlkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjzhDBv1U4IvBmSLHU1pG2Od8Smy0Yv1Tle/vLuop1IJ135DJrLzkxKTofPv4KvEUAiSmezMitHhXaYmql4OZXTmGpCVJO/vtWwfRLrBft1ISWwcIspTk6o4zhmjF+Se41tEA0KhTvkWi6HKumhEbXDRP8AnJYyBkPJ0uQsYqB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jr4POA5p; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769591451; x=1801127451;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZjvafvHGrsoREp76sQmuFuxDf9DKKzuVLt4vSY5tlkc=;
  b=Jr4POA5p9RnRe2+zSGu4XVNajxOEegsQW++XLjbTV3vjLBw/J9HP8455
   4Sbscmu+0Tu+pJ2327BeBoJIbS/Gw5kWzfFPPfC0FDaoB91Nh7lnUlxQS
   S4soe0eyGWo1G+2zMVmAATfjkGBxrRzX60bcdG0OVmXqUuJAYw5PXFqLs
   DesoW+OE9D3ubMNjg1AbzKYeEVuEVwyQ9BQdehGdwfhsN2PDzrbjSY3x+
   xzndcw1JYwBm689rY8mDeN84Jm25Pf2xX+r2OmV5Irpcw62eIwRMe+MnV
   Xt9SJePdl9ot3iuan+3bb4yAzz0MqYUn6ASvgstOmJ2kICiQ2jWMWI1Dl
   A==;
X-CSE-ConnectionGUID: /AB8brDeR0miqa8/AE198A==
X-CSE-MsgGUID: PSdHjLZ7Qi+YFGn1FoC+BQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="69814711"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="69814711"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 01:10:51 -0800
X-CSE-ConnectionGUID: KqjXb3D5QdSDwI/Y/lNCuQ==
X-CSE-MsgGUID: f4TtDGrLSYeOAK99HauECA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="239470188"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 01:10:49 -0800
Date: Wed, 28 Jan 2026 11:10:47 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Mika Westerberg <westeri@kernel.org>, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 1/1] gpiolib: acpi: Fix potential out-of-boundary left
 shift
Message-ID: <aXnSl20A2RD4RsfV@smile.fi.intel.com>
References: <20260127110824.4020130-1-andriy.shevchenko@linux.intel.com>
 <20260127134300.GK2275908@black.igk.intel.com>
 <aXjCfwnnASFZ1Ghh@smile.fi.intel.com>
 <CAMRc=Me=TFk6XZtLJ9XGBdYtQRb=-tLqXy+x7mteBe8ANvqEKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Me=TFk6XZtLJ9XGBdYtQRb=-tLqXy+x7mteBe8ANvqEKA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-20705-lists,linux-acpi=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smile.fi.intel.com:mid,intel.com:email,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D9139EACB
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 01:02:11AM -0800, Bartosz Golaszewski wrote:
> On Tue, 27 Jan 2026 14:49:51 +0100, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> said:
> > On Tue, Jan 27, 2026 at 02:43:00PM +0100, Mika Westerberg wrote:
> >> On Tue, Jan 27, 2026 at 12:06:30PM +0100, Andy Shevchenko wrote:
> >> > GPIO Address Space handler gets a pointer to the in or out value.
> >> > This value is supposed to be at least 64-bit, but it's not limited
> >> > to be exactly 64-bit. When ACPI tables are being parsed, for
> >> > the bigger Connection():s ACPICA creates a Buffer instead of regular
> >> > Integer object. The Buffer exists as long as Namespace holds
> >> > the certain Connection(). Hence we can access the necessary bits
> >> > without worrying. On the other hand, the left shift, used in
> >> > the code, is limited by 31 (on 32-bit platforms) and otherwise
> >> > considered to be Undefined Behaviour. Also the code uses only
> >> > the first 64-bit word for the value, and anything bigger than 63
> >> > will be also subject to UB. Fix all this by modifying the code
> >> > to correctly set or clear the respective bit in the bitmap constructed
> >> > of 64-bit words.
> >> >
> >> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >>
> >> Perfect, thanks!
> >
> >> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> >
> > Thank you!
> >
> > Bart, since you picked up the patch in the same lines of code, feel free to
> > take this one on top (I think it's your gpio/for-current branch).
> 
> Don't you want a Fixes: and Cc: stable tags?

Okay, I will add them in v3, thanks!

-- 
With Best Regards,
Andy Shevchenko



