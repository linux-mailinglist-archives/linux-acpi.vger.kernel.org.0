Return-Path: <linux-acpi+bounces-7595-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C642D952B1D
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2024 11:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25A9A1F227CB
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2024 09:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4A81C233D;
	Thu, 15 Aug 2024 08:31:07 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDA019D8BA;
	Thu, 15 Aug 2024 08:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723710667; cv=none; b=lWzJatIB2/8vRt/+vYoMUaX/HoB95BgImPA+Kc7cAuF0WhUt2rfQAYLzhUL45sSJXBBonJ85Mv66TcitzeWzcwgo7SE9QJ0l+du8FWLjgXA1UL1o66ZcbkUKSDIo7G5g3mw9EwW3it3MGKtYK+p17XBKyAe17INl3UBrD/3BHR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723710667; c=relaxed/simple;
	bh=yCf+HKHuM6f2qoMtzJkk0v/WG1j9KRG1+IxcRU8fI0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TZRVXnOk9jRpSkruxnboQ/j7BDFisBV0xfKSPNkPgptG5bPdgQdjrQvycyguK7ZesXbXa8vKqfObqHHdrRzAXh0SSLnVJsCOps6xhLn6b02njuYXIQ5GlJeJ9qZ25nYdd2AG+J85o3JxmU61mftxITpVC30R0n+G1Y7+m3/e8EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAEE81756;
	Thu, 15 Aug 2024 01:31:30 -0700 (PDT)
Received: from e126645.nice.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E6A7B3F6A8;
	Thu, 15 Aug 2024 01:30:59 -0700 (PDT)
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
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Thomas Bertschinger <tahbertschinger@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	rust-for-linux@vger.kernel.org
Subject: [RFC PATCH 6/6] rust: cpufreq: Add rust implementation of cppc_cpufreq driver
Date: Thu, 15 Aug 2024 10:29:10 +0200
Message-Id: <20240815082916.1210110-7-pierre.gondois@arm.com>
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

In an effort to add test/support the cpufreq framework in rust,
add a rust implementation of the cppc_cpufreq driver named:
`rcppc_cpufreq`.

This implementation doesn't support/implement:
- vendor specific workarounds
- Frequency Invariance Engine (FIE)
- artificial Energy Model (EM)
- (struct cpufreq_driver).attr field
- QoS requests

Basic support is provided to get/set the frequency on a platform
implementing the CPPC section of the ACPI spec.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/cpufreq/Kconfig          |  16 ++
 drivers/cpufreq/Makefile         |   1 +
 drivers/cpufreq/rcppc_cpufreq.rs | 333 +++++++++++++++++++++++++++++++
 3 files changed, 350 insertions(+)
 create mode 100644 drivers/cpufreq/rcppc_cpufreq.rs

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index eb9359bd3c5c..57130d0789b0 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -343,4 +343,20 @@ config ACPI_CPPC_CPUFREQ_FIE
 
 	  If in doubt, say N.
 
+config ACPI_CPPC_CPUFREQ_RUST
+	tristate "Rust based CPUFreq driver based on the ACPI CPPC spec"
+	depends on ACPI_PROCESSOR
+	depends on ARM || ARM64 || RISCV
+	select ACPI_CPPC_LIB
+	help
+	  This adds a Rust based CPUFreq driver based on the ACPI CPPC spec.
+	  Basic support is only available for now, i.e. the following are
+	  not supported:
+	  - vendor specific workarounds
+	  - Frequency Invariance Engine (FIE)
+	  - artificial Energy Model (EM)
+	  - QoS requests
+
+	  If in doubt, say N.
+
 endmenu
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 4981d908b803..5e17db481a50 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_CPU_FREQ_GOV_ATTR_SET)	+= cpufreq_governor_attr_set.o
 
 obj-$(CONFIG_CPUFREQ_DT)		+= cpufreq-dt.o
 obj-$(CONFIG_CPUFREQ_DT_RUST)		+= rcpufreq_dt.o
+obj-$(CONFIG_ACPI_CPPC_CPUFREQ_RUST)	+= rcppc_cpufreq.o
 obj-$(CONFIG_CPUFREQ_DT_PLATDEV)	+= cpufreq-dt-platdev.o
 
 # Traces
