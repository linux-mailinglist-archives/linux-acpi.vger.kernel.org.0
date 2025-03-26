Return-Path: <linux-acpi+bounces-12473-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E34A720C6
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 22:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2616118950F9
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 21:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B2825FA0E;
	Wed, 26 Mar 2025 21:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJdT/eTR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26B619FA93;
	Wed, 26 Mar 2025 21:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743024475; cv=none; b=K36D74DxGE/bDzWec+g2KhGZeTsaaGMWon68qafngMNP2s00pNAEFUKX+ACuWZ0zOlmPm+tTWDOK+DcrsYTz8yHGXdHkbi1iqtxjcBNtRoHFNzxQOUZsWAmJqXOZNwQvLwKpAxQ8BP536JTTqTtM01Aia10K23sF/qi1m0sw5rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743024475; c=relaxed/simple;
	bh=rel0LO6wnZX0yamOBZ2Hr0Q9Kjf4GnVHzzI1nENcclc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBgHdCC4ixKk7RLNq9eHMcVWOSsN/+XbEfnrzn8NaUEKcBBxSnistrCxGW6jZOra3tcR4GfvqZ2WVuFCtCvaOc9KnThgGRheI1bxPrFHt34TPZERVi3x7C5EjaLLRBDGWbF1h3VyVuEUQeXi2CsoKoPYJzkhcSymRgABY+6j7xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJdT/eTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E69C4CEE2;
	Wed, 26 Mar 2025 21:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743024474;
	bh=rel0LO6wnZX0yamOBZ2Hr0Q9Kjf4GnVHzzI1nENcclc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mJdT/eTRAHvGAOCaMQrlGca1CdQRPyRIC4GWPhsZdS5Cveg6IVcs06MFgLWOoiFc6
	 7eDhVMI1FPp513/EB/liAG5epgFpDSbrWW6qcuxu5fT/I84tAi1mLO4DGPuZFoy/hl
	 yhJFsxFWW4duYwMY5UEWQTBiIxWrJTaGEFWSMZUkAUVlgIi54fcTBXl+z/i26zNJ7h
	 Tes2xS47a7G4y4ITvCWvx7Up40J35SfQGMmTomRhTwLVWDi/pulQuINith0lKr/Sza
	 CzoXM+2/etQGpvOB6ot50QsmGuCCK/YYUGczOHpHn4ZpMid4el9wWyK9UDQUHXmGjd
	 20iq6iCgQ46Mw==
Date: Wed, 26 Mar 2025 16:27:53 -0500
From: Rob Herring <robh@kernel.org>
To: Remo Senekowitsch <remo@buenzli.dev>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Subject: Re: [PATCH 04/10] rust: Add bindings for reading device properties
Message-ID: <20250326212753.GA2844851-robh@kernel.org>
References: <20250326171411.590681-1-remo@buenzli.dev>
 <20250326171411.590681-5-remo@buenzli.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326171411.590681-5-remo@buenzli.dev>

