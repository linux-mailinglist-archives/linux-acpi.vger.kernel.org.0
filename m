Return-Path: <linux-acpi+bounces-14161-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BFBACF427
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 18:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9FF83AEDF6
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 16:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E231F91D6;
	Thu,  5 Jun 2025 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yn5XN2qt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283F71F2BAB;
	Thu,  5 Jun 2025 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749140627; cv=none; b=XK/5iR5/knhp3082J7Dw0F8b9CFn+SmYRXNqHt9wI6V2+15ReuuR1bDdEMiTEGqjV23ZsT3oBLY4kME7i74lFlBBuXYA8BkM5HoLnCNYbtPI3GXFdLdgvvskTzncdFzxlsUgS8dvSg5vkJWu2saTRGWt+YN0IPLqF5RLLApbziA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749140627; c=relaxed/simple;
	bh=B6QRYSwoEPKAw0CBU9/MKKr2LpuO0A+Kmwo/HZhwp2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IsoFQH/F+wh9DiITCwAFl+A9KUtgrrCeeCdW94NsWnIWPCdUQ1af9+UGZiGXzxNGJnGoEjAUku0wWYRUNnwYJQg0G3akI9uPLgwIBJNf07wHiWNAaBnabD5ms3YDOBZ0BnU8cQThL/6LRhfWkVUf20vbB9x5ycFwYp8ATyRbrdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yn5XN2qt; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-451e24dfe1aso10147265e9.3;
        Thu, 05 Jun 2025 09:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749140622; x=1749745422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2F7GrQ5ZHjP6suHBJXzOsQaZFBrj5luNHrI/XyyD2TE=;
        b=Yn5XN2qtiojxVNbFGEKGHjBhrYwJmxdp6jQqLEoV3AXcNCwWoFZkwjVb41S9ARXnQp
         Tck0K9EhsqiKqPp7ajVgNAeNGxS7hCXXLwdleczdQcXqxxT1GPbf92YQ/BjrCskI430G
         sZrGmHb6+RT5fauFwJFnA4OGYq6A+ZWkv/VZh19erCMb5lKopTdGZdUHkduShxceGcIS
         ne2hMW4FpvvZnQtwl1ImDXmTj3jI/4OD41CEBcXqXU8RjB2Wb/9VnEcVtIDK1YmwDg5f
         AkWVcfj6QrRl24/aYB/Cp04fcYPU4dSlPtBRYh4iZj1O/8iLT8w8thpFCJL0mxJBYVZM
         dpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749140622; x=1749745422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2F7GrQ5ZHjP6suHBJXzOsQaZFBrj5luNHrI/XyyD2TE=;
        b=hxohj2nFPoP48PtQX0UbDO9Rh1szXvfpsa3p3CWHMA6X7foMDvXnMqH+kqM9cIf78n
         Ud/eeUgn+E+M/mJ3mT6A7QeEv4ZFtNUbW3LIJsPs4nKZ0jT11//rRxZN9xjdMRmsSR8P
         j/ABl72h4o3tgHRmnt6WtZwXZpZdkzJZ2Yg45im6hV/7Snz6CFP5y6grq24s339d4gUn
         qIZn7jL8lSq2tcO6enFr1a2+Cm4UAQ7p3plhqdjsb9atxnudCe9VPJme6XoHjaxHVpN5
         K8fdchIESjSOOtlcFedlte0qvq9cOSkEHdhUO82Qg8LCnsxd2ynQNumPLSntN4EucWER
         nU5g==
X-Forwarded-Encrypted: i=1; AJvYcCX09IB7yyNTxTdRKNsJFdUBbcLK0Nl0vcePtgOdtkFw2ZaSyEOmbi/JWKd2sSN9MmYNn849z9v771Jl@vger.kernel.org, AJvYcCX4ydr5xOzqTeh/cUnHswxm82VylJA6spphdDi2f8z9p5BAUFeUCEX71F9WYEJo0+5aBhsbQQMf/L2gQg==@vger.kernel.org, AJvYcCXcPNVXm6+VO4WDtZt0AaeKlDQMikqYcrHOJVke8B2gVqFJ3mh1lV6F9SYmA37Xqa80KX/P69N6FsrgmkuW@vger.kernel.org, AJvYcCXrsDN18X05zoZH/0WmsYgYN37yAa/hlysXTiC8lNfOBPJdIeZqeSJ16z7fcyldbGlMfafptmq8U0k1L+ujPq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/xyDImZAfiEf7HAhtHgQAD2JFbzCAmh+Ew6AXuIFxzzdiqER/
	hX6bAxRkCgbpjNnt6IX0t4EWAZd9qLs8amMM7W1Ye0XLOxqA2vxQwrs9
X-Gm-Gg: ASbGncsfjZCG9SfWUz6kIuIdKR072jDc0NgAZvLYyqWQ7JehJpmm3vxOO3kzsN390e7
	VPKO6MSvQkeZ/CX8+QASJv6ERzVx4T41afP/BHX9/3LkrxMkzvlXXLj5mWM4JVuaBWpXhloRwDP
	W1xfbQENNVKI5nqNrqGu/GtqbNf87bZhLsrzIhmjttPoWsFfTGX/ljt9AYpdhkycqxZQRMYq1pt
	qu+/vTPtrTjLHxVVE+LKzLQSuqQbLbxoRy8T6ns+mMJaKq2GH2w5rpgEHgfFXt9VCUdyIFfrpmj
	EukGZ0hZlvB5yu5w5DEox+fyJg+W5vngqt2eI0KwfQ/3A/+cchD8u3an+kEyFwDhIagFYFlHf3u
	W94GFutFF3T/K4fkEzCEKNnY=
X-Google-Smtp-Source: AGHT+IFUzREo4CrSMybFCvDXcfF+zrn7VtJtHlVgCrTazl3OsJBFZMZ3pRtHj+4hJCjqe4EgIqLowg==
X-Received: by 2002:a05:6000:1ace:b0:3a4:cfbf:51a0 with SMTP id ffacd0b85a97d-3a51dbcd6f3mr6839341f8f.21.1749140622061;
        Thu, 05 Jun 2025 09:23:42 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.. ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451f9919671sm30128675e9.27.2025.06.05.09.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 09:23:41 -0700 (PDT)
From: Igor Korotin <igor.korotin.linux@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alex Hung <alex.hung@amd.com>,
	Tamir Duberstein <tamird@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Xiangfei Ding <dingxiangfei2009@gmail.com>,
	Igor Korotin <igor.korotin.linux@gmail.com>
Subject: [PATCH v2 1/5] rust: acpi: add `acpi::DeviceId` abstraction
Date: Thu,  5 Jun 2025 17:23:26 +0100
Message-ID: <20250605162326.3659046-1-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250605161956.3658374-1-igor.korotin.linux@gmail.com>
References: <20250605161956.3658374-1-igor.korotin.linux@gmail.com>
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
 rust/kernel/acpi.rs | 62 +++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs  |  1 +
 3 files changed, 64 insertions(+)
 create mode 100644 rust/kernel/acpi.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index b659fb27ab63..5f8dfae08454 100644
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
index 000000000000..2f526a0b2ed9
--- /dev/null
+++ b/rust/kernel/acpi.rs
@@ -0,0 +1,62 @@
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
+
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 6e9287136cac..c2761bc7cfe6 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -51,6 +51,7 @@
 
 pub use ffi;
 
+pub mod acpi;
 pub mod alloc;
 #[cfg(CONFIG_BLOCK)]
 pub mod block;
-- 
2.43.0


