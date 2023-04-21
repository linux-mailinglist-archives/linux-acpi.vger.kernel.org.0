Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403996EAEA9
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Apr 2023 18:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjDUQGL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Apr 2023 12:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjDUQGK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Apr 2023 12:06:10 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CC6E61;
        Fri, 21 Apr 2023 09:06:08 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Q2zp973X3z6J72f;
        Sat, 22 Apr 2023 00:03:13 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 21 Apr
 2023 17:06:05 +0100
Date:   Fri, 21 Apr 2023 17:06:05 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <rafael@kernel.org>, <lukas@wunner.de>
Subject: Re: [PATCH v4 04/23] cxl: Add common helpers for cdat parsing
Message-ID: <20230421170605.00000f5a@Huawei.com>
In-Reply-To: <71fb1962-7029-119f-f12a-32849dff659a@intel.com>
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
        <168193568543.1178687.3067575213689202382.stgit@djiang5-mobl3>
        <20230420104104.000065dd@Huawei.com>
        <71fb1962-7029-119f-f12a-32849dff659a@intel.com>
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


> >> +int cdat_table_parse_sslbis(struct cdat_header *table,
> >> +			    cdat_tbl_entry_handler handler, void *arg)  
> > 
> > Feels like these ones should take a typed arg.  Sure you'll loose
> > that again to use the generic handling code, but at this level we can
> > do it I think.  
> 
> while DSMAS and DSLBIS takes a list_head, SSLBIS takes an xarray. I can 
> create a union.

I don't understand why,  If you drop the macro usage introduced in
a later patch you can just have each one take the right thing.
That macro isn't a huge saving anyway.

Jonathan

> 
> >   
> >> +{
> >> +	struct cdat_subtable_proc proc = {
> >> +		.handler	= handler,
> >> +		.arg		= arg,
> >> +	};
> >> +
> >> +	return cdat_table_parse_entries(CDAT_TYPE_SSLBIS, table, &proc);
> >> +}  
> >   
> 

