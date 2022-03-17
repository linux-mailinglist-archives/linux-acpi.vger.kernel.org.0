Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5D04DC9C6
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Mar 2022 16:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbiCQPVE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Mar 2022 11:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235714AbiCQPVA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Mar 2022 11:21:00 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C252E15B9B5;
        Thu, 17 Mar 2022 08:19:42 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KK9kK2Wfkz67VWd;
        Thu, 17 Mar 2022 23:17:45 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 17 Mar 2022 16:19:40 +0100
Received: from localhost (10.47.67.100) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Mar
 2022 15:19:40 +0000
Date:   Thu, 17 Mar 2022 15:19:38 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Vishal Verma <vishal.l.verma@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC PATCH 0/2] acpi: add support for CXL _OSC
Message-ID: <20220317151938.000042e9@Huawei.com>
In-Reply-To: <20220317002704.1835870-1-vishal.l.verma@intel.com>
References: <20220317002704.1835870-1-vishal.l.verma@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.67.100]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 16 Mar 2022 18:27:02 -0600
Vishal Verma <vishal.l.verma@intel.com> wrote:

> Add support for using the CXL definition of _OSC where applicable, and
> negotiating CXL specific support and control bits.
> 
> Patch 1 adds the new CXL _OSC UUID, and uses it instead of the PCI UUID
> when a root port is CXL enabled. It provides a fallback method for
> CXL-1.1 devices that may not implement the CXL-2.0 _OSC.

_OSC is implemented by the firmware of a host not the device so perhaps
rephrase this.

> 
> Patch 2 performs negotiation for the CXL specific _OSC support and
> control bits.
> 
> I've tested these against a custom qemu[1], which adds the CXL _OSC (in
> addition to other CXL support). Specifically, _OSC support is added
> here[2].
> 
> [1]: https://gitlab.com/jic23/qemu/-/tree/cxl-v7-draft-2-for-test
> [2]: https://gitlab.com/jic23/qemu/-/commit/31c85054b84645dfbd9e9bb14aa35286141c14cf

Glad that worked :) I was wondering if it was correct.
There are some issues with that code raised in a recent review, so good
to have this to test against it going forwards.

Thanks,

Jonathan

> 
> Dan Williams (1):
>   PCI/ACPI: Use CXL _OSC instead of PCIe _OSC
> 
> Vishal Verma (1):
>   acpi/pci_root: negotiate CXL _OSC
> 
>  include/linux/acpi.h    |  11 +++
>  include/acpi/acpi_bus.h |   7 +-
>  drivers/acpi/pci_root.c | 201 ++++++++++++++++++++++++++++++++++------
>  3 files changed, 187 insertions(+), 32 deletions(-)
> 
> 
> base-commit: 74be98774dfbc5b8b795db726bd772e735d2edd4

