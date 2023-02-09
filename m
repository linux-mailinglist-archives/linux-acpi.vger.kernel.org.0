Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D0A690415
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Feb 2023 10:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjBIJr3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Feb 2023 04:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBIJr2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Feb 2023 04:47:28 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E317A2B283;
        Thu,  9 Feb 2023 01:47:26 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id j23so1206273wra.0;
        Thu, 09 Feb 2023 01:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ClLp3PPP9k28DbYaMNfEXNS3WvVI0EPC4yIBTWDqEE=;
        b=M+JDhU199pYRh0D7Xx/HikLYxqi5repqdQx9VoMw9Q+n3Zlss5o/Mmr/3fibPeB1RF
         BD9+UE+V1BRxBPidZyuYGdYO+LT7r9soJnmeattn3leFVlT7VQm5qPq+E59tskd5tqJh
         a0LeVEslqO7r/ileCO4XGtFqK51VyNgURqfMmStg7NWhLGW+9iBdRCDWDRTeL8slhCoP
         2AyT+fbz54iURTgiOVMHDpKoaSQx/czBW/GxBocyA5DhUcX/QmWnJlYPsgtlUUH5Cv1P
         6daaKxyXrpbO0mq8UzB8+f8tJ4qTmi6CfzEz8W0YC6eGEYcO/n17kCOc596BKs+HUmZS
         CM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ClLp3PPP9k28DbYaMNfEXNS3WvVI0EPC4yIBTWDqEE=;
        b=CnfwSKP3aEt8OKoQ0eZusBKm+k6xPTlSKlWHmjIsXmIWYDrWljYFUqx5jkE5pZWOVi
         ekTb42j5xZiYZRD5gWW6ZFoy79FujIqE7i4/4O5Oqg1CZE2P7tN2FKvKLWp2J3dK1H6X
         InaMSiMiacCSn4Xpyaw3QWZXWKzts3W7v3efK9p8MXE8pDDgt5NIdzn4GlxPQ/0lQq+O
         nFOQX/YtmjHUN0L1Y2s8woq5WaOoBC3pbURjWggHOTD9RkNCDg9K1HFtaS1wMY5ryKKC
         kIvECQgmGHUUHIXq3Cw6gYH0VIoEP4FsIiIWwLLR21JJHY46zcFBs48myLwJtIVjLZlZ
         1mlQ==
X-Gm-Message-State: AO0yUKUGiUR5p4v649dmL8jNKMjCXtPMqTNp2kZe79an6A8TcfnLcbWz
        NsMiy68ehF8r0khvnXF7i6o=
X-Google-Smtp-Source: AK7set9abhntnv+7sQvVlWr/s1UnyhqUWhGNpNBlg4dmh7vwG4w8/m+GjrtTwW/XcL5tdyoErubQSQ==
X-Received: by 2002:adf:fa83:0:b0:2bf:ae16:817c with SMTP id h3-20020adffa83000000b002bfae16817cmr10200928wrr.29.1675936045518;
        Thu, 09 Feb 2023 01:47:25 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q13-20020adff94d000000b002be099f78c0sm795496wrr.69.2023.02.09.01.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 01:47:24 -0800 (PST)
Date:   Thu, 9 Feb 2023 12:47:20 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-acpi@vger.kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-media@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v5 2/8] ACPI: property: Parse _CRS CSI-2 descriptor
Message-ID: <202302091722.YCT7d1kl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208212712.3184953-3-sakari.ailus@linux.intel.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Sakari,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sakari-Ailus/ACPI-property-Parse-data-node-string-references-in-properties/20230209-053017
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230208212712.3184953-3-sakari.ailus%40linux.intel.com
patch subject: [PATCH v5 2/8] ACPI: property: Parse _CRS CSI-2 descriptor
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20230209/202302091722.YCT7d1kl-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202302091722.YCT7d1kl-lkp@intel.com

smatch warnings:
drivers/acpi/mipi.c:241 acpi_crs_csi2_alloc_fill_swnodes() warn: variable dereferenced before check 'ads' (see line 237)

vim +/ads +241 drivers/acpi/mipi.c

