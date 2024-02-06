Return-Path: <linux-acpi+bounces-3258-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1614684C005
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Feb 2024 23:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92CEA1F2442E
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Feb 2024 22:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E525E1BF20;
	Tue,  6 Feb 2024 22:30:05 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CE18F61;
	Tue,  6 Feb 2024 22:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707258605; cv=none; b=izThqy/VJPeSzISY6sKAu9Xqmp3fCWSWitPT5LoXPhNsZOBlSl6TApl6FIJb8f60YlpTpCDStIczvIqdxfbTOVVLu+WSt2Iq3hJOeSNVU00wT81YnWZLQl+iiLvdFY+I6x57/L3a9EuVU/xELaj2zSMvwKXimRO+YYI6cg0uBoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707258605; c=relaxed/simple;
	bh=b99246+dgU+ryvt2aUmzQvU8tNHBbAEI/f4kzuMRLTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fOEncVUyMMBSC5TLY3ry8hBw+kPkx4vlTp50QZ7+8gQpP0kjceF4jimkAS8ojM0A9vhJkjuuHzBuIj3PJGAs003dmJn3iaXFOCbuJQSBIAUd3PFc9F4UC0LlIiCv3byjk12QJRl+SWKn0C/bNc0gHel82TdpcXLjc0EDaiJIJPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2A1C433C7;
	Tue,  6 Feb 2024 22:30:05 +0000 (UTC)
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
Subject: [PATCH v5 0/12] cxl: Add support to report region access coordinates to numa nodes
Date: Tue,  6 Feb 2024 15:28:28 -0700
Message-ID: <20240206222951.1833098-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.43.0
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
Please review patch 2 and 11 and ack the numa node bits if they look ok to you. Thank you!

v5:
- Fix various 0-day issues
- Remove EXPORT_SYMBOL for cxl_coords_combine() (Dan)
- Rebased against fixes series for qos_class [1].

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

According to numaperf documentation [2] there are 2 access classes defined
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

See git branch [3] for convenience.

[1]: https://lore.kernel.org/linux-cxl/20240206190431.1810289-1-dave.jiang@intel.com/T/#t 
[2]: https://www.kernel.org/doc/Documentation/admin-guide/mm/numaperf.rst
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl-hmem-report

