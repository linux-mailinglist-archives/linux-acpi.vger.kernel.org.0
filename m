Return-Path: <linux-acpi+bounces-6772-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0E5927BC0
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jul 2024 19:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0438828AFF5
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jul 2024 17:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0581B3F3D;
	Thu,  4 Jul 2024 17:11:01 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2851D1AEFF7;
	Thu,  4 Jul 2024 17:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720113061; cv=none; b=TeQK4W21BBRoXL+QT7BCqWQq+uPrScl0/ka2kAd40ikTkqDibaIgZZRISXUJrqFSOCjgRlc1QJLVDduv7J/AlsbTfA3VoVtgpownaqHw6sPv4IgNJbiCePmZjbWgFmkqLv6QDI1JkiX6d5ISHmT/XR4mpcJuCc57jbuVEZ4xAx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720113061; c=relaxed/simple;
	bh=se7hGGJS76ibaSDWgXMSdvT5qXceFTD9ouhexyozp6U=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j9zHE7thzxQmrRaCG3sOnjOGjtrn9dxR9lWeXPmm6hht9x3vR1dyWgdRjwN/1HbOEGYOVmKzsV5bj9VC4+Olmuv2FKzWAsZ6znBS58ysTZtbtFrhdx59sKDlHZKrpEA7ueZs7dFDIa7VE2RfuGW/IWiN3bZEc+9XOAkRYWoRFlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFNSQ1d8dz6JBH9;
	Fri,  5 Jul 2024 01:10:14 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 1FEEC1409EA;
	Fri,  5 Jul 2024 01:10:56 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 4 Jul
 2024 18:10:55 +0100
Date: Thu, 4 Jul 2024 18:10:54 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Ho-Ren (Jack) Chuang" <horen.chuang@linux.dev>
CC: "Huang, Ying" <ying.huang@intel.com>, Gregory Price
	<gourry.memverge@gmail.com>, <aneesh.kumar@linux.ibm.com>, <mhocko@suse.com>,
	<tj@kernel.org>, <john@jagalactic.com>, Eishan Mirakhur
	<emirakhur@micron.com>, Vinicius Tavares Petrucci <vtavarespetr@micron.com>,
	Ravis OpenSrc <Ravis.OpenSrc@micron.com>, Alistair Popple
	<apopple@nvidia.com>, Srinivasulu Thanneeru <sthanneeru@micron.com>, SeongJae
 Park <sj@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Dave Jiang
	<dave.jiang@intel.com>, "Dan Williams" <dan.j.williams@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, "Ho-Ren (Jack) Chuang" <horenc@vt.edu>, "Ho-Ren (Jack)
 Chuang" <horenchuang@bytedance.com>, "Ho-Ren (Jack) Chuang"
	<horenchuang@gmail.com>, <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3] memory tier: consolidate the initialization of
 memory tiers
Message-ID: <20240704181054.00001f67@Huawei.com>
In-Reply-To: <20240704072646.437579-1-horen.chuang@linux.dev>
References: <20240704072646.437579-1-horen.chuang@linux.dev>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu,  4 Jul 2024 07:26:44 +0000
"Ho-Ren (Jack) Chuang" <horen.chuang@linux.dev> wrote:

> The current memory tier initialization process is distributed across
> two different functions, memory_tier_init() and memory_tier_late_init().
> This design is hard to maintain. Thus, this patch is proposed to reduce
> the possible code paths by consolidating different
> initialization patches into one.
> 
> The earlier discussion with Jonathan and Ying is listed here:
> https://lore.kernel.org/lkml/20240405150244.00004b49@Huawei.com/
> 
> If we want to put these two initializations together, they must be
> placed together in the later function. Because only at that time,
> the HMAT information will be ready, adist between nodes can be
> calculated, and memory tiering can be established based on the adist.
> So we position the initialization at memory_tier_init() to the
> memory_tier_late_init() call. Moreover, it's natural to keep
> memory_tier initialization in drivers at device_initcall() level.
> 
> If we simply move the set_node_memory_tier() from memory_tier_init()
> to late_initcall(), it will result in HMAT not registering
> the mt_adistance_algorithm callback function, because
> set_node_memory_tier() is not performed during the memory tiering
> initialization phase, leading to a lack of correct default_dram
> information.
> 
> Therefore, we introduced a nodemask to pass the information of the
> default DRAM nodes. The reason for not choosing to reuse
> default_dram_type->nodes is that it is not clean enough. So in the end,
> we use a __initdata variable, which is a variable that is released once
> initialization is complete, including both CPU and memory nodes for HMAT
> to iterate through.
> 
> This patchset is based on commits <cf93be18fa1b> ("memory tier: create
> CPUless memory tiers after obtaining HMAT info") and
> <a72a30af550c> ("memory tier: dax/kmem: introduce an abstract layer for
> finding, allocating, and putting memory types"):
> [0/2] https://lkml.kernel.org/r/20240405000707.2670063-1-horenchuang@bytedance.com
> [1/2] https://lkml.kernel.org/r/20240405000707.2670063-2-horenchuang@bytedance.com
> [1/2] https://lkml.kernel.org/r/20240405000707.2670063-3-horenchuang@bytedance.com
> 
> Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


