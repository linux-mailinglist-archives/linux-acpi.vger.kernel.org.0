Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C1B439831
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Oct 2021 16:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbhJYONm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Oct 2021 10:13:42 -0400
Received: from mga18.intel.com ([134.134.136.126]:32702 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233264AbhJYONl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Oct 2021 10:13:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="216568937"
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800"; 
   d="scan'208";a="216568937"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 07:11:19 -0700
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800"; 
   d="scan'208";a="496823204"
Received: from yifanyao-mobl.ccr.corp.intel.com (HELO chenyu5-mobl1) ([10.249.171.31])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 07:11:15 -0700
Date:   Mon, 25 Oct 2021 22:11:11 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/4] drivers/acpi: Introduce Platform Firmware Runtime
 Update device driver
Message-ID: <20211025141111.GA8602@chenyu5-mobl1>
References: <cover.1635140590.git.yu.c.chen@intel.com>
 <6d4a9bc38c1efd2b10955f64629d194c050fdae1.1635140590.git.yu.c.chen@intel.com>
 <YXZTDp3xB9hZdcuY@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXZTDp3xB9hZdcuY@kroah.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 25, 2021 at 08:47:42AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Oct 25, 2021 at 02:25:16PM +0800, Chen Yu wrote:
[snip...]
> > +
> > +static int acpi_pfru_probe(struct platform_device *pdev)
> > +{
> > +	struct pfru_device *pfru_dev;
> > +	acpi_handle handle;
> > +	static int pfru_idx;
> 
> Why not use an ida/idr structure for this?  You never decrement this
> when the device is removed?
>
Will fix it and use ida_alloc() for this in next version. 
> > +	int ret;
> > +
> > +	pfru_dev = devm_kzalloc(&pdev->dev, sizeof(*pfru_dev), GFP_KERNEL);
> > +	if (!pfru_dev)
> > +		return -ENOMEM;
> > +
> > +	ret = guid_parse(PFRU_UUID, &pfru_dev->uuid);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = guid_parse(PFRU_CODE_INJ_UUID, &pfru_dev->code_uuid);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = guid_parse(PFRU_DRV_UPDATE_UUID, &pfru_dev->drv_uuid);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* default rev id is 1 */
> > +	pfru_dev->rev_id = 1;
> > +	pfru_dev->dev = &pdev->dev;
> > +	handle = ACPI_HANDLE(pfru_dev->dev);
> > +	if (!acpi_has_method(handle, "_DSM")) {
> > +		dev_dbg(&pdev->dev, "Missing _DSM\n");
> > +		return -ENODEV;
> > +	}
> 
> Why not make this check first, before you allocate or parse anything?
>
Will fix it in next version. 
> > +
> > +	pfru_dev->miscdev.minor = MISC_DYNAMIC_MINOR;
> > +	pfru_dev->miscdev.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> > +						"pfru%d", pfru_idx);
> > +	if (!pfru_dev->miscdev.name)
> > +		return -ENOMEM;
> > +
> > +	pfru_dev->miscdev.nodename = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> > +						    "acpi_pfru%d", pfru_idx);
> > +	if (!pfru_dev->miscdev.nodename)
> > +		return -ENOMEM;
> > +
> > +	pfru_idx++;
> > +	pfru_dev->miscdev.fops = &acpi_pfru_fops;
> > +
> > +	ret = misc_register(&pfru_dev->miscdev);
> > +	if (ret)
> > +		return ret;
> 
> You forgot to set the parent of the misc device here, right?  :(
> 
>
Ah, yes, will fix it in next version. 
> > +
> > +	platform_set_drvdata(pdev, pfru_dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct acpi_device_id acpi_pfru_ids[] = {
> > +	{"INTC1080", 0},
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(acpi, acpi_pfru_ids);
> > +
> > +static struct platform_driver acpi_pfru_driver = {
> > +	.driver = {
> > +		.name = "pfru_update",
> > +		.acpi_match_table = acpi_pfru_ids,
> > +	},
> > +	.probe = acpi_pfru_probe,
> > +	.remove = acpi_pfru_remove,
> > +};
> > +
> > +static int __init pfru_init(void)
> > +{
> > +	return platform_driver_register(&acpi_pfru_driver);
> > +}
> > +
> > +static void __exit pfru_exit(void)
> > +{
> > +	platform_driver_unregister(&acpi_pfru_driver);
> > +}
> > +
> > +module_init(pfru_init);
> > +module_exit(pfru_exit);
> 
> module_platform_driver()?
>
Currently there are two platform drivers in this file, one is this
platform driver, another one will be introduced in the subsequent
patch for telemetry. Since the two platform drivers are treated
as a whole, they are put into one file. Should I split them
into two files?

thanks,
Chenyu 
> thanks,
> 
> greg k-h
