Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB1B71629B
	for <lists+linux-acpi@lfdr.de>; Tue, 30 May 2023 15:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjE3Nut (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 May 2023 09:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjE3Nus (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 30 May 2023 09:50:48 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE12113;
        Tue, 30 May 2023 06:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685454643; x=1716990643;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=coaE20tPVJ7AZBZ9YIPPD7ohxPRVwifqLulonpO6f/c=;
  b=fja4gN7hCJmVNFFIFoOIMG9fWwsaN7mLQ8X4uGWBjjO5p659dLetg0U4
   JcA1wXe6s7760OvLEZ2GyVnhLraHDR0k2dvtCJIsHLApbZ/HNvjKO4biG
   F+rzZRF3WbnsnJYYFd/cy97IOrjW9T82l6zL513+LLGcpwVAD+fatHpP1
   F966BKV9YYgjumbo3k/H0x4JNjEOhUg9c8WirtQBPCPj4D+5c7Y1t3EmO
   n5dZevGjnkOe2fzDH8sFSywSf9ZQKJBdzhP81zu3kxfw2wnOoCpMgmatb
   zwAXA5cHvZ9rXzLeF4rIKk32imkepLz9HAKlS4nG5hyirBZUdLnAogtol
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="352418864"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="352418864"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 06:50:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="771552147"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="771552147"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 30 May 2023 06:50:23 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q3zjy-0000aN-2p;
        Tue, 30 May 2023 13:50:22 +0000
Date:   Tue, 30 May 2023 21:50:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Evan Quan <evan.quan@amd.com>, rafael@kernel.org, lenb@kernel.org,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        kvalo@kernel.org, nbd@nbd.name, lorenzo@kernel.org,
        ryder.lee@mediatek.com, shayne.chen@mediatek.com,
        sean.wang@mediatek.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, Mario.Limonciello@amd.com,
        Lijo.Lazar@amd.com
Cc:     oe-kbuild-all@lists.linux.dev, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, ath11k@lists.infradead.org
Subject: Re: [PATCH 8/9] drm/amd/pm: enable Wifi RFI mitigation feature
 support for SMU13.0.0
Message-ID: <202305302118.3mARqykY-lkp@intel.com>
References: <20230530024227.2139632-9-evan.quan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530024227.2139632-9-evan.quan@amd.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Evan,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on kvalo-ath/ath-next wireless-next/main wireless/main linus/master v6.4-rc4]
[cannot apply to next-20230530]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Evan-Quan/drivers-acpi-Add-support-for-Wifi-band-RF-mitigations/20230530-104541
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20230530024227.2139632-9-evan.quan%40amd.com
patch subject: [PATCH 8/9] drm/amd/pm: enable Wifi RFI mitigation feature support for SMU13.0.0
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20230530/202305302118.3mARqykY-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/8ecc361da81a0915bb626156b47403a91b678de1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Evan-Quan/drivers-acpi-Add-support-for-Wifi-band-RF-mitigations/20230530-104541
        git checkout 8ecc361da81a0915bb626156b47403a91b678de1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305302118.3mARqykY-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__umoddi3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>> ERROR: modpost: "__udivdi3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
