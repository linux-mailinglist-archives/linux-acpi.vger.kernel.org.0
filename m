Return-Path: <linux-acpi+bounces-127-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E1C7AECED
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 14:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 85B202817CF
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 12:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC44286A6
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 12:33:38 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6735381
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 11:05:44 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32DE95;
	Tue, 26 Sep 2023 04:05:42 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RvxhW2RCtz6K9hk;
	Tue, 26 Sep 2023 19:04:27 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 26 Sep
 2023 12:05:40 +0100
Date: Tue, 26 Sep 2023 12:05:39 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <rafael@kernel.org>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<bhelgaas@google.com>, <yazen.ghannam@amd.com>
Subject: Re: [PATCH v5 3/3] ACPI, APEI, EINJ: Update EINJ documentation
Message-ID: <20230926120539.00000a4a@Huawei.com>
In-Reply-To: <20230925200127.504256-4-Benjamin.Cheatham@amd.com>
References: <20230925200127.504256-1-Benjamin.Cheatham@amd.com>
	<20230925200127.504256-4-Benjamin.Cheatham@amd.com>
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
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 25 Sep 2023 15:01:27 -0500
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> Update EINJ documentation to include CXL errors in available_error_types
> table and usage of the types.
> 
> Also fix a formatting error in the param4 file description that caused
> the description to be on the same line as the bullet point.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
A trivial comment inline.

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

#Unrelated change.  Probably reasonable but should be separate patch really.

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


