Return-Path: <linux-acpi+bounces-12703-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C495BA7A8EB
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 19:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B0F11896F09
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 17:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA242517BF;
	Thu,  3 Apr 2025 17:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pn2ybXL0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2712924CEE8;
	Thu,  3 Apr 2025 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743702907; cv=none; b=P+aUP376jX6CH5VuymRn4f1/pOPN29CTS4IVVBCdy6Vhw1AZ5cWSDPn5HH2yr5FNtP2k0Z5gomo5j83dS0GjXLuGd+d0Stdg4DQR1hWsif0JTm0O01GivtcNiOR06MQ7BW9oKKY9EW9faVbpIJTCQOHCdyyXh2N5D5XtAQUSnc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743702907; c=relaxed/simple;
	bh=i7EwGuFwl7cxoGntAnpzoanOk0CDEIKNdoMN1vfuPCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USfl9N48YzFb1jIyIByAS+DtMCbsOmvM4+RSyrURb6ZIHWE+4UNGKtBST7YeKi/e/+h6B59Vbm2z5yk5OjtVPf2EkShDmxjPhY9+lDU57D8JOpcwFMNy71uvH57LFom5QLuYttykN0VQTmdmSgC1IfiRVG4sAzLPAYeuNTxq+VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pn2ybXL0; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743702906; x=1775238906;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=i7EwGuFwl7cxoGntAnpzoanOk0CDEIKNdoMN1vfuPCk=;
  b=Pn2ybXL0SN0I5uaeShEveU1rQyVuDjUqztN9y6lZ3W59qmA3C7nyHgNZ
   19K9sEU+oEofrsO/k95K281oTmoc8QajbUF6S3FEyUPvIUPf73nIdf7eM
   LBjjw59lubLcedX7QWNS6goTuNu7fYqMt/BO89o1I23M/ayjMTTRbKGkA
   HOaU4VkrazEr1k4FDWETdnB3AOHjG5ihQ7rUnh6UKUOVyjUXHyCQ9zmyE
   YYffqluE8eB6PYnMWLF6eCHTEtrdfQAkLRuXa14H1wswqejGe0EBTbcbU
   JaEep/Gvdi0RvVA8fcCkQRMwuNd6mYbW0CTf7MO4P0XC8zDo1dTTLXnRX
   w==;
X-CSE-ConnectionGUID: E91Kj7ESQ4ulhBfAgZPJtw==
X-CSE-MsgGUID: AdL34zbVTaGD8/ucQuzW9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="44381573"
X-IronPort-AV: E=Sophos;i="6.15,186,1739865600"; 
   d="scan'208";a="44381573"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 10:55:05 -0700
X-CSE-ConnectionGUID: jpxGc3sWSNCcv1IrutrHKA==
X-CSE-MsgGUID: DShBMFNNTBimd6qc3vw2xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,186,1739865600"; 
   d="scan'208";a="126881481"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 10:55:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u0OmH-00000008szH-1Emp;
	Thu, 03 Apr 2025 20:54:57 +0300
Date: Thu, 3 Apr 2025 20:54:57 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rob Herring <robh@kernel.org>
Cc: Remo Senekowitsch <remo@buenzli.dev>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Dirk Behme <dirk.behme@de.bosch.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 03/10] device property: Add
 fwnode_property_read_int_array()
Message-ID: <Z-7LcXoGw7uNWBUE@smile.fi.intel.com>
References: <20250326171411.590681-1-remo@buenzli.dev>
 <20250326171411.590681-4-remo@buenzli.dev>
 <Z-UPJyD41LOMM3o2@smile.fi.intel.com>
 <CAL_Jsq+tJvGsbw1dGdgmBM8+cL4vN71OMTvX9tkmBLNk=6T9KQ@mail.gmail.com>
 <Z-60LwRrw30cq4YE@smile.fi.intel.com>
 <CAL_JsqKiYCh7ukDoqc_toyn75=3wOM4WyOTGvogoOfdz9T_7Ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKiYCh7ukDoqc_toyn75=3wOM4WyOTGvogoOfdz9T_7Ow@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 03, 2025 at 11:36:38AM -0500, Rob Herring wrote:
> On Thu, Apr 3, 2025 at 11:15 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Apr 03, 2025 at 11:04:32AM -0500, Rob Herring wrote:
> > > On Thu, Mar 27, 2025 at 3:41 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Wed, Mar 26, 2025 at 06:13:42PM +0100, Remo Senekowitsch wrote:
> > > > > The rust bindings for reading device properties has a single
> > > > > implementation supporting differing sizes of integers. The fwnode C API
> > > > > already has a similar interface, but it is not exposed with the
> > > > > fwnode_property_ API. Add the fwnode_property_read_int_array() wrapper.

...

> > > > > +EXPORT_SYMBOL_GPL(fwnode_property_read_int_array);
> > > >
> > > > I'm not sure about this. We have a lot of assumptions in the code that the
> > > > arrays beneath are only represented by the selected number of integer types.
> > > > This opens a Pandora's box, e.g., reading in u24, which is not supported by
> > > > the upper layers..
> > >
> > > We can probably drop the export if it is just that which you object to.
> >
> > Yes, this is main point, but dropping it does not prevent from still using in
> > the complied-in code. Is it possible to hide it better?
> 
> Don't put any declaration in the header and declare it in the rust
> code? But lack of declaration generates warnings.

Exactly. And I believe we have the typed versions of int_array for a reason.
Otherwise what's the point in having them to begin with?
(The first what comes to my mind is a compile time type checking, so we don't
 try to load u8 with u32 data or any other dirty tricks.)

Maybe it deserves a header that can be included explicitly in the rust stuff
and being checked at compile time to avoid people using that? Can we achieve
something like C preprocessor

#ifndef FOO
#error This header must not be included directly
#endif

> Also, all the backends will reject an arbitrary size. So your worry
> about u24 or other odd sizes isn't really valid. But if you want to be
> doubly paranoid for when we add a new firmware backend (shoot me now),
> you could move this from the swnode implementation to the fwnode
> implementation:
> 
>         if (!is_power_of_2(elem_size) || elem_size > sizeof(u64))
>                 return -ENXIO;

That might work. But still an interface of int_array seems lower by
level than typed ones.

-- 
With Best Regards,
Andy Shevchenko



