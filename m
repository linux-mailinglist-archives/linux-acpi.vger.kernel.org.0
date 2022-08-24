Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A671559FD74
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Aug 2022 16:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238546AbiHXOmU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Aug 2022 10:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbiHXOmS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Aug 2022 10:42:18 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C84453039;
        Wed, 24 Aug 2022 07:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661352137; x=1692888137;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OhsDaWbsEJUhliaArsNuOKtaQMM8fP5ySs6yGdRcm7I=;
  b=Nr25DNy24WucI1IYkbMd+oi2y6ugcw+ZR+l40O202DN7SBWgOw4eGBiC
   bBWZTJDtM5HwwsNxD/eiWDGYaktczN1kF2wIiydtZWdQoNjYQXxUulMQb
   qiNROnfVQr97Pas80zJrNPLegSAl1MpGy4JJ8KiS4HzkBN5Y0U+dalkFU
   p6wzHJCYHxkHWCkSnQANfTHuJMw+i3NXJK7g+urslhdkuLD/B6Jpv2ToN
   Z2PObz4od5WaOZ+gWKRNEtWq8/3r+KPM4Q+Vd1cG0nuZ3MG9qJOgeQH9U
   7JZOzko+H5nqGsG0WUK1JohJlQg7v7lxbX7pBz+ByRrWWW/s9yVLew82w
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="274373175"
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="274373175"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 07:42:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="937934527"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 24 Aug 2022 07:42:15 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQraB-0000cx-0h;
        Wed, 24 Aug 2022 14:42:15 +0000
Date:   Wed, 24 Aug 2022 22:41:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     kbuild-all@lists.01.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-pm@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Subject: [rafael-pm:bleeding-edge 12/27] drivers/acpi/acpi_amba.c:100:17:
 error: 'struct acpi_device' has no member named 'parent'
Message-ID: <202208242233.FPqG2d3S-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   19c67c2579a54d65fea2ce802328ac3d0547b95c
commit: c097c05812636fef5d73b8a68444e4d885559929 [12/27] ACPI: Drop parent field from struct acpi_device
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220824/202208242233.FPqG2d3S-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=c097c05812636fef5d73b8a68444e4d885559929
        git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
        git fetch --no-tags rafael-pm bleeding-edge
        git checkout c097c05812636fef5d73b8a68444e4d885559929
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/acpi/acpi_amba.c: In function 'amba_handler_attach':
>> drivers/acpi/acpi_amba.c:100:17: error: 'struct acpi_device' has no member named 'parent'
     100 |         if (adev->parent)
         |                 ^~
   drivers/acpi/acpi_amba.c:101:68: error: 'struct acpi_device' has no member named 'parent'
     101 |                 dev->dev.parent = acpi_get_first_physical_node(adev->parent);
         |                                                                    ^~
--
   drivers/perf/arm_dsu_pmu.c: In function 'dsu_pmu_acpi_get_cpus':
>> drivers/perf/arm_dsu_pmu.c:657:33: error: 'struct acpi_device' has no member named 'parent'
     657 |                         acpi_dev->parent == ACPI_COMPANION(dev)->parent)
         |                                 ^~
   drivers/perf/arm_dsu_pmu.c:657:64: error: 'struct acpi_device' has no member named 'parent'
     657 |                         acpi_dev->parent == ACPI_COMPANION(dev)->parent)
         |                                                                ^~
--
   drivers/perf/qcom_l3_pmu.c: In function 'qcom_l3_cache_pmu_probe':
>> drivers/perf/qcom_l3_pmu.c:745:31: error: 'struct acpi_device' has no member named 'parent'
     745 |                       acpi_dev->parent->pnp.unique_id, acpi_dev->pnp.unique_id);
         |                               ^~


vim +100 drivers/acpi/acpi_amba.c

