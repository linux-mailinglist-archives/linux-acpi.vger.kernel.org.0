Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134505EC334
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Sep 2022 14:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiI0Mr1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Sep 2022 08:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiI0Mr0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Sep 2022 08:47:26 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F278B161CD9;
        Tue, 27 Sep 2022 05:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664282843; x=1695818843;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kpGAEpHLvVd76YdyrLzjv/w0GPJd1G4FzfKRQuGIxyI=;
  b=KIX5UZuvwCMqKhYo6479+eg/nRutOJoDZGzOaYEnp7H+tymw14tZ9ij9
   y3trTmxDBgwGwxLxp5giqRHuWsPwYxqDHpOOGe9APG3XniIl9B8XdyQwm
   IbyDqrpl1XRNtiTAV/Lxcd2Mwro3Sx/9M9f1Uk9fm15zHqKFMtqe4Y6Ix
   cFmDZN/5C/h/W8+5fhqNfTdyw13TjqFNismWf9uSFqU3Uu5GcV7dtImqO
   +OW5u5mWOKhhD0t0u6Igp2yam/6M6R0Lm7oyDZ/Bu9BLrSsLHo0crPW3q
   vu4unMaQjcHhniYQUJYIwe8BbceMeGyZktXFFsG4DzU/jo98zTumVD64u
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="288456525"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="288456525"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 05:47:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="654713029"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="654713029"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 27 Sep 2022 05:47:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1od9zZ-008S0p-2d;
        Tue, 27 Sep 2022 15:47:17 +0300
Date:   Tue, 27 Sep 2022 15:47:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     linux-acpi@vger.kernel.org, linux-clk@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, rafael@kernel.org,
        lenb@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        hdegoede@redhat.com, markgross@kernel.org, robert.moore@intel.com
Subject: Re: [PATCH v3 3/5] platform/x86: int3472: Support multiple clock
 consumers
Message-ID: <YzLw1VVWDGF1YVu5@smile.fi.intel.com>
References: <20220921230439.768185-1-djrscally@gmail.com>
 <20220921230439.768185-4-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921230439.768185-4-djrscally@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 22, 2022 at 12:04:37AM +0100, Daniel Scally wrote:
> At present, the tps68470.c only supports a single clock consumer when
> passing platform data to the clock driver. In some devices multiple
> sensors depend on the clock provided by a single TPS68470 and so all
> need to be able to acquire the clock. Support passing multiple
> consumers as platform data.

...

> +static int
> +skl_int3472_fill_clk_pdata(struct device *dev, struct tps68470_clk_platform_data **clk_pdata)
> +{
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
> +	struct acpi_device *consumer;
> +	unsigned int n_consumers = 0;
> +	const char *sensor_name;
> +	unsigned int i = 0;
> +
> +	for_each_acpi_consumer_dev(adev, consumer)
> +		n_consumers++;

Here no put for consumer (and IIUC it's correct).

> +

(Also no need to have a blank line here, the condition is tighten to
 the for-loop.)

> +	if (!n_consumers) {
> +		dev_err(dev, "INT3472 seems to have no dependents\n");
> +		return -ENODEV;
> +	}
> +
> +	*clk_pdata = devm_kzalloc(dev, struct_size(*clk_pdata, consumers, n_consumers),
> +				  GFP_KERNEL);
> +	if (!*clk_pdata)
> +		return -ENOMEM;
> +
> +	(*clk_pdata)->n_consumers = n_consumers;
> +	i = 0;
> +
> +	for_each_acpi_consumer_dev(adev, consumer) {
> +		sensor_name = devm_kasprintf(dev, GFP_KERNEL, I2C_DEV_NAME_FORMAT,
> +					     acpi_dev_name(consumer));
> +		if (!sensor_name)
> +			return -ENOMEM;
> +
> +		(*clk_pdata)->consumers[i].consumer_dev_name = sensor_name;
> +		i++;
> +	}

> +	acpi_dev_put(consumer);

Why is it here?

> +	return n_consumers;
> +}

-- 
With Best Regards,
Andy Shevchenko


