Return-Path: <linux-acpi+bounces-12481-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8B8A723E2
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 23:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA0301788AE
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 22:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D025E262811;
	Wed, 26 Mar 2025 22:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFCwFmqo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977212459DA;
	Wed, 26 Mar 2025 22:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743027930; cv=none; b=NUpqRoWviT3679IwKy6VcXPAkpt8ZimilOJW73QSudoq7JNzN/7orOERUr7QxD1wWJBeLpnQschy08+uF2rqQy84JjS5XdabzqPrpa+26FHjeXj3T9/Fg7RYQAUDMMOqge4SHTSB9F04U5X3En2AGg7PZgJ5ygCOhi4OKamjq/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743027930; c=relaxed/simple;
	bh=iZrgnYv/P8IbHSIWNMx4qd6WiLeL1uyCHHQaevyBHdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsuETF1BMRN8OUqM0HbA6swd49K3ZytCd6v34vzuIf8Qc/HJxlEHl8aefXCSiUWwVkV5mN4epgN5km0Rc25r33otRhQvOVL5wy2btTPJz2rpYPBlRoPptjEA5vsPkt5YuuglSyFKWYlRdK76TUIKkxcGhPCpQjuh/xFKUaQx/wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFCwFmqo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA187C4CEE2;
	Wed, 26 Mar 2025 22:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743027930;
	bh=iZrgnYv/P8IbHSIWNMx4qd6WiLeL1uyCHHQaevyBHdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cFCwFmqofOl1sT5ewxP9RYc3XC7nfP+bsdxONlByhqpqUc4/GPjIiJFPC8tXr00zf
	 dTYq9F+SxierorNJPX8UrJFQ1GjyRXF6jb5heb13vz7w1ApNklT6IE8Lf6SRUZ6ckY
	 HND3l/8TqLUhrPfpj9yTtbsc9pyvlNgqw0DShtfyLHsGt16vsiOvyVYIxFm8sMr5ND
	 va9Esb80NRB/WVebnTTU0JrK+nmS2DP2BzD3fBA43brHsNMhWRXKstIQw2CbibD+r2
	 CB3PbFgUo1VOIaONPPxEoKwDoPxtpUOpLY3Yp79ZpoaHj0hUmy4xivp1Aprx1L9kjt
	 /iQz9ffsmuWtQ==
Date: Wed, 26 Mar 2025 17:25:29 -0500
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
Subject: Re: [PATCH 09/10] rust: property: Add PropertyGuard
Message-ID: <20250326222529.GE2844851-robh@kernel.org>
References: <20250326171411.590681-1-remo@buenzli.dev>
 <20250326171411.590681-10-remo@buenzli.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326171411.590681-10-remo@buenzli.dev>

On Wed, Mar 26, 2025 at 06:13:48PM +0100, Remo Senekowitsch wrote:
> Forcing users to specify whether a property is supposed to be required
> or not allows us to move error logging of missing required properties
> into core, preventing a lot of boilerplate in drivers.

We'll want to squash this one too.

