Return-Path: <linux-acpi+bounces-14205-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F90AD0737
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 19:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00FAC177D93
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 17:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA6228981C;
	Fri,  6 Jun 2025 17:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyfrSp+5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1831289E0B;
	Fri,  6 Jun 2025 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749229755; cv=none; b=Np5eiKTBBD71Sz0EO3VgowqMwrBhk1qE8JhHVpGBA/lcRq8/qSyzvJDFLldMrZPcWczaT3F66F3r83dMFNEJKei/XT6KM2+bYi3ZaXdjhcGuyYyuVkFBO0njfB6b6fU19QfZGI76VT8PJM0zIOd4a1V4pn1PVjhyPEqEvunbo3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749229755; c=relaxed/simple;
	bh=4B3tJHQ0zjlLU8gpzpYofkTTqkCGGUIIR2t43dYz79g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DjFs1suHOMDMjBqXbWLp1VtrOoUiRXaCMjXt55/CmKwtGFnzH6f/mtXjLzVxfgjMkcgo0iOJ6YLrvQP7T+BEZoCoBeh9RFNNzJ6WWD+6jDBZlrnlCrVTysm7Nav82TC1dpRHiwUocSH2vRVKLaNZweAH/03q0oSkaIrGXLjWhE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyfrSp+5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-442f9043f56so13029755e9.0;
        Fri, 06 Jun 2025 10:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749229752; x=1749834552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRzkq7o17FupNHBNiNCKXwDcUfVhYZAdS3v3dhCCeoM=;
        b=lyfrSp+59z8Isprymbr83A9x6FLEcpBPB/VU+97S/FMhPk6iLyOTTgjVLLYHUX6HO7
         w7TX3xREjLIRaNnoYz1SNT+OELJQcl0XPoS+UbMeM+24CXZ+XELu6xrpmV9BqGM7cHAj
         PgmjawvCSsIeak9Z+zuKHVsxJQ4spe+5NR2e/lKlaXjLVEOY7QOR1EpUJZCGQ9ql5gEm
         Gnx1JKMlJY0sTCpR6X7tfK04FI1kvqjCkxLji185amZiFkrGF1bBSe3JkB7x1nnr3w6k
         E00dSrfK8X0vwHNwDg5hncXLcPKDK7vF3NoCXtPwWMocCmQPxsF8AHa0ZSyaow3jXuMh
         G9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749229752; x=1749834552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IRzkq7o17FupNHBNiNCKXwDcUfVhYZAdS3v3dhCCeoM=;
        b=OJpKvd5rAB1P/lUVDJ75/hpN+ShCjUn0f2yhzz8Ez76rXCk2338AujrGmtfWW23pvu
         Awv/VkbNlOGgEUtFOKCZlEp7L6mMBgY91BmgE3Lcww6ucj++VGuVH3hpGqNSTGMAnnzr
         CzomBg8D1K/VNjJnXajy4ZElalCoTdHLgwQc0B34nn9CK0mcSbrThe+NzhiMR/CnpB8D
         xDoLeSZ80j7l7U1HsB8SQj/JRQV0Yu+m0H/FrUC29OQCVGY/GTvFg3DuJqoSfeJ3nnxY
         vjzy3ixyLhv35Nr87wCWEhvPIaHu1f3cJ7YzpqvFC0KVil5kmG1V8m/JggKIth4j5ygQ
         4kDg==
X-Forwarded-Encrypted: i=1; AJvYcCU6/WM4lkyr09/UMUbioy0Y7JCvpZLGnBOThowVjdUpsvtkLPh2qdYHZZKD4ya5+bupW81RLhTWyKef@vger.kernel.org, AJvYcCWYB9XFm9VsbUeT9wf4bzIJofiLgq54IshfYjtNFJWzSwy3HSHbI7/XAEyWTs4pQnwrOZz9ggV0DdhWVKLAnU8=@vger.kernel.org, AJvYcCXqXPXqCb9/xnxOKKafebNUrrGPXc9nz/rfbk+XSBScr1J9VfwVwj6EutMR74KYpc1XC2OfHwW/6e2zLNuS@vger.kernel.org
X-Gm-Message-State: AOJu0YxUz7wgIoFpz0VZf5WcYsaucTSEusjarPe6OsfKyR1gTZM5gcdW
	zh+ENJakH2wS/lJtWp34n6Uvy4e1zGHHqZxnEJ0FVJ+6/KJruJEa3RO2
