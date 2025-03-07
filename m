Return-Path: <linux-acpi+bounces-11925-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD45A55DDA
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Mar 2025 03:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B39B73B3C2E
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Mar 2025 02:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FFD18C00B;
	Fri,  7 Mar 2025 02:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJnGMVQy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9546C18785D;
	Fri,  7 Mar 2025 02:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741315618; cv=none; b=epCuTgQKO4LnQg+ZHSVUmDDEwum+gfiANo2b6Qn1ZE1mJfDaHURFhdg1zaGXVbetsXpDWMsLphKZhRhl0B6kjnBi6hrk51zUdMsAniIWDmPtGa1Jons2AteNMVhJnfDf6Qy18Kns9bp0xNL7yDcuq/qFpVwrKcy+RIpvNb1ZhQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741315618; c=relaxed/simple;
	bh=PDOx0j31h8/h9Hw5Hq2e6EjlX2+2KHTQdpJa0b3m/ls=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tjic8livGaJp0PgaQMjCVuaaYLGHSW1kCx1sGRkUkasbWYeZrOUEnfB4vq4jqVFmIYxqMmDS5oVlzVB5+iIpQS68bZdwXfL7F3bZq/uKBrK5lhJ7MJP3pUFVHpKpzYtuk4Yb/ZqKB66bssSQxm3q+SimptNh177UP/iBKhkh9Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJnGMVQy; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-223378e2b0dso20191695ad.0;
        Thu, 06 Mar 2025 18:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741315615; x=1741920415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e2QEuerNx36Ve8h38j5UuGqNQVWgLdwOZn9+FhlFR/8=;
        b=KJnGMVQySLQNYuUurlTbZPqZFPhwqP2feM0HcVVA2t4XIQGkJpTzh/ZIa7xaCwgoZ3
         HPfuPlKaDpptaQ8cZCISgU0UrQstl13g7P7yYUnIFZie5oQ2RLvT8QRSuITPkR8UKNgf
         N1v/fwsLfoGZ/GzLY/5sgLr2Xiyu8NaOovtf4VgMof5c/IGx5Az8Tel1xEVTzMDqgsN1
         dwY3EHjPteGNb1BseLnRMoWo0/FccHz1Zm4fNx5jAQwg5cYL0u/TCH0XfHMSRoQh/XdD
         j3UJXGFPndgYNGP+C26GUV7wa3m9WRgAYOnUW0O/nGspvmrGBmZqi1D9OG5qMhUXJnl4
         Zi0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741315615; x=1741920415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2QEuerNx36Ve8h38j5UuGqNQVWgLdwOZn9+FhlFR/8=;
        b=X74ltF4Jtxmblc2enl4Ihv1wkzVHpDGA6fP1etmEfOAgjhUZYh6q3J0zKgE6gF91K3
         9mFphwYfiTecwAiHc8NVTK3Bx/58yp0JVoEd6smdxiE35Mwaa4GS66wWP+9VGkpKqj+1
         XChYkjaEEZqmRfyaC1ZKrtXqR0w5bAYQDG8BBinl2ppgtXTV926HDcu5kNS0HZBWNvhZ
         k7ztWRWbojKer7iQISDd67uwGX8Fjgu5KFWA0ifL+bl1/SdXD71iyHuThSiVwe3ta896
         XM8NzGpwccr8+Mh6ZE+kODQ+r+peSRrM2fQwoaQfefHcclhqaGXYKxYoV3pZkH3/f5bI
         DXrg==
