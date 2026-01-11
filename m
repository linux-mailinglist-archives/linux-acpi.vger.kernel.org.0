Return-Path: <linux-acpi+bounces-20158-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A49D0FBEC
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Jan 2026 21:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A80F33002BB9
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Jan 2026 20:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DED6136672;
	Sun, 11 Jan 2026 20:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXWgq9TO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924EA13FEE
	for <linux-acpi@vger.kernel.org>; Sun, 11 Jan 2026 20:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768161683; cv=none; b=oaIOUHKoGkORZswNQNINDM9rkt9DWaWbnBCXyXp2wDIvil0Hy+Eth9vXCFw7VVmgCFpx79GmwhC8Y+IXUnpNJADjYjqEFHKuhvltFjge4HDHHKJHKtYpR0sW6x0MVIhP6TB0Wl4MjUnyzGZ9Dcx0UWmOqfY3cMVSH8YI2tEgoA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768161683; c=relaxed/simple;
	bh=C8W/5GsJmCIKCN/wg4T3obD+ZMFqBZlAawRgEpe0aZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bx2oFh54uxX6ucYPxYXlb+n1yzDlLRP7sdXXFhlzsbo8jZW3LD3E8IF5/ZIIhruym+/Pfn3cdtAanU6s58aNEB0VBUG2E8B3rQ7D5CAnCirF1iRhQBitwQ6CkHQamjjdGln3QQgc8/hDEolxwJCSSKkHIqhZ3rZSUMFZjBCPTtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXWgq9TO; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7ce2b17a2e4so3803291a34.3
        for <linux-acpi@vger.kernel.org>; Sun, 11 Jan 2026 12:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768161680; x=1768766480; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AAEdLK+X3YFomibfs/nJUGuHj9KEH+0Eq3zrH9g87PM=;
        b=lXWgq9TO4TwQKTqMDTPAdkujWgRrX3p7P8y+icgRiYj81mbfxBReuhRMGnW3nZxT91
         kvyIKfLc9gxpqgdZIeG/ZjcgUPf+BH4mt3sONQ8ssw319xsLR/5oPLZ5786XRrdlvwQK
         3WRpMlKBkochgjuua23RQPYuQTAPxzwskGb6KD3xzAaIrq4+TZaW3XLyO9ok+W0NXeXi
         /bmCDPCGZHZnbvF7HxayJfsq/LPamqLG3Cm++NoV13d/r/tyntrafF/XVA5UgcY1kO29
         iHZ1ccigYR72Vgg9PaZhSK3vQeY1NzjNIM+mtbgJF6wjZZVyAsPY5TIV5JgHJyXvfg+h
         XyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768161680; x=1768766480;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAEdLK+X3YFomibfs/nJUGuHj9KEH+0Eq3zrH9g87PM=;
        b=HTrst2wh2L6aa5yUVc996pwL3ssILIuTeMDdfH780oNUO+MlfPKAueHFYzq/idVUNi
         eq1U+WK+9VNbppvOy/T0IZaxa7me/s0/enZZoGRRyHgPMB/TOolx441YNBOP579fas9n
         qlEFuNdSUZOcOAflMVEn+wLWhkwPOdBEmXBT7GkwXt0F8BvZYJLMK5lF5+ddra3Hfblt
         iHTi5i3h2p1SYQ3d1/3vRup1cUvOevNL5IGVitJdpGXciqFZFlc+v5wBpLN0Hzb0uepn
         NqK6ukZX9h3jYDEKr+KFHfUI9zg7Zbl1r+g6roHlMY1uDhYUuM3kWyFggGqpyKcZqe/x
         ryDg==
X-Forwarded-Encrypted: i=1; AJvYcCVJ5D+p9eXyiXG/3cJsgVvN0OtiJbb4IgS6NI6ofYjuvtO+1UbEyLJgt35ZTtQHwhH4NlARuTADH1Xv@vger.kernel.org
X-Gm-Message-State: AOJu0YyrkepTM7M61+8v0EUC09NB6+sT3dQZZJ32GOEgfpuWVbOIXhAC
	uHRP97QHY4bhIcQk5f3JjQm9GRvn4nnU4ZxoU+WquOifdJ42++3w1f4EmYsGmquN
