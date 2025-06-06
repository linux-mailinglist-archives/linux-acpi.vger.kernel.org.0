Return-Path: <linux-acpi+bounces-14203-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E45A0AD072E
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 19:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D8693AA288
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 17:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B93B28981C;
	Fri,  6 Jun 2025 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwzctFfU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814AB1DCB09;
	Fri,  6 Jun 2025 17:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749229623; cv=none; b=L6exO6xAJUKj2dgikmM/Pn6zB3LSiQr1dMp7IusiVy2QDxkaf8wbOn7lgepdMWrAQhcRA5pCx2MUc+dpEG/MC+Ky5pf8vFBXfLVoNDjKn5/u2AEdq8FqW103zpvRruiWrJSK3pmtRSe0mqyThRv9rIkifhYdR8uAthIjm5SrCu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749229623; c=relaxed/simple;
	bh=KEJ/UuLwWvSWrDMoCKZXu93CmoLNfIFRbJTlWuBegGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OdzSgnJGGRCq/+1v4B+eddJ/oZSxhKKAXDti0vxQVexRr6MzoDltcUkphGIJctpQpAMur/JmIbNmDi2uBltpKKPTIa7UYfUCW16lQQiMSuO74Z8GZIbw+jxp9EvfKiiqzW17PrlHSPFBTwewSMbaJzkejX2chhDre8XxAfEDM/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwzctFfU; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450cf0120cdso22079695e9.2;
        Fri, 06 Jun 2025 10:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749229620; x=1749834420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYO+eGQfYOWOdEYORTE/WzWP16MU86w5cp2kZkMSGJI=;
        b=UwzctFfUgtWMoV9H7bP4P9fvMXL+DJYSSa2Z2BzJr+4nF+Tzhq5qrKQixGsfR8UdBi
         6IsJjaTEunUOZkgUNBwtOr5j0EEjk55QvKGNVFT++d+F6+RVFKGSj3hVxyZhbGZaSAb4
         zCiA+JQV1g7PfkxS8+SZa60luEXZ7QmlaaB0VR/vzjFGxZpi+Yrrd7o0pHmS70mV5OKE
         O/dSq61nn0dvuAW3+0Q6gpec4F3O4e4Mzzyf6mgwOETMcvImzDmSUPe5EzKcV9e5IAUP
         Tb8A2my5PjLKmY+/AsJ9yahMblYJOhMhPfrAoFz5CUCPc7HuHCE4d6hC12alIIdZsdjY
         9hUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749229620; x=1749834420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HYO+eGQfYOWOdEYORTE/WzWP16MU86w5cp2kZkMSGJI=;
        b=LZI0GK6d8KpP3CaMHWXDes5YEKSVZv9d3CduPw18CCJy/Y+Irweu1hEsXuWt4PHyFi
         JSHNdS/VhWSTQB+nQC1xirJqQ58U5II+mViiMgD8kPZ4R7bzhEdrsRIahjLn05XRI4ru
         MrnnVSqPMLXsGc5wtBLIrI9da0SXP+xkUx1kLXunRyWos8TO/seVHR62QIUhqLPMddOv
         xXXjEL/1WHAxN+sjvgNvRuMZBVW20O+/x7qXbgUeEChZ762HLWIDP1jFe7jvWhc4oooo
         +NRZL6lmsBMJL3MTWL6DvhWHuKT/LLUO2UUuipp8y7mpGmpezBU7lCE4TF3orChm25IT
         hmhA==
X-Forwarded-Encrypted: i=1; AJvYcCUV8wweoAnOvI3k57QRmmCgLh5p7PLET8lBLBjUUOFVx3zPvexQt3L4OARWdC4DWREH7fMz7QxgCAW6SEcd@vger.kernel.org, AJvYcCVtbCS8O+ksIWoD8xBn7ToKS5NNrNhGHZNxISJrJuViDvQcdJwzk7QmSIK6NPMhIm5d2agRbjN7cVBg@vger.kernel.org, AJvYcCW1GD4wSZ9VvbSTrUvcIhpzytS7fn198+1ffNSSRD5j1OGcbmiE8aUDWzTL6Y7L37N0OyipAewYty3ogDvYb2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN4x4dpW8kWRd+oJ/yX01FKWLVpoxvNYNMu1i85ISy9AVgxFtv
	6oDQmBsC+b6K9Yeg7X/SCMCIJcTF36dQ27LIzg8CdYG5XGbNrcoSikYc
X-Gm-Gg: ASbGncsglRfOjcWAawilJSNObsO8GESgoud4vxIxAfcFvClS65w8gSZOVuQr7HA8H2S
	axx1rirYH1I406ELrJ9MRQR0NkklA/Z9LYJqxPJedjmiUjXOQAhZntyHY8mQX2Jddznvu/Romwr
	dLDkt0STe+ecnGHyrixEx2u5Rc/3tw7JWVzTLDG8vOzeSq3uEKTjGWs7Ww52pCpl+TW2nhUyXQI
	rAiwGDD95bwvn51YzlDtyxvk4vBb4pwlCJf90d/EAD+uxqRIT7926LZMT9KmIPJGdQVdPmfINiy
	U9k2DcEcnstbDkmzG4BXpQnEpn4AIb8r753xL+Ecry4gGkj45YpRN54686yHr7PdU/JMzNZBZso
	v4yqoYAIRbyP1tpFd+GiUZuM=
X-Google-Smtp-Source: AGHT+IFSmXlCB/lezpaS2SYphJkVZyW5SY5HLRtTzO6PHhKNjwdwIfDncmWXtOXDNG4/yqMyZLmA5A==
X-Received: by 2002:a05:600c:34d2:b0:450:c20d:64c3 with SMTP id 5b1f17b1804b1-4520137cba3mr49852725e9.18.1749229619393;
        Fri, 06 Jun 2025 10:06:59 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.. ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4526e163447sm27671315e9.17.2025.06.06.10.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 10:06:59 -0700 (PDT)
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
Subject: [PATCH v3 1/4] rust: acpi: add `acpi::DeviceId` abstraction
Date: Fri,  6 Jun 2025 18:06:41 +0100
Message-ID: <20250606170641.3881401-1-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250606170341.3880941-1-igor.korotin.linux@gmail.com>
References: <20250606170341.3880941-1-igor.korotin.linux@gmail.com>
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
index 731f09909a92..44ae63e4b3b8 100644
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
index de07aadd1ff5..3c17e60e3093 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -37,6 +37,7 @@
 
 pub use ffi;
 
+pub mod acpi;
 pub mod alloc;
 #[cfg(CONFIG_BLOCK)]
 pub mod block;
-- 
2.43.0


