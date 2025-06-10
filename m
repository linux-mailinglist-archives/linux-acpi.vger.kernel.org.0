Return-Path: <linux-acpi+bounces-14271-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1518AD3CB8
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 17:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 882503ABFF8
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 15:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C3E235BE8;
	Tue, 10 Jun 2025 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYPFTZuB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AA0231820;
	Tue, 10 Jun 2025 15:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568529; cv=none; b=plMKb55JhuAzlfZTvmn41ozTd0o2yhdIAQYlfW7UlQLbzShirS1fGDuwEIpV0oGB+wwvPnNZUzGqY8Pz504n8YzVHHN9HD29FHm0L2vy/ayoWtOwgF3pZh3huPA17p8To4FtUsD3rA3cZs2djb5pwndt95eIWcJ2HHTpgI/YIo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568529; c=relaxed/simple;
	bh=AxJkQsibdaksU42884Z6x6WQyQHXWY2r1ANS6fr93Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VR80ixxrnNejO3AYYXDM4taZjD6goZhPFk+yu0vKM0WNDZjwGWsap4gUKO6xrwfv/12KyGK59fsiWuZKBI9AsMIA1yAzC7TdCoUG1Jb8GqfDUYA1YfzU2PwyFQT4UenZxqMdXqejz7N/3Vpnvffp1W91TeQ1U9Vq+6epK+dSAVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYPFTZuB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1895C4CEED;
	Tue, 10 Jun 2025 15:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749568528;
	bh=AxJkQsibdaksU42884Z6x6WQyQHXWY2r1ANS6fr93Z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SYPFTZuB3+wiMQZvX2Gaa3oYXJUT0klmCkiTwWo0kSdBYRrlvt1Hc0+RkZ9Bk4RX9
	 mhu5ldHrtNzMp5cBcl2CURy9KtksyQ9owBgl+mnPkV1OiFpDH9wqINQwioXZqll/bX
	 68x/9DXUKWpRrt9z10sj0lMIUsGUyI3e8cau81UC44Ag/oOdC16HhSrrGt13xqXf3Q
	 PQ1n2oLJhPll0B3vVWMdJd4ld96ZyPPVvz3tJ8PheXzIibQSwki2qUiiWiz0ggb/E7
	 fnmj623DSP5eBlfwr7zw1wP+SkE6UYLs5ymgo6yb/nAQyCuOcsq2xMMNsohftX4Uaf
	 BfohatvfOWQTA==
Date: Tue, 10 Jun 2025 17:15:21 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Igor Korotin <igor.korotin.linux@gmail.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, rafael@kernel.org,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-acpi@vger.kernel.org,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, lenb@kernel.org, wedsonaf@gmail.com,
	viresh.kumar@linaro.org, alex.hung@amd.com,
	dingxiangfei2009@gmail.com
Subject: Re: [PATCH v4 3/5] rust: driver: Consolidate `Adapter` methods using
 `#[cfg]`
Message-ID: <aEhMCVJG3c7zVbyU@cassiopeiae>
References: <20250610145234.235005-1-igor.korotin.linux@gmail.com>
 <20250610150538.238007-1-igor.korotin.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610150538.238007-1-igor.korotin.linux@gmail.com>

On Tue, Jun 10, 2025 at 04:05:38PM +0100, Igor Korotin wrote:
> Refactor the `acpi_id_info` and `of_id_info` methods in the `Adapter` trait
> to reduce duplication. Previously, each method had two versions selected
> via `#[cfg(...)]` and `#[cfg(not(...))]`. This change merges them into a
> single method per case by using `#[cfg]` blocks within the method bodies.
> 
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
> ---
>  rust/kernel/driver.rs | 76 +++++++++++++++++++++----------------------
>  1 file changed, 38 insertions(+), 38 deletions(-)
> 
> diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
> index 638f1d270af8..805f61bd4a50 100644
> --- a/rust/kernel/driver.rs
> +++ b/rust/kernel/driver.rs
> @@ -147,30 +147,30 @@ pub trait Adapter {
>      /// Returns the driver's private data from the matching entry in the [`acpi::IdTable`], if any.
>      ///
>      /// If this returns `None`, it means there is no match with an entry in the [`acpi::IdTable`].
> -    #[cfg(CONFIG_ACPI)]
>      fn acpi_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
> -        let table = Self::acpi_id_table()?;
> +        #[cfg(not(CONFIG_ACPI))] {
> +            let _ = dev;
> +            return None;
> +        }
>  
> -        // SAFETY:
> -        // - `table` has static lifetime, hence it's valid for read,
> -        // - `dev` is guaranteed to be valid while it's alive, and so is `pdev.as_ref().as_raw()`.
> -        let raw_id = unsafe { bindings::acpi_match_device(table.as_ptr(), dev.as_raw()) };
> +        #[cfg(CONFIG_ACPI)] {
> +            let table = Self::acpi_id_table()?;
>  
> -        if raw_id.is_null() {
> -            None
> -        } else {
> -            // SAFETY: `DeviceId` is a `#[repr(transparent)` wrapper of `struct of_device_id` and
> -            // does not add additional invariants, so it's safe to transmute.
> -            let id = unsafe { &*raw_id.cast::<acpi::DeviceId>() };
> +            // SAFETY:
> +            // - `table` has static lifetime, hence it's valid for read,
> +            // - `dev` is guaranteed to be valid while it's alive, and so is `pdev.as_ref().as_raw()`.
> +            let raw_id = unsafe { bindings::acpi_match_device(table.as_ptr(), dev.as_raw()) };
>  
> -            Some(table.info(<acpi::DeviceId as crate::device_id::RawDeviceId>::index(id)))
> -        }
> -    }
> +            if raw_id.is_null() {
> +                None
> +            } else {
> +                // SAFETY: `DeviceId` is a `#[repr(transparent)` wrapper of `struct of_device_id` and
> +                // does not add additional invariants, so it's safe to transmute.
> +                let id = unsafe { &*raw_id.cast::<acpi::DeviceId>() };
>  
> -    #[cfg(not(CONFIG_ACPI))]
> -    #[allow(missing_docs)]
> -    fn acpi_id_info(_dev: &device::Device) -> Option<&'static Self::IdInfo> {
> -        None
> +                Some(table.info(<acpi::DeviceId as crate::device_id::RawDeviceId>::index(id)))
> +            }
> +        }
>      }

It seems there has been a misunderstanding, the idea was to refactor
Adapter::of_id_info() in one patch and introduce Adapter::acpi_id_info() in a
subsequent patch already being the suggested implementation by Benno.

We try to avoid introducing code, just to change it again in a subsequent patch.

