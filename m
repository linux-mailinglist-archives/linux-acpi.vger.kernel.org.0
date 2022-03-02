Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BDF4CA02B
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Mar 2022 10:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240288AbiCBJBV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Mar 2022 04:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238235AbiCBJBV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Mar 2022 04:01:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6703355778
        for <linux-acpi@vger.kernel.org>; Wed,  2 Mar 2022 01:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646211637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nglozkwZ9E5oM3xxjiOvdMHp+P3p2GEbi9ZIptGZfLU=;
        b=aoOtKIisQYmErAxb3S8p5uJsOS0f5cwI8mgIJZ+yI4l/kV1vaj2us/zvp4SrX4Ri1Np17e
        yGgOGuKq2LjGmDybf930LYjcJT1YK2l/kRClM9itEvrBRENVKRRNblTlD35gVfHjoBEhOj
        /7YwAr8RLDO11YnnnLkl4qkddPZ+XB0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576-HwAN6i2VNnucwkNwAAWk_A-1; Wed, 02 Mar 2022 04:00:36 -0500
X-MC-Unique: HwAN6i2VNnucwkNwAAWk_A-1
Received: by mail-ed1-f71.google.com with SMTP id z24-20020a50cd18000000b00414d5314c35so597795edi.21
        for <linux-acpi@vger.kernel.org>; Wed, 02 Mar 2022 01:00:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nglozkwZ9E5oM3xxjiOvdMHp+P3p2GEbi9ZIptGZfLU=;
        b=Gs/F4bJDr3mxFqDzFuS8/eW9OXQwFmDIM0FPP+YXcHJYYohm7HLa0fiFvpFZ9ksNP9
         n80DUwXkLA5JiVASuTzLmBskUi9txKOXaDuqgRzMpf00ttnImsO8R8lcvGnVno7rLE2c
         abhZOdEjfPivrU+7Xb2sFIpgIqVL8dbYuWxNTu1ScZPisw0gLMQu1VkoX9Rosyk72gHj
         h6m/LKzMztShR2BPZZ7MusqNjRl+wF0h/6sS/2Gj3VI4/zlyL/Ef+Jf8fioIFMkkpBt/
         TTarEv0K1OrPCXAz8XUqPa2plHPufOY0VMUJDonDg0dIb9AdUtjQs6NkYX1hBMixHr3e
         +YkQ==
X-Gm-Message-State: AOAM531+Pl3lxvx5qNNIW4z6QpCEIW0fA81Ya6d6g4INeTyojkz/lh/b
        FFIpee043Gre8HshGPQP7j4h1aneNNpywATz4+oVMML/LMBgD5Vvz27cwVfggxIW8/r/3UfrLt/
        Mb5ZD+MEoxgxmvt6Y+qXeiQ==
X-Received: by 2002:a17:907:8a25:b0:6d7:d59:6912 with SMTP id sc37-20020a1709078a2500b006d70d596912mr4089326ejc.259.1646211635239;
        Wed, 02 Mar 2022 01:00:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw2PFOMyGct2RwZCRKJpVo0k7br2d4b17H/TgVXIFh2tZdS2AyukmH9dplP1caqs7n3pFiayw==
X-Received: by 2002:a17:907:8a25:b0:6d7:d59:6912 with SMTP id sc37-20020a1709078a2500b006d70d596912mr4089310ejc.259.1646211634977;
        Wed, 02 Mar 2022 01:00:34 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id d4-20020a1709067a0400b006d6e3ca9f71sm1609122ejo.198.2022.03.02.01.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 01:00:34 -0800 (PST)
