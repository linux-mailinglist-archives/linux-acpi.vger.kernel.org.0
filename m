Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2287F360347
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Apr 2021 09:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhDOH1r (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Apr 2021 03:27:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24373 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230090AbhDOH1p (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 15 Apr 2021 03:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618471641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ekzj4mcW27qGn3lH96EGgzNbzBUSOojlu95Su7o6jyE=;
        b=iobPDCtj1JOahsPcEtmTVaYmxGfKIoYAiFGrNta/cYkhoF+JkUNOzAvyyIYF0VYpq8XgQH
        uEG2awGqVYQzDeQyQQILpNEbYeEuhlt3ynKtnm0bQweTgvnvfG6pWcT/jZ+Dw625QESloB
        Db3PgNoLXm+LVHCXfyXGw5w5sIKp7f0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-roGooyyyNJGAwnRl2CDabA-1; Thu, 15 Apr 2021 03:27:19 -0400
X-MC-Unique: roGooyyyNJGAwnRl2CDabA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80CE39F92F;
        Thu, 15 Apr 2021 07:27:17 +0000 (UTC)
Received: from [10.36.114.81] (ovpn-114-81.ams2.redhat.com [10.36.114.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D3AE41969E;
        Thu, 15 Apr 2021 07:27:12 +0000 (UTC)
Subject: Re: [RFC PATCH v2 1/8] ACPICA: IORT: Update for revision E
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org, devel@acpica.org
Cc:     linuxarm@huawei.com, steven.price@arm.com, guohanjun@huawei.com,
        Sami.Mujawar@arm.com, robin.murphy@arm.com, wanghuiqiang@huawei.com
References: <20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com>
 <20201119121150.3316-2-shameerali.kolothum.thodi@huawei.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <da7b36fb-b30c-2d87-0934-7021d1093a1a@redhat.com>
Date:   Thu, 15 Apr 2021 09:27:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20201119121150.3316-2-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Shameer,

On 11/19/20 1:11 PM, Shameer Kolothum wrote:
> IORT revision E contains a few additions like,
>     -Added an identifier field in the node descriptors to aid table
>      cross-referencing.
>     -Introduced the Reserved Memory Range(RMR) node. This is used
>      to describe memory ranges that are used by endpoints and requires
>      a unity mapping in SMMU.
>     -Introduced a flag in the RC node to express support for PRI.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  include/acpi/actbl2.h | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index ec66779cb193..274fce7b5c01 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -68,7 +68,7 @@
>   * IORT - IO Remapping Table
>   *
>   * Conforms to "IO Remapping Table System Software on ARM Platforms",
> - * Document number: ARM DEN 0049D, March 2018
> + * Document number: ARM DEN 0049E, June 2020
>   *
>   ******************************************************************************/
>  
> @@ -86,7 +86,8 @@ struct acpi_iort_node {
>  	u8 type;
>  	u16 length;
>  	u8 revision;
> -	u32 reserved;
> +	u16 reserved;
> +	u16 identifier;
>  	u32 mapping_count;
>  	u32 mapping_offset;
>  	char node_data[1];
> @@ -100,7 +101,8 @@ enum acpi_iort_node_type {
>  	ACPI_IORT_NODE_PCI_ROOT_COMPLEX = 0x02,
>  	ACPI_IORT_NODE_SMMU = 0x03,
>  	ACPI_IORT_NODE_SMMU_V3 = 0x04,
> -	ACPI_IORT_NODE_PMCG = 0x05
> +	ACPI_IORT_NODE_PMCG = 0x05,
> +	ACPI_IORT_NODE_RMR = 0x06,
>  };
>  
>  struct acpi_iort_id_mapping {
> @@ -167,10 +169,10 @@ struct acpi_iort_root_complex {
>  	u8 reserved[3];		/* Reserved, must be zero */
>  };
>  
> -/* Values for ats_attribute field above */
> +/* Masks for ats_attribute field above */
>  
> -#define ACPI_IORT_ATS_SUPPORTED         0x00000001	/* The root complex supports ATS */
> -#define ACPI_IORT_ATS_UNSUPPORTED       0x00000000	/* The root complex doesn't support ATS */
> +#define ACPI_IORT_ATS_SUPPORTED         (1)	/* The root complex supports ATS */
> +#define ACPI_IORT_PRI_SUPPORTED         (1<<1)	/* The root complex supports PRI */
>  
>  struct acpi_iort_smmu {
>  	u64 base_address;	/* SMMU base address */
> @@ -241,6 +243,17 @@ struct acpi_iort_pmcg {
>  	u64 page1_base_address;
>  };
>  
> +struct acpi_iort_rmr {
so indeed in E.b there is a new field here.
u32 flags
> +	u32 rmr_count;
> +	u32 rmr_offset;
> +};
> +
> +struct acpi_iort_rmr_desc {
> +	u64 base_address;
> +	u64 length;
> +	u32 reserved;
> +};
> +
>  /*******************************************************************************
>   *
>   * IVRS - I/O Virtualization Reporting Structure
> 
Thanks

Eric

