Return-Path: <linux-acpi+bounces-6937-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F5C93413E
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jul 2024 19:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FDB81F220C9
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jul 2024 17:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B631181B9A;
	Wed, 17 Jul 2024 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkIF3E48"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C793FB1B;
	Wed, 17 Jul 2024 17:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721236467; cv=none; b=mM3bsW//spBmeajBc+WeI+K4Pt3tO3B5pdA4G9js6qLStVaU+o0uVcDos6OAJ4WvMoQrvgup13vKn2oaZKECylDLVfVuE+BXHM1eh4UiVPNKcO/jO4iDiXLzh+Y+yCJYrBSddJkklJ8qzP0AG1Nrdk1LHe4cU3K8RPmv5rlclTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721236467; c=relaxed/simple;
	bh=tEXdaulW2f20dXpuenXh8bUFdqo+7Z1BGL9pU1HsRqQ=;
	h=Message-ID:From:Date:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4YKDMy5cFNmn/5zcM1U83Uwlt+ugvsSZP1LUAHbEu6yMeDy2RWTVmqh9Vk5Ocfiu1cCQC5ffn8ydtiw1N+1IiL1V9tqmkqwSAUm+CDjPF52QIWky1gKsAwodxWqzfop7lIRHFDTYxTzAwo0eBWxY6orTCoz3gjtdy9s46+mEA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkIF3E48; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-651da7c1531so252227b3.0;
        Wed, 17 Jul 2024 10:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721236464; x=1721841264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:date:from:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kLkXS4JNkxJPRpT02NgFAng+HVvSx9yoDRGZiEauZGI=;
        b=CkIF3E48+59cM9p+H71bikoUITx8tq1Lte+WQ5md7n4VG54fjOBRSqJgMvX5nOD4l7
         shqIsKZcdwpRh7vxayhItL/1bs49Qklo7NZH/oakiO+09jDZ2q04GVBUr7xs86XSfuz9
         h5T8nXOfMu7eq30TAOOrF3d3hdqs1JX/5x8y+H9UUFywsmqFuHuqNWp0CwI3Wft1th3W
         lU4ZuQ79kcpgQSilh9O+NtgZFtwKPBaR+jY/0UyKUObmNtX/dViII8f+LFJ9vP+xDSPg
         XduQtRzjTxIYGjYPyMfKEehphqSJvvhLOOu2HvV0GxfmHVdvrrW94Id4I35rBDx6h/R/
         Vx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721236464; x=1721841264;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:date:from:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLkXS4JNkxJPRpT02NgFAng+HVvSx9yoDRGZiEauZGI=;
        b=BxTzNSCQqDgSvfLIg97tzZyW7D+Aknd7qdP8bV9dzqeBHe7DxunMQ3tLBg7AgsrkMy
         nrEIlH8vAhi7LyVfEEz+XOQLqQrb5JNpnMMNOCjGxerOqCD1+Lf4UmB/cifR2B+n7Owy
         ctuTQncCM6bUlyPqaBQqNWJz9rJcrc3IwtvaoYe5iZfoAy30r/zpAWb23V1X99Lr5XPs
         ItpInRC2UxKbFCWCZGS0LtRgPBooea9dSylm2sB9oVDwZdickpnPZ0MfJhG42800LK96
         6CvSSV23nemcUfQV6nogUJOUZaTuyxsmmA5ONRsX/os2bf7CtT75DGtCvZEB4sGsKIaN
         GDXA==
X-Forwarded-Encrypted: i=1; AJvYcCU5MwPSimeKSEsv5gjNzm+RsyMSCoCRqLzdYVibZfB9RYP0d/2Ny2pPPgZt+A6VKo/K75KmifcOqvzs4bn4JoOgzAZYeOkvlKBW0QrsVcoAoUn7edn4OgYYQl/yH/te8obh+sdkwc4wYP8tH2E9iJsrkO+tVudmzdrpMFCiBulBahLs7g==
X-Gm-Message-State: AOJu0YzFIgK4JYvZi1elp4A20To/LT0XbhqbfAV0t2AXHf0d8qMf8bYM
	6yw+I76zFrOFlQuGyDzsmLS6TVZBGtR6MprrGZnuqbDIVE4Idndp
X-Google-Smtp-Source: AGHT+IGv0Fp8VtqtaEbxPcnhkeI+TU2IkWi0U9x446wbrGVqb0eUoIkz99EP6B5DwE3+FcxH0Eyo1Q==
X-Received: by 2002:a05:6902:1614:b0:e05:e1d5:8852 with SMTP id 3f1490d57ef6-e05ed6de401mr2844209276.13.1721236464289;
        Wed, 17 Jul 2024 10:14:24 -0700 (PDT)
