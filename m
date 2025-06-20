Return-Path: <linux-acpi+bounces-14482-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35485AE1EAB
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jun 2025 17:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B774B170BEB
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jun 2025 15:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61EE2C3757;
	Fri, 20 Jun 2025 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ya3OYn/b"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C382C324B;
	Fri, 20 Jun 2025 15:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750433191; cv=none; b=lXVI1LrFp++xPeyxKsmgsFUNxLpRBRqFgCJqcIDDQyVbquYgNnqJOEyYjvAme0xt1cPyLsXJuvUijK15ANeV3v8N81SpIW1wzAe5CiTsfaxLvp5JGVkqEua+JMPnGp/DTZGk+huO84uecBNLheuMnd1wBm25AzDQ+D1ZIoDX2lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750433191; c=relaxed/simple;
	bh=WUB2wpa3W+3uIW4pg1fQ/88tmjy06qgVmc5O/tjNYJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h32tT5CJPGcZs2b2GTFNU10k+fJEcJ86D02t3J+Dw5FxSInlj5BSza+SdSHtjZLREToImD4bnOJAQG/dAkqlfaxyd5shHanO5O0zj6WWpkNKSskL3UO6Aa4rHHiENm3WZB3nrVDyj2f1odoxDKKdolCY19cf9FP7XEnC1Tu92Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ya3OYn/b; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so11943935e9.2;
        Fri, 20 Jun 2025 08:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750433188; x=1751037988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvw6+KSPOqtrmOukGHEiEP8MZe9/XdRUXjCAQWIBviU=;
        b=Ya3OYn/bxS5vCtVeI70dsYBs6h0TDnnczTD5q4G3GGIrzWUjdDMg5gR8fx26KU00ED
         EBhoWcr6MDtpDkJE8PiMXI3TIggpab949ihqGzLxnYau8HWozxZInYrTScfzqeNMoNku
         SKmwjDJNEUcxPFjCXXbeARVOQyIxmlAPYzsthNCHi+8pyfvI0VwBZHwojG17PUdyHKz4
         Mxq9Gveqnmi+HjRFl/b6PBw/8DXi9P6ukUxPBb+3kj8exo42sS+Lw2ysUWp8kXkrD5Wj
         /X3E6MSQWn1qPYM2Hf/bkwU7zRXbPKkRW4P9pPqQrygaAWPZF1aj+SZOdyNs3oVLZh69
         dxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750433188; x=1751037988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dvw6+KSPOqtrmOukGHEiEP8MZe9/XdRUXjCAQWIBviU=;
        b=oDnSjuQL66C7SxtYa220FAH8sT67LHAGglbj6HZ1ycXScibJa7jyQSEAXxXXyHcbqg
         UfLPEpBxWsJrxWPYu7rcCrGTTYEgVnuxwIxdxhQ36/K/dktAt+nmpapgaPQ8nkxj/BHV
         3FXv4Fg4AysE78jT/EHEi3id2zvWlQ4yLvfKAoEDkG5RKDE75Gb6V8miJugCS/KcQ/PO
         i6KcO3ib3JarfY6IjdcsLwOzC4RCMyGuP16IxW6zinCsjl5n2jLCWuOZmVtTtKTc1C8S
         zAGNolnUBNKdRmhoaTxTk2QDq1SIDY+nXpqXk+IurZvJBZGsYAkkdkq1jgdsk+sSNWJZ
         sM0A==
