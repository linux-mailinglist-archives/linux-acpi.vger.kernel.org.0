Return-Path: <linux-acpi+bounces-14439-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD811ADE8B7
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 12:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D346C3B0002
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Jun 2025 10:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7823E2DF3CE;
	Wed, 18 Jun 2025 10:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWBZKlpA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD472857CF;
	Wed, 18 Jun 2025 10:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750241988; cv=none; b=RL7gq/Lt0iwxcmkWiGVH4JHxyc9CsVWMmm9WW0ogduJpfBwaR2+AyJyZ6axx7rZx1jUHHeoFEsLC4prar0WD3sv0p+GjhCgyzPAD+Jl7APT4Ls3UGDPM6jxzSSMAi312fvuIHtk6l826fJb0wc1ZG2KMcVZfX2h85lbRjmomuaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750241988; c=relaxed/simple;
	bh=kdiPdMh5+sRzNgtYRKj/S0sAtUte5v+zpvWVg0DO3wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FQfo6ZSMJJ+QfcqCHKwwcIcNLM4rnwFDNE1KEo8OwW+uzM8WXMrsEypCT1P3ooJfNVrUBmEfz7eu/5BpVtwhJzlSlQjFWqzY/dzPXrJPRGTJWguPjWm/naPpUPC94zRyEBCh/FnGqnkOzPgLsUE5IBl8W5oTtzDHaaZnXtLkIX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWBZKlpA; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a50fc7ac4dso3953114f8f.0;
        Wed, 18 Jun 2025 03:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750241985; x=1750846785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5X6IDTVHTHpEsUSABa7MSKK8TKkDRNQdpFJlmd5FHY=;
        b=cWBZKlpA7WK6bTpiP2mJGrl1sFGOD3VQZYQZuYsIV850lUFdRZpyVBfRb3p2ZQ7Utg
         dIPVncWiZUm8CR6Otyo0QKKwGI9AauDs2r3G0vkAaCGrYilTB9Okk5Am9tPHUVzXCepc
         klTIGkmcb353yRYunszFMHvrkF9MPkiahDfWGwQs+BZWDmJFlhdtKeX0GiJFkc8keKQH
         LU27u4Ve9xJDcVoS9tzvky3pj1l0p+IPIVxxcCtpUSzJjTUPJ/yFLvG0WE8B2WFY93Ba
         3JEyseLtY6IU3DkBKx4QAc7yp89zdz/7IuaVJVR+pCFIm5NGkn8zNeY3WZ1ET+tvfe3g
         DhgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750241985; x=1750846785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/5X6IDTVHTHpEsUSABa7MSKK8TKkDRNQdpFJlmd5FHY=;
        b=MVR0GhKBcWJjQ7+A0qPKIqiLk2O0IgS03Tv+Es4HAiS2vL2S4vrOedcdeL9MVxSf5I
         gDa3gZwO8gFdup1v15nNBMo0U20Raq8Pk+C6Uoq9+nTKxnluAse5TPObZbzmiPvF8kV+
         dHC+Bti8XTmaUQHOkDrE7DIq1v9OuaL3feYBPk7IxqORmROnwtjsx9oBYWeuDvNOvuAm
         ZgNNY5ym5d8YA69ZkJa8zMXXVs90r0Jf27GCG7bA1zO/OhGvwptbYc4cbAMsUzTrAKVK
         yNOLfr9nAaFoBg+EI1BDPsa5+oVGtLUNQ8LQTqqp2AMqmhd+QXjA5hfExZd+zai5agYf
         MKVw==
X-Forwarded-Encrypted: i=1; AJvYcCUTUHMeaD2v2sCTADS+ZN4q7+obwAVI/8HQnQhSB6KUrodQwsayESPFwqpeJ8sGF/LShu28F5z77tJvnVkk@vger.kernel.org, AJvYcCUdIHURHQnKTBHktvdas5GOOEHX1F6ExBvQh8JFdAaKZpjac3leSUjGruzGGEogOKMpAn6m4DOAQLKuzTefHss=@vger.kernel.org, AJvYcCXEEd2qp3i1P5kPyTyQp5g+CYxmrcivkKIsEpWqvuOmNJrliPiAlZ19p7fns/pdgE2T+DY5e9MxLeCk@vger.kernel.org
X-Gm-Message-State: AOJu0YwYVz2OTXySsd3P/zCP1zakNPcq+7PhS3o3Ym6HOwaM4/YXbNKO
	khUzMglhLKoq61pZ5CAka6gITSSSPF4py7QAMnOeKkNzmI2UpcRiF4ut
X-Gm-Gg: ASbGnctwyFsgfHB2XBUwRO549gfHfd9wZnq/zEOTWp/otuccC4SVZuyzeXjkV5LGE7y
	3zUCPx6bcQdISGE96+u8UB5hJxCxUKeBJAvXNfyGtvU4N2r51qLf+6E5/3IxygKze9hHd9n+AQ3
	sdKw32wFh2E1wmRYGMRF/r9B0SLG+RNo4U+7SH6oVVAEqgWTO/0O/uKZHC8dKjmK6elJD6gkR3Q
	4HwisRNr/UV/5+bFoLIJ/NkXOOjTC4V5+SbvMOsloaxbOLySzFhNeoMCi7/lSoliGOJObV4xSAs
	uRNi6UsjQUe11GF00pLIp9YPD6AJpglgomIfAl+ocf/YzQihLNkkk92yc1BDa1jg4QN+Ga8C9tf
	1KuImZohbTckiyBSi3nsygydij6qdiiqnouRE
X-Google-Smtp-Source: AGHT+IHB+U5DjgKYH28LDRAxh/14b9t99lBDOZmzIa0ejbzDXmc50b8UhG5Om/kD1z7jYZvFiiye4g==
X-Received: by 2002:a05:6000:4b18:b0:3a4:dcfb:3118 with SMTP id ffacd0b85a97d-3a57236795cmr14608027f8f.10.1750241984501;
        Wed, 18 Jun 2025 03:19:44 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a68b0esm16274027f8f.29.2025.06.18.03.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 03:19:44 -0700 (PDT)
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
Subject: [PATCH v7 5/9] rust: driver: Consolidate `Adapter::of_id_info` methods using `#[cfg]`
Date: Wed, 18 Jun 2025 11:17:42 +0100
Message-ID: <20250618101742.3048622-1-igor.korotin.linux@gmail.com>
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

Refactor the `of_id_info` methods in the `Adapter` trait to reduce
duplication. Previously, the method had two versions selected
via `#[cfg(...)]` and `#[cfg(not(...))]`. This change merges them into a
single method by using `#[cfg]` blocks within the method body.

Suggested-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Igor Korotin <igor.korotin.linux@gmail.com>
---
 rust/kernel/driver.rs | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index ec9166cedfa7..cb62b75a0c0e 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -147,30 +147,32 @@ pub trait Adapter {
     /// Returns the driver's private data from the matching entry in the [`of::IdTable`], if any.
     ///
     /// If this returns `None`, it means there is no match with an entry in the [`of::IdTable`].
-    #[cfg(CONFIG_OF)]
     fn of_id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
-        let table = Self::of_id_table()?;
+        #[cfg(not(CONFIG_OF))]
+        {
+            let _ = dev;
+            return None;
+        }
 
-        // SAFETY:
-        // - `table` has static lifetime, hence it's valid for read,
-        // - `dev` is guaranteed to be valid while it's alive, and so is `pdev.as_ref().as_raw()`.
-        let raw_id = unsafe { bindings::of_match_device(table.as_ptr(), dev.as_raw()) };
+        #[cfg(CONFIG_OF)]
+        {
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