06167f6b99bad9 Sakari Ailus 2023-02-08  206  void acpi_crs_csi2_alloc_fill_swnodes(size_t ports_count, acpi_handle handle)
06167f6b99bad9 Sakari Ailus 2023-02-08  207  {
06167f6b99bad9 Sakari Ailus 2023-02-08  208  	struct acpi_device_software_nodes *ads;
06167f6b99bad9 Sakari Ailus 2023-02-08  209  	struct crs_csi2_swnodes *swnodes;
06167f6b99bad9 Sakari Ailus 2023-02-08  210  	size_t alloc_size;
06167f6b99bad9 Sakari Ailus 2023-02-08  211  	unsigned int i;
06167f6b99bad9 Sakari Ailus 2023-02-08  212  	bool overflow;
06167f6b99bad9 Sakari Ailus 2023-02-08  213  	void *end;
06167f6b99bad9 Sakari Ailus 2023-02-08  214  
06167f6b99bad9 Sakari Ailus 2023-02-08  215  	/*
06167f6b99bad9 Sakari Ailus 2023-02-08  216  	 * Allocate memory for ports, node pointers (number of nodes +
06167f6b99bad9 Sakari Ailus 2023-02-08  217  	 * 1 (guardian), nodes (root + number of ports * 2 (for for
06167f6b99bad9 Sakari Ailus 2023-02-08  218  	 * every port there is an endpoint)).
06167f6b99bad9 Sakari Ailus 2023-02-08  219  	 */
06167f6b99bad9 Sakari Ailus 2023-02-08  220  	overflow = check_mul_overflow(sizeof(*ads->ports) +
06167f6b99bad9 Sakari Ailus 2023-02-08  221  				      sizeof(*ads->nodes) * 2 +
06167f6b99bad9 Sakari Ailus 2023-02-08  222  				      sizeof(*ads->nodeptrs) * 2,
06167f6b99bad9 Sakari Ailus 2023-02-08  223  				      ports_count, &alloc_size);
06167f6b99bad9 Sakari Ailus 2023-02-08  224  	overflow = overflow ||
06167f6b99bad9 Sakari Ailus 2023-02-08  225  		   check_add_overflow(sizeof(*ads) + sizeof(*ads->nodes) +
06167f6b99bad9 Sakari Ailus 2023-02-08  226  				      sizeof(*ads->nodeptrs) * 2,
06167f6b99bad9 Sakari Ailus 2023-02-08  227  				      alloc_size, &alloc_size);
06167f6b99bad9 Sakari Ailus 2023-02-08  228  	if (overflow) {
06167f6b99bad9 Sakari Ailus 2023-02-08  229  		acpi_handle_warn(handle,
06167f6b99bad9 Sakari Ailus 2023-02-08  230  				 "too many _CRS CSI2 resource handles (%zu)",
06167f6b99bad9 Sakari Ailus 2023-02-08  231  				 ports_count);
06167f6b99bad9 Sakari Ailus 2023-02-08  232  		return;
06167f6b99bad9 Sakari Ailus 2023-02-08  233  	}
06167f6b99bad9 Sakari Ailus 2023-02-08  234  
06167f6b99bad9 Sakari Ailus 2023-02-08  235  	swnodes = kzalloc(sizeof(*swnodes), GFP_KERNEL);
06167f6b99bad9 Sakari Ailus 2023-02-08  236  	ads = kzalloc(alloc_size, GFP_KERNEL);
06167f6b99bad9 Sakari Ailus 2023-02-08 @237  	ads->ports = (void *)(ads + 1);
                                                ^^^^^^^^^^
Derference

06167f6b99bad9 Sakari Ailus 2023-02-08  238  	ads->nodes = (void *)(ads->ports + ports_count);
06167f6b99bad9 Sakari Ailus 2023-02-08  239  	ads->nodeptrs = (void *)(ads->nodes + ports_count * 2 + 1);
06167f6b99bad9 Sakari Ailus 2023-02-08  240  	end = ads->nodeptrs + ports_count * 2 + 2;
06167f6b99bad9 Sakari Ailus 2023-02-08 @241  	if (!swnodes || !ads || WARN_ON((void *)ads + alloc_size != end)) {
                                                                ^^^^
Checked to late.

06167f6b99bad9 Sakari Ailus 2023-02-08  242  		kfree(swnodes);
06167f6b99bad9 Sakari Ailus 2023-02-08  243  		kfree(ads);
06167f6b99bad9 Sakari Ailus 2023-02-08  244  		acpi_handle_debug(handle,
06167f6b99bad9 Sakari Ailus 2023-02-08  245  				  "cannot allocate for %zu software nodes\n",
06167f6b99bad9 Sakari Ailus 2023-02-08  246  				  ports_count);
06167f6b99bad9 Sakari Ailus 2023-02-08  247  		return;
06167f6b99bad9 Sakari Ailus 2023-02-08  248  	}
06167f6b99bad9 Sakari Ailus 2023-02-08  249  
06167f6b99bad9 Sakari Ailus 2023-02-08  250  	ads->num_ports = ports_count;
06167f6b99bad9 Sakari Ailus 2023-02-08  251  	for (i = 0; i < ports_count * 2 + 1; i++)
06167f6b99bad9 Sakari Ailus 2023-02-08  252  		ads->nodeptrs[i] = &ads->nodes[i];
06167f6b99bad9 Sakari Ailus 2023-02-08  253  	ads->nodeptrs[i] = NULL;
06167f6b99bad9 Sakari Ailus 2023-02-08  254  	for (i = 0; i < ports_count; i++)
06167f6b99bad9 Sakari Ailus 2023-02-08  255  		ads->ports[i].port_nr = NO_CSI2_PORT;
06167f6b99bad9 Sakari Ailus 2023-02-08  256  	swnodes->handle = handle;
06167f6b99bad9 Sakari Ailus 2023-02-08  257  	swnodes->ads = ads;
06167f6b99bad9 Sakari Ailus 2023-02-08  258  	list_add(&swnodes->list, &crs_csi2_swnodes);
06167f6b99bad9 Sakari Ailus 2023-02-08  259  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

