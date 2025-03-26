Return-Path: <linux-acpi+bounces-12457-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36527A7203A
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 21:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158F43B9739
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 20:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85EA259C88;
	Wed, 26 Mar 2025 20:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqudimeM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88221F4717;
	Wed, 26 Mar 2025 20:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743022267; cv=none; b=kBgMsfUFdVx1iTrRp3op/Y8QgulpTZ8cetyMbdBeJhuKfWjm8UOfpBBuw5aXgIzBEr4b3e982Lp7Ux6ypeYQZwQy2ymbNmiqYLfac9pa+5C2r58+VlUG56G3cF4BfhiMBMOcq0WhRXvVM5BBfMVbgpx92VMCqWpjR8Yv4nWgmPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743022267; c=relaxed/simple;
	bh=S27gZEX4GCylozEOPuY+M4umPDYp6zAXe1i1PawRNPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPb7jmTuQ8N6uSjDLBLFDcA0g2538oDykwgctKqdfLYySnvGKa0N6/tn7rNvLyPn8zXnu+aC4OS1nq3B6Z2mkzjit0fw2tjKXVqsLvLcs9S6mLi7tx30O8FgxokO6V6MJoaZ6Bh1/OLVgDWiJU+hYnrb/6538oo4Gqs6Cche+mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqudimeM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026ACC4CEE2;
	Wed, 26 Mar 2025 20:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743022267;
	bh=S27gZEX4GCylozEOPuY+M4umPDYp6zAXe1i1PawRNPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fqudimeMa7tpJCKwxfluvocGRhmS9Kih5in7bjvHTzBF0sgpTDNG1LtJxRzpZ9hbN
	 z0djoeV1epts9cd6ZtJESN3GXiPgBj5OfGJ2hD2mT/JzXKM2FplFv4ARxaN/HkYC+Z
	 EvqK0cDD2hmbQ8/pDhIPGPC0RULvuBsRSVt39cTg6vu8AYUZ66wyrAjXbTlFapQ/nH
	 8mEos+cGY+pDeqfcxJ0NDH4P64gX9koHZsZV/y/XoAJrEd4poCUBvRCg8y3xB5dtIx
	 8kqMrQ+8hG2CcZFdSH5OHA5AIX2V1jWcJ3w9Eun1O6PKCzvhZ7h7owXQ1FHqy1ZpTE
	 yLyp1gTA4wnIA==
Date: Wed, 26 Mar 2025 15:51:06 -0500
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
Subject: Re: [PATCH 01/10] rust: Move property_present to property.rs
Message-ID: <20250326205106.GB2787672-robh@kernel.org>
References: <20250326171411.590681-1-remo@buenzli.dev>
 <20250326171411.590681-2-remo@buenzli.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326171411.590681-2-remo@buenzli.dev>

On Wed, Mar 26, 2025 at 06:13:40PM +0100, Remo Senekowitsch wrote:
> Not all property-related APIs can be exposed directly on a device.
> For example, iterating over child nodes of a device will yield
> fwnode_handle. Thus, in order to access properties on these child nodes,
> the APIs has to be duplicated on a fwnode as they are in C.

s/has/have/

> 
> A related discussion can be found on the R4L Zulip[1].
> 
> [1] https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/DS90UB954.20driver.20done.2C.20ready.20to.20upstream.3F/near/505415697

Useful below the '---', but I don't think we want to keep this link 
forever. And who knows how long it will be valid? The commit msg needs 
to stand on its own, and I think it does.

