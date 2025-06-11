Return-Path: <linux-acpi+bounces-14283-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C081AD5D65
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Jun 2025 19:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 093671BC0907
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Jun 2025 17:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7E82080E8;
	Wed, 11 Jun 2025 17:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bA91tdkU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB9D273FE;
	Wed, 11 Jun 2025 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749663973; cv=none; b=QGIW8FbJNhSx/z/CQWIMefjJt9O79mGAVL7BbLXwCS2GfQjZQlcv6qTQ9SqJPiEGJvLlvcE3rFVORymNehpNKuABca4iYjZ9bNgBHLXfVWHMEj1gomQ2O6agO50aLLQ1BpUGZnDK0QXPzdQbcSSku1AfH2oQxzJath03Pc3pTyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749663973; c=relaxed/simple;
	bh=fLM1J7jVqqiZf/ld7d1JFGfRWVz+teNjK6y084/tbPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OYsA/VFh8BKNQ16b0t7aKBjEOcQtJJoh0Kkt5UDlxfcY/v+UZdp70vqzabysSFoPOQ5fQWEFofz9xHnMWCtH6VtV7LSG5Ntv4J/Kw2Ubgyd7oX1/wa5mjJBH/CjsmAnAjtBVlv7jsbXnuRQPx8kY0O9Uqkn8jtyuEXocspXnGeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bA91tdkU; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so108744f8f.1;
        Wed, 11 Jun 2025 10:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749663969; x=1750268769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oudxA8JPC06HRjXurKEPIdr/6i2EGFIADSPFZLQo5s0=;
        b=bA91tdkU6onYX4fGazm4pYNEIDNPDZeV8Hnu4LfKRYgEUhIPawNFtdIDjZXdnNWmHL
         f6sc2EryXEetjIUwNeB/9x++MsB8X6icP+Ccd+qMX35AjoGqevR7pqD5apKDW/slNmOI
         MYsidSqyEm7T54h+H/y1oWID2iH0S3Lizl04drsMpEqWtNPLWHXEFndeDvF0IrALbM6l
         A3uHDyr3PVSC4at3KWE9xHvAxTtKpOBmwfFY9AqBZdM7hyPxzB0gzzE9FRrZpVmJbZlA
         q4P2NF/VN4OHzRNCNOkiD6LIDPI/57XxJ6jiKJB4coU7JiAhlh7wr9qtZ8huYhL6+IE9
         Pt8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749663969; x=1750268769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oudxA8JPC06HRjXurKEPIdr/6i2EGFIADSPFZLQo5s0=;
        b=UBrWEq3y2UnDy0M2K3nDRNRNyPm0JK2vEuZALkxxN2h3UnxOZYGDLpl0oz4TdWq0Kz
         IrS9G+zEJ2qxbbALUlPlF99ZF4KGQAw7NohueOKf9IOobTv4y6iYW5eDHmHdjUR73JKR
         Nw5FK5POGTXgrEGSLtZOKXaDWA6/+OX+QBaLoGu2/zP/12pEdx53+DHFV6mc8ULZ5oCT
         kN6plaaTr8YKTtmUeYvAjlG8L10R4NiycUy9CT4aLk13XM3hdX1IXSNGbUkQQUeHWVIM
         1QMjZewIli5t42qf8zSCjSnSsIpqEwFfUMO0J/GD4tIUARvdmatYOcMo2DM0BaMtsXv3
         2+dA==
X-Forwarded-Encrypted: i=1; AJvYcCVf3YIFUMw5fW1FqKnuKbxEAs7JdMJ703n8AKYYCKLXNdM11W8aUx3WnFzq3HTHlW59LRhTaEL3DTSEgCFEss8=@vger.kernel.org, AJvYcCW1oEXQqazk2IRZUb8brOy4rpjk3T45PokPbyJjDvblon0ONITtfLillmVQ6YR4PqgJA0I116b46Bys@vger.kernel.org, AJvYcCX32+w9OShHlCKG4pxm8AhA1PgjnTXX3oCs8dGVqHCFD+E/95+KBi4VQ/q51ARFVYgJJ3V2SUBeUKWQZNZc@vger.kernel.org
X-Gm-Message-State: AOJu0YyMoxXMZ8JBNmHOz8l3ZILB5lT6qWIZeGHuHKajm662OnjaWzUF
	PYmm+5DesYli+lbklUBw7Lf+FwE2HOx+gXGCZl2fHVKTanALu9ivlN06
X-Gm-Gg: ASbGnctxsFksvhdip2Nq2B/IVGo+EhanEMIaywSq3oVLRW/tJmVht4KWMK/wqIBbrth
	JjcOn+SPY4jd72ULLDNOUws9F5PD0iR3ZXLka0lfzZbA1fU5u1wP7BxUUVB5N4sp+0bKqbtqJUb
	9344O946z0PLl6zmU2DQshXyLPmh0m2FhlcP9r5QT5CEg7komwD9jRNZ4Ck+R+YhyU3jafwc9/0
	LG7Cp4uUva2J9inZU1Vmv7XlQSKlrLY3E/5I2KmSLAGFWrlm7n7DQ6ft99Lri057N3UGPj6IHd8
	nmX3gNQjmkEoahq8Tbka3OANKNfF6AfPGalqtBML6wloxymRMEYL/fog6AQSVrVAWaoqRYgivg8
	aJrV0w9NbfqwB+Tdg86yIo0qvitDW24yz3IFQ+T89Nx+C/t4=
