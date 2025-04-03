Return-Path: <linux-acpi+bounces-12701-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 484D8A7A862
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 19:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99ED31893AC5
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 17:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739912505BC;
	Thu,  3 Apr 2025 17:04:55 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5630019ABD4;
	Thu,  3 Apr 2025 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743699895; cv=none; b=VQFVr0yRAMpKgiC31EoYdmaufH4g8MGG0FkLjV1WEjr1QYbItuJyTo0VAtNcZv6dbo3J/P/uz8SQycyyIhdEMFS51jXtjmp73KkP0Yr4xIg981jXls/j5R6/8KLLY6V2GivBE9jLcm51/PWWRJLGrPlg9oRwA4eLog2K4h4Kxpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743699895; c=relaxed/simple;
	bh=yxD2RUGCoUv9KFxeKH+EgZNjLoLeN1AaFgsM7EKHvtE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bUEWgb8SFhd/GtkgTWmyOSihmj6AjKc9iauvRhm9ZuWK63UnTIGVBpbMfTalm0BhmIcoUrBUtcLIR9nmcWrl0i/i6RWhxQ/7d8lDp2zyIP+ziez2JPtEDIv7mhisuMfwAMZq3VxKt3vOy7BXOLXupXe+bieQkwD/FmQ29xn7QVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ZT7Q23hTPz9t47;
	Thu,  3 Apr 2025 19:04:42 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Apr 2025 19:04:38 +0200
Message-Id: <D8X60PODTV0B.2ENFYEXH7EZP0@buenzli.dev>
Cc: "Daniel Scally" <djrscally@gmail.com>, "Heikki Krogerus"
 <heikki.krogerus@linux.intel.com>, "Sakari Ailus"
 <sakari.ailus@linux.intel.com>, "Dirk Behme" <dirk.behme@de.bosch.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>, "Saravana
 Kannan" <saravanak@google.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 03/10] device property: Add
 fwnode_property_read_int_array()
From: "Remo Senekowitsch" <remo@buenzli.dev>
To: "Rob Herring" <robh@kernel.org>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>
References: <20250326171411.590681-1-remo@buenzli.dev>
 <20250326171411.590681-4-remo@buenzli.dev>
 <Z-UPJyD41LOMM3o2@smile.fi.intel.com>
 <D8WA3WIHEQRN.3LQS84K8Z46OW@buenzli.dev>
 <Z-6NG7fSfyKH-vW_@smile.fi.intel.com>
 <CAL_JsqLPZc1LB09auMOJp90hbhJin75Yaa09h12ziZZgExSsBg@mail.gmail.com>
In-Reply-To: <CAL_JsqLPZc1LB09auMOJp90hbhJin75Yaa09h12ziZZgExSsBg@mail.gmail.com>
X-Rspamd-Queue-Id: 4ZT7Q23hTPz9t47

On Thu Apr 3, 2025 at 6:08 PM CEST, Rob Herring wrote:
> On Thu, Apr 3, 2025 at 8:29=E2=80=AFAM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>>
>> On Wed, Apr 02, 2025 at 06:04:13PM +0200, Remo Senekowitsch wrote:
>> > On Thu Mar 27, 2025 at 9:41 AM CET, Andy Shevchenko wrote:
>> > > On Wed, Mar 26, 2025 at 06:13:42PM +0100, Remo Senekowitsch wrote:
>> > >> The rust bindings for reading device properties has a single
>> > >> implementation supporting differing sizes of integers. The fwnode C=
 API
>> > >> already has a similar interface, but it is not exposed with the
>> > >> fwnode_property_ API. Add the fwnode_property_read_int_array() wrap=
per.
>>
>> ...
>>
>> > >> +EXPORT_SYMBOL_GPL(fwnode_property_read_int_array);
>> > >
>> > > I'm not sure about this. We have a lot of assumptions in the code th=
at the
>> > > arrays beneath are only represented by the selected number of intege=
r types.
>> > > This opens a Pandora's box, e.g., reading in u24, which is not suppo=
rted by
>> > > the upper layers..
>> > >
>> > >> +int fwnode_property_read_int_array(const struct fwnode_handle *fwn=
ode, const char *propname,
>> > >> +                             unsigned int elem_size, void *val, si=
ze_t nval);
>> >
>> > Here's an alternative approach using a macro to map each integer type =
explicitly
>> > to its corresponding read function. There are some additional changes =
that will
>> > be necessary to make the rest work, but this is the gist of it.
>>
>> I don;'t know Rust to tell anything about this, but at least it feels mu=
ch
>> better approach.
>
> I know a little Rust and it is much worse. It is implementing the same
> code 8 times instead of 1 time just to work-around the C API.

I prepared a functioning version of the macro-based approach. I'll post
the patch for reference and discussion. We don't have to go with it.

Remo

