Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC35572023A
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Jun 2023 14:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbjFBMi1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Jun 2023 08:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbjFBMi0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jun 2023 08:38:26 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8108FE46;
        Fri,  2 Jun 2023 05:38:10 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QXjG36YJmz6J777;
        Fri,  2 Jun 2023 20:38:03 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 2 Jun
 2023 13:38:07 +0100
Date:   Fri, 2 Jun 2023 13:38:07 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <lukas@wunner.de>
Subject: Re: [PATCH v3 3/4] acpi: fix misnamed define for CDAT DSMAS
Message-ID: <20230602133807.00000f60@Huawei.com>
In-Reply-To: <168565512544.1098279.10448422511551990530.stgit@djiang5-mobl3>
References: <168565502116.1098279.131831312990693128.stgit@djiang5-mobl3>
        <168565512544.1098279.10448422511551990530.stgit@djiang5-mobl3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 01 Jun 2023 14:32:05 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> ACPI_CEDT_DSMAS_NON_VOLATILE should be defined as
> ACPI_CDAT_DSMAS_NON_VOLATILE. Fix misspelled define.
> 
> Links: https://github.com/acpica/acpica/pull/874
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Given question of acpica addressed by your link above
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> ---
>  include/acpi/actbl1.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 58b0490a2ad1..8d5572ad48cb 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -402,7 +402,7 @@ struct acpi_cdat_dsmas {
>  
>  /* Flags for subtable above */
>  
> -#define ACPI_CEDT_DSMAS_NON_VOLATILE        (1 << 2)
> +#define ACPI_CDAT_DSMAS_NON_VOLATILE        (1 << 2)
>  
>  /* Subtable 1: Device scoped Latency and Bandwidth Information Structure (DSLBIS) */
>  
> 
> 

