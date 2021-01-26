Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34152304C8A
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 23:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbhAZWrc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Jan 2021 17:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbhAZRIg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Jan 2021 12:08:36 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262B6C0611C2;
        Tue, 26 Jan 2021 08:44:58 -0800 (PST)
Received: from zn.tnic (p200300ec2f0d11004e878318d6a49745.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1100:4e87:8318:d6a4:9745])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7508B1EC0489;
        Tue, 26 Jan 2021 17:44:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611679493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5BNpA18woz/GtfcJQFYWq8Enn52JhWk6go+AvI3AO0o=;
        b=JbzeN6Y3TiHP0m0DgF4RqOYNI+QjY+gMwZCh9AxYX0L8xVq4wa04fEyh6FrmCjYPmdiqzC
        tpmeNqOkWo1HZVFeDZpFru6tq/5or4V/6dOhHrPgzBeTZTqUEGUrteo4v5qkJEelpNlF01
        b8X8N3n41Y3OPWVqZlIJmzqUUw8tA1g=
Date:   Tue, 26 Jan 2021 17:44:54 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Terry Bowman <terry.bowman@amd.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, yazen.ghannam@amd.com, guohanjun@huawei.com,
        colin.king@canonical.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, jon.grimm@amd.com
Subject: Re: [PATCH v2] ACPI / APEI: Add is_generic_error() to identify GHES
 sources
Message-ID: <20210126164454.GD6514@zn.tnic>
References: <20210126163201.1433505-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210126163201.1433505-1-terry.bowman@amd.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 26, 2021 at 10:32:01AM -0600, Terry Bowman wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Refactor duplicated GHES identity logic into is_generic_error().
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Reviewed-by: Robert Richter <rrichter@amd.com>
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
> Changes in v2:
>   - Rename is_ghes_type() to is_generic_error()
>   - Add co-developed-by
>   
>  drivers/acpi/apei/hest.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
> index 6e980fe16772..f220bb00e91b 100644
> --- a/drivers/acpi/apei/hest.c
> +++ b/drivers/acpi/apei/hest.c
> @@ -49,6 +49,12 @@ static const int hest_esrc_len_tab[ACPI_HEST_TYPE_RESERVED] = {
>  	[ACPI_HEST_TYPE_IA32_DEFERRED_CHECK] = -1,
>  };
>  
> +static inline bool is_generic_error(struct acpi_hest_header *hest_hdr)
> +{
> +	return hest_hdr->type == ACPI_HEST_TYPE_GENERIC_ERROR ||
> +	       hest_hdr->type == ACPI_HEST_TYPE_GENERIC_ERROR_V2;
> +}
> +
>  static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
>  {
>  	u16 hest_type = hest_hdr->type;
> @@ -141,8 +147,7 @@ static int __init hest_parse_ghes_count(struct acpi_hest_header *hest_hdr, void
>  {
>  	int *count = data;
>  
> -	if (hest_hdr->type == ACPI_HEST_TYPE_GENERIC_ERROR ||
> -	    hest_hdr->type == ACPI_HEST_TYPE_GENERIC_ERROR_V2)
> +	if (is_generic_error(hest_hdr))
>  		(*count)++;
>  	return 0;
>  }
> @@ -153,9 +158,7 @@ static int __init hest_parse_ghes(struct acpi_hest_header *hest_hdr, void *data)
>  	struct ghes_arr *ghes_arr = data;
>  	int rc, i;
>  
> -	if (hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR &&
> -	    hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR_V2)
> +	if (!is_generic_error(hest_hdr))
>  		return 0;
>  
>  	if (!((struct acpi_hest_generic *)hest_hdr)->enabled)
> --

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
