Return-Path: <linux-acpi+bounces-14365-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1752AD956B
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 21:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF88A3B4182
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 19:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C172223D2A9;
	Fri, 13 Jun 2025 19:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VCt3JuwL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C006F3595A;
	Fri, 13 Jun 2025 19:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749842197; cv=none; b=Lhw5bGgSaF4c2dHjhkKY50nnrdlJCqTKBAA2RZyYwhJnICMU1z5XKwWaeFg7BZx6ydeB09tDYFnaGmUlZ7f8cm7iYfQiPV1yD7PGz9Rdxz3uDe4DJ2uH1xBJd07mGlqsOHkjyvE7yw6J0BrmPWwNPxspLtcjpipJD0ETgv0DwcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749842197; c=relaxed/simple;
	bh=9UpM1Ni+bJU9NoQyrUI1I313v8+VKBabwKwOdKSP5YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LNXa283S7bO/7348HFq0pzfq8/OCmwvH/yaTU2gN/nSPzlKt6gVNROfQ4Yh6UD7Co3uSw0YBCQk5jEMotZV4JygUeOAqQFI0S8UvbuyYZHfPwsn/iv1awH33a3sPbaDIneMTUe6Wma7WwsXyE1AX44VBb1QS+LwEWdfPZDYHCPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VCt3JuwL; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749842196; x=1781378196;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9UpM1Ni+bJU9NoQyrUI1I313v8+VKBabwKwOdKSP5YQ=;
  b=VCt3JuwL5nymkct3F1gsWR3ByzxnXFjWb9naC+2OhPpZhK2/UgQAYoSo
   auYf9eaqFOxzUuZIU9lMnHwpkMhjRGZ8+QpHEoDWSGsIzpjH2I9TKTiIn
   86QmN+teMlOD9dZJA4bMR7vP3mwngyX9CXA2ZuEw5OzhcpNXbEw7kPnG5
   L/q9ZJs9+SqMydMTHvTtkaOnBUx85lTTnesr2Uu0WH3mBDjhlh8KtG4Ob
   hAPY4urQ0o8zHuMpdJpWxDYwD/Nl+mSyQZ78JLVLZ+wFUC17Lg6w2PzcJ
   ltqVs7ukoENmoew9Q7ZBI01k9HLiIDD4l9a8EE2ZeppZz8ADAuTZCyF74
   Q==;
X-CSE-ConnectionGUID: mscgwMpLS1mRIQBVKdIObg==
X-CSE-MsgGUID: 7wszPhskQw2bIKHIUk/SKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="51296773"
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="51296773"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 12:16:35 -0700
X-CSE-ConnectionGUID: A/faDkYaSrWRcpw/QtAq8w==
X-CSE-MsgGUID: S9vjPXWHRxCq9e0GOwEWPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="148444294"
Received: from unknown (HELO hyperion.jf.intel.com) ([10.243.61.29])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 12:16:35 -0700
From: marc.herbert@linux.intel.com
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	rafael.j.wysocki@intel.com,
	linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Ben Cheatham <Benjamin.Cheatham@amd.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Marc Herbert <marc.herbert@linux.intel.com>
Subject: [PATCH] driver core: faux: fix Undefined Behavior in faux_device_destroy()
Date: Fri, 13 Jun 2025 19:15:56 +0000
Message-ID: <20250613191556.4184103-1-marc.herbert@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marc Herbert <marc.herbert@linux.intel.com>

Fixes undefined behavior that was spotted by Jonathan Cameron in
https://lore.kernel.org/linux-cxl/20250609170509.00003625@huawei.com/

The possible consequences of the undefined behavior fixed here are fairly
well documented across the Internet but to save research time and avoid
doubts, I include a very short and simple demo below. I imagine kernel
compilation flags and various other conditions may not make the
consequences as bad as this example, however those conditions could change
and this type of code is still Undefined Behavior no matter what.
One of the best articles - there are many others:
https://blog.llvm.org/2011/05/what-every-c-programmer-should-know.html

Since commit b5ec6fd286dfa4 ("kbuild: Drop -Wdeclaration-after-statement"),
it's now possible to use C99 declarations; the kernel is not constrained
anymore to group all declarations at the top of a block like single-pass
compilers used to require. This allows combining declarations and
definitions in one place - like literally every other language and project
does - and trivially fix undefined behavior like this.  This also reduces
variable scope and avoids misuse between declaration and definition like
uninitialized reads or writing to the wrong variable by mistake. C99
declarations also allow using a lot more `const` (the default in some
languages) which avoids some misuse after legitimate use.
tl;dr: C99 declarations are not just a "codestyle" or "taste" issue;
they are an important (and not mandatory) feature.

cc --version
  cc (GCC) 15.1.1 20250425

for i in 0 1 2 g; do printf "gcc -O$i: "; gcc -O$i nullptrUB.c &&
   ./a.out; done

gcc -O0: Segmentation fault (core dumped)
gcc -O1: ptr is zero
gcc -O2: ptr is NOT zero!!!
gcc -O3: ptr is NOT zero!!!
gcc -Og: ptr is zero

clang --version
  clang version 19.1.7

clang -O0: Segmentation fault (core dumped)
clang -O1: ptr is NOT zero!!!
clang -O2: ptr is NOT zero!!!
clang -O3: ptr is NOT zero!!!
clang -Og: ptr is NOT zero!!!

int faux_device_destroy(int *ptr)
{
  int i = *ptr;  i++;

  // Because we dereferenced ptr, the compiler knows the pointer cannot
  // be null (even when it is!) and can optimize this away.
  if (!ptr) {
    printf("ptr is zero\n");
    return 0;
  }

  printf("ptr is NOT zero!!!\n");
  return 1;
}

int main()
{
  struct timespec t1, t2;
  clock_gettime(CLOCK_MONOTONIC, &t1);
  clock_gettime(CLOCK_MONOTONIC, &t2);

  // Use the clock to hide zero from the compiler
  int * zeroptr = (int *)(t2.tv_sec - t1.tv_sec);

  return faux_device_destroy(zeroptr);
}

Fixes: 35fa2d88ca94 ("driver core: add a faux bus for use when a simple device/bus is needed")
Signed-off-by: Marc Herbert <marc.herbert@linux.intel.com>
---
 drivers/base/faux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/faux.c b/drivers/base/faux.c
index 9054d346bd7f..94392d397986 100644
--- a/drivers/base/faux.c
+++ b/drivers/base/faux.c
@@ -218,11 +218,11 @@ EXPORT_SYMBOL_GPL(faux_device_create);
  */
 void faux_device_destroy(struct faux_device *faux_dev)
 {
-	struct device *dev = &faux_dev->dev;
-
 	if (!faux_dev)
 		return;
 
+	struct device *dev = &faux_dev->dev;
+
 	device_del(dev);
 
 	/* The final put_device() will clean up the memory we allocated for this device. */
-- 
2.49.0


