Return-Path: <linux-acpi+bounces-13990-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC663AC8EEB
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 15:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0339D3B5CCC
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 12:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B3726280F;
	Fri, 30 May 2025 12:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hainksAY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2533261365;
	Fri, 30 May 2025 12:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748608848; cv=none; b=ij78lSMmSyDx6dnzQgF6avmdDu6Eaa6FJONjK92lgoqMXzcpqs1sk8eee7IjjQGd74GJz2BPBHGtdDWDFvWv5lpPCcHJ8YEAZ6HuOiofow2tQfapEIJJR7mKRwBk12PTxh+s5KsYt9IebPB1t2z5j96WdnHcIB9yMdGQ9xOTe88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748608848; c=relaxed/simple;
	bh=XWF7ghCau7PeWDzA8J+cdCynLNNleKMMNsGblfJSVWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hK2kD5vaG/kO8BT+MYNFzmAeIq4mlZm71TXBwnVf58kldNvuKrcJq6A41a+q04x3IWQ9+Cl32Trr2eqJgMOPvQmYaFzg543NRC+/1hyPwrXX20sFTId2R0acWIbzUZswGfoT5YIFucuLWDPOLig3SGNA/SPJ+2Dkg/ZBVo4PH94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hainksAY; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a363d15c64so1320142f8f.3;
        Fri, 30 May 2025 05:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748608845; x=1749213645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UK5nNgXBuHxDSeQY2F0dT9x4Zdv3FiZ5Mbfzw7GxZn8=;
        b=hainksAY18GVTqkHDLWetVApZyuFRazRxghW+gW3UWtZyLaL0wFdhzfjW5Ruafi8xU
         S979XAYfT916gh4T8k2BGe+gQnqKObF1K/+Lb4Hagwtvuz0VCCtO5/fQCuL0AkTtMtTp
         Oq92dFz1Rr3lJwQL8xistMaZMxNNOowWhW9x6pP/9qKzfpFIISCIvTjCYmxH6jh+8GI9
         v8Py4H8jSgIJ/g/WnGp+2JKPMMOQnMVnbHv3P02uUq9VYQ1c6l+jF089aSC6TViLEL50
         lK3RLCS4vm/+ctTmiiZKm4Ix+/p4fvAy5gEWLqZAO4+LLVrA9wKabd+S9gIv4pyw+9qb
         0u8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748608845; x=1749213645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UK5nNgXBuHxDSeQY2F0dT9x4Zdv3FiZ5Mbfzw7GxZn8=;
        b=UgaHlxpTk0RikGL2aMEsLrmSbjGxmD6JkgP1wvxLgk6tT2gNkcI9eAvnBI5HowilUE
         1tD9+1Eow9cSXzI0iD+kKIGUzD0/LOn3nfoWiG+ius22fD1i2XerqDIxjw+hq867NqlQ
         L09fhsnGusQVfE9c4DbL60FpZolTnQzPHSy7Z3gnDBNjieN7wdNjdAFJGiFUO4vJj2Fv
         z+dhCCxV3y640LaEWy+gRa2jBLTiez6GBy0QhcTcw3XN6VzDQrS+igqyLljmZl+QKRgR
         z2jpMGSbEqhRR5U7o5ArtpCPIdm/8ye/ZcSNc0Gv7e6s7u8TVPMPmG8vcgkzYOKHya3j
         kIzg==
X-Forwarded-Encrypted: i=1; AJvYcCUBr/v4CwHtQjRBStNr/Bwr6RDdg6DdUbZ2mcKGode0yLI5wv0XSa+Xi+RTr2HWzd5vuVBqeoNjtbejoBBDKYY=@vger.kernel.org, AJvYcCXKpaO87dPb4VCh1MJvZE2t8W62iC96yDlpyu4zAsUr49uZC59k6LNGPyPlSf7u9ctXBICikWVPtJHwE7/4@vger.kernel.org, AJvYcCXSQNbnQtNlN47bk7LayUpRYgmjdyWbD4SFyL95jJgINOpAk7S8rToiu8JWnJayVcWL003sleaGkfyt@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7UTQKLfZPD65tUFJUT3a4oZ1ZH/eBgNh6o+Fo57Ttk9Ml/ikj
	bUX3EgVZ4BZ+MHE9L2Tva90uttTx0Q6VK0mHmOc1aMqXRQobqqT0N5dL
X-Gm-Gg: ASbGncuIk9oUFMda6SOBBCcRZY7G9spd1VnhGfFrJBgs/Gak+L776N/6QzD98tF8ZYW
	ydLzYYkel/H6ZRj0+y4OJ91r6hm6act0W1t6Oh+TSA+B9WI2RFZ0MUZhV5NbvzrU8z7de0cYhTX
	iAsmoDF6Zj3323qOrQwg0zSvJWGMaebOxjzQluyw0mFTRCaLNWh/a9Q0+6CW2jes6dEywd/QNk2
	GS+6XIURDZXSZEReoQvIV0QyHIWDqDLyp9qTOXw2ayq+NTUETnvsuCMgD5wNGrVT0PEJ+naNiy9
	0O+9sb1guza0u18kUkbTmOryPHh0LdtV496vUBOMYPnHKyBPtJVPgZ2yw07oP2w58XWNE/CcBVJ
	bP8S76/G4dCcmBo3J02TLO8GF9wQ/
X-Google-Smtp-Source: AGHT+IFKXKz9K3tDUkA7n5EvBtl+LosvhugkBp22Jy94or3qDXc9oEfUgmuRTn7SuyVpYTAFxKWaig==
X-Received: by 2002:a5d:5850:0:b0:3a3:6a1b:6885 with SMTP id ffacd0b85a97d-3a4f7a6d1f5mr2638615f8f.47.1748608844502;
        Fri, 30 May 2025 05:40:44 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f009ff7asm4752103f8f.90.2025.05.30.05.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 05:40:43 -0700 (PDT)
From: Igor Korotin <igor.korotin.linux@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-acpi@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Igor Korotin <igor.korotin.linux@gmail.com>
Subject: [PATCH] rust: acpi: add `acpi::DeviceId` abstraction
Date: Fri, 30 May 2025 13:38:06 +0100
Message-ID: <20250530123815.1766726-1-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
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
 rust/kernel/acpi.rs | 63 +++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs  |  1 +
 3 files changed, 65 insertions(+)
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
index 000000000000..bbd38910736c
--- /dev/null
+++ b/rust/kernel/acpi.rs
@@ -0,0 +1,63 @@
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
+        // TODO: Use `clone_from_slice` once the corresponding types do match.
+        let mut i = 0;
+        while i < src.len() {
+            acpi.id[i] = src[i] as _;
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
index 15c5f72976cd..05f1d3870bf7 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -78,6 +78,7 @@
 #[cfg(CONFIG_NET)]
 pub mod net;
 pub mod of;
+pub mod acpi;
 pub mod page;
 #[cfg(CONFIG_I2C)]
 pub mod i2c;
-- 
2.43.0