Message-ID: <a429c799-f293-89b5-417b-3aa9cfeef457@redhat.com>
Date:   Wed, 2 Mar 2022 10:00:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [rafael-pm:bleeding-edge 113/118]
 arch/x86/kernel/acpi/boot.c:1476:8: warning: excess elements in array
 initializer
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, Mark Cilissen <mark@yotsuba.nl>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <202203020737.wa9uc4gW-lkp@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <202203020737.wa9uc4gW-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On 3/2/22 03:51, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> head:   f7307721a01f4f14d21c699b270a870370cf34b9
> commit: ed00b2b8d737f87a2437d7bd7c7f90124b50da05 [113/118] x86 / ACPI: Work around broken XSDT on SEGA AALE board
> config: i386-randconfig-a011 (https://download.01.org/0day-ci/archive/20220302/202203020737.wa9uc4gW-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=ed00b2b8d737f87a2437d7bd7c7f90124b50da05
>         git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
>         git fetch --no-tags rafael-pm bleeding-edge
>         git checkout ed00b2b8d737f87a2437d7bd7c7f90124b50da05
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kernel/acpi/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>>> arch/x86/kernel/acpi/boot.c:1476:8: warning: excess elements in array initializer [-Wexcess-initializers]
>                         DMI_MATCH(DMI_BIOS_DATE, "02/01/2011"),
>                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/mod_devicetable.h:587:25: note: expanded from macro 'DMI_MATCH'
>    #define DMI_MATCH(a, b) { .slot = a, .substr = b }
>                            ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    1 warning generated.
> 
> 
> vim +1476 arch/x86/kernel/acpi/boot.c
> 
>   1389	
>   1390	/*
>   1391	 * If your system is blacklisted here, but you find that acpi=force
>   1392	 * works for you, please contact linux-acpi@vger.kernel.org
>   1393	 */
>   1394	static const struct dmi_system_id acpi_dmi_table[] __initconst = {
>   1395		/*
>   1396		 * Boxes that need ACPI disabled
>   1397		 */
>   1398		{
>   1399		 .callback = dmi_disable_acpi,
>   1400		 .ident = "IBM Thinkpad",
>   1401		 .matches = {
>   1402			     DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),
>   1403			     DMI_MATCH(DMI_BOARD_NAME, "2629H1G"),
>   1404			     },
>   1405		 },
>   1406	
>   1407		/*
>   1408		 * Boxes that need ACPI PCI IRQ routing disabled
>   1409		 */
>   1410		{
>   1411		 .callback = disable_acpi_irq,
>   1412		 .ident = "ASUS A7V",
>   1413		 .matches = {
>   1414			     DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC"),
>   1415			     DMI_MATCH(DMI_BOARD_NAME, "<A7V>"),
>   1416			     /* newer BIOS, Revision 1011, does work */
>   1417			     DMI_MATCH(DMI_BIOS_VERSION,
>   1418				       "ASUS A7V ACPI BIOS Revision 1007"),
>   1419			     },
>   1420		 },
>   1421		{
>   1422			/*
>   1423			 * Latest BIOS for IBM 600E (1.16) has bad pcinum
>   1424			 * for LPC bridge, which is needed for the PCI
>   1425			 * interrupt links to work. DSDT fix is in bug 5966.
>   1426			 * 2645, 2646 model numbers are shared with 600/600E/600X
>   1427			 */
>   1428		 .callback = disable_acpi_irq,
>   1429		 .ident = "IBM Thinkpad 600 Series 2645",
>   1430		 .matches = {
>   1431			     DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),
>   1432			     DMI_MATCH(DMI_BOARD_NAME, "2645"),
>   1433			     },
>   1434		 },
>   1435		{
>   1436		 .callback = disable_acpi_irq,
>   1437		 .ident = "IBM Thinkpad 600 Series 2646",
>   1438		 .matches = {
>   1439			     DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),
>   1440			     DMI_MATCH(DMI_BOARD_NAME, "2646"),
>   1441			     },
>   1442		 },
>   1443		/*
>   1444		 * Boxes that need ACPI PCI IRQ routing and PCI scan disabled
>   1445		 */
>   1446		{			/* _BBN 0 bug */
>   1447		 .callback = disable_acpi_pci,
>   1448		 .ident = "ASUS PR-DLS",
>   1449		 .matches = {
>   1450			     DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
>   1451			     DMI_MATCH(DMI_BOARD_NAME, "PR-DLS"),
>   1452			     DMI_MATCH(DMI_BIOS_VERSION,
>   1453				       "ASUS PR-DLS ACPI BIOS Revision 1010"),
>   1454			     DMI_MATCH(DMI_BIOS_DATE, "03/21/2003")
>   1455			     },
>   1456		 },
>   1457		{
>   1458		 .callback = disable_acpi_pci,
>   1459		 .ident = "Acer TravelMate 36x Laptop",
>   1460		 .matches = {
>   1461			     DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
>   1462			     DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 360"),
>   1463			     },
>   1464		 },
>   1465		/*
>   1466		 * Boxes that need ACPI XSDT use disabled due to corrupted tables
>   1467		 */
>   1468		{
>   1469		 .callback = disable_acpi_xsdt,
>   1470		 .ident = "SEGA AALE",
>   1471		 .matches = {
>   1472			     DMI_MATCH(DMI_SYS_VENDOR, "NEC"),
>   1473			     DMI_MATCH(DMI_PRODUCT_NAME, "Bearlake CRB Board"),
>   1474			     DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
>   1475			     DMI_MATCH(DMI_BIOS_VERSION, "V1.12"),
>> 1476			     DMI_MATCH(DMI_BIOS_DATE, "02/01/2011"),
>   1477			     },

Ah, right there can be max 4 matches for a single dmi_system_id table entry.

Mark, I think the BIOS-vendor match has little value, so that can be dropped, do you
agree?

Regards,

Hans





