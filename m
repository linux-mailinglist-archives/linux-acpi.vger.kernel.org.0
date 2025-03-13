Return-Path: <linux-acpi+bounces-12173-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61825A5EFC0
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 10:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0F81177381
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 09:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E04265624;
	Thu, 13 Mar 2025 09:40:05 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EACF265610;
	Thu, 13 Mar 2025 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741858805; cv=none; b=E2lHsEDIp9OIys6zkTdbCxfaHbz2nqDEeSQoC7Xar9c33ILzB+t0si4WaQgl6BZd23cSP8Flv0MYj731HJEv8pUbhMIu8ENmoULKO+VEcEQW7Y9Iqxjwkz56Zacx7cKVOe7ZdfhlWUxuD3bK7CyyCilZbn9aNkLlWJHIZC1czNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741858805; c=relaxed/simple;
	bh=OanOg2QJhwZ6mKdmGf8UyGOz8ytmi0JebT8MUuN1NtE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mm4TlZ8A9DUYhlsa5OWRKt/Q/MOG5vv3GkeyXPtrQ7CWZg/vH39GEx9ij9e+yVLN65PHvdgobwlpp0I768gogpCBgxecqFKzz/P0qIe+mbrQTs3iJgYkB8DgMMXTrIEdOnnyvKeGVYn8AbowNK6leUQjpHfzlEOH60lJmE8FBDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZD2RQ1ztrz6J6g3;
	Thu, 13 Mar 2025 17:35:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 96D80140442;
	Thu, 13 Mar 2025 17:40:01 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 13 Mar
 2025 10:40:00 +0100
Date: Thu, 13 Mar 2025 09:39:59 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
	<dan.j.williams@intel.com>, <Benjamin.Cheatham@amd.com>,
	<Avadhut.Naik@amd.com>, <viro@zeniv.linux.org.uk>, <arnd@arndb.de>,
	<ira.weiny@intel.com>, <dave.jiang@intel.com>,
	<sthanneeru.opensrc@micron.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v4 5/9] ACPI: APEI: EINJ: Enable the discovery of EINJv2
 capabilities
Message-ID: <20250313093959.0000619d@huawei.com>
In-Reply-To: <20250306234810.75511-6-zaidal@os.amperecomputing.com>
References: <20250306234810.75511-1-zaidal@os.amperecomputing.com>
	<20250306234810.75511-6-zaidal@os.amperecomputing.com>
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

On Thu,  6 Mar 2025 15:48:06 -0800
Zaid Alali <zaidal@os.amperecomputing.com> wrote:

> Enable the driver to show all supported error injections for EINJ
> and EINJv2 at the same time. EINJv2 capabilities can be discovered
> by checking the return value of get_error_type, where bit 30 set
> indicates EINJv2 support.
> 
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
Trivial comment for another day inline.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/acpi/apei/apei-internal.h |  2 +-
>  drivers/acpi/apei/einj-core.c     | 64 ++++++++++++++++++++++++-------
>  drivers/acpi/apei/einj-cxl.c      |  2 +-
>  3 files changed, 52 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
> index cd2766c69d78..77c10a7a7a9f 100644
> --- a/drivers/acpi/apei/apei-internal.h
> +++ b/drivers/acpi/apei/apei-internal.h
> @@ -131,7 +131,7 @@ static inline u32 cper_estatus_len(struct acpi_hest_generic_status *estatus)
>  
>  int apei_osc_setup(void);
>  
> -int einj_get_available_error_type(u32 *type);
> +int einj_get_available_error_type(u32 *type, int einj_action);
>  int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
>  		      u64 param4);
>  int einj_cxl_rch_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> index 3f828f9265a8..aee9a7b17313 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -33,6 +33,7 @@
>  #define SLEEP_UNIT_MAX		5000			/* 5ms */
>  /* Firmware should respond within 1 seconds */
>  #define FIRMWARE_TIMEOUT	(1 * USEC_PER_SEC)
> +#define ACPI65_EINJV2_SUPP	BIT(30)
>  #define ACPI5_VENDOR_BIT	BIT(31)
>  #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
>  				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
> @@ -84,6 +85,7 @@ static struct debugfs_blob_wrapper vendor_errors;
>  static char vendor_dev[64];
>  
>  static u32 available_error_type;
> +static u32 available_error_type_v2;
>  
>  /*
>   * Some BIOSes allow parameters to the SET_ERROR_TYPE entries in the
> @@ -159,13 +161,13 @@ static void einj_exec_ctx_init(struct apei_exec_context *ctx)
>  			   EINJ_TAB_ENTRY(einj_tab), einj_tab->entries);
>  }
>  
> -static int __einj_get_available_error_type(u32 *type)
> +static int __einj_get_available_error_type(u32 *type, int einj_action)
>  {
>  	struct apei_exec_context ctx;
>  	int rc;
>  
>  	einj_exec_ctx_init(&ctx);
> -	rc = apei_exec_run(&ctx, ACPI_EINJ_GET_ERROR_TYPE);
> +	rc = apei_exec_run(&ctx, einj_action);
>  	if (rc)
>  		return rc;
>  	*type = apei_exec_ctx_get_output(&ctx);
> @@ -174,12 +176,12 @@ static int __einj_get_available_error_type(u32 *type)
>  }
>  
>  /* Get error injection capabilities of the platform */
> -int einj_get_available_error_type(u32 *type)
> +int einj_get_available_error_type(u32 *type, int einj_action)
>  {
>  	int rc;
>  
>  	mutex_lock(&einj_mutex);

Might be worth looking at using guard(mutex) in here to simplify paths.
But that's a job for another day!

> -	rc = __einj_get_available_error_type(type);
> +	rc = __einj_get_available_error_type(type, einj_action);
>  	mutex_unlock(&einj_mutex);
>  
>  	return rc;