> 
> Signed-off-by: Remo Senekowitsch <remo@buenzli.dev>
> ---
>  rust/helpers/helpers.c  |  1 +
>  rust/helpers/property.c | 13 ++++++++
>  rust/kernel/device.rs   |  7 ----
>  rust/kernel/lib.rs      |  1 +
>  rust/kernel/property.rs | 73 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 88 insertions(+), 7 deletions(-)
>  create mode 100644 rust/helpers/property.c
>  create mode 100644 rust/kernel/property.rs
> 
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 0640b7e11..b4eec5bf2 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -23,6 +23,7 @@
>  #include "platform.c"
>  #include "pci.c"
>  #include "pid_namespace.c"
> +#include "property.c"
>  #include "rbtree.c"
>  #include "rcu.c"
>  #include "refcount.c"
> diff --git a/rust/helpers/property.c b/rust/helpers/property.c
> new file mode 100644
> index 000000000..c37c74488
> --- /dev/null
> +++ b/rust/helpers/property.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/property.h>
> +
> +struct fwnode_handle *rust_helper_dev_fwnode(struct device *dev)
> +{
> +	return dev_fwnode(dev);
> +}
> +
> +void rust_helper_fwnode_handle_put(struct fwnode_handle *fwnode)
> +{
> +	fwnode_handle_put(fwnode);
> +}
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index db2d9658b..d5e6a19ff 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -6,7 +6,6 @@
>  
>  use crate::{
>      bindings,
> -    str::CStr,
>      types::{ARef, Opaque},
>  };
>  use core::{fmt, ptr};
> @@ -181,12 +180,6 @@ unsafe fn printk(&self, klevel: &[u8], msg: fmt::Arguments<'_>) {
>              )
>          };
>      }
> -
> -    /// Checks if property is present or not.
> -    pub fn property_present(&self, name: &CStr) -> bool {
> -        // SAFETY: By the invariant of `CStr`, `name` is null-terminated.
> -        unsafe { bindings::device_property_present(self.as_raw().cast_const(), name.as_char_ptr()) }
> -    }
>  }
>  
>  // SAFETY: Instances of `Device` are always reference-counted.
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 496ed32b0..ca233fd20 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -67,6 +67,7 @@
>  pub mod platform;
>  pub mod prelude;
>  pub mod print;
> +pub mod property;
>  pub mod rbtree;
>  pub mod revocable;
>  pub mod security;
> diff --git a/rust/kernel/property.rs b/rust/kernel/property.rs
> new file mode 100644
> index 000000000..b0a4bb63a
> --- /dev/null
> +++ b/rust/kernel/property.rs
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Unified device property interface.
> +//!
> +//! C header: [`include/linux/property.h`](srctree/include/linux/property.h)
> +
> +use core::ptr;
> +
> +use crate::{bindings, device::Device, str::CStr, types::Opaque};
> +
> +impl Device {
> +    /// Obtain the fwnode corresponding to the device.
> +    fn fwnode(&self) -> &FwNode {
> +        // SAFETY: `self` is valid.
> +        let fwnode_handle = unsafe { bindings::dev_fwnode(self.as_raw()) };
> +        if fwnode_handle.is_null() {
> +            panic!("fwnode_handle cannot be null");

It's usually not a good idea to panic the kernel especially with 
something a driver calls as that's probably recoverable.

Users/drivers testing fwnode_handle/of_node for NULL is pretty common. 
Though often that's a legacy code path, so maybe not allowing NULL is 
fine for now.

> +        }
> +        // SAFETY: `fwnode_handle` is valid. Its lifetime is tied to `&self`. We
> +        // return a reference instead of an `ARef<FwNode>` because `dev_fwnode()`
> +        // doesn't increment the refcount.
> +        unsafe { &*fwnode_handle.cast() }
> +    }
> +
> +    /// Checks if property is present or not.
> +    pub fn property_present(&self, name: &CStr) -> bool {
> +        self.fwnode().property_present(name)
> +    }
> +}

The C developer in me wants to put this after the FwNode stuff since 
this uses it.

> +
> +/// A reference-counted fwnode_handle.
> +///
> +/// This structure represents the Rust abstraction for a
> +/// C `struct fwnode_handle`. This implementation abstracts the usage of an
> +/// already existing C `struct fwnode_handle` within Rust code that we get
> +/// passed from the C side.
> +///
> +/// # Invariants
> +///
> +/// A `FwNode` instance represents a valid `struct fwnode_handle` created by the
> +/// C portion of the kernel.
> +///
> +/// Instances of this type are always reference-counted, that is, a call to
> +/// `fwnode_handle_get` ensures that the allocation remains valid at least until
> +/// the matching call to `fwnode_handle_put`.
> +#[repr(transparent)]
> +pub struct FwNode(Opaque<bindings::fwnode_handle>);
> +
> +impl FwNode {
> +    /// Obtain the raw `struct fwnode_handle *`.
> +    pub(crate) fn as_raw(&self) -> *mut bindings::fwnode_handle {
> +        self.0.get()
> +    }
> +
> +    /// Checks if property is present or not.
> +    pub fn property_present(&self, name: &CStr) -> bool {
> +        // SAFETY: By the invariant of `CStr`, `name` is null-terminated.
> +        unsafe { bindings::fwnode_property_present(self.as_raw().cast_const(), name.as_char_ptr()) }
> +    }
> +}
> +
> +// SAFETY: Instances of `FwNode` are always reference-counted.
> +unsafe impl crate::types::AlwaysRefCounted for FwNode {
> +    fn inc_ref(&self) {
> +        // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
> +        unsafe { bindings::fwnode_handle_get(self.as_raw()) };
> +    }
> +
> +    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
> +        // SAFETY: The safety requirements guarantee that the refcount is non-zero.
> +        unsafe { bindings::fwnode_handle_put(obj.cast().as_ptr()) }
> +    }
> +}
> -- 
> 2.49.0
> 

