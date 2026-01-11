Return-Path: <linux-acpi+bounces-20157-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 915FBD0F947
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Jan 2026 19:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2551430505A8
	for <lists+linux-acpi@lfdr.de>; Sun, 11 Jan 2026 18:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D8234FF50;
	Sun, 11 Jan 2026 18:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="Xj5E5wc8";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="2HINTMLu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from m.foxido.dev (m.foxido.dev [81.177.217.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C559121FF4C;
	Sun, 11 Jan 2026 18:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.177.217.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768156330; cv=none; b=sEWJ3zru+vZJ6Rr3YkkCyXWaxud5mc4p31DYdljwDDxR5nHm5qaGcKkiHyVm2Jm3CIqHSRNVzDuFbQXHGMpjG7KkH6y+U5XFWNc7LQjCgDpR+FetrqAog+QHCtv8jHxO+69nX++dDfJAn4W/5ePYFI2n38RGeqFiTAIcNN+Tq3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768156330; c=relaxed/simple;
	bh=WbhC6EFKKjuMv1cPLZkF+zvOg/8ttTQTKXQQP4Mr0/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rq/twpAoVM1K9WFx/s+USYz8VXghn0ZC6pqwc3FaUNvgIROfHHHkShFQpS0SyqOIdqDSsGZyFiAhNhuwjtRQP2Ijh2oHPFf71m2PYDIeOHdnCXCRy8oGKoke/sTjtrvp4Duj0d5w8oVVQ9cb0Mu52ajsdxfrddI5mjDZQbYw/RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=foxido.dev; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=Xj5E5wc8; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=2HINTMLu; arc=none smtp.client-ip=81.177.217.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxido.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1768156307; bh=Js3PfRacKkqfBS9WvlN8eaq
	gmgTyO3HuuIh10PvNMrM=; b=Xj5E5wc8KHDopmt8wdh6Yeomvtd7g1vbYtjPuIf+7OkgYEER2M
	4kWQ1+9YThNiCtohSAexF6PqzqMX3yzmHmndoeKYMvIWQR1tRHqAQLQsIXtiHbNQrIi2GuRSeNr
	H4IiOXafIVLEK+Lb4Rxriqqlk7ELMD4EyhLPCExSR+9uF2QVXUx4uCYmALhF4yZ/ODxFyIBNmgu
	DIZKnfh8YQVSaEK8V8pmwEZveqvkOQPPt6OAPFZSyuVaCy8coY1TGWSXVwTjcm3sZHWiHZSdCLn
	7WM13GL5LbXOJsL4xNy3GV39kvFsQ3B8F77cZnaIS69uU1S2fDix7MVhKtAPZLmJFBw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1768156307; bh=Js3PfRacKkqfBS9WvlN8eaq
	gmgTyO3HuuIh10PvNMrM=; b=2HINTMLuAsgZMOaOrmGMPxQebpuwUam8CrzoOqNPLaVadyWlRv
	n93jszgfvom/fpf0BU28DZfdbzdfsUQ+yGCw==;
From: Gladyshev Ilya <foxido@foxido.dev>
To: foxido@foxido.dev
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
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
	linux-acpi@vger.kernel.org
Subject: [PATCH v2 2/2] rust: add WMI abstractions
Date: Sun, 11 Jan 2026 21:31:26 +0300
Message-ID: <42c8729d79c1264a2100b00d58b3f28a4584e585.1768153572.git.foxido@foxido.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768153572.git.foxido@foxido.dev>
References: <cover.1768153572.git.foxido@foxido.dev>
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
 rust/kernel/wmi.rs              | 286 ++++++++++++++++++++++++++++++++
 4 files changed, 290 insertions(+)
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
index 000000000000..d6b9bc29a4d6
--- /dev/null
+++ b/rust/kernel/wmi.rs
@@ -0,0 +1,286 @@
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
+use core::{
+    marker::PhantomData,
+    ptr::NonNull, //
+};
+use macros::vtable;
+
+/// [`IdTable`](kernel::device_id::IdTable) type for WMI.
+pub type IdTable<T> = &'static dyn kernel::device_id::IdTable<DeviceId, T>;
+
+/// The WMI driver trait.
+///
+/// Driver can be called from arbitary thread without any ordering guarantees.
+#[vtable]
+pub trait Driver: Send + Sync {
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
+    fn notify(self: Pin<&Self>, _dev: &Device<device::Bound>, _event: Option<&AcpiObject<'_>>) {
+        build_error!(VTABLE_DEFAULT_ERROR);
+    }
+
+    /// WMI driver remove.
+    ///
+    /// Called when the WMI driver is unbound from a WMI device.
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
+        to_result(unsafe { bindings::__wmi_driver_register(wdrv.get(), module.as_ptr()) })
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
+        let obj: Option<&AcpiObject<'_>> =
+            unsafe { core::mem::transmute(obj as *const AcpiObject<'_>) };
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
+// SAFETY: `Device` is a transparent wrapper of a type that doesn't depend on `Device`'s generic
+// argument.
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
+    const GUID_LEN: usize = bindings::UUID_STRING_LEN as usize;
+
+    /// Constructs new DeviceId from GUID string.
+    pub const fn new(guid: &[u8; Self::GUID_LEN]) -> Self {
+        let mut inner: bindings::wmi_device_id = pin_init::zeroed();
+
+        build_assert!(inner.guid_string.len() == Self::GUID_LEN + 1);
+
+        // We are copying UUID_STRING_LEN bytes and we verified that UUID_STRING_LEN + 1 byte
+        // exists and will remain '\0'. So we will construct valid C string.
+        let mut i = 0;
+        while i < Self::GUID_LEN {
+            inner.guid_string[i] = guid[i];
+            i += 1;
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


