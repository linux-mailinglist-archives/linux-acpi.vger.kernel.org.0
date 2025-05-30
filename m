Return-Path: <linux-acpi+bounces-14019-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D9DAC9078
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 15:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4A299E0618
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 13:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33E0220F4E;
	Fri, 30 May 2025 13:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DC2EdB1v"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5869F21517C;
	Fri, 30 May 2025 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748612652; cv=none; b=C4m6akU5D8BWvuKVmPDogssJTIRwO7iUOd1JFmrIMwGj+J4EIw99GPf8x9YtqQIvfbv1B2UTzAffDs9MLXeM/suYcf9JL3Vn1K95XY1BYfs7jgvLsuR1aOLGQtkVShafmLtYgy+kVMReV8xJTPXnBF9an2l3xfZOUHrxvPy+3yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748612652; c=relaxed/simple;
	bh=GzYoAIWTFmgIn+wCMJ71Bjo9eHEgpY3fZvvllpFtNlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAHl+xILOwRqc3UN22IWD8dSBLKTWrP7ixAHwPCE6FlYmosu0GK6OfYlwh4SPKA4M2clfsq18KwaJWzKpZYjesQrOomwkuDMnG9yl13P+pwm07btJxKWQSEleCEdZUiZ/UfheXnOkP5Jv0jk7HqGdIfC1DSh6gOPQDsuqo4+oWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DC2EdB1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060D3C4CEE9;
	Fri, 30 May 2025 13:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748612649;
	bh=GzYoAIWTFmgIn+wCMJ71Bjo9eHEgpY3fZvvllpFtNlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DC2EdB1vtdkpGOZMMsKx/kpyFYb4kswSJcd1XqeGzxXAnTuPdQIBXtcYPlbZvRqlu
	 pMa0CK8OlPD5oI5U2s/euD+DSR5ZH5OS6hF1KDGAQyQLRfMjoL9SDvfkaeWH3LWEq2
	 4qkjbHgtim+qvaXkM5RnpzMS/0FoAbQSt/od8YZM=
Date: Fri, 30 May 2025 15:44:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Igor Korotin <igor.korotin.linux@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-acpi@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: acpi: add `acpi::DeviceId` abstraction
Message-ID: <2025053001-navigate-worry-c75b@gregkh>
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
> ---
>  MAINTAINERS         |  1 +
>  rust/kernel/acpi.rs | 63 +++++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs  |  1 +
>  3 files changed, 65 insertions(+)
>  create mode 100644 rust/kernel/acpi.rs

I'm not seeing any "subsequent patches" here.  Is this part of a patch
series that didn't all get sent out properly?

thanks,

greg k-h


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
> +        // TODO: Use `clone_from_slice` once the corresponding types do match.
> +        let mut i = 0;
> +        while i < src.len() {
> +            acpi.id[i] = src[i] as _;
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

Aren't these supposed to be sorted?

thanks,

greg k-h

