Return-Path: <linux-acpi+bounces-2942-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0C8832E0D
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Jan 2024 18:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C14B287EEA
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Jan 2024 17:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF1B5577D;
	Fri, 19 Jan 2024 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I8ixvOEz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86AC54BEE;
	Fri, 19 Jan 2024 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705684986; cv=none; b=Tye/fiNjRcJDsrzXVajGLomjQSdINDm9r5y+D5y9kiDkQEjgbw+Ygz9eu4jVG/EPQAjglBkxPsL5FnMrlR4nBHzTtMMf+MTeHN4ZbJ9qyLG3eoYd+CcYjzXFUrzDzYsfu7/ijImfb3jdzELLOprjwsGF6I0t6E04mdTqRHCdQRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705684986; c=relaxed/simple;
	bh=ViGy1MNPoHzdAAlOoVw+jmeOLSwE3a7hj20/dLzoCzM=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=iVqN6d3JfLV1j/mVStb5kaS+gq1oahao4knM5cTwQ1urCFGhkqaYX9rlMFeZrgKMnkXy7Nl5mP8/Mio8ueBXtD6iCnfnvO1NgEyMvk0aQGYHm7nXSedJCqoEjvRRzfyWlKxZ2RJlOFEFlaMAd8chwMmtD1EvgwjrZnQsF4kfqFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I8ixvOEz; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705684984; x=1737220984;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ViGy1MNPoHzdAAlOoVw+jmeOLSwE3a7hj20/dLzoCzM=;
  b=I8ixvOEzZyOdiXBbsAw4jT3Rv6iln/8QoOkX2XSlkDJq2LtZNLg09JXs
   XCIlj2kngQzln3AOY+/CpwQRcjF3BolRO1Lmu134g4L7PUbIcUkoxULH0
   Ltk929wHLruc6NVj0QVTjYEUQJIM1FDJ6sK0uwfaevZhquB9kPDbtezUo
   QRCZw8kGiu0quyfEsuUAA+W5Tkj911BxHJKF50y4aHouR+NbifhBAIljC
   KF8o/b4G1JdCC5HiaY5bpWCkzrAuIodwyAHHohRUFvdq1tcj1smAiR1Os
   Vn1Bjg/CHufzAchBVyt+6CDbWJwxcalTB8U3sW8TFmJpxouosCzfYzh9p
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="399665959"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="399665959"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 09:23:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="634514"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.161.22])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 09:23:02 -0800
Subject: [PATCH v4 00/11] cxl: Add support to report region access coordinates
 to numa nodes
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: "Huang, Ying" <ying.huang@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 jonathan.cameron@huawei.com, dave@stgolabs.net, brice.goglin@gmail.com,
 nifan.cxl@gmail.com, rafael@kernel.org, gregkh@linuxfoundation.org
Date: Fri, 19 Jan 2024 10:23:01 -0700
Message-ID: <170568485801.1008395.12244787918793980621.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Rafael,
Please review patches 1-4,10,11 and ack if they look ok to you. Thank you!

Hi Greg,
Please review patch 2 and 11 and ack the numa node bits if they look ok to you. Thank you!

v4:
- Introduce access class 0 and 1 for CXL access coordinates.
- See individual patches for detailed change log if applicable.

v3:
- Make attributes not visible if no data. (Jonathan)
- Fix documentation verbiage. (Jonathan)
- Check against read bandwidth instead of write bandwidth due to future RO devices. (Jonathan)
- Export node_set_perf_attrs() to all namespaces. (Jonathan)
- Remove setting of coordinate access level 1. (Jonathan)

v2:
- Move calculation function to core/cdat.c due to QTG series changes
- Make cxlr->coord static (Dan)
- Move calculation to cxl_region_attach to be under cxl_dpa_rwsem (Dan)
- Normalize perf latency numbers to nanoseconds (Brice)
- Update documentation with units and initiator details (Brice, Dan)
- Fix notifier return values (Dan)
- Use devm_add_action_or_reset() to unregister memory notifier (Dan)

This series adds support for computing the performance data of a CXL region
and also updates the performance data to the NUMA node. This series depends
on the CXL QOS class series that's pending 6.8 pull request.

CXL memory devices already attached before boot are enumerated by the BIOS.
The SRAT and HMAT tables are properly setup to including memory regions
enumerated from those CXL memory devices. For regions not programmed or a
hot-plugged CXL memory device, the BIOS does not have the relevant
information and the performance data has to be caluclated by the driver
post region assembly.

According to numaperf documentation [1] there are 2 access classes defined
for performance between an initiator node and a memory target node. Access
class "0" describes attributes between a memory target and the highest
performing initator local to the target. In this case the initiator can be
a CPU or an I/O initiator such as a GPU or NIC. Access class "1" describes
attributes between a memory target and the nearest CPU node. Both access
classes are calculated for the CXL memory target and updated for NUMA nodes
through HMAT_REPORTING code or directly depending on if the NUMA node is
described by the ACPI SRAT table.

Recall from [2] that the performance data for the ranges of a CXL memory device
is computed and cached. A CXL memory region can be backed by one or more
devices. Thus the performance data would be the aggregated bandwidth of all
devices that back a region and the worst latency out of all devices backing
the region.

See git branch [3] for convenience.

[1]: https://www.kernel.org/doc/Documentation/admin-guide/mm/numaperf.rst
[2]: https://lore.kernel.org/linux-cxl/170319606771.2212653.5435838660860735129.stgit@djiang5-mobl3/
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl-hmem-report

---

Dave Jiang (11):
      ACPI: HMAT: Remove register of memory node for generic target
      base/node / ACPI: Enumerate node access class for 'struct access_coordinate'
      ACPI: HMAT: Introduce 2 levels of generic port access class
      ACPI: HMAT / cxl: Add retrieval of generic port coordinates for both access classes
      cxl: Split out combine_coordinates() for common shared usage
      cxl: Split out host bridge access coordinates
      cxl: Set cxlmd->endpoint before adding port device
      cxl/region: Calculate performance data for a region
      cxl/region: Add sysfs attribute for locality attributes of CXL regions
      cxl/region: Add memory hotplug notifier for cxl region
      cxl/region: Deal with numa nodes not enumarated by SRAT


 Documentation/ABI/testing/sysfs-bus-cxl |  60 +++++++
 drivers/acpi/numa/hmat.c                |  86 +++++++---
 drivers/acpi/numa/srat.c                |  11 ++
 drivers/base/node.c                     |   7 +-
 drivers/cxl/acpi.c                      |   8 +-
 drivers/cxl/core/cdat.c                 | 142 ++++++++++++++--
 drivers/cxl/core/core.h                 |   4 +
 drivers/cxl/core/port.c                 |  44 +++--
 drivers/cxl/core/region.c               | 216 ++++++++++++++++++++++++
 drivers/cxl/cxl.h                       |  15 +-
 include/linux/acpi.h                    |  10 ++
 include/linux/memory.h                  |   1 +
 include/linux/node.h                    |  18 +-
 13 files changed, 565 insertions(+), 57 deletions(-)

--


