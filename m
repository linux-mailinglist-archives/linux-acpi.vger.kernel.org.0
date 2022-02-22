Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A75F4BFB1B
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Feb 2022 15:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbiBVOsV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Feb 2022 09:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbiBVOsV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Feb 2022 09:48:21 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AF91115C;
        Tue, 22 Feb 2022 06:47:54 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id h6so33729550wrb.9;
        Tue, 22 Feb 2022 06:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Qm1gUW1WMgQrValQhtP7kyXyStpeZtkZnXBE+C7tPEw=;
        b=n4UF1bZDE4nqRq8ywgwYQV2mSKjbKXEWCxAC1DibUypAFactYN470B/J+th7c6ptnW
         NGYVceYzBRyCWQ/JYex1b7zyU77wvK4s1imB1kFEZpzKKqhhrtqXdXeLtaq+l+giB1Dc
         JuNAmgIZtFGdRUEpSF4Z/abwP/IYBVeS4WGJfAIV2PEmJphgdED/+nXDWNAi9jAP+mlO
         PrzQV/qlntkvP9eA8gP9Cc2svlzbxkBSXgFFls1apsj0+zybkDcNi/zsvChleHCtM77i
         /e5U5+ZzxtmQ8y6NFvn9Zp/Aayn6M5Ox4FPfWnvoMzoNcvTSzjBNerzU8q5Ioeiw/vqG
         l+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Qm1gUW1WMgQrValQhtP7kyXyStpeZtkZnXBE+C7tPEw=;
        b=WKyGj1ARcw28UsAoSTe3YNAMimGxkPzgm5yYhB8OyLcM3bT8zQT8dILttBuIiXrAcm
         zItGqgyI4AvNdpVFu7wa5KFc2d6jWO0ULkN4i/EdgMDmWG+/Xfqjk8Bmlbcgpe+V3oTy
         S8eqlAa2cp1RsgBqRMsAVAfn9btJJ8S5TVd+UWE4/zPprKlpAWyJbKVXKiZuwMRwb+u1
         73kOy7T3n1jueu+OUqwdNBX2BR7pcYZ8xkyy2sOmWqDOvlZXwMipsc29N4u6uM6IGYn2
         hF7cGW9gCgWWCfFaT/6PpaY9CTnblIUctWAc0GW/TTYh98sMKYBZtk60Q1hfCDk1v/6R
         9oXA==
X-Gm-Message-State: AOAM531TlKoLkYaAaBoWlrFimcF4Zd+/eNbV2eX/FrwavQRXa4fF5b1e
        Pj3A4LRtNp7f9mgB2hZJENU=
X-Google-Smtp-Source: ABdhPJwUq557bc0oHkQyL1A1ZMTZsFqxUATrhtc8KaM+ZEf/FBBBC0JhbxFz2pQoWC6tgL2fB2vZKg==
X-Received: by 2002:a5d:64a6:0:b0:1ea:80f8:a14e with SMTP id m6-20020a5d64a6000000b001ea80f8a14emr3736065wrp.513.1645541272756;
        Tue, 22 Feb 2022 06:47:52 -0800 (PST)
Received: from [192.168.0.14] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id a1sm55414531wrf.42.2022.02.22.06.47.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 06:47:52 -0800 (PST)
Message-ID: <8f0b5cc3-8de9-95f0-53a5-71cb401c80e9@gmail.com>
Date:   Tue, 22 Feb 2022 14:47:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/6] platform/x86: int3472: Support multiple clock
 consumers
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        kernel test robot <lkp@intel.com>,
        linux-acpi@vger.kernel.org, linux-clk@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     kbuild-all@lists.01.org, rafael@kernel.org, lenb@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, markgross@kernel.org,
        robert.moore@intel.com
References: <20220216225304.53911-4-djrscally@gmail.com>
 <202202171110.7EOaTUJH-lkp@intel.com>
 <0bcc6093-4e38-3a0d-e619-3575bfeed410@redhat.com>
From:   Daniel Scally <djrscally@gmail.com>
In-Reply-To: <0bcc6093-4e38-3a0d-e619-3575bfeed410@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Hans

On 22/02/2022 14:44, Hans de Goede wrote:
> Hi,
>
> On 2/17/22 04:22, kernel test robot wrote:
>> Hi Daniel,
>>
>> I love your patch! Perhaps something to improve:
>>
>> [auto build test WARNING on rafael-pm/linux-next]
>> [also build test WARNING on clk/clk-next linus/master v5.17-rc4 next-20220216]
>> [cannot apply to platform-drivers-x86/for-next]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:    https://github.com/0day-ci/linux/commits/Daniel-Scally/Add-multiple-consumer-support-to-int3472-tps68470-driver/20220217-065452
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
>> config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220217/202202171110.7EOaTUJH-lkp@intel.com/config)
>> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> smatch warnings:
>> drivers/platform/x86/intel/int3472/tps68470.c:155 skl_int3472_tps68470_probe() warn: unsigned 'n_consumers' is never less than zero.
> Right this needs to be an int, not an unsigned int. Daniel, please fix this for v2.


