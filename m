Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905CE55D9C1
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jun 2022 15:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240811AbiF0XcL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Jun 2022 19:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236744AbiF0XcL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jun 2022 19:32:11 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5003610B9;
        Mon, 27 Jun 2022 16:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656372729; x=1687908729;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O5LxPAYhM+CNwQqbN7pv8Mq8jswCUClbEwHdElRgSyk=;
  b=TEMGItocrxw5O1QM9oYXq2R/5yGVBOlMN4y3e5hnettICKueBvEa4EAV
   9cRM1v8AOdTdAQFMKvXGlmlEZI3z4L7cS20NHn/onjVTcE/0RCXR3SY29
   +xwG1P9MzYXEIWn/Oxq1tbfGc0p+FfV+DTdeOzk9BLMHQhlAGQa96GkDi
   sqjNJm7R9b+9/lLQFpHXWTHQzL8ov3MsX77uz3otsWeNTENo4NRb63R21
   XtLiHoV5gfXcrq189HGwev6DyA4U8HCvUNEeNPDAXpXdFOjt5YnhRtWos
   UNP2NCWlRBawDEvMqj0UJeqxcH0QsPAwCcl0TSNr+/VMQV38RLpZiEs2l
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="261391227"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="261391227"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 16:32:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646646287"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 27 Jun 2022 16:32:06 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5yD7-0009DG-Up;
        Mon, 27 Jun 2022 23:32:05 +0000
Date:   Tue, 28 Jun 2022 07:31:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-acpi@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v3 1/2] ACPI: utils: Add api to read _SUB from ACPI
Message-ID: <202206280722.5wvfmDeu-lkp@intel.com>
References: <20220627155138.807420-2-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627155138.807420-2-sbinding@opensource.cirrus.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Stefan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on broonie-sound/for-next linus/master v5.19-rc4 next-20220627]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Stefan-Binding/Read-_SUB-from-ACPI-to-be-able-to-identify-firmware/20220627-235448
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220628/202206280722.5wvfmDeu-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/7dd124b65442fd6622e7df2949795f735d8356be
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Stefan-Binding/Read-_SUB-from-ACPI-to-be-able-to-identify-firmware/20220627-235448
        git checkout 7dd124b65442fd6622e7df2949795f735d8356be
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/acpi/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/acpi/utils.c:17:
   drivers/acpi/utils.c: In function 'acpi_get_subsystem_id':
>> drivers/acpi/utils.c:317:49: warning: format '%d' expects argument of type 'int', but argument 4 has type 'size_t' {aka 'long unsigned int'} [-Wformat=]
     317 |                         acpi_handle_err(handle, "ACPI _SUB Length %d is Invalid\n",
         |                                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     318 |                                         strlen(obj->string.pointer));
         |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                         |
         |                                         size_t {aka long unsigned int}
   include/linux/acpi.h:1172:46: note: in definition of macro 'acpi_handle_err'
    1172 |         acpi_handle_printk(KERN_ERR, handle, fmt, ##__VA_ARGS__)
         |                                              ^~~
   drivers/acpi/utils.c:317:68: note: format string is defined here
     317 |                         acpi_handle_err(handle, "ACPI _SUB Length %d is Invalid\n",
         |                                                                   ~^
         |                                                                    |
         |                                                                    int
         |                                                                   %ld


vim +317 drivers/acpi/utils.c

   295	
   296	const char *acpi_get_subsystem_id(acpi_handle handle)
   297	{
   298		struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
   299		union acpi_object *obj;
   300		acpi_status status;
   301		const char *sub;
   302	
   303		status = acpi_evaluate_object(handle, METHOD_NAME__SUB, NULL, &buffer);
   304		if (ACPI_FAILURE(status)) {
   305			acpi_handle_debug(handle, "Reading ACPI _SUB failed: %#x\n", status);
   306			return ERR_PTR(-ENODATA);
   307		}
   308	
   309		obj = buffer.pointer;
   310		if (obj->type == ACPI_TYPE_STRING) {
   311			if (strlen(obj->string.pointer) < ACPI_MAX_SUB_BUF_SIZE &&
   312			    strlen(obj->string.pointer) > 0) {
   313				sub = kstrdup(obj->string.pointer, GFP_KERNEL);
   314				if (!sub)
   315					sub = ERR_PTR(-ENOMEM);
   316			} else {
 > 317				acpi_handle_err(handle, "ACPI _SUB Length %d is Invalid\n",
   318						strlen(obj->string.pointer));
   319				sub = ERR_PTR(-EINVAL);
   320			}
   321		} else {
   322			acpi_handle_warn(handle, "Warning ACPI _SUB did not return a string\n");
   323			sub = ERR_PTR(-EINVAL);
   324		}
   325	
   326		acpi_os_free(buffer.pointer);
   327	
   328		return sub;
   329	}
   330	EXPORT_SYMBOL_GPL(acpi_get_subsystem_id);
   331	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
