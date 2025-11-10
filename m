Return-Path: <linux-acpi+bounces-18741-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B62DC48188
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 17:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD74C3AF6DC
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Nov 2025 16:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1276E27A476;
	Mon, 10 Nov 2025 16:23:39 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E9F26ED5B;
	Mon, 10 Nov 2025 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762791819; cv=none; b=gCYR3nDfYGGZhqjXs7D44D4BRUUOjCKRIGo+M3860hB/kO1lVVq6o8JVtWSFZM4iScGTyeDnLfz+MlZP8kMYqy6fh5Z0JslXB9fi5Dy4Ypxv/oyxBLx6Dd3xCxeh1yPyUc0nS+Hs6dNbrtTD87cHrMPJjMtt33iDo2FUVyGaG8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762791819; c=relaxed/simple;
	bh=8ZT2OXNdZ2uBCLKH/JF4yu29nQu0BrS1b7YRJ7GigqM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a6ZSgJGS/jFX0ZxrbvpLdXX8qWQ9Td9gwXvoonNvkfMB2vJldzs/lnn4XmriOsJHD6151zCeWAG9VTgSZJEUbfIggjj7PXsmEyt6xUcys7iumAyXOPjBn1m3hJlSHWL3ycttp9lLNo1FTC7umGXhRcCY56z2oeJ5xapACtmFt3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d4w2F3PGtzHnH6F;
	Tue, 11 Nov 2025 00:23:17 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id DBB3C1402F5;
	Tue, 11 Nov 2025 00:23:32 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 10 Nov
 2025 16:23:31 +0000
Date: Mon, 10 Nov 2025 16:23:30 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Ben Horgan <ben.horgan@arm.com>
CC: <james.morse@arm.com>, <amitsinght@marvell.com>,
	<baisheng.gao@unisoc.com>, <baolin.wang@linux.alibaba.com>,
	<bobo.shaobowang@huawei.com>, <carl@os.amperecomputing.com>,
	<catalin.marinas@arm.com>, <dakr@kernel.org>, <dave.martin@arm.com>,
	<david@redhat.com>, <dfustini@baylibre.com>, <fenghuay@nvidia.com>,
	<gregkh@linuxfoundation.org>, <gshan@redhat.com>, <guohanjun@huawei.com>,
	<jeremy.linton@arm.com>, <kobak@nvidia.com>, <lcherian@marvell.com>,
	<lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lpieralisi@kernel.org>, <peternewman@google.com>, <quic_jiles@quicinc.com>,
	<rafael@kernel.org>, <robh@kernel.org>, <rohit.mathew@arm.com>,
	<scott@os.amperecomputing.com>, <sdonthineni@nvidia.com>,
	<sudeep.holla@arm.com>, <tan.shaopeng@fujitsu.com>, <will@kernel.org>,
	<xhao@linux.alibaba.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: Re: [PATCH 09/33] ACPI / MPAM: Parse the MPAM table
Message-ID: <20251110162330.00002917@huawei.com>
In-Reply-To: <20251107123450.664001-10-ben.horgan@arm.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
	<20251107123450.664001-10-ben.horgan@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 7 Nov 2025 12:34:26 +0000
Ben Horgan <ben.horgan@arm.com> wrote:

> From: James Morse <james.morse@arm.com>
> 
> Add code to parse the arm64 specific MPAM table, looking up the cache
> level from the PPTT and feeding the end result into the MPAM driver.
> 
> This happens in two stages. Platform devices are created first for the
> MSC devices. Once the driver probes it calls acpi_mpam_parse_resources()
> to discover the RIS entries the MSC contains.
> 
> For now the MPAM hook mpam_ris_create() is stubbed out, but will update
> the MPAM driver with optional discovered data about the RIS entries.
> 
> CC: Carl Worth <carl@os.amperecomputing.com>
> Link: https://developer.arm.com/documentation/den0065/3-0bet/?lang=en
> Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
Nothing to add to Gavin's comments.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>





