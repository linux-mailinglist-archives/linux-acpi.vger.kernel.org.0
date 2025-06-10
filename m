Return-Path: <linux-acpi+bounces-14266-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE9CAD3C31
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 17:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4AA51894401
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 15:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C91239E7F;
	Tue, 10 Jun 2025 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddxdvx+G"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AC4239085;
	Tue, 10 Jun 2025 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749567795; cv=none; b=nhEggROgr+GNy3e6z8F+dehZ9i5RQTN7IiGD1xZZtYo7osl15Hx6PppmOPzKFcfhlhlaNQdiq2/MA2a9gya4RoZVRtj/WP6WIMhHdQKag33Uta/EDpPloR6OpTMwQOWkgd8RShsYsSJqi1TqoHjR3i798uFGY5N92bOUcodmSak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749567795; c=relaxed/simple;
	bh=fLM1J7jVqqiZf/ld7d1JFGfRWVz+teNjK6y084/tbPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jol19xdslwFNbi0pe7miihJGHBB/3c80Kd0fqqx1AcirLTjrohoRckvyQmtjLp2df0uzu+DrCko1Fkbv9yaFZwh9XjVGC7i6VWQvgNIXgRTPnpek2a6Ki5S+v+SJx75UUFXxDa3kOb59DrxwxiOmRvvwy5/ZrwyMFHh9QEA6NiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddxdvx+G; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60727e46168so9597590a12.0;
        Tue, 10 Jun 2025 08:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749567792; x=1750172592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oudxA8JPC06HRjXurKEPIdr/6i2EGFIADSPFZLQo5s0=;
        b=ddxdvx+GmNN00bF+E1yjB4oBe/F8/At0+fE0nib9tgiiUZGlAIRj2XOiLyxyVVLMwZ
         emp51Nq7MF2hTzako4tsaHdZ0sWWefVOKcKBvfiSPiiGW+ZheqPCYcyj8NwZHEfafTPB
         yr2bRggDv9NmjfihYt7BI/hrFInLXjxzLnjVumo3zyrslUTJoS+kHMph6naNqcXya1z5
         R19EuBYobDQxxvHf3+X+QrXn7ZfMANzpTvxgR1nz7ticd3UHQT2BIzM7j7ez6HMDgiv8
         IEv+RmWBxoN30smexkoZU/D/JUQpURzUI/xTDScLQsPrFz49Fm89b4VADKCbJ1tb23Wu
         emXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749567792; x=1750172592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oudxA8JPC06HRjXurKEPIdr/6i2EGFIADSPFZLQo5s0=;
        b=Au/vaoCGIyXbXonrwdVwX8BaV4qtzpbRN9ZUNCoBne65zGD6LxHMYht5opqHyMGO/f
         D6NE4CFEHYhCOb3W5rYHZt5CI6OyW3oRuHSogvHPHOoIUBPYsTXyiU1GFUZiFjQd3q15
         aEbZLhxWRTKnnliJt5lUDVxv8yRgPu57PZ6pAbaXWnBz5s9IgLaKNzDG/VWPRx6FbJGY
         ggEbw2bk7uOlsaDUPSu7PLSMB7paJGUt7e/fUuMl23LtBLsTXPvdZcSzyIRn3KbNRgKC
         Bn4TELLsf+qeHDTNoSBDSTBBMG8AyrZepQDYzY8qf6/ztw2Hi/XxSFsmT51czjN6SewS
         e9fA==
X-Forwarded-Encrypted: i=1; AJvYcCUb0msEYGc2XTFPbwegV6mxbnIQ38Kut2TwMcZfth08WFeKdiglq5AMRj48m8G+G7cz4fpcQdHnOr+rs1Ap@vger.kernel.org, AJvYcCVwsYyP0nQC4E1XHcReFoQnpE77hAm290MdLk+MzcOu1+nmmOLMMvWGsE9CuveJjM8LquEb/1ozwh8J@vger.kernel.org, AJvYcCXmCP67QSg6uXA+zKPB+h5Z0pXXsk4fDQKvvi4HUXZTyuR7EA59QjgGjADwD6S+/ADc5PBGp62886yZGrw2Tlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YweuDrF6TdutJ1nTEiMJ63cud80ij4OfbHH02XbPMzBarqNDVp1
	EprlFva1HtnVzUbOVwZQ3lRNdRCiVrITUPkrM6RSrtRTsAM/bA+xnLnZyOoVj4SKGE4=
X-Gm-Gg: ASbGncvrnuSAgCoBN95Z42s6YS9v/5VJfs9JUYLVeJx9ligtOgcWvNMLknR8h2Ut2KS
	3HwcDq4jxZWvYCNwhX4RhykRR1McXYEIvVulhub0HeZmw1gUi86rJrsRuO1o/5LbtknGI3VHxLB
	84/tFbAt6bj3YIbH1hlpva1tMdfkc80AX60Rl5twFW3RT37/lcrGsdaT9/HRPGO6PIwePSZ7iQ6
	FwRfZs4fiAiCjaQx/tREPqS1LeOwzlConm8zYoTu9q+D+daCmbZ8if4JOlIrAYoIzikiqd6saSS
	0ZMzmhED78Z3D/LiAQYx5TOTQFjH/W4sQZ4S4zrb4pxBEs2OJpn1HiiLtrkNZ5/+HuplErhuBWi
	rl6C4F8UUfrbNCwuHUB29ckgt+snqw1xqMF+G
X-Google-Smtp-Source: AGHT+IH0+AZPTlciHmkGllD/oma4zGiZ8/jDRd0hiXsfTZ/a0TRwnby3WB2wlYT/JkgeoZpgsuc5Fw==
X-Received: by 2002:a05:6000:4205:b0:3a4:c75c:efd5 with SMTP id ffacd0b85a97d-3a5319b4d6bmr15095416f8f.46.1749567781536;
        Tue, 10 Jun 2025 08:03:01 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53244e0e3sm12721205f8f.68.2025.06.10.08.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 08:03:00 -0700 (PDT)
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
Subject: [PATCH v4 1/5] rust: acpi: add `acpi::DeviceId` abstraction
Date: Tue, 10 Jun 2025 16:00:51 +0100
Message-ID: <20250610150051.237201-1-igor.korotin.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250610145234.235005-1-igor.korotin.linux@gmail.com>
References: <20250610145234.235005-1-igor.korotin.linux@gmail.com>
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


