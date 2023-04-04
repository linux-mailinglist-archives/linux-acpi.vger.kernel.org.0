Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DD66D6728
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Apr 2023 17:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjDDPWj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 4 Apr 2023 11:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjDDPWi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Apr 2023 11:22:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1DEF26A4;
        Tue,  4 Apr 2023 08:22:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D25D8D75;
        Tue,  4 Apr 2023 08:23:20 -0700 (PDT)
Received: from [10.57.19.46] (unknown [10.57.19.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2F9C3F73F;
        Tue,  4 Apr 2023 08:22:32 -0700 (PDT)
Message-ID: <60e86c22-ca05-81a0-da0a-73928e4b2c93@arm.com>
Date:   Tue, 4 Apr 2023 16:22:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V2 2/5] coresight: etm4x: Drop iomem 'base' argument from
 etm4_probe()
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com
Cc:     scclevenger@os.amperecomputing.com,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230327050537.30861-1-anshuman.khandual@arm.com>
 <20230327050537.30861-3-anshuman.khandual@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230327050537.30861-3-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 27/03/2023 06:05, Anshuman Khandual wrote:
> 'struct etm4_drvdata' itself can carry the base address before etm4_probe()
> gets called. Just drop that redundant argument from etm4_probe().
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: coresight@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 10119c223fbe..5d77571a8df9 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -2048,7 +2048,7 @@ static int etm4_add_coresight_dev(struct etm4_init_arg *init_arg)
>  	return 0;
>  }
>  
> -static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
> +static int etm4_probe(struct device *dev, u32 etm_pid)
>  {
>  	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev);
>  	struct csdev_access access = { 0 };
> @@ -2069,8 +2069,6 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
>  			return -ENOMEM;
>  	}
>  
> -	drvdata->base = base;
> -
>  	spin_lock_init(&drvdata->spinlock);
>  
>  	drvdata->cpu = coresight_get_cpu(dev);
> @@ -2124,8 +2122,9 @@ static int etm4_probe_amba(struct amba_device *adev, const struct amba_id *id)
>  	if (!drvdata)
>  		return -ENOMEM;
>  
> +	drvdata->base = base;
>  	dev_set_drvdata(dev, drvdata);
> -	ret = etm4_probe(dev, base, id->id);
> +	ret = etm4_probe(dev, id->id);
>  	if (!ret)
>  		pm_runtime_put(&adev->dev);
>  
> @@ -2141,6 +2140,7 @@ static int etm4_probe_platform_dev(struct platform_device *pdev)
>  	if (!drvdata)
>  		return -ENOMEM;
>  
> +	drvdata->base = NULL;

Very minor point, drvdata is zero alloced so it doesn't make sense to
zero this field but not the others. It's harmless, but it might imply
something and confuse someone.

Either way:
Reviewed-by: James Clark <james.clark@arm.com>

>  	dev_set_drvdata(&pdev->dev, drvdata);
>  	pm_runtime_get_noresume(&pdev->dev);
>  	pm_runtime_set_active(&pdev->dev);
> @@ -2151,7 +2151,7 @@ static int etm4_probe_platform_dev(struct platform_device *pdev)
>  	 * HW by reading appropriate registers on the HW
>  	 * and thus we could skip the PID.
>  	 */
> -	ret = etm4_probe(&pdev->dev, NULL, 0);
> +	ret = etm4_probe(&pdev->dev, 0);
>  
>  	pm_runtime_put(&pdev->dev);
>  	return ret;
