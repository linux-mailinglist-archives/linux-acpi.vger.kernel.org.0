Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0ED6692485
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Feb 2023 18:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjBJRfA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 12:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjBJRe5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 12:34:57 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D5875376;
        Fri, 10 Feb 2023 09:34:57 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PD1361q8yz67Qtq;
        Sat, 11 Feb 2023 01:30:26 +0800 (CST)
Received: from localhost (10.81.210.211) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 10 Feb
 2023 17:34:54 +0000
Date:   Fri, 10 Feb 2023 17:34:53 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Fan Ni" <fan.ni@samsung.com>, <dave.hansen@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 09/20] cxl/region: Move region-position validation to
 a helper
Message-ID: <20230210173453.00002fc5@Huawei.com>
In-Reply-To: <167601997584.1924368.4615769326126138969.stgit@dwillia2-xfh.jf.intel.com>
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
        <167601997584.1924368.4615769326126138969.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.210.211]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
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

On Fri, 10 Feb 2023 01:06:15 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for region autodiscovery, that needs all devices
> discovered before their relative position in the region can be
> determined, consolidate all position dependent validation in a helper.
> 
> Recall that in the on-demand region creation flow the end-user picks the
> position of a given endpoint decoder in a region. In the autodiscovery
> case the position of an endpoint decoder can only be determined after
> all other endpoint decoders that claim to decode the region's address
> range have been enumerated and attached. So, in the autodiscovery case
> endpoint decoders may be attached before their relative position is
> known. Once all decoders arrive, then positions can be determined and
> validated with cxl_region_validate_position() the same as user initiated
> on-demand creation.
> 
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> Tested-by: Fan Ni <fan.ni@samsung.com>
> Link: https://lore.kernel.org/r/167564538779.847146.8356062886811511706.stgit@dwillia2-xfh.jf.intel.com
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