X-Google-Smtp-Source: AGHT+IGis81OISeR1H6EKCsnDF9D+IMc7DX0AsSIPHEM1aS4aL6icCQI8s3ZReBVHMGuxWp9hN3iTw==
X-Received: by 2002:a05:6000:1785:b0:3a4:f7e6:284b with SMTP id ffacd0b85a97d-3a5606a262bmr288137f8f.10.1749663968775;
        Wed, 11 Jun 2025 10:46:08 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45325171e16sm27667525e9.18.2025.06.11.10.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 10:46:08 -0700 (PDT)
Sender: Igor Korotin <igorkor.3vium@gmail.com>
From: Igor Korotin <igor.korotin.linux@gmail.com>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	rafael@kernel.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	lenb@kernel.org,
	wedsonaf@gmail.com,
	viresh.kumar@linaro.org,
	alex.hung@amd.com,
	dingxiangfei2009@gmail.com
Subject: [PATCH v5 1/6] rust: acpi: add `acpi::DeviceId` abstraction
Date: Wed, 11 Jun 2025 18:44:06 +0100
Message-ID: <20250611174406.802093-1-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250611174034.801460-1-igor.korotin.linux@gmail.com>
References: <20250611174034.801460-1-igor.korotin.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`acpi::DeviceId` is an abstraction around `struct acpi_device_id`.

This is used by subsequent patches, in particular the i2c driver
abstractions, to create ACPI device ID tables.

Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
---
 MAINTAINERS         |  1 +
 rust/kernel/acpi.rs | 61 +++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs  |  1 +
 3 files changed, 63 insertions(+)
 create mode 100644 rust/kernel/acpi.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index a92290fffa16..6c809ea30e6a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -302,6 +302,7 @@ F:	include/linux/acpi.h
 F:	include/linux/fwnode.h
 F:	include/linux/fw_table.h
 F:	lib/fw_table.c
+F:	rust/kernel/acpi.rs
 F:	tools/power/acpi/
 
 ACPI APEI
diff --git a/rust/kernel/acpi.rs b/rust/kernel/acpi.rs
new file mode 100644
index 000000000000..f9a98dc4eb8a
--- /dev/null
+++ b/rust/kernel/acpi.rs
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Advanced Configuration and Power Interface abstractions.
+
+use crate::{bindings, device_id::RawDeviceId, prelude::*};
+
+/// IdTable type for ACPI drivers.
+pub type IdTable<T> = &'static dyn kernel::device_id::IdTable<DeviceId, T>;
+
+/// An ACPI device id.
+#[repr(transparent)]
+#[derive(Clone, Copy)]
+pub struct DeviceId(bindings::acpi_device_id);
+
+// SAFETY:
+// * `DeviceId` is a `#[repr(transparent)` wrapper of `struct acpi_device_id` and does not add
+//   additional invariants, so it's safe to transmute to `RawType`.
+// * `DRIVER_DATA_OFFSET` is the offset to the `data` field.
+unsafe impl RawDeviceId for DeviceId {
+    type RawType = bindings::acpi_device_id;
+
+    const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::acpi_device_id, driver_data);
+
+    fn index(&self) -> usize {
+        self.0.driver_data as _
+    }
+}
+
+impl DeviceId {
+    const ACPI_ID_LEN: usize = 16;
+
+    /// Create a new device id from an ACPI 'id' string.
+    pub const fn new(id: &'static CStr) -> Self {
+        assert!(id.len() <= Self::ACPI_ID_LEN, "ID exceeds 16 bytes");
+        let src = id.as_bytes_with_nul();
+        // Replace with `bindings::acpi_device_id::default()` once stabilized for `const`.
+        // SAFETY: FFI type is valid to be zero-initialized.
+        let mut acpi: bindings::acpi_device_id = unsafe { core::mem::zeroed() };
+        let mut i = 0;
+        while i < src.len() {
+            acpi.id[i] = src[i];
+            i += 1;
+        }
+
+        Self(acpi)
+    }
+}
+
+/// Create an ACPI `IdTable` with an "alias" for modpost.
+#[macro_export]
+macro_rules! acpi_device_table {
+    ($table_name:ident, $module_table_name:ident, $id_info_type: ty, $table_data: expr) => {
+        const $table_name: $crate::device_id::IdArray<
+            $crate::acpi::DeviceId,
+            $id_info_type,
+            { $table_data.len() },
+        > = $crate::device_id::IdArray::new($table_data);
+
+        $crate::module_device_table!("acpi", $module_table_name, $table_name);
+    };
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 6b4774b2b1c3..5bbf3627212f 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -51,6 +51,7 @@
 
 pub use ffi;
 
+pub mod acpi;
 pub mod alloc;
 #[cfg(CONFIG_AUXILIARY_BUS)]
 pub mod auxiliary;
-- 
2.43.0


