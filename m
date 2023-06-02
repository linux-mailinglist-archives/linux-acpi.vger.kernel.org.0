Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCB5720230
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Jun 2023 14:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbjFBMgv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Jun 2023 08:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbjFBMgu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jun 2023 08:36:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B0118C;
        Fri,  2 Jun 2023 05:36:48 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QXjB329yCz67J0f;
        Fri,  2 Jun 2023 20:34:35 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 2 Jun
 2023 13:36:46 +0100
Date:   Fri, 2 Jun 2023 13:36:45 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <lukas@wunner.de>
Subject: Re: [PATCH v3 2/4] lib/firmware_table: tables: Add CDAT table
 parsing support
Message-ID: <20230602133645.000036db@Huawei.com>
In-Reply-To: <168565511896.1098279.8010082917678621299.stgit@djiang5-mobl3>
References: <168565502116.1098279.131831312990693128.stgit@djiang5-mobl3>
        <168565511896.1098279.8010082917678621299.stgit@djiang5-mobl3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
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

On Thu, 01 Jun 2023 14:31:58 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> The CDAT table is very similar to ACPI tables when it comes to sub-table
> and entry structures. The helper functions can be also used to parse the
> CDAT table. Add support to the helper functions to deal with an external
> CDAT table, and also handle the endieness since CDAT can be processed by a
> BE host. Export a function cdat_table_parse() for CXL driver to parse
> a CDAT table.
> 
> In order to minimize ACPICA code changes, __force is being utilized to deal
> with the case of a big endian (BE) host parsing a CDAT. All CDAT data
> structure variables are being force casted to __leX as appropriate.
> 
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
>
LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


