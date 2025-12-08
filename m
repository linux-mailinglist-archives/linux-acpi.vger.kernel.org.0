Return-Path: <linux-acpi+bounces-19493-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EEBCADC40
	for <lists+linux-acpi@lfdr.de>; Mon, 08 Dec 2025 17:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C36803014ABE
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Dec 2025 16:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262D2224B1B;
	Mon,  8 Dec 2025 16:35:23 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22301F4180;
	Mon,  8 Dec 2025 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765211723; cv=none; b=fh8OzOJXThX6gmlWFka5xHsZc7pjz90lcbOxjn+SmyIK7c7e4zuVtP8LG+5GjAP9gGJ9gxMglCHHY92TStUdoPtkw3upZCxXIQQlDHX669vb2VtEvSQ04IVCBlDDSxP8QgFHUZg+qXIMD1Ln6CseKq6737w0cEUO/QGZcvA1qZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765211723; c=relaxed/simple;
	bh=Ooo6FxYXHn78K86xCGl0ZXtkzHKCenbN1yMa1IxT/zI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZPzJdVECdxadiO1suwDuYW06dTS+v89wXQJPqRPFa09ER3anrNEGk4h1G11Gg4Z67RQzYP7d/mnjpHVOKORpcmQoFTZk3jrYT2rO37md68Zjq1CbByopjvQctJiqytVDIGMXCHRq1/b5p0qBwM6fu+q81SCBBc9igndUuBdaqRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dQ6yv1cjdzJ46DW;
	Tue,  9 Dec 2025 00:35:03 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F9B64056A;
	Tue,  9 Dec 2025 00:35:18 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 8 Dec
 2025 16:35:17 +0000
Date: Mon, 8 Dec 2025 16:35:15 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Huisong Li <lihuisong@huawei.com>, <linuxarm@huawei.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Sudeep.Holla@arm.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <yubowen8@huawei.com>
Subject: Re: [PATCH] ACPI: processor: idle: Add debug log for the state
 whose entry method is illegal
Message-ID: <20251208163459.00000842@huawei.com>
In-Reply-To: <20251125064702.3666149-1-lihuisong@huawei.com>
References: <20251125064702.3666149-1-lihuisong@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 25 Nov 2025 14:47:02 +0800
Huisong Li <lihuisong@huawei.com> wrote:

> According to ACPI spec, entry method in LPI sub-package must be buffer
> or integer. Driver will disable the state whose the entry method is
> illegal by zero flags in struct acpi_lpi_state. The entry method is
> very key in cpuidle. A debug log is very useful developers.
> 
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
Seems reasonable to me and debug is probably appropriate error for broken
firmware. 
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  drivers/acpi/processor_idle.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 22909fccf0b1..5f86297c8b23 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -946,6 +946,8 @@ static int acpi_processor_evaluate_lpi(acpi_handle handle,
>  			lpi_state->entry_method = ACPI_CSTATE_INTEGER;
>  			lpi_state->address = obj->integer.value;
>  		} else {
> +			pr_debug("Entry method of state-%d is illegal, disable it.\n",
> +				 state_idx);
>  			continue;
>  		}
>  


