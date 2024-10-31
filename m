Return-Path: <linux-acpi+bounces-9205-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 504019B83A5
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 20:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 047291F226DC
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 19:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C031CB331;
	Thu, 31 Oct 2024 19:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="sK2Mu5Uv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E53C1A2562;
	Thu, 31 Oct 2024 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730404286; cv=none; b=K7fpz2AePsRo/817FhXmFVji3kBByiFp+mkSgcgn4/uIo1KvQqhyW2h/K7yNoCklRWaDNQ2/J7oa+jmJqyvrxUulDvI0PGynT9bPxL/hEIr8DucyZCsWYy5x7/lqY5IQKnAEwN9q3zuye/22Fo6/4t5EcnAeJlRm1kjBaCPtyt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730404286; c=relaxed/simple;
	bh=pWeTyJJNnr00Ds1a/IrE+1tdtM+/jzwGubwtgQ/p3RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRnnYqKCxMm9XQVAoYCduVfdkW3rlMID7LGWOhaQo2YiYyDAKjs/MJVM8lJJiSlW0A1soQVAzfw9WSXadcnAu9uBm5cnoJAJ+RUgOT4PRhLuKNSq9X75vxDx/7MS+cg1BpJ7/FjMEfEN5vnNI8lm1THR9Rrd0HP3MojyO2zRC0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=sK2Mu5Uv; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc (unknown [10.10.165.3])
	by mail.ispras.ru (Postfix) with ESMTPSA id 61BCD40777DF;
	Thu, 31 Oct 2024 19:51:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 61BCD40777DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1730404273;
	bh=ANbGFTkYcuHN9MP7yhDSsW9JkyY2aWF7v/pBJSBGoLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sK2Mu5UvfLD+ZZnSKJGEh+JOx0In9VTgb+fmUGwhG0Xr6PTTb2L7Qp+4oDud+QgBx
	 IS8U8Sgra+7jfgv5V6E+Ap4FBDBb/r610FIaUz7QBldHurlKqN9asHCMsrFwQy6+Ao
	 cCTXHFvNDp1AEmwugIKBkM3/2EhQoyhKEdbauILY=
Date: Thu, 31 Oct 2024 22:51:09 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: George Rurikov <grurikov@gmail.com>
Cc: Robert Moore <robert.moore@intel.com>, lvc-project@linuxtesting.org,
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, linux-acpi@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <lenb@kernel.org>
Subject: Re: [PATCH] ACPICA: Fix dereference in
 acpi_ev_address_space_dispatch()
Message-ID: <20241031-2f71908a9a589c4469480e73-pchelkin@ispras.ru>
References: <20241031173146.1459-1-grurikov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241031173146.1459-1-grurikov@gmail.com>

On Thu, 31. Oct 20:31, George Rurikov wrote:
> When support for  PCC Opregion was added, validation of field_obj
> was missed.
> Based on the acpi_ev_address_space_dispatch function description,
> field_obj can be NULL, and also when acpi_ev_address_space_dispatch
> is called in the acpi_ex_region_read() NULL is passed as field_obj.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 0acf24ad7e10 ("ACPICA: Add support for PCC Opregion special context data")
> Cc: stable@vger.kernel.org
> Signed-off-by: George Rurikov <grurikov@gmail.com>
> ---
>  drivers/acpi/acpica/evregion.c | 18 +++++++++++-------

Hi George,

ACPICA patches go first via a separate Github project [1].
[1]: https://github.com/acpica/acpica

Please see [2] and [3] for more info:
[2]: https://lore.kernel.org/acpica-devel/CAJZ5v0i7LYzF13M0qdeYWXZ7uO6HUpAS7pE5RJnOAJtKB8o88A@mail.gmail.com/
[3]: https://docs.kernel.org/driver-api/acpi/linuxized-acpica.html

>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
> index cf53b9535f18..03e8b6f186af 100644
> --- a/drivers/acpi/acpica/evregion.c
> +++ b/drivers/acpi/acpica/evregion.c
> @@ -164,13 +164,17 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
>  		}
>  
>  		if (region_obj->region.space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
> -			struct acpi_pcc_info *ctx =
> -			    handler_desc->address_space.context;
> -
> -			ctx->internal_buffer =
> -			    field_obj->field.internal_pcc_buffer;
> -			ctx->length = (u16)region_obj->region.length;
> -			ctx->subspace_id = (u8)region_obj->region.address;
> +			if (field_obj != NULL) {
> +				struct acpi_pcc_info *ctx =
> +					handler_desc->address_space.context;
> +
> +				ctx->internal_buffer =
> +					field_obj->field.internal_pcc_buffer;
> +				ctx->length = (u16)region_obj->region.length;
> +				ctx->subspace_id = (u8)region_obj->region.address;
> +			} else {
> +				return_ACPI_STATUS(AE_ERROR);
> +			}
>  		}
>  
>  		if (region_obj->region.space_id ==
> -- 
> 2.34.1

