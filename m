Return-Path: <linux-acpi+bounces-16893-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E624B57315
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 10:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F3FC188838F
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 08:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21DD2EC570;
	Mon, 15 Sep 2025 08:36:00 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43A52E9EC6;
	Mon, 15 Sep 2025 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925360; cv=none; b=pJNqMgtIH0RYLSMmEdyrQqZfTvKcaa/6kpyxq0erBk266uqns8rGO67Km9kfPMwPVsJZf494SvhcgVbo2lvu+kzlB+D4wWPmHHVPXioNVjLwvI/G7eXAQyfOBuwqhTjZ04q+c/ibHsd7QZ3i8MGKoQGaiisj4SFLTVrRGHrjRmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925360; c=relaxed/simple;
	bh=VkcjkftJycQyIffTCSVJgTGHr7QHWCz4TzoirBJAQVU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WRyKl9vmzBeHMvUA/UOjmsFmIyQV0BlT7GlsaMlJfu+4sStVvx8McgrhW8ZOzIfL3/xniODHeWo2zrwHdYTfpZIqpc67dQBtU+MApO5zpKr+mg+QHAeyHGLbyqZjXMtiV29r0W5bjvmk7BnPDbRVSVlbwjgqblB0gmfKyDIds7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cQJFZ07vmz6M4xD;
	Mon, 15 Sep 2025 16:33:06 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 576671402EA;
	Mon, 15 Sep 2025 16:35:51 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 15 Sep
 2025 10:35:50 +0200
Date: Mon, 15 Sep 2025 09:35:49 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<andrew@kernel.org>, <bfaccini@nvidia.com>, <eahariha@linux.microsoft.com>,
	<dan.j.williams@intel.com>, <thorsten.blum@linux.dev>, <gourry@gourry.net>,
	<nunodasneves@linux.microsoft.com>, <wangyuquan1236@phytium.com.cn>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v2] acpi,srat: Fix incorrect device handle check for
 Generic Initiator
Message-ID: <20250915093549.00006109@huawei.com>
In-Reply-To: <20250913023224.39281-1-xueshuai@linux.alibaba.com>
References: <20250913023224.39281-1-xueshuai@linux.alibaba.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sat, 13 Sep 2025 10:32:24 +0800
Shuai Xue <xueshuai@linux.alibaba.com> wrote:

> The Generic Initiator Affinity Structure in SRAT table uses device
> handle type field to indicate the device type. According to ACPI
> specification, the device handle type value of 1 represents PCI device,
> not 0.
> 
> Fixes: 894c26a1c274 ("ACPI: Support Generic Initiator only domains")
> Reported-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Thanks!

> ---
> changes since v1: drop changes in actbl3.h to make it easy to progress per Jonathan
> ---
>  drivers/acpi/numa/srat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 53816dfab645..aa87ee1583a4 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -237,7 +237,7 @@ acpi_table_print_srat_entry(struct acpi_subtable_header *header)
>  		struct acpi_srat_generic_affinity *p =
>  			(struct acpi_srat_generic_affinity *)header;
>  
> -		if (p->device_handle_type == 0) {
> +		if (p->device_handle_type == 1) {
>  			/*
>  			 * For pci devices this may be the only place they
>  			 * are assigned a proximity domain


