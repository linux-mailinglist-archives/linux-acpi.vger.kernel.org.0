Return-Path: <linux-acpi+bounces-12655-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A83D1A792A4
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Apr 2025 18:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC691171D95
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Apr 2025 16:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CE617E01B;
	Wed,  2 Apr 2025 16:04:30 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE5538DE9;
	Wed,  2 Apr 2025 16:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743609870; cv=none; b=c9M0vHB9uieAvB/vG18gmsLQwf8G1hSbj4jrWQiigR+KZ6bCboHCbEbk0mUiGAobYARq/vMt4nA4SQYcPSI2nS3j04KDQE0d127EeUpa7pAzYr4r3gIZ+k975GzcJ++qlMTxMnXQtTj3BJPKnG5SexbRgCU75a0k4NvwUcDLDHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743609870; c=relaxed/simple;
	bh=H8RhS+K+2lmf/4O1CUzjViFWSlESvTAkGL1rAkqQEYI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Ues9CrVqbZhCvJjsZFVqTeV4XXPV+cnGvx+k3MXdWZTi7SSL2/C44oRvZ1dpz9ZadDnUhAABfa4Lhl0ALwlmpWwXWFcRi2QJ8l/KoMrfezejsq+RBfRvEOpZKj+eGRGPAt9VXDBZgvv2lqgSaqt14BqRQ1ZZTlcXhlzEeLqDzrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ZSV6q0XTmz9scX;
	Wed,  2 Apr 2025 18:04:19 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 02 Apr 2025 18:04:13 +0200
Message-Id: <D8WA3WIHEQRN.3LQS84K8Z46OW@buenzli.dev>
From: "Remo Senekowitsch" <remo@buenzli.dev>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: "Daniel Scally" <djrscally@gmail.com>, "Heikki Krogerus"
 <heikki.krogerus@linux.intel.com>, "Sakari Ailus"
 <sakari.ailus@linux.intel.com>, "Rob Herring" <robh@kernel.org>, "Dirk
 Behme" <dirk.behme@de.bosch.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>, "Saravana Kannan"
 <saravanak@google.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 03/10] device property: Add
 fwnode_property_read_int_array()
References: <20250326171411.590681-1-remo@buenzli.dev>
 <20250326171411.590681-4-remo@buenzli.dev>
 <Z-UPJyD41LOMM3o2@smile.fi.intel.com>
In-Reply-To: <Z-UPJyD41LOMM3o2@smile.fi.intel.com>
X-Rspamd-Queue-Id: 4ZSV6q0XTmz9scX

On Thu Mar 27, 2025 at 9:41 AM CET, Andy Shevchenko wrote:
> On Wed, Mar 26, 2025 at 06:13:42PM +0100, Remo Senekowitsch wrote:
>> The rust bindings for reading device properties has a single
>> implementation supporting differing sizes of integers. The fwnode C API
>> already has a similar interface, but it is not exposed with the
>> fwnode_property_ API. Add the fwnode_property_read_int_array() wrapper.
>
> ...
>
>> +EXPORT_SYMBOL_GPL(fwnode_property_read_int_array);
>
> I'm not sure about this. We have a lot of assumptions in the code that th=
e
> arrays beneath are only represented by the selected number of integer typ=
es.
> This opens a Pandora's box, e.g., reading in u24, which is not supported =
by
> the upper layers..
>
>> +int fwnode_property_read_int_array(const struct fwnode_handle *fwnode, =
const char *propname,
>> +				   unsigned int elem_size, void *val, size_t nval);

Here's an alternative approach using a macro to map each integer type expli=
citly
to its corresponding read function. There are some additional changes that =
will
be necessary to make the rest work, but this is the gist of it.

+macro_rules! impl_property_for_int {
+    ($($int:ty: $f:ident),* $(,)?) =3D> {
+        $(
+            impl<const N: usize> Property for [$int; N] {
+                fn read(fwnode: &FwNode, name: &CStr) -> Result<Self> {
+                    let mut val: [MaybeUninit<$int>; N] =3D [const { Maybe=
Uninit::uninit() }; N];
+
+                    // SAFETY: `name` is non-null and null-terminated. `fw=
node.as_raw` is valid
+                    // because `fwnode` is valid. `val.as_ptr` is valid be=
cause `val` is valid.
+                    let ret =3D unsafe {
+                        bindings::$f(
+                            fwnode.as_raw(),
+                            name.as_char_ptr(),
+                            val.as_mut_ptr().cast(),
+                            val.len(),
+                        )
+                    };
+                    to_result(ret)?;
+
+                    // SAFETY: `val` is always initialized when
+                    // fwnode_property_read_$t_array is successful.
+                    Ok(val.map(|v| unsafe { v.assume_init() }))
+                }
+            }
+            impl Property for $int {
+                fn read(fwnode: &FwNode, name: &CStr) -> Result<Self> {
+                    let val: [_; 1] =3D <[$int; 1] as Property>::read(fwno=
de, name)?;
+                    Ok(val[0])
+                }
+            }
+        )*
+    };
+}
+impl_property_for_int! {
+    u8: fwnode_property_read_u8_array,
+    u16: fwnode_property_read_u16_array,
+    u32: fwnode_property_read_u32_array,
+    u64: fwnode_property_read_u64_array,
+    i8: fwnode_property_read_u8_array,
+    i16: fwnode_property_read_u16_array,
+    i32: fwnode_property_read_u32_array,
+    i64: fwnode_property_read_u64_array,
+}

