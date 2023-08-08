Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD71A77467A
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Aug 2023 20:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbjHHS5f (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Aug 2023 14:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbjHHS5L (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Aug 2023 14:57:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F361D3FC;
        Tue,  8 Aug 2023 10:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691515025; x=1723051025;
  h=date:from:to:cc:subject:message-id;
  bh=AWGeMYbuVJ5L7BwJCINBSuxOF6O8n3VbHXGNs71prNw=;
  b=iVJeYLAZYCL9q6NWfYdPoYnfMggPm4bjjkms9XWh/9KKl8ViZpF4CAJw
   8B5zWH1Ht3AZpiotmgrulegQszb18rz1dxon6p7c7QYXQ7PNQWzSaXB1/
   MPL6/C3kCt5UuQZV+ZzZ+YeCdc8F+Q9noOqXF3OBYu0G0S6QyF33XRUWH
   pK9CY5kNoffzonxJUriYnFd+hK08JEaYjYPuYGOEHOGqnMCWYpj9ek/aJ
   569UAKIz1U7DKJVBmUZ607B77aAWOHJDP5xinVn2ckjMKsfi/iAc/71nD
   eUf3VoLdycAHl+AoSq6JKzzSinMOKofBFSCVN9sfXo8PgDvn94hrojn2t
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="360828587"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="360828587"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 00:00:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="708137515"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="708137515"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Aug 2023 00:00:49 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qTGi1-0005As-0G;
        Tue, 08 Aug 2023 07:00:49 +0000
Date:   Tue, 08 Aug 2023 15:00:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD REGRESSION
 a478d3007320f8bee5a50522f8ac32a25ec5fc6b
Message-ID: <202308081535.FxeVihIZ-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: a478d3007320f8bee5a50522f8ac32a25ec5fc6b  Merge branch 'acpi-thermal-next' into bleeding-edge

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202308020253.WHEHp60K-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202308080324.vk0Xzw11-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202308080433.zTgDF79n-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/acpi/thermal.c:1000:40: error: passing argument 3 of 'acpi_dev_remove_notify_handler' from incompatible pointer type [-Werror=incompatible-pointer-types]
drivers/acpi/thermal.c:1007:40: error: passing argument 3 of 'acpi_dev_remove_notify_handler' from incompatible pointer type [-Werror=incompatible-pointer-types]
drivers/acpi/thermal.c:1019:32: warning: variable 'result' set but not used [-Wunused-but-set-variable]
drivers/acpi/thermal.c:810:22: error: redefinition of 'device'
drivers/acpi/thermal.c:810:29: error: 'device' redeclared as different kind of symbol
drivers/acpi/thermal.c:810:31: error: use of undeclared identifier 'data'
drivers/acpi/thermal.c:810:38: error: 'data' undeclared (first use in this function)
drivers/acpi/thermal.c:810:38: error: 'data' undeclared (first use in this function); did you mean '_data'?
drivers/acpi/thermal.c:817:29: error: 'device' redeclared as different kind of symbol
drivers/acpi/thermal.c:817:38: error: 'data' undeclared (first use in this function)
drivers/acpi/thermal.c:975:50: error: passing argument 3 of 'acpi_dev_install_notify_handler' from incompatible pointer type [-Werror=incompatible-pointer-types]
drivers/acpi/thermal.c:975:8: error: incompatible function pointer types passing 'void (struct acpi_device *, u32)' (aka 'void (struct acpi_device *, unsigned int)') to parameter of type 'acpi_notify_handler' (aka 'void (*)(void *, unsigned int, void *)') [-Wincompatible-function-pointer-types]
drivers/acpi/thermal.c:982:50: error: passing argument 3 of 'acpi_dev_install_notify_handler' from incompatible pointer type [-Werror=incompatible-pointer-types]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-allyesconfig
|   |-- drivers-acpi-thermal.c:error:data-undeclared-(first-use-in-this-function)
|   |-- drivers-acpi-thermal.c:error:device-redeclared-as-different-kind-of-symbol
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_install_notify_handler-from-incompatible-pointer-type
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_remove_notify_handler-from-incompatible-pointer-type
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- arm64-defconfig
|   |-- drivers-acpi-thermal.c:error:data-undeclared-(first-use-in-this-function)
|   |-- drivers-acpi-thermal.c:error:device-redeclared-as-different-kind-of-symbol
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_install_notify_handler-from-incompatible-pointer-type
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_remove_notify_handler-from-incompatible-pointer-type
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- i386-allyesconfig
|   |-- drivers-acpi-thermal.c:error:data-undeclared-(first-use-in-this-function)
|   |-- drivers-acpi-thermal.c:error:device-redeclared-as-different-kind-of-symbol
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_install_notify_handler-from-incompatible-pointer-type
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_remove_notify_handler-from-incompatible-pointer-type
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- i386-buildonly-randconfig-r006-20230807
|   |-- drivers-acpi-thermal.c:error:data-undeclared-(first-use-in-this-function)
|   |-- drivers-acpi-thermal.c:error:device-redeclared-as-different-kind-of-symbol
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_install_notify_handler-from-incompatible-pointer-type
|   `-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_remove_notify_handler-from-incompatible-pointer-type
|-- i386-debian-10.3
|   |-- drivers-acpi-thermal.c:error:data-undeclared-(first-use-in-this-function)
|   |-- drivers-acpi-thermal.c:error:device-redeclared-as-different-kind-of-symbol
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_install_notify_handler-from-incompatible-pointer-type
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_remove_notify_handler-from-incompatible-pointer-type
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- i386-defconfig
|   |-- drivers-acpi-thermal.c:error:data-undeclared-(first-use-in-this-function)
|   |-- drivers-acpi-thermal.c:error:device-redeclared-as-different-kind-of-symbol
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_install_notify_handler-from-incompatible-pointer-type
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_remove_notify_handler-from-incompatible-pointer-type
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- i386-randconfig-i001-20230807
|   |-- drivers-acpi-thermal.c:error:data-undeclared-(first-use-in-this-function)
|   |-- drivers-acpi-thermal.c:error:device-redeclared-as-different-kind-of-symbol
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_install_notify_handler-from-incompatible-pointer-type
|   `-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_remove_notify_handler-from-incompatible-pointer-type
|-- i386-randconfig-i002-20230807
|   |-- drivers-acpi-thermal.c:error:data-undeclared-(first-use-in-this-function)
|   |-- drivers-acpi-thermal.c:error:device-redeclared-as-different-kind-of-symbol
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_install_notify_handler-from-incompatible-pointer-type
|   `-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_remove_notify_handler-from-incompatible-pointer-type
|-- i386-randconfig-i003-20230807
|   |-- drivers-acpi-thermal.c:error:data-undeclared-(first-use-in-this-function)
|   |-- drivers-acpi-thermal.c:error:device-redeclared-as-different-kind-of-symbol
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_install_notify_handler-from-incompatible-pointer-type
|   `-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_remove_notify_handler-from-incompatible-pointer-type
|-- i386-randconfig-i005-20230807
|   |-- drivers-acpi-thermal.c:error:data-undeclared-(first-use-in-this-function)
|   |-- drivers-acpi-thermal.c:error:device-redeclared-as-different-kind-of-symbol
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_install_notify_handler-from-incompatible-pointer-type
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_remove_notify_handler-from-incompatible-pointer-type
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- i386-randconfig-i006-20230807
|   |-- drivers-acpi-thermal.c:error:data-undeclared-(first-use-in-this-function)
|   |-- drivers-acpi-thermal.c:error:device-redeclared-as-different-kind-of-symbol
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_install_notify_handler-from-incompatible-pointer-type
|   `-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_remove_notify_handler-from-incompatible-pointer-type
|-- loongarch-allmodconfig
|   |-- drivers-acpi-thermal.c:error:data-undeclared-(first-use-in-this-function)
|   |-- drivers-acpi-thermal.c:error:device-redeclared-as-different-kind-of-symbol
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_install_notify_handler-from-incompatible-pointer-type
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_remove_notify_handler-from-incompatible-pointer-type
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- loongarch-allyesconfig
|   |-- drivers-acpi-thermal.c:error:data-undeclared-(first-use-in-this-function)
|   |-- drivers-acpi-thermal.c:error:device-redeclared-as-different-kind-of-symbol
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_install_notify_handler-from-incompatible-pointer-type
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_remove_notify_handler-from-incompatible-pointer-type
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- loongarch-defconfig
|   |-- drivers-acpi-thermal.c:error:data-undeclared-(first-use-in-this-function)
|   |-- drivers-acpi-thermal.c:error:device-redeclared-as-different-kind-of-symbol
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_install_notify_handler-from-incompatible-pointer-type
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_remove_notify_handler-from-incompatible-pointer-type
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- x86_64-allyesconfig
|   |-- drivers-acpi-thermal.c:error:data-undeclared-(first-use-in-this-function)
|   |-- drivers-acpi-thermal.c:error:device-redeclared-as-different-kind-of-symbol
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_install_notify_handler-from-incompatible-pointer-type
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_remove_notify_handler-from-incompatible-pointer-type
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- x86_64-defconfig
|   |-- drivers-acpi-thermal.c:error:data-undeclared-(first-use-in-this-function)
|   |-- drivers-acpi-thermal.c:error:device-redeclared-as-different-kind-of-symbol
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_install_notify_handler-from-incompatible-pointer-type
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_remove_notify_handler-from-incompatible-pointer-type
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- x86_64-kexec
|   |-- drivers-acpi-thermal.c:error:data-undeclared-(first-use-in-this-function)
|   |-- drivers-acpi-thermal.c:error:device-redeclared-as-different-kind-of-symbol
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_install_notify_handler-from-incompatible-pointer-type
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_remove_notify_handler-from-incompatible-pointer-type
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- x86_64-randconfig-r004-20230807
|   |-- drivers-acpi-thermal.c:error:data-undeclared-(first-use-in-this-function)
|   |-- drivers-acpi-thermal.c:error:device-redeclared-as-different-kind-of-symbol
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_install_notify_handler-from-incompatible-pointer-type
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_remove_notify_handler-from-incompatible-pointer-type
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- x86_64-randconfig-x012-20230807
|   |-- drivers-acpi-thermal.c:error:data-undeclared-(first-use-in-this-function)
|   |-- drivers-acpi-thermal.c:error:device-redeclared-as-different-kind-of-symbol
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_install_notify_handler-from-incompatible-pointer-type
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_remove_notify_handler-from-incompatible-pointer-type
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- x86_64-randconfig-x013-20230807
|   |-- drivers-acpi-thermal.c:error:data-undeclared-(first-use-in-this-function)
|   |-- drivers-acpi-thermal.c:error:device-redeclared-as-different-kind-of-symbol
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_install_notify_handler-from-incompatible-pointer-type
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_remove_notify_handler-from-incompatible-pointer-type
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- x86_64-randconfig-x014-20230807
|   |-- drivers-acpi-thermal.c:error:data-undeclared-(first-use-in-this-function)
|   |-- drivers-acpi-thermal.c:error:device-redeclared-as-different-kind-of-symbol
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_install_notify_handler-from-incompatible-pointer-type
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_remove_notify_handler-from-incompatible-pointer-type
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- x86_64-randconfig-x015-20230807
|   |-- drivers-acpi-thermal.c:error:data-undeclared-(first-use-in-this-function)
|   |-- drivers-acpi-thermal.c:error:device-redeclared-as-different-kind-of-symbol
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_install_notify_handler-from-incompatible-pointer-type
|   `-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_remove_notify_handler-from-incompatible-pointer-type
|-- x86_64-randconfig-x016-20230807
|   |-- drivers-acpi-thermal.c:error:data-undeclared-(first-use-in-this-function)
|   |-- drivers-acpi-thermal.c:error:device-redeclared-as-different-kind-of-symbol
|   |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_install_notify_handler-from-incompatible-pointer-type
|   `-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_remove_notify_handler-from-incompatible-pointer-type
`-- x86_64-rhel-8.3
    |-- drivers-acpi-thermal.c:error:data-undeclared-(first-use-in-this-function)
    |-- drivers-acpi-thermal.c:error:device-redeclared-as-different-kind-of-symbol
    |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_install_notify_handler-from-incompatible-pointer-type
    |-- drivers-acpi-thermal.c:error:passing-argument-of-acpi_dev_remove_notify_handler-from-incompatible-pointer-type
    `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
clang_recent_errors
|-- i386-randconfig-i011-20230807
|   |-- drivers-acpi-thermal.c:error:incompatible-function-pointer-types-passing-void-(struct-acpi_device-u32)-(aka-void-(struct-acpi_device-unsigned-int)-)-to-parameter-of-type-acpi_notify_handler-(aka-void-
|   |-- drivers-acpi-thermal.c:error:redefinition-of-device
|   `-- drivers-acpi-thermal.c:error:use-of-undeclared-identifier-data
|-- i386-randconfig-i012-20230807
|   |-- drivers-acpi-thermal.c:error:incompatible-function-pointer-types-passing-void-(struct-acpi_device-u32)-(aka-void-(struct-acpi_device-unsigned-int)-)-to-parameter-of-type-acpi_notify_handler-(aka-void-
|   |-- drivers-acpi-thermal.c:error:redefinition-of-device
|   `-- drivers-acpi-thermal.c:error:use-of-undeclared-identifier-data
|-- i386-randconfig-i013-20230807
|   |-- drivers-acpi-thermal.c:error:incompatible-function-pointer-types-passing-void-(struct-acpi_device-u32)-(aka-void-(struct-acpi_device-unsigned-int)-)-to-parameter-of-type-acpi_notify_handler-(aka-void-
|   |-- drivers-acpi-thermal.c:error:redefinition-of-device
|   `-- drivers-acpi-thermal.c:error:use-of-undeclared-identifier-data
|-- i386-randconfig-i014-20230807
|   |-- drivers-acpi-thermal.c:error:incompatible-function-pointer-types-passing-void-(struct-acpi_device-u32)-(aka-void-(struct-acpi_device-unsigned-int)-)-to-parameter-of-type-acpi_notify_handler-(aka-void-
|   |-- drivers-acpi-thermal.c:error:redefinition-of-device
|   `-- drivers-acpi-thermal.c:error:use-of-undeclared-identifier-data
|-- i386-randconfig-i015-20230807
|   |-- drivers-acpi-thermal.c:error:incompatible-function-pointer-types-passing-void-(struct-acpi_device-u32)-(aka-void-(struct-acpi_device-unsigned-int)-)-to-parameter-of-type-acpi_notify_handler-(aka-void-
|   |-- drivers-acpi-thermal.c:error:redefinition-of-device
|   `-- drivers-acpi-thermal.c:error:use-of-undeclared-identifier-data
|-- i386-randconfig-i016-20230807
|   |-- drivers-acpi-thermal.c:error:incompatible-function-pointer-types-passing-void-(struct-acpi_device-u32)-(aka-void-(struct-acpi_device-unsigned-int)-)-to-parameter-of-type-acpi_notify_handler-(aka-void-
|   |-- drivers-acpi-thermal.c:error:redefinition-of-device
|   `-- drivers-acpi-thermal.c:error:use-of-undeclared-identifier-data
|-- x86_64-randconfig-x001-20230807
|   |-- drivers-acpi-thermal.c:error:incompatible-function-pointer-types-passing-void-(struct-acpi_device-u32)-(aka-void-(struct-acpi_device-unsigned-int)-)-to-parameter-of-type-acpi_notify_handler-(aka-void-
|   |-- drivers-acpi-thermal.c:error:redefinition-of-device
|   `-- drivers-acpi-thermal.c:error:use-of-undeclared-identifier-data
|-- x86_64-randconfig-x002-20230807
|   |-- drivers-acpi-thermal.c:error:incompatible-function-pointer-types-passing-void-(struct-acpi_device-u32)-(aka-void-(struct-acpi_device-unsigned-int)-)-to-parameter-of-type-acpi_notify_handler-(aka-void-
|   |-- drivers-acpi-thermal.c:error:redefinition-of-device
|   `-- drivers-acpi-thermal.c:error:use-of-undeclared-identifier-data
`-- x86_64-randconfig-x003-20230807
    |-- drivers-acpi-thermal.c:error:incompatible-function-pointer-types-passing-void-(struct-acpi_device-u32)-(aka-void-(struct-acpi_device-unsigned-int)-)-to-parameter-of-type-acpi_notify_handler-(aka-void-
    |-- drivers-acpi-thermal.c:error:redefinition-of-device
    `-- drivers-acpi-thermal.c:error:use-of-undeclared-identifier-data

elapsed time: 723m

configs tested: 106
configs skipped: 5

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230807   gcc  
alpha                randconfig-r016-20230807   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230807   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230807   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r021-20230807   clang
arm64                randconfig-r032-20230807   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r013-20230807   gcc  
hexagon              randconfig-r012-20230807   clang
hexagon              randconfig-r041-20230807   clang
hexagon              randconfig-r045-20230807   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230807   gcc  
i386         buildonly-randconfig-r005-20230807   gcc  
i386         buildonly-randconfig-r006-20230807   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230807   gcc  
i386                 randconfig-i002-20230807   gcc  
i386                 randconfig-i003-20230807   gcc  
i386                 randconfig-i004-20230807   gcc  
i386                 randconfig-i005-20230807   gcc  
i386                 randconfig-i006-20230807   gcc  
i386                 randconfig-i011-20230807   clang
i386                 randconfig-i012-20230807   clang
i386                 randconfig-i013-20230807   clang
i386                 randconfig-i014-20230807   clang
i386                 randconfig-i015-20230807   clang
i386                 randconfig-i016-20230807   clang
i386                 randconfig-r002-20230807   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r023-20230807   gcc  
mips                 randconfig-r035-20230807   clang
nios2                               defconfig   gcc  
nios2                randconfig-r003-20230807   gcc  
openrisc             randconfig-r024-20230807   gcc  
openrisc             randconfig-r033-20230807   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230807   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r011-20230807   clang
s390                 randconfig-r044-20230807   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r022-20230807   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r036-20230807   gcc  
sparc64              randconfig-r025-20230807   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r006-20230807   clang
um                   randconfig-r014-20230807   gcc  
um                   randconfig-r015-20230807   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230807   gcc  
x86_64       buildonly-randconfig-r002-20230807   gcc  
x86_64       buildonly-randconfig-r003-20230807   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r004-20230807   gcc  
x86_64               randconfig-x001-20230807   clang
x86_64               randconfig-x002-20230807   clang
x86_64               randconfig-x003-20230807   clang
x86_64               randconfig-x004-20230807   clang
x86_64               randconfig-x005-20230807   clang
x86_64               randconfig-x006-20230807   clang
x86_64               randconfig-x011-20230807   gcc  
x86_64               randconfig-x012-20230807   gcc  
x86_64               randconfig-x013-20230807   gcc  
x86_64               randconfig-x014-20230807   gcc  
x86_64               randconfig-x015-20230807   gcc  
x86_64               randconfig-x016-20230807   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r026-20230807   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
