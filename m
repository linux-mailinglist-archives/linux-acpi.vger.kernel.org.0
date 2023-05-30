Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85E171649E
	for <lists+linux-acpi@lfdr.de>; Tue, 30 May 2023 16:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjE3OoS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 May 2023 10:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjE3OoR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 30 May 2023 10:44:17 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DBE9D;
        Tue, 30 May 2023 07:44:15 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QVw8Z6zTlz6DB9Q;
        Tue, 30 May 2023 22:42:06 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 30 May
 2023 15:44:13 +0100
Date:   Tue, 30 May 2023 15:44:12 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <linux-i2c@vger.kernel.org>
CC:     Wolfram Sang <wsa@kernel.org>, Niyas Sait <niyas.sait@linaro.org>,
        Klaus Jensen <its@irrelevant.dk>,
        Andy Shevchenko <andy@kernel.org>,
        <linux-acpi@vger.kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        "Matt Johnston" <matt@codeconstruct.com.au>,
        Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>,
        <linux-cxl@vger.kernel.org>,
        "Viacheslav A . Dubeyko" <viacheslav.dubeyko@bytedance.com>
Subject: Re: [RFC PATCH 6/6] HACK: i2c: aspeed: Enable build without
 COMPILE_TEST
Message-ID: <20230530154125.0000191c@huawei.com>
In-Reply-To: <20230525152203.32190-7-Jonathan.Cameron@huawei.com>
References: <20230525152203.32190-1-Jonathan.Cameron@huawei.com>
        <20230525152203.32190-7-Jonathan.Cameron@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
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

On Thu, 25 May 2023 16:22:03 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> See cover letter for why...
> This works nicely on x86 with appropriate evil emulation.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
I'll drop this from v2. It's obviously unnecessary. I'll
just tell people who care to enable COMPILE_TEST
We shouldn't carry my lazy hack around ;)

Jonathan

> ---
>  drivers/i2c/busses/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 87600b4aacb3..96bb5a05e195 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -391,7 +391,6 @@ config I2C_ALTERA
>  
>  config I2C_ASPEED
>  	tristate "Aspeed I2C Controller"
> -	depends on ARCH_ASPEED || COMPILE_TEST
>  	help
>  	  If you say yes to this option, support will be included for the
>  	  Aspeed I2C controller.

