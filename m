Return-Path: <linux-acpi+bounces-3517-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE8F855E48
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 10:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD2E7B31EB9
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 09:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AB514002;
	Thu, 15 Feb 2024 09:33:29 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD8E1C290;
	Thu, 15 Feb 2024 09:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989609; cv=none; b=Hh9nBZ9hsKcRjdMyXq9NxPyyHwVYGDyy9JB7XW6wWLbJkrCj7qlcVf80Lz6Ea1JNI1/6nJl+0oPlgxqKTw0OgFlmQHwAQK0QBJVTM86Xl/z70b24/lVn+uDNDv0O+K3JpGf2LgWD3AYsJRX5Zk//6DMLmdPSrJaRhtmi1da+Qe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989609; c=relaxed/simple;
	bh=XcY6l45QO6lnI+tAYMdjp2gDS/JA/wkhgyzDiGZTQoQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MY+FfZNhJMzrm+/mMaujIAr4n3bDQTkJ6qCNAdWDLHaZLZ5St8Sv2N2HrgZmAaPfu/LGBUnX4wm057QLlDI9+F+9zydH3XUv4KDyHQHIvzGs5uEZdZqaWXo8lceD1BPg7Jga6zHphJ//rjepuL/MXRvRNVq5Do5FOkppuwCi3nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tb8sG2JCXz6JB39;
	Thu, 15 Feb 2024 17:29:22 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 4AD321400D4;
	Thu, 15 Feb 2024 17:33:24 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 09:33:23 +0000
Date: Thu, 15 Feb 2024 09:33:22 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <dan.j.williams@intel.com>, <rafael@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <dave@stogolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v12 2/3] cxl/core, EINJ: Add EINJ CXL debugfs files and
 EINJ helper functions
Message-ID: <20240215093322.00000a5e@Huawei.com>
In-Reply-To: <20240214200709.777166-3-Benjamin.Cheatham@amd.com>
References: <20240214200709.777166-1-Benjamin.Cheatham@amd.com>
	<20240214200709.777166-3-Benjamin.Cheatham@amd.com>
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

On Wed, 14 Feb 2024 14:07:08 -0600
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> Implement CXL helper functions in the EINJ module for getting/injecting
> available CXL protocol error types and export them to sysfs under
> kernel/debug/cxl.
> 
> The kernel/debug/cxl/einj_types file will print the available CXL
> protocol errors in the same format as the available_error_types
> file provided by the EINJ module. The
> kernel/debug/cxl/$dport_dev/einj_inject is functionally the same as the
> error_type and error_inject files provided by the EINJ module, i.e.:
> writing an error type into $dport_dev/einj_inject will inject said error
> type into the CXL dport represented by $dport_dev.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>

Hi Ben,

Just one trivial thing to add to Dan's comments.

> diff --git a/include/linux/einj-cxl.h b/include/linux/einj-cxl.h
> new file mode 100644
> index 000000000000..92c0e2e37ad9
> --- /dev/null
> +++ b/include/linux/einj-cxl.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * CXL protocol Error INJection support.
> + *
> + * Copyright (c) 2023 Advanced Micro Devices, Inc.
> + * All Rights Reserved.
> + *
> + * Author: Ben Cheatham <benjamin.cheatham@amd.com>
> + */
> +#ifndef CXL_EINJ_H
> +#define CXL_EINJ_H
> +
> +#include <linux/pci.h>
> +
> +#if IS_ENABLED(CONFIG_ACPI_APEI_EINJ)
> +int einj_cxl_available_error_type_show(struct seq_file *m, void *v);
> +int einj_cxl_inject_error(struct pci_dev *dport_dev, u64 type);
> +int einj_cxl_inject_rch_error(u64 rcrb, u64 type);
> +bool einj_is_initialized(void);
> +#else // !IS_ENABLED(CONFIG_ACPI_APEI_EINJ)
Whilst C++ Style comments are allowed for a few specific case, you should stick
to local style. In the include directory a quick grep gave me loads of
#else /*  */
lines and only 2
#else //

So C style comments preferred.


> +static inline int einj_cxl_available_error_type_show(struct seq_file *m,
> +						     void *v)
> +{
> +	return -ENXIO;
> +}
> +
> +static inline int einj_cxl_inject_error(struct pci_dev *dport_dev, u64 type)
> +{
> +	return -ENXIO;
> +}
> +
> +static inline int einj_cxl_inject_rch_error(u64 rcrb, u64 type)
> +{
> +	return -ENXIO;
> +}
> +
> +static inline bool einj_is_initialized(void) { return false; }
> +#endif // CONFIG_ACPI_APEI_EINJ
> +
> +#endif // CXL_EINJ_H


