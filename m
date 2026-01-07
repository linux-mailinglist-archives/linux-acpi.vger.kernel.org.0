Return-Path: <linux-acpi+bounces-20022-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C33D00128
	for <lists+linux-acpi@lfdr.de>; Wed, 07 Jan 2026 21:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E83333040647
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Jan 2026 20:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0C0338F5B;
	Wed,  7 Jan 2026 20:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b="UcfMCxJa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="wFKkpf5l";
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="odLQckj4";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="nSe0+eEL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender5.mail.selcloud.ru (sender5.mail.selcloud.ru [5.8.75.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F26932ABFF;
	Wed,  7 Jan 2026 20:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.8.75.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767819259; cv=none; b=VcGX3DhYTzHQ5ja/BrQU5hV5LsOCgHGEkWkAm7AxL6YlDP/4EAOo6P109rYGeYO9TD5gB2/j95rGIfIcz7JB3YS27FP/MVlgJ6AnYEjTfiBz9WklBpyQONPjtODfltVKQYLnwG8RabRI1LPy7NcUL/+VgWdJIAm9zCSKQ5VpdAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767819259; c=relaxed/simple;
	bh=NBQ9TY3kF5fw/EoSTz/33J3iAwOL5DU0ElmmRDR60Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWCxKMV1ILJD32UvVh33Fs7qrgfWuiBQ30+CWOmfqlq66SHIR3bm8DvhHmCwRamBzJ575wJiRmKL0tNw4pwL8krE6x+Lfn+myHZeq3QiK3qTxoA+5K27z9SlvqzKR0Az7hagjw82JrTCgdo1jJnY6LDjhJNNMvb8c6rsOfFqSOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=mail.selcloud.ru; dkim=pass (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b=UcfMCxJa; dkim=pass (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=wFKkpf5l; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=odLQckj4; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=nSe0+eEL; arc=none smtp.client-ip=5.8.75.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.selcloud.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mail.selcloud.ru; s=selcloud; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:List-id:
	List-Unsubscribe:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Help:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TjQ4wYNafNpSTegf9S2wuJejqmu04xdA+i2KKIYcbIs=; t=1767819255; x=1767992055;
	 b=UcfMCxJaL4JQUwbeak0qOxZHBacDgNILyGGFQvmRhTTyZIFpco8xZvvWy3mdi2Df/XN45C/7KD
	q3Qut6krFBlIhFY6svu79CbInIsckftqngIdz3RK+Hm4CobCUM3kWRS5b8vS952i4LMYNJcLh7fR8
	b4p6pOTyygGDCWkeLjTo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=foxido.dev;
	 s=selcloud; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:List-id:List-Unsubscribe:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=TjQ4wYNafNpSTegf9S2wuJejqmu04xdA+i2KKIYcbIs=; t=1767819255; x=1767992055;
	 b=wFKkpf5lPLBMfHtWQClle0XB8W36+LZ1+izC1x7gVSZrU2rEZB1zmt9TzFhNSl11QppFMiHbhj
	o34nEljSMOBOfqXS11RJaQ3GFKXprHKyA5GDNaVpUUuSV7X2qNr7vAE7bDPh20rzmr7Gf5HUkoZrB
	RutjRo3qauyvK1Jpl3Dg=;
Precedence: bulk
X-Issuen: 1539712
X-User: 335779833
X-Postmaster-Msgtype: 3849
Feedback-ID: 1539712:15965:3849:samotpravil
X-From: foxido.dev
X-from-id: 15965
X-MSG-TYPE: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
X-blist-id: 3849
X-Gungo: 20251225.193711
X-SMTPUID: mlgnr59
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1767818172; bh=TjQ4wYNafNpSTegf9S2wuJe
	jqmu04xdA+i2KKIYcbIs=; b=odLQckj4ln9aeeX97359WlXyUG28rAxphOIrhkudIp9G/dZU7/
	mcrrkSwbG9FL/TdZ7hYbK1ZeVGsQywboY6MIaxJtROvmMDSqBo/2TDjZ8mHkGQU1FOqjwMgGK9E
	cpt76zL5cx7WpLTTbXR+ftm3Xni8yXuv4X+HnlFXgLVZx9zYg//krXeGXQf5PMoVH4BaTJaiDFD
	9yuVtU1ArYl1E1ARRY4y8Uy71btKbqbHLMnNcw211YSLoXfn4j9EJzi2fnYdVSQyorPVL90dOXq
	Ii18qRyVDFzDI45GHeaR/FyMmqOISMVi62gBkiw/Bk11EwdIjmC13XsTB/sdRyU9Ofg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1767818172; bh=TjQ4wYNafNpSTegf9S2wuJe
	jqmu04xdA+i2KKIYcbIs=; b=nSe0+eELZAvN+dBtuiuucjIjP5RaguJKHmetisl2CodO0a9EuG
	T3+r8fAmpWNjfqxrCkPGE++SYz1JGKfj2LBQ==;
From: Gladyshev Ilya <foxido@foxido.dev>
To: "foxido @ foxido . dev-cc= Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Tamir Duberstein <tamird@gmail.com>,
	Armin Wolf <W_Armin@gmx.de>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Gladyshev Ilya <foxido@foxido.dev>
Subject: [PATCH 3/3] rust: add WMI abstractions
Date: Wed,  7 Jan 2026 23:35:33 +0300
Message-ID: <a119094f2e248587c541daf7c5b65bf4398b281b.1767818037.git.foxido@foxido.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1767818037.git.foxido@foxido.dev>
References: <cover.1767818037.git.foxido@foxido.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This introduces Rust abstraction for WMI subsystem via wmi::Driver trait
and module_wmi_driver/wmi_device_table macros. Driver can be probed,
notified on events and removed -- almost everything C-side can do.

This abstraction will be used by subsequent redmi_wmi_rs reference
driver.

Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>
---
 MAINTAINERS                     |   1 +
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/lib.rs              |   2 +
 rust/kernel/wmi.rs              | 277 ++++++++++++++++++++++++++++++++
 4 files changed, 281 insertions(+)
 create mode 100644 rust/kernel/wmi.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 765ad2daa218..4909ae8be6e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -404,6 +404,7 @@ F:	Documentation/driver-api/wmi.rst
 F:	Documentation/wmi/
 F:	drivers/platform/wmi/
 F:	include/uapi/linux/wmi.h
+F:	rust/kernel/wmi.rs
 
 ACRN HYPERVISOR SERVICE MODULE
 M:	Fei Li <fei1.li@intel.com>
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index a067038b4b42..f9671280c6b5 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -85,6 +85,7 @@
 #include <linux/usb.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
+#include <linux/wmi.h>
 #include <linux/xarray.h>
 #include <trace/events/rust_sample.h>
 
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index a6eccdba50b5..29bc2b87a103 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -152,6 +152,8 @@
 pub mod uaccess;
 #[cfg(CONFIG_USB = "y")]
 pub mod usb;
+#[cfg(CONFIG_ACPI_WMI)]
+pub mod wmi;
 pub mod workqueue;
 pub mod xarray;
 
diff --git a/rust/kernel/wmi.rs b/rust/kernel/wmi.rs
new file mode 100644
index 000000000000..a15258365a2e
--- /dev/null
+++ b/rust/kernel/wmi.rs
@@ -0,0 +1,277 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Abstractions for the WMI devices.
+//!
+//! C header: [`include/linux/wmi.h`](srctree/include/linux/wmi.h).
+
+use crate::{
+    acpi::AcpiObject,
+    device,
+    device_id::{
+        RawDeviceId,
+        RawDeviceIdIndex, //
+    },
+    driver,
+    error::{
+        from_result,
+        to_result,
+        VTABLE_DEFAULT_ERROR, //
+    },
+    prelude::*,
+    types::Opaque, //
+};
+use core::{marker::PhantomData, mem::MaybeUninit, ptr::NonNull};
+use macros::vtable;
+
+/// [`IdTable`](kernel::device_id::IdTable) type for WMI.
+pub type IdTable<T> = &'static dyn kernel::device_id::IdTable<DeviceId, T>;
+
+/// The WMI driver trait.
+#[vtable]
+pub trait Driver: Send {
+    /// The type holding information about each one of the device ids supported by the driver.
+    type IdInfo: 'static;
+
+    /// The table of device ids supported by the driver.
+    const TABLE: IdTable<Self::IdInfo>;
+
+    /// WMI driver probe.
+    ///
+    /// Called when a new WMI device is bound to this driver.
+    /// Implementers should attempt to initialize the driver here.
+    fn probe(dev: &Device<device::Core>, id_info: &Self::IdInfo) -> impl PinInit<Self, Error>;
+
+    /// WMI device notify.
+    ///
+    /// Called when new WMI event received from bounded device.
+    fn notify(self: Pin<&Self>, _dev: &Device<device::Core>, _event: Option<&AcpiObject>) {
+        build_error!(VTABLE_DEFAULT_ERROR);
+    }
+
+    /// WMI driver remove.
+    fn unbind(self: Pin<&Self>, _dev: &Device<device::Core>) {
+        build_error!(VTABLE_DEFAULT_ERROR);
+    }
+}
+
+/// A WMI device.
+///
+/// This structure represents the Rust abstraction for a C [`struct wmi_device`].
+/// The implementation abstracts the usage of a C [`struct wmi_device`] passed
+/// in from the C side.
+pub struct Device<Cxt: device::DeviceContext = device::Normal> {
+    inner: Opaque<bindings::wmi_device>,
+    _p: PhantomData<Cxt>,
+}
+
+impl<Cxt: device::DeviceContext> Device<Cxt> {
+    fn as_raw(&self) -> *mut bindings::wmi_device {
+        self.inner.get()
+    }
+}
+
+/// An adapter for the registration of WMI drivers.
+pub struct Adapter<T: Driver>(T);
+
+// SAFETY: A call to `unregister` for a given instance of `RegType` is guaranteed to be valid if
+// a preceding call to `register` has been successful.
+unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
+    type RegType = bindings::wmi_driver;
+
+    unsafe fn register(
+        wdrv: &Opaque<Self::RegType>,
+        name: &'static CStr,
+        module: &'static ThisModule,
+    ) -> Result {
+        macro_rules! map_callback {
+            ($flag:ident -> $callback:ident) => {
+                if T::$flag {
+                    Some(Self::$callback)
+                } else {
+                    None
+                }
+            };
+        }
+
+        // SAFETY: It's safe to set the fields of `struct wmi_driver` on initialization.
+        unsafe {
+            (*wdrv.get()).driver.name = name.as_char_ptr();
+            (*wdrv.get()).driver.probe_type = bindings::probe_type_PROBE_PREFER_ASYNCHRONOUS;
+            (*wdrv.get()).id_table = T::TABLE.as_ptr();
+            (*wdrv.get()).probe = map_callback!(HAS_PROBE -> probe_callback);
+            (*wdrv.get()).notify = map_callback!(HAS_NOTIFY -> notify_callback);
+            (*wdrv.get()).remove = map_callback!(HAS_UNBIND -> remove_callback);
+            (*wdrv.get()).shutdown = None;
+            (*wdrv.get()).no_singleton = true;
+            (*wdrv.get()).no_notify_data = true;
+        }
+
+        // SAFETY: `wdrv` is guaranteed to be a valid `RegType`.
+        to_result(unsafe { bindings::__wmi_driver_register(wdrv.get(), module.0) })
+    }
+
+    unsafe fn unregister(wdrv: &Opaque<Self::RegType>) {
+        // SAFETY: `wdrv` is guaranteed to be a valid `RegType`.
+        unsafe { bindings::wmi_driver_unregister(wdrv.get()) };
+    }
+}
+
+impl<T: Driver + 'static> Adapter<T> {
+    extern "C" fn probe_callback(
+        wdev: *mut bindings::wmi_device,
+        id: *const c_void,
+    ) -> kernel::ffi::c_int {
+        // SAFETY: The WMI core only ever calls the probe callback with a valid pointer to a
+        // `struct wmi_device`.
+        //
+        // INVARIANT: `wdev` is valid for the duration of `probe_callback()`.
+        let wdev = unsafe { &*wdev.cast::<Device<device::CoreInternal>>() };
+
+        let id = id as usize;
+        let info = T::TABLE.info(id);
+
+        from_result(|| {
+            let data = T::probe(wdev, info);
+
+            wdev.as_ref().set_drvdata(data)?;
+            Ok(0)
+        })
+    }
+
+    extern "C" fn notify_callback(
+        wdev: *mut bindings::wmi_device,
+        obj: *mut bindings::acpi_object,
+    ) {
+        // SAFETY: The WMI system only ever calls the notify callback with a valid pointer to a
+        // `struct wmi_device`.
+        let wdev = unsafe { &*wdev.cast::<Device<device::CoreInternal>>() };
+        // SAFETY:
+        // - AcpiObject is repr(transparent) wrapper around FFI object, so it's safe to cast
+        //    raw pointer to reference (in terms of alignment and etc),
+        // - Option<&ref> is guaranteed to have same layout as raw pointer (with NULL representing
+        //    None) by Rust's "nullable pointer optimization".
+        let obj: Option<&AcpiObject> = unsafe { core::mem::transmute(obj as *const AcpiObject) };
+
+        // SAFETY: `notify_callback` is only ever called after a successful call to
+        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
+        // and stored a `T`.
+        let this = unsafe { wdev.as_ref().drvdata_borrow::<T>() };
+        this.notify(wdev, obj);
+    }
+
+    extern "C" fn remove_callback(wdev: *mut bindings::wmi_device) {
+        // SAFETY: The WMI system only ever calls the remove callback with a valid pointer to a
+        // `struct wmi_device`.
+        let wdev = unsafe { &*wdev.cast::<Device<device::CoreInternal>>() };
+
+        // SAFETY: `remove_callback` is only ever called after a successful call to
+        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
+        // and stored a `T`.
+        let this = unsafe { wdev.as_ref().drvdata_borrow::<T>() };
+        this.unbind(wdev);
+    }
+}
+
+impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device<Ctx> {
+    fn as_ref(&self) -> &device::Device<Ctx> {
+        // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a pointer to a valid
+        // `struct platform_device`.
+        let dev = unsafe { &raw mut (*self.inner.get()).dev };
+
+        // SAFETY: `dev` points to a valid `struct device`.
+        unsafe { device::Device::from_raw(dev) }
+    }
+}
+
+kernel::impl_device_context_deref!(unsafe { Device });
+kernel::impl_device_context_into_aref!(Device);
+
+// SAFETY: Instances of `Device` are always reference-counted.
+unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
+        unsafe { bindings::get_device(self.as_ref().as_raw()) };
+    }
+
+    unsafe fn dec_ref(obj: NonNull<Self>) {
+        // SAFETY: The safety requirements guarantee that the refcount is non-zero.
+        unsafe { bindings::put_device(&raw mut (*obj.as_ref().as_raw()).dev) }
+    }
+}
+
+/// Abstraction for the WMI device ID structure, i.e. [`struct wmi_device_id`].
+///
+/// [`struct wmi_device_id`]: https://docs.kernel.org/driver-api/basics.html#c.wmi_device_id
+#[repr(transparent)]
+pub struct DeviceId(bindings::wmi_device_id);
+
+impl DeviceId {
+    /// Constructs new DeviceId from GUID string.
+    pub const fn new(guid: &[u8; bindings::UUID_STRING_LEN as usize]) -> Self {
+        // SAFETY: FFI type is valid to be zero-initialized.
+        let mut inner: bindings::wmi_device_id = unsafe { MaybeUninit::zeroed().assume_init() };
+
+        build_assert!(inner.guid_string.len() == bindings::UUID_STRING_LEN as usize + 1);
+
+        // SAFETY: It's safe to copy UUID_STRING_LEN, because we validated lengths.
+        // Also we leave last byte zeroed, so guid_string is valid C string.
+        unsafe {
+            ::core::ptr::copy_nonoverlapping(
+                guid.as_ptr(),
+                &raw mut inner.guid_string[0],
+                bindings::UUID_STRING_LEN as usize,
+            );
+        }
+
+        Self(inner)
+    }
+}
+
+// SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `wmi_device_id` and does not add
+// additional invariants, so it's safe to transmute to `RawType`.
+unsafe impl RawDeviceId for DeviceId {
+    type RawType = bindings::wmi_device_id;
+}
+
+// SAFETY: `DRIVER_DATA_OFFSET` is the offset to the `context` field.
+unsafe impl RawDeviceIdIndex for DeviceId {
+    const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::wmi_device_id, context);
+
+    fn index(&self) -> usize {
+        self.0.context as usize
+    }
+}
+
+/// Declares a kernel module that exposes a single WMI driver.
+///
+/// # Examples
+///
+/// ```ignore
+/// module_wmi_driver! {
+///     type: MyDriver,
+///     name: "Module name",
+///     author: ["Author name"],
+///     description: "Description",
+///     license: "GPL v2",
+/// }
+/// ```
+#[macro_export]
+macro_rules! module_wmi_driver {
+    ($($f:tt)*) => {
+        $crate::module_driver!(<T>, $crate::wmi::Adapter<T>, { $($f)* });
+    }
+}
+
+/// Create a WMI `IdTable` with its alias for modpost.
+#[macro_export]
+macro_rules! wmi_device_table {
+    ($table_name:ident, $module_table_name:ident, $id_info_type: ty, $table_data: expr) => {
+        const $table_name: $crate::device_id::IdArray<
+            $crate::wmi::DeviceId,
+            $id_info_type,
+            { $table_data.len() },
+        > = $crate::device_id::IdArray::new($table_data);
+
+        $crate::module_device_table!("wmi", $module_table_name, $table_name);
+    };
+}
-- 
2.52.0


