Return-Path: <linux-acpi+bounces-12684-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A5DA7A3B1
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 15:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E76F63A8B54
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 13:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047D724E00D;
	Thu,  3 Apr 2025 13:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZcRsrZXn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A05435942;
	Thu,  3 Apr 2025 13:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743686949; cv=none; b=KXTZy/VyEQFA3MEu++R7jTyDPtAUTdEZu625M1+6E3CJdUOzcTBD7H++Jd0bsaXPSpfQYIZsiXChESB8DOT8ydx4f5TyvZ7Rd+WKIgf6JRAaUz8zSSvYwlm0Fe1uNBpWjf8l9lJJU1evCb7vH+dgGY3wSgCcjOuUShYkV24l9+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743686949; c=relaxed/simple;
	bh=nt4GNb62EasvK8nbge9TkirgD7IhLXNL3w9iTDtAjqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTrDbxPhge6tg4ITfbAHGAYrO/Ei9T2mks0mwNS0KYn/6QIrTX34E22Ei5Qn/uvU3eqFC92X06bNghiAbYg+43f1GxRfwC7ZHMRxPCuTFT7JhGCFAQafFqgqdz+INLqqKs5p9ytlHDx9RWNqKB8lDojbBoueiyKfyoMkGFsyRgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZcRsrZXn; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743686948; x=1775222948;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nt4GNb62EasvK8nbge9TkirgD7IhLXNL3w9iTDtAjqc=;
  b=ZcRsrZXnLM/wb8x7AqpnPhWoPVx218wJjP3rv2auVYHoT4mNe7VHLXuM
   6gw9mp+AgygnY57lU3wzBUu1RacZ+WQ8xvtWu5Jx02TqxhwPgKXsm9pZT
   7PCqJorZbj0Ad8EkieUky1t+RTMYOlwjQoWSgk3gSyLnRHo8HSyIu5nv9
   evXWsyEp8L3hbXYC1BlMxSRNX9if2eCVX2l1nkmh+JEf6ht5BjvRALVWO
   R6WZhetqt9JQUwtm49dELFkMXXa5UApJ8/Sp/Vpd/NhSOCXN4Bb8UXiEV
   XzzBByCUmS0QOKYFI6JRsXmX9vUGGrpfR41F9D8BUPahlHINicCu4Naik
   w==;
X-CSE-ConnectionGUID: CcfFI1fpS5WDLdb1lRsZ6A==
X-CSE-MsgGUID: fGBt7lfjTzOvtsGQz4vPcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="44350164"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="44350164"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 06:29:07 -0700
X-CSE-ConnectionGUID: /T2NBRLJR5yatbCth9BFWw==
X-CSE-MsgGUID: uh/BkaH5REmuiPRhTanmIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="127856844"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2025 06:29:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u0Kct-00000008oyq-1MUl;
	Thu, 03 Apr 2025 16:28:59 +0300
Date: Thu, 3 Apr 2025 16:28:59 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Remo Senekowitsch <remo@buenzli.dev>
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Rob Herring <robh@kernel.org>, Dirk Behme <dirk.behme@de.bosch.com>,
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
Message-ID: <Z-6NG7fSfyKH-vW_@smile.fi.intel.com>
References: <20250326171411.590681-1-remo@buenzli.dev>
 <20250326171411.590681-4-remo@buenzli.dev>
 <Z-UPJyD41LOMM3o2@smile.fi.intel.com>
 <D8WA3WIHEQRN.3LQS84K8Z46OW@buenzli.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8WA3WIHEQRN.3LQS84K8Z46OW@buenzli.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 02, 2025 at 06:04:13PM +0200, Remo Senekowitsch wrote:
> On Thu Mar 27, 2025 at 9:41 AM CET, Andy Shevchenko wrote:
> > On Wed, Mar 26, 2025 at 06:13:42PM +0100, Remo Senekowitsch wrote:
> >> The rust bindings for reading device properties has a single
> >> implementation supporting differing sizes of integers. The fwnode C API
> >> already has a similar interface, but it is not exposed with the
> >> fwnode_property_ API. Add the fwnode_property_read_int_array() wrapper.

...

> >> +EXPORT_SYMBOL_GPL(fwnode_property_read_int_array);
> >
> > I'm not sure about this. We have a lot of assumptions in the code that the
> > arrays beneath are only represented by the selected number of integer types.
> > This opens a Pandora's box, e.g., reading in u24, which is not supported by
> > the upper layers..
> >
> >> +int fwnode_property_read_int_array(const struct fwnode_handle *fwnode, const char *propname,
> >> +				   unsigned int elem_size, void *val, size_t nval);
> 
> Here's an alternative approach using a macro to map each integer type explicitly
> to its corresponding read function. There are some additional changes that will
> be necessary to make the rest work, but this is the gist of it.

I don;'t know Rust to tell anything about this, but at least it feels much
better approach.

> +macro_rules! impl_property_for_int {
> +    ($($int:ty: $f:ident),* $(,)?) => {
> +        $(
> +            impl<const N: usize> Property for [$int; N] {
> +                fn read(fwnode: &FwNode, name: &CStr) -> Result<Self> {
> +                    let mut val: [MaybeUninit<$int>; N] = [const { MaybeUninit::uninit() }; N];
> +
> +                    // SAFETY: `name` is non-null and null-terminated. `fwnode.as_raw` is valid
> +                    // because `fwnode` is valid. `val.as_ptr` is valid because `val` is valid.
> +                    let ret = unsafe {
> +                        bindings::$f(
> +                            fwnode.as_raw(),
> +                            name.as_char_ptr(),
> +                            val.as_mut_ptr().cast(),
> +                            val.len(),
> +                        )
> +                    };
> +                    to_result(ret)?;
> +
> +                    // SAFETY: `val` is always initialized when
> +                    // fwnode_property_read_$t_array is successful.
> +                    Ok(val.map(|v| unsafe { v.assume_init() }))
> +                }
> +            }
> +            impl Property for $int {
> +                fn read(fwnode: &FwNode, name: &CStr) -> Result<Self> {
> +                    let val: [_; 1] = <[$int; 1] as Property>::read(fwnode, name)?;
> +                    Ok(val[0])
> +                }
> +            }
> +        )*
> +    };
> +}
> +impl_property_for_int! {
> +    u8: fwnode_property_read_u8_array,
> +    u16: fwnode_property_read_u16_array,
> +    u32: fwnode_property_read_u32_array,
> +    u64: fwnode_property_read_u64_array,

> +    i8: fwnode_property_read_u8_array,
> +    i16: fwnode_property_read_u16_array,
> +    i32: fwnode_property_read_u32_array,
> +    i64: fwnode_property_read_u64_array,

Dunno what these mean. Are they signed integers? Do you really need this kind
of types to be supported? Properties usually unsigned and I never saw (but it
doesn't mean they are not exist) the negative values there.  Does DT schema
even allow this? Does DT validator complain or not on the negative values
supplied in the DTS?

> +}

-- 
With Best Regards,
Andy Shevchenko