> 
> Signed-off-by: Remo Senekowitsch <remo@buenzli.dev>
> ---
>  rust/kernel/property.rs | 146 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 127 insertions(+), 19 deletions(-)
> 
> diff --git a/rust/kernel/property.rs b/rust/kernel/property.rs
> index f1d0a33ba..e4f0e5f97 100644
> --- a/rust/kernel/property.rs
> +++ b/rust/kernel/property.rs
> @@ -42,7 +42,11 @@ pub fn property_match_string(&self, name: &CStr, match_str: &CStr) -> Result<usi
>      }
>  
>      /// Returns firmware property `name` integer array values in a KVec
> -    pub fn property_read_array_vec<T: Integer>(&self, name: &CStr, len: usize) -> Result<KVec<T>> {
> +    pub fn property_read_array_vec<'fwnode, 'name, T: Integer>(
> +        &'fwnode self,
> +        name: &'name CStr,
> +        len: usize,
> +    ) -> Result<PropertyGuard<'fwnode, 'name, KVec<T>>> {
>          self.fwnode().property_read_array_vec(name, len)
>      }
>  
> @@ -52,12 +56,18 @@ pub fn property_count_elem<T: Integer>(&self, name: &CStr) -> Result<usize> {
>      }
>  
>      /// Returns firmware property `name` integer scalar value
> -    pub fn property_read<T: Property>(&self, name: &CStr) -> Result<T> {
> +    pub fn property_read<'fwnode, 'name, T: Property>(
> +        &'fwnode self,
> +        name: &'name CStr,
> +    ) -> PropertyGuard<'fwnode, 'name, T> {
>          self.fwnode().property_read(name)
>      }
>  
>      /// Returns first matching named child node handle.
> -    pub fn get_child_by_name(&self, name: &CStr) -> Option<ARef<FwNode>> {
> +    pub fn get_child_by_name<'fwnode, 'name>(
> +        &'fwnode self,
> +        name: &'name CStr,
> +    ) -> PropertyGuard<'fwnode, 'name, ARef<FwNode>> {
>          self.fwnode().get_child_by_name(name)
>      }

While child nodes can be required or optional, it's a bit less common to 
be optional. There error message on missing required child nodes is 
going to be a bit misleading saying 'property'. So maybe don't do the 
PropertyGuard on child node handling?

>  
> @@ -132,12 +142,16 @@ pub fn property_match_string(&self, name: &CStr, match_str: &CStr) -> Result<usi
>      }
>  
>      /// Returns firmware property `name` integer array values in a KVec
> -    pub fn property_read_array_vec<T: Integer>(&self, name: &CStr, len: usize) -> Result<KVec<T>> {
> +    pub fn property_read_array_vec<'fwnode, 'name, T: Integer>(
> +        &'fwnode self,
> +        name: &'name CStr,
> +        len: usize,
> +    ) -> Result<PropertyGuard<'fwnode, 'name, KVec<T>>> {
>          let mut val: KVec<T> = KVec::with_capacity(len, GFP_KERNEL)?;
>  
>          // SAFETY: `name` is non-null and null-terminated. `self.as_raw` is valid
>          // because `self` is valid. `val.as_ptr` is valid because `val` is valid.
> -        to_result(unsafe {
> +        let err = unsafe {
>              bindings::fwnode_property_read_int_array(
>                  self.as_raw(),
>                  name.as_char_ptr(),
> @@ -145,11 +159,19 @@ pub fn property_read_array_vec<T: Integer>(&self, name: &CStr, len: usize) -> Re
>                  val.as_ptr() as *mut c_void,
>                  len,
>              )
> -        })?;
> -
> -        // SAFETY: fwnode_property_read_int_array() writes exactly `len` entries on success
> -        unsafe { val.set_len(len) }
> -        Ok(val)
> +        };
> +        let res = if err < 0 {
> +            Err(Error::from_errno(err))
> +        } else {
> +            // SAFETY: fwnode_property_read_int_array() writes exactly `len` entries on success
> +            unsafe { val.set_len(len) }
> +            Ok(val)
> +        };
> +        Ok(PropertyGuard {
> +            inner: res,
> +            fwnode: self,
> +            name,
> +        })
>      }
>  
>      /// Returns integer array length for firmware property `name`
> @@ -194,24 +216,42 @@ pub fn property_count_elem<T: Integer>(&self, name: &CStr) -> Result<usize> {
>      /// # use crate::{device::Device, types::CString};
>      /// fn examples(dev: &Device) -> Result {
>      ///     let fwnode = dev.fwnode();
> -    ///     let b: bool = fwnode.property_read("some-bool")?;
> -    ///     let s: CString = fwnode.property_read("some-str")?;
> +    ///     let b: bool = fwnode.property_read("some-bool").required()?;
> +    ///     if let Some(s) = fwnode.property_read::<CString>("some-str").optional() {
> +    ///         // ...
> +    ///     }
>      /// }
>      /// ```
> -    pub fn property_read<T: Property>(&self, name: &CStr) -> Result<T> {
> -        T::read(&self, name)
> +    pub fn property_read<'fwnode, 'name, T: Property>(
> +        &'fwnode self,
> +        name: &'name CStr,
> +    ) -> PropertyGuard<'fwnode, 'name, T> {
> +        PropertyGuard {
> +            inner: T::read(&self, name),
> +            fwnode: self,
> +            name,
> +        }
>      }
>  
>      /// Returns first matching named child node handle.
> -    pub fn get_child_by_name(&self, name: &CStr) -> Option<ARef<Self>> {
> +    pub fn get_child_by_name<'fwnode, 'name>(
> +        &'fwnode self,
> +        name: &'name CStr,
> +    ) -> PropertyGuard<'fwnode, 'name, ARef<Self>> {
>          // SAFETY: `self` and `name` are valid.
>          let child =
>              unsafe { bindings::fwnode_get_named_child_node(self.as_raw(), name.as_char_ptr()) };
> -        if child.is_null() {
> -            return None;
> +        let res = if child.is_null() {
> +            Err(ENOENT)
> +        } else {
> +            // SAFETY: `fwnode_get_named_child_node` returns a pointer with refcount incremented.
> +            Ok(unsafe { Self::from_raw(child) })
> +        };
> +        PropertyGuard {
> +            inner: res,
> +            fwnode: self,
> +            name,
>          }
> -        // SAFETY: `fwnode_get_named_child_node` returns a pointer with refcount incremented.
> -        Some(unsafe { Self::from_raw(child) })
>      }
>  
>      /// Returns an iterator over a node's children.
> @@ -365,3 +405,71 @@ pub enum NArgs<'a> {
>      /// The known number of arguments.
>      N(u32),
>  }
> +
> +/// A helper for reading device properties.
> +///
> +/// Use [Self::required] if a missing property is considered a bug and
> +/// [Self::optional] otherwise.
> +///
> +/// For convenience, [Self::or] and [Self::or_default] are provided.
> +pub struct PropertyGuard<'fwnode, 'name, T> {
> +    /// The result of reading the property.
> +    inner: Result<T>,
> +    /// The fwnode of the property, used for logging in the "required" case.
> +    fwnode: &'fwnode FwNode,
> +    /// The name of the property, used for logging in the "required" case.
> +    name: &'name CStr,
> +}
> +
> +impl<T> PropertyGuard<'_, '_, T> {
> +    /// Access the property, indicating it is required.
> +    ///
> +    /// If the property is not present, the error is automatically logged. If a
> +    /// missing property is not an error, use [Self::optional] instead.
> +    pub fn required(self) -> Result<T> {
> +        if self.inner.is_err() {
> +            // Get the device associated with the fwnode for device-associated
> +            // logging.
> +            // TODO: Are we allowed to do this? The field `fwnode_handle.dev`
> +            // has a somewhat vague comment, which could mean we're not
> +            // supposed to access it:
> +            // https://elixir.bootlin.com/linux/v6.13.6/source/include/linux/fwnode.h#L51
> +            // SAFETY: According to the invariant of FwNode, it is valid.
> +            let dev = unsafe { (*self.fwnode.as_raw()).dev };
> +
> +            if dev.is_null() {
> +                pr_err!("property '{}' is missing\n", self.name);

We should print the node path in this case (and perhaps both cases).

We have "%pfw" printf format specifier for C. We're going to need the 
same for rust.

> +            } else {
> +                // SAFETY: If dev is not null, it points to a valid device.
> +                let dev: &Device = unsafe { &*dev.cast() };
> +                dev_err!(dev, "property '{}' is missing\n", self.name);
> +            };
> +        }
> +        self.inner
> +    }
> +
> +    /// Access the property, indicating it is optional.
> +    ///
> +    /// In contrast to [Self::required], no error message is logged if the
> +    /// property is not present.
> +    pub fn optional(self) -> Option<T> {
> +        self.inner.ok()
> +    }
> +
> +    /// Access the property or the specified default value.
> +    ///
> +    /// Do not pass a sentinel value as default to detect a missing property.
> +    /// Use [Self::required] or [Self::optional] instead.
> +    pub fn or(self, default: T) -> T {
> +        self.inner.unwrap_or(default)
> +    }
> +}
> +
> +impl<T: Default> PropertyGuard<'_, '_, T> {
> +    /// Access the property or a default value.
> +    ///
> +    /// Use [Self::or] to specify a custom default value.
> +    pub fn or_default(self) -> T {
> +        self.inner.unwrap_or_default()
> +    }
> +}
> -- 
> 2.49.0
> 

