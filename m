Return-Path: <linux-acpi+bounces-4164-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02FD874EAA
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Mar 2024 13:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2FF1C20CB8
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Mar 2024 12:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A7C8527D;
	Thu,  7 Mar 2024 12:12:09 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2AB82891;
	Thu,  7 Mar 2024 12:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709813529; cv=none; b=sBTGd0tD2v2M6osC6IvaMxx2HQSJMeN4mCh7dVC0bVif5Nd2K25I99Le9DfPJq4AwuY8PkcaOicG3pJkF7dGdZL67s69usSR9VHuCPwqZaEGigbNyOaYF2MAqs85QfwDqoEYAjRq4Y1+GLebqkhb7nkYhrHenxXUaWObofRf114=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709813529; c=relaxed/simple;
	bh=UnwjjV2ntMRTqmvpmWVAXUYbJq7AnQYyihE5UAuH280=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nz/rLC6OkgFCBmWefbbTn9lIQ6SLl5tVG4Zw4Ou05qc8G1FrGWGpuoMNWT8jp1UzNtmmpBv24Gny+v8QVlZ+ymG5cS5LxYV40DCOHYsU5eIigAYdwm7ya3Lc5MXPqupcL4049CQiU8dZBl8/OnYeOFpQzm30yhOXMMUmI7QWZq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tr7Nl1ZNQz6K9Dk;
	Thu,  7 Mar 2024 20:08:07 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 808D9140EDE;
	Thu,  7 Mar 2024 20:12:05 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 7 Mar
 2024 12:12:05 +0000
Date: Thu, 7 Mar 2024 12:12:04 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <dan.j.williams@intel.com>, <rafael@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <dave@stogolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v14 4/4] EINJ, Documentation: Update EINJ kernel doc
Message-ID: <20240307121204.00002e70@Huawei.com>
In-Reply-To: <20240226222704.1079449-5-Benjamin.Cheatham@amd.com>
References: <20240226222704.1079449-1-Benjamin.Cheatham@amd.com>
	<20240226222704.1079449-5-Benjamin.Cheatham@amd.com>
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

On Mon, 26 Feb 2024 16:27:04 -0600
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> Update EINJ kernel document to include how to inject CXL protocol error
> types, build the kernel to include CXL error types, and give an example
> injection.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

