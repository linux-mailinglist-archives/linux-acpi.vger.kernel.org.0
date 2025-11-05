Return-Path: <linux-acpi+bounces-18562-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 086A0C38688
	for <lists+linux-acpi@lfdr.de>; Thu, 06 Nov 2025 00:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B95E94F3DAC
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 23:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616AF2DC342;
	Wed,  5 Nov 2025 23:48:59 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4271834CDD;
	Wed,  5 Nov 2025 23:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762386539; cv=none; b=tykhKXrkzWvkF6wN0VfIfHANMHVHMXW8L5A9649w7WMEM3IqRZUr+QMMEKEGRdxqyvrLasyLXGK+IjfDC4kbel9SGIRSQ+qEhZXm0hr7Rd25VMxmR+bNTbQwDQH1WNydAmrbPT1Gy05kR2ZN2zWTeJ2XGG/KSXETnVbfpCNLQX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762386539; c=relaxed/simple;
	bh=B2k3xFM0Shdi3e3P19hj1+izH5kPwAJYk/HrG5f0yrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gSjIJfqppu8yJZU+6zT8GzseGAL422wGIWkYjHZxO0P/l/1IHRVacgfO/DPX1AwPnzrpTwChEw1nItp29Y+Jq+CnMuVwkJ58ye2iHb+wycb0Ho5mDhzQxZ7hhbFUZeHUCf3i+GW2SqnwsbR5i0tNojutyd9IaDsEFK1ACHi7oyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0541C4CEF5;
	Wed,  5 Nov 2025 23:48:58 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	rafael@kernel.org,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v4 0/2] acpi/hmat: hmat_register_target() refactor to address lockdep warning
Date: Wed,  5 Nov 2025 16:48:49 -0700
Message-ID: <20251105234851.81589-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251105234851.81589-1-dave.jiang@intel.com>
References: <20251105234851.81589-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v4:
- Refactor hmat_hotplug_target() (Jonathan)
- Fix fixes tag. (Jonathan)

This series has changes that refactor the hmat_register_target() function
to clean up a lockdep warning.

Dave Jiang (2):
  acpi/hmat: Return when generic target is updated
  acpi/hmat: Fix lockdep warning for hmem_register_resource()

 drivers/acpi/numa/hmat.c | 60 ++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 27 deletions(-)


base-commit: 6146a0f1dfae5d37442a9ddcba012add260bceb0
-- 
2.51.1


