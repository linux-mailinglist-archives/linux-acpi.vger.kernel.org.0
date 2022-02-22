Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590354BFB0B
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Feb 2022 15:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbiBVOpi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Feb 2022 09:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiBVOph (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Feb 2022 09:45:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89AEC6540A
        for <linux-acpi@vger.kernel.org>; Tue, 22 Feb 2022 06:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645541110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pi2rjzwWJCsz1l1I4uoWGPB26BchWaIZD/weN4Zfg3Y=;
        b=Ik7SFFXbIoRxAcXAa7VF8UPEUKKq0S8fxRiTxc3VjOlh2TJf/UPbHEC1nzK7V+EgklSbv6
        OIM9P6VR13aEVw6k8Qx+Oxzxqv+2GrPX/MNw3yywYF2lfUT1qHUCuDep2YtJJmE9mFTiY0
        e+8ERilFRglv6lNZkQzrYfOSGbMrCk4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-ZDk7DfQQNpGoebCkxsckqw-1; Tue, 22 Feb 2022 09:45:08 -0500
X-MC-Unique: ZDk7DfQQNpGoebCkxsckqw-1
Received: by mail-ed1-f70.google.com with SMTP id j9-20020a056402238900b004128085d906so11138215eda.19
        for <linux-acpi@vger.kernel.org>; Tue, 22 Feb 2022 06:45:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Pi2rjzwWJCsz1l1I4uoWGPB26BchWaIZD/weN4Zfg3Y=;
        b=Tbj2PNQND0226kDFu4sArvNatRr4QPFrwCTUUdj9uHCgm+NfdoAhe4Sgjbk2qgg3XX
         5JXB/A6d7b1IW48N8ovJ+URxTatRWHvY4v3fw7x5rIh23WTGlcW/nhUyNeSr6fl9Du0l
         QFUzKUn5MkzO84TUzcwu+sEg+RD4QgUm9XfKdAxLpnZkYy3tjVrEvOkO0Fp0PjZUs0TR
         mujOq7PrMTi9sMHUMHTvdU/PzXlu+AzIGrlWPeg2fds7wGI/y1Et3m+Ukc+qVtSZnQav
         x9NtpMFrpNK8K6s1n2GSOwP2w9cCtEZEblqldLcKepO8sKnwrTD+u7laAbaUgVOeOSFa
         WXbw==
X-Gm-Message-State: AOAM532D+dQ18D1ky41bZyJk9Gor8Dkp8IhLdne6X/0K15sqiFAxf+08
        hV2zBJE+Q2RXq87gucaAxWJiFHbfMeofVqFXyi2S6j8GElZgmzNXNy1wqOPifeaRjVFVThnE25U
        GsGLk+8WsofSHsMEWHrkrtQ==
X-Received: by 2002:a05:6402:350d:b0:410:b608:ff4f with SMTP id b13-20020a056402350d00b00410b608ff4fmr26942051edd.89.1645541096294;
        Tue, 22 Feb 2022 06:44:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxvM5S5RkK76j3FGBHN8kvT6AFU1ejMN2c3FmagD8AC6C6lx/6xeCsefO8fOLWZtXqr9Vy3Bw==
X-Received: by 2002:a05:6402:350d:b0:410:b608:ff4f with SMTP id b13-20020a056402350d00b00410b608ff4fmr26942029edd.89.1645541096041;
        Tue, 22 Feb 2022 06:44:56 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id h19sm10458362edt.6.2022.02.22.06.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 06:44:55 -0800 (PST)
Message-ID: <0bcc6093-4e38-3a0d-e619-3575bfeed410@redhat.com>
Date:   Tue, 22 Feb 2022 15:44:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/6] platform/x86: int3472: Support multiple clock
 consumers
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        linux-acpi@vger.kernel.org, linux-clk@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     kbuild-all@lists.01.org, rafael@kernel.org, lenb@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, markgross@kernel.org,
        robert.moore@intel.com
References: <20220216225304.53911-4-djrscally@gmail.com>
 <202202171110.7EOaTUJH-lkp@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <202202171110.7EOaTUJH-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 2/17/22 04:22, kernel test robot wrote:
