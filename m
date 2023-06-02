Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDD7720224
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Jun 2023 14:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbjFBMfL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Jun 2023 08:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234571AbjFBMfK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jun 2023 08:35:10 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813741AE;
        Fri,  2 Jun 2023 05:35:07 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QXj862q2Rz6D8XS;
        Fri,  2 Jun 2023 20:32:54 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 2 Jun
 2023 13:35:05 +0100
Date:   Fri, 2 Jun 2023 13:35:04 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, <lenb@kernel.org>,
        <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <lukas@wunner.de>
Subject: Re: [PATCH v3 1/4] acpi: Move common tables helper functions to
 common lib
Message-ID: <20230602133504.00001c69@Huawei.com>
In-Reply-To: <168565511236.1098279.11767193165079131197.stgit@djiang5-mobl3>
References: <168565502116.1098279.131831312990693128.stgit@djiang5-mobl3>
        <168565511236.1098279.11767193165079131197.stgit@djiang5-mobl3>
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

On Thu, 01 Jun 2023 14:31:52 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Some of the routines in ACPI driver/acpi/tables.c can be shared with
> parsing CDAT. CDAT is a device-provided data structure that is formatted
> similar to a platform provided ACPI table. CDAT is used by CXL and can
> exist on platforms that do not use ACPI. Split out the common routine
> from ACPI to accommodate platforms that do not support ACPI and move that
> to /lib. The common routines can be built outside of ACPI if
> FIRMWARE_TABLES is selected.
> 
> Link: https://lore.kernel.org/linux-cxl/CAJZ5v0jipbtTNnsA0-o5ozOk8ZgWnOg34m34a9pPenTyRLj=6A@mail.gmail.com/
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Minor comment to fix inline. With that tidied up

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> diff --git a/include/linux/fw_table.h b/include/linux/fw_table.h
> new file mode 100644
> index 000000000000..ff8fa58d5818
> --- /dev/null
> +++ b/include/linux/fw_table.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + *  fw_tables.h - Parsing support for ACPI and ACPI-like tables provided by
> + *                platform or device firmware
> + *
> + *  Copyright (C) 2001 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
> + *  Copyright (C) 2023 Intel Corp.
> + */
> +#ifndef _FW_TABLE_H_
> +#define _FW_TABLE_H_
> +
> +union acpi_subtable_headers;
> +
> +typedef int (*acpi_tbl_entry_handler)(union acpi_subtable_headers *header,
> +				      const unsigned long end);
> +
> +typedef int (*acpi_tbl_entry_handler_arg)(union acpi_subtable_headers *header,
> +					  void *arg, const unsigned long end);
> +
> +struct acpi_subtable_proc {
> +	int id;
> +	acpi_tbl_entry_handler handler;
> +	acpi_tbl_entry_handler_arg handler_arg;
> +	void *arg;
> +	int count;
> +};
> +
> +#include <linux/acpi.h>
> +#include <acpi/acpi.h>

Includes mid way down the files is not a common pattern and I can't see why
it's particularly useful to do so here.

+ linux/acpi.h includes acpi/acpi.h and I can't see that changing any time
soon...

> +
> +union acpi_subtable_headers {
> +	struct acpi_subtable_header common;
> +	struct acpi_hmat_structure hmat;
> +	struct acpi_prmt_module_header prmt;
> +	struct acpi_cedt_header cedt;
> +};
> +
> +int acpi_parse_entries_array(char *id, unsigned long table_size,
> +			     struct acpi_table_header *table_header,
> +			     struct acpi_subtable_proc *proc,
> +			     int proc_num, unsigned int max_entries);
> +
> +#endif


