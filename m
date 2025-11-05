Return-Path: <linux-acpi+bounces-18565-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC43C3869A
	for <lists+linux-acpi@lfdr.de>; Thu, 06 Nov 2025 00:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482831A220B7
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 23:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CC92DAFB8;
	Wed,  5 Nov 2025 23:51:17 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B321FA272;
	Wed,  5 Nov 2025 23:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762386677; cv=none; b=MmYm7gAfn+Cim0/QwotKNO0pbrjOXZeJRCaDdl7zy25EZcUEkG/irDH16oFqYdJ7H4Az64/vAJeHEV5YoKTEJJo5M0NJCBIvouRkj3QipYDi+a+cNITMKNRrNDQffeuocC0jC+Sl0kIybhYcqp/41d9QuPxmu2yLt7wzWoHOAE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762386677; c=relaxed/simple;
	bh=B2k3xFM0Shdi3e3P19hj1+izH5kPwAJYk/HrG5f0yrs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lXFDjikAytF3iDcs3lY+DN8xemnc5QpAK6y4VN+H3MMdJ71f76kajYmHXHaUxhI3z4vWrIx7Ye/E34sGBM0nCIBxB5IZxrBgdHm1Hn6YLJNVvnovJJnT2qwMk5l8qwMqYf9dBw3JZ73grfZWmUw914+mFJdh/YQxJQI71BxkoZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BEF8C4CEF5;
	Wed,  5 Nov 2025 23:51:17 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	rafael@kernel.org,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [RESEND PATCH v4 0/2] acpi/hmat: hmat_register_target() refactor to address lockdep warning
Date: Wed,  5 Nov 2025 16:51:13 -0700
Message-ID: <20251105235115.85062-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.51.1
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


