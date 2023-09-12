Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B90079D2D6
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Sep 2023 15:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbjILNwM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Sep 2023 09:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbjILNwG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Sep 2023 09:52:06 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF621703;
        Tue, 12 Sep 2023 06:52:02 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RlQ2M6WpVz6HJp3;
        Tue, 12 Sep 2023 21:50:19 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 12 Sep
 2023 14:51:59 +0100
Date:   Tue, 12 Sep 2023 14:51:58 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Cheatham <Benjamin.Cheatham@amd.com>
CC:     <rafael@kernel.org>, <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <bhelgaas@google.com>, <yazen.ghannam@amd.com>
Subject: Re: [PATCH v4 3/3] ACPI, APEI, EINJ: Update EINJ documentation
Message-ID: <20230912145158.00007d76@Huawei.com>
In-Reply-To: <20230907191956.674833-4-Benjamin.Cheatham@amd.com>
References: <20230907191956.674833-1-Benjamin.Cheatham@amd.com>
        <20230907191956.674833-4-Benjamin.Cheatham@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 7 Sep 2023 14:19:56 -0500
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> Update EINJ documentation to include CXL errors in available_error_types
> table and usage of the types.
> 
> Also fix a formatting error in the param4 file description that caused
> the description to be on the same line as the bullet point.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>

Matches what the spec says, so
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  .../firmware-guide/acpi/apei/einj.rst         | 25 ++++++++++++++++---
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
> index d6b61d22f525..c6f28118c48b 100644
> --- a/Documentation/firmware-guide/acpi/apei/einj.rst
> +++ b/Documentation/firmware-guide/acpi/apei/einj.rst
> @@ -32,6 +32,9 @@ configuration::
>    CONFIG_ACPI_APEI
>    CONFIG_ACPI_APEI_EINJ
>  
> +To use CXL error types ``CONFIG_CXL_ACPI`` needs to be set to the same
> +value as ``CONFIG_ACPI_APEI_EINJ`` (either "y" or "m").
> +
>  The EINJ user interface is in <debugfs mount point>/apei/einj.
>  
>  The following files belong to it:
> @@ -40,9 +43,9 @@ The following files belong to it:
>  
>    This file shows which error types are supported:
>  
> -  ================  ===================================
> +  ================  =========================================
>    Error Type Value	Error Description
> -  ================  ===================================
> +  ================  =========================================
>    0x00000001        Processor Correctable
>    0x00000002        Processor Uncorrectable non-fatal
>    0x00000004        Processor Uncorrectable fatal
> @@ -55,7 +58,13 @@ The following files belong to it:
>    0x00000200        Platform Correctable
>    0x00000400        Platform Uncorrectable non-fatal
>    0x00000800        Platform Uncorrectable fatal
> -  ================  ===================================
> +  0x00001000        CXL.cache Protocol Correctable
> +  0x00002000        CXL.cache Protocol Uncorrectable non-fatal
> +  0x00004000        CXL.cache Protocol Uncorrectable fatal
> +  0x00008000        CXL.mem Protocol Correctable
> +  0x00010000        CXL.mem Protocol Uncorrectable non-fatal
> +  0x00020000        CXL.mem Protocol Uncorrectable fatal
> +  ================  =========================================
>  
>    The format of the file contents are as above, except present are only
>    the available error types.
> @@ -106,6 +115,7 @@ The following files belong to it:
>    Used when the 0x1 bit is set in "flags" to specify the APIC id
>  
>  - param4
> +
>    Used when the 0x4 bit is set in "flags" to specify target PCIe device
>  
>  - notrigger
> @@ -159,6 +169,13 @@ and param2 (1 = PROCESSOR, 2 = MEMORY, 4 = PCI). See your BIOS vendor
>  documentation for details (and expect changes to this API if vendors
>  creativity in using this feature expands beyond our expectations).
>  
> +CXL error types are supported from ACPI 6.5 onwards. To use these error
> +types you need the MMIO address of a CXL 1.1 downstream port. You can
> +find the address of dportY in /sys/bus/cxl/devices/portX/dportY/cxl_rcrb_addr
> +(it's possible that the dport is under the CXL root, in that case the
> +path would be /sys/us/cxl/devices/rootX/dportY/cxl_rcrb_addr).
> +From there, write the address to param1 and continue as you would for a
> +memory error type.
>  
>  An error injection example::
>  
> @@ -201,4 +218,4 @@ The following sequence can be used:
>    7) Read from the virtual address. This will trigger the error
>  
>  For more information about EINJ, please refer to ACPI specification
> -version 4.0, section 17.5 and ACPI 5.0, section 18.6.
> +version 4.0, section 17.5 and ACPI 6.5, section 18.6.

