Return-Path: <linux-acpi+bounces-14321-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF065AD8D49
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 15:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 143763B573D
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 13:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BAD158DA3;
	Fri, 13 Jun 2025 13:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqRVk66n"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43F1111BF;
	Fri, 13 Jun 2025 13:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749822050; cv=none; b=Z1+7TtycwgbNtAC7hKdrbpOIv2HiJR2PKHGjy4ZyBTCHvh6aZaGfDAIYNBZ+b/L5LsHh7cBUpP0N0yqJD6EbiDSOFvGfPzMLs2PgsODD6BSi2xjeTXokWgrIjXAclSUw3xXxojFuuZjCK5LwkRh0KXgDUcym1rP0KVzb41jKaH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749822050; c=relaxed/simple;
	bh=fLM1J7jVqqiZf/ld7d1JFGfRWVz+teNjK6y084/tbPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BNSV5vms5Kwbtlbhq6bjk/VgU1NkfplM+jeg7FEJImv0lUpQmLatZyS3RynIE0hx/xHMs3qNFmJpvpokQRZt1VXVajgeDoA9i2xAFrpmxqg8fFqh0ZjlCh9Skx7HoR3sbRpTS4lO2uAd1Ou9KcCvqx/7wq3BiSjuC+cANMmGIEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JqRVk66n; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-450cf0120cdso17390995e9.2;
        Fri, 13 Jun 2025 06:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749822047; x=1750426847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oudxA8JPC06HRjXurKEPIdr/6i2EGFIADSPFZLQo5s0=;
        b=JqRVk66nenFwP3UFJSa2v0lIxzb6/hIo1iqOQqNzCbibJEMr/GQ7I2ZZ38jAw7Fe8s
         6LhmobPA7CVC+WrrO9OB1gjz7tsXUCnq3J9ps515xDnl2kFCPVDufBS4T7kCCS6xSLwO
         IP8CkfzAbgm/vDgtiAsAUM0ewRwXkSN4m0cgmeJklKbHDs2Zw9b5jdoApSiPCYj+apwk
         v5Fhsi48PlEtIMENJxTcLGNXgW5Lx7qUOc81aKa83cmn88EuZljftGpE0EPITSFPxaYh
         rHK44fBmJ11GkuP0gBqN8JlQ1LAJREviY+rDCjM9n/i3c8D+UXG8Kfw5jAf+Rwp+0svE
         EKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749822047; x=1750426847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oudxA8JPC06HRjXurKEPIdr/6i2EGFIADSPFZLQo5s0=;
        b=uH9MzXXREWtXXMYb12JNtv5x5RJJmjUXOI55KGpB2MW2h6Brje5YhzS+NkKXNAKy1j
         BZcB/N7Y3Yiwjo8cRSWIRdztI/SVpEbhKk+CVp/8mYmFlQnNEvs9vaW8/r4XAGEeRLnR
         dgycMXfGWzKE44ujr+m6AFBewDEvkTGAZXLcHKtZFw9QZHjUVFgxvkJ3vAWS8R6MSq7o
         zseuIxSmyu5ZOBokwCrRjQU7W52u8/6b89E85DQPNZKY2mdByc/OyRJ8KmVDDK/Rds0T
         kzHbVCPtMa5RB12Ua+e4n/pouGvLcznPTpPDRsaSMuhYyZEBFtx2gwHsoPLeSUaqVM8N
         MNQw==
X-Forwarded-Encrypted: i=1; AJvYcCV8Th2+3U+a8mUPgRhSoViDu3bgqmJeuW04EQ6iok8ZSJAdim+3XEhfa0PLcs76GFxjGF8z44HVTKsrr8AEFKc=@vger.kernel.org, AJvYcCXCEbqv2XD4Qe0SLUPoO5zbz7zobkMSx5sWQ85oJuM68fsI6vCpvwdUwYS9aBmbk1hn9eAVER1KX8wE@vger.kernel.org, AJvYcCXfeBZ9Cxws57v8dfPEW94gUFOJIeiC6mFGK78ntU9E5ZxSBZIAJCob0A/iu8NsFkD8qf/m8DpqyEaU/Kc5@vger.kernel.org
X-Gm-Message-State: AOJu0YwW1WvD6Cks/+uJgZwlTZ8Hb5P79ycPDQiT1v5yX6k/ly6rVEmD
	+JYsFORkenmFJHRxyiJkH5LIRItQ6MMyvJzSvg54X0kqNL4T3LOc8b44
X-Gm-Gg: ASbGncs1rVaRP0NNeLvEhH3cYIcPO4H+N9Ick/E0aPfPQSPrSbiKAyZE5/Fx99RrUdf
	pje+Sm0EbFORPt6ES+H/hvTG9a+MykO4r6Jx7dPm9wFYyESwOuTjywMMGAlzIvNEVCzhaNtfDTR
	U5xX1f/4q+D3wmbuwQLU6iUZkTC/irVEQZMIj/6bzgVXugspqglAMBnOkE3egtMGthuXdPxPlB3
	8sprvqY7CLdxMdgL1waVlOosHpJqXqqd8VilOAgyEhFO3tYDMo4aWduf5LmjpuFBglwl8RjQeuI
	a+akTIYlvS9pbfsMxiPOIcAWYBfcoE7hz+w3x0I6EQFTRnLBWvXRROMcGney8kPdCh1W0bV+4xB
	iI+EefVSMyokKt8PWPl87yH1jBxsdk8Hn+XxyXppqKFsiuNc=
X-Google-Smtp-Source: AGHT+IGSQQDsmwIh4IRTyDRinr32zbDXqbTyjcQINJTodAgQ41yIYuwm/iuMJcEHUctW6KpfLD9UWA==
X-Received: by 2002:a05:600c:4f53:b0:43d:9f2:6274 with SMTP id 5b1f17b1804b1-45334ad2eb9mr35369995e9.14.1749822046739;
        Fri, 13 Jun 2025 06:40:46 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b48564sm2361368f8f.82.2025.06.13.06.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 06:40:46 -0700 (PDT)
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
Subject: [PATCH v6 1/6] rust: acpi: add `acpi::DeviceId` abstraction
Date: Fri, 13 Jun 2025 14:38:42 +0100
Message-ID: <20250613133842.1230254-1-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613133517.1229722-1-igor.korotin.linux@gmail.com>
References: <20250613133517.1229722-1-igor.korotin.linux@gmail.com>
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


