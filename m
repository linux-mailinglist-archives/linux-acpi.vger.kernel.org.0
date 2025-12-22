Return-Path: <linux-acpi+bounces-19773-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6F9CD5DEC
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 12:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1703E3041CF6
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 11:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D081F3112D3;
	Mon, 22 Dec 2025 11:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0aevQiS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB0D239E79;
	Mon, 22 Dec 2025 11:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766404238; cv=none; b=BWaNeAHs1aK7tlUT2e/6r3pnugpUC5lxPgr2xxsMNxpJy6d0YixxoqmcKeuGZ8etdUcApNVHrdnw9NAnGvzNGWdWQpYWQkcEuqG5NWSN1tRy66rp2uHwZ5Y9lmemgSRYpvYIwTCTfZ6rVBxwH26jrA3IGKOQiA9uPCKYjTj+tUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766404238; c=relaxed/simple;
	bh=WhCdTM+aRTwVD9MNtOdkcZNsIZowj80yg1ouTKHU5+0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=I28qwIfLrI0d5IY35ecSLAI+3uvGccUAB9xZckOGXQeR7jKyfH2NpAbk9Gv9Zps10NBA32u3U4fmlf0ZOhkpckPjnrQSGEICFdJJxN6U3lS12ZtASVw1udYrN1dzeG15bXVkocNcDUyEKv+wEqvFXzTLm2UKgqqSy/MFa+edeoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0aevQiS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2762C116D0;
	Mon, 22 Dec 2025 11:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766404238;
	bh=WhCdTM+aRTwVD9MNtOdkcZNsIZowj80yg1ouTKHU5+0=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=S0aevQiSSiRvp16fgMzbEMcYmZ92iEjb0U1nRr3AcB5QKb7NyEa0TFNnVP7g/8vXo
	 xZKQjPXhyU1uXb1YiqNx8Nquk2dxjcyejviLjLu13dHIpS0oETfwkZEiUVCxVTk5Mr
	 s9wiQOsPtyZ6dkpMVW0kq45KqqA70Fj3oRg6sM5Y2guLcMd1/4nY8YEvFDcmSsTxVJ
	 VbqlZpd9QWQNmr9uiAX3qcqLFkq7TOjfG5ARVsoa1PAv/iMBWkL4Ty45mrSURMCltm
	 /7GGlRXnQX5aExNwu424+NW13px1ED6Kvfog/u1BHknOUTOvscob0uNl9XfPMvZyD9
	 V7326loP7z8lg==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Dec 2025 12:50:32 +0100
Message-Id: <DF4Q1I15MG7E.Q8234J76FQ1O@kernel.org>
To: "Gladyshev Ilya" <foxido@foxido.dev>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [RFC PATCH 2/3] rust: introduce WMI abstractions
Cc: "foxido @ foxido . dev-cc= Rafael J. Wysocki" <rafael@kernel.org>, "Len
 Brown" <lenb@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Tamir
 Duberstein" <tamird@gmail.com>, "Armin Wolf" <W_Armin@gmx.de>,
 <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-acpi@vger.kernel.org>
References: <cover.1766331321.git.foxido@foxido.dev>
 <cc4a2e7e9fd5f07f8a0831ca085e489f0ae87d1f.1766331321.git.foxido@foxido.dev>
In-Reply-To: <cc4a2e7e9fd5f07f8a0831ca085e489f0ae87d1f.1766331321.git.foxido@foxido.dev>

On Sun Dec 21, 2025 at 7:22 PM CET, Gladyshev Ilya wrote:
> diff --git a/rust/kernel/wmi.rs b/rust/kernel/wmi.rs
> new file mode 100644
> index 000000000000..018e88d01e8c
> --- /dev/null
> +++ b/rust/kernel/wmi.rs
> @@ -0,0 +1,267 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Abstractions for the WMI devices.
> +//!
> +//! C header: [`include/linux/wmi.h`](srctree/include/linux/wmi.h)
> +
> +use crate::{
> +    acpi::AcpiObject,
> +    device,
> +    device_id::{RawDeviceId, RawDeviceIdIndex},
> +    driver,
> +    error::{from_result, to_result, VTABLE_DEFAULT_ERROR},
> +    prelude::*,
> +    types::Opaque,
> +};
> +use core::{
> +    marker::PhantomData,
> +    mem::MaybeUninit,
> +    ptr::{addr_of_mut, NonNull},
> +};
> +use macros::vtable;

Please use kernel vertical style.

