Return-Path: <linux-acpi+bounces-16197-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBEEB3C4CC
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Aug 2025 00:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EBC2585C35
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 22:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E2F276031;
	Fri, 29 Aug 2025 22:29:33 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DC81D61BB;
	Fri, 29 Aug 2025 22:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756506573; cv=none; b=N6M/Knoeq1XuRDfC2xSvmvg5+Zj+gOOWCOEGuzQ5wC4f+nJifuGygjdMTaQpTnf3nc/mZEGjg55H/OrO+ggFX9BU0EeO8QWS5MswbjJgjIDKxf445meF+CWW7j8SKgDcKWsqt9MOw3w5es5lMJR02RaQsPwRotKLz8hnFSBG5zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756506573; c=relaxed/simple;
	bh=nkEs4vYTB1eTT7mV0Lw0Yk9UVaevXLO8VmSQ2dytcMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OwqRD7MXS0NTFir2JbYWx4Ztaga4CHbe4hDEf4ChOwBcZ0KRXGrA+FxhqlKuPTCCcFyo4X2Fy5l2GTRpvRDwl4bbRsslds4PfXz/pO+TAFLJJJy368IFqOy8UvnFDlMhhVMEErPfuvnJUdgVL0ZGP4AMnyJ/agYr9xUgwCfAm+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC07C4CEF0;
	Fri, 29 Aug 2025 22:29:31 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	marc.herbert@linux.intel.com,
	akpm@linux-foundation.org,
	david@redhat.com
Subject: [PATCH v3 0/4] cxl, acpi/hmat, node: Update CXL access coordinates to node directly
Date: Fri, 29 Aug 2025 15:29:03 -0700
Message-ID: <20250829222907.1290912-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I plan to take this series through the CXL tree when all the necessary tags
are received.

Rafael, please ack patches 3/4 and 4/4 if you are happy with the changes.

Thank you!

v3:
- Fix grammar in comment. (DavidH)
- Use nodemask instead of xarray. (Jonathan)

v2:
- Use clearer comment from DavidH for 1/4. (DavidH)
- Fix comment in 2/4. (DavidH)
- Streamline code in 2/4. (DavidH)
- Add description to observed issue. (Dan)
- Add correct Fixes tag. (Dan)
- Add cc to stable for fix patch. (Dan)
- Add mechansim to only update on first region for the node. (Jonathan)

The series aim to clean up the current CXL memory region hotplug notifier by
removing the update path through HMAT and updating the node access coordinates
directly. With the existing implementation, the CXL memory hotplug notifier
gets called first. It updates the HMAT target access coordinates. And then
the HMAT notifier gets called and create the node sysfs attribs. The new
implemenation flips the callback ordering and directly updates the sysfs
attribs already created in the node and leaves HMAT data structures alone.

Dave Jiang (4):
  mm/memory_hotplug: Update comment for hotplug memory callback
    priorities
  drivers/base/node: Add a helper function node_update_perf_attrs()
  cxl, acpi/hmat: Update CXL access coordinates directly instead of
    through HMAT
  acpi/hmat: Remove now unused hmat_update_target_coordinates()

 drivers/acpi/numa/hmat.c  | 34 ----------------------------------
 drivers/base/node.c       | 38 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/cdat.c   | 11 -----------
 drivers/cxl/core/core.h   |  3 ---
 drivers/cxl/core/region.c | 20 ++++++++++++--------
 include/linux/acpi.h      | 12 ------------
 include/linux/memory.h    |  6 +++---
 include/linux/node.h      |  8 ++++++++
 8 files changed, 61 insertions(+), 71 deletions(-)


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.50.1


