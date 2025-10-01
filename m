Return-Path: <linux-acpi+bounces-17475-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 192E2BB04E5
	for <lists+linux-acpi@lfdr.de>; Wed, 01 Oct 2025 14:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD6FC3AF233
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Oct 2025 12:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD0C277CB3;
	Wed,  1 Oct 2025 12:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="B7+h2GLX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC48279DDB;
	Wed,  1 Oct 2025 12:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759321268; cv=none; b=aLuAeP6XYxOu8/CF6NIDumvedetzBRPWSHqQdxrUm4oxI/am+ZX2Vlni36J+7F1awwDu19Z1lpSbX4ayvnhmr3NknXakAOCOwq/ejqeGj4H5PHr4QBbi+jREiteHbF20zZrwGjW8PMG7AcpwrYuiRrHDUkaSdAZ223lUjz2ZhWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759321268; c=relaxed/simple;
	bh=vjpwNsC5W3V+0SjL3ro24C9U/HdP0+ByapTuQH1XqfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nbp9r4y/DWis4Z0Ez1Q9XYWupe1knCh6CDd1uxCrns8R4DFQWwg5yA3BwIDLuV/sjVCvB7HLSUC8e/RQUPSh1xZ4phbXP5D6Dggcc7G9S9e76nhMAI2J0loAx74NxrPywhHFAjGZA/E3UUcjPYz+yOuSF+LHJ2hz/VZc5V0uZ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=B7+h2GLX; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id F29DD169;
	Wed,  1 Oct 2025 14:19:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1759321168;
	bh=vjpwNsC5W3V+0SjL3ro24C9U/HdP0+ByapTuQH1XqfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B7+h2GLXNOemy3KlDAhj4n9gW/kGO8m1n56ZKnonvIv/3th4t1sKjwOHR7pQ/x6gz
	 9A7FYB7abcidVvHzo+/GuusgmHppl2pBxbIQaZE6iLb2P6jKzhyOGqcBP/GohZRIrW
	 F5i5vVQOkTH0jz6JXE5dBFGkHAxNpZQVFhtBE48s=
Date: Wed, 1 Oct 2025 15:20:51 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 3/3] ACPI: property: Rework acpi_graph_get_next_endpoint()
Message-ID: <20251001122051.GC14600@pendragon.ideasonboard.com>
References: <20251001104320.1272752-1-sakari.ailus@linux.intel.com>
 <20251001104320.1272752-4-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251001104320.1272752-4-sakari.ailus@linux.intel.com>

On Wed, Oct 01, 2025 at 01:43:20PM +0300, Sakari Ailus wrote:
> Rework the code obtaining the next endpoint in
> acpi_graph_get_next_endpoint(). The resulting code removes unnecessary
> contitionals and should be easier to follow.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/acpi/property.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 200e5d717f16..c07f45929a25 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -1421,14 +1421,17 @@ static struct fwnode_handle *acpi_graph_get_next_endpoint(
>  	if (!port)
>  		return NULL;
>  
> -	endpoint = acpi_get_next_subnode(port, prev);
> -	while (!endpoint) {
> -		port = acpi_get_next_subnode(fwnode, port);
> -		if (!port)
> +	do {
> +		endpoint = acpi_get_next_subnode(port, prev);
> +		if (endpoint)
>  			break;
> -		if (is_acpi_graph_node(port, "port"))
> -			endpoint = acpi_get_next_subnode(port, NULL);
> -	}
> +
> +		prev = NULL;
> +
> +		do {
> +			port = acpi_get_next_subnode(fwnode, port);
> +		} while (port && !is_acpi_graph_node(port, "port"));
> +	} while (port);
>  
>  	/*
>  	 * The names of the endpoint nodes begin with "endpoint@" followed by

-- 
Regards,

Laurent Pinchart

