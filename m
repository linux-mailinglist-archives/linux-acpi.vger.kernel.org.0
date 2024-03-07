Return-Path: <linux-acpi+bounces-4163-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AC0874EA6
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Mar 2024 13:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53DB31C22654
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Mar 2024 12:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBE712881C;
	Thu,  7 Mar 2024 12:10:53 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76BC128801;
	Thu,  7 Mar 2024 12:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709813453; cv=none; b=lQqSj5SCl6Km0D1y5QSMzjh4oyJzN9WrrfIb1u25sRlfMHCgXgP3pKrIxOv5vw1m7rBLrJE6RMdkXs7XzBdOoETy6VFZ9j2Tdgap3Otez5SUwB/Zb/SVOFgh3HnlOdtYfpEx7o1nZPzwoTwuB2/2firT0xOWh0RsAS1cLjq5hUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709813453; c=relaxed/simple;
	bh=JDLVcsIGeJuejtKFCySKnnA8gIBub+8q91W47kiwOGM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fO2f1z1S4hDwKF9BHoUkqqP5mWHdOEh3VLDyi3MjQMv37lPCMO+4ZWtgdTfSdNRqI+jItEZ74zwtLowpG5D+u4WhcU0AthoZXKo4Ia0IZvyTf5VQSJP8yc4wuG2Gp3hY60i8jYWnMETAe9okJe4z++9MkdKxyHkJIZvCu06l8UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tr7MH0TFDz6K9Gh;
	Thu,  7 Mar 2024 20:06:51 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5884E140A34;
	Thu,  7 Mar 2024 20:10:49 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 7 Mar
 2024 12:10:48 +0000
Date: Thu, 7 Mar 2024 12:10:47 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ben Cheatham <benjamin.cheatham@amd.com>
CC: <dan.j.williams@intel.com>, <rafael@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <dave@stogolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v14 3/4] cxl/core: Add CXL EINJ debugfs files
Message-ID: <20240307121047.00004b28@Huawei.com>
In-Reply-To: <fcc39ab2-d616-4be2-a816-b0037a9653a2@amd.com>
References: <20240226222704.1079449-1-Benjamin.Cheatham@amd.com>
	<20240226222704.1079449-4-Benjamin.Cheatham@amd.com>
	<fcc39ab2-d616-4be2-a816-b0037a9653a2@amd.com>
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

On Tue, 27 Feb 2024 14:14:35 -0600
Ben Cheatham <benjamin.cheatham@amd.com> wrote:

> This patch also had an outdated commit message (still referenced the einj-cxl module).
> The patch with the updated commit message is below. I also made a tiny change to
> the format specifier of the einj_inject file to "0x%llx\n" from "%llx\n".
> 
> Thanks,
> Ben
> 
> From 321129893da9129473c447772a461c1a4e9e0e9d Mon Sep 17 00:00:00 2001
> From: Ben Cheatham <Benjamin.Cheatham@amd.com>
> Date: Fri, 16 Feb 2024 11:17:01 -0600
> Subject: [PATCH v14 3/4] cxl/core: Add CXL EINJ debugfs files
> 
> Export CXL helper functions in einj-cxl.c for getting/injecting
> available CXL protocol error types to sysfs under kernel/debug/cxl.
> 
> The kernel/debug/cxl/einj_types file will print the available CXL
> protocol errors in the same format as the available_error_types
> file provided by the einj module. The
> kernel/debug/cxl/$dport_dev/einj_inject file is functionally the same
> as the error_type and error_inject files provided by the EINJ module,
> i.e.: writing an error type into $dport_dev/einj_inject will inject
> said error type into the CXL dport represented by $dport_dev.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
LGTM other than not sending patches like this as tooling won't pick them up!
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


