Return-Path: <linux-acpi+bounces-15704-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 175C4B26D62
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 19:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FE511753E3
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 17:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8C515C158;
	Thu, 14 Aug 2025 17:17:23 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D92C32145D;
	Thu, 14 Aug 2025 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755191843; cv=none; b=jtJAUhjQ979Cd8vmWNGP+xAJy0xcHDbp+mLFkvlSrOopeFQSRYrgCIISc7cZKZcvcJA1wlBnGDnzQUExAu429qA2KRMnG1mwM16pSdHdK1QYWmEjSNQIpckhnP7hWL14CrudM8UrFEduhCu5GvTwTi6QWrq+hPiDuNW5vmZDkUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755191843; c=relaxed/simple;
	bh=PHHqoOq53ti1GIk4/b/DNGXwZna0WvrBdllf1Pft6ys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fN2wAvmjnCIoHXuChkI4IpMa5V1cPmAp6QJlEgRJ4tejgudUmMTqpPoEGkM6BN9lIpRU4OTWImMn6J7kNWrprZlr2nl00jkKcm+pQUd/IrndIV8Z4bmGZAohOXDN2q6TVnr9qD8sFTWpwZjqYjUtc11Yc7/N1llEVfDpEI26ONI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFF1C4CEED;
	Thu, 14 Aug 2025 17:17:21 +0000 (UTC)
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
Subject: [PATCH 0/4] cxl, acpi/hmat, node: Update CXL access coordinates to node directly
Date: Thu, 14 Aug 2025 10:16:46 -0700
Message-ID: <20250814171650.3002930-1-dave.jiang@intel.com>
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

Andrew or David, can you please ack patch 1/4 if you are okay with it.

Greg or Rafael, please ack patch 2/4 if you are satisfied with it. The helper
function's usage is in patch 3/4.

Rafael, please ack patches 3/4 and 4/4 if you are happy with the changes.

Thank you all!

The series aim to clean up the current CXL memory region hotplug notifier by
removing the update path through HMAT and updating the node access coordinates
directly. With the existing implementation, the CXL memory hotplug notifier
gets called first. It updates the HMAT target access coordinates. And then
the HMAT notifier gets called and create the node sysfs attribs. The new
implemenation flips the callback ordering and directly updates the sysfs
attribs already created in the node and leaves HMAT data structures alone.

# Dave Jiang (4):
#       mm/memory_hotplug: Update comment for hotplug memory callback priorities
#       drivers/base/node: Add a helper function node_update_perf_attrs()
#       cxl, acpi/hmat: Update CXL access coordinates directly instead of through HMAT
#       acpi/hmat: Remove now unused hmat_update_target_coordinates()
#
#  drivers/acpi/numa/hmat.c  | 34 ----------------------------------
#  drivers/base/node.c       | 39 +++++++++++++++++++++++++++++++++++++++
#  drivers/cxl/core/cdat.c   | 11 -----------
#  drivers/cxl/core/core.h   |  3 ---
#  drivers/cxl/core/region.c | 10 ++--------
#  include/linux/acpi.h      | 12 ------------
#  include/linux/memory.h    |  4 ++--
#  include/linux/node.h      |  8 ++++++++
#  8 files changed, 51 insertions(+), 70 deletions(-)
# </REPLACE>


Dave Jiang (4):
  mm/memory_hotplug: Update comment for hotplug memory callback
    priorities
  drivers/base/node: Add a helper function node_update_perf_attrs()
  cxl, acpi/hmat: Update CXL access coordinates directly instead of
    through HMAT
  acpi/hmat: Remove now unused hmat_update_target_coordinates()

 drivers/acpi/numa/hmat.c  | 34 ----------------------------------
 drivers/base/node.c       | 39 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/cdat.c   | 11 -----------
 drivers/cxl/core/core.h   |  3 ---
 drivers/cxl/core/region.c | 10 ++--------
 include/linux/acpi.h      | 12 ------------
 include/linux/memory.h    |  4 ++--
 include/linux/node.h      |  8 ++++++++
 8 files changed, 51 insertions(+), 70 deletions(-)


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.50.1


