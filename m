Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A55B700768
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 14:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240546AbjELMAn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 08:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240445AbjELMAm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 08:00:42 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B3E10E0;
        Fri, 12 May 2023 05:00:41 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QHnL06tCfz6J793;
        Fri, 12 May 2023 19:56:40 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 12 May
 2023 13:00:39 +0100
Date:   Fri, 12 May 2023 13:00:38 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <rafael@kernel.org>, <lenb@kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <lukas@wunner.de>
Subject: Re: [PATCH 2/4] acpi: Add header struct in CDAT subtables
Message-ID: <20230512130038.00002c84@Huawei.com>
In-Reply-To: <168330798275.2042604.11217169699695338532.stgit@djiang5-mobl3>
References: <168330787964.2042604.17648905811002211147.stgit@djiang5-mobl3>
        <168330798275.2042604.11217169699695338532.stgit@djiang5-mobl3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 05 May 2023 10:33:02 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add the common header struct in all CDAT subtables. This change
> complies with other ACPI sub-tables in the header file. The change
> also eases the usage with the helper functions in tables.c.
> 
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Other than the naming question from previous patch (should these have acpi
in their names at all?), this looks sensible to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  include/acpi/actbl1.h |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 3119be093cfe..166337b04306 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -350,6 +350,7 @@ enum acpi_cdat_type {
>  /* Subtable 0: Device Scoped Memory Affinity Structure (DSMAS) */
>  
>  struct acpi_cdat_dsmas {
> +	struct acpi_cdat_header header;
>  	u8 dsmad_handle;
>  	u8 flags;
>  	u16 reserved;
> @@ -364,6 +365,7 @@ struct acpi_cdat_dsmas {
>  /* Subtable 1: Device scoped Latency and Bandwidth Information Structure (DSLBIS) */
>  
>  struct acpi_cdat_dslbis {
> +	struct acpi_cdat_header header;
>  	u8 handle;
>  	u8 flags;		/* If Handle matches a DSMAS handle, the definition of this field matches
>  				 * Flags field in HMAT System Locality Latency */
> @@ -377,6 +379,7 @@ struct acpi_cdat_dslbis {
>  /* Subtable 2: Device Scoped Memory Side Cache Information Structure (DSMSCIS) */
>  
>  struct acpi_cdat_dsmscis {
> +	struct acpi_cdat_header header;
>  	u8 dsmas_handle;
>  	u8 reserved[3];
>  	u64 side_cache_size;
> @@ -386,6 +389,7 @@ struct acpi_cdat_dsmscis {
>  /* Subtable 3: Device Scoped Initiator Structure (DSIS) */
>  
>  struct acpi_cdat_dsis {
> +	struct acpi_cdat_header header;
>  	u8 flags;
>  	u8 handle;
>  	u16 reserved;
> @@ -398,6 +402,7 @@ struct acpi_cdat_dsis {
>  /* Subtable 4: Device Scoped EFI Memory Type Structure (DSEMTS) */
>  
>  struct acpi_cdat_dsemts {
> +	struct acpi_cdat_header header;
>  	u8 dsmas_handle;
>  	u8 memory_type;
>  	u16 reserved;
> @@ -408,6 +413,7 @@ struct acpi_cdat_dsemts {
>  /* Subtable 5: Switch Scoped Latency and Bandwidth Information Structure (SSLBIS) */
>  
>  struct acpi_cdat_sslbis {
> +	struct acpi_cdat_header header;
>  	u8 data_type;
>  	u8 reserved[3];
>  	u64 entry_base_unit;
> 
> 
> 

