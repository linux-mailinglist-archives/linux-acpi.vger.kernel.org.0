Return-Path: <linux-acpi+bounces-6213-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B252F8FE230
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 11:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B15561C23E6C
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Jun 2024 09:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B7913E05C;
	Thu,  6 Jun 2024 09:03:50 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6857413E051;
	Thu,  6 Jun 2024 09:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664630; cv=none; b=Exy+E+/jE4DVVDSgkJC2M68PsL2U+CiORoCT0uDeWpvQ3iTcH3Hi84TWQ1WeBhGI6d99wGrD34ZkWseVeBQCsLTwppelf1JYuBlMcv97fvEx+U7pPEdwoCEZpsLTELudlIfq4x4cEReH4qwoMGsaUlPHKdhUfhPw1wp0qQ32TCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664630; c=relaxed/simple;
	bh=2zYvUiFXb9ziA9s/CGnzNXB/lGHZdt5gQLZKHADzUqk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sIV6a2S6RxfVrc8YAC4vuKwu81eGvtALvi68bnb8Q+E9Z85I9LC2Oe448vfRMBAvwBZoX665nTenUEU4AweJ5UADdGpfSSAlraLgZwhl2YzIFR8XfNByuMN5nPh5B1YFBIHPuMiVJ7yawTbFmzJGaDslrSogecdcFoSV6w75BbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vvyv05TkPz6JBZ1;
	Thu,  6 Jun 2024 16:59:24 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A07B1408F9;
	Thu,  6 Jun 2024 17:03:45 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 6 Jun
 2024 10:03:44 +0100
Date: Thu, 6 Jun 2024 10:03:43 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Huang Ying <ying.huang@intel.com>
CC: "Rafael J . Wysocki" <rafael@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Bharata B Rao <bharata@amd.com>,
	Alistair Popple <apopple@nvidia.com>, "Aneesh Kumar K . V"
	<aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] acpi,hmat: Use ACCESS_COORDINATE_CPU when appropriate
Message-ID: <20240606100343.000075ea@Huawei.com>
In-Reply-To: <20240606022845.189710-1-ying.huang@intel.com>
References: <20240606022845.189710-1-ying.huang@intel.com>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu,  6 Jun 2024 10:28:45 +0800
Huang Ying <ying.huang@intel.com> wrote:

> To improve the readability of the code via replacing the magic number
> "1" with ACCESS_COORDINATE_CPU when appropriate.  No functionality
> change.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Bharata B Rao <bharata@amd.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Good to clean this up. Thanks!

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/acpi/numa/hmat.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 2c8ccc91ebe6..febd9e51350b 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -408,7 +408,7 @@ static __init void hmat_update_target(unsigned int tgt_pxm, unsigned int init_px
>  	if (target && target->processor_pxm == init_pxm) {
>  		hmat_update_target_access(target, type, value,
>  					  ACCESS_COORDINATE_LOCAL);
> -		/* If the node has a CPU, update access 1 */
> +		/* If the node has a CPU, update access ACCESS_COORDINATE_CPU */
>  		if (node_state(pxm_to_node(init_pxm), N_CPU))
>  			hmat_update_target_access(target, type, value,
>  						  ACCESS_COORDINATE_CPU);
> @@ -948,7 +948,7 @@ static int hmat_set_default_dram_perf(void)
>  		target = find_mem_target(pxm);
>  		if (!target)
>  			continue;
> -		attrs = &target->coord[1];
> +		attrs = &target->coord[ACCESS_COORDINATE_CPU];
>  		rc = mt_set_default_dram_perf(nid, attrs, "ACPI HMAT");
>  		if (rc)
>  			return rc;
> @@ -975,7 +975,7 @@ static int hmat_calculate_adistance(struct notifier_block *self,
>  	hmat_update_target_attrs(target, p_nodes, ACCESS_COORDINATE_CPU);
>  	mutex_unlock(&target_lock);
>  
> -	perf = &target->coord[1];
> +	perf = &target->coord[ACCESS_COORDINATE_CPU];
>  
>  	if (mt_perf_to_adistance(perf, adist))
>  		return NOTIFY_OK;


