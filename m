Return-Path: <linux-acpi+bounces-19739-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0AECD43E4
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Dec 2025 19:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 516CC300BA3F
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Dec 2025 18:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF51306B1B;
	Sun, 21 Dec 2025 18:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="CRoEAOKV";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="l35fgg/Y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from m.foxido.dev (m.foxido.dev [81.177.217.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3BE306480;
	Sun, 21 Dec 2025 18:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.177.217.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766341491; cv=none; b=gMEjbGDQeRXJ/tSc1hP2AIsFGZCUA1M7amtBngXAUA1d4yZPz4msQUqCw6fUo8aeHc+qfAZF8vEP/QPuWsWcBUviZmSPLk4i3ey4s4B/IrO2qRVCdLJS7SOiQnLwNwGjcN3Hlar2v2rh2R31k9wJFfKxltQ5VjN61I5CY87igUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766341491; c=relaxed/simple;
	bh=vqYgEcj4VTwKmN9jtOddNnmKyLqJT/1kumllqrp4OsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BIoghJ/WitU+FS9q/WjnJ3xtfmgHOW2ny5qHx5wUMVKEKpHkW9DW5b0PvDmSG4DYwTYLaYq8+dE0l1EVyz2bmxz+VadL36QITKKbwRt6Xi/bHeokuvCiLeV7/2aupUGFAcPP7NiydAWVV7f7uDHo/adFdPkYAR8opXm0o31tqPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=foxido.dev; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=CRoEAOKV; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=l35fgg/Y; arc=none smtp.client-ip=81.177.217.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxido.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1766341460; bh=Dc26qUoCL/ggkq/m7pPFrGF
	gqMygx6Q43yo2ozhm04w=; b=CRoEAOKV6GK7rWlUjTZ1u7/4G1/f/dznkOT4fKPE9cjZkFwNtf
	P0HeFZ/xMWLVgFEW1viRc72AlxarSLati3nZdVaMmn1ST4jIHBjeQ4Yd6l2ybhcrjx/gleo/PDV
	kDodHAhlicJzpRTsF5cwzzWrpcQjIduiDRrwcdoMPmJUb31jSmkIgDA/4SGrj1HHpfeFU2M2jFx
	5eA2oatUGZZN1IPXHmq91Ar0O+dDJuVDcaWfuroQod+MISr5eNVaEtPP1/HKQezwKi1z21nx0Ox
	sMknyvTDib8oC9pavZj0jI9lsMJ6DJ7cYSWPBA7E7b6MFnMwWEc+ZufUb/7EroTEEzQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1766341460; bh=Dc26qUoCL/ggkq/m7pPFrGF
	gqMygx6Q43yo2ozhm04w=; b=l35fgg/Y+wE42FxsjjVpF942oO+b2kdm9f/LSlMn09w4TsZJ4b
	3TuR1QxDMQwQSFGBkJP67a2fCC4aZmz0SOAw==;
From: Gladyshev Ilya <foxido@foxido.dev>
To: "foxido @ foxido . dev-cc= Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
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
Subject: [RFC PATCH 2/3] rust: introduce WMI abstractions
Date: Sun, 21 Dec 2025 21:22:38 +0300
Message-ID: <cc4a2e7e9fd5f07f8a0831ca085e489f0ae87d1f.1766331321.git.foxido@foxido.dev>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <cover.1766331321.git.foxido@foxido.dev>
References: <cover.1766331321.git.foxido@foxido.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the basic WMI subsystem abstractions required to write a
WMI device driver with or without the need for initial device data.
This includes the following data structures:

The `wmi::Driver` trait represents the interface to the driver.

The `wmi::Device` abstraction represents a `struct wmi_device`.

In order to provide the WMI specific parts to a generic
`driver::Registration` the `driver::RegistrationOps` trait is
implemented by `wmi::Adapter`.

Everything from C side is supported, except shutdown action

Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/lib.rs              |   2 +
 rust/kernel/wmi.rs              | 267 ++++++++++++++++++++++++++++++++
 3 files changed, 270 insertions(+)
 create mode 100644 rust/kernel/wmi.rs

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
index f812cf120042..db3e649d26eb 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -151,6 +151,8 @@
 pub mod uaccess;
 #[cfg(CONFIG_USB = "y")]
 pub mod usb;
+#[cfg(CONFIG_ACPI_WMI)]
+pub mod wmi;
 pub mod workqueue;
 pub mod xarray;
 
diff --git a/rust/kernel/wmi.rs b/rust/kernel/wmi.rs
new file mode 100644
index 000000000000..018e88d01e8c
--- /dev/null
+++ b/rust/kernel/wmi.rs
@@ -0,0 +1,267 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Abstractions for the WMI devices.
+//!
+//! C header: [`include/linux/wmi.h`](srctree/include/linux/wmi.h)
+
+use crate::{
+    acpi::AcpiObject,
+    device,
+    device_id::{RawDeviceId, RawDeviceIdIndex},
+    driver,
+    error::{from_result, to_result, VTABLE_DEFAULT_ERROR},
+    prelude::*,
+    types::Opaque,
+};
+use core::{
+    marker::PhantomData,
+    mem::MaybeUninit,
+    ptr::{addr_of_mut, NonNull},
+};
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
+    /// Called when new WMI event received from bounded device
+    fn notify(&self, _dev: &Device<device::Core>, _event: &AcpiObject) {
+        build_error!(VTABLE_DEFAULT_ERROR);
+    }
+
+    /// WMI driver remove.
+    fn remove(self: Pin<KBox<Self>>, _dev: &Device<device::Core>) {
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
+            (*wdrv.get()).remove = map_callback!(HAS_REMOVE -> remove_callback);
+            (*wdrv.get()).shutdown = None;
+            (*wdrv.get()).no_singleton = true;
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
+        // SAFETY: AcpiObject is repr(transparent) wrapper
+        let obj: &AcpiObject = unsafe { &*(obj as *const AcpiObject) };
+
+        // SAFETY: `notify_callback` is only ever called after a successful call to
+        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
+        // and stored a `T`.
+        let this: &T = unsafe { &wdev.as_ref().drvdata_borrow::<T>() };
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
+        let this = unsafe { wdev.as_ref().drvdata_obtain::<T>() };
+        this.remove(wdev);
+    }
+}
+
+impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device<Ctx> {
+    fn as_ref(&self) -> &device::Device<Ctx> {
+        // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a pointer to a valid
+        // `struct platform_device`.
+        let dev = unsafe { addr_of_mut!((*self.inner.get()).dev) };
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
+#[repr(transparent)]
+pub struct DeviceId(bindings::wmi_device_id);
+
+impl DeviceId {
+    /// Constructs new DeviceId from GUID string
+    pub const fn new(guid: &[u8; bindings::UUID_STRING_LEN as usize]) -> Self {
+        // SAFETY: FFI type is valid to be zero-initialized.
+        let mut inner: bindings::wmi_device_id = unsafe { MaybeUninit::zeroed().assume_init() };
+
+        build_assert!(inner.guid_string.len() == bindings::UUID_STRING_LEN as usize + 1);
+
+        // SAFETY: It's safe to copy UUID_STRING_LEN, because we validated lengths
+        // Also we leave last byte zeroed -> guid_string is valid C string
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
2.51.1.dirty


