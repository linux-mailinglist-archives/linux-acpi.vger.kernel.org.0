Return-Path: <linux-acpi+bounces-18200-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C06FC07980
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 19:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A95FA35A27B
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 17:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95710346777;
	Fri, 24 Oct 2025 17:52:48 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5E633FE26;
	Fri, 24 Oct 2025 17:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328368; cv=none; b=cyoQQOlrzCOz8Rn6Iev/ms2fxtgz8tUf1JuCEFI8XnfWhyjA41plnGm2g2VKzMfQx32NebAXFjWCNUgSC6Cxs68J6dAPcdWc1FX5+Wkit1NIBeF4uBTxOOZFLDkGq2Oz6fEw2v2V9hIBPC+LuFr4N2zwpkmFNTLfOsWv5YdmMV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328368; c=relaxed/simple;
	bh=CLuXSTG9NRI58+a1hWOBp0kNaI16bo/jqRz0pYjTLpY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FdEGrhUGKak4j0zBHao4tDPRwwHjf4tN73sLc5enHJyMsRte9LPjW2lPJLM0CR5zGZcShBijOkpGcZaDpsFq+cB3IjPPn38sJA729i7mSkYNPvBu8iVvUU+mcHqF5L1h0Q7YqczQ+xsGqtAn6rg5EU7kKE46ajNVjtcOzpiPxmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ctVlT0TySz6GD8s;
	Sat, 25 Oct 2025 01:49:25 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id E8D2F14027A;
	Sat, 25 Oct 2025 01:52:43 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 24 Oct
 2025 18:52:42 +0100
Date: Fri, 24 Oct 2025 18:52:41 +0100
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
	Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 15/29] arm_mpam: Reset MSC controls from cpuhp
 callbacks
Message-ID: <20251024185241.0000206e@huawei.com>
In-Reply-To: <20251017185645.26604-16-james.morse@arm.com>
References: <20251017185645.26604-1-james.morse@arm.com>
	<20251017185645.26604-16-james.morse@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 17 Oct 2025 18:56:31 +0000
James Morse <james.morse@arm.com> wrote:

> When a CPU comes online, it may bring a newly accessible MSC with
> it. Only the default partid has its value reset by hardware, and
> even then the MSC might not have been reset since its config was
> previously dirtied. e.g. Kexec.
> 
> Any in-use partid must have its configuration restored, or reset.
> In-use partids may be held in caches and evicted later.
> 
> MSC are also reset when CPUs are taken offline to cover cases where
> firmware doesn't reset the MSC over reboot using UEFI, or kexec
> where there is no firmware involvement.
> 
> If the configuration for a RIS has not been touched since it was
> brought online, it does not need resetting again.
> 
> To reset, write the maximum values for all discovered controls.
> 
> CC: Rohit Mathew <Rohit.Mathew@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>



