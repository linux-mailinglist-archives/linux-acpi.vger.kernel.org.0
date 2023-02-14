Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C3F69649A
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Feb 2023 14:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjBNNXl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 Feb 2023 08:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjBNNXk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Feb 2023 08:23:40 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7266C5FEB;
        Tue, 14 Feb 2023 05:23:39 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PGMHC09Mbz6J7f8;
        Tue, 14 Feb 2023 21:19:03 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Tue, 14 Feb
 2023 13:23:37 +0000
Date:   Tue, 14 Feb 2023 13:23:36 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Fan Ni <fan.ni@samsung.com>,
        <vishal.l.verma@intel.com>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 13/20] cxl/region: Add region autodiscovery
Message-ID: <20230214132336.00005915@Huawei.com>
In-Reply-To: <63e6b89581c3c_1db5d029467@dwillia2-xfh.jf.intel.com.notmuch>
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
        <167601999958.1924368.9366954455835735048.stgit@dwillia2-xfh.jf.intel.com>
        <20230210180958.00002e5a@Huawei.com>
        <63e6b89581c3c_1db5d029467@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


> > 
> > 		/*
> > 		 * If device_attach() fails the range may still be active via
> > 		 * the platform-firmware memory map, otherwise the driver for
> > 		 * regions is local to this file, so driver matching can't fail
> > +                * and hence device_attach() cannot return 1.
> > 
> > //very much not obvious otherwise to anyone who isn't far too familiar with device_attach()  
> 
> Hence the comment? Not sure what else can be said here about why
> device_attach() < 0 is a sufficient check.

I'd just add the bit I added above that calls out the condition you are
describing is indicated by a return of 1.



