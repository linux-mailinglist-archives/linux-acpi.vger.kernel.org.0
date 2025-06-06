Return-Path: <linux-acpi+bounces-14193-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E09AD037B
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 15:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CFE0173A81
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 13:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109F7289353;
	Fri,  6 Jun 2025 13:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qg8qAs4c"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30B627F164;
	Fri,  6 Jun 2025 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749217820; cv=none; b=QQtzjQ8zXGNP9LGap2aNjKe7WLq9p2N153WgdVVoxtZFpihUJaEfTJzc795XSFbZW+oV8qTuRgcrM96G9I0pE/W9jsGF6AUKDJ44PR1Q2aSSnhFL8LyvU73ymoWIRm2NwZ8HIVXUV85+2Q09uH61ZDZPIMINdn1UcsNeEGPTuWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749217820; c=relaxed/simple;
	bh=RvvYVQ5MhdaaL45STXuT2LS673L9xdDS8erLOZOlJak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCQCAuzT3Gzhh43JJVGzAN+rXozCalfzCQ8TLf2gvkvQzVpoTTE987GpiRNywEHw9q9+2kktNB/5iW1k0J1xvRN7UWAjLHFawcpjmoQaGdupErKln6ossuQ7mDfS2VAGU14IqrMle3r/3OX2YgIV18PAl/F6ksTuh3aH0FIz8+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qg8qAs4c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891BFC4CEEB;
	Fri,  6 Jun 2025 13:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749217818;
	bh=RvvYVQ5MhdaaL45STXuT2LS673L9xdDS8erLOZOlJak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qg8qAs4cFm3Hc2vDwqoJE/iVCWx/sXCbl6qW/Ct7ghYNgpZ+MCRqm7TO/ZaR9xiy6
	 sdLmDjzNsE/SV1LfHEnyInyp+BGWeGCm1A5A5rilHuw2vPIOjMNWjxqEopWfkjeTg2
	 cZJBhBaeKxrKtzu083NGdQJqRMpT9AqqHxGjwYbk/I3hEUabFF38ULa7gzFdznxGZZ
	 DXXaFjgX8PONtmKWkDiqk6PLNQ8b+PaMmTychwDD6QifSfZd7RHSeJVjy7FvUXJrAa
	 aarsCmfZ0TItTxMnUrszsIOgBudVQlkv2P5GTlGYCCW7aI8L097iYunDDZ0HNDJCK8
	 0JyjtPnfKX6mQ==
Date: Fri, 6 Jun 2025 15:50:10 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Igor Korotin <igor.korotin@yahoo.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alex Hung <alex.hung@amd.com>, Tamir Duberstein <tamird@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Xiangfei Ding <dingxiangfei2009@gmail.com>,
	Igor Korotin <igor.korotin.linux@gmail.com>
Subject: Re: [PATCH v2 3/5] rust: driver: Add ACPI id table support to
 Adapter trait
Message-ID: <aELyEqg0GrkC8oZY@pollux>
References: <20250605161956.3658374-1-igor.korotin.linux@gmail.com>
 <20250605162726.3659792-1-igor.korotin@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605162726.3659792-1-igor.korotin@yahoo.com>

