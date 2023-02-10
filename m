Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E28E692554
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Feb 2023 19:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjBJS04 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 13:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbjBJS0y (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 13:26:54 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370C77CC95;
        Fri, 10 Feb 2023 10:26:13 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PD2BQ08fnz6J64s;
        Sat, 11 Feb 2023 02:21:50 +0800 (CST)
Received: from localhost (10.81.210.211) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 10 Feb
 2023 18:25:59 +0000
Date:   Fri, 10 Feb 2023 18:25:58 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Fan Ni <fan.ni@samsung.com>,
        <vishal.l.verma@intel.com>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 18/20] dax/hmem: Move hmem device registration to
 dax_hmem.ko
Message-ID: <20230210182558.00005853@Huawei.com>
In-Reply-To: <167602002771.1924368.5653558226424530127.stgit@dwillia2-xfh.jf.intel.com>
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
        <167602002771.1924368.5653558226424530127.stgit@dwillia2-xfh.jf.intel.com>
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

On Fri, 10 Feb 2023 01:07:07 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for the CXL region driver to take over the responsibility
> of registering device-dax instances for CXL regions, move the
> registration of "hmem" devices to dax_hmem.ko.
> 
> Previously the builtin component of this enabling
> (drivers/dax/hmem/device.o) would register platform devices for each
> address range and trigger the dax_hmem.ko module to load and attach
> device-dax instances to those devices. Now, the ranges are collected
> from the HMAT and EFI memory map walking, but the device creation is
> deferred. A new "hmem_platform" device is created which triggers
> dax_hmem.ko to load and register the platform devices.
> 
> Tested-by: Fan Ni <fan.ni@samsung.com>
> Link: https://lore.kernel.org/r/167564543923.847146.9030380223622044744.stgit@dwillia2-xfh.jf.intel.com
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

I'm not particularly familiar with this code, but you changes indeed
reflect what you describe above an appear correct to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
