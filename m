Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DCF27E405
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Sep 2020 10:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbgI3IoZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 30 Sep 2020 04:44:25 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2929 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbgI3IoZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 30 Sep 2020 04:44:25 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id B202F8CDE30D2099234E;
        Wed, 30 Sep 2020 09:44:23 +0100 (IST)
Received: from localhost (10.52.127.162) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Wed, 30 Sep
 2020 09:44:23 +0100
Date:   Wed, 30 Sep 2020 09:42:41 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     Nathan Chancellor <natechancellor@gmail.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <devel@acpica.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI / NUMA: Add stub function for pxm_to_node
Message-ID: <20200930094241.00002949@Huawei.com>
In-Reply-To: <c313dcd3-7fab-00eb-15f2-65a3a51f7bd5@infradead.org>
References: <20200928194554.3423466-1-natechancellor@gmail.com>
        <c313dcd3-7fab-00eb-15f2-65a3a51f7bd5@infradead.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.127.162]
X-ClientProxiedBy: lhreml707-chm.china.huawei.com (10.201.108.56) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 29 Sep 2020 13:13:24 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 9/28/20 12:45 PM, Nathan Chancellor wrote:
> > After commit 01feba590cd6 ("ACPI: Do not create new NUMA domains from
> > ACPI static tables that are not SRAT"):
> > 
> > $ scripts/config --file arch/x86/configs/x86_64_defconfig -d NUMA -e ACPI_NFIT
> > 
> > $ make -skj"$(nproc)" distclean defconfig drivers/acpi/nfit/
> > drivers/acpi/nfit/core.c: In function ‘acpi_nfit_register_region’:
> > drivers/acpi/nfit/core.c:3010:27: error: implicit declaration of
> > function ‘pxm_to_node’; did you mean ‘xa_to_node’?
> > [-Werror=implicit-function-declaration]
> >  3010 |   ndr_desc->target_node = pxm_to_node(spa->proximity_domain);
> >       |                           ^~~~~~~~~~~
> >       |                           xa_to_node
> > cc1: some warnings being treated as errors
> > ...
> > 
> > Add a stub function like acpi_map_pxm_to_node had so that the build
> > continues to work.
> > 
> > Fixes: 01feba590cd6 ("ACPI: Do not create new NUMA domains from ACPI static tables that are not SRAT")
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> > 
> > I am not sure if this is the right place or value for this. It looks
> > like there is going to be another stub function added here, which is
> > going through -mm:
> > 
> > https://lkml.kernel.org/r/159643094925.4062302.14979872973043772305.stgit@dwillia2-desk3.amr.corp.intel.com
> > 
> >  include/acpi/acpi_numa.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/include/acpi/acpi_numa.h b/include/acpi/acpi_numa.h
> > index fdebcfc6c8df..09eb3bc20ff5 100644
> > --- a/include/acpi/acpi_numa.h
> > +++ b/include/acpi/acpi_numa.h
> > @@ -22,5 +22,10 @@ extern int acpi_numa __initdata;
> >  extern void bad_srat(void);
> >  extern int srat_disabled(void);
> >  
> > +#else				/* CONFIG_ACPI_NUMA */
> > +static inline int pxm_to_node(int pxm)
> > +{
> > +	return 0;
> > +}
> >  #endif				/* CONFIG_ACPI_NUMA */
> >  #endif				/* __ACP_NUMA_H */
> > 
> > base-commit: eb6335b68ce3fc85a93c4c6cd3bb6bc5ac490efe  
> 
> OK, that works/builds. It doesn't quite apply cleanly to linux-next-20200929
> but that's a minor detail and easy to get around.
> 
> Thanks.
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
>

Looks correct to me.  Thanks!

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



