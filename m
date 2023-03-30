Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826D36CFE83
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Mar 2023 10:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjC3IiK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 30 Mar 2023 04:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjC3IiJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Mar 2023 04:38:09 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5A44EFE;
        Thu, 30 Mar 2023 01:38:08 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PnGtQ0zQ0z6J9tP;
        Thu, 30 Mar 2023 16:34:22 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 30 Mar
 2023 09:38:06 +0100
Date:   Thu, 30 Mar 2023 09:38:05 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
CC:     Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Michael Hennerich" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Jonathan Hunter" <jonathanh@nvidia.com>,
        Marc Zyngier <maz@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-staging@lists.linux.dev>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/5] iio: adc: ad7292: Add explicit include for of.h
Message-ID: <20230330093805.00003bb4@Huawei.com>
In-Reply-To: <ZCThn87xFr3wGtzP@marsc.168.1.7>
References: <20230329-acpi-header-cleanup-v1-0-8dc5cd3c610e@kernel.org>
        <20230329-acpi-header-cleanup-v1-1-8dc5cd3c610e@kernel.org>
        <ZCThn87xFr3wGtzP@marsc.168.1.7>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 29 Mar 2023 22:10:55 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 03/29, Rob Herring wrote:
> > With linux/acpi.h no longer implicitly including of.h, add an explicit
> > include of of.h to fix the following error:
> > 
> > drivers/iio/adc/ad7292.c:307:9: error: implicit declaration of function 'for_each_available_child_of_node'; did you mean 'fwnode_for_each_available_child_node'? [-Werror=implicit-function-declaration]
> > 
> > Signed-off-by: Rob Herring <robh@kernel.org>  
> 
> Acked-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> Thanks,
> Marcelo
> 
> > ---
> >  drivers/iio/adc/ad7292.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iio/adc/ad7292.c b/drivers/iio/adc/ad7292.c
> > index a2f9fda25ff3..cccacec5db6d 100644
> > --- a/drivers/iio/adc/ad7292.c
> > +++ b/drivers/iio/adc/ad7292.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/bitfield.h>
> >  #include <linux/device.h>
> >  #include <linux/module.h>
> > +#include <linux/of.h>
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/spi/spi.h>
> >  
> > 
> > -- 
> > 2.39.2
> >   

