Return-Path: <linux-acpi+bounces-16729-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4870CB54F8C
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 15:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92E03B4BF5
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 13:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7468B3074A2;
	Fri, 12 Sep 2025 13:29:36 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927CE81ACA;
	Fri, 12 Sep 2025 13:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683776; cv=none; b=RxymyijJJhksPbV1PfUPDlFbunjoh8sWnt6xUc6PJmcDce2GUMju20T+x6rG7IVrmoSim7vVqeCoXhAkvWpd9v8tZuAazP+uqYiZrcANCtLdr4uZoc56DqrBOixKhy4DHps7p43iNB8BQbtXdG2UHBEyg28bLuOyHh7mZ3yxwdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683776; c=relaxed/simple;
	bh=R9v3NwR+y68DNl6xr63+DO5nHtLQMFSg7mW26LoTY/M=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=paTlzlGE7JmjCPrKaMyGsEh42IiFmSQx8+JeKcSZcFGVjLJjZIdGIe0HUk5awdbXCCDSZqr4Rpn77TDk5gjYTxJ1H50cOvhvCFFvBvGpJMOeLTLyeANYy3RLxOCir4simP1wv5hX6Xx/NvgeiLO5N13hvjI/yzTq9H8JSm4QBwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cNZxV2v9Zz6GDFh;
	Fri, 12 Sep 2025 21:28:14 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9916F1401F4;
	Fri, 12 Sep 2025 21:29:32 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 12 Sep
 2025 15:29:31 +0200
Date: Fri, 12 Sep 2025 14:29:29 +0100
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
	Danilo Krummrich <dakr@kernel.org>, Ben Horgan <ben.horgan@arm.com>
Subject: Re: [PATCH v2 26/29] arm_mpam: Use long MBWU counters if supported
Message-ID: <20250912142929.00003cff@huawei.com>
In-Reply-To: <20250910204309.20751-27-james.morse@arm.com>
References: <20250910204309.20751-1-james.morse@arm.com>
	<20250910204309.20751-27-james.morse@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 10 Sep 2025 20:43:06 +0000
James Morse <james.morse@arm.com> wrote:

> From: Rohit Mathew <rohit.mathew@arm.com>
> 
> If the 44 bit (long) or 63 bit (LWD) counters are detected on probing
> the RIS, use long/LWD counter instead of the regular 31 bit mbwu
> counter.
> 
> Only 32bit accesses to the MSC are required to be supported by the
> spec, but these registers are 64bits. The lower half may overflow
> into the higher half between two 32bit reads. To avoid this, use
> a helper that reads the top half multiple times to check for overflow.
> 
> Signed-off-by: Rohit Mathew <rohit.mathew@arm.com>
> [morse: merged multiple patches from Rohit]
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

