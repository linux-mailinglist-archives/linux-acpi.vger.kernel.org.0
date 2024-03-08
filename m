Return-Path: <linux-acpi+bounces-4207-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FBC876C97
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Mar 2024 23:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C07D9282C9F
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Mar 2024 22:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1EE5FB8B;
	Fri,  8 Mar 2024 22:01:03 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34C55E094;
	Fri,  8 Mar 2024 22:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709935263; cv=none; b=IUKFj93roS5yI9wjQExVKxfJ+vCl0Ix7IU2AT37O6RIKtxoMNx81pEXrdiXcSuNROSBk31QPO/X67gZJ2IXmrLe9Vj5hebHLTdn2rL8+MxMfoK9U1QrzZ5szVfniSFwycF760njQLk4ovKeMXK46UIkIs4jKczy8PJTmTi6xrbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709935263; c=relaxed/simple;
	bh=ZgRS+pkfLbcRBERv0qpMefaDzsG714FgyTgyLPVQeUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jBFrPwPrEkDycJ3ZL3SnZjHpXMOaEGfShSW/1/LvdtRbJi6KyVb4RKM9v3Whi9ICbL0ub8TJbYqO2GVNPH1JLnCAfps9FRnhQb79YpWwFbDeWHmYz14BLF+gZpb8+8CaY7ycvzVTBC/gBUlBUuKYD7OEMoTWVJcQr4/SNtfpU1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A912FC433F1;
	Fri,  8 Mar 2024 22:01:01 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	rafael@kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH v7 0/12] cxl: Add support to report region access coordinates to numa nodes
Date: Fri,  8 Mar 2024 14:59:19 -0700
Message-ID: <20240308220055.2172956-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Rafael,
Please review patches 1-4,10,11 and ack if they look ok to you. Thank you!

Hi Greg,
Please review patch 11 and ack the numa node bits if they look ok to you. Thank you!

v7:
- Add review tag from Greg
- Add review and test tags from Jonathan
- Fix typos (Jonathan)
- Move memory_notifier registeration to devm_cxl_add_region() (Dan)

v6:
- Enhance macros used to reduce code for cxl access coordinates sysfs attrs (Jonathan)
- Various minor updates and fixes, see per commit details. (Jonathan)
- Added review tags from Jonathan.

v5:
- Fix various 0-day issues
- Remove EXPORT_SYMBOL for cxl_coords_combine() (Dan)
- Rebased against fixes series for qos_class
https://lore.kernel.org/linux-cxl/20240206190431.1810289-1-dave.jiang@intel.com/T/#t 

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

Recall from qos_class series (v6.8) that the performance data for the ranges
of a CXL memory device is computed and cached. A CXL memory region can be
backed by one or more devices. Thus the performance data would be the
aggregated bandwidth of all devices that back a region and the worst
latency out of all devices backing the region.

See kernel git branch [2] for convenience.

[1]: https://www.kernel.org/doc/Documentation/admin-guide/mm/numaperf.rst
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl-hmem-report