On Wed, Mar 26, 2025 at 06:13:43PM +0100, Remo Senekowitsch wrote:
> The device property API is a firmware agnostic API for reading
> properties from firmware (DT/ACPI) devices nodes and swnodes.
> 
> While the C API takes a pointer to a caller allocated variable/buffer,
> the rust API is designed to return a value and can be used in struct
> initialization. Rust generics are also utilized to support different
> sizes of properties (e.g. u8, u16, u32).
> 
> Co-developed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Remo Senekowitsch <remo@buenzli.dev>
> ---
>  rust/kernel/property.rs | 153 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 151 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/property.rs b/rust/kernel/property.rs
> index b0a4bb63a..4756ea766 100644
> --- a/rust/kernel/property.rs
> +++ b/rust/kernel/property.rs
> @@ -4,9 +4,17 @@
>  //!
>  //! C header: [`include/linux/property.h`](srctree/include/linux/property.h)
>  
> -use core::ptr;
> +use core::{ffi::c_void, mem::MaybeUninit, ptr};
>  
> -use crate::{bindings, device::Device, str::CStr, types::Opaque};
> +use crate::{
> +    alloc::KVec,
> +    bindings,
> +    device::Device,
> +    error::{to_result, Result},
> +    prelude::*,
> +    str::{CStr, CString},
> +    types::{Integer, Opaque},
> +};
>  
>  impl Device {
>      /// Obtain the fwnode corresponding to the device.
> @@ -26,6 +34,41 @@ fn fwnode(&self) -> &FwNode {
>      pub fn property_present(&self, name: &CStr) -> bool {
>          self.fwnode().property_present(name)
>      }
> +
> +    /// Returns if a firmware property `name` is true or false
> +    pub fn property_read_bool(&self, name: &CStr) -> bool {
> +        self.fwnode().property_read_bool(name)
> +    }
> +
> +    /// Returns the index of matching string `match_str` for firmware string property `name`

Comment doesn't match the function.

> +    pub fn property_read_string(&self, name: &CStr) -> Result<CString> {
> +        self.fwnode().property_read_string(name)
> +    }
> +
> +    /// Returns the index of matching string `match_str` for firmware string property `name`
> +    pub fn property_match_string(&self, name: &CStr, match_str: &CStr) -> Result<usize> {
> +        self.fwnode().property_match_string(name, match_str)
> +    }
> +
> +    /// Returns firmware property `name` integer scalar value
> +    pub fn property_read<T: Integer>(&self, name: &CStr) -> Result<T> {
> +        self.fwnode().property_read(name)
> +    }
> +
> +    /// Returns firmware property `name` integer array values
> +    pub fn property_read_array<T: Integer, const N: usize>(&self, name: &CStr) -> Result<[T; N]> {
> +        self.fwnode().property_read_array(name)
> +    }
> +
> +    /// Returns firmware property `name` integer array values in a KVec
> +    pub fn property_read_array_vec<T: Integer>(&self, name: &CStr, len: usize) -> Result<KVec<T>> {
> +        self.fwnode().property_read_array_vec(name, len)
> +    }
> +
> +    /// Returns integer array length for firmware property `name`
> +    pub fn property_count_elem<T: Integer>(&self, name: &CStr) -> Result<usize> {
> +        self.fwnode().property_count_elem::<T>(name)
> +    }
>  }
>  
>  /// A reference-counted fwnode_handle.
> @@ -57,6 +100,112 @@ pub fn property_present(&self, name: &CStr) -> bool {
>          // SAFETY: By the invariant of `CStr`, `name` is null-terminated.
>          unsafe { bindings::fwnode_property_present(self.as_raw().cast_const(), name.as_char_ptr()) }
>      }
> +
> +    /// Returns if a firmware property `name` is true or false
> +    pub fn property_read_bool(&self, name: &CStr) -> bool {
> +        // SAFETY: `name` is non-null and null-terminated. `self.as_raw` is valid
> +        // because `self` is valid.
> +        unsafe { bindings::fwnode_property_read_bool(self.as_raw(), name.as_char_ptr()) }
> +    }
> +
> +    /// Returns the index of matching string `match_str` for firmware string property `name`

Same comment copy-n-paste mismatch.

> +    pub fn property_read_string(&self, name: &CStr) -> Result<CString> {
> +        let mut str = core::ptr::null_mut();
> +        let pstr: *mut _ = &mut str;
> +
> +        // SAFETY: `name` is non-null and null-terminated. `self.as_raw` is
> +        // valid because `self` is valid.
> +        let ret = unsafe {
> +            bindings::fwnode_property_read_string(self.as_raw(), name.as_char_ptr(), pstr as _)
> +        };
> +        to_result(ret)?;
> +
> +        // SAFETY: `pstr` contains a non-null ptr on success
> +        let str = unsafe { CStr::from_char_ptr(*pstr) };
> +        Ok(str.try_into()?)
> +    }

There's a problem with the C version of this function that I'd like to 
not repeat in Rust especially since ownership is clear. 

The issue is that we never know when the returned string is no longer 
needed. For DT overlays, we need to be able free the string when/if an 
overlay is removed. Though overlays are somewhat orthogonal to this. 
It's really just when the property's node refcount goes to 0 that the 
property value could be freed.

So this function should probably return a copy of the string that the 
caller owns.

Rob

