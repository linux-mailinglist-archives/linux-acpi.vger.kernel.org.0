Return-Path: <linux-acpi+bounces-10299-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F2B9FBFD0
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Dec 2024 16:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C0FC7A1AA3
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Dec 2024 15:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88ED61CDFC1;
	Tue, 24 Dec 2024 15:51:20 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E070D1C4A34;
	Tue, 24 Dec 2024 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735055480; cv=none; b=mv2sQsM0vhBKZzHYdyEvZimjz9tGMwAcMB06HrRUZIL6/v20kOD9M0ed+Q6QAjU4KnBk/VWmNFQfOu9ISkfXmS9OtJqNMndhoUrDodKAU48UVxjlreZh4uzH6RamRCSz5ygY2g9thdWBNY+5J3wO8y9UTOXl0TsXXOYksXJLqek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735055480; c=relaxed/simple;
	bh=Rwp65D8HlzMHS77CO6br69GE75UQy6NZ8JuSyPfrOw4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mlamXFhdnv3aQPLFdR63sEVKl0qOhWgIkv/vj1uNho1HriPIvcmeYTjWwN9yU+dOgtft8ZEcS7tpY7pDCAbiOPiarnNiJceBrzJ36GGY4uOlFfEqnHhTpNMqbBh4sYZcIn/vMRyVYVp+AkWb9E8t4kxyCE8MO1OORmKBPZyx5yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHfV31ztqz6LDDR;
	Tue, 24 Dec 2024 23:50:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C1BAC14038F;
	Tue, 24 Dec 2024 23:51:16 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 16:51:15 +0100
Date: Tue, 24 Dec 2024 15:51:13 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
	<dan.j.williams@intel.com>, <Benjamin.Cheatham@amd.com>,
	<Avadhut.Naik@amd.com>, <viro@zeniv.linux.org.uk>, <arnd@arndb.de>,
	<ira.weiny@intel.com>, <dave.jiang@intel.com>,
	<sthanneeru.opensrc@micron.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v2 6/9] ACPI: APEI: EINJ: Add einjv2 extension struct
Message-ID: <20241224155113.00001d29@huawei.com>
In-Reply-To: <20241205211854.43215-7-zaidal@os.amperecomputing.com>
References: <20241205211854.43215-1-zaidal@os.amperecomputing.com>
	<20241205211854.43215-7-zaidal@os.amperecomputing.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu,  5 Dec 2024 13:18:51 -0800
Zaid Alali <zaidal@os.amperecomputing.com> wrote:

> Add einjv2 extension struct and EINJv2 error types to prepare
> the driver for EINJv2 support. ACPI specifications(1) enables

Reference got lost? 

> EINJv2 by extending set_error_type_with_address struct.
> 
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
> ---
>  drivers/acpi/apei/einj-core.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> index 2c57e25252ac..039d36472342 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c

> +struct einjv2_extension_struct {
> +	u32 length;
> +	u16 revision;
> +	u16 component_arr_count;
> +	struct syndrome_array component_arr[];

__counted_by marking seems appropriate here.

> +};
> +
>  struct set_error_type_with_address {
>  	u32	type;
>  	u32	vendor_extension;
> @@ -58,6 +80,7 @@ struct set_error_type_with_address {
>  	u64	memory_address;
>  	u64	memory_address_range;
>  	u32	pcie_sbdf;
> +	struct	einjv2_extension_struct einjv2_struct;
>  };
>  enum {
>  	SETWA_FLAGS_APICID = 1,


