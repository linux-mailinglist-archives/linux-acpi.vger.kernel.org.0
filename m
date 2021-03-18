Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25671340C2E
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Mar 2021 18:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhCRRxK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Mar 2021 13:53:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37063 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229734AbhCRRxB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 18 Mar 2021 13:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616089980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uruINJSWaWFLlku1MQ1qt468Ob8HB9qLPxmAmX6H9nc=;
        b=hGczqCXRG9demSmTE8hnBPyD00MKI0vk/7jlfNhRCR6+XHjCckJrvpK1POvRNiMMUaeE1Y
        Soty8Y99czWjMpfc4kNKp8POrMEYZOtdZ+Is5oj/QXSTAKhrjq16E1ZTrDkNefMyvxYi7O
        AEXs48ij70hWd7HIzeKU63mU8NoSMv0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-HNdaGIRbPOiZUUxEWpstlA-1; Thu, 18 Mar 2021 13:52:56 -0400
X-MC-Unique: HNdaGIRbPOiZUUxEWpstlA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B072A81431C;
        Thu, 18 Mar 2021 17:52:54 +0000 (UTC)
Received: from [10.36.112.6] (ovpn-112-6.ams2.redhat.com [10.36.112.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 70BB95D9C6;
        Thu, 18 Mar 2021 17:52:46 +0000 (UTC)
Subject: Re: [PATCH 1/3] ACPICA: iASL: Add definitions for the VIOT table
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        rjw@rjwysocki.net, lenb@kernel.org, joro@8bytes.org, mst@redhat.com
Cc:     will@kernel.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        sebastien.boeuf@intel.com, robin.murphy@arm.com,
        kevin.tian@intel.com, lorenzo.pieralisi@arm.com
References: <20210316191652.3401335-1-jean-philippe@linaro.org>
 <20210316191652.3401335-2-jean-philippe@linaro.org>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <83d8f573-0a96-5869-2c22-249bf2db7399@redhat.com>
Date:   Thu, 18 Mar 2021 18:52:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210316191652.3401335-2-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jean,

On 3/16/21 8:16 PM, Jean-Philippe Brucker wrote:
> Just here for reference, don't merge!
> 
> The actual commits will be pulled from the next ACPICA release.
> I squashed the three relevant commits:
> 
> ACPICA commit fc4e33319c1ee08f20f5c44853dd8426643f6dfd
> ACPICA commit 2197e354fb5dcafaddd2016ffeb0620e5bc3d5e2
> ACPICA commit 856a96fdf4b51b2b8da17529df0255e6f51f1b5b
> 
> Link: https://github.com/acpica/acpica/commit/fc4e3331
> Link: https://github.com/acpica/acpica/commit/2197e354
> Link: https://github.com/acpica/acpica/commit/856a96fd
> Signed-off-by: Bob Moore <robert.moore@intel.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  include/acpi/actbl3.h | 67 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
> index df5f4b27f3aa..09d15898e9a8 100644
> --- a/include/acpi/actbl3.h
> +++ b/include/acpi/actbl3.h
> @@ -33,6 +33,7 @@
>  #define ACPI_SIG_TCPA           "TCPA"	/* Trusted Computing Platform Alliance table */
>  #define ACPI_SIG_TPM2           "TPM2"	/* Trusted Platform Module 2.0 H/W interface table */
>  #define ACPI_SIG_UEFI           "UEFI"	/* Uefi Boot Optimization Table */
> +#define ACPI_SIG_VIOT           "VIOT"	/* Virtual I/O Translation Table */
>  #define ACPI_SIG_WAET           "WAET"	/* Windows ACPI Emulated devices Table */
>  #define ACPI_SIG_WDAT           "WDAT"	/* Watchdog Action Table */
>  #define ACPI_SIG_WDDT           "WDDT"	/* Watchdog Timer Description Table */
> @@ -483,6 +484,72 @@ struct acpi_table_uefi {
>  	u16 data_offset;	/* Offset of remaining data in table */
>  };
>  
> +/*******************************************************************************
> + *
> + * VIOT - Virtual I/O Translation Table
> + *        Version 1
For other tables I see
Conforms to ../.. Shouldn't we have such section too
> + *
> + ******************************************************************************/
> +
> +struct acpi_table_viot {
> +	struct acpi_table_header header;	/* Common ACPI table header */
> +	u16 node_count;
> +	u16 node_offset;
> +	u8 reserved[8];
> +};
> +
> +/* VIOT subtable header */
> +
> +struct acpi_viot_header {
> +	u8 type;
> +	u8 reserved;
> +	u16 length;
> +};
> +
> +/* Values for Type field above */
> +
> +enum acpi_viot_node_type {
> +	ACPI_VIOT_NODE_PCI_RANGE = 0x01,
> +	ACPI_VIOT_NODE_MMIO = 0x02,
> +	ACPI_VIOT_NODE_VIRTIO_IOMMU_PCI = 0x03,
> +	ACPI_VIOT_NODE_VIRTIO_IOMMU_MMIO = 0x04,
> +	ACPI_VIOT_RESERVED = 0x05
> +};
> +
> +/* VIOT subtables */
> +
> +struct acpi_viot_pci_range {
> +	struct acpi_viot_header header;
> +	u32 endpoint_start;
> +	u16 segment_start;
> +	u16 segment_end;
> +	u16 bdf_start;
> +	u16 bdf_end;
> +	u16 output_node;
> +	u8 reserved[6];
> +};
> +
> +struct acpi_viot_mmio {
> +	struct acpi_viot_header header;
> +	u32 endpoint;
> +	u64 base_address;
> +	u16 output_node;
> +	u8 reserved[6];
> +};
> +
> +struct acpi_viot_virtio_iommu_pci {
> +	struct acpi_viot_header header;
> +	u16 segment;
> +	u16 bdf;
> +	u8 reserved[8];
> +};
> +
> +struct acpi_viot_virtio_iommu_mmio {
> +	struct acpi_viot_header header;
> +	u8 reserved[4];
> +	u64 base_address;
> +};
> +
>  /*******************************************************************************
>   *
>   * WAET - Windows ACPI Emulated devices Table
> 

Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