6ce2e188a6ae33 Graeme Gregory 2016-01-20   47  
6ce2e188a6ae33 Graeme Gregory 2016-01-20   48  static int amba_handler_attach(struct acpi_device *adev,
6ce2e188a6ae33 Graeme Gregory 2016-01-20   49  				const struct acpi_device_id *id)
6ce2e188a6ae33 Graeme Gregory 2016-01-20   50  {
6ce2e188a6ae33 Graeme Gregory 2016-01-20   51  	struct amba_device *dev;
6ce2e188a6ae33 Graeme Gregory 2016-01-20   52  	struct resource_entry *rentry;
6ce2e188a6ae33 Graeme Gregory 2016-01-20   53  	struct list_head resource_list;
6ce2e188a6ae33 Graeme Gregory 2016-01-20   54  	bool address_found = false;
6ce2e188a6ae33 Graeme Gregory 2016-01-20   55  	int irq_no = 0;
6ce2e188a6ae33 Graeme Gregory 2016-01-20   56  	int ret;
6ce2e188a6ae33 Graeme Gregory 2016-01-20   57  
6ce2e188a6ae33 Graeme Gregory 2016-01-20   58  	/* If the ACPI node already has a physical device attached, skip it. */
6ce2e188a6ae33 Graeme Gregory 2016-01-20   59  	if (adev->physical_node_count)
6ce2e188a6ae33 Graeme Gregory 2016-01-20   60  		return 0;
6ce2e188a6ae33 Graeme Gregory 2016-01-20   61  
6ce2e188a6ae33 Graeme Gregory 2016-01-20   62  	dev = amba_device_alloc(dev_name(&adev->dev), 0, 0);
6ce2e188a6ae33 Graeme Gregory 2016-01-20   63  	if (!dev) {
6ce2e188a6ae33 Graeme Gregory 2016-01-20   64  		dev_err(&adev->dev, "%s(): amba_device_alloc() failed\n",
6ce2e188a6ae33 Graeme Gregory 2016-01-20   65  			__func__);
6ce2e188a6ae33 Graeme Gregory 2016-01-20   66  		return -ENOMEM;
6ce2e188a6ae33 Graeme Gregory 2016-01-20   67  	}
6ce2e188a6ae33 Graeme Gregory 2016-01-20   68  
6ce2e188a6ae33 Graeme Gregory 2016-01-20   69  	INIT_LIST_HEAD(&resource_list);
6ce2e188a6ae33 Graeme Gregory 2016-01-20   70  	ret = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
6ce2e188a6ae33 Graeme Gregory 2016-01-20   71  	if (ret < 0)
6ce2e188a6ae33 Graeme Gregory 2016-01-20   72  		goto err_free;
6ce2e188a6ae33 Graeme Gregory 2016-01-20   73  
6ce2e188a6ae33 Graeme Gregory 2016-01-20   74  	list_for_each_entry(rentry, &resource_list, node) {
6ce2e188a6ae33 Graeme Gregory 2016-01-20   75  		switch (resource_type(rentry->res)) {
6ce2e188a6ae33 Graeme Gregory 2016-01-20   76  		case IORESOURCE_MEM:
6ce2e188a6ae33 Graeme Gregory 2016-01-20   77  			if (!address_found) {
6ce2e188a6ae33 Graeme Gregory 2016-01-20   78  				dev->res = *rentry->res;
7718629432676b Liguang Zhang  2021-06-29   79  				dev->res.name = dev_name(&dev->dev);
6ce2e188a6ae33 Graeme Gregory 2016-01-20   80  				address_found = true;
6ce2e188a6ae33 Graeme Gregory 2016-01-20   81  			}
6ce2e188a6ae33 Graeme Gregory 2016-01-20   82  			break;
6ce2e188a6ae33 Graeme Gregory 2016-01-20   83  		case IORESOURCE_IRQ:
6ce2e188a6ae33 Graeme Gregory 2016-01-20   84  			if (irq_no < AMBA_NR_IRQS)
6ce2e188a6ae33 Graeme Gregory 2016-01-20   85  				dev->irq[irq_no++] = rentry->res->start;
6ce2e188a6ae33 Graeme Gregory 2016-01-20   86  			break;
6ce2e188a6ae33 Graeme Gregory 2016-01-20   87  		default:
6ce2e188a6ae33 Graeme Gregory 2016-01-20   88  			dev_warn(&adev->dev, "Invalid resource\n");
6ce2e188a6ae33 Graeme Gregory 2016-01-20   89  			break;
6ce2e188a6ae33 Graeme Gregory 2016-01-20   90  		}
6ce2e188a6ae33 Graeme Gregory 2016-01-20   91  	}
6ce2e188a6ae33 Graeme Gregory 2016-01-20   92  
6ce2e188a6ae33 Graeme Gregory 2016-01-20   93  	acpi_dev_free_resource_list(&resource_list);
6ce2e188a6ae33 Graeme Gregory 2016-01-20   94  
6ce2e188a6ae33 Graeme Gregory 2016-01-20   95  	/*
6ce2e188a6ae33 Graeme Gregory 2016-01-20   96  	 * If the ACPI node has a parent and that parent has a physical device
6ce2e188a6ae33 Graeme Gregory 2016-01-20   97  	 * attached to it, that physical device should be the parent of
6ce2e188a6ae33 Graeme Gregory 2016-01-20   98  	 * the amba device we are about to create.
6ce2e188a6ae33 Graeme Gregory 2016-01-20   99  	 */
6ce2e188a6ae33 Graeme Gregory 2016-01-20 @100  	if (adev->parent)
6ce2e188a6ae33 Graeme Gregory 2016-01-20  101  		dev->dev.parent = acpi_get_first_physical_node(adev->parent);
6ce2e188a6ae33 Graeme Gregory 2016-01-20  102  
6ce2e188a6ae33 Graeme Gregory 2016-01-20  103  	ACPI_COMPANION_SET(&dev->dev, adev);
6ce2e188a6ae33 Graeme Gregory 2016-01-20  104  
6ce2e188a6ae33 Graeme Gregory 2016-01-20  105  	ret = amba_device_add(dev, &iomem_resource);
6ce2e188a6ae33 Graeme Gregory 2016-01-20  106  	if (ret) {
6ce2e188a6ae33 Graeme Gregory 2016-01-20  107  		dev_err(&adev->dev, "%s(): amba_device_add() failed (%d)\n",
6ce2e188a6ae33 Graeme Gregory 2016-01-20  108  		       __func__, ret);
6ce2e188a6ae33 Graeme Gregory 2016-01-20  109  		goto err_free;
6ce2e188a6ae33 Graeme Gregory 2016-01-20  110  	}
6ce2e188a6ae33 Graeme Gregory 2016-01-20  111  
6ce2e188a6ae33 Graeme Gregory 2016-01-20  112  	return 1;
6ce2e188a6ae33 Graeme Gregory 2016-01-20  113  
6ce2e188a6ae33 Graeme Gregory 2016-01-20  114  err_free:
6ce2e188a6ae33 Graeme Gregory 2016-01-20  115  	amba_device_put(dev);
6ce2e188a6ae33 Graeme Gregory 2016-01-20  116  	return ret;
6ce2e188a6ae33 Graeme Gregory 2016-01-20  117  }
6ce2e188a6ae33 Graeme Gregory 2016-01-20  118  

:::::: The code at line 100 was first introduced by commit
:::::: 6ce2e188a6ae339340d9bbf5bb0b81db20454353 ACPI / scan: AMBA bus probing support

:::::: TO: Graeme Gregory <graeme.gregory@linaro.org>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