Received: from gpd. ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e05fea266desm6231276.22.2024.07.17.10.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 10:14:23 -0700 (PDT)
Message-ID: <6697fbef.250a0220.24877d.00a7@mx.google.com>
X-Google-Original-Message-ID: <Zpf7tF5678aZwus_@gpd.>
From: nifan.cxl@gmail.com
X-Google-Original-From: fan@gpd.
Date: Wed, 17 Jul 2024 10:13:24 -0700
To: shiju.jose@huawei.com
Cc: linux-edac@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bp@alien8.de, tony.luck@intel.com,
	rafael@kernel.org, lenb@kernel.org, mchehab@kernel.org,
	dan.j.williams@intel.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, david@redhat.com, Vilas.Sridharan@amd.com,
	leo.duran@amd.com, Yazen.Ghannam@amd.com, rientjes@google.com,
	jiaqiyan@google.com, Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
	naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com,
	somasundaram.a@hpe.com, erdemaktas@google.com, pgonda@google.com,
	duenwen@google.com, mike.malvestuto@intel.com, gthelen@google.com,
	wschwartz@amperecomputing.com, dferguson@amperecomputing.com,
	wbs@os.amperecomputing.com, nifan.cxl@gmail.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
	wanghuiqiang@huawei.com, linuxarm@huawei.com
Subject: Re: [RFC PATCH v9 03/11] EDAC: Add EDAC ECS control driver
References: <20240716150336.2042-1-shiju.jose@huawei.com>
 <20240716150336.2042-4-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716150336.2042-4-shiju.jose@huawei.com>

On Tue, Jul 16, 2024 at 04:03:27PM +0100, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add EDAC ECS (Error Check Scrub) control driver supports configuring
> the memory device's ECS feature.
> 
> The Error Check Scrub (ECS) is a feature defined in JEDEC DDR5 SDRAM
> Specification (JESD79-5) and allows the DRAM to internally read, correct
> single-bit errors, and write back corrected data bits to the DRAM array
> while providing transparency to error counts.
> 
> The DDR5 device contains number of memory media FRUs per device. The
> DDR5 ECS feature and thus the ECS control driver supports configuring
> the ECS parameters per FRU.
> 
> The memory devices supports ECS feature register with the EDAC ECS driver
> and thus with the generic EDAC RAS feature driver, which adds the sysfs
> ECS control interface. The ECS control attributes are exposed to the
> userspace in /sys/bus/edac/devices/<dev-name>/ecs_fruX/.
> 
> Generic EDAC ECS driver and the common sysfs ECS interface promotes
> unambiguous control from the userspace irrespective of the underlying
> devices, support ECS feature.
> 
> The support for ECS feature is added separately because the DDR5 ECS
> feature's control attributes are dissimilar from those of the scrub
> feature.
> 
> Note: Documentation can be added if necessary.
> 
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/edac/Makefile            |   2 +-
>  drivers/edac/edac_ecs.c          | 396 +++++++++++++++++++++++++++++++
>  drivers/edac/edac_ras_feature.c  |   5 +
>  include/linux/edac_ras_feature.h |  36 +++
>  4 files changed, 438 insertions(+), 1 deletion(-)
>  create mode 100755 drivers/edac/edac_ecs.c
> 
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index de56cbd039eb..c1412c7d3efb 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -10,7 +10,7 @@ obj-$(CONFIG_EDAC)			:= edac_core.o
>  
>  edac_core-y	:= edac_mc.o edac_device.o edac_mc_sysfs.o
>  edac_core-y	+= edac_module.o edac_device_sysfs.o wq.o
> -edac_core-y	+= edac_ras_feature.o edac_scrub.o
> +edac_core-y	+= edac_ras_feature.o edac_scrub.o edac_ecs.o
>  
>  edac_core-$(CONFIG_EDAC_DEBUG)		+= debugfs.o
>  
> diff --git a/drivers/edac/edac_ecs.c b/drivers/edac/edac_ecs.c
> new file mode 100755
> index 000000000000..37dabd053c36
> --- /dev/null
> +++ b/drivers/edac/edac_ecs.c
> @@ -0,0 +1,396 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ECS driver supporting controlling on die error check scrub
> + * (e.g. DDR5 ECS). The common sysfs ECS interface promotes
> + * unambiguous access from the userspace.
> + *
> + * Copyright (c) 2024 HiSilicon Limited.
> + */
> +
> +#define pr_fmt(fmt)     "EDAC ECS: " fmt
> +
> +#include <linux/edac_ras_feature.h>
> +
> +#define EDAC_ECS_FRU_NAME "ecs_fru"
> +
> +enum edac_ecs_attributes {
> +	ecs_log_entry_type,
> +	ecs_log_entry_type_per_dram,
> +	ecs_log_entry_type_per_memory_media,
> +	ecs_mode,
> +	ecs_mode_counts_rows,
> +	ecs_mode_counts_codewords,
> +	ecs_reset,
> +	ecs_name,
> +	ecs_threshold,
> +	ecs_max_attrs
> +};