---
 rust/kernel/property.rs | 124 +++++++++++++++++++++++++---------------
 1 file changed, 77 insertions(+), 47 deletions(-)

diff --git a/rust/kernel/property.rs b/rust/kernel/property.rs
index ceedd1a82..78dcc189e 100644
--- a/rust/kernel/property.rs
+++ b/rust/kernel/property.rs
@@ -4,7 +4,7 @@
 //!
 //! C header: [`include/linux/property.h`](srctree/include/linux/property.=
h)
=20
-use core::{ffi::c_void, mem::MaybeUninit, ptr};
+use core::{mem::MaybeUninit, ptr};
=20
 use crate::{
     alloc::KVec,
@@ -13,7 +13,7 @@
     error::{to_result, Result},
     prelude::*,
     str::{CStr, CString},
-    types::{ARef, Integer, Opaque},
+    types::{ARef, Opaque},
 };
=20
 impl Device {
@@ -43,7 +43,7 @@ pub fn property_match_string(&self, name: &CStr, match_st=
r: &CStr) -> Result<usi
     }
=20
     /// Returns firmware property `name` integer array values in a KVec
-    pub fn property_read_array_vec<'fwnode, 'name, T: Integer>(
+    pub fn property_read_array_vec<'fwnode, 'name, T: PropertyInt>(
         &'fwnode self,
         name: &'name CStr,
         len: usize,
@@ -52,7 +52,7 @@ pub fn property_read_array_vec<'fwnode, 'name, T: Integer=
>(
     }
=20
     /// Returns integer array length for firmware property `name`
-    pub fn property_count_elem<T: Integer>(&self, name: &CStr) -> Result<u=
size> {
+    pub fn property_count_elem<T: PropertyInt>(&self, name: &CStr) -> Resu=
lt<usize> {
         self.fwnode().property_count_elem::<T>(name)
     }
=20
@@ -148,24 +148,17 @@ pub fn property_match_string(&self, name: &CStr, matc=
h_str: &CStr) -> Result<usi
     }
=20
     /// Returns firmware property `name` integer array values in a KVec
-    pub fn property_read_array_vec<'fwnode, 'name, T: Integer>(
+    pub fn property_read_array_vec<'fwnode, 'name, T: PropertyInt>(
         &'fwnode self,
         name: &'name CStr,
         len: usize,
     ) -> Result<PropertyGuard<'fwnode, 'name, KVec<T>>> {
         let mut val: KVec<T> =3D KVec::with_capacity(len, GFP_KERNEL)?;
=20
-        // SAFETY: `name` is non-null and null-terminated. `self.as_raw` i=
s valid
-        // because `self` is valid. `val.as_ptr` is valid because `val` is=
 valid.
-        let err =3D unsafe {
-            bindings::fwnode_property_read_int_array(
-                self.as_raw(),
-                name.as_char_ptr(),
-                T::SIZE as u32,
-                val.as_ptr() as *mut c_void,
-                len,
-            )
-        };
+        // SAFETY: `val.as_mut_ptr()` is valid because `KVec::with_capacit=
y`
+        // didn't return an error and it has at least space for `len` numb=
er
+        // of elements.
+        let err =3D unsafe { T::read_array_out_param(self, name, val.as_mu=
t_ptr(), len) };
         let res =3D if err < 0 {
             Err(Error::from_errno(err))
         } else {
@@ -181,19 +174,11 @@ pub fn property_read_array_vec<'fwnode, 'name, T: Int=
eger>(
     }
=20
     /// Returns integer array length for firmware property `name`
-    pub fn property_count_elem<T: Integer>(&self, name: &CStr) -> Result<u=
size> {
+    pub fn property_count_elem<T: PropertyInt>(&self, name: &CStr) -> Resu=
lt<usize> {
         // SAFETY: `name` is non-null and null-terminated. `self.as_raw` i=
s valid
         // because `self` is valid. Passing null pointer buffer is valid t=
o obtain
         // the number of elements in the property array.
-        let ret =3D unsafe {
-            bindings::fwnode_property_read_int_array(
-                self.as_raw(),
-                name.as_char_ptr(),
-                T::SIZE as u32,
-                ptr::null_mut(),
-                0,
-            )
-        };
+        let ret =3D unsafe { T::read_array_out_param(self, name, ptr::null=
_mut(), 0) };
         to_result(ret)?;
         Ok(ret as usize)
     }
@@ -201,8 +186,8 @@ pub fn property_count_elem<T: Integer>(&self, name: &CS=
tr) -> Result<usize> {
     /// Returns the value of firmware property `name`.
     ///
     /// This method is generic over the type of value to read. Informally,
-    /// the types that can be read are booleans, strings, integers and arr=
ays
-    /// of integers.
+    /// the types that can be read are booleans, strings, unsigned integer=
s and
+    /// arrays of unsigned integers.
     ///
     /// Reading a `KVec` of integers is done with the
     /// separate method [Self::property_read_array_vec], because it takes =
an
@@ -300,6 +285,9 @@ pub fn property_get_reference_args(
             NArgs::N(nargs) =3D> (ptr::null(), nargs),
         };
=20
+        // SAFETY: `self.0.get()` is valid. `prop.as_char_ptr()` is valid =
and
+        // zero-terminated. `nargs_prop` is valid and zero-terminated if `=
nargs`
+        // is zero, otherwise it is allowed to be a null-pointer.
         let ret =3D unsafe {
             bindings::fwnode_property_get_reference_args(
                 self.0.get(),
@@ -388,34 +376,76 @@ fn read(fwnode: &FwNode, name: &CStr) -> Result<Self>=
 {
         Ok(str.try_into()?)
     }
 }
-impl<T: Integer, const N: usize> Property for [T; N] {
+/// Implemented for all integers that can be read as properties.
+///
+/// This helper trait is needed to associate the integer types of various =
sizes
+/// with their corresponding `fwnode_property_read_*_array` functions.
+pub trait PropertyInt: Property {
+    /// # Safety
+    ///
+    /// Callers must ensure that if `len` is non-zero, `out_param` must be
+    /// valid and point to memory that has enough space to hold at least `=
len`
+    /// number of elements.
+    unsafe fn read_array_out_param(
+        fwnode: &FwNode,
+        name: &CStr,
+        out_param: *mut Self,
+        len: usize,
+    ) -> ffi::c_int;
+}
+// This macro generates implementations of the traits `Property` and
+// `PropertyInt` for integers of various sizes. Its input is a list
+// of pairs separated by commas. The first element of the pair is the
+// type of the integer, the second one is the name of its corresponding
+// `fwnode_property_read_*_array` function.
+macro_rules! impl_property_for_int {
+    ($($int:ty: $f:ident),* $(,)?) =3D> { $(
+        impl Property for $int {
+            fn read(fwnode: &FwNode, name: &CStr) -> Result<Self> {
+                let val: [_; 1] =3D <[$int; 1] as Property>::read(fwnode, =
name)?;
+                Ok(val[0])
+            }
+        }
+        impl PropertyInt for $int {
+            unsafe fn read_array_out_param(
+                fwnode: &FwNode,
+                name: &CStr,
+                out_param: *mut Self,
+                len: usize,
+            ) -> ffi::c_int {
+                // SAFETY: `name` is non-null and null-terminated.
+                // `fwnode.as_raw` is valid because `fwnode` is valid.
+                // `out_param` is valid and has enough space for at least
+                // `len` number of elements as per the safety requirement.
+                unsafe {
+                    bindings::$f(fwnode.as_raw(), name.as_char_ptr(), out_=
param, len)
+                }
+            }
+        }
+    )* };
+}
+impl_property_for_int! {
+    u8: fwnode_property_read_u8_array,
+    u16: fwnode_property_read_u16_array,
+    u32: fwnode_property_read_u32_array,
+    u64: fwnode_property_read_u64_array,
+}
+impl<T: PropertyInt, const N: usize> Property for [T; N] {
     fn read(fwnode: &FwNode, name: &CStr) -> Result<Self> {
         let mut val: [MaybeUninit<T>; N] =3D [const { MaybeUninit::uninit(=
) }; N];
=20
-        // SAFETY: `name` is non-null and null-terminated. `fwnode.as_raw`=
 is valid
-        // because `fwnode` is valid. `val.as_ptr` is valid because `val` =
is valid.
-        let ret =3D unsafe {
-            bindings::fwnode_property_read_int_array(
-                fwnode.as_raw(),
-                name.as_char_ptr(),
-                T::SIZE as u32,
-                val.as_mut_ptr().cast(),
-                val.len(),
-            )
-        };
+        // SAFETY: `name` is non-null and null-terminated. `fwnode.as_raw`=
 is
+        // valid because `fwnode` is valid. `val.as_ptr` is valid because =
`val`
+        // is valid. Casting from `*mut MaybeUninit<T>` to `*mut T` is saf=
e
+        // because `MaybeUninit<T>` has the same memory layout as `T`.
+        let ret =3D unsafe { T::read_array_out_param(fwnode, name, val.as_=
mut_ptr().cast(), N) };
         to_result(ret)?;
=20
         // SAFETY: `val` is always initialized when
-        // fwnode_property_read_int_array is successful.
+        // fwnode_property_read_$t_array is successful.
         Ok(val.map(|v| unsafe { v.assume_init() }))
     }
 }
-impl<T: Integer> Property for T {
-    fn read(fwnode: &FwNode, name: &CStr) -> Result<T> {
-        let val: [_; 1] =3D <[T; 1] as Property>::read(fwnode, name)?;
-        Ok(val[0])
-    }
-}
=20
 /// The number of arguments of a reference.
 pub enum NArgs<'a> {
--=20
2.49.0