X-Gm-Gg: ASbGncsrm5ndFwql+WOt/kffFMtDqB+NgJhgbDWJKAHQ1uPgA32D4e+L+iSxxI4VQKH
	qXEouz2l7TOQwK+E+stV8iQGpCjtDWBzijQSy1PMvAJ5Qg0A81Ucv83G2vSfJCTzsoFsWAOzXZw
	oD5ySyrdQfA+tZC1ghCto/jmVo2rQcQsSo1Rb5HZd+QVPbm6KJqftMe3lfsaMsDuQ69/Zrj1giU
	gLbW1Hek059JyvoLTfVe3j8tel89l7tFLaRX6Itu9mbxX6fxYg66Aid90Ymc8ChgBQXeKvLcPsB
	MRazWf5s17Gza1e5zejdOKAVrZLiJPzDELIQonSx/j58UadLupPwm1zkza4tX07wrhDwgWgSude
	GlY+Ro6ZrVZzMR8N8k6FQBbEeWw==
X-Google-Smtp-Source: AGHT+IHTVX90u5t14UbVPQj1KYfbmllG+s7EVZetpQpxVSlaRZkmTPsWtlNle7T6w+Ln3IzQs6Nodg==
X-Received: by 2002:a05:600c:8716:b0:442:f4a3:8c5c with SMTP id 5b1f17b1804b1-4520139a4b8mr53445835e9.10.1749229751747;
        Fri, 06 Jun 2025 10:09:11 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.. ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452ec06d9aesm24563515e9.15.2025.06.06.10.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 10:09:11 -0700 (PDT)
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
Subject: [PATCH v3 3/4] rust: platform: Add ACPI match table support to `Driver` trait
Date: Fri,  6 Jun 2025 18:09:05 +0100
Message-ID: <20250606170905.3881900-1-igor.korotin.linux@gmail.com>
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

Extend the `platform::Driver` trait to support ACPI device matching by
adding the `ACPI_ID_TABLE` constant.

This allows Rust platform drivers to define ACPI match tables alongside
their existing OF match tables.

These changes mirror the existing OF support and allow Rust platform
drivers to match devices based on ACPI identifiers.

To avoid breaking compilation, a stub ACPI match table definition is
added to the Rust sample platform driver. Functional support for ACPI
matching in the sample driver will be provided in a follow-up patch.

Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
---
 rust/kernel/platform.rs              | 14 ++++++++++++--
 samples/rust/rust_driver_platform.rs |  3 ++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index dd77934937d3..78010a613c54 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -38,12 +38,18 @@ unsafe fn register(
             None => core::ptr::null(),
         };
 
+        let acpi_table = match T::ACPI_ID_TABLE {
+            Some(table) => table.as_ptr(),
+            None => core::ptr::null(),
+        };
+
         // SAFETY: It's safe to set the fields of `struct platform_driver` on initialization.
         unsafe {
             (*pdrv.get()).driver.name = name.as_char_ptr();
             (*pdrv.get()).probe = Some(Self::probe_callback);
             (*pdrv.get()).remove = Some(Self::remove_callback);
             (*pdrv.get()).driver.of_match_table = of_table;
+            (*pdrv.get()).driver.acpi_match_table = acpi_table;
         }
 
         // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
@@ -97,7 +103,7 @@ fn of_id_table() -> Option<of::IdTable<Self::IdInfo>> {
     }
 
     fn acpi_id_table() -> Option<acpi::IdTable<Self::IdInfo>> {
-        None
+        T::ACPI_ID_TABLE
     }
 }
 
@@ -128,7 +134,7 @@ macro_rules! module_platform_driver {
 /// # Example
 ///
 ///```
-/// # use kernel::{bindings, c_str, device::Core, of, platform};
+/// # use kernel::{acpi, bindings, c_str, device::Core, of, platform};
 ///
 /// struct MyDriver;
 ///
@@ -144,6 +150,7 @@ macro_rules! module_platform_driver {
 /// impl platform::Driver for MyDriver {
 ///     type IdInfo = ();
 ///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
+///     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 ///
 ///     fn probe(
 ///         _pdev: &platform::Device<Core>,
@@ -164,6 +171,9 @@ pub trait Driver: Send {
     /// The table of OF device ids supported by the driver.
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>>;
 
+    /// The table of ACPI device ids supported by the driver.
+    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>>;
+
     /// Platform driver probe.
     ///
     /// Called when a new platform device is added or discovered.
diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
index 8b42b3cfb363..e3992e7a71e9 100644
--- a/samples/rust/rust_driver_platform.rs
+++ b/samples/rust/rust_driver_platform.rs
@@ -2,7 +2,7 @@
 
 //! Rust Platform driver sample.
 
-use kernel::{c_str, device::Core, of, platform, prelude::*, types::ARef};
+use kernel::{acpi, c_str, device::Core, of, platform, prelude::*, types::ARef};
 
 struct SampleDriver {
     pdev: ARef<platform::Device>,
@@ -20,6 +20,7 @@ struct SampleDriver {
 impl platform::Driver for SampleDriver {
     type IdInfo = Info;
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
+    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = None;
 
     fn probe(
         pdev: &platform::Device<Core>,
-- 
2.43.0


