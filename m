Return-Path: <linux-acpi+bounces-14438-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EC8ADE84D
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 12:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E094A16337C
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 10:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144882853E0;
	Wed, 18 Jun 2025 10:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/cypbIE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2966027F16D;
	Wed, 18 Jun 2025 10:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750241861; cv=none; b=tIIk1CLnOJujT5bujdmWTgN0TUgK5aZHdp+T29uKcB6ahjhzknxbUAJtPzpL2jtyo/z47Elvy/bIjL5+XnXdQ2ARXN9aEX7GL6ZuyoXyH0GzVEqgeBINKtzs6/4PamnZMZhlF5ODJcUTnekSz5br903AjT2j6WjyWtaf7VyzcRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750241861; c=relaxed/simple;
	bh=o0tgbZ6l9N8xB1X8Omt0Kq66IINCXwZBCo1mV7j2XGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMkCSqm2VFVUJHHbV3GOcFLSfKptpu++JlCl9DmzTT1AkcqOM2vyi7+0PBpC5t0G1kqz5g7gD/FtGaQ7N9hBA2At2xkycdxleVvObYN81SYihdAv+MCwJnMFqWg2hnWCgSG9CjNFd9J6bUf/spqXO2Rvh3htcuSOiaJKBEEfKPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/cypbIE; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so85273735e9.1;
        Wed, 18 Jun 2025 03:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750241857; x=1750846657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3MCJ09iMYAJehaa7R4exb7fZmksRmxtphee/D+f4gE=;
        b=d/cypbIEMqZJV93dYpaSY4O9GNc2Lh1W/MICBd7+oq6X/GCuGDfB6+/FpcS6Sd9DYV
         JpFwLu6I/dubmuVnC2aBx56yOn4SDX/Nh3JoaiP+BaqmoE/vK1ASWJ7d/3+NFkPieRLE
         wqAQDoWbjxq/h7LcG9GAMpYImWCSWCrIYBi6eTSoLy5o86v7pkzUuenq8Mhq9EorCWJp
         2Hthw6WqmlnI8DolBugcWLMY2txdlvs32JQdau2W3PQC6D+0ykv0j5AiZZsuNyhN9h5C
         XVEQ7ZZeOLiHx4ox1Fa3ogN+LqlzzyO85ylvFFOrNW7n9gdojibEO8BBc5xkQ/pgZQoi
         EcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750241857; x=1750846657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X3MCJ09iMYAJehaa7R4exb7fZmksRmxtphee/D+f4gE=;
        b=dOzvaQL0dFxMdmPM/EY2yRvR7J1l5IIFimRRJMq2ulNXrvkxiLyZUy+ArlNqgmEADu
         NExWHi0cMhJJ+3bpKoseoY/cGp8etpdIvHQsdAqj9BlK5Yp6Gi8ubPJc/NDVEmXuC4gG
         0+ObzFHem6X/Q4Jbf7Gt6SItbe2DJJM2KKr4rbE32qjIJfoessryoc4xSI4cdyJl2g0k
         tIF4PdwrRVN94WfmojD0EDzw7yRqTgkHhSKKQM90+bD+OkPEFMnqlu4Hzf2fHg/kffJW
         3yNrBu+tfRcEJxoo46PGJTYJ6SMt/EdUxli5BY5SNqUkdz1MBWxNby/qGujC6L3rBGQu
         IyNw==
X-Forwarded-Encrypted: i=1; AJvYcCULwHClOf/XL+1pMzN2Xf3Aw01Jhwi+WUDqaplng/A4o0KR6fI/DDsNF0L6JNDF3axMaHgzdFM1kIl3svRX@vger.kernel.org, AJvYcCUYZiqYIIoCz2IeJMh4qQ9bRRNXAfvTFcBAtmHkJOM3C/+oBcqlDrx+mwNuTuQbYFsW19nrtMppremi@vger.kernel.org, AJvYcCWEPIF87Pb+6qQIrH7omSpH2xoNPg5+QFF5+tdu6DqjMtVliukA7C6gvQ9Z35s1cORJs4f2JD17yMnqdZ9v8x8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLCWsWF1oNFTy88F0ySUj/r8A8RgpA5vcTNxiV+Ek+8KkKx1Yw
	3FhyQY1veGtuCR9FZVzmvvuSYZaGCRrZC6QyR8jHT9cThN/SxMsToL9M
X-Gm-Gg: ASbGnctSwv9j84Z5moy/7kdLXD62+Vx7PyUoMl2sKhxUJHAnO8LQBqNEXl83eKZHkgH
	QKd48nCz0NP76AXgIWgGlYoPavPXmg9v+vrC2oZevXIOjDenWDcM6hBtcqQZzSNoxa2xbOmjpFI
	jUr26XKBnqia40FUIDuMHaYz5Nlr+d/8nVJdItAkqoNoIjK8JZZzJbrhRgvYkSjp/CGrS+vG1b3
	E9dtEGNXoj+sR+EF4AdRk0Yf3owH4mJezCCmx5LkcUUOu+piRGTvx+utaXFGwtHmyStXFbOtC94
	3SsONESscNeqLJfUnoRrEwEWpJB8C0s0AVOxLUFGfOWgGL/Z/RBZJMl2HBDR7THRYeNr45Et1fr
	m3IIgX47RIxRS362moH2pp3K5b5w1SPzZkxE/
X-Google-Smtp-Source: AGHT+IHBSD5xgqVtLPW7Ie1ApLdXu1ylBvAlNyRg/m6dABbRKmGS4jcvbdLe12gs66fPRSQeQ+l9FQ==
X-Received: by 2002:a05:6000:230e:b0:3a4:e740:cd72 with SMTP id ffacd0b85a97d-3a572396df6mr13827720f8f.13.1750241857173;
        Wed, 18 Jun 2025 03:17:37 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a54a36sm16731721f8f.15.2025.06.18.03.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 03:17:36 -0700 (PDT)
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
Subject: [PATCH v7 4/9] rust: acpi: add `acpi::DeviceId` abstraction
Date: Wed, 18 Jun 2025 11:15:33 +0100
Message-ID: <20250618101533.3048391-1-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618100221.3047133-1-igor.korotin.linux@gmail.com>
References: <20250618100221.3047133-1-igor.korotin.linux@gmail.com>
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
index 9f724cd556f4..acd36c148479 100644
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


