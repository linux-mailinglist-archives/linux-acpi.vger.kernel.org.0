Return-Path: <linux-acpi+bounces-4161-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ECA874E50
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Mar 2024 12:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 470841C22C5B
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Mar 2024 11:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44CF1292C0;
	Thu,  7 Mar 2024 11:52:29 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F94127B7C;
	Thu,  7 Mar 2024 11:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709812349; cv=none; b=Dw8OreNajps9e0icg9H5WwHYBFtg/JFtdLzUD4U0EuAZIp2p2HCwyyLpOwD8KJ0VCH7SBcuPUd664Iw7FlVYZq2UqWP7XAO31oTG+kfN65ItqCgv4MIkC+ojbjPhzwFLeCGK9iOBzMaEqs65lwQK7/b97bqbzWM51Eaf2rJVJNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709812349; c=relaxed/simple;
	bh=dn38CN8WfWjt4vTcx16K27zg6xgAPSAHSgtXGkPcf1A=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qf7X0gnZGXvjXUEUG0CpwItXaEbc5VqRVkGhUrYybx3pe/KWMxe+C3FMyZwdN5w8AOr8XyMOc4+wsWJqbEt9yA2T1yp+Qoih2BLDXeiqRwicmZqZ0q5rCsp3U3icVlipje7rnbANPDm4HzW3UmWlbP0bQ3Db3VXZunO73NalS64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tr6y05PF9z6K9D9;
	Thu,  7 Mar 2024 19:48:24 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0BED9141B20;
	Thu,  7 Mar 2024 19:52:23 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 7 Mar
 2024 11:52:22 +0000
Date: Thu, 7 Mar 2024 11:52:21 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <dan.j.williams@intel.com>, <rafael@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <dave@stogolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v14 1/4] EINJ: Migrate to a platform driver
Message-ID: <20240307115221.000039ab@Huawei.com>
In-Reply-To: <20240226222704.1079449-2-Benjamin.Cheatham@amd.com>
References: <20240226222704.1079449-1-Benjamin.Cheatham@amd.com>
	<20240226222704.1079449-2-Benjamin.Cheatham@amd.com>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 26 Feb 2024 16:27:01 -0600
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> Change the EINJ module to install a platform device/driver on module
> init and move the module init() and exit() functions to driver probe and
> remove. This change allows the EINJ module to load regardless of whether
> setting up EINJ succeeds, which allows dependent modules to still load
> (i.e. the CXL core).
> 
> Since EINJ may no longer be initialized when the module loads, any
> functions that are called from dependent/external modules should check
> the einj_initialized variable before calling any EINJ functions.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
Looks good to me.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I did wonder if a debug message was needed on no acpi support given
that should be really really obvious on a system, but I guess with
late probing of this from a module, maybe that is still useful.

Jonathan