X-Gm-Gg: AY/fxX7zhhxpIOw8X7ecP4kHXVscocCECcD2qiSVGMnYjMj8+trMyjDc4KfoSA6/H4B
	FkUzWz/5tX9xFfS58NVQiOF5AjsblHbP5A17xRiTgbdyKWSZeKwaJc1mjlxeJWxILPS4J3B7lb0
	DgLqZLFLvkIN0WVf3xwcetDVnQoTRJVob2yjqfetfeqK32o8GJ/Fu9YHUKy/KhGgZWsZ3Azs/xO
	gZUWJDwrs6GfoEVeXspYjA7w2yQmQCyBwHPe2BrszKg56SWWLVPrVThuAFto8VtoDx4EFNVJ5iu
	74LB65RLBd1E1PVDr6VmJafr4Y+UfOrj/nMRTUhnGymADHa7Fq2TO3o7WT6h0iMl/xettjXxdVa
	v/OMUXFIWDOc/2skhPzV7p6EUA29LHHyHR+iaRjgyMuq/R4r7l9t4HPmX665SKovlqjEb/ZrMCw
	CxqitjyHVhZTpokG1JgrmLmmwq2OtNXW3SaaJAoOUiZWVu9pv0EK4sclZx
X-Google-Smtp-Source: AGHT+IGKsa+eUTRHfgJbARJeOP9InejOY5GSkszKPFd2NTD++JXS3K7YXw/8XYAxcz87WdhhQS3AcA==
X-Received: by 2002:a05:6830:469a:b0:7cb:133b:c07f with SMTP id 46e09a7af769-7ce50a7037bmr6041339a34.28.1768161680504;
        Sun, 11 Jan 2026 12:01:20 -0800 (PST)
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com. [209.85.161.54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478af8b2sm11324389a34.15.2026.01.11.12.01.19
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 12:01:20 -0800 (PST)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-65f66a770cbso1528764eaf.1
        for <linux-acpi@vger.kernel.org>; Sun, 11 Jan 2026 12:01:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWv7NPlS7VKY+vpvStN2Oz61nHrcGiOPTPcUGwcNwkADkBtZixt9V106mwLsqRPic/dQSEEsdUfvWim@vger.kernel.org
X-Received: by 2002:a05:6820:603:b0:65f:6794:9e6f with SMTP id
 006d021491bc7-65f6794a7admr4485979eaf.24.1768161679199; Sun, 11 Jan 2026
 12:01:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768153572.git.foxido@foxido.dev> <42c8729d79c1264a2100b00d58b3f28a4584e585.1768153572.git.foxido@foxido.dev>
In-Reply-To: <42c8729d79c1264a2100b00d58b3f28a4584e585.1768153572.git.foxido@foxido.dev>
From: Kari Argillander <kari.argillander@gmail.com>
Date: Sun, 11 Jan 2026 22:01:08 +0200
X-Gmail-Original-Message-ID: <CAKBF=pvPFLtbYj_sR6j2HnE=uS9fwWLJnEMqk9_8FcfeTfo7gg@mail.gmail.com>
X-Gm-Features: AZwV_QifGwMHIW_mnzPBJDYNjeBOvmsZ_JjGTY4GL-K_cUTwegKGVWCBpxcOZUw
Message-ID: <CAKBF=pvPFLtbYj_sR6j2HnE=uS9fwWLJnEMqk9_8FcfeTfo7gg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: add WMI abstractions
To: Gladyshev Ilya <foxido@foxido.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@gmail.com>, Armin Wolf <W_Armin@gmx.de>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Still found couple small things. Overall these looks really good to me.
Waiting for more. Please CC also me to this series. Usually you CC
people who do some reviewing as then they notice right away when
new series comes and can give another look.

On Sun, 11 Jan 2026 at 20:33, Gladyshev Ilya <foxido@foxido.dev> wrote:
>
> This introduces Rust abstraction for WMI subsystem via wmi::Driver trait
> and module_wmi_driver/wmi_device_table macros. Driver can be probed,
> notified on events and removed -- almost everything C-side can do.
>
> This abstraction will be used by subsequent redmi_wmi_rs reference
> driver.
>
> Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>
> ---
>  MAINTAINERS                     |   1 +
>  rust/bindings/bindings_helper.h |   1 +
>  rust/kernel/lib.rs              |   2 +
>  rust/kernel/wmi.rs              | 286 ++++++++++++++++++++++++++++++++
>  4 files changed, 290 insertions(+)
>  create mode 100644 rust/kernel/wmi.rs
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 765ad2daa218..4909ae8be6e3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -404,6 +404,7 @@ F:  Documentation/driver-api/wmi.rst
>  F:     Documentation/wmi/
>  F:     drivers/platform/wmi/
>  F:     include/uapi/linux/wmi.h
> +F:     rust/kernel/wmi.rs
>
>  ACRN HYPERVISOR SERVICE MODULE
>  M:     Fei Li <fei1.li@intel.com>
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index a067038b4b42..f9671280c6b5 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -85,6 +85,7 @@
>  #include <linux/usb.h>
>  #include <linux/wait.h>
>  #include <linux/workqueue.h>
> +#include <linux/wmi.h>
>  #include <linux/xarray.h>
>  #include <trace/events/rust_sample.h>
>
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index f812cf120042..db3e649d26eb 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -151,6 +151,8 @@
>  pub mod uaccess;
>  #[cfg(CONFIG_USB = "y")]
>  pub mod usb;
> +#[cfg(CONFIG_ACPI_WMI)]
> +pub mod wmi;
>  pub mod workqueue;
>  pub mod xarray;
>
> diff --git a/rust/kernel/wmi.rs b/rust/kernel/wmi.rs
> new file mode 100644
> index 000000000000..d6b9bc29a4d6
> --- /dev/null
> +++ b/rust/kernel/wmi.rs
> @@ -0,0 +1,286 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Abstractions for the WMI devices.
> +//!
> +//! C header: [`include/linux/wmi.h`](srctree/include/linux/wmi.h).
> +
> +use crate::{
> +    acpi::AcpiObject,
> +    device,
> +    device_id::{
> +        RawDeviceId,
> +        RawDeviceIdIndex, //
> +    },
> +    driver,
> +    error::{
> +        from_result,
> +        to_result,
> +        VTABLE_DEFAULT_ERROR, //
> +    },
> +    prelude::*,
> +    types::Opaque, //
> +};
> +use core::{
> +    marker::PhantomData,
> +    ptr::NonNull, //
> +};
> +use macros::vtable;
> +
> +/// [`IdTable`](kernel::device_id::IdTable) type for WMI.
> +pub type IdTable<T> = &'static dyn kernel::device_id::IdTable<DeviceId, T>;
> +
> +/// The WMI driver trait.
> +///
> +/// Driver can be called from arbitary thread without any ordering guarantees.

s/arbitary/arbitrary

> +#[vtable]
> +pub trait Driver: Send + Sync {
> +    /// The type holding information about each one of the device ids supported by the driver.
> +    type IdInfo: 'static;
> +
> +    /// The table of device ids supported by the driver.
> +    const TABLE: IdTable<Self::IdInfo>;
> +
> +    /// WMI driver probe.
> +    ///
> +    /// Called when a new WMI device is bound to this driver.
> +    /// Implementers should attempt to initialize the driver here.
> +    fn probe(dev: &Device<device::Core>, id_info: &Self::IdInfo) -> impl PinInit<Self, Error>;
> +
> +    /// WMI device notify.
> +    ///
> +    /// Called when new WMI event received from bounded device.

Maybe add here little bit info what does it mean that AcpiObject is
Optional. Something like:

/// Some notification events do not provide any additional ACPI data.
/// In those cases, `event` will be `None`.

> +    fn notify(self: Pin<&Self>, _dev: &Device<device::Bound>, _event: Option<&AcpiObject<'_>>) {
> +        build_error!(VTABLE_DEFAULT_ERROR);
> +    }
> +
> +    /// WMI driver remove.
> +    ///
> +    /// Called when the WMI driver is unbound from a WMI device.

Just copy paste this from example PCI. That way it is clear that
usually this should not be used.

    /// WMI driver unbind.
    ///
    /// Called when a [`Device`] is unbound from its bound [`Driver`].
Implementing this callback
    /// is optional.
    ///
    /// This callback serves as a place for drivers to perform
teardown operations that require a
    /// `&Device<Core>` or `&Device<Bound>` reference. For instance,
drivers may try to perform I/O
    /// operations to gracefully tear down the device.
    ///
    /// Otherwise, release operations for driver resources should be
performed in `Self::drop`.

> +    fn unbind(self: Pin<&Self>, _dev: &Device<device::Core>) {
> +        build_error!(VTABLE_DEFAULT_ERROR);
> +    }
> +}
> +
> +/// A WMI device.
> +///
> +/// This structure represents the Rust abstraction for a C [`struct wmi_device`].
> +/// The implementation abstracts the usage of a C [`struct wmi_device`] passed
> +/// in from the C side.
> +pub struct Device<Cxt: device::DeviceContext = device::Normal> {
> +    inner: Opaque<bindings::wmi_device>,
> +    _p: PhantomData<Cxt>,
> +}
> +
> +impl<Cxt: device::DeviceContext> Device<Cxt> {
> +    fn as_raw(&self) -> *mut bindings::wmi_device {
> +        self.inner.get()
> +    }
> +}
> +
> +/// An adapter for the registration of WMI drivers.
> +pub struct Adapter<T: Driver>(T);
> +
> +// SAFETY: A call to `unregister` for a given instance of `RegType` is guaranteed to be valid if
> +// a preceding call to `register` has been successful.
> +unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
> +    type RegType = bindings::wmi_driver;
> +
> +    unsafe fn register(
> +        wdrv: &Opaque<Self::RegType>,
> +        name: &'static CStr,
> +        module: &'static ThisModule,
> +    ) -> Result {
> +        macro_rules! map_callback {
> +            ($flag:ident -> $callback:ident) => {
> +                if T::$flag {
> +                    Some(Self::$callback)
> +                } else {
> +                    None
> +                }
> +            };
> +        }
> +
> +        // SAFETY: It's safe to set the fields of `struct wmi_driver` on initialization.
> +        unsafe {
> +            (*wdrv.get()).driver.name = name.as_char_ptr();
> +            (*wdrv.get()).driver.probe_type = bindings::probe_type_PROBE_PREFER_ASYNCHRONOUS;
> +            (*wdrv.get()).id_table = T::TABLE.as_ptr();
> +            (*wdrv.get()).probe = map_callback!(HAS_PROBE -> probe_callback);
> +            (*wdrv.get()).notify = map_callback!(HAS_NOTIFY -> notify_callback);
> +            (*wdrv.get()).remove = map_callback!(HAS_UNBIND -> remove_callback);
> +            (*wdrv.get()).shutdown = None;
> +            (*wdrv.get()).no_singleton = true;

Maybe comment for no_singleton

    // Every new WMI driver needs to set this true.

> +            (*wdrv.get()).no_notify_data = true;

Maybe add comment for no_notify_data

    // With this notify_callback() can receive empty notification
    // which is we then transform to 'None'.

> +        }
> +
> +        // SAFETY: `wdrv` is guaranteed to be a valid `RegType`.
> +        to_result(unsafe { bindings::__wmi_driver_register(wdrv.get(), module.as_ptr()) })
> +    }
> +
> +    unsafe fn unregister(wdrv: &Opaque<Self::RegType>) {
> +        // SAFETY: `wdrv` is guaranteed to be a valid `RegType`.
> +        unsafe { bindings::wmi_driver_unregister(wdrv.get()) };
> +    }
> +}
> +
> +impl<T: Driver + 'static> Adapter<T> {
> +    extern "C" fn probe_callback(
> +        wdev: *mut bindings::wmi_device,
> +        id: *const c_void,
> +    ) -> kernel::ffi::c_int {
> +        // SAFETY: The WMI core only ever calls the probe callback with a valid pointer to a
> +        // `struct wmi_device`.
> +        //
> +        // INVARIANT: `wdev` is valid for the duration of `probe_callback()`.
> +        let wdev = unsafe { &*wdev.cast::<Device<device::CoreInternal>>() };
> +
> +        let id = id as usize;

Convention has been that "as" cast has comments like

    // CAST:

This can be added also other places. This is just nit from me and I do not
require this. So up to you.

> +        let info = T::TABLE.info(id);
> +
> +        from_result(|| {
> +            let data = T::probe(wdev, info);
> +
> +            wdev.as_ref().set_drvdata(data)?;
> +            Ok(0)
> +        })
> +    }
> +
> +    extern "C" fn notify_callback(
> +        wdev: *mut bindings::wmi_device,
> +        obj: *mut bindings::acpi_object,
> +    ) {
> +        // SAFETY: The WMI system only ever calls the notify callback with a valid pointer to a
> +        // `struct wmi_device`.
> +        let wdev = unsafe { &*wdev.cast::<Device<device::CoreInternal>>() };
> +        // SAFETY:
> +        // - AcpiObject is repr(transparent) wrapper around FFI object, so it's safe to cast
> +        //    raw pointer to reference (in terms of alignment and etc),
> +        // - Option<&ref> is guaranteed to have same layout as raw pointer (with NULL representing
> +        //    None) by Rust's "nullable pointer optimization".
> +        let obj: Option<&AcpiObject<'_>> =
> +            unsafe { core::mem::transmute(obj as *const AcpiObject<'_>) };
> +
> +        // SAFETY: `notify_callback` is only ever called after a successful call to
> +        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
> +        // and stored a `T`.
> +        let this = unsafe { wdev.as_ref().drvdata_borrow::<T>() };
> +        this.notify(wdev, obj);
> +    }
> +
> +    extern "C" fn remove_callback(wdev: *mut bindings::wmi_device) {
> +        // SAFETY: The WMI system only ever calls the remove callback with a valid pointer to a
> +        // `struct wmi_device`.
> +        let wdev = unsafe { &*wdev.cast::<Device<device::CoreInternal>>() };
> +
> +        // SAFETY: `remove_callback` is only ever called after a successful call to
> +        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
> +        // and stored a `T`.
> +        let this = unsafe { wdev.as_ref().drvdata_borrow::<T>() };
> +        this.unbind(wdev);
> +    }
> +}
> +
> +impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device<Ctx> {
> +    fn as_ref(&self) -> &device::Device<Ctx> {
> +        // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a pointer to a valid
> +        // `struct platform_device`.

Safety comment seems copy pasted so it is wrong.

> +        let dev = unsafe { &raw mut (*self.inner.get()).dev };
> +
> +        // SAFETY: `dev` points to a valid `struct device`.
> +        unsafe { device::Device::from_raw(dev) }
> +    }
> +}
> +
> +// SAFETY: `Device` is a transparent wrapper of a type that doesn't depend on `Device`'s generic
> +// argument.
> +kernel::impl_device_context_deref!(unsafe { Device });
> +kernel::impl_device_context_into_aref!(Device);
> +
> +// SAFETY: Instances of `Device` are always reference-counted.
> +unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
> +    fn inc_ref(&self) {
> +        // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
> +        unsafe { bindings::get_device(self.as_ref().as_raw()) };
> +    }
> +
> +    unsafe fn dec_ref(obj: NonNull<Self>) {
> +        // SAFETY: The safety requirements guarantee that the refcount is non-zero.
> +        unsafe { bindings::put_device(&raw mut (*obj.as_ref().as_raw()).dev) }
> +    }
> +}
> +
> +/// Abstraction for the WMI device ID structure, i.e. [`struct wmi_device_id`].
> +///
> +/// [`struct wmi_device_id`]: https://docs.kernel.org/driver-api/basics.html#c.wmi_device_id
> +#[repr(transparent)]
> +pub struct DeviceId(bindings::wmi_device_id);
> +
> +impl DeviceId {
> +    const GUID_LEN: usize = bindings::UUID_STRING_LEN as usize;
> +
> +    /// Constructs new DeviceId from GUID string.
> +    pub const fn new(guid: &[u8; Self::GUID_LEN]) -> Self {
> +        let mut inner: bindings::wmi_device_id = pin_init::zeroed();
> +
> +        build_assert!(inner.guid_string.len() == Self::GUID_LEN + 1);
> +
> +        // We are copying UUID_STRING_LEN bytes and we verified that UUID_STRING_LEN + 1 byte
> +        // exists and will remain '\0'. So we will construct valid C string.
> +        let mut i = 0;
> +        while i < Self::GUID_LEN {
> +            inner.guid_string[i] = guid[i];
> +            i += 1;
> +        }
> +
> +        Self(inner)
> +    }
> +}
> +
> +// SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `wmi_device_id` and does not add
> +// additional invariants, so it's safe to transmute to `RawType`.
> +unsafe impl RawDeviceId for DeviceId {
> +    type RawType = bindings::wmi_device_id;
> +}
> +
> +// SAFETY: `DRIVER_DATA_OFFSET` is the offset to the `context` field.
> +unsafe impl RawDeviceIdIndex for DeviceId {
> +    const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::wmi_device_id, context);
> +
> +    fn index(&self) -> usize {
> +        self.0.context as usize
> +    }
> +}
> +
> +/// Declares a kernel module that exposes a single WMI driver.
> +///
> +/// # Examples
> +///
> +/// ```ignore
> +/// module_wmi_driver! {
> +///     type: MyDriver,
> +///     name: "Module name",
> +///     author: ["Author name"],
> +///     description: "Description",
> +///     license: "GPL v2",
> +/// }
> +/// ```
> +#[macro_export]
> +macro_rules! module_wmi_driver {
> +    ($($f:tt)*) => {
> +        $crate::module_driver!(<T>, $crate::wmi::Adapter<T>, { $($f)* });
> +    }
> +}
> +
> +/// Create a WMI `IdTable` with its alias for modpost.
> +#[macro_export]
> +macro_rules! wmi_device_table {
> +    ($table_name:ident, $module_table_name:ident, $id_info_type: ty, $table_data: expr) => {
> +        const $table_name: $crate::device_id::IdArray<
> +            $crate::wmi::DeviceId,
> +            $id_info_type,
> +            { $table_data.len() },
> +        > = $crate::device_id::IdArray::new($table_data);
> +
> +        $crate::module_device_table!("wmi", $module_table_name, $table_name);
> +    };
> +}
> --
> 2.52.0
>
>