X-Forwarded-Encrypted: i=1; AJvYcCV7zh4402s9iPK2Zl9xpus8x7/FPxw3p42OQ0MSDVkED+MHQGs+Y5lyV6CWsSQyeHnxbOzQEYS0ql/Nog==@vger.kernel.org, AJvYcCWHAtGh2J0lRUYuEWZ4AZ2wKH6MXoEXjsHX/ScL//4BfbWSHU+vMZ/RaLryVmPxAT3xVJFE3p8fKDpOjsR5@vger.kernel.org, AJvYcCWTVNbn6WXGed6KcLhpzfgx+/d1TWfvicMA7WLS26BW7cNAL0SXu7CxEwrZfGwc+QWFjKuFqaVZwtwJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyFY4bZlze4ZvfYvt/FocmOJaC1CN32UnlxUMDzQbrIzKG9iCTA
	78f+TAvSz/pL4pmCVjneMlpdT8il9AlIX5VLrGC1Eh+QnS920/LJ
X-Gm-Gg: ASbGnctaLzUnzGD18IuSmw73QnvCLyS5BnE2NOZh9HAT2irjsuk409rD3J+AJgoP/JG
	kj04sbhA036ZREfIecwscnLYauDW0e1RB8qB5mDgu/ZBY9oQSjv7ORBryq9vZtfMDAimJo7NKd5
	VQZMZL71k+VC49r+X8gjeDDyhB3KXjUszIYwxTw31ew9H794TqOT+TgA3VTHtFzGlU6unw66CrY
	kv8B3xDZpc7x69D47OaCCDMX1q7l8/yb5fu7cM1qNp5ZQcRs7Y9jW1nfC5jcAsPJNHTXi2EELb3
	Qr2VXBlzg9Dxx5uJ/Ve87llTFe6ErKMvt3B132A=
X-Google-Smtp-Source: AGHT+IGGCWc+C20JLK/YSYbgDhPc0LYuDsVUjJzrJtp+CZGL5bkrHLd/Z6KMIm2ETKyJ3Rm5TOz4rg==
X-Received: by 2002:a17:902:da82:b0:224:1eab:97b2 with SMTP id d9443c01a7336-22428c120a4mr23605895ad.53.1741315615452;
        Thu, 06 Mar 2025 18:46:55 -0800 (PST)