> Hi Daniel,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on rafael-pm/linux-next]
> [also build test WARNING on clk/clk-next linus/master v5.17-rc4 next-20220216]
> [cannot apply to platform-drivers-x86/for-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Daniel-Scally/Add-multiple-consumer-support-to-int3472-tps68470-driver/20220217-065452
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220217/202202171110.7EOaTUJH-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> smatch warnings:
> drivers/platform/x86/intel/int3472/tps68470.c:155 skl_int3472_tps68470_probe() warn: unsigned 'n_consumers' is never less than zero.

Right this needs to be an int, not an unsigned int. Daniel, please fix this for v2.

Regards,

Hans



> 
> vim +/n_consumers +155 drivers/platform/x86/intel/int3472/tps68470.c
> 
>    142	
>    143	static int skl_int3472_tps68470_probe(struct i2c_client *client)
>    144	{
>    145		struct acpi_device *adev = ACPI_COMPANION(&client->dev);
>    146		const struct int3472_tps68470_board_data *board_data;
>    147		struct tps68470_clk_platform_data *clk_pdata;
>    148		unsigned int n_consumers;
>    149		struct mfd_cell *cells;
>    150		struct regmap *regmap;
>    151		int device_type;
>    152		int ret;
>    153	
>    154		n_consumers = skl_int3472_fill_clk_pdata(&client->dev, &clk_pdata);
>  > 155		if (n_consumers < 0)
>    156			return n_consumers;
>    157	
>    158		regmap = devm_regmap_init_i2c(client, &tps68470_regmap_config);
>    159		if (IS_ERR(regmap)) {
>    160			dev_err(&client->dev, "Failed to create regmap: %ld\n", PTR_ERR(regmap));
>    161			return PTR_ERR(regmap);
>    162		}
>    163	
>    164		i2c_set_clientdata(client, regmap);
>    165	
>    166		ret = tps68470_chip_init(&client->dev, regmap);
>    167		if (ret < 0) {
>    168			dev_err(&client->dev, "TPS68470 init error %d\n", ret);
>    169			return ret;
>    170		}
>    171	
>    172		device_type = skl_int3472_tps68470_calc_type(adev);
>    173		switch (device_type) {
>    174		case DESIGNED_FOR_WINDOWS:
>    175			board_data = int3472_tps68470_get_board_data(dev_name(&client->dev));
>    176			if (!board_data)
>    177				return dev_err_probe(&client->dev, -ENODEV, "No board-data found for this model\n");
>    178	
>    179			cells = kcalloc(TPS68470_WIN_MFD_CELL_COUNT, sizeof(*cells), GFP_KERNEL);
>    180			if (!cells)
>    181				return -ENOMEM;
>    182	
>    183			/*
>    184			 * The order of the cells matters here! The clk must be first
>    185			 * because the regulator depends on it. The gpios must be last,
>    186			 * acpi_gpiochip_add() calls acpi_dev_clear_dependencies() and
>    187			 * the clk + regulators must be ready when this happens.
>    188			 */
>    189			cells[0].name = "tps68470-clk";
>    190			cells[0].platform_data = clk_pdata;
>    191			cells[0].pdata_size = struct_size(clk_pdata, consumers, n_consumers);
>    192			cells[1].name = "tps68470-regulator";
>    193			cells[1].platform_data = (void *)board_data->tps68470_regulator_pdata;
>    194			cells[1].pdata_size = sizeof(struct tps68470_regulator_platform_data);
>    195			cells[2].name = "tps68470-gpio";
>    196	
>    197			gpiod_add_lookup_table(board_data->tps68470_gpio_lookup_table);
>    198	
>    199			ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
>    200						   cells, TPS68470_WIN_MFD_CELL_COUNT,
>    201						   NULL, 0, NULL);
>    202			kfree(cells);
>    203	
>    204			if (ret)
>    205				gpiod_remove_lookup_table(board_data->tps68470_gpio_lookup_table);
>    206	
>    207			break;
>    208		case DESIGNED_FOR_CHROMEOS:
>    209			ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
>    210						   tps68470_cros, ARRAY_SIZE(tps68470_cros),
>    211						   NULL, 0, NULL);
>    212			break;
>    213		default:
>    214			dev_err(&client->dev, "Failed to add MFD devices\n");
>    215			return device_type;
>    216		}
>    217	
>    218		/*
>    219		 * No acpi_dev_clear_dependencies() here, since the acpi_gpiochip_add()
>    220		 * for the GPIO cell already does this.
>    221		 */
>    222	
>    223		return ret;
>    224	}
>    225	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

