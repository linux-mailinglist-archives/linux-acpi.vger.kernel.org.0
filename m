Return-Path: <linux-acpi+bounces-19926-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D91F1CEE628
	for <lists+linux-acpi@lfdr.de>; Fri, 02 Jan 2026 12:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A2AB3008E80
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Jan 2026 11:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3D92D7D42;
	Fri,  2 Jan 2026 11:37:45 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E0D2DC783;
	Fri,  2 Jan 2026 11:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767353865; cv=none; b=mZruC/MIB65C+Iw/+TI2S3FsqnPfD9KmMe3y9QVTN/iAAVIva8HTNvdX59gf2vMxAXdfSLtTXW9m7DXzhHx/5n+U8YsFL3bJOQ1D5gY5ZApQ90Pkuz5P8aQ5RwRp2lrERy8A0U0+OkAN3YrQ5AARPlAmanl+Km1aWlBY/Na2GgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767353865; c=relaxed/simple;
	bh=RTfHCfDMy4NtxmGDV1e22MEx8FDGgXV4jhn+xcPKGKo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KtTbqNU3aM1aT/2dXkQoM2ByQOP8HyhJAzvuYIVZOQZ1ZLu1Ywol1CJIAkmr0Mnu61RwulpIHJaZDehPKiTx0kmkt/iKT2euzg9NLtouOJl+8leW51l0QJ/UNX9VoNWcn6IEgnQnlwTvX0W2EqH/hAnFPQ4NGK9Zys0AsMzkWmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4djM921NNVzHnGj0;
	Fri,  2 Jan 2026 19:36:38 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id BE8EB40539;
	Fri,  2 Jan 2026 19:37:34 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 2 Jan
 2026 11:37:33 +0000
Date: Fri, 2 Jan 2026 11:37:32 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux ACPI <linux-acpi@vger.kernel.org>, Dan Carpenter
	<dan.carpenter@linaro.org>, LKML <linux-kernel@vger.kernel.org>, "Srinivas
 Pandruvada" <srinivas.pandruvada@linux.intel.com>, Hans de Goede
	<hansg@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v1] ACPI: bus: Fix typo under sizeof() in acpi_run_osc()
Message-ID: <20260102113732.0000192c@huawei.com>
In-Reply-To: <2817106.mvXUDI8C0e@rafael.j.wysocki>
References: <2817106.mvXUDI8C0e@rafael.j.wysocki>
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

On Mon, 29 Dec 2025 14:27:46 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: 
> 
> The sizeof(32) in acpi_run_osc() should be sizeof(u32), so fix it.
> 
> Fixes: e5322888e6bf ("ACPI: bus: Rework the handling of \_SB._OSC platform features")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
> 
> Commit e5322888e6bf is a linux-next one.
> 
> ---
>  drivers/acpi/bus.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -294,7 +294,7 @@ acpi_status acpi_run_osc(acpi_handle han
>  	int ret;
>  
>  	if (!context || !context->cap.pointer ||
> -	    context->cap.length < 2 * sizeof(32) ||
> +	    context->cap.length < 2 * sizeof(u32) ||
>  	    guid_parse(context->uuid_str, &guid))
>  		return AE_BAD_PARAMETER;
>  
> 
> 
> 
> 