diff --git a/drivers/cpufreq/rcppc_cpufreq.rs b/drivers/cpufreq/rcppc_cpufreq.rs
new file mode 100644
index 000000000000..198857a5b966
--- /dev/null
+++ b/drivers/cpufreq/rcppc_cpufreq.rs
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust based implementation of the cppc_cpufreq driver.
+
+use core::format_args;
+
+use kernel::prelude::*;
+
+use kernel::{
+    bindings, c_str, cpufreq,
+    cpumask::Cpumask,
+    error::{to_result, Result},
+    sync::Arc,
+};
+
+/// 2 usec delay between sampling
+const COUNTERS_SAMPLING_DELAY_US: u64 = 2;
+
+// Whether boost is supported
+static mut BOOST_SUPPORTED: bool = false;
+
+struct CPUFreqCppcDriver {
+    _drv: cpufreq::Registration<Self>,
+}
+
+struct CPUFreqCppcData {
+    perf_caps: bindings::cppc_perf_caps,
+    perf_ctrls: bindings::cppc_perf_ctrls,
+    shared_type: u32,
+    shared_cpu_map: Cpumask,
+}
+
+impl CPUFreqCppcData {
+    fn new(cpu: u32) -> Result<Self> {
+        let mut shared_type = bindings::CPUFREQ_SHARED_TYPE_NONE;
+        let mut perf_caps = bindings::cppc_perf_caps::default();
+        let mut shared_cpu_map = Cpumask::new()?;
+
+        match acpi_get_psd_map(cpu, &mut shared_cpu_map, &mut shared_type) {
+            Err(e) => {
+                pr_debug!("Err parsing CPU{cpu} PSD data: err:{e:?}\n");
+                return Err(e);
+            }
+            _ => {}
+        }
+
+        match cppc_get_perf_caps(cpu as i32, &mut perf_caps) {
+            Err(e) => {
+                pr_debug!("Err reading CPU{cpu} perf caps: e:{e:?}\n");
+                return Err(e);
+            }
+            _ => {}
+        }
+
+        Ok(Self {
+            perf_caps: perf_caps,
+            perf_ctrls: bindings::cppc_perf_ctrls::default(),
+            shared_type: shared_type,
+            shared_cpu_map: shared_cpu_map,
+        })
+    }
+}
+
+fn acpi_get_psd_map(cpu: u32, shared_cpu_map: &mut Cpumask, shared_type: &mut u32) -> Result<()> {
+    unsafe {
+        to_result(bindings::acpi_get_psd_map(
+            cpu,
+            shared_cpu_map.as_mut_ptr(),
+            shared_type,
+        ))
+    }
+}
+
+fn cppc_get_perf_caps(cpu: i32, perf_caps: &mut bindings::cppc_perf_caps) -> Result<()> {
+    unsafe { to_result(bindings::cppc_get_perf_caps(cpu, perf_caps)) }
+}
+
+fn cppc_perf_to_khz(caps: &mut bindings::cppc_perf_caps, perf: u32) -> u32 {
+    unsafe { bindings::cppc_perf_to_khz(caps, perf) }
+}
+
+fn cppc_khz_to_perf(caps: &mut bindings::cppc_perf_caps, freq: u32) -> u32 {
+    unsafe { bindings::cppc_khz_to_perf(caps, freq) }
+}
+
+fn cppc_set_perf(cpu: u32, perf_ctrls: &mut bindings::cppc_perf_ctrls) -> Result<()> {
+    unsafe { to_result(bindings::cppc_set_perf(cpu as i32, perf_ctrls)) }
+}
+
+fn cpufreq_freq_transition_begin(
+    policy: &mut cpufreq::Policy,
+    freqs: &mut bindings::cpufreq_freqs,
+) {
+    unsafe { bindings::cpufreq_freq_transition_begin(policy.as_raw(), freqs) }
+}
+
+fn cpufreq_freq_transition_end(
+    policy: &mut cpufreq::Policy,
+    freqs: &mut bindings::cpufreq_freqs,
+    transition_failed: bool,
+) {
+    unsafe {
+        bindings::cpufreq_freq_transition_end(policy.as_raw(), freqs, transition_failed as i32)
+    }
+}
+
+fn cppc_get_perf_ctrs(cpu: u32, fb_ctrs: &mut bindings::cppc_perf_fb_ctrs) -> Result<()> {
+    unsafe { to_result(bindings::cppc_get_perf_ctrs(cpu as i32, fb_ctrs)) }
+}
+
+fn cppc_perf_from_fbctrs(
+    desired_perf: u32,
+    fb_ctrs_t0: bindings::cppc_perf_fb_ctrs,
+    fb_ctrs_t1: bindings::cppc_perf_fb_ctrs,
+) -> u32 {
+    let reference_perf = fb_ctrs_t0.reference_perf;
+    let delta_reference = fb_ctrs_t1.reference.wrapping_sub(fb_ctrs_t0.reference);
+    let delta_delivered = fb_ctrs_t1.delivered.wrapping_sub(fb_ctrs_t0.delivered);
+
+    if delta_reference == 0 || delta_delivered == 0 {
+        return desired_perf;
+    }
+
+    return ((reference_perf - delta_delivered) / delta_reference) as u32;
+}
+
+#[vtable]
+impl cpufreq::Driver for CPUFreqCppcDriver {
+    type Data = ();
+    type PData = Arc<CPUFreqCppcData>;
+
+    fn init(policy: &mut cpufreq::Policy) -> Result<Self::PData> {
+        let cpu = policy.cpu();
+        let mut data = CPUFreqCppcData::new(cpu)?;
+
+        // Set min to lowest nonlinear perf to avoid any efficiency penalty
+        // (see Section 8.4.7.1.1.5 of ACPI 6.1 spec)
+        policy
+            .set_min(data.perf_caps.lowest_nonlinear_perf)
+            .set_max(data.perf_caps.nominal_perf);
+
+        let lowest_nonlinear_perf = data.perf_caps.lowest_nonlinear_perf;
+        let nominal_perf = data.perf_caps.nominal_perf;
+        let highest_perf = data.perf_caps.highest_perf;
+
+        // Set cpuinfo.min_freq to Lowest to make the full range of performance
+        // available if userspace wants to use any perf between lowest & lowest
+        // nonlinear perf
+        policy
+            .set_cpuinfo_min_freq(cppc_perf_to_khz(&mut data.perf_caps, lowest_nonlinear_perf))
+            .set_cpuinfo_max_freq(cppc_perf_to_khz(&mut data.perf_caps, nominal_perf));
+
+        policy
+            .set_transition_delay_us(unsafe { bindings::cppc_get_transition_latency(cpu as i32) })
+            .set_shared_type(data.shared_type);
+
+        match data.shared_type {
+            bindings::CPUFREQ_SHARED_TYPE_HW => {}
+            bindings::CPUFREQ_SHARED_TYPE_NONE => {}
+            bindings::CPUFREQ_SHARED_TYPE_ANY => {
+                // All CPUs in the domain will share a policy and all cpufreq
+                // operations will use the same CPUFreqCppcData struct.
+                let cpus = policy.cpus();
+                data.shared_cpu_map.copy(cpus);
+            }
+            default => {
+                pr_err!("Unsupported CPU co-ord type: {default}\n");
+                return Err(EFAULT);
+            }
+        }
+
+        if unsafe { bindings::cppc_allow_fast_switch() } {
+            policy.set_fast_switch_possible(true);
+        }
+
+        // If 'highest_perf' is greater than 'nominal_perf', we assume CPU Boost
+        // is supported.
+        if highest_perf > nominal_perf {
+            unsafe { BOOST_SUPPORTED = true };
+        }
+
+        // Set policy->cur to max now. The governors will adjust later.
+        policy
+            .set_dvfs_possible_from_any_cpu()
+            .set_cur(cppc_perf_to_khz(&mut data.perf_caps, highest_perf));
+
+        cppc_set_perf(cpu, &mut data.perf_ctrls)?;
+
+        Ok(Arc::new(data, GFP_KERNEL)?)
+    }
+
+    fn exit(_policy: &mut cpufreq::Policy, _data: Option<Self::PData>) -> Result<()> {
+        Ok(())
+    }
+
+    fn verify(policy_data: &mut cpufreq::PolicyData) -> Result<()> {
+        unsafe { bindings::cpufreq_verify_within_cpu_limits(policy_data.as_raw()) };
+        Ok(())
+    }
+
+    fn target(
+        policy: &mut cpufreq::Policy,
+        target_freq: u32,
+        _relation: cpufreq::Relation,
+    ) -> Result<()> {
+        let data = match policy.data::<Self::PData>() {
+            Some(data) => data,
+            None => return Err(ENOENT),
+        };
+
+        let mut perf_ctrls: bindings::cppc_perf_ctrls = data.perf_ctrls;
+        let mut perf_caps: bindings::cppc_perf_caps = data.perf_caps;
+        let desired_perf: u32 = cppc_khz_to_perf(&mut perf_caps, target_freq);
+        let cpu = policy.cpu();
+
+        // Return if it is exactly the same perf.
+        if desired_perf == perf_ctrls.desired_perf {
+            return Ok(());
+        }
+
+        perf_ctrls.desired_perf = desired_perf;
+
+        let mut freqs = bindings::cpufreq_freqs::default();
+        freqs.old = policy.cur();
+        freqs.new = target_freq;
+
+        cpufreq_freq_transition_begin(policy, &mut freqs);
+        let ret = cppc_set_perf(cpu, &mut perf_ctrls);
+        let transition_failed = match ret {
+            Ok(_) => false,
+            Err(e) => {
+                pr_debug!("Failed to set target on CPU:{cpu}. err:{e:?}\n");
+                true
+            }
+        };
+        cpufreq_freq_transition_end(policy, &mut freqs, transition_failed);
+
+        ret
+    }
+
+    fn fast_switch(policy: &mut cpufreq::Policy, target_freq: u32) -> u32 {
+        let data = match policy.data::<Self::PData>() {
+            Some(data) => data,
+            None => return 0,
+        };
+
+        let mut perf_caps = data.perf_caps;
+        let mut perf_ctrls = data.perf_ctrls;
+        let desired_perf = cppc_khz_to_perf(&mut perf_caps, target_freq);
+        let cpu = policy.cpu();
+
+        perf_ctrls.desired_perf = desired_perf;
+
+        if let Err(ret) = cppc_set_perf(cpu, &mut perf_ctrls) {
+            pr_debug!("Failed to set target on CPU:{cpu}. ret:{ret:?}\n");
+            return 0;
+        }
+
+        return target_freq;
+    }
+
+    fn get(policy: &mut cpufreq::Policy) -> Result<u32> {
+        let mut fb_ctrs_t0 = bindings::cppc_perf_fb_ctrs::default();
+        let mut fb_ctrs_t1 = bindings::cppc_perf_fb_ctrs::default();
+        let cpu = policy.cpu();
+
+        let data = match policy.data::<Self::PData>() {
+            Some(data) => data,
+            None => return Err(ENOENT),
+        };
+
+        let mut perf_caps = data.perf_caps;
+        let desired_perf = data.perf_ctrls.desired_perf;
+
+        cppc_get_perf_ctrs(cpu, &mut fb_ctrs_t0)?;
+        unsafe { bindings::__udelay(COUNTERS_SAMPLING_DELAY_US) };
+        cppc_get_perf_ctrs(cpu, &mut fb_ctrs_t1)?;
+
+        let delivered_perf = cppc_perf_from_fbctrs(desired_perf, fb_ctrs_t0, fb_ctrs_t1);
+        let freq = cppc_perf_to_khz(&mut perf_caps, delivered_perf);
+
+        Ok(freq)
+    }
+
+    fn set_boost(policy: &mut cpufreq::Policy, state: i32) -> Result<()> {
+        if unsafe { !BOOST_SUPPORTED } {
+            pr_err!("BOOST not supported by CPU or firmware\n");
+            return Err(EINVAL);
+        }
+
+        let data = match policy.data::<Self::PData>() {
+            Some(data) => data,
+            None => return Err(ENOENT),
+        };
+        let mut caps = data.perf_caps;
+        let highest_perf = caps.highest_perf;
+        let nominal_perf = caps.nominal_perf;
+
+        let max_freq = if state != 0 {
+            cppc_perf_to_khz(&mut caps, highest_perf)
+        } else {
+            cppc_perf_to_khz(&mut caps, nominal_perf)
+        };
+
+        policy
+            .set_max(max_freq)
+            .set_cpuinfo_max_freq(max_freq);
+
+        Ok(())
+    }
+}
+
+module! {
+    type: CPUFreqCppcDriver,
+    name: "cppc_cpufreq",
+    author: "Pierre Gondois",
+    description: "CPPC cpufreq driver",
+    license: "GPL v2",
+    initcall: ".initcall7.init",
+}
+
+impl kernel::Module for CPUFreqCppcDriver {
+    fn init(_name: &'static CStr, _module: &'static ThisModule) -> Result<Self> {
+        let drv = cpufreq::Registration::<CPUFreqCppcDriver>::register(
+            c_str!("rcppc-cpufreq"),
+            (),
+            cpufreq::flags::CONST_LOOPS,
+            false,
+        )?;
+
+        Ok(CPUFreqCppcDriver { _drv: drv })
+    }
+}
-- 
2.25.1


