Return-Path: <linux-acpi+bounces-12503-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF56A734B0
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Mar 2025 15:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B68D1897A7B
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Mar 2025 14:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9ECF214A98;
	Thu, 27 Mar 2025 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBV24t6e"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77331217F36;
	Thu, 27 Mar 2025 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743086414; cv=none; b=SNSO0f5OVW5IyVACjsNo9bFcReVTnMLvNOClpV1G3rf7g1LvgoxBZcdCk6cH83KaKl1d1jVsSeEj4RSUrAT6/BELZ+WgYjGRD07HinLFQCNFVyySsVQTBnF7+C2Z0qc3m+oX6Pn24YlGr4+35d8zTXdBAvr3CzYSkiI5E1nNDbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743086414; c=relaxed/simple;
	bh=xLojPGVZuKTt2T24et9s0pONVfQDrJThoOxlvufCtd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUqDu6L+9/7JTkXC/gZwg/Mybj5OL0IvF5nGpeddZpZ/gIeU33ofhVM46M1gIuYtLkf8x17oTT9AHXcGrTXFNYswFJCtCwclot6IiIdp5uIWrd9zDEbol0Nm2WrwYjOsP7/aWmByAZLpx2yEneV9jr5yTMJ9ErAwbn0OdIvriaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBV24t6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9E4C4CEDD;
	Thu, 27 Mar 2025 14:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743086414;
	bh=xLojPGVZuKTt2T24et9s0pONVfQDrJThoOxlvufCtd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WBV24t6e4qika/ZQS+tyW6B3U/U0XkMB/HQ+aVjR8QunDh47/Arl+KSULt3Egbd0e
	 auAPkY54FvT+5SV8s6UQs0FlWTLAZVfMcSNHC5SPzCJ3ZwWKoThP0XGpeSBtCZ7z25
	 46tFOmjujK43S/2vTsduvvtxgmvLukWYX+KMepOvQw4Z+rGDIm8++oWLfNzvSvbFF8
	 ENYMV1+QPBaNO8N24KBY9T62kSshmYVlcCwVRSd6V1nYQrPOVPp2MOqixmtR/1Q7I0
	 kDiWHt5Vxw3vsJKsgidrT+vL7GTpoqx45/i5V/ZMCwwDgFebEnToo53FsHB6RjwbNU
	 kEZih7H4TxZqw==
Date: Thu, 27 Mar 2025 15:40:06 +0100
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
Subject: Re: [PATCH 07/10] rust: Add arrayvec
Message-ID: <Z-VjRmiWDj6teoFL@cassiopeiae>
References: <20250326171411.590681-1-remo@buenzli.dev>
 <20250326171411.590681-8-remo@buenzli.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326171411.590681-8-remo@buenzli.dev>

On Wed, Mar 26, 2025 at 06:13:46PM +0100, Remo Senekowitsch wrote:
> This patch is basically a proof of concept intendend to gather feedback
> about how to do this properly. Normally I would want to use the crate
> from crates.io[1], but that's not an option in the kernel. We could also
> vendor the entire source code of arrayvec. I'm not sure if people will
> be happy with that.

Do we really need this? The only user in this series I could spot was
property_get_reference_args(). And I think that with a proper abstraction of
struct fwnode_reference_args we could avoid to copy memory at all.

If it turns out we actually need something like this, I'd prefer to move it to
rust/kernel/alloc/ and see if it's worth to derive a common trait that maybe can
share a few things between ArrayVec and Vec.

> 
> [1] https://crates.io/crates/arrayvec
> 
> Signed-off-by: Remo Senekowitsch <remo@buenzli.dev>
> ---
>  rust/kernel/arrayvec.rs | 81 +++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs      |  1 +
>  2 files changed, 82 insertions(+)
>  create mode 100644 rust/kernel/arrayvec.rs
> 
> diff --git a/rust/kernel/arrayvec.rs b/rust/kernel/arrayvec.rs
> new file mode 100644
> index 000000000..041e7dcce
> --- /dev/null
> +++ b/rust/kernel/arrayvec.rs
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Provides [ArrayVec], a stack-allocated vector with static capacity.
> +
> +use core::mem::MaybeUninit;
> +
> +/// A stack-allocated vector with statically fixed capacity.
> +///
> +/// This can be useful to avoid heap allocation and still ensure safety where a
> +/// small but dynamic number of elements is needed.
> +///
> +/// For example, consider a function that returns a variable number of values,
> +/// but no more than 8. In C, one might achieve this by passing a pointer to
> +/// a stack-allocated array as an out-parameter and making the function return
> +/// the actual number of elements. This is not safe, because nothing prevents
> +/// the caller from reading elements from the array that weren't actually
> +/// initialized by the function. `ArrayVec` solves this problem, users are
> +/// prevented from accessing uninitialized elements.
> +///
> +/// This basically exists already (in a much more mature form) on crates.io:
> +/// <https://crates.io/crates/arrayvec>
> +#[derive(Debug)]
> +pub struct ArrayVec<const N: usize, T> {
> +    array: [core::mem::MaybeUninit<T>; N],
> +    len: usize,
> +}
> +
> +impl<const N: usize, T> ArrayVec<N, T> {
> +    /// Adds a new element to the end of the vector.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if the vector is already full.
> +    pub fn push(&mut self, elem: T) {
> +        if self.len == N {
> +            panic!("OOM")

Please do not panic, this should return a Result instead.

