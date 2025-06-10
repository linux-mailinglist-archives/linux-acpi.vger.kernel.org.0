Return-Path: <linux-acpi+bounces-14268-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D303AD3C42
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 17:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368D218867EE
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 15:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBC22367B9;
	Tue, 10 Jun 2025 15:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkzSHTZR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2640A235358;
	Tue, 10 Jun 2025 15:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568066; cv=none; b=HtdG/vVxX7N5fVBg0p+iWSYtlYY44nlB/yaKsfX3oXnWuEMO/9CfMdtlZkeU07NXbPo/F6UGVqjpBusAL6PHRIVrj6WJlSQCtzMTMof1ZQ9BcvoARbAQWJWqeEyLNof6nDUiDot1WWgT9W2DYAw761gGhzp6KYC0Os0HCItQC7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568066; c=relaxed/simple;
	bh=1UZ55Ek45CKKfVDM95IkqYsS3tOP2/4OhvhnJ6C/s6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfpMM7rl5yblOmpQntH8thaszVU3U5qVX4W+9pBZj5zAqWJarcO1Q+NpcuypONky1HYgSySjPAfnoBKYhA9HpgzGh2xcNi1736vrI1VpOnR2fwTERfZ0wLkcS+/FAHUSc2gweEtYzFtHOj7dsyhsfcP1WxZE91HRq9dTIKw0dbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkzSHTZR; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-442f4a3a4d6so30256305e9.0;
        Tue, 10 Jun 2025 08:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749568062; x=1750172862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LOqx5US9U5c9V8qjyLq6lu8HPn0k7QBwpGRoaY52N0=;
        b=NkzSHTZRWhjZf5CJuEy13B9jav7n7hW6qy8rDQfE9CUjX+KaoxK0NetmpakZ+GyjqW
         4TGhDzHioZ54fjzPMWCGxXV2RDkGCrzrCeHghDBIYbMNN0olCvv+xVsDOy8dsRzMvSpw
         PbsUyTm5lTs2r2Wthqg732zcAg1cR1pC5zOfdWlc2AG28dFouFze68l/z0UvtjgX8X6y
         LnDJMhhtLhGeLmr3kjUKC3VKftO1E1/dTOiE4UQSB9eDnOUXcWeK/luUzRAv5XYG5tFD
         SXQb/pqMdyrPxz04e/Io5SzkNW7vpDtjUWP6NiMXAd4ua8cPMC4e+yktgXqNhd1ewJO6
         copw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749568062; x=1750172862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8LOqx5US9U5c9V8qjyLq6lu8HPn0k7QBwpGRoaY52N0=;
        b=HzWqq/H79f7N73f/5yaNC+D+S9AbVWJgdOKMDq8h7DxuIqSq/Sj+Lp8c7dw2AroPKl
         iEu0mHQfQ3ZZeUOnwFCUqhxRxzrvqtRrPwM9un0BqbqgT9+qWyhFTWqzIMeVF3T+6jtr
         jmXU+OGq3SS1StllqgTnwCwCJ9TwOKAlGCNy6AdFRZa4N78JwftCVcALZj+sVrOTy/3h
         FKDFZf7TbCHvYFK1q3xlIMcrBOucnhWuG9RN1skYuEOM7XSV/gGUVytm2+xYTi3tBkZU
         l/gKuVfaOKxKxPrQZ2QhImi2226aIg9cOnHkWg+WZXaOR9HjL4ot8NAh946NY7rAVDaC
         ORhw==
X-Forwarded-Encrypted: i=1; AJvYcCUsa+EhuqTJrqMbaGtX1133TFmyyzEqN343+r0r1h4Kny7LeCXgSrrr4QUsGQsVwbeKeDrXfVbl+bPq@vger.kernel.org, AJvYcCUuogI2pEygJjss/6MCaKldvYVp7SO+spqk3yGWYfuBJFgiKoddLw+UeKh0dteTCBzEwlmMYJrsnAHKBv0u@vger.kernel.org, AJvYcCXUX+eK4RG7oI5WjPPsTVIdlQpTn5uKlmG5TkWdFzV5MnyVKZMkaKjCnTmlQIhD3oqXR0d1rIfm5p3csR6607U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuPK9GnR/X+Y5GzqyUyV4O4pqEsAKt+5AQbKUG0+WNBYUcRla3
	6wB+pbIgLSEja+p6ddwCtggLnLpaicIsK1Bkq+yZHXukae9Y09pVFLFD
X-Gm-Gg: ASbGncuE8pQ9ag6MzTR+TGDNcLd/wumzdt1pCiAUCLtZps7uHF6wdh3OUlkD/3g4TJ5
	pU9rAmTbVU3WmzXIBVplKUJmHd/EHeGyRsNmDxrKjnyyauTSkh3QlsICd6K2RS/1FGBtlHvDk6z
	M2Pwhi7ut9JMtxj9vRpEaVevrXgxp60c1PKQzW64dG/Hu5VnHENpFuoIVDKjlFZDqbxZCa9fw37
	BFye38mnk/JNUa6r/tqeyOxuVO1Vq2gjs4B+CvjUbNGpp5PDNJM2+145djr1rpPz6UxDgHyMx+6
	nEkivXq7gm1yL/tOD29mImK+RZHyqOA3RlDYbVef/UVs5jqhk3FM8s20mvLtko8ab+R89gvv8Kw
	m2biSjlADfYOXzHZFMSoLcj5C6mfkKMmCDIm9
