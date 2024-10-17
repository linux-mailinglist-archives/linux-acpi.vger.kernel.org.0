Return-Path: <linux-acpi+bounces-8849-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB169A2967
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2024 18:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B9E3B23C19
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2024 16:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419C71DFE2A;
	Thu, 17 Oct 2024 16:41:08 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137161DF75D;
	Thu, 17 Oct 2024 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183268; cv=none; b=uAczNtredSu/r8+phLjSvTrcIuQWQ8FY6qX2QIFNYTorXxA+j3dCjJg/38oa5Rhnd/3Cw20cLCTv9akQ/tg2pqIJ59kVgNQIBECJvCD3/VFCbsA3AQD61fwaMLgWP4+ljDtowe3Y61Zh5hM9kL6ZuU4f0cNfCar+cJZ+av5GZJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183268; c=relaxed/simple;
	bh=X0A/LssMRj4VLoCivEQ4z/v91VHtuCg4Aoye4BcbcnQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gNzU7ocdYjL2bXlrLgjFdhyxN644yrW8tzu+lCaVrrnn4De7Yd+BzRic0K5+/xUeaNCaYU8hBDj3Xc163karbJkJopuktPU/FLdIvdro4pHNQd2+YiOC9bFNmy0LkgpvRb0jEV/UVRO9m25bPSzuFJiLv+X/gVdjNKHK03Am1o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTtpD31yqz6K6F4;
	Fri, 18 Oct 2024 00:39:16 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0AA1614011A;
	Fri, 18 Oct 2024 00:41:01 +0800 (CST)
Received: from localhost (10.126.174.164) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 18:41:00 +0200
Date: Thu, 17 Oct 2024 17:40:58 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<rafael@kernel.org>, <bp@alien8.de>, <dan.j.williams@intel.com>,
	<tony.luck@intel.com>, <dave@stgolabs.net>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>
Subject: Re: [RFC PATCH 6/6] cxl: Add mce notifier to emit aliased address
 for extended linear cache
Message-ID: <20241017174058.000078bc@Huawei.com>
In-Reply-To: <20240927142108.1156362-7-dave.jiang@intel.com>
References: <20240927142108.1156362-1-dave.jiang@intel.com>
	<20240927142108.1156362-7-dave.jiang@intel.com>
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

On Fri, 27 Sep 2024 07:16:58 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Below is a setup with extended linear cache configuration with an example
> layout of of memory region shown below presented as a single memory region
> consists of 256G memory where there's 128G of DRAM and 128G of CXL memory.
> The kernel sees a region of total 256G of system memory.
> 
>               128G DRAM                          128G CXL memory
> |-----------------------------------|-------------------------------------|
> 
> Data resides in either DRAM or far memory (FM) with no replication. Hot data
> is swapped into DRAM by the hardware behind the scenes. When error is detected
> in one location, it is possible that error also resides in the aliased
> location. Therefore when a memory location that is flagged by MCE is part of
> the special region, the aliased memory location needs to be offlined as well.
> 
> Add an mce notify callback to identify if the MCE address location is part of
> an extended linear cache region and handle accordingly.
> 
> Added symbol export to set_mce_nospec() in x86 code in order to call
> set_mce_nospec() from the CXL MCE notify callback.

Whilst not commenting on whether any other implementation might exist,
this code should be written to be arch independent at some level.

> 
> Link: https://lore.kernel.org/linux-cxl/668333b17e4b2_5639294fd@dwillia2-xfh.jf.intel.com.notmuch/
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>


