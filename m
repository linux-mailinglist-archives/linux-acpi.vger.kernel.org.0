Return-Path: <linux-acpi+bounces-12502-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97722A7347C
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Mar 2025 15:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E3207A25BF
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Mar 2025 14:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A616F21882F;
	Thu, 27 Mar 2025 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxAhSevb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D73D21858D;
	Thu, 27 Mar 2025 14:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743085963; cv=none; b=seSrtXaEWOch9eA9s3Ed79JZ/mtSGyii36xx+3O/j1ul8JKH8xRyLqMVYI/+Z6x2Q3gk/LhU8Q5iS+3O7yg9cBnR9jrL8PbCoUhoeJxUmhGuwrBlFcmoLbESqzSxDpdLCKNlNnaeZeuiqf58iyEuGhJCflNOKBf6Ew82Efe+ZaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743085963; c=relaxed/simple;
	bh=EKJjDGTPuM3JrHg8idN9+Afkua9aYeI8TRO7eBdtUbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfBuNk9kDC/7GEYTXUf++IAven5nnmd9BiJs1hpWgaFwACczHyhsqg1jV6C1wrC8nZeYBeM0pfFXnupkROeujE8L0AaSdm6Wd3zSlbJwS8HXXVbm0FTXxatoY8p1AIh+0zx8oUI056DyMw1uTBcJKACIAdZK47FafkmjSTE5suE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxAhSevb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69520C4CEED;
	Thu, 27 Mar 2025 14:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743085962;
	bh=EKJjDGTPuM3JrHg8idN9+Afkua9aYeI8TRO7eBdtUbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GxAhSevby667JMr4l13rJPNebs1GVndNL5l7OBI8fJfiO4jgBZi31twxWTc8v6aL0
	 r33E3SJfUHIeE4PKsvLBIEutEd46Mqp/87Zg2IX8fZUS3hAVlnui8ouOjviPklD2f3
	 vozqTfHt4mftYbrVAlPaS38QeSDQqMaD+N+4qFhMkgUrCRNOg4swfsXXKeC0AZlCUu
	 DMKTgyG/LG46y5ZiEFqadjBK3q4L+eonV9Zbe/23q0p43oJhMvk8sMBmnpaBIBvUaA
	 QpxM8c2e+5JKdA4iXQUfWqcA5MpU5OUG8ymP0UM57WWy0xKhO9NmjzPECRas1zj1CC
	 kAC9g4vqRro4Q==
Date: Thu, 27 Mar 2025 15:32:35 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Remo Senekowitsch <remo@buenzli.dev>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Rob Herring <robh@kernel.org>, Dirk Behme <dirk.behme@de.bosch.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
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
Subject: Re: [PATCH 08/10] rust: property: Add property_get_reference_args
Message-ID: <Z-VhgxJ5kyQbeVPi@cassiopeiae>
References: <20250326171411.590681-1-remo@buenzli.dev>
 <20250326171411.590681-9-remo@buenzli.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326171411.590681-9-remo@buenzli.dev>

On Wed, Mar 26, 2025 at 06:13:47PM +0100, Remo Senekowitsch wrote:
> Signed-off-by: Remo Senekowitsch <remo@buenzli.dev>
> ---
>  rust/kernel/property.rs | 63 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/rust/kernel/property.rs b/rust/kernel/property.rs
> index dc927ad93..f1d0a33ba 100644
> --- a/rust/kernel/property.rs
> +++ b/rust/kernel/property.rs
> @@ -8,6 +8,7 @@
>  
>  use crate::{
>      alloc::KVec,
> +    arrayvec::ArrayVec,
>      bindings,
>      device::Device,
>      error::{to_result, Result},
> @@ -64,6 +65,20 @@ pub fn get_child_by_name(&self, name: &CStr) -> Option<ARef<FwNode>> {
>      pub fn children<'a>(&'a self) -> impl Iterator<Item = ARef<FwNode>> + 'a {
>          self.fwnode().children()
>      }
> +
> +    /// Finds a reference with arguments.
> +    pub fn property_get_reference_args(
> +        &self,
> +        prop: &CStr,
> +        nargs: NArgs<'_>,
> +        index: u32,
> +    ) -> Result<(
> +        ARef<FwNode>,
> +        ArrayVec<{ bindings::NR_FWNODE_REFERENCE_ARGS as usize }, u64>,
> +    )> {
> +        self.fwnode()
> +            .property_get_reference_args(prop, nargs, index)
> +    }
>  }
>  
>  /// A reference-counted fwnode_handle.
> @@ -226,6 +241,45 @@ pub fn children<'a>(&'a self) -> impl Iterator<Item = ARef<FwNode>> + 'a {
>              Some(next)
>          })
>      }
> +
> +    /// Finds a reference with arguments.
> +    pub fn property_get_reference_args(
> +        &self,
> +        prop: &CStr,
> +        nargs: NArgs<'_>,
> +        index: u32,
> +    ) -> Result<(
> +        ARef<Self>,
> +        ArrayVec<{ bindings::NR_FWNODE_REFERENCE_ARGS as usize }, u64>,
> +    )> {
> +        let mut out_args = bindings::fwnode_reference_args::default();
> +
> +        let (nargs_prop, nargs) = match nargs {
> +            NArgs::Prop(nargs_prop) => (nargs_prop.as_char_ptr(), 0),
> +            NArgs::N(nargs) => (ptr::null(), nargs),
> +        };
> +
> +        let ret = unsafe {
> +            bindings::fwnode_property_get_reference_args(
> +                self.0.get(),
> +                prop.as_char_ptr(),
> +                nargs_prop,
> +                nargs,
> +                index,
> +                &mut out_args,
> +            )
> +        };
> +        to_result(ret)?;
> +
> +        let node = unsafe { FwNode::from_raw(out_args.fwnode) };
> +        let mut args = ArrayVec::default();
> +
> +        for i in 0..out_args.nargs {
> +            args.push(out_args.args[i as usize]);
> +        }

Why the copy? Can't you just write an abstraction for struct
fwnode_reference_args and just return an instance of that?