X-Forwarded-Encrypted: i=1; AJvYcCUhu4GxXGO72J6ULHhMT+Ws1qW8AjtbC58xhWG4wPChq5GXpPtGPYJZsSijnzf0N5NejLb+F6BrKa4Y@vger.kernel.org, AJvYcCUz0YcXz4HR4kAxbuWtSqFkw85ojXVgl2xAIlPbez2gScAxDv7fjXSKro6LunolUu1pVcviuncPaOANeAX5@vger.kernel.org, AJvYcCV5JF+rlLs30etVDCxXXAZrdZa8tkGMvQn2RUftRqTEYfnyIbZFevJJ7Lc965pncRtsIj0atiFtGFz7hwou3DU=@vger.kernel.org, AJvYcCVlOh55vSDBXSsLD6RK4id/I20JKx2eEaH8nHWJGKApk91Pl2bV1Zf1x3PIDVcWjw45Vv4LtE36O4fSMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0kD+vGcfWZaq3Pfvb4MJvpo1X0rWKWjHNv+WaDi8OlunUuc/t
	fIryBTwubwIIXJ3zFXED6V0LnTa4axqVgsIegfTGKeXJChdCnr4ot8Tz
X-Gm-Gg: ASbGncvE8Ii1cr1GwJPEPJ579I1YBpyLIaG95KsMTgKqousdvOSnjOgXQkxTRX0U9OQ
	fRGrSwoQo26HsR/8+bZBjolFUeBC8mdfvGntqDEApDltDKzSQHZEeDa4yy9F83GrU3YP+BPmTEY
	ugnCuxJYdB7qRz9dpFgrt9lT1I51dEJZasFIJCDrXaAT6cIKNoWmytl5Z6gKJFD9NPU1R265kwB
	bfOfLQwiomFdPhc+1eFFCETUliHOm36a0io0rlF0AleCP58X8awBAwCUv5l8CUol+J+x/WcT4Tr
	1a1xneFYNC+XJnNhSV+Kr7+4HUPnILfsmS1Erz3BwqiY5/FqQIDWVR4GxVY6klXze/TgBi3b7+B
	SVY/gL37cATzDsAQtOi6h5ElxFLBFzc7cQYxk
X-Google-Smtp-Source: AGHT+IFGJ4j2oFpKlnm3TiPSB5wBBPqtGsgs71FDdaXalDsriq6wX0J9e6BEAmaAsoKXsWO/2igTtQ==
X-Received: by 2002:a05:600c:4443:b0:43d:172:50b1 with SMTP id 5b1f17b1804b1-453659ef73fmr31399135e9.29.1750433187813;
        Fri, 20 Jun 2025 08:26:27 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453646cb57fsm29222215e9.1.2025.06.20.08.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 08:26:27 -0700 (PDT)
Sender: Igor Korotin <igorkor.3vium@gmail.com>
From: Igor Korotin <igor.korotin.linux@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: Alex Hung <alex.hung@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Igor Korotin <igor.korotin.linux@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Remo Senekowitsch <remo@buenzli.dev>,
	Tamir Duberstein <tamird@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Xiangfei Ding <dingxiangfei2009@gmail.com>,
	devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Benno Lossin <lossin@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Len Brown <lenb@kernel.org>,
	Trevor Gross <tmgross@umich.edu>
Subject: [PATCH v8 4/9] rust: acpi: add `acpi::DeviceId` abstraction
Date: Fri, 20 Jun 2025 16:24:25 +0100
Message-ID: <20250620152425.285683-1-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250620150914.276272-1-igor.korotin.linux@gmail.com>
References: <20250620150914.276272-1-igor.korotin.linux@gmail.com>
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
 rust/kernel/acpi.rs | 60 +++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs  |  1 +
 3 files changed, 62 insertions(+)
 create mode 100644 rust/kernel/acpi.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e918319cff4..3e59a177ac0c 100644
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
index 000000000000..2b25dc9e07ac
--- /dev/null
+++ b/rust/kernel/acpi.rs
@@ -0,0 +1,60 @@
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
+    pub const fn new<const N: usize>(id: &[u8; N]) -> Self {
+        build_assert!(N <= Self::ACPI_ID_LEN, "ID exceeds 16 bytes");
+        // Replace with `bindings::acpi_device_id::default()` once stabilized for `const`.
+        // SAFETY: FFI type is valid to be zero-initialized.
+        let mut acpi: bindings::acpi_device_id = unsafe { core::mem::zeroed() };
+        let mut i = 0;
+        while i < N {
+            acpi.id[i] = id[i];
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


