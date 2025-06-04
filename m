Return-Path: <linux-acpi+bounces-14130-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4340CACDDFC
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Jun 2025 14:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DC7E1894C87
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Jun 2025 12:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6385928F50F;
	Wed,  4 Jun 2025 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJXJo3u9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D06A28F929;
	Wed,  4 Jun 2025 12:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749040339; cv=none; b=q5KKbVi/bcKR9ogsuacrSY+494FTtWn+LOVvUa8bRbIHxuBaAr1xoX3jjGqLwnBFXkGszzrf17aG6L3SmzYs1JViW4Jj5XwkAfY2cwmdUT5LW3xLvOv9R0Z6VgJWLTW47fgVfKoMi4lxbQHiEkJC5gmNdXF7sr10Aff+7OJfVQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749040339; c=relaxed/simple;
	bh=B6QRYSwoEPKAw0CBU9/MKKr2LpuO0A+Kmwo/HZhwp2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lsxP9qK2HkvAItZFyuDLuUN1htjlpqagCVvuXsSlSDjNJa4/Csb1JvDPymZSAuwEZUQkIYeATgFUMhsqoPHJfkR/nXY6kRJbsvZR1W3a2IFhrJOm8Q9YUNpiZJAmWwxq1FyKFCTAzug9OVpBrzr8XHUh7gNNwMF7+ZzRNIoGJQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJXJo3u9; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-3a374f727dbso5912881f8f.0;
        Wed, 04 Jun 2025 05:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749040336; x=1749645136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2F7GrQ5ZHjP6suHBJXzOsQaZFBrj5luNHrI/XyyD2TE=;
        b=mJXJo3u9xwPWKoJjPkypG6bn2wAkNiibra0tqugwDYfNAmcFCd1fgwK99W8nNq6OYD
         aLuqxLEptG+Xe3bU8G/Nw38tSX/ftpbKGuQY8jQLPhzZpH+YE63zm+buQKbuVS57VIN6
         PGTs2V+Ffrt39iLgwUqXtIYsrlphoThcvp2pgmFCaiktua8u6ET9eMjbKZUAR8vXWKQ2
         z3t2fac84tKw/D8HYYGiU6Euek8K6gjqD+fKpSznF/OgJIVYSLvFXR1Vy9nBP8OgGkGC
         /ZgeJhMcK4eLlD8jGxdvW2ErRqWK+m2AdcPzedTXhOUw5/4IY0EyoQLWWlOkBtMXTx3N
         2uqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749040336; x=1749645136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2F7GrQ5ZHjP6suHBJXzOsQaZFBrj5luNHrI/XyyD2TE=;
        b=gNVjR96Atpf77y221YLnlA/bZMVIFuhGz67Nd/ck6lmrzK352Jl13UrgFoHBQ6oPVg
         iv0wMIt6ZlX/M1PTiVc8MeSo5JYr/uxLCfLQCKo8rXYhCHYDQupUpIwjfF7OqtamyKjY
         VZwvCLsogBH8Z3Dm1NkHERctC/qrJD8y9j6Kih7le1TWR7ZlOApiFgz4Kg0ivcWoTDUW
         RgXfs+g4wxXwDsrmxFUY/S+45Hr5OpW5XYTSPJdpSdpzumdjY35xGT+dAJeT5VIU7IOx
         iqqJENN73nYcpuMhl596DcjqV+hL+J6x+mfjmcCAz3ugIy+1b0tgHCJvqvq70NFU2vKz
         hfgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWASuHyDLDxe2pEGlENxegm77Q6kIhBE+CVx4oq41o1Mz3MAP5honUkSQRYJ+eWqCRYpqDWdD54gwRotA==@vger.kernel.org, AJvYcCWMxIZP/RL6AVppQuSUkUHPeZOIs7gLDv02kPfH4ho/ygaRd37CsCv3Clr6tZCi9GAxLLeeT2yH3zwwI1PhJvY=@vger.kernel.org, AJvYcCX+stnmli2CPQH1FF4QdQcJDSL4pduSq3R/MPEjaTAc1e8+L9+59P1nZTdxeQesEBghTZe/oeJYBMumeRYM@vger.kernel.org, AJvYcCX5DIvw3wr0OSCRSATyXgICo8fmBk9k4t7bCZ9plpr5xuDPKXiTlMasxTyhUe9OBXCc8Gzcsobtrloo@vger.kernel.org
X-Gm-Message-State: AOJu0Yykt4WGpxXiSaUcyj/4O3dx0XrICD46PApKkHw0mmIAytBeUKml
	cPevO6PUG7sD1VU5wOLWwG6o9y6/rkGd1G+LmgJeER/RVLOZv1j6QzvI
X-Gm-Gg: ASbGncsV1lxuFtB776WtLoPZTg2cFC/HhkEgzdC6bUV8W9Wf6dTzeOFQib5aMX3R82Q
	orM2KXiGl6vgn5POZLJQ9ES2bfCwG2isST3kggtD6Kb1ksjwksm/ozGlqS2ugl5esVohNaScozq
	BcjVYmJk8FxCYTC34Avy4VWipbOoooIhz0zSC6SEwsov0FIAyhK3vsH/2CjYt3m46ERKmdvA3f4
	t//PcTAqODt72TmDKiKqz7iKbgd+k+kXsEwsB9OmhA6kvUjJm+Ht1BmXGKjwJavt4QvXGiXRJTf
	fZAEziR/20NAyzM17YAg05VxhQZvQVti5NUDOGRzkcP1dHT3tJAx8jYNioLJhgH/jSCxtBwXOKH
	S9VOLxsSGaH+ksu5oh91+tED4AxaU
X-Google-Smtp-Source: AGHT+IG/YAHVEgsT0iwtMleHoRoZoKaEfTJVyrwismrWf/GQQyXUTjEX15d+2pC18p8+ckzjRlUlFA==
X-Received: by 2002:a05:6000:2489:b0:3a4:f644:95f0 with SMTP id ffacd0b85a97d-3a51d9791a6mr2036983f8f.54.1749040335466;
        Wed, 04 Jun 2025 05:32:15 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8006c21sm194467085e9.33.2025.06.04.05.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 05:32:14 -0700 (PDT)
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
Subject: [PATCH v1 1/5] rust: acpi: add `acpi::DeviceId` abstraction
Date: Wed,  4 Jun 2025 13:29:40 +0100
Message-ID: <20250604122945.3445776-2-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604122945.3445776-1-igor.korotin.linux@gmail.com>
References: <20250604122945.3445776-1-igor.korotin.linux@gmail.com>
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


