Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088364B9699
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Feb 2022 04:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbiBQDXP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Feb 2022 22:23:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiBQDXO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Feb 2022 22:23:14 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C8B17678C;
        Wed, 16 Feb 2022 19:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645068181; x=1676604181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XLTgaP6uMqXdgPZqvwV53mTh9SR3QNDXEQzPNJKMtnQ=;
  b=LlFnZ2jNGwOq+LP3h16NSZx7ixFXHKW2MbGGmKC68OUR2g6tCN3iWVCR
   ZH9Cwhsm4g4gsjHxEguCqXvkce1/lzJ1td1pYVd1vYmPjMLXTiCqHXjBA
   Sa3jea//O6hLRlv+mRpDdx+i3lR9NYuuJ+W5GxwZ+v4oJdsM9aMC34Wwy
   4nIGVyzF5W4FF1FmHnJ5qAmLjk9bwNIM60tORTv002TCzBjOouBuD8v/R
   Qc4cvXQw1HmF/p5rQowx5ZNc134A10O8XKutmU+ZoBQ63gQd++sVszPA0
   FPt8ZSAHJM8dYTW1XFlpBr5jY4tm6a4bm7OTjXMxgUkP3lLRP9aiSIRwS
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="250721101"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="250721101"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 19:23:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="625761461"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Feb 2022 19:22:57 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKXNh-000BMt-9U; Thu, 17 Feb 2022 03:22:57 +0000
Date:   Thu, 17 Feb 2022 11:22:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Scally <djrscally@gmail.com>, linux-acpi@vger.kernel.org,
        linux-clk@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     kbuild-all@lists.01.org, rafael@kernel.org, lenb@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, hdegoede@redhat.com,
        markgross@kernel.org, robert.moore@intel.com
Subject: Re: [PATCH 3/6] platform/x86: int3472: Support multiple clock
 consumers
Message-ID: <202202171110.7EOaTUJH-lkp@intel.com>
References: <20220216225304.53911-4-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216225304.53911-4-djrscally@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Daniel,

I love your patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on clk/clk-next linus/master v5.17-rc4 next-20220216]
[cannot apply to platform-drivers-x86/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Daniel-Scally/Add-multiple-consumer-support-to-int3472-tps68470-driver/20220217-065452
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220217/202202171110.7EOaTUJH-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
drivers/platform/x86/intel/int3472/tps68470.c:155 skl_int3472_tps68470_probe() warn: unsigned 'n_consumers' is never less than zero.

vim +/n_consumers +155 drivers/platform/x86/intel/int3472/tps68470.c

   142	
   143	static int skl_int3472_tps68470_probe(struct i2c_client *client)
   144	{
   145		struct acpi_device *adev = ACPI_COMPANION(&client->dev);
   146		const struct int3472_tps68470_board_data *board_data;
   147		struct tps68470_clk_platform_data *clk_pdata;
   148		unsigned int n_consumers;
   149		struct mfd_cell *cells;
   150		struct regmap *regmap;
   151		int device_type;
   152		int ret;
   153	
   154		n_consumers = skl_int3472_fill_clk_pdata(&client->dev, &clk_pdata);
 > 155		if (n_consumers < 0)
   156			return n_consumers;
   157	
   158		regmap = devm_regmap_init_i2c(client, &tps68470_regmap_config);
   159		if (IS_ERR(regmap)) {
   160			dev_err(&client->dev, "Failed to create regmap: %ld\n", PTR_ERR(regmap));
   161			return PTR_ERR(regmap);
   162		}
   163	
   164		i2c_set_clientdata(client, regmap);
   165	
   166		ret = tps68470_chip_init(&client->dev, regmap);
   167		if (ret < 0) {
   168			dev_err(&client->dev, "TPS68470 init error %d\n", ret);
   169			return ret;
   170		}
   171	
   172		device_type = skl_int3472_tps68470_calc_type(adev);
   173		switch (device_type) {
   174		case DESIGNED_FOR_WINDOWS:
   175			board_data = int3472_tps68470_get_board_data(dev_name(&client->dev));
   176			if (!board_data)
   177				return dev_err_probe(&client->dev, -ENODEV, "No board-data found for this model\n");
   178	
   179			cells = kcalloc(TPS68470_WIN_MFD_CELL_COUNT, sizeof(*cells), GFP_KERNEL);
   180			if (!cells)
   181				return -ENOMEM;
   182	
   183			/*
   184			 * The order of the cells matters here! The clk must be first
   185			 * because the regulator depends on it. The gpios must be last,
   186			 * acpi_gpiochip_add() calls acpi_dev_clear_dependencies() and
   187			 * the clk + regulators must be ready when this happens.
   188			 */
   189			cells[0].name = "tps68470-clk";
   190			cells[0].platform_data = clk_pdata;
   191			cells[0].pdata_size = struct_size(clk_pdata, consumers, n_consumers);
   192			cells[1].name = "tps68470-regulator";
   193			cells[1].platform_data = (void *)board_data->tps68470_regulator_pdata;
   194			cells[1].pdata_size = sizeof(struct tps68470_regulator_platform_data);
   195			cells[2].name = "tps68470-gpio";
   196	
   197			gpiod_add_lookup_table(board_data->tps68470_gpio_lookup_table);
   198	
   199			ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
   200						   cells, TPS68470_WIN_MFD_CELL_COUNT,
   201						   NULL, 0, NULL);
   202			kfree(cells);
   203	
   204			if (ret)
   205				gpiod_remove_lookup_table(board_data->tps68470_gpio_lookup_table);
   206	
   207			break;
   208		case DESIGNED_FOR_CHROMEOS:
   209			ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
   210						   tps68470_cros, ARRAY_SIZE(tps68470_cros),
   211						   NULL, 0, NULL);
   212			break;
   213		default:
   214			dev_err(&client->dev, "Failed to add MFD devices\n");
   215			return device_type;
   216		}
   217	
   218		/*
   219		 * No acpi_dev_clear_dependencies() here, since the acpi_gpiochip_add()
   220		 * for the GPIO cell already does this.
   221		 */
   222	
   223		return ret;
   224	}
   225	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