Received: from debian ([2601:646:8f03:9fee:e44d:748a:50ed:471f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a91c43sm19629325ad.183.2025.03.06.18.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 18:46:54 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 6 Mar 2025 18:46:38 -0800
To: shiju.jose@huawei.com
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, david@redhat.com, Vilas.Sridharan@amd.com,
	linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, bp@alien8.de,
	tony.luck@intel.com, rafael@kernel.org, lenb@kernel.org,
	mchehab@kernel.org, leo.duran@amd.com, Yazen.Ghannam@amd.com,
	rientjes@google.com, jiaqiyan@google.com, Jon.Grimm@amd.com,
	dave.hansen@linux.intel.com, naoya.horiguchi@nec.com,
	james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
	gthelen@google.com, wschwartz@amperecomputing.com,
	dferguson@amperecomputing.com, wbs@os.amperecomputing.com,
	nifan.cxl@gmail.com, tanxiaofei@huawei.com,
	prime.zeng@hisilicon.com, roberto.sassu@huawei.com,
	kangkang.shen@futurewei.com, wanghuiqiang@huawei.com,
	linuxarm@huawei.com
Subject: Re: [PATCH 3/8] cxl/memfeature: Add CXL memory device ECS control
 feature
Message-ID: <Z8peDpw-9P00Peer@debian>
References: <20250227223816.2036-1-shiju.jose@huawei.com>
 <20250227223816.2036-4-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227223816.2036-4-shiju.jose@huawei.com>

On Thu, Feb 27, 2025 at 10:38:10PM +0000, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.2 section 8.2.10.9.11.2 describes the DDR5 ECS (Error Check
> Scrub) control feature.
> The Error Check Scrub (ECS) is a feature defined in JEDEC DDR5 SDRAM
> Specification (JESD79-5) and allows the DRAM to internally read, correct
> single-bit errors, and write back corrected data bits to the DRAM array
> while providing transparency to error counts.
> 
> The ECS control allows the requester to change the log entry type, the ECS
> threshold count (provided the request falls within the limits specified in
> DDR5 mode registers), switch between codeword mode and row count mode, and
> reset the ECS counter.
> 
> Register with EDAC device driver, which retrieves the ECS attribute
> descriptors from the EDAC ECS and exposes the ECS control attributes to
> userspace via sysfs. For example, the ECS control for the memory media FRU0
> in CXL mem0 device is located at /sys/bus/edac/devices/cxl_mem0/ecs_fru0/
> 

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/cxl/Kconfig            |   1 +
>  drivers/cxl/core/memfeatures.c | 355 ++++++++++++++++++++++++++++++++-
>  2 files changed, 355 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index b83bdb30b702..94321f5bed77 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -119,6 +119,7 @@ config CXL_RAS_FEATURES
>  	depends on CXL_FEATURES
>  	depends on EDAC=y || (CXL_BUS=m && EDAC=m)
>  	depends on EDAC_SCRUB
> +	depends on EDAC_ECS
>  	help
>  	  The CXL memory RAS feature control is optional and allows host to
>  	  control the RAS features configurations of CXL Type 3 devices.
> diff --git a/drivers/cxl/core/memfeatures.c b/drivers/cxl/core/memfeatures.c
> index 7a5c0645a07e..253930051e87 100644
> --- a/drivers/cxl/core/memfeatures.c
> +++ b/drivers/cxl/core/memfeatures.c
> @@ -19,7 +19,7 @@
>  #include <cxlmem.h>
>  #include "core.h"
>  
> -#define CXL_DEV_NUM_RAS_FEATURES	1
> +#define CXL_DEV_NUM_RAS_FEATURES	2
>  #define CXL_DEV_HOUR_IN_SECS	3600
>  
>  #define CXL_DEV_NAME_LEN	128
> @@ -428,6 +428,352 @@ static int cxl_region_scrub_init(struct cxl_region *cxlr,
>  	return 0;
>  }
>  
> +/*
> + * CXL DDR5 ECS control definitions.
> + */
> +struct cxl_ecs_context {
> +	u16 num_media_frus;
> +	u16 get_feat_size;
> +	u16 set_feat_size;
> +	u8 get_version;
> +	u8 set_version;
> +	u16 effects;
> +	struct cxl_memdev *cxlmd;
> +};
> +
> +enum {
> +	CXL_ECS_PARAM_LOG_ENTRY_TYPE,
> +	CXL_ECS_PARAM_THRESHOLD,
> +	CXL_ECS_PARAM_MODE,
> +	CXL_ECS_PARAM_RESET_COUNTER,
> +};
> +
> +#define CXL_ECS_LOG_ENTRY_TYPE_MASK	GENMASK(1, 0)
> +#define CXL_ECS_REALTIME_REPORT_CAP_MASK	BIT(0)
> +#define CXL_ECS_THRESHOLD_COUNT_MASK	GENMASK(2, 0)
> +#define CXL_ECS_COUNT_MODE_MASK	BIT(3)
> +#define CXL_ECS_RESET_COUNTER_MASK	BIT(4)
> +#define CXL_ECS_RESET_COUNTER	1
> +
> +enum {
> +	ECS_THRESHOLD_256 = 256,
> +	ECS_THRESHOLD_1024 = 1024,
> +	ECS_THRESHOLD_4096 = 4096,
> +};
> +
> +enum {
> +	ECS_THRESHOLD_IDX_256 = 3,
> +	ECS_THRESHOLD_IDX_1024 = 4,
> +	ECS_THRESHOLD_IDX_4096 = 5,
> +};
> +
> +static const u16 ecs_supp_threshold[] = {
> +	[ECS_THRESHOLD_IDX_256] = 256,
> +	[ECS_THRESHOLD_IDX_1024] = 1024,
> +	[ECS_THRESHOLD_IDX_4096] = 4096,
> +};
> +
> +enum {
> +	ECS_LOG_ENTRY_TYPE_DRAM = 0x0,
> +	ECS_LOG_ENTRY_TYPE_MEM_MEDIA_FRU = 0x1,
> +};
> +
> +enum cxl_ecs_count_mode {
> +	ECS_MODE_COUNTS_ROWS = 0,
> +	ECS_MODE_COUNTS_CODEWORDS = 1,
> +};
> +
> +/**
> + * struct cxl_ecs_params - CXL memory DDR5 ECS parameter data structure.
> + * @threshold: ECS threshold count per GB of memory cells.
> + * @log_entry_type: ECS log entry type, per DRAM or per memory media FRU.
> + * @reset_counter: [IN] reset ECC counter to default value.
> + * @count_mode: codeword/row count mode
> + *		0 : ECS counts rows with errors
> + *		1 : ECS counts codeword with errors
> + */
> +struct cxl_ecs_params {
> +	u16 threshold;
> +	u8 log_entry_type;
> +	u8 reset_counter;
> +	enum cxl_ecs_count_mode count_mode;
> +};
> +
> +/*
> + * See CXL spec rev 3.2 @8.2.10.9.11.2 Table 8-225 DDR5 ECS Control Feature
> + * Readable Attributes.
> + */
> +struct cxl_ecs_fru_rd_attrs {
> +	u8 ecs_cap;
> +	__le16 ecs_config;
> +	u8 ecs_flags;
> +}  __packed;
> +
> +struct cxl_ecs_rd_attrs {
> +	u8 ecs_log_cap;
> +	struct cxl_ecs_fru_rd_attrs fru_attrs[];
> +}  __packed;
> +
> +/*
> + * See CXL spec rev 3.2 @8.2.10.9.11.2 Table 8-226 DDR5 ECS Control Feature
> + * Writable Attributes.
> + */
> +struct cxl_ecs_fru_wr_attrs {
> +	__le16 ecs_config;
> +} __packed;
> +
> +struct cxl_ecs_wr_attrs {
> +	u8 ecs_log_cap;
> +	struct cxl_ecs_fru_wr_attrs fru_attrs[];
> +}  __packed;
> +
> +/*
> + * CXL DDR5 ECS control functions.
> + */
> +static int cxl_mem_ecs_get_attrs(struct device *dev,
> +				 struct cxl_ecs_context *cxl_ecs_ctx,
> +				 int fru_id, struct cxl_ecs_params *params)
> +{
> +	struct cxl_memdev *cxlmd = cxl_ecs_ctx->cxlmd;
> +	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
> +	struct cxl_ecs_fru_rd_attrs *fru_rd_attrs;
> +	size_t rd_data_size;
> +	u8 threshold_index;
> +	size_t data_size;
> +	u16 ecs_config;
> +
> +	rd_data_size = cxl_ecs_ctx->get_feat_size;
> +
> +	struct cxl_ecs_rd_attrs *rd_attrs __free(kvfree) =
> +		kvzalloc(rd_data_size, GFP_KERNEL);
> +	if (!rd_attrs)
> +		return -ENOMEM;
> +
> +	params->log_entry_type = 0;
> +	params->threshold = 0;
> +	params->count_mode = 0;
> +	data_size = cxl_get_feature(cxl_mbox, &CXL_FEAT_ECS_UUID,
> +				    CXL_GET_FEAT_SEL_CURRENT_VALUE,
> +				    rd_attrs, rd_data_size, 0, NULL);
> +	if (!data_size)
> +		return -EIO;
> +
> +	fru_rd_attrs = rd_attrs->fru_attrs;
> +	params->log_entry_type = FIELD_GET(CXL_ECS_LOG_ENTRY_TYPE_MASK,
> +					   rd_attrs->ecs_log_cap);
> +	ecs_config = le16_to_cpu(fru_rd_attrs[fru_id].ecs_config);
> +	threshold_index = FIELD_GET(CXL_ECS_THRESHOLD_COUNT_MASK,
> +				    ecs_config);
> +	params->threshold = ecs_supp_threshold[threshold_index];
> +	params->count_mode = FIELD_GET(CXL_ECS_COUNT_MODE_MASK,
> +				       ecs_config);
> +	return 0;
> +}
> +
> +static int cxl_mem_ecs_set_attrs(struct device *dev,
> +				 struct cxl_ecs_context *cxl_ecs_ctx,
> +				 int fru_id, struct cxl_ecs_params *params,
> +				 u8 param_type)
> +{
> +	struct cxl_memdev *cxlmd = cxl_ecs_ctx->cxlmd;
> +	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
> +	struct cxl_ecs_fru_rd_attrs *fru_rd_attrs;
> +	struct cxl_ecs_fru_wr_attrs *fru_wr_attrs;
> +	size_t rd_data_size, wr_data_size;
> +	u16 num_media_frus, count;
> +	size_t data_size;
> +	u16 ecs_config;
> +
> +	num_media_frus = cxl_ecs_ctx->num_media_frus;
> +	rd_data_size = cxl_ecs_ctx->get_feat_size;
> +	wr_data_size = cxl_ecs_ctx->set_feat_size;
> +	struct cxl_ecs_rd_attrs *rd_attrs __free(kvfree) =
> +		kvzalloc(rd_data_size, GFP_KERNEL);
> +	if (!rd_attrs)
> +		return -ENOMEM;
> +
> +	data_size = cxl_get_feature(cxl_mbox, &CXL_FEAT_ECS_UUID,
> +				    CXL_GET_FEAT_SEL_CURRENT_VALUE,
> +				    rd_attrs, rd_data_size, 0, NULL);
> +	if (!data_size)
> +		return -EIO;
> +
> +	struct cxl_ecs_wr_attrs *wr_attrs __free(kvfree) =
> +					kvzalloc(wr_data_size, GFP_KERNEL);
> +	if (!wr_attrs)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Fill writable attributes from the current attributes read
> +	 * for all the media FRUs.
> +	 */
> +	fru_rd_attrs = rd_attrs->fru_attrs;
> +	fru_wr_attrs = wr_attrs->fru_attrs;
> +	wr_attrs->ecs_log_cap = rd_attrs->ecs_log_cap;
> +	for (count = 0; count < num_media_frus; count++)
> +		fru_wr_attrs[count].ecs_config = fru_rd_attrs[count].ecs_config;
> +
> +	/*
> +	 * Fill attribute to be set for the media FRU
> +	 */
> +	ecs_config = le16_to_cpu(fru_rd_attrs[fru_id].ecs_config);
> +	switch (param_type) {
> +	case CXL_ECS_PARAM_LOG_ENTRY_TYPE:
> +		if (params->log_entry_type != ECS_LOG_ENTRY_TYPE_DRAM &&
> +		    params->log_entry_type != ECS_LOG_ENTRY_TYPE_MEM_MEDIA_FRU)
> +			return -EINVAL;
> +
> +		wr_attrs->ecs_log_cap = FIELD_PREP(CXL_ECS_LOG_ENTRY_TYPE_MASK,
> +						   params->log_entry_type);
> +		break;
> +	case CXL_ECS_PARAM_THRESHOLD:
> +		ecs_config &= ~CXL_ECS_THRESHOLD_COUNT_MASK;
> +		switch (params->threshold) {
> +		case ECS_THRESHOLD_256:
> +			ecs_config |= FIELD_PREP(CXL_ECS_THRESHOLD_COUNT_MASK,
> +						 ECS_THRESHOLD_IDX_256);
> +			break;
> +		case ECS_THRESHOLD_1024:
> +			ecs_config |= FIELD_PREP(CXL_ECS_THRESHOLD_COUNT_MASK,
> +						 ECS_THRESHOLD_IDX_1024);
> +			break;
> +		case ECS_THRESHOLD_4096:
> +			ecs_config |= FIELD_PREP(CXL_ECS_THRESHOLD_COUNT_MASK,
> +						 ECS_THRESHOLD_IDX_4096);
> +			break;
> +		default:
> +			dev_dbg(dev,
> +				"Invalid CXL ECS scrub threshold count(%d) to set\n",
> +				params->threshold);
> +			dev_dbg(dev,
> +				"Supported scrub threshold counts: %u, %u, %u\n",
> +				ECS_THRESHOLD_256, ECS_THRESHOLD_1024, ECS_THRESHOLD_4096);
> +			return -EINVAL;
> +		}
> +		break;
> +	case CXL_ECS_PARAM_MODE:
> +		if (params->count_mode != ECS_MODE_COUNTS_ROWS &&
> +		    params->count_mode != ECS_MODE_COUNTS_CODEWORDS) {
> +			dev_dbg(dev,
> +				"Invalid CXL ECS scrub mode(%d) to set\n",
> +				params->count_mode);
> +			dev_dbg(dev,
> +				"Supported ECS Modes: 0: ECS counts rows with errors,"
> +				" 1: ECS counts codewords with errors\n");
> +			return -EINVAL;
> +		}
> +		ecs_config &= ~CXL_ECS_COUNT_MODE_MASK;
> +		ecs_config |= FIELD_PREP(CXL_ECS_COUNT_MODE_MASK, params->count_mode);
> +		break;
> +	case CXL_ECS_PARAM_RESET_COUNTER:
> +		if (params->reset_counter != CXL_ECS_RESET_COUNTER)
> +			return -EINVAL;
> +
> +		ecs_config &= ~CXL_ECS_RESET_COUNTER_MASK;
> +		ecs_config |= FIELD_PREP(CXL_ECS_RESET_COUNTER_MASK, params->reset_counter);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	fru_wr_attrs[fru_id].ecs_config = cpu_to_le16(ecs_config);
> +
> +	return cxl_set_feature(cxl_mbox, &CXL_FEAT_ECS_UUID,
> +			       cxl_ecs_ctx->set_version,
> +			       wr_attrs, wr_data_size,
> +			       CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET,
> +			       0, NULL);
> +}
> +
> +#define CXL_ECS_GET_ATTR(attrib)						\
> +static int cxl_ecs_get_##attrib(struct device *dev, void *drv_data,		\
> +				int fru_id, u32 *val)				\
> +{										\
> +	struct cxl_ecs_context *ctx = drv_data;					\
> +	struct cxl_ecs_params params;						\
> +	int ret;								\
> +										\
> +	ret = cxl_mem_ecs_get_attrs(dev, ctx, fru_id, &params);			\
> +	if (ret)								\
> +		return ret;							\
> +										\
> +	*val = params.attrib;							\
> +										\
> +	return 0;								\
> +}
> +
> +CXL_ECS_GET_ATTR(log_entry_type)
> +CXL_ECS_GET_ATTR(count_mode)
> +CXL_ECS_GET_ATTR(threshold)
> +
> +#define CXL_ECS_SET_ATTR(attrib, param_type)						\
> +static int cxl_ecs_set_##attrib(struct device *dev, void *drv_data,			\
> +				int fru_id, u32 val)					\
> +{											\
> +	struct cxl_ecs_context *ctx = drv_data;						\
> +	struct cxl_ecs_params params = {						\
> +		.attrib = val,								\
> +	};										\
> +											\
> +	return cxl_mem_ecs_set_attrs(dev, ctx, fru_id, &params, (param_type));		\
> +}
> +CXL_ECS_SET_ATTR(log_entry_type, CXL_ECS_PARAM_LOG_ENTRY_TYPE)
> +CXL_ECS_SET_ATTR(count_mode, CXL_ECS_PARAM_MODE)
> +CXL_ECS_SET_ATTR(reset_counter, CXL_ECS_PARAM_RESET_COUNTER)
> +CXL_ECS_SET_ATTR(threshold, CXL_ECS_PARAM_THRESHOLD)
> +
> +static const struct edac_ecs_ops cxl_ecs_ops = {
> +	.get_log_entry_type = cxl_ecs_get_log_entry_type,
> +	.set_log_entry_type = cxl_ecs_set_log_entry_type,
> +	.get_mode = cxl_ecs_get_count_mode,
> +	.set_mode = cxl_ecs_set_count_mode,
> +	.reset = cxl_ecs_set_reset_counter,
> +	.get_threshold = cxl_ecs_get_threshold,
> +	.set_threshold = cxl_ecs_set_threshold,
> +};
> +
> +static int cxl_memdev_ecs_init(struct cxl_memdev *cxlmd,
> +			       struct edac_dev_feature *ras_feature)
> +{
> +	struct cxl_ecs_context *cxl_ecs_ctx;
> +	struct cxl_feat_entry *feat_entry;
> +	int num_media_frus;
> +
> +	feat_entry = cxl_get_feature_entry(cxlmd->cxlds, &CXL_FEAT_ECS_UUID);
> +	if (IS_ERR(feat_entry))
> +		return -EOPNOTSUPP;
> +
> +	if (!(le32_to_cpu(feat_entry->flags) & CXL_FEATURE_F_CHANGEABLE))
> +		return -EOPNOTSUPP;
> +
> +	num_media_frus = (le16_to_cpu(feat_entry->get_feat_size) -
> +			  sizeof(struct cxl_ecs_rd_attrs)) /
> +			  sizeof(struct cxl_ecs_fru_rd_attrs);
> +	if (!num_media_frus)
> +		return -EOPNOTSUPP;
> +
> +	cxl_ecs_ctx = devm_kzalloc(&cxlmd->dev, sizeof(*cxl_ecs_ctx),
> +				   GFP_KERNEL);
> +	if (!cxl_ecs_ctx)
> +		return -ENOMEM;
> +
> +	*cxl_ecs_ctx = (struct cxl_ecs_context) {
> +		.get_feat_size = le16_to_cpu(feat_entry->get_feat_size),
> +		.set_feat_size = le16_to_cpu(feat_entry->set_feat_size),
> +		.get_version = feat_entry->get_feat_ver,
> +		.set_version = feat_entry->set_feat_ver,
> +		.effects = le16_to_cpu(feat_entry->effects),
> +		.num_media_frus = num_media_frus,
> +		.cxlmd = cxlmd,
> +	};
> +
> +	ras_feature->ft_type = RAS_FEAT_ECS;
> +	ras_feature->ecs_ops = &cxl_ecs_ops;
> +	ras_feature->ctx = cxl_ecs_ctx;
> +	ras_feature->ecs_info.num_media_frus = num_media_frus;
> +
> +	return 0;
> +}
> +
>  int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
>  {
>  	struct edac_dev_feature ras_features[CXL_DEV_NUM_RAS_FEATURES];
> @@ -444,6 +790,13 @@ int devm_cxl_memdev_edac_register(struct cxl_memdev *cxlmd)
>  	if (rc != -EOPNOTSUPP)
>  		num_ras_features++;
>  
> +	rc = cxl_memdev_ecs_init(cxlmd, &ras_features[num_ras_features]);
> +	if (rc < 0 && rc != -EOPNOTSUPP)
> +		return rc;
> +
> +	if (rc != -EOPNOTSUPP)
> +		num_ras_features++;
> +
>  	snprintf(cxl_dev_name, sizeof(cxl_dev_name), "%s_%s",
>  		 "cxl", dev_name(&cxlmd->dev));
>  
> -- 
> 2.43.0
> 

