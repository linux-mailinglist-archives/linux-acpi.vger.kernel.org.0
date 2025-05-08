Return-Path: <linux-acpi+bounces-13637-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F57AAF709
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 11:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 372A81727B6
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 09:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC041D86DC;
	Thu,  8 May 2025 09:45:49 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363611BEF7D;
	Thu,  8 May 2025 09:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746697549; cv=none; b=lsffi9pYNpatzA6xCQ8sbGubbLSh8PbyVXqbEPm/FkEw9CkfU6lQKoiSoZrRW58diaB8e3hA5Oorphgl2AxtPFRSyqA90LeyxaP1Cj6Lnwp/FXDQVNjamDJ+IXDmx4rNueqf22WC8wOolQ+FDzxt9JPSrzgTjikcEv125+PPEK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746697549; c=relaxed/simple;
	bh=7mgsxlwXgZTpgICxXGcZhTz23FBiew9Od/LMjNg6saI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RNMuiUn0LnVN1dA6J0OtGwXrwaGtkn7iQ04E6ZhyhjGqog5sQdZXfxmjzuX1J5V+iObfWGFQmCpzQYfiaCWi4MOITmydgEeEcyL7H7x+OUiR38QmMr+asXA4mLYlCQR1qkBBebhMGs0w6WEy7glv5Lr9vZn6gCpQIAlE1wFxucE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZtS136R71z6K9Xl;
	Thu,  8 May 2025 17:45:27 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E8ECC140121;
	Thu,  8 May 2025 17:45:43 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 8 May
 2025 11:45:43 +0200
Date: Thu, 8 May 2025 10:45:41 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alison Schofield <alison.schofield@intel.com>
CC: Yuquan Wang <wangyuquan1236@phytium.com.cn>, <dan.j.williams@intel.com>,
	<rppt@kernel.org>, <rafael@kernel.org>, <lenb@kernel.org>,
	<akpm@linux-foundation.org>, <rrichter@amd.com>, <bfaccini@nvidia.com>,
	<haibo1.xu@intel.com>, <david@redhat.com>, <chenhuacai@kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<chenbaozi@phytium.com.cn>, <loongarch@lists.linux.dev>
Subject: Re: [PATCH v3 1/1] mm: numa_memblks: introduce
 numa_add_reserved_memblk
Message-ID: <20250508104541.00007c4f@huawei.com>
In-Reply-To: <aBwuY7Rj3mpr5Pm4@aschofie-mobl2.lan>
References: <20250508022719.3941335-1-wangyuquan1236@phytium.com.cn>
	<aBwuY7Rj3mpr5Pm4@aschofie-mobl2.lan>
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
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 7 May 2025 21:09:07 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> On Thu, May 08, 2025 at 10:27:19AM +0800, Yuquan Wang wrote:
> > acpi_parse_cfmws() currently adds empty CFMWS ranges to numa_meminfo
> > with the expectation that numa_cleanup_meminfo moves them to
> > numa_reserved_meminfo. There is no need for that indirection when it is
> > known in advance that these unpopulated ranges are meant for
> > numa_reserved_meminfo in support of future hotplug / CXL provisioning.
> > 
> > Introduce and use numa_add_reserved_memblk() to add the empty CFMWS
> > ranges directly.
> > 
> > Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>  
> 
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> 
> 
> 

Yuquan - I'm guessing this is a misunderstanding of process.
The patch submitter should pick up tags on previous versions.
If any are not picked up in the tag block there should be a clear
explanation of why!

Jonathan

