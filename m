Return-Path: <linux-acpi+bounces-18203-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E42BC07B47
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 20:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4A991C4420D
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 18:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B386F33B964;
	Fri, 24 Oct 2025 18:18:57 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D22348440;
	Fri, 24 Oct 2025 18:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329937; cv=none; b=QXU+9kofsSCXHHpcFLZLxqJqRWC7YHuoivwxl8/8vdZnEDC198G6mUIb7cYepOG32nVCo5kp+ywZibhTy2x+kcvHYnnpT2OiqIpY9IOpbVB1ORJYK4N4/roPmEsdQqXJFcvQ20UPtS5MYtXwZprpBinG+TAyqN7AL5NDmCYHmkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329937; c=relaxed/simple;
	bh=6EN6VUcThMiYj1R8UhAjoa3oHbeRXy85Ty5i7arv1nk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d32FL5K5OfMZv+CwJUSPZ6rXfzeLZ3oC9s3lqeWJ1XQXYyI49jd/J77NsuPSCFexuhrIbM0Vbrdt+ZsaE8NP4Mu8S9d8orc7PXccUwJOcKr+9xuUHW1ci6xQ0aQS+imDMkogcURk+eOQzOHwrkQ+bWvHcIewnRnGVjCTAHNIYSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ctWKc3PZ5z6GDCt;
	Sat, 25 Oct 2025 02:15:32 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 669201400CB;
	Sat, 25 Oct 2025 02:18:51 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 24 Oct
 2025 19:18:50 +0100
Date: Fri, 24 Oct 2025 19:18:48 +0100
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
Subject: Re: [PATCH v3 23/29] arm_mpam: Add mpam_msmon_read() to read
 monitor value
Message-ID: <20251024191848.00007331@huawei.com>
In-Reply-To: <20251017185645.26604-24-james.morse@arm.com>
References: <20251017185645.26604-1-james.morse@arm.com>
	<20251017185645.26604-24-james.morse@arm.com>
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

On Fri, 17 Oct 2025 18:56:39 +0000
James Morse <james.morse@arm.com> wrote:

> Reading a monitor involves configuring what you want to monitor, and
> reading the value. Components made up of multiple MSC may need values
> from each MSC. MSCs may take time to configure, returning 'not ready'.
> The maximum 'not ready' time should have been provided by firmware.
> 
> Add mpam_msmon_read() to hide all this. If (one of) the MSC returns
> not ready, then wait the full timeout value before trying again.
> 
> CC: Shanker Donthineni <sdonthineni@nvidia.com>
> Signed-off-by: James Morse <james.morse@arm.com>

Seems fine. Just the trivial comment below.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>



> +static int _msmon_read(struct mpam_component *comp, struct mon_read *arg)
> +{
> +	int err,  any_err = 0;
extra space after ,

> +	struct mpam_vmsc *vmsc;




