Return-Path: <linux-acpi+bounces-18205-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E284C07BB6
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 20:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6794D4F9A09
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 18:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A7C311956;
	Fri, 24 Oct 2025 18:25:00 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B119E1F17E8;
	Fri, 24 Oct 2025 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761330300; cv=none; b=BUODZjGZBNyDXYesF3tBA0IVyzs2o8kRSP98j4H86wQYCDSxDXNuYDgOOJ7zliPIZfkq5JnNh6KWVS1CmYCYPVCtVx4TYzcu6RCQD42EguWZE5f9CmI6x6MhX173eOLKj0EB1PLSRfMJG3VAUrzzDSKuvy++tFfO08bkHmeF69c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761330300; c=relaxed/simple;
	bh=KkEXNeFNONC4/6eH/vlbfMozECHHHd8MRFjwl5bknp0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uxGQxqaCch8l9ZzfaTDX0gMBIu5+VvchvBh7ZgrR6Bk+VduGeRzqLqlUBhLVEzq0/XOMwTYKF0g2inehugcvA0CTfcHOxSjMM9HPDRxJBGQwtPcfJc3KBeLBPQpunN4zzcUBpO6qGDtwofGC06Hw/PxoGQN8CB7Y26ujso+UuSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ctWSb3pGKz6GDFr;
	Sat, 25 Oct 2025 02:21:35 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 765B3140276;
	Sat, 25 Oct 2025 02:24:54 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 24 Oct
 2025 19:24:53 +0100
Date: Fri, 24 Oct 2025 19:24:51 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: James Morse <james.morse@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>, Koba
 Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
	<fenghuay@nvidia.com>, <baisheng.gao@unisoc.com>, Rob Herring
	<robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>, "Rafael Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla
	<sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>,
	Gavin Shan <gshan@redhat.com>, Ben Horgan <ben.horgan@arm.com>
Subject: Re: [PATCH v3 25/29] arm_mpam: Probe for long/lwd mbwu counters
Message-ID: <20251024192451.00007ffb@huawei.com>
In-Reply-To: <20251017185645.26604-26-james.morse@arm.com>
References: <20251017185645.26604-1-james.morse@arm.com>
	<20251017185645.26604-26-james.morse@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 17 Oct 2025 18:56:41 +0000
James Morse <james.morse@arm.com> wrote:

> From: Rohit Mathew <rohit.mathew@arm.com>
> 
> mpam v0.1 and versions above v1.0 support optional long counter for
> memory bandwidth monitoring. The MPAMF_MBWUMON_IDR register has fields
> indicating support for long counters.
> 
> Probe these feature bits.
> 
> The mpam_feat_msmon_mbwu feature is used to indicate that bandwidth
> monitors are supported, instead of muddling this with which size of
> bandwidth monitors, add an explicit 31 bit counter feature.
> 
> Signed-off-by: Rohit Mathew <rohit.mathew@arm.com>
> [ morse: Added 31bit counter feature to simplify later logic ]
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
With or without the change Ben suggested.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

