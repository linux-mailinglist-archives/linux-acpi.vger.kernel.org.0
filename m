Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC9171A0F1
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jun 2023 16:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjFAOu2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Jun 2023 10:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbjFAOu0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2023 10:50:26 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424FA180;
        Thu,  1 Jun 2023 07:50:23 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QX8F64W2gz6J73l;
        Thu,  1 Jun 2023 22:50:18 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 1 Jun
 2023 15:50:19 +0100
Date:   Thu, 1 Jun 2023 15:50:19 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <rafael@kernel.org>, <lenb@kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <lukas@wunner.de>
Subject: Re: [PATCH v2 1/4] acpi: Move common tables helper functions to
 common lib
Message-ID: <20230601155019.00000ed3@Huawei.com>
In-Reply-To: <168443478260.2966470.6881416930240756285.stgit@djiang5-mobl3>
References: <168443445827.2966470.16511867875780059322.stgit@djiang5-mobl3>
        <168443478260.2966470.6881416930240756285.stgit@djiang5-mobl3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
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

On Thu, 18 May 2023 11:33:02 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Some of the routines in ACPI tables.c can be shared with parsing CDAT.
> However, CDAT is used by CXL and can exist on platforms that do not use
> ACPI. Split out the common routine from ACPI to accomodate platforms that
> do not support ACPI. The common routines can be built outside of ACPI if
> ACPI_TABLES_LIB is selected.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Comment inline - otherwise looks fine to me.

Jonathan

> diff --git a/drivers/acpi/tables_lib.c b/drivers/acpi/tables_lib.c
> new file mode 100644
> index 000000000000..701001610fa9
> --- /dev/null
> +++ b/drivers/acpi/tables_lib.c
> @@ -0,0 +1,194 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *  acpi_tables.c - ACPI Boot-Time Table Parsing
> + *
> + *  Copyright (C) 2001 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
> + */
> +
> +/* Uncomment next line to get verbose printout */
> +/* #define DEBUG */
> +#define pr_fmt(fmt) "ACPI: " fmt
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/smp.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +#include <linux/irq.h>

Check these includes are all needed by this subset of the
original file.

Also could take opportunity to put what is left in
alphabetical order or some other convention.


> +#include <linux/errno.h>
> +#include <linux/acpi.h>
> +#include <linux/memblock.h>
> +#include <linux/earlycpio.h>
> +#include <linux/initrd.h>
> +#include <linux/security.h>
> +#include <linux/kmemleak.h>

...

