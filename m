Return-Path: <linux-acpi+bounces-3550-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ACC856A56
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 17:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 048E61C23978
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 16:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A990A132C10;
	Thu, 15 Feb 2024 16:57:53 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4A212FB27;
	Thu, 15 Feb 2024 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016273; cv=none; b=tKQGSC0c5QpN+Cq3Ll1gj2JejZ1w85co3wBXW32fhmXtH7NH4ZXxvZS+SL0plJFnGSb3/t69bU9yPZ6wNbPtcf+ozu42KDbuS2P7RJBIM1hs5IyXHv7QZvfa8D4sEp1oUaBJH4uFbrUXnrBDcEcfPBIbDM9M4QNw8LEN+j9PiTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016273; c=relaxed/simple;
	bh=613+vV4QwK+eCHle+1IZMuHLVW3e+dhtwuDMptnrydg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OJthkdg7wVbfIBnoFOI1PCBgh9dvw6qCKX0dzrie5VnThVNk5135Z8RoFXF3A+KzIYbbPmRfJVrG6FfztyuMp04nXTPgZCAYcS4kcnFXkkmrWXvmaBe5WsMk2Uoxa3lnpE3Sa2V8iyhcTWAabm39R0BqwrulzB3dQqXGHqGOT6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbLkN3GTGz67lbN;
	Fri, 16 Feb 2024 00:54:04 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 1FD2C140B3C;
	Fri, 16 Feb 2024 00:57:49 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 16:57:48 +0000
Date: Thu, 15 Feb 2024 16:57:47 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <rafael@kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 07/12] cxl: Move QoS class to be calculated from the
 nearest CPU
Message-ID: <20240215165747.00001d9f@Huawei.com>
In-Reply-To: <20240206222951.1833098-8-dave.jiang@intel.com>
References: <20240206222951.1833098-1-dave.jiang@intel.com>
	<20240206222951.1833098-8-dave.jiang@intel.com>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 6 Feb 2024 15:28:35 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Retrieve the qos_class (QTG ID) using the access coordinates from the
> nearest CPU rather than the nearst initiator that may not be a CPU.
> This may be the more appropriate number that applications care about.
> 
> Link: https://lore.kernel.org/linux-cxl/20240112113023.00006c50@Huawei.com/
> Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Might be worth calling out that in most cases they are the same so
that no one bothers to backport this.

> ---
>  drivers/cxl/core/cdat.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 79844874a34b..bd0ff3cebb8c 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -198,12 +198,12 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
>  		 * coordinates in order to allow calculation of access class
>  		 * 0 and 1 for region later.
>  		 */
> -		cxl_coordinates_combine(&coord[ACCESS_COORDINATE_LOCAL],
> -					&coord[ACCESS_COORDINATE_LOCAL],
> +		cxl_coordinates_combine(&coord[ACCESS_COORDINATE_CPU],
> +					&coord[ACCESS_COORDINATE_CPU],
>  					&dent->coord);
>  		dent->entries = 1;
>  		rc = cxl_root->ops->qos_class(cxl_root,
> -					      &coord[ACCESS_COORDINATE_LOCAL],
> +					      &coord[ACCESS_COORDINATE_CPU],
>  					      1, &qos_class);
>  		if (rc != 1)
>  			continue;