On Thu, Jun 05, 2025 at 05:27:26PM +0100, Igor Korotin wrote:
> From: Igor Korotin <igor.korotin.linux@gmail.com>
> 
> Extend the `Adapter` trait to support ACPI device identification.
> 
> This mirrors the existing Open Firmware (OF) support (`of_id_table`) and
> enables Rust drivers to match and retrieve ACPI-specific device data
> when `CONFIG_ACPI` is enabled.
> 
> To avoid breaking compilation, a stub implementation of `acpi_id_table()`
> is added to the Platform adapter; the full implementation will be provided
> in a subsequent patch.
> ---
>  rust/bindings/bindings_helper.h |  1 +
>  rust/kernel/driver.rs           | 58 ++++++++++++++++++++++++++++++---
>  rust/kernel/platform.rs         |  5 +++
>  3 files changed, 60 insertions(+), 4 deletions(-)
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index e0bcd130b494..d974fc6c141f 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -6,6 +6,7 @@
>   * Sorted alphabetically.
>   */
>  
> +#include <linux/acpi.h>
>  #include <kunit/test.h>
>  #include <linux/blk-mq.h>
>  #include <linux/blk_types.h>
> diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
> index ec9166cedfa7..d4098596188a 100644
> --- a/rust/kernel/driver.rs
> +++ b/rust/kernel/driver.rs
> @@ -6,7 +6,7 @@
>  //! register using the [`Registration`] class.
>  
>  use crate::error::{Error, Result};
> -use crate::{device, of, str::CStr, try_pin_init, types::Opaque, ThisModule};
> +use crate::{device, of, acpi, str::CStr, try_pin_init, types::Opaque, ThisModule};
>  use core::pin::Pin;
>  use pin_init::{pin_data, pinned_drop, PinInit};
>  
> @@ -141,6 +141,38 @@ pub trait Adapter {
>      /// The type holding driver private data about each device id supported by the driver.
>      type IdInfo: 'static;
>  
> +    /// The [`acpi::IdTable`] of the corresponding driver
> +    fn acpi_id_table() -> Option<acpi::IdTable<Self::IdInfo>>;
> +
> +    /// Returns the driver's private data from the matching entry in the [`acpi::IdTable`], if any.
> +    ///
> +    /// If this returns `None`, it means there is no match with an entry in the [`acpi::IdTable`].
> +    #[cfg(CONFIG_ACPI)]
> +    fn acpi_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
> +        let table = Self::acpi_id_table()?;
> +
> +        // SAFETY:
> +        // - `table` has static lifetime, hence it's valid for read,
> +        // - `dev` is guaranteed to be valid while it's alive, and so is `pdev.as_ref().as_raw()`.
> +        let raw_id = unsafe { bindings::acpi_match_device(table.as_ptr(), dev.as_raw()) };
> +
> +        if raw_id.is_null() {
> +            None
> +        } else {
> +            // SAFETY: `DeviceId` is a `#[repr(transparent)` wrapper of `struct of_device_id` and
> +            // does not add additional invariants, so it's safe to transmute.
> +            let id = unsafe { &*raw_id.cast::<acpi::DeviceId>() };
> +
> +            Some(table.info(<acpi::DeviceId as crate::device_id::RawDeviceId>::index(id)))
> +        }
> +    }
> +
> +    #[cfg(not(CONFIG_ACPI))]
> +    #[allow(missing_docs)]
> +    fn acpi_id_info(_dev: &device::Device) -> Option<&'static Self::IdInfo> {
> +        None
> +    }
> +
>      /// The [`of::IdTable`] of the corresponding driver.
>      fn of_id_table() -> Option<of::IdTable<Self::IdInfo>>;
>  
> @@ -178,9 +210,27 @@ fn of_id_info(_dev: &device::Device) -> Option<&'static Self::IdInfo> {
>      /// If this returns `None`, it means that there is no match in any of the ID tables directly
>      /// associated with a [`device::Device`].
>      fn id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
> -        let id = Self::of_id_info(dev);
> -        if id.is_some() {
> -            return id;
> +        // SAFETY: `id_info` is called from `Adapter::probe_callback` with a valid `dev` argument.
> +        let fwnode = unsafe{ (*dev.as_raw()).fwnode};

There is an abstraction for FwNode on the list [1] that I plan to merge soon.
Generally, it would make sense to build on top of that.

However, I don't understand why we need this and the subsequent
is_acpi_device_node() and is_of_node() checks.

Instead, I think we can keep the existing code and just add the following.

	let id = Self::acpi_id_info(dev);
	if id.is_some() {
	   return id;
	}

[1] https://lore.kernel.org/lkml/20250530192856.1177011-1-remo@buenzli.dev/

> +
> +        // SAFETY: `bindings::is_acpi_device_node` checks `fwnode` before accessing `fwnode->ops`,
> +        // and only compares it with the address of `acpi_device_fwnode_ops`.
> +        if unsafe { bindings::is_acpi_device_node(fwnode) } {

As mentioned above, I think we don't need this check.

> +            let id = Self::acpi_id_info(dev);
> +
> +            if id.is_some() {
> +                return id;
> +            }
> +        }
> +
> +        // SAFETY: `bindings::is_of_node` checks `fwnode` before accessing `fwnode->ops`,
> +        // and only compares it with the address of `of_fwnode_ops`.
> +        if unsafe { bindings::is_of_node(fwnode) } {

Same here.

> +            let id = Self::of_id_info(dev);
> +
> +            if id.is_some() {
> +                return id;
> +            }
>          }
>  
>          None
> diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
> index fd4a494f30e8..3cc9fe6ccfcf 100644
> --- a/rust/kernel/platform.rs
> +++ b/rust/kernel/platform.rs
> @@ -5,6 +5,7 @@
>  //! C header: [`include/linux/platform_device.h`](srctree/include/linux/platform_device.h)
>  
>  use crate::{
> +    acpi,
>      bindings, device, driver,
>      error::{to_result, Result},
>      of,
> @@ -95,6 +96,10 @@ impl<T: Driver + 'static> driver::Adapter for Adapter<T> {
>      fn of_id_table() -> Option<of::IdTable<Self::IdInfo>> {
>          T::OF_ID_TABLE
>      }
> +
> +    fn acpi_id_table() -> Option<acpi::IdTable<Self::IdInfo>> {
> +        None
> +    }
>  }
>  
>  /// Declares a kernel module that exposes a single platform driver.
> -- 
> 2.43.0
> 

