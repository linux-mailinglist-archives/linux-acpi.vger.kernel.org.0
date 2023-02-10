Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B508769257B
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Feb 2023 19:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbjBJSjA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 13:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbjBJSjA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 13:39:00 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2942D16E;
        Fri, 10 Feb 2023 10:38:58 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PD2TL3Ctvz6J67f;
        Sat, 11 Feb 2023 02:34:46 +0800 (CST)
Received: from localhost (10.81.210.211) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 10 Feb
 2023 18:38:55 +0000
Date:   Fri, 10 Feb 2023 18:38:54 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Fan Ni <fan.ni@samsung.com>,
        <vishal.l.verma@intel.com>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 20/20] cxl/dax: Create dax devices for CXL RAM
 regions
Message-ID: <20230210183854.000022ee@Huawei.com>
In-Reply-To: <167602003896.1924368.10335442077318970468.stgit@dwillia2-xfh.jf.intel.com>
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
        <167602003896.1924368.10335442077318970468.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.210.211]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
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

On Fri, 10 Feb 2023 01:07:19 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> While platform firmware takes some responsibility for mapping the RAM
> capacity of CXL devices present at boot, the OS is responsible for
> mapping the remainder and hot-added devices. Platform firmware is also
> responsible for identifying the platform general purpose memory pool,
> typically DDR attached DRAM, and arranging for the remainder to be 'Soft
> Reserved'. That reservation allows the CXL subsystem to route the memory
> to core-mm via memory-hotplug (dax_kmem), or leave it for dedicated
> access (device-dax).
> 
> The new 'struct cxl_dax_region' object allows for a CXL memory resource
> (region) to be published, but also allow for udev and module policy to
> act on that event. It also prevents cxl_core.ko from having a module
> loading dependency on any drivers/dax/ modules.
> 
> Tested-by: Fan Ni <fan.ni@samsung.com>
> Link: https://lore.kernel.org/r/167564545116.847146.4741351262959589920.stgit@dwillia2-xfh.jf.intel.com
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

I've not yet gotten around to testing this version yet but from a read
through looks fine.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I've skipped a patch or two where I felt I didn't have the expertise
to cover them adequately (and not enough time for now to get it...)
in particular the policy patch. Hopefully that will get
good review from others.

Jonathan


