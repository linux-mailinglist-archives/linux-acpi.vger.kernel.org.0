Return-Path: <linux-acpi+bounces-4140-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE3B8739DB
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Mar 2024 15:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC171C222F7
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Mar 2024 14:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E41134CED;
	Wed,  6 Mar 2024 14:55:07 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DD7133981;
	Wed,  6 Mar 2024 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709736907; cv=none; b=PXM0bWlSG2UJf8SxiKiz7Y7x0Amk7tI0tGoWAUlpDpxai9Y+XZDPKbGW51iTDUKS+mySoWsTRfnTxGrnuYtBXKUyrWYgbcAAR0wONwoO85PYrJcszSHtmTj6JWbpOopvj3uX11e2ibXD+zKTkOwI4yOLMlGr0bQ9jnZ064f0QEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709736907; c=relaxed/simple;
	bh=jzDiXRLETQyLMscOyASRXMIUDF47bsQN3faviixjV4g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oGva+OOXWsoFHKnW6pBoY41V93SlNdz7sWAWPNaBn4Kuz93KbBeDAkJIO/FnKKI9SzYnY+FRy8+heeOd0kwLkCA5dFBI1x99L4k2u5ThKb4fiO4EEDvgwQnR8TPg4QK9FQsfwx0kqFlkk/3oKVkEJz0BHItGKBWbkVjNRBhHjN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tqb226frhz6D8j4;
	Wed,  6 Mar 2024 22:50:02 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 995B81412E2;
	Wed,  6 Mar 2024 22:55:02 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Mar
 2024 14:55:02 +0000
Date: Wed, 6 Mar 2024 14:55:01 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <rafael@kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 0/12] cxl: Add support to report region access
 coordinates to numa nodes
Message-ID: <20240306145501.0000730f@Huawei.com>
In-Reply-To: <20240220231402.3156281-1-dave.jiang@intel.com>
References: <20240220231402.3156281-1-dave.jiang@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 20 Feb 2024 16:12:29 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Hi Rafael,
> Please review patches 1-4,10,11 and ack if they look ok to you. Thank you!
> 
> Hi Greg,
> Please review patch 2 and 11 and ack the numa node bits if they look ok to you. Thank you!

Whilst currently a bit light weight, I poked this along with the QEMU Generic Port emulation
on the gitlab.com/jic23/qemu cxl-2024-03-05 and some pathological cases from host side,

It works so

Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> v6:
> - Enhance macros used to reduce code for cxl access coordinates sysfs attrs (Jonathan)
> - Various minor updates and fixes, see per commit details. (Jonathan)
> - Added review tags from Jonathan.
> 
> v5:
> - Fix various 0-day issues
> - Remove EXPORT_SYMBOL for cxl_coords_combine() (Dan)
> - Rebased against fixes series for qos_class [1].
> 
> v4:
> - Introduce access class 0 and 1 for CXL access coordinates.
> - See individual patches for detailed change log if applicable.
> 
> v3:
> - Make attributes not visible if no data. (Jonathan)
> - Fix documentation verbiage. (Jonathan)
> - Check against read bandwidth instead of write bandwidth due to future RO devices. (Jonathan)
> - Export node_set_perf_attrs() to all namespaces. (Jonathan)
> - Remove setting of coordinate access level 1. (Jonathan)
> 
> v2:
> - Move calculation function to core/cdat.c due to QTG series changes
> - Make cxlr->coord static (Dan)
> - Move calculation to cxl_region_attach to be under cxl_dpa_rwsem (Dan)
> - Normalize perf latency numbers to nanoseconds (Brice)
> - Update documentation with units and initiator details (Brice, Dan)
> - Fix notifier return values (Dan)
> - Use devm_add_action_or_reset() to unregister memory notifier (Dan)
> 
> This series adds support for computing the performance data of a CXL region
> and also updates the performance data to the NUMA node. This series depends
> on the CXL QOS class series that's pending 6.8 pull request.
> 
> CXL memory devices already attached before boot are enumerated by the BIOS.
> The SRAT and HMAT tables are properly setup to including memory regions
> enumerated from those CXL memory devices. For regions not programmed or a
> hot-plugged CXL memory device, the BIOS does not have the relevant
> information and the performance data has to be caluclated by the driver
> post region assembly.
> 
> According to numaperf documentation [2] there are 2 access classes defined
> for performance between an initiator node and a memory target node. Access
> class "0" describes attributes between a memory target and the highest
> performing initator local to the target. In this case the initiator can be
> a CPU or an I/O initiator such as a GPU or NIC. Access class "1" describes
> attributes between a memory target and the nearest CPU node. Both access
> classes are calculated for the CXL memory target and updated for NUMA nodes
> through HMAT_REPORTING code or directly depending on if the NUMA node is
> described by the ACPI SRAT table.
> 
> Recall from qos_class series (v6.8) that the performance data for the ranges
> of a CXL memory device is computed and cached. A CXL memory region can be
> backed by one or more devices. Thus the performance data would be the
> aggregated bandwidth of all devices that back a region and the worst
> latency out of all devices backing the region.
> 
> See kernel git branch [3] for convenience.
> 
> [1]: https://lore.kernel.org/linux-cxl/20240206190431.1810289-1-dave.jiang@intel.com/T/#t 
> [2]: https://www.kernel.org/doc/Documentation/admin-guide/mm/numaperf.rst
> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl-hmem-report
> 


