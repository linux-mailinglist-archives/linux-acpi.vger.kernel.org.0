Return-Path: <linux-acpi+bounces-7593-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7199C952B11
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2024 11:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3C761C20FC5
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2024 09:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1B91BD4F9;
	Thu, 15 Aug 2024 08:30:38 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C4B177980;
	Thu, 15 Aug 2024 08:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723710638; cv=none; b=JMX6d7P19V+P0HeI1G2yWVGMnj6CRPuqE0ekbplk03bLej1NKtEaR4sHTxSzQwbYt5q11/Au1dr3Kpgdr5WK/XHYlS7ZVGodWShoUCjR1aYmcrsTvgytaOCIyZJq36EyXn5gEj0V5/qkChXRbkm6HOP8uH8WEVOR3SPXGXicFW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723710638; c=relaxed/simple;
	bh=ZDbEQnYH376ogFQyuTaYXdGy5SLbLU9ts6dCAXzOXoc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GeTMDkRY+PL9Czkt+jhpKLsb4KuR3khgmPpO0fRh3Y407Jgz+jdmX4wYY44LsBQZwj1rIUXPyKw19hv8VyX1IdC1XZcFvT2h+J+x2udqIA+1XTjSnKOrh/JhvwFVik3VEi6z6NDI2mjVe7+iOQc6/GyY+HoGbMK8EBiKUkaeZoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3B3B1713;
	Thu, 15 Aug 2024 01:31:02 -0700 (PDT)
Received: from e126645.nice.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F20753F6A8;
	Thu, 15 Aug 2024 01:30:31 -0700 (PDT)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Pierre Gondois <pierre.gondois@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Robert Moore <robert.moore@intel.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Danilo Krummrich <dakr@redhat.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Thomas Bertschinger <tahbertschinger@gmail.com>,
	linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	rust-for-linux@vger.kernel.org
Subject: [RFC PATCH 4/6] rust: cpufreq: Add methods to struct Cpufreq
Date: Thu, 15 Aug 2024 10:29:08 +0200
Message-Id: <20240815082916.1210110-5-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240815082916.1210110-1-pierre.gondois@arm.com>
References: <20240815082916.1210110-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following methods are added and seamlessly allow to get/set
the matching fields in the C definition of the `struct cpufreq`:
- set_min()
- set_max()
- set_cur()
- fast_switch_possible()
- set_fast_switch_possible()
- set_cpuinfo_min_freq()
- set_cpuinfo_max_freq()
- set_transition_delay_us()
- set_shared_type()

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 rust/kernel/cpufreq.rs | 53 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index b395694de6c4..588080724fbf 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -318,16 +318,34 @@ pub fn min(&self) -> u32 {
         self.as_ref().min
     }
 
+    /// Set the minimum frequency for a cpufreq policy.
+    pub fn set_min(&mut self, min: u32) -> &mut Self {
+        self.as_mut_ref().min = min;
+        self
+    }
+
     /// Returns the maximum frequency for a cpufreq policy.
     pub fn max(&self) -> u32 {
         self.as_ref().max
     }
 
+    /// Set the maximum frequency for a cpufreq policy.
+    pub fn set_max(&mut self, max: u32) -> &mut Self {
+        self.as_mut_ref().max = max;
+        self
+    }
+
     /// Returns the current frequency for a cpufreq policy.
     pub fn cur(&self) -> u32 {
         self.as_ref().cur
     }
 
+    /// Set the current frequency for a cpufreq policy.
+    pub fn set_cur(&mut self, cur: u32) -> &mut Self {
+        self.as_mut_ref().cur = cur;
+        self
+    }
+
     /// Sets the suspend frequency for a cpufreq policy.
     pub fn set_suspend_freq(&mut self, freq: u32) -> &mut Self {
         self.as_mut_ref().suspend_freq = freq;
@@ -378,12 +396,47 @@ pub fn set_dvfs_possible_from_any_cpu(&mut self) -> &mut Self {
         self
     }
 
+    /// Get fast_switch_possible value.
+    pub fn fast_switch_possible(&self) -> bool {
+        self.as_ref().fast_switch_possible
+    }
+
+    /// Enable/disable fast frequency switching.
+    pub fn set_fast_switch_possible(&mut self, val: bool) -> &mut Self {
+        self.as_mut_ref().fast_switch_possible = val;
+        self
+    }
+
     /// Sets transition latency for a cpufreq policy.
     pub fn set_transition_latency(&mut self, latency: u32) -> &mut Self {
         self.as_mut_ref().cpuinfo.transition_latency = latency;
         self
     }
 
+    /// Set cpuinfo.min_freq.
+    pub fn set_cpuinfo_min_freq(&mut self, min_freq: u32) -> &mut Self {
+        self.as_mut_ref().cpuinfo.min_freq = min_freq;
+        self
+    }
+
+    /// Set cpuinfo.max_freq.
+    pub fn set_cpuinfo_max_freq(&mut self, max_freq: u32) -> &mut Self {
+        self.as_mut_ref().cpuinfo.max_freq = max_freq;
+        self
+    }
+
+    /// Set transition_delay_us, i.e. time between successive freq. change requests.
+    pub fn set_transition_delay_us(&mut self, transition_delay_us: u32) -> &mut Self {
+        self.as_mut_ref().transition_delay_us = transition_delay_us;
+        self
+    }
+
+    /// Set shared_type, how CPUs coordinate freq. requests (ACPI only).
+    pub fn set_shared_type(&mut self, shared_type: u32) -> &mut Self {
+        self.as_mut_ref().shared_type = shared_type;
+        self
+    }
+
     /// Returns the cpufreq table for a cpufreq policy. The cpufreq table is recreated in a
     /// light-weight manner from the raw pointer. The table in C code is not freed once this table
     /// is dropped.
-- 
2.25.1


