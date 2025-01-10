Return-Path: <linux-acpi+bounces-10517-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B549A09746
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jan 2025 17:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920891881FBE
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jan 2025 16:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A4C212D83;
	Fri, 10 Jan 2025 16:25:31 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D68212D93;
	Fri, 10 Jan 2025 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736526331; cv=none; b=oW8M3wss0kILb0Jm0sMWecPgbKO0OEaUBGpkHNmJI5LmOS4PyPDsQ9in2W2FF3EJQYdJGQRqp1sITsbeApjE7y2S16zfJPNV6vy7BnlOLNKZ1SIBMG8/HX94RfGSsEOAcy4Wa7L982Qlwz9IjDk5utXF89lSzxVcPuo9XM9Rw2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736526331; c=relaxed/simple;
	bh=wLjfmgGiu2XrA5lV5v9LtNUSzshUKvHbygKXWknjVu4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hEEjX/vZac/9iifvTVqEue96CnYPZtErq1vpTVWY73AdxMJEx9PT2R5sTv5MdR73APs3olJEcpYdwVzbD1uuEjKdcE29x+aVEh3qFeipVoRGeEVxQwxog46ClaYPYgajTAAKGxxu/45hASWg3uLKAHjjoQQa0jbD2wSIkRpVtLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YV6Mc6NKmz6JB2r;
	Sat, 11 Jan 2025 00:20:44 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C7921408F9;
	Sat, 11 Jan 2025 00:25:26 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 10 Jan
 2025 17:25:25 +0100
Date: Fri, 10 Jan 2025 16:25:24 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<rafael@kernel.org>, <bp@alien8.de>, <dan.j.williams@intel.com>,
	<tony.luck@intel.com>, <dave@stgolabs.net>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>
Subject: Re: [PATCH v2 2/4] acpi/hmat / cxl: Add extended linear cache
 support for CXL
Message-ID: <20250110162524.00004d1b@huawei.com>
In-Reply-To: <20250110151913.3462283-3-dave.jiang@intel.com>
References: <20250110151913.3462283-1-dave.jiang@intel.com>
	<20250110151913.3462283-3-dave.jiang@intel.com>
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

On Fri, 10 Jan 2025 08:17:45 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> The current cxl region size only indicates the size of the CXL memory
> region without accounting for the extended linear cache size. Retrieve the
> cache size from HMAT and append that to the cxl region size for the cxl
> region range that matches the SRAT range that has extended linear cache
> enabled.
> 
> The SRAT defines the whole memory range that includes the extended linear
> cache and the CXL memory region. The new HMAT ECN/ECR to the Memory Side
> Cache Information Structure defines the size of the extended linear cache
> size and matches to the SRAT Memory Affinity Structure by the memory
> proxmity domain. Add a helper to match the cxl range to the SRAT memory
> range in order to retrieve the cache size.
> 
> There are several places that checks the cxl region range against the
> decoder range. Use new helper to check between the two ranges and address
> the new cache size.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