X-Google-Smtp-Source: AGHT+IG88wvODRgnzvR0fqTOUToaq98Ang4Ryxq55QbU6vKi2A1qEOPZBUVkvodd8v2792RM5XHsRQ==
X-Received: by 2002:a05:600c:a09:b0:43c:f3e1:a729 with SMTP id 5b1f17b1804b1-4531cfc489bmr35963205e9.12.1749568061850;
        Tue, 10 Jun 2025 08:07:41 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53244f516sm12473356f8f.74.2025.06.10.08.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 08:07:41 -0700 (PDT)
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
Subject: [PATCH v4 3/5] rust: driver: Consolidate `Adapter` methods using `#[cfg]`
Date: Tue, 10 Jun 2025 16:05:38 +0100
Message-ID: <20250610150538.238007-1-igor.korotin.linux@gmail.com>
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

Refactor the `acpi_id_info` and `of_id_info` methods in the `Adapter` trait
to reduce duplication. Previously, each method had two versions selected
via `#[cfg(...)]` and `#[cfg(not(...))]`. This change merges them into a
single method per case by using `#[cfg]` blocks within the method bodies.

Suggested-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
---
 rust/kernel/driver.rs | 76 +++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index 638f1d270af8..805f61bd4a50 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -147,30 +147,30 @@ pub trait Adapter {
     /// Returns the driver's private data from the matching entry in the [`acpi::IdTable`], if any.
     ///
     /// If this returns `None`, it means there is no match with an entry in the [`acpi::IdTable`].
-    #[cfg(CONFIG_ACPI)]
     fn acpi_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
-        let table = Self::acpi_id_table()?;
+        #[cfg(not(CONFIG_ACPI))] {
+            let _ = dev;
+            return None;
+        }
 
-        // SAFETY:
-        // - `table` has static lifetime, hence it's valid for read,
-        // - `dev` is guaranteed to be valid while it's alive, and so is `pdev.as_ref().as_raw()`.
-        let raw_id = unsafe { bindings::acpi_match_device(table.as_ptr(), dev.as_raw()) };
+        #[cfg(CONFIG_ACPI)] {
+            let table = Self::acpi_id_table()?;
 
-        if raw_id.is_null() {
-            None
-        } else {
-            // SAFETY: `DeviceId` is a `#[repr(transparent)` wrapper of `struct of_device_id` and
-            // does not add additional invariants, so it's safe to transmute.
-            let id = unsafe { &*raw_id.cast::<acpi::DeviceId>() };
+            // SAFETY:
+            // - `table` has static lifetime, hence it's valid for read,
+            // - `dev` is guaranteed to be valid while it's alive, and so is `pdev.as_ref().as_raw()`.
+            let raw_id = unsafe { bindings::acpi_match_device(table.as_ptr(), dev.as_raw()) };
 
-            Some(table.info(<acpi::DeviceId as crate::device_id::RawDeviceId>::index(id)))
-        }
-    }
+            if raw_id.is_null() {
+                None
+            } else {
+                // SAFETY: `DeviceId` is a `#[repr(transparent)` wrapper of `struct of_device_id` and
+                // does not add additional invariants, so it's safe to transmute.
+                let id = unsafe { &*raw_id.cast::<acpi::DeviceId>() };
 
-    #[cfg(not(CONFIG_ACPI))]
-    #[allow(missing_docs)]
-    fn acpi_id_info(_dev: &device::Device) -> Option<&'static Self::IdInfo> {
-        None
+                Some(table.info(<acpi::DeviceId as crate::device_id::RawDeviceId>::index(id)))
+            }
+        }
     }
 
     /// The [`of::IdTable`] of the corresponding driver.
@@ -179,30 +179,30 @@ fn acpi_id_info(_dev: &device::Device) -> Option<&'static Self::IdInfo> {
     /// Returns the driver's private data from the matching entry in the [`of::IdTable`], if any.
     ///
     /// If this returns `None`, it means there is no match with an entry in the [`of::IdTable`].
-    #[cfg(CONFIG_OF)]
     fn of_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
-        let table = Self::of_id_table()?;
+        #[cfg(not(CONFIG_OF))] {
+            let _ = dev;
+            return None;
+        }
 
-        // SAFETY:
-        // - `table` has static lifetime, hence it's valid for read,
-        // - `dev` is guaranteed to be valid while it's alive, and so is `pdev.as_ref().as_raw()`.
-        let raw_id = unsafe { bindings::of_match_device(table.as_ptr(), dev.as_raw()) };
+        #[cfg(CONFIG_OF)] {
+            let table = Self::of_id_table()?;
 
-        if raw_id.is_null() {
-            None
-        } else {
-            // SAFETY: `DeviceId` is a `#[repr(transparent)` wrapper of `struct of_device_id` and
-            // does not add additional invariants, so it's safe to transmute.
-            let id = unsafe { &*raw_id.cast::<of::DeviceId>() };
+            // SAFETY:
+            // - `table` has static lifetime, hence it's valid for read,
+            // - `dev` is guaranteed to be valid while it's alive, and so is `pdev.as_ref().as_raw()`.
+            let raw_id = unsafe { bindings::of_match_device(table.as_ptr(), dev.as_raw()) };
 
-            Some(table.info(<of::DeviceId as crate::device_id::RawDeviceId>::index(id)))
-        }
-    }
+            if raw_id.is_null() {
+                None
+            } else {
+                // SAFETY: `DeviceId` is a `#[repr(transparent)` wrapper of `struct of_device_id` and
+                // does not add additional invariants, so it's safe to transmute.
+                let id = unsafe { &*raw_id.cast::<of::DeviceId>() };
 
-    #[cfg(not(CONFIG_OF))]
-    #[allow(missing_docs)]
-    fn of_id_info(_dev: &device::Device) -> Option<&'static Self::IdInfo> {
-        None
+                Some(table.info(<of::DeviceId as crate::device_id::RawDeviceId>::index(id)))
+            }
+        }
     }
 
     /// Returns the driver's private data from the matching entry of any of the ID tables, if any.
-- 
2.43.0


