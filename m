Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DDB5EC33D
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Sep 2022 14:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbiI0Mss (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Sep 2022 08:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiI0Msc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Sep 2022 08:48:32 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066E6E21EC;
        Tue, 27 Sep 2022 05:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664282912; x=1695818912;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AAIdI0RNB57IskifMX7lahsJLiiDGkz4H28pXt6CjgM=;
  b=FVgD6fkdrdA39D5oIjvIfhAWBH33EjdwnpkGYmvVdauyex82MhwGPqCx
   RN4eusoy1aFQ7E1FutH65nOcFlhYzkeXX4PfbNjcpySdppk6LwrDz/BTB
   hXYcBnPA6SOnz5Gp8huvTsinEO4IlNQv02c7nUQQvURyKNKEswhRjWen6
   7+C8Xh6oRZRrs2RjjtG4lT0dIsWkL6lgynsRn+/Qx//6/MPo9kqdmBk26
   pjxngE7BYpA9OeX4F6qDG9GqLIEb1sIaKQvVb0hZLr54+4D5VFXv+YDsr
   A/ymA1H56TYiHyX/w+IShF8kSsRutz21nr6W53aHg4LlaQ55dNG/eZobw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="302786803"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="302786803"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 05:48:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="652266364"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="652266364"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 27 Sep 2022 05:48:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1odA0g-008S3J-31;
        Tue, 27 Sep 2022 15:48:26 +0300
Date:   Tue, 27 Sep 2022 15:48:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     linux-acpi@vger.kernel.org, linux-clk@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, rafael@kernel.org,
        lenb@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        hdegoede@redhat.com, markgross@kernel.org, robert.moore@intel.com
Subject: Re: [PATCH v3 3/5] platform/x86: int3472: Support multiple clock
 consumers
Message-ID: <YzLxGmesitf6G0Ve@smile.fi.intel.com>
References: <20220921230439.768185-1-djrscally@gmail.com>
 <20220921230439.768185-4-djrscally@gmail.com>
 <YzLw1VVWDGF1YVu5@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzLw1VVWDGF1YVu5@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 27, 2022 at 03:47:17PM +0300, Andy Shevchenko wrote:
> On Thu, Sep 22, 2022 at 12:04:37AM +0100, Daniel Scally wrote:
> > At present, the tps68470.c only supports a single clock consumer when
> > passing platform data to the clock driver. In some devices multiple
> > sensors depend on the clock provided by a single TPS68470 and so all
> > need to be able to acquire the clock. Support passing multiple
> > consumers as platform data.

...

> > +static int
> > +skl_int3472_fill_clk_pdata(struct device *dev, struct tps68470_clk_platform_data **clk_pdata)
> > +{
> > +	struct acpi_device *adev = ACPI_COMPANION(dev);
> > +	struct acpi_device *consumer;
> > +	unsigned int n_consumers = 0;
> > +	const char *sensor_name;
> > +	unsigned int i = 0;
> > +
> > +	for_each_acpi_consumer_dev(adev, consumer)
> > +		n_consumers++;
> 
> Here no put for consumer (and IIUC it's correct).
> 
> > +
> 
> (Also no need to have a blank line here, the condition is tighten to
>  the for-loop.)
> 
> > +	if (!n_consumers) {
> > +		dev_err(dev, "INT3472 seems to have no dependents\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	*clk_pdata = devm_kzalloc(dev, struct_size(*clk_pdata, consumers, n_consumers),
> > +				  GFP_KERNEL);
> > +	if (!*clk_pdata)
> > +		return -ENOMEM;
> > +
> > +	(*clk_pdata)->n_consumers = n_consumers;
> > +	i = 0;
> > +
> > +	for_each_acpi_consumer_dev(adev, consumer) {
> > +		sensor_name = devm_kasprintf(dev, GFP_KERNEL, I2C_DEV_NAME_FORMAT,
> > +					     acpi_dev_name(consumer));
> > +		if (!sensor_name)
> > +			return -ENOMEM;
> > +
> > +		(*clk_pdata)->consumers[i].consumer_dev_name = sensor_name;
> > +		i++;
> > +	}
> 
> > +	acpi_dev_put(consumer);

> Why is it here?

Now I got it, you need to move it to the error path before returning from
inside the for-loop.

> > +	return n_consumers;
> > +}

-- 
With Best Regards,
Andy Shevchenko


