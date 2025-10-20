Return-Path: <linux-acpi+bounces-18005-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCA3BF2047
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 17:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6879534C680
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 15:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A67B23A58B;
	Mon, 20 Oct 2025 15:11:32 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275DA229B2A;
	Mon, 20 Oct 2025 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973092; cv=none; b=sd0z/ObiUGX3/G6Gp73b2TqfbQl2InwZkUMAU+UScu+hqKJMjvcKEm42MjUzuSlFZQkZrVt+GuqhzrnWptvVQCfBp+IRn7omz+4vDmY8e+4GyZQzw0HoamamjDvyBZKtoSPkTcPTzgNm8lnITbael9s/AjJenvFll2yyZIq9KeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973092; c=relaxed/simple;
	bh=DPphK7EalUc/OEqUgMMfPzehoXv3BpiJffqmHDfOpHc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bDFIOn3O5fvQB6vaWWs2rgMpx9pfgDH1DPwsyPMOue65phbY8nWRUEbm+AWiP9qJjO+XdxkWGBsvb1VNgTJAdHIcBYbkNSyB5vGBh8WfxqpFITO2W04g38Kzmjl47odl4TQ8vkmAXn+z5iKn484C5Wd1sXtEQQqVYCFr0WNRQ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cqzLs6Ndmz6M5CH;
	Mon, 20 Oct 2025 23:07:49 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 0692814038F;
	Mon, 20 Oct 2025 23:11:27 +0800 (CST)
Received: from localhost (10.48.157.75) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 20 Oct
 2025 16:11:26 +0100
Date: Mon, 20 Oct 2025 16:11:22 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM
	<linux-pm@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, LKML
	<linux-kernel@vger.kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>, Frank
 Li <Frank.Li@nxp.com>, Dhruva Gole <d-gole@ti.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 2/2] ACPI: TAD: Improve runtime PM using guard macros
Message-ID: <20251020161122.00006179@huawei.com>
In-Reply-To: <22877917.EfDdHjke4D@rafael.j.wysocki>
References: <8599731.T7Z3S40VBb@rafael.j.wysocki>
	<22877917.EfDdHjke4D@rafael.j.wysocki>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Sat, 18 Oct 2025 14:24:42 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Use guard pm_runtime_active_try to simplify runtime PM cleanup and
> implement runtime resume error handling in multiple places.
> 
> Also use guard pm_runtime_noresume to simplify acpi_tad_remove().
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/acpi_tad.c |   57 +++++++++++++++++++++---------------------------
>  1 file changed, 25 insertions(+), 32 deletions(-)
> 
> --- a/drivers/acpi/acpi_tad.c
> +++ b/drivers/acpi/acpi_tad.c

> @@ -111,12 +110,11 @@ static int acpi_tad_get_real_time(struct
>  	acpi_status status;
>  	int ret = -EIO;
>  
> -	pm_runtime_get_sync(dev);
> +	ACQUIRE(pm_runtime_active_try, pm)(dev);
> +	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
> +		return -ENXIO;
>  
>  	status = acpi_evaluate_object(handle, "_GRT", NULL, &output);
> -
> -	pm_runtime_put_sync(dev);
> -
>  	if (ACPI_FAILURE(status))

Whilst it isn't actually a bug, this does run up against the guidance
in cleanup.h to avoid mixing gotos and cleanup.h usage in a single function.
That's partly a simplification to avoid having to explain the issues with
jumping past inline declarations.

If you want to follow that guidance, either you'd need to add a helper along the
lines of:

DEFINE_FREE(acpi_buffer, void *m ACPI_FREE(_T));
void *acpi_eval_grt(acpi_handle handle, struct acpi_buffer *output)
{
	acpi_status status = acpi_evaluate_object(handle, "_GRT", NULL, &output);

	if (ACPI_FAILURE(status)) {
		ACPI_FREE(output.pointer);
		return ERR_PTR(-EIO); //whatever error makse sense.
	}

	return output.pointer;
}

void *out_obj __free(acpi_buffer) = acpi_eval_grt(handle, &output);

Then can return directly at all error paths.  Not the nicest bit of
code though.

Or, factor out everthing after that allocation down
to the label as helper function and have direct returns in that.

or leave it all as is and hope Linus doesn't get grumpy about mix
and match (which lead to that guidance being so general in the first place!)

The rest look good to me.

Jonathan



>  		goto out_free;
>  

