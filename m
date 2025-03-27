Return-Path: <linux-acpi+bounces-12491-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E955A72BA8
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Mar 2025 09:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 393311712FE
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Mar 2025 08:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A182080CD;
	Thu, 27 Mar 2025 08:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IfYjAM6/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B19207E1F;
	Thu, 27 Mar 2025 08:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743064883; cv=none; b=YmgFu9m5LQkhACIl5yRp0ifEI0fxd3U7BCZUX83oRFXX6bBg0g0qnXPJQHqLS6Jkwoy6NruWUk2KPX9sUMRz+bIhAqg2Atln6MgGc8OUmq0wMlF7rxuCBH33y9NNs+L5UDwnrcyq1XOqXFOVAAyKf1GZks2ws6fIL70h4YfysG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743064883; c=relaxed/simple;
	bh=/CTsE8+e4IgpFZMUIYGcSt1t0a2Iahxvo8D6O4Ny114=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=js5pXBCjj2X7WOlBpA7xhPqGBoCKUrV2QVHmg4AIGo/KAIta4NSTyVquylxH6VLAN6nXVMWo673SHJWTDKGjlhhZs2tkm6DfZ0cgzJnIIKZ0DA25aWv+ipG5FIahQlOdkZklFKj4ReCMSgIu+UPDENSzjLvgwX+qU+yuxnVQ+wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IfYjAM6/; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743064882; x=1774600882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/CTsE8+e4IgpFZMUIYGcSt1t0a2Iahxvo8D6O4Ny114=;
  b=IfYjAM6/otKolk792y9wiauI/2p44G0S2r3JUnyUVpZQncwR4pMoSZWF
   HlzlRyhneP4hacR87qdItA59h2dnG/5MDtJI1o7BpLUHoeIG5eTMq4NZ+
   is3nbgE+r/9R+zWYuXB7C0GCVXjWbGyFOQRnhN2l6fddT7660+F01GBcM
   oAMV6CbMAdKVQ5+JoIBBVY9ttwwgY+k2xs88YR8A6snYlzPWzkjgjcKPZ
   Nf8h+XVp70i0qqL0eIpNtE1D9ThKoT3Xw2oiH6dkGGyIrA0PEcx81/Lmt
   H7v4C2770JVuQCIZ5BaSUe9wKh8KEq0LI8GWj5lS6/RIIquuFHgl1bnLZ
   Q==;
X-CSE-ConnectionGUID: ChkAw37MQOCHFvWVw5EFsQ==
X-CSE-MsgGUID: FrDxMSk+TnCF3AhUtAkbUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44486933"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="44486933"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 01:41:21 -0700
X-CSE-ConnectionGUID: i0kvd6KDToC/EPuDonyzQw==
X-CSE-MsgGUID: 9wN2WU61TWi64UDoClc/Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="129224481"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 01:41:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1txinY-00000006Kbe-0hPn;
	Thu, 27 Mar 2025 10:41:12 +0200
Date: Thu, 27 Mar 2025 10:41:11 +0200
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
Message-ID: <Z-UPJyD41LOMM3o2@smile.fi.intel.com>
References: <20250326171411.590681-1-remo@buenzli.dev>
 <20250326171411.590681-4-remo@buenzli.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326171411.590681-4-remo@buenzli.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 26, 2025 at 06:13:42PM +0100, Remo Senekowitsch wrote:
> The rust bindings for reading device properties has a single
> implementation supporting differing sizes of integers. The fwnode C API
> already has a similar interface, but it is not exposed with the
> fwnode_property_ API. Add the fwnode_property_read_int_array() wrapper.

...

> +EXPORT_SYMBOL_GPL(fwnode_property_read_int_array);

I'm not sure about this. We have a lot of assumptions in the code that the
arrays beneath are only represented by the selected number of integer types.
This opens a Pandora's box, e.g., reading in u24, which is not supported by
the upper layers..

> +int fwnode_property_read_int_array(const struct fwnode_handle *fwnode, const char *propname,
> +				   unsigned int elem_size, void *val, size_t nval);

-- 
With Best Regards,
Andy Shevchenko



