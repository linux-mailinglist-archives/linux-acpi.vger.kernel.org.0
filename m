Return-Path: <linux-acpi+bounces-10519-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E44A09798
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jan 2025 17:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D3D16B31A
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jan 2025 16:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF8F211A13;
	Fri, 10 Jan 2025 16:35:03 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB95205507;
	Fri, 10 Jan 2025 16:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736526903; cv=none; b=AeZBOP0q5ez6i8689/ZoM/7hmu9UxugCpdWYJAAx1E+3ztqdIlnS+9mjxKM7KmG6yCc+dmKv0idT9Vg4gOg+EVsjxbgwD7TVTXh6pSF9njOrEdehqn0B1nSHg/8J8YyTKlu3/ABeVxTNJeW9cWYsLFj7QDRcU+QOdR45a7etZzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736526903; c=relaxed/simple;
	bh=fgEDOWuoyuZMMmN5upDq1yqC87LVXMUPG5TS3B2kVG0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HMCY8+yr1YMJxzBT4UzfjoxidKycZBATzil+rUzBtPYXM7xtMDkz0qSNYkz372xoves5rmz2KQqfHFxqwWS4YrAZQkopw4L3pNL1M2HrdVu7uEfUvtk6PPj5zu2WbaAYl/dz7Qv8V38FUcQmcIez2VhojJBkvlMJBNyBbsp5eB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YV6Zd0krNz6JB2k;
	Sat, 11 Jan 2025 00:30:17 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 937C2140B63;
	Sat, 11 Jan 2025 00:34:58 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 10 Jan
 2025 17:34:58 +0100
Date: Fri, 10 Jan 2025 16:34:56 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<rafael@kernel.org>, <bp@alien8.de>, <dan.j.williams@intel.com>,
	<tony.luck@intel.com>, <dave@stgolabs.net>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>
Subject: Re: [PATCH v2 4/4] cxl: Add mce notifier to emit aliased address
 for extended linear cache
Message-ID: <20250110163456.00003903@huawei.com>
In-Reply-To: <20250110151913.3462283-5-dave.jiang@intel.com>
References: <20250110151913.3462283-1-dave.jiang@intel.com>
	<20250110151913.3462283-5-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 10 Jan 2025 08:17:47 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Below is a setup with extended linear cache configuration with an example
> layout of memory region shown below presented as a single memory region
> consists of 256G memory where there's 128G of DRAM and 128G of CXL memory.
> The kernel sees a region of total 256G of system memory.
> 
>               128G DRAM                          128G CXL memory
> |-----------------------------------|-------------------------------------|
> 
> Data resides in either DRAM or far memory (FM) with no replication. Hot
> data is swapped into DRAM by the hardware behind the scenes. When error is
> detected in one location, it is possible that error also resides in the
> aliased location. Therefore when a memory location that is flagged by MCE
> is part of the special region, the aliased memory location needs to be
> offlined as well.
> 
> Add an mce notify callback to identify if the MCE address location is part
> of an extended linear cache region and handle accordingly.
> 
> Added symbol export to set_mce_nospec() in x86 code in order to call
> set_mce_nospec() from the CXL MCE notify callback.
> 
> Link: https://lore.kernel.org/linux-cxl/668333b17e4b2_5639294fd@dwillia2-xfh.jf.intel.com.notmuch/
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2:
> - Update new EXPORT_SYMOBOL_() input. (Jonathan)

typo  Though this get dropped anyway so not important!

> - Remove unnecessary pointer cast. (Jonathan)
> - Introduce CONFIG_CXL_MCE to shield from missing CONFIG_MEMORY_FAILURE kbuilds.
> - Emit alias address0 (Jonathan)


