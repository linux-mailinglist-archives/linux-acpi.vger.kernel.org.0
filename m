Return-Path: <linux-acpi+bounces-12744-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDC2A7BB4D
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 13:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D04617AE88
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 11:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56A41DACB8;
	Fri,  4 Apr 2025 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ah4cOtRl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA491D5CE5;
	Fri,  4 Apr 2025 11:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743764424; cv=none; b=W6o84o3Fht5BTZrtgZP9Yqr6jrfaTu36q0ITYZRSQi+TdL19oz9PoKW84ekatDOtP+6Jui9TmiBQZAkOR5QFmcuMITLO7Bg/07yBbR8tnXTXdkb6AKmOFmBUO0GFfGplzzIUMmtp9fjkOwHKLyTXAwfW2DT/kqtpc8pBiAJnn04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743764424; c=relaxed/simple;
	bh=GZXn6CV49ewP1iBodmuC+IRGPTHyiw8+KpS1+6MaCFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNia+AgYR1U4LiH45kSD4ne8ZF/2OO71KIHNt9ty97xLYD+hnayIlZCMXtLLeTnAAQc7t4Y9ythScVHIU4tKmWULr4B6+4v9C6zShq/OJjFP8BsH8cW32DfaiaZ1sLMp9C5BNXcsBcx8Z1gf/4NaHZ+8Lb8r6KP4xyjZCzyYqyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ah4cOtRl; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743764423; x=1775300423;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GZXn6CV49ewP1iBodmuC+IRGPTHyiw8+KpS1+6MaCFE=;
  b=ah4cOtRlKNX5xdHiRA4aHf4JE58C4DXYnRt11jsr1jyujTP9GhPYbGeV
   OIDvRU9YEuy1W6egHy9BrdqAbKqRamqbeaUSvN6XS2N2u9XwqRW1mpH7+
   H7DnbBqrtvewEB8Yow+Q1W9NrQuBYzUNPqDJ3ESR1XnZ2XprXeLFJhH0D
   6HMwGD2B+R7NX1dwpq2pliLRttc1QlA4yYI4+5U+739T7zob7ZtgqDFFG
   Iq7qHIUAOdOj8otIviYRPhW0z8viOJ9eKoxXrHNDnYKSLFH1Yx5Yd+L8A
   kx5dFnk5yYUTp+izZCr4qyC+vaAulxoxCh9D9vArWBrcD6L5h03NWxU+h
   g==;
X-CSE-ConnectionGUID: IcL9Ha5ITEWjLGmAXX4vew==
X-CSE-MsgGUID: e5yAFtcRRsaZu139W9dw8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="44354957"
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="44354957"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 04:00:22 -0700
X-CSE-ConnectionGUID: O149ibG4Rkq8PvTmtuge2Q==
X-CSE-MsgGUID: o/q1jdSKTHWAorbXYOHvBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="127049530"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 04:00:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u0emS-000000096jg-3zIR;
	Fri, 04 Apr 2025 14:00:12 +0300
Date: Fri, 4 Apr 2025 14:00:12 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
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
Message-ID: <Z--7vN1h0jwgLUyF@smile.fi.intel.com>
References: <20250326171411.590681-1-remo@buenzli.dev>
 <20250326171411.590681-4-remo@buenzli.dev>
 <Z-UPJyD41LOMM3o2@smile.fi.intel.com>
 <CAL_Jsq+tJvGsbw1dGdgmBM8+cL4vN71OMTvX9tkmBLNk=6T9KQ@mail.gmail.com>
 <Z-60LwRrw30cq4YE@smile.fi.intel.com>
 <CAL_JsqKiYCh7ukDoqc_toyn75=3wOM4WyOTGvogoOfdz9T_7Ow@mail.gmail.com>
 <Z-7LcXoGw7uNWBUE@smile.fi.intel.com>
 <CAL_JsqLCa8AjwsUpS-N9FWymG67w7DjmmBZCKW7G7BAfY78vWw@mail.gmail.com>
 <CANiq72=iD5ogB2Qjn=WNbghouuER5ypND9=Y_wFiTDfPC2NgFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=iD5ogB2Qjn=WNbghouuER5ypND9=Y_wFiTDfPC2NgFA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 03, 2025 at 10:36:40PM +0200, Miguel Ojeda wrote:
> On Thu, Apr 3, 2025 at 8:48 PM Rob Herring <robh@kernel.org> wrote:
> >
> > Looks there are RUST_BINDGEN or __BINDGEN__ define which could be used
> > here. Don't need a header, just wrap the declaration. No idea which
> > one would be preferred as there's exactly 1 use of each. Miguel?
> 
> If you mean bcachefs' `RUST_BINDGEN`, then I think that one comes from
> bcachefs-tools, i.e. we don't define it.

But is there a way to have a function that is not really exported to be used in
Rust only code?

-- 
With Best Regards,
Andy Shevchenko



