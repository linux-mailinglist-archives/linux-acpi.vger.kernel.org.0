Return-Path: <linux-acpi+bounces-14322-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1659AAD8D6A
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 15:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DA017A8CED
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 13:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AC81A5BBD;
	Fri, 13 Jun 2025 13:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7v/a5nX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0008519ABC3;
	Fri, 13 Jun 2025 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749822179; cv=none; b=PvYs3jBta4aStgU5lVD8IWKX1ugSGp68uVBfh0amtxNCw39jlqT/OeZeAaEZmA/ffCpJ4i3YGDL2lmfwgpqiRIU+2vqOIq4KR+puo+ek334ousTsBK0S1VEjumD4yxE1NOE6nJ/krt6gSQuxTlYciMw12G1eZgpQYhzk+docuUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749822179; c=relaxed/simple;
	bh=kdiPdMh5+sRzNgtYRKj/S0sAtUte5v+zpvWVg0DO3wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=agahtGzEi54B5F9LWYM2obbjelhTKsP4y6E4jM7+vclUwcRulwghAyYSd33cOTL+zbF9Ze2kCxVJQTxyD+eQkrtOryTwMWREnv989Cp1FVqHtfp0Jjss8tFA+DtiBqzszymrN1jqpr83SAzuJWesPoOKTy0Kd2bpgMTROXC2qRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7v/a5nX; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so1321383f8f.1;
        Fri, 13 Jun 2025 06:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749822176; x=1750426976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5X6IDTVHTHpEsUSABa7MSKK8TKkDRNQdpFJlmd5FHY=;
        b=R7v/a5nXcZ1hPE6Teu5COQktZBWtmrg/3WLFDI76xAH+IXsPChYDLZn8tiuJRBYTz9
         EKuCdOqmJ61pXl42KLC1KUai109P75Ilxhp54/U7+jOVVKsnfp4oUTLeaRD/N+xZAt5t
         rKi4yi1V0WyIm45f3gUCPw//XcteD2qyJid6JdwigcwwFeGjNsiIyfyN3skSEVSWrQWO
         o7Nn9UlUzTxosVxpSmcCtFAv39dpIblLW22vvw3Bh+f3pP3QdfmyLs/rimoR6FuoACMx
         VAupx4hNzyhcAfOaN1vflNlD35cN6RRsCpIsTh+vexXkb/XhlhnSO8KvQkrU5OzMfJ2F
         864g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749822176; x=1750426976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/5X6IDTVHTHpEsUSABa7MSKK8TKkDRNQdpFJlmd5FHY=;
        b=jgJg5xApEVd5GObHb0rcdjuNhkgut3i9e1Ej++JJuX/P0Ag8f48y0WAaoyMGWVqWkY
         C6VEz6fvzv2fQ+YrLn0JaVBFjnGICc2Xx/E8wKKVGea2wUmFnXD4zSLEEs5IfJtk3chV
         9VGAm//GHQ+IMHo6owS7/+cC0IVTDISXTZi8oil9BvaWc+wU907mEi5ThIUtTxlKLdPH
         NH6MKomyzYMmUdMz3XszwC3bSFTnZQj1DVBIckn+QPQvdmbAXVzQiCNZKYYCcL9zsfsd
         OP9yh6CDIc0j3Wkj611MlrJfC8gghsQqk8zZG7iZ+3L7M1Qwi/1Phda0LJHJf4xjbYZW
         dCqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0gFAbaeid7/3HggGnefgYoBGxR0eKF4+uZNJSfMTFEq6+zGoUBtsMmg2ZKBoGirbZ7JYIhvnNuK6B@vger.kernel.org, AJvYcCVpRdUF+JZa4zIAGjUH9wVugoQWQY4Bwi9GeIMHxmK82W6cT6c8Y1KmJ6HUFuMbMRr5AsKoB+YMvvcQqjp9@vger.kernel.org, AJvYcCXa5awEUU15FKTB+w9AFPT33AFQcsW3VH9EZ0HyaNKHvRkTZR+1Y0L+ugE+Zc0c3EyjmLSwWFcbmRG1NzoB6l8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlc7uWb4F+kIHEseMR4wm1uJ0lYGHOw7lnVsF3P8cCOZGnYKie
	20aOHtbb2F0lheUYhv2nlw/XNQWYFnoQkTx8vTf3lmkxF00OEtwi+x6S
X-Gm-Gg: ASbGnct+brE7dCcVj5rYzSqwu4mTmfjeB6bEtLyxy1VOj+9iL7GOXRD/Z6f4u9QHMGt
	LoxTYqdUxYqZ78/nN4sQa1YIK64PB+OYDCm55fEnuahwNQHEvLh7A9IhWnGEcvs0gvBrZtQzauG
	5YdWbE8Pqs2JxZPixIn3Kg7LCL2xySfcgkHBpBdbg9eANJEBHg04K9slDsCY0rfi7DddcjqaE5a
	3uBmlZMtnO7QYbX+C/NxgRFqP3mWP4Ehqy41gbwIJ8N/YCYdU+qu0kc1kZq86AdoDXbt/U6mwF8
	tLtwtHThyXteKd+zInqBJPo9Me8/tllOLlSmxZ1J7///oN77kzOX6bJWtkPQjN6F0nk0/dVS88l
	y8nLPRDSueRcs/tQhm6JMp1ASpa+zBLeqO+B+Gg8=
X-Google-Smtp-Source: AGHT+IErpZfMNcD4uCLvcP/jWyCe4iFHGIQImMSC9pURAYXJyAQlvgrclcjpnEZwyzObV9itosVjVQ==
X-Received: by 2002:a5d:584c:0:b0:3a4:e5ea:1ac0 with SMTP id ffacd0b85a97d-3a5686e3f89mr3290245f8f.5.1749822175949;
        Fri, 13 Jun 2025 06:42:55 -0700 (PDT)
Received: from igor-korotin-Precision-Tower-3620.airspan.com ([188.39.32.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4531febf905sm93542555e9.0.2025.06.13.06.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 06:42:55 -0700 (PDT)
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
Subject: [PATCH v6 2/6] rust: driver: Consolidate `Adapter::of_id_info` methods using `#[cfg]`
Date: Fri, 13 Jun 2025 14:40:53 +0100
Message-ID: <20250613134053.1230903-1-igor.korotin.linux@gmail.com>
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


