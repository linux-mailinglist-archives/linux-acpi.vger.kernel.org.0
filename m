Return-Path: <linux-acpi+bounces-4138-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A74D8739C0
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Mar 2024 15:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A39289270
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Mar 2024 14:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A16E13440D;
	Wed,  6 Mar 2024 14:49:00 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D2F131759;
	Wed,  6 Mar 2024 14:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709736540; cv=none; b=Po3hI4FCfV8EdnI1ybLNT0B+cpl+ds8iYq513/EmwGjTqV4pqMvnhj1F7WM7tiqRygMfSSwOMFjNbOK5xVEuadKfhE1xOVpdM8TV5E8LhaaFrL+6VYOjHyUy+ujSADAk/xQ4+ngG9yHFCyYT0AufWDpU1Ql5lMkMui+/EsssPH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709736540; c=relaxed/simple;
	bh=75d+921Vgrd/MF25y9yKj07lCNdQoY9StIIvrFPtlu8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fp41sP1b+mF+lFFMeQFg+4Yjf+B9MQzJdXJ92P2kreoJv0VRThuTCSz+V2zg7QfOgXisiTQr4km3DzkclQWmAupAJVza5lytGJYAXWJkyXE+YFvT+EMGvOxTvx/Tz+3bO5jWQZuF28YwqFNEqutj5/EW9O6enHW4K/gSVFFgHLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TqZw83McNz6K8L5;
	Wed,  6 Mar 2024 22:44:56 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 74328140CF4;
	Wed,  6 Mar 2024 22:48:33 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Mar
 2024 14:48:13 +0000
Date: Wed, 6 Mar 2024 14:48:12 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <rafael@kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 10/12] cxl/region: Add sysfs attribute for locality
 attributes of CXL regions
Message-ID: <20240306144812.00007ccc@Huawei.com>
In-Reply-To: <20240220231402.3156281-11-dave.jiang@intel.com>
References: <20240220231402.3156281-1-dave.jiang@intel.com>
	<20240220231402.3156281-11-dave.jiang@intel.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 20 Feb 2024 16:12:39 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add read/write latencies and bandwidth sysfs attributes for the enabled CXL
> region. The bandwidth is the aggregated bandwidth of all devices that
> contribute to the CXL region. The latency is the worst latency of the
> device amongst all the devices that contribute to the CXL region.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
One trivial comment follows though it applies in a couple of places.
Up to you whether you act on it.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> +
> +ACCESS_ATTR_RO(1, read_bandwidth);
> +ACCESS_ATTR_RO(1, read_latency);
> +ACCESS_ATTR_RO(1, write_bandwidth);
> +ACCESS_ATTR_RO(1, write_latency);
> +
> +static struct attribute *access1_coordinate_attrs[] = {
> +	ACCESS_ATTR_DECLARE(1, read_bandwidth),
> +	ACCESS_ATTR_DECLARE(1, write_bandwidth),
> +	ACCESS_ATTR_DECLARE(1, read_latency),
> +	ACCESS_ATTR_DECLARE(1, write_latency),
> +	NULL,
I'd drop that comma on the trailing entry, but there are others
already in this file that do have it, so up to you.