Will do! And thanks for your comments / tags on the rest of the series;
I'll post a new version some time this week.


Dan

>
> Regards,
>
> Hans
>
>
>
>> vim +/n_consumers +155 drivers/platform/x86/intel/int3472/tps68470.c
>>
>>    142	
>>    143	static int skl_int3472_tps68470_probe(struct i2c_client *client)
>>    144	{
>>    145		struct acpi_device *adev = ACPI_COMPANION(&client->dev);
>>    146		const struct int3472_tps68470_board_data *board_data;
>>    147		struct tps68470_clk_platform_data *clk_pdata;
>>    148		unsigned int n_consumers;
>>    149		struct mfd_cell *cells;
>>    150		struct regmap *regmap;
>>    151		int device_type;
>>    152		int ret;
>>    153	
>>    154		n_consumers = skl_int3472_fill_clk_pdata(&client->dev, &clk_pdata);
>>  > 155		if (n_consumers < 0)
>>    156			return n_consumers;
>>    157	
>>    158		regmap = devm_regmap_init_i2c(client, &tps68470_regmap_config);
>>    159		if (IS_ERR(regmap)) {
>>    160			dev_err(&client->dev, "Failed to create regmap: %ld\n", PTR_ERR(regmap));
>>    161			return PTR_ERR(regmap);
>>    162		}
>>    163	
>>    164		i2c_set_clientdata(client, regmap);
>>    165	
>>    166		ret = tps68470_chip_init(&client->dev, regmap);
>>    167		if (ret < 0) {
>>    168			dev_err(&client->dev, "TPS68470 init error %d\n", ret);
>>    169			return ret;
>>    170		}
>>    171	
>>    172		device_type = skl_int3472_tps68470_calc_type(adev);
>>    173		switch (device_type) {
>>    174		case DESIGNED_FOR_WINDOWS:
>>    175			board_data = int3472_tps68470_get_board_data(dev_name(&client->dev));
>>    176			if (!board_data)
>>    177				return dev_err_probe(&client->dev, -ENODEV, "No board-data found for this model\n");
>>    178	
>>    179			cells = kcalloc(TPS68470_WIN_MFD_CELL_COUNT, sizeof(*cells), GFP_KERNEL);
>>    180			if (!cells)
>>    181				return -ENOMEM;
>>    182	
>>    183			/*
>>    184			 * The order of the cells matters here! The clk must be first
>>    185			 * because the regulator depends on it. The gpios must be last,
>>    186			 * acpi_gpiochip_add() calls acpi_dev_clear_dependencies() and
>>    187			 * the clk + regulators must be ready when this happens.
>>    188			 */
>>    189			cells[0].name = "tps68470-clk";
>>    190			cells[0].platform_data = clk_pdata;
>>    191			cells[0].pdata_size = struct_size(clk_pdata, consumers, n_consumers);
>>    192			cells[1].name = "tps68470-regulator";
>>    193			cells[1].platform_data = (void *)board_data->tps68470_regulator_pdata;
>>    194			cells[1].pdata_size = sizeof(struct tps68470_regulator_platform_data);
>>    195			cells[2].name = "tps68470-gpio";
>>    196	
>>    197			gpiod_add_lookup_table(board_data->tps68470_gpio_lookup_table);
>>    198	
>>    199			ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
>>    200						   cells, TPS68470_WIN_MFD_CELL_COUNT,
>>    201						   NULL, 0, NULL);
>>    202			kfree(cells);
>>    203	
>>    204			if (ret)
>>    205				gpiod_remove_lookup_table(board_data->tps68470_gpio_lookup_table);
>>    206	
>>    207			break;
>>    208		case DESIGNED_FOR_CHROMEOS:
>>    209			ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
>>    210						   tps68470_cros, ARRAY_SIZE(tps68470_cros),
>>    211						   NULL, 0, NULL);
>>    212			break;
>>    213		default:
>>    214			dev_err(&client->dev, "Failed to add MFD devices\n");
>>    215			return device_type;
>>    216		}
>>    217	
>>    218		/*
>>    219		 * No acpi_dev_clear_dependencies() here, since the acpi_gpiochip_add()
>>    220		 * for the GPIO cell already does this.
>>    221		 */
>>    222	
>>    223		return ret;
>>    224	}
>>    225	
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>>