As mentioned in other review, use uppercase.

Fan

> +
> +struct edac_ecs_dev_attr {
> +	struct device_attribute dev_attr;
> +	int fru_id;
> +};
> +
> +struct edac_ecs_fru_context {
> +	char name[EDAC_RAS_NAME_LEN];
> +	struct edac_ecs_dev_attr ecs_dev_attr[ecs_max_attrs];
> +	struct attribute *ecs_attrs[ecs_max_attrs + 1];
> +	struct attribute_group group;
> +};
> +
> +struct edac_ecs_context {
> +	u16 num_media_frus;
> +	struct edac_ecs_fru_context *fru_ctxs;
> +};
> +
> +#define to_ecs_dev_attr(_dev_attr)	\
> +	container_of(_dev_attr, struct edac_ecs_dev_attr, dev_attr)
> +
> +static ssize_t log_entry_type_show(struct device *ras_feat_dev,
> +				   struct device_attribute *attr,
> +				   char *buf)
> +{
> +	struct edac_ecs_dev_attr *ecs_dev_attr = to_ecs_dev_attr(attr);
> +	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_ecs_ops *ops = ctx->ecs.ops;
> +	u64 val;
> +	int ret;
> +
> +	ret = ops->get_log_entry_type(ras_feat_dev->parent, ctx->ecs.private,
> +				      ecs_dev_attr->fru_id, &val);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "0x%llx\n", val);
> +}
> +
> +static ssize_t log_entry_type_store(struct device *ras_feat_dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t len)
> +{
> +	struct edac_ecs_dev_attr *ecs_dev_attr = to_ecs_dev_attr(attr);
> +	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_ecs_ops *ops = ctx->ecs.ops;
> +	long val;
> +	int ret;
> +
> +	ret = kstrtol(buf, 10, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ops->set_log_entry_type(ras_feat_dev->parent, ctx->ecs.private,
> +				      ecs_dev_attr->fru_id, val);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static ssize_t log_entry_type_per_dram_show(struct device *ras_feat_dev,
> +					    struct device_attribute *attr,
> +					    char *buf)
> +{
> +	struct edac_ecs_dev_attr *ecs_dev_attr = to_ecs_dev_attr(attr);
> +	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_ecs_ops *ops = ctx->ecs.ops;
> +	u64 val;
> +	int ret;
> +
> +	ret = ops->get_log_entry_type_per_dram(ras_feat_dev->parent, ctx->ecs.private,
> +					       ecs_dev_attr->fru_id, &val);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "0x%llx\n", val);
> +}
> +
> +static ssize_t log_entry_type_per_memory_media_show(struct device *ras_feat_dev,
> +						    struct device_attribute *attr,
> +						    char *buf)
> +{
> +	struct edac_ecs_dev_attr *ecs_dev_attr = to_ecs_dev_attr(attr);
> +	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_ecs_ops *ops = ctx->ecs.ops;
> +	u64 val;
> +	int ret;
> +
> +	ret = ops->get_log_entry_type_per_memory_media(ras_feat_dev->parent,
> +						       ctx->ecs.private,
> +						       ecs_dev_attr->fru_id, &val);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "0x%llx\n", val);
> +}
> +
> +static ssize_t mode_show(struct device *ras_feat_dev,
> +			 struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct edac_ecs_dev_attr *ecs_dev_attr = to_ecs_dev_attr(attr);
> +	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_ecs_ops *ops = ctx->ecs.ops;
> +	u64 val;
> +	int ret;
> +
> +	ret = ops->get_mode(ras_feat_dev->parent, ctx->ecs.private,
> +			    ecs_dev_attr->fru_id, &val);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "0x%llx\n", val);
> +}
> +
> +static ssize_t mode_store(struct device *ras_feat_dev,
> +			  struct device_attribute *attr,
> +			  const char *buf, size_t len)
> +{
> +	struct edac_ecs_dev_attr *ecs_dev_attr = to_ecs_dev_attr(attr);
> +	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_ecs_ops *ops = ctx->ecs.ops;
> +	long val;
> +	int ret;
> +
> +	ret = kstrtol(buf, 10, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ops->set_mode(ras_feat_dev->parent, ctx->ecs.private,
> +			    ecs_dev_attr->fru_id, val);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static ssize_t mode_counts_rows_show(struct device *ras_feat_dev,
> +				     struct device_attribute *attr,
> +				     char *buf)
> +{
> +	struct edac_ecs_dev_attr *ecs_dev_attr = to_ecs_dev_attr(attr);
> +	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_ecs_ops *ops = ctx->ecs.ops;
> +	u64 val;
> +	int ret;
> +
> +	ret = ops->get_mode_counts_rows(ras_feat_dev->parent, ctx->ecs.private,
> +					ecs_dev_attr->fru_id, &val);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "0x%llx\n", val);
> +}
> +
> +static ssize_t mode_counts_codewords_show(struct device *ras_feat_dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	struct edac_ecs_dev_attr *ecs_dev_attr = to_ecs_dev_attr(attr);
> +	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_ecs_ops *ops = ctx->ecs.ops;
> +	u64 val;
> +	int ret;
> +
> +	ret = ops->get_mode_counts_codewords(ras_feat_dev->parent, ctx->ecs.private,
> +					     ecs_dev_attr->fru_id, &val);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "0x%llx\n", val);
> +}
> +
> +static ssize_t reset_store(struct device *ras_feat_dev,
> +			   struct device_attribute *attr,
> +			   const char *buf, size_t len)
> +{
> +	struct edac_ecs_dev_attr *ecs_dev_attr = to_ecs_dev_attr(attr);
> +	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_ecs_ops *ops = ctx->ecs.ops;
> +	long val;
> +	int ret;
> +
> +	ret = kstrtol(buf, 10, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ops->reset(ras_feat_dev->parent, ctx->ecs.private,
> +			 ecs_dev_attr->fru_id, val);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static ssize_t name_show(struct device *ras_feat_dev,
> +			 struct device_attribute *attr, char *buf)
> +{
> +	struct edac_ecs_dev_attr *ecs_dev_attr = to_ecs_dev_attr(attr);
> +	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_ecs_ops *ops = ctx->ecs.ops;
> +	int ret;
> +
> +	ret = ops->get_name(ras_feat_dev->parent, ctx->ecs.private,
> +			    ecs_dev_attr->fru_id, buf);
> +	if (ret)
> +		return ret;
> +
> +	return strlen(buf);
> +}
> +
> +static ssize_t threshold_show(struct device *ras_feat_dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	struct edac_ecs_dev_attr *ecs_dev_attr = to_ecs_dev_attr(attr);
> +	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_ecs_ops *ops = ctx->ecs.ops;
> +	int ret;
> +	u64 val;
> +
> +	ret = ops->get_threshold(ras_feat_dev->parent, ctx->ecs.private,
> +				 ecs_dev_attr->fru_id, &val);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "0x%llx\n", val);
> +}
> +
> +static ssize_t threshold_store(struct device *ras_feat_dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t len)
> +{
> +	struct edac_ecs_dev_attr *ecs_dev_attr = to_ecs_dev_attr(attr);
> +	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_ecs_ops *ops = ctx->ecs.ops;
> +	long val;
> +	int ret;
> +
> +	ret = kstrtol(buf, 10, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ops->set_threshold(ras_feat_dev->parent, ctx->ecs.private,
> +				 ecs_dev_attr->fru_id, val);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
> +static umode_t ecs_attr_visible(struct kobject *kobj,
> +				struct attribute *a, int attr_id)
> +{
> +	struct device *ras_feat_dev = kobj_to_dev(kobj);
> +	struct edac_ras_feat_ctx *ctx = dev_get_drvdata(ras_feat_dev);
> +	const struct edac_ecs_ops *ops = ctx->ecs.ops;
> +
> +	switch (attr_id) {
> +	case ecs_log_entry_type:
> +		if (ops->get_log_entry_type && ops->set_log_entry_type)
> +			return a->mode;
> +		if (ops->get_log_entry_type)
> +			return 0444;
> +		return 0;
> +	case ecs_log_entry_type_per_dram:
> +		return ops->get_log_entry_type_per_dram ? a->mode : 0;
> +	case ecs_log_entry_type_per_memory_media:
> +		return ops->get_log_entry_type_per_memory_media ? a->mode : 0;
> +	case ecs_mode:
> +		if (ops->get_mode && ops->set_mode)
> +			return a->mode;
> +		if (ops->get_mode)
> +			return 0444;
> +		return 0;
> +	case ecs_mode_counts_rows:
> +		return ops->get_mode_counts_rows ? a->mode : 0;
> +	case ecs_mode_counts_codewords:
> +		return ops->get_mode_counts_codewords ? a->mode : 0;
> +	case ecs_reset:
> +		return ops->reset ? a->mode : 0;
> +	case ecs_name:
> +		return ops->get_name ? a->mode : 0;
> +	case ecs_threshold:
> +		if (ops->get_threshold && ops->set_threshold)
> +			return a->mode;
> +		if (ops->get_threshold)
> +			return 0444;
> +		return 0;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +#define EDAC_ECS_ATTR_RO(_name, _fru_id)       \
> +	((struct edac_ecs_dev_attr) { .dev_attr = __ATTR_RO(_name), \
> +				     .fru_id = _fru_id })
> +
> +#define EDAC_ECS_ATTR_WO(_name, _fru_id)       \
> +	((struct edac_ecs_dev_attr) { .dev_attr = __ATTR_WO(_name), \
> +				     .fru_id = _fru_id })
> +
> +#define EDAC_ECS_ATTR_RW(_name, _fru_id)       \
> +	((struct edac_ecs_dev_attr) { .dev_attr = __ATTR_RW(_name), \
> +				     .fru_id = _fru_id })
> +
> +static int ecs_create_desc(struct device *ecs_dev,
> +			   const struct attribute_group **attr_groups,
> +			   u16 num_media_frus)
> +{
> +	struct edac_ecs_context *ecs_ctx;
> +	u32 fru;
> +
> +	ecs_ctx = devm_kzalloc(ecs_dev, sizeof(*ecs_ctx), GFP_KERNEL);
> +	if (!ecs_ctx)
> +		return -ENOMEM;
> +
> +	ecs_ctx->num_media_frus = num_media_frus;
> +	ecs_ctx->fru_ctxs = devm_kcalloc(ecs_dev, num_media_frus,
> +					 sizeof(*ecs_ctx->fru_ctxs),
> +					 GFP_KERNEL);
> +	if (!ecs_ctx->fru_ctxs)
> +		return -ENOMEM;
> +
> +	for (fru = 0; fru < num_media_frus; fru++) {
> +		struct edac_ecs_fru_context *fru_ctx = &ecs_ctx->fru_ctxs[fru];
> +		struct attribute_group *group = &fru_ctx->group;
> +		int i;
> +
> +		fru_ctx->ecs_dev_attr[0] = EDAC_ECS_ATTR_RW(log_entry_type, fru);
> +		fru_ctx->ecs_dev_attr[1] = EDAC_ECS_ATTR_RO(log_entry_type_per_dram, fru);
> +		fru_ctx->ecs_dev_attr[2] = EDAC_ECS_ATTR_RO(log_entry_type_per_memory_media, fru);
> +		fru_ctx->ecs_dev_attr[3] = EDAC_ECS_ATTR_RW(mode, fru);
> +		fru_ctx->ecs_dev_attr[4] = EDAC_ECS_ATTR_RO(mode_counts_rows, fru);
> +		fru_ctx->ecs_dev_attr[5] = EDAC_ECS_ATTR_RO(mode_counts_codewords, fru);
> +		fru_ctx->ecs_dev_attr[6] = EDAC_ECS_ATTR_WO(reset, fru);
> +		fru_ctx->ecs_dev_attr[7] = EDAC_ECS_ATTR_RO(name, fru);
> +		fru_ctx->ecs_dev_attr[8] = EDAC_ECS_ATTR_RW(threshold, fru);
> +		for (i = 0; i < ecs_max_attrs; i++)
> +			fru_ctx->ecs_attrs[i] = &fru_ctx->ecs_dev_attr[i].dev_attr.attr;
> +
> +		sprintf(fru_ctx->name, "%s%d", EDAC_ECS_FRU_NAME, fru);
> +		group->name = fru_ctx->name;
> +		group->attrs = fru_ctx->ecs_attrs;
> +		group->is_visible  = ecs_attr_visible;
> +
> +		attr_groups[fru] = group;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * edac_ecs_get_desc - get edac ecs descriptors
> + * @ecs_dev: client ecs device
> + * @attr_groups: pointer to attrribute group container
> + * @num_media_frus: number of media FRUs in the device
> + *
> + * Returns 0 on success, error otherwise.
> + */
> +int edac_ecs_get_desc(struct device *ecs_dev,
> +		      const struct attribute_group **attr_groups,
> +		      u16 num_media_frus)
> +{
> +	if (!ecs_dev || !attr_groups || !num_media_frus)
> +		return -EINVAL;
> +
> +	return ecs_create_desc(ecs_dev, attr_groups, num_media_frus);
> +}
> diff --git a/drivers/edac/edac_ras_feature.c b/drivers/edac/edac_ras_feature.c
> index 48927f868372..a02ffbcc1c1e 100755
> --- a/drivers/edac/edac_ras_feature.c
> +++ b/drivers/edac/edac_ras_feature.c
> @@ -47,10 +47,15 @@ static int edac_ras_feat_ecs_init(struct device *parent,
>  				  const struct attribute_group **attr_groups)
>  {
>  	int num = efeat->ecs_info.num_media_frus;
> +	int ret;
>  
>  	edata->ops = efeat->ecs_ops;
>  	edata->private = efeat->ecs_ctx;
>  
> +	ret = edac_ecs_get_desc(parent, attr_groups, num);
> +	if (ret)
> +		return ret;
> +
>  	return num;
>  }
>  
> diff --git a/include/linux/edac_ras_feature.h b/include/linux/edac_ras_feature.h
> index 462f9ecbf9d4..153f8a3557f1 100755
> --- a/include/linux/edac_ras_feature.h
> +++ b/include/linux/edac_ras_feature.h
> @@ -47,10 +47,46 @@ struct edac_scrub_ops {
>  
>  const struct attribute_group *edac_scrub_get_desc(void);
>  
> +/**
> + * struct ecs_ops - ECS device operations (all elements optional)
> + * @get_log_entry_type: read the log entry type value.
> + * @set_log_entry_type: set the log entry type value.
> + * @get_log_entry_type_per_dram: read the log entry type per dram value.
> + * @get_log_entry_type_memory_media: read the log entry type per memory media value.
> + * @get_mode: read the mode value.
> + * @set_mode: set the mode value.
> + * @get_mode_counts_rows: read the mode counts rows value.
> + * @get_mode_counts_codewords: read the mode counts codewords value.
> + * @reset: reset the ECS counter.
> + * @get_threshold: read the threshold value.
> + * @set_threshold: set the threshold value.
> + * @get_name: get the ECS's name.
> + */
> +struct edac_ecs_ops {
> +	int (*get_log_entry_type)(struct device *dev, void *drv_data, int fru_id, u64 *val);
> +	int (*set_log_entry_type)(struct device *dev, void *drv_data, int fru_id, u64 val);
> +	int (*get_log_entry_type_per_dram)(struct device *dev, void *drv_data,
> +					   int fru_id, u64 *val);
> +	int (*get_log_entry_type_per_memory_media)(struct device *dev, void *drv_data,
> +						   int fru_id, u64 *val);
> +	int (*get_mode)(struct device *dev, void *drv_data, int fru_id, u64 *val);
> +	int (*set_mode)(struct device *dev, void *drv_data, int fru_id, u64 val);
> +	int (*get_mode_counts_rows)(struct device *dev, void *drv_data, int fru_id, u64 *val);
> +	int (*get_mode_counts_codewords)(struct device *dev, void *drv_data, int fru_id, u64 *val);
> +	int (*reset)(struct device *dev, void *drv_data, int fru_id, u64 val);
> +	int (*get_threshold)(struct device *dev, void *drv_data, int fru_id, u64 *threshold);
> +	int (*set_threshold)(struct device *dev, void *drv_data, int fru_id, u64 threshold);
> +	int (*get_name)(struct device *dev, void *drv_data, int fru_id, char *buf);
> +};
> +
>  struct edac_ecs_ex_info {
>  	u16 num_media_frus;
>  };
>  
> +int edac_ecs_get_desc(struct device *ecs_dev,
> +		      const struct attribute_group **attr_groups,
> +		      u16 num_media_frus);
> +
>  /*
>   * EDAC RAS feature information structure
>   */
> -- 
> 2.34.1
> 

