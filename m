Return-Path: <linux-acpi+bounces-16280-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14262B408DF
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Sep 2025 17:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D94D2544AC5
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Sep 2025 15:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF40731DDB7;
	Tue,  2 Sep 2025 15:24:59 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C01623D7C4;
	Tue,  2 Sep 2025 15:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756826699; cv=none; b=T2Qi7AV+7sH5y1cNKs0hHd4uGKFm68qTdwuk80r5gjfGu9rJyvPt2xsoSvdkkt+SwNje2dFd2zQqW8qkKUtg7QxAQaHBunYpcYc8XajDFxBWj312NruzUPphShjGeYSG0avZa1Di/d6XqgGHSwzFSvcjTq0K0sBbh94c0NP0G1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756826699; c=relaxed/simple;
	bh=08WLGYvIs6DHBHZWmf9vElYib+z/jFkZCljxRkJotHw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bv3JVIXpQi2eDbNqKgfZe6FJFj7TPfx0UQsys2zQyxsnmlXob0NPzO8lFuf9qAta6+yFZOGFvzALtofoRA3oMo+IurM//oFeffQnih6mks2aajywc0y28mSQjn/iFsgA0BLGHcTwh0G71x621a4nbN56v0QpeS2RG5hLDodcoLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cGTxt08Cmz6M4ZQ;
	Tue,  2 Sep 2025 23:22:26 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E5D40140136;
	Tue,  2 Sep 2025 23:24:52 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 2 Sep
 2025 17:24:52 +0200
Date: Tue, 2 Sep 2025 16:24:50 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<rafael@kernel.org>, <dakr@kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<marc.herbert@linux.intel.com>, <akpm@linux-foundation.org>,
	<david@redhat.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] cxl, acpi/hmat: Update CXL access coordinates
 directly instead of through HMAT
Message-ID: <20250902162450.00002684@huawei.com>
In-Reply-To: <20250829222907.1290912-4-dave.jiang@intel.com>
References: <20250829222907.1290912-1-dave.jiang@intel.com>
	<20250829222907.1290912-4-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 29 Aug 2025 15:29:06 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> The current implementation of CXL memory hotplug notifier gets called
> before the HMAT memory hotplug notifier. The CXL driver calculates the
> access coordinates (bandwidth and latency values) for the CXL end to
> end path (i.e. CPU to endpoint). When the CXL region is onlined, the CXL
> memory hotplug notifier writes the access coordinates to the HMAT target
> structs. Then the HMAT memory hotplug notifier is called and it creates
> the access coordinates for the node sysfs attributes.
> 
> During testing on an Intel platform, it was found that although the
> newly calculated coordinates were pushed to sysfs, the sysfs attributes for
> the access coordinates showed up with the wrong initiator. The system has
> 4 nodes (0, 1, 2, 3) where node 0 and 1 are CPU nodes and node 2 and 3 are
> CXL nodes. The expectation is that node 2 would show up as a target to node
> 0:
> /sys/devices/system/node/node2/access0/initiators/node0
> 
> However it was observed that node 2 showed up as a target under node 1:
> /sys/devices/system/node/node2/access0/initiators/node1
> 
> The original intent of the 'ext_updated' flag in HMAT handling code was to
> stop HMAT memory hotplug callback from clobbering the access coordinates
> after CXL has injected its calculated coordinates and replaced the generic
> target access coordinates provided by the HMAT table in the HMAT target
> structs. However the flag is hacky at best and blocks the updates from
> other CXL regions that are onlined in the same node later on. Remove the
> 'ext_updated' flag usage and just update the access coordinates for the
> nodes directly without touching HMAT target data.
> 
> The hotplug memory callback ordering is changed. Instead of changing CXL,
> move HMAT back so there's room for the levels rather than have CXL share
> the same level as SLAB_CALLBACK_PRI. The change will resulting in the CXL
> callback to be executed after the HMAT callback.
> 
> With the change, the CXL hotplug memory notifier runs after the HMAT
> callback. The HMAT callback will create the node sysfs attributes for
> access coordinates. The CXL callback will write the access coordinates to
> the now created node sysfs attributes directly and will not pollute the
> HMAT target values.
> 
> A nodemask is introduced to keep track if a node has been updated and
> prevents further updates.
> 
> Fixes: 067353a46d8c ("cxl/region: Add memory hotplug notifier for cxl region")
> Cc: stable@vger.kernel.org
> Tested-by: Marc Herbert <marc.herbert@linux.intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

