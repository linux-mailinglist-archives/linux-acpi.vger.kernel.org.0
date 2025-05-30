Return-Path: <linux-acpi+bounces-14020-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1374FAC91BF
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 16:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C72EC4A0122
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 14:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343DC23373D;
	Fri, 30 May 2025 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2tGI9pC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A6D22F16E;
	Fri, 30 May 2025 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748616195; cv=none; b=YxTVYZFCIUVXNfTz+/GQqxJIbzx3ujwo0e0Mkqew3+mVbQRDTy0G4PQJyBbYUbL4vsjxtSh4PvYYaS+oyFC86vRduuvAWZiYby1lfphDzCfSBMDvP30L720t0UCZjVHvDCwVdKsZgjU3xcLER+ObketRrG0upVHr1yg1a4OlS9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748616195; c=relaxed/simple;
	bh=mY/b1aYZ4zd+kOTmSV/9uLnE2/GpBj9H7mUyqgsW6Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMyLxOWXdWFQUFo/rMtdQaePRBtI2tTDoT5aEA7xxiT9VvjSGxRiaXfPlBn1nasBXA/8gDygXYmAu3i8rVxM6q2nAuLKDZ9m5pFYesTpWSO3S+gYyymFq2GklAAgIoIkFcupZxQcr8glbeBMoAg7xt19Chpsc5l8ZPVyEX8Bpvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2tGI9pC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5390FC4CEE9;
	Fri, 30 May 2025 14:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748616194;
	bh=mY/b1aYZ4zd+kOTmSV/9uLnE2/GpBj9H7mUyqgsW6Bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q2tGI9pCPo8JExw4qGa00gTsqQs4sZa4Zx3V77oGvTMzuJ5B9MkkW+8XR3Wr0XrE0
	 Alm0r/RK4uIZguw/DyZP2VC59npUKO8qhOfMntAV7ZqROxgY8liBvnfVLXLdDcVCZs
	 sbP6ZFXGI8szVTZA2KOQqvzRfJ7JJqBudpelzGpz9iNVDWB4C23iUGkMkZqM3YIbRj
	 UkgiDZdO5ugRT5kMWiPiD0y/CExK2Apb6zlVZ4o461WaqpWyYa7k+oPpv5wF/5JT8/
	 Wf0+O3jOgCKW55pfpLHi1r3+9dZLXHgNwpFD153bsbfO2XONDvRneDwZwFLIjYVqGk
	 NjQhB7ZFH24wA==
Date: Fri, 30 May 2025 16:43:08 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Igor Korotin <igor.korotin.linux@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-acpi@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: acpi: add `acpi::DeviceId` abstraction
Message-ID: <aDnD_Bb3l6GiI_8K@cassiopeiae>
References: <20250530123815.1766726-1-igor.korotin.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530123815.1766726-1-igor.korotin.linux@gmail.com>

On Fri, May 30, 2025 at 01:38:06PM +0100, Igor Korotin wrote:
> `acpi::DeviceId` is an abstraction around `struct acpi_device_id`.
> 
> This is used by subsequent patches, in particular the i2c driver
> abstractions, to create ACPI device ID tables.
> 
> Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>

As Greg mentioned it would be nice to see the subsequent patches.

Also, for this to be useful you need to implement the generic glue code in
rust/kernel/driver.rs in the generic Adapter trait.

You also may want to connect it to the platform bus abstraction, just like the
OF bindings are, since I assume that's the bus you care about?

> ---
>  MAINTAINERS         |  1 +
>  rust/kernel/acpi.rs | 63 +++++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs  |  1 +
>  3 files changed, 65 insertions(+)
>  create mode 100644 rust/kernel/acpi.rs
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b659fb27ab63..5f8dfae08454 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -302,6 +302,7 @@ F:	include/linux/acpi.h
>  F:	include/linux/fwnode.h
>  F:	include/linux/fw_table.h
>  F:	lib/fw_table.c
> +F:	rust/kernel/acpi.rs
>  F:	tools/power/acpi/
>  
>  ACPI APEI
> diff --git a/rust/kernel/acpi.rs b/rust/kernel/acpi.rs
> new file mode 100644
> index 000000000000..bbd38910736c
> --- /dev/null
> +++ b/rust/kernel/acpi.rs
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Advanced Configuration and Power Interface abstractions.
> +
> +use crate::{bindings, device_id::RawDeviceId, prelude::*};
> +
> +/// IdTable type for ACPI drivers.
> +pub type IdTable<T> = &'static dyn kernel::device_id::IdTable<DeviceId, T>;
> +
> +/// An ACPI device id.
> +#[repr(transparent)]
> +#[derive(Clone, Copy)]
> +pub struct DeviceId(bindings::acpi_device_id);
> +
> +// SAFETY:
> +// * `DeviceId` is a `#[repr(transparent)` wrapper of `struct acpi_device_id` and does not add
> +//   additional invariants, so it's safe to transmute to `RawType`.
> +// * `DRIVER_DATA_OFFSET` is the offset to the `data` field.
> +unsafe impl RawDeviceId for DeviceId {
> +    type RawType = bindings::acpi_device_id;
> +
> +    const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::acpi_device_id, driver_data);
> +
> +    fn index(&self) -> usize {
> +        self.0.driver_data as _
> +    }
> +}
> +
> +impl DeviceId {
> +    const ACPI_ID_LEN: usize = 16;
> +
> +    /// Create a new device id from an ACPI 'id' string.
> +    pub const fn new(id: &'static CStr) -> Self {
> +        assert!(id.len() <= Self::ACPI_ID_LEN, "ID exceeds 16 bytes");
> +        let src = id.as_bytes_with_nul();
> +        // Replace with `bindings::acpi_device_id::default()` once stabilized for `const`.
> +        // SAFETY: FFI type is valid to be zero-initialized.
> +        let mut acpi: bindings::acpi_device_id = unsafe { core::mem::zeroed() };

The patch did not land yet, but for this there's the following improvement
upcoming:

https://lore.kernel.org/rust-for-linux/20250523145125.523275-13-lossin@kernel.org/

> +        // TODO: Use `clone_from_slice` once the corresponding types do match.

clone_from_slice() can't be used from const context, this comment is wrong in
of.rs (where you probably copied it from).

> +        let mut i = 0;
> +        while i < src.len() {
> +            acpi.id[i] = src[i] as _;

You can drop this cast, it shouldn't be needed anymore.

> +            i += 1;
> +        }
> +
> +        Self(acpi)
> +    }
> +}
> +
> +/// Create an ACPI `IdTable` with an "alias" for modpost.
> +#[macro_export]
> +macro_rules! acpi_device_table {
> +    ($table_name:ident, $module_table_name:ident, $id_info_type: ty, $table_data: expr) => {
> +        const $table_name: $crate::device_id::IdArray<
> +            $crate::acpi::DeviceId,
> +            $id_info_type,
> +            { $table_data.len() },
> +        > = $crate::device_id::IdArray::new($table_data);
> +
> +        $crate::module_device_table!("acpi", $module_table_name, $table_name);
> +    };
> +}
> +
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 15c5f72976cd..05f1d3870bf7 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -78,6 +78,7 @@
>  #[cfg(CONFIG_NET)]
>  pub mod net;
>  pub mod of;
> +pub mod acpi;

As mentioned by Greg, please keep this ordered.

