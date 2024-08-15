Return-Path: <linux-acpi+bounces-7589-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B6A952B00
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2024 11:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4F01F21F19
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2024 09:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4411BC066;
	Thu, 15 Aug 2024 08:29:49 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD9719D886;
	Thu, 15 Aug 2024 08:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723710589; cv=none; b=cDrl5mqUYx1ax3HcIY/G81agG8d0eJZHEEijOtg3Uyz6bzc/HxD0ZelgmqflSR3ftwVP9W2jfjnnYviYMH2zgIGgEjmfRL+OEDEA/J3oi8forT05eSShqWMqU6svCjg6RhH5NvEmwJtFxNxm25WS+FTUmqmSP698w/kX/wJgmJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723710589; c=relaxed/simple;
	bh=usUJ+ZMdAJKFpHqU9vw+q8ZPHOCj/YT/Au10Vbbq66A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C3gRGEo3C2iaQa9pz951O7o8mmeApCe7DZ/4wAsFckYJcOsJdkE6Hiu5wvjbkz9x4qf23uMKyZsF+Q20wDWl2Mj5TQWldpofP+hO9DmimsJ2+o6OtWNJOc4gZO8ZaMWxzCh952d0H7mdhI2V27dj79cXWtEBE/r2eOXXT9hQ+OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97929169E;
	Thu, 15 Aug 2024 01:30:10 -0700 (PDT)
Received: from e126645.nice.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 706C33F6A8;
	Thu, 15 Aug 2024 01:29:39 -0700 (PDT)
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
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Thomas Bertschinger <tahbertschinger@gmail.com>,
	linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	rust-for-linux@vger.kernel.org
Subject: [RFC PATCH 0/6] rust: cpufreq: Add cppc_cpufreq driver implementation
Date: Thu, 15 Aug 2024 10:29:04 +0200
Message-Id: <20240815082916.1210110-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,
This patchset is based on Viresh's Rust cpufreq patchset [1] and
implements a basic cppc cpufreq driver in Rust. The following features/
possibilities are not supported yet:
- vendor specific workarounds
- Frequency Invariance Engine (FIE)
- artificial Energy Model (EM)
- (struct cpufreq_driver).attr field
- QoS requests

Testing:
The patchset was tested on a CPPC based Juno-r2 platform. It was
checked that the underlying firmware received the freq. requests
the OS made.
The platform doesn't support Delivered/Reference Performance Counters
which are used to infer the current frequency of a perf. domain. The
.get() function of the driver was thus implemented, but bypassed
during testing.

[1]
Can be found at:
- git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git rust/cpufreq-dt
- latest commit: 2b6d636d1c7db3b21198105ad3ed5f458f027637
  ("defconfig: Update Rust and initramfs")
- Latest version is available at:
  - https://lore.kernel.org/lkml/cover.1722334569.git.viresh.kumar@linaro.org/

Pierre Gondois (6):
  ACPI: CPPC: Move struct cppc_cpudata to cppc_cpufreq driver
  cpufreq: cppc: Remove perf_fb_ctrs field from struct cppc_cpudata
  rust: module: Allow modules to specify initcall section
  rust: cpufreq: Add methods to struct Cpufreq
  rust: bindings: Add bindings for rcppc_cpufreq driver
  rust: cpufreq: Add rust implementation of cppc_cpufreq driver

 drivers/acpi/cppc_acpi.c         |  26 ++-
 drivers/cpufreq/Kconfig          |  16 ++
 drivers/cpufreq/Makefile         |   1 +
 drivers/cpufreq/cppc_cpufreq.c   |  12 +-
 drivers/cpufreq/rcppc_cpufreq.rs | 333 +++++++++++++++++++++++++++++++
 include/acpi/cppc_acpi.h         |  13 +-
 rust/bindings/bindings_helper.h  |   1 +
 rust/helpers.c                   |   6 +
 rust/kernel/cpufreq.rs           |  53 +++++
 rust/macros/module.rs            |  21 +-
 10 files changed, 457 insertions(+), 25 deletions(-)
 create mode 100644 drivers/cpufreq/rcppc_cpufreq.rs

-- 
2.25.1


