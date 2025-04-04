Return-Path: <linux-acpi+bounces-12760-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDADA7C19C
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 18:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD14816FECA
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 16:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD70A20ADD5;
	Fri,  4 Apr 2025 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/kPjiBL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DEF1F867F;
	Fri,  4 Apr 2025 16:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743784546; cv=none; b=rnjuYB3eH5QbUvnX5VFJ741Wskcu7xrffsjyPNfZ0WD4WUvbBh8Hzup7s2NDRikO0xg7GlQWMDUwYd4eUHP6e+yldgl7gifX25f2VrZEn8ngHtzCcW29A1nx0WA+gwrlHHHVnErW7rRy1eWjr2k6AandUnBkTSrdobOrildPuwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743784546; c=relaxed/simple;
	bh=yax9FGKSQAu8nxfktLBz7x1X8hnXSFAvFkZzYLw6MnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NChahmx9L2jnnoQYJCahDaYsK2vlogd+NkNUWvtz4MQWe2YFBK9RHIp48X2wO8DtssgtfyfYK0GmFqVrUlSH+DaH4DIMsG+tA9QbxCbSVAR5z3dCrxge0o7ZFwyX5RsV2sO4ChaNAAUGbgfLexVpEfav/2e2jvXV0xlYJj3gCoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/kPjiBL; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743784545; x=1775320545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yax9FGKSQAu8nxfktLBz7x1X8hnXSFAvFkZzYLw6MnQ=;
  b=a/kPjiBL08GFwyAbTlCwCSlyx3GD3PNeZNxqYCq3xnjbJbgIGaNBkgmg
   MIXJluSvATiFxoX2wozFLg5MLBtbXIaXNhBmah7aNV+RgS/+HXJd6Xi4q
   6tuARRGOYGT/uDY8CTOp9wXmt/Smvs0IHwKBYZhJlOe5a7PBEAvgAY014
   pnGK/S9KHpLycRFKOMOGUKFBqb3X8wugeddFqEkw+KoruzjTRRlLjKZMx
   I1jjvXBaNdCHMX6wzItcZXTw2qs+FW7Ov7K6cOEIkfngdra76zQrp+JXC
   urjIqnVRnEANXVSaT1Slu/9Y5tDvFBD9AYzCTfKwf0yNkr6GRKAEteGta
   g==;
X-CSE-ConnectionGUID: /7KY+7/PR4CIKWSAiGDlcw==
X-CSE-MsgGUID: TonZY/LuRvWJxZPxWNdO0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11394"; a="56598103"
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="56598103"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 09:35:42 -0700
X-CSE-ConnectionGUID: bYNXK64lSGC2SglxjgP0dA==
X-CSE-MsgGUID: OgxCq2u0Q4C3eHtDGkPQmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="127340745"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 09:35:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u0k0z-00000009CLA-3FP7;
	Fri, 04 Apr 2025 19:35:33 +0300
Date: Fri, 4 Apr 2025 19:35:33 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rob Herring <robh@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Remo Senekowitsch <remo@buenzli.dev>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Dirk Behme <dirk.behme@de.bosch.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
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
Message-ID: <Z_AKVcR_otZj6Q_G@smile.fi.intel.com>
References: <20250326171411.590681-4-remo@buenzli.dev>
 <Z-UPJyD41LOMM3o2@smile.fi.intel.com>
 <CAL_Jsq+tJvGsbw1dGdgmBM8+cL4vN71OMTvX9tkmBLNk=6T9KQ@mail.gmail.com>
 <Z-60LwRrw30cq4YE@smile.fi.intel.com>
 <CAL_JsqKiYCh7ukDoqc_toyn75=3wOM4WyOTGvogoOfdz9T_7Ow@mail.gmail.com>
 <Z-7LcXoGw7uNWBUE@smile.fi.intel.com>
 <CAL_JsqLCa8AjwsUpS-N9FWymG67w7DjmmBZCKW7G7BAfY78vWw@mail.gmail.com>
 <CANiq72=iD5ogB2Qjn=WNbghouuER5ypND9=Y_wFiTDfPC2NgFA@mail.gmail.com>
 <Z--7vN1h0jwgLUyF@smile.fi.intel.com>
 <CAL_Jsq+S6=k4+Y4rcOsgtrSHC0AtSPx_8B8TMW-rm0YsrjoaXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+S6=k4+Y4rcOsgtrSHC0AtSPx_8B8TMW-rm0YsrjoaXA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 04, 2025 at 09:12:57AM -0500, Rob Herring wrote:
> On Fri, Apr 4, 2025 at 6:00 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Apr 03, 2025 at 10:36:40PM +0200, Miguel Ojeda wrote:
> > > On Thu, Apr 3, 2025 at 8:48 PM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > Looks there are RUST_BINDGEN or __BINDGEN__ define which could be used
> > > > here. Don't need a header, just wrap the declaration. No idea which
> > > > one would be preferred as there's exactly 1 use of each. Miguel?
> > >
> > > If you mean bcachefs' `RUST_BINDGEN`, then I think that one comes from
> > > bcachefs-tools, i.e. we don't define it.
> >
> > But is there a way to have a function that is not really exported to be used in
> > Rust only code?
> 
> #ifdef __BINDGEN__
> int fwnode_property_read_int_array(const struct fwnode_handle *fwnode,
> const char *propname,
>                                 unsigned int elem_size, void *val, size_t nval);
> #endif

Okay. This can be working compromise. Meanwhile I leave the discussion go on
how to proceed the best on the Rust code side. It seems to me if the macro
approach is indeed looks nice (let's say comparatively nice as this piece in C
header) I would prefer that we do not export it at all.

-- 
With Best Regards,
Andy Shevchenko