[1] https://docs.kernel.org/rust/coding-guidelines.html#imports

> +
> +/// [`IdTable`](kernel::device_id::IdTable) type for WMI.
> +pub type IdTable<T> =3D &'static dyn kernel::device_id::IdTable<DeviceId=
, T>;
> +
> +/// The WMI driver trait.
> +#[vtable]
> +pub trait Driver: Send {
> +    /// The type holding information about each one of the device ids su=
pported by the driver.
> +    type IdInfo: 'static;
> +
> +    /// The table of device ids supported by the driver.
> +    const TABLE: IdTable<Self::IdInfo>;
> +
> +    /// WMI driver probe.
> +    ///
> +    /// Called when a new WMI device is bound to this driver.
> +    /// Implementers should attempt to initialize the driver here.
> +    fn probe(dev: &Device<device::Core>, id_info: &Self::IdInfo) -> impl=
 PinInit<Self, Error>;
> +
> +    /// WMI device notify.
> +    ///
> +    /// Called when new WMI event received from bounded device
> +    fn notify(&self, _dev: &Device<device::Core>, _event: &AcpiObject) {

Please use Pin<&Self> instead.

> +        build_error!(VTABLE_DEFAULT_ERROR);
> +    }
> +
> +    /// WMI driver remove.
> +    fn remove(self: Pin<KBox<Self>>, _dev: &Device<device::Core>) {

We can't pass the driver's device private data by value here. As long as th=
e
device is not fully unbound, there may still be calls to Device::drvdata();
please see also [2]). Hence, please use Pin<&Self> instead.

Also, please call this method unbind() to be consistent with other busses.

[2] https://lore.kernel.org/rust-for-linux/DEZMS6Y4A7XE.XE7EUBT5SJFJ@kernel=
.org/

> +        build_error!(VTABLE_DEFAULT_ERROR);
> +    }
> +}

<snip>

> +impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device<C=
tx> {
> +    fn as_ref(&self) -> &device::Device<Ctx> {
> +        // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a=
 pointer to a valid
> +        // `struct platform_device`.
> +        let dev =3D unsafe { addr_of_mut!((*self.inner.get()).dev) };

Please use &raw mut instead.

> +
> +        // SAFETY: `dev` points to a valid `struct device`.
> +        unsafe { device::Device::from_raw(dev) }
> +    }
> +}
> +
> +kernel::impl_device_context_deref!(unsafe { Device });
> +kernel::impl_device_context_into_aref!(Device);
> +
> +// SAFETY: Instances of `Device` are always reference-counted.
> +unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
> +    fn inc_ref(&self) {
> +        // SAFETY: The existence of a shared reference guarantees that t=
he refcount is non-zero.
> +        unsafe { bindings::get_device(self.as_ref().as_raw()) };
> +    }
> +
> +    unsafe fn dec_ref(obj: NonNull<Self>) {
> +        // SAFETY: The safety requirements guarantee that the refcount i=
s non-zero.
> +        unsafe { bindings::put_device(&raw mut (*obj.as_ref().as_raw()).=
dev) }
> +    }
> +}
> +
> +/// Abstraction for the WMI device ID structure, i.e. [`struct wmi_devic=
e_id`].
> +#[repr(transparent)]
> +pub struct DeviceId(bindings::wmi_device_id);
> +
> +impl DeviceId {
> +    /// Constructs new DeviceId from GUID string
> +    pub const fn new(guid: &[u8; bindings::UUID_STRING_LEN as usize]) ->=
 Self {
> +        // SAFETY: FFI type is valid to be zero-initialized.
> +        let mut inner: bindings::wmi_device_id =3D unsafe { MaybeUninit:=
:zeroed().assume_init() };
> +
> +        build_assert!(inner.guid_string.len() =3D=3D bindings::UUID_STRI=
NG_LEN as usize + 1);
> +
> +        // SAFETY: It's safe to copy UUID_STRING_LEN, because we validat=
ed lengths
> +        // Also we leave last byte zeroed -> guid_string is valid C stri=
ng
> +        unsafe {
> +            ::core::ptr::copy_nonoverlapping(
> +                guid.as_ptr(),
> +                &raw mut inner.guid_string[0],
> +                bindings::UUID_STRING_LEN as usize,
> +            );
> +        }

This does not compile without const_intrinsic_copy. I think we can enable i=
t
though, since it should be stable since 1.83.

> +
> +        Self(inner)
> +    }
> +}

