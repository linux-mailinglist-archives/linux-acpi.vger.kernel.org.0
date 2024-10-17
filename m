Return-Path: <linux-acpi+bounces-8851-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07B39A2971
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2024 18:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E0791C27622
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2024 16:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B511DFD88;
	Thu, 17 Oct 2024 16:46:44 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7B71DEFF7;
	Thu, 17 Oct 2024 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183604; cv=none; b=q1eXfw+H7qUebqB5YHGQ7qcg6Y6ZnxktkPfwDGp9PgyKP0hnyyhPxLhufmTyL7xLC/ARPOeUcXj2COXnuVSl2cTcunVCkPL4bAzr9h1JlBNewlDhsIcU4nd3VWCQpLIEFOOph43/GkjRY/DC0eOF0mvOfobXRjjBDNUiIGmEjuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183604; c=relaxed/simple;
	bh=+OzZ/uW9lk9vatz9ccIyoWr/wHQampRc/RcX0fDAyz4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XSZJ1UMiYcPJ8Ax+Ue5rir2Gw6UPSInKOL9pMF+BXpNH3aOxACmpNqM/Sp6876jkM7y6XRMYAUlstCMU9osbLT9Ykcyr8YENRve1BqiSwMKlYs3y4C58Pr/5vTShbH+ASM6zPUbmBS7pueYbDQcD5r30dVz4cKxrqYlI0so9hIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTtxw4FWTz6K9Fp;
	Fri, 18 Oct 2024 00:45:56 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 53BB814011A;
	Fri, 18 Oct 2024 00:46:37 +0800 (CST)
Received: from localhost (10.126.174.164) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 18:46:36 +0200
Date: Thu, 17 Oct 2024 17:46:34 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<rafael@kernel.org>, <bp@alien8.de>, <dan.j.williams@intel.com>,
	<tony.luck@intel.com>, <dave@stgolabs.net>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>
Subject: Re: [RFC PATCH 0/6] acpi/hmat / cxl: Add exclusive caching
 enumeration and RAS support
Message-ID: <20241017174634.000079a1@Huawei.com>
In-Reply-To: <20240927142108.1156362-1-dave.jiang@intel.com>
References: <20240927142108.1156362-1-dave.jiang@intel.com>
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
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 27 Sep 2024 07:16:52 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Hi all,
> I'm looking for comments on the approach and the implementation of dealing with
> this exclusive caching configuration. I have concerns with the discovering and
> handling of I/O hole in the memory mapping and looking for suggestions on if
> there are better ways to do it. I will be taking a 4 weeks sabbatical starting
> next week and I apologize in advance in the delay on responses. Thank you in
> advance for reviewing the patches.
> 
> The MCE folks will be interested in patch 6/6 where MCE_PRIO_CXL is added.
> 
> 
> Certain systems provide an exclusive caching memory configurations where a
> 1:1 layout of DRAM and far memory (FR) such as CXL memory is utilized. In
(FM) at least that is what you use later.


> this configuration, the memory region is provided as a single memory region
> to the OS. For example such as below:
> 
>              128GB DRAM                         128GB CXL memory
> |------------------------------------|------------------------------------|

So this differs slightly from what I expected.  
The ACPI spec change I believe allows for the CXL memory to be be N times
bigger than the cache.

I'm not against only supporting 1:1, but I didn't immediately see code
to check for that and scream if it sees something different.

Also as I mention in one of the patches, I don't recall the ACPI stuff
giving an 'order' to the two types of memory.  Maybe I'm missing that
but in theory at least I think the code needs to be more flexible
(or renamed perhaps).

Jonathan




