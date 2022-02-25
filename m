Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7354C43E9
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Feb 2022 12:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240262AbiBYLt5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Feb 2022 06:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240259AbiBYLt5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Feb 2022 06:49:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BAF581CABDD
        for <linux-acpi@vger.kernel.org>; Fri, 25 Feb 2022 03:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645789762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JxbpviFIwwWGMimnbBa21g7ZJ6lnEHRif+FHWwSd4G8=;
        b=JxopCy85921C5aPAtGcFE49++qK0PMENG/VRvGstl5tIrx8vtCZtFGzgmusH9LHhvNyNP3
        8nkGtzo7Epn4tehnVCXAXu+3gzxsDG+FsSpjBJoLjE3GLMF4SNfMBKPS9CsCj/uqVy8k2M
        OX57gNePX52AwABG2YWMLBw1tKmW/gQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-326-F7BFCLo-P1Gyrq519mENEw-1; Fri, 25 Feb 2022 06:49:21 -0500
X-MC-Unique: F7BFCLo-P1Gyrq519mENEw-1
Received: by mail-ej1-f70.google.com with SMTP id gn20-20020a1709070d1400b006cf1fcb4c8dso2562311ejc.12
        for <linux-acpi@vger.kernel.org>; Fri, 25 Feb 2022 03:49:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JxbpviFIwwWGMimnbBa21g7ZJ6lnEHRif+FHWwSd4G8=;
        b=70LyxoE+bHIF0/V2MlXSJUaMaI2Ph8HJm3mwMZi0pWFhAboBOVQLzncu73y1xnOpDp
         M6LJTOnCwdwFiGRF8XSGLvB8CqxMXmtNWkXmADgKem+6SRNxS2BTz2wQm2DIqEX1N/MR
         oDTAqEyevSxiMhKbRNG5xwz/GlV53Aih8LaJpEiQopvntYJJ7eSWfQMIXZh4NaoFqM9I
         1y+q2/orv3n6ePaCki6NSzFY/Tv0nvYfuSJgyvKA/qaIkMxO5OgheKthTX2ejcbWnIvg
         VxKY+dn0nlpZqs4XELji1/BQYesfonuEYsCr/wZNisKslvmD/TqpULe/x1QiBzRX7lZ8
         306w==
X-Gm-Message-State: AOAM533sHmr/Z75wZMCAeEj1ABck744L6w4VRSEZ2/WGzydchWB+3y69
        CHOY+xx+2GK1GW0jOWyc8TJJgrjof8aa0t2NevKihMc46diLeebfVifdbmcyayE/a2WvEo/a4vP
        BzsWsEGfw+ojWrM9qYK7q5g==
X-Received: by 2002:a50:d61b:0:b0:413:373c:5206 with SMTP id x27-20020a50d61b000000b00413373c5206mr6785574edi.289.1645789760320;
        Fri, 25 Feb 2022 03:49:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzx8bZd0RPnNsQ5aIvkwGntraFi27+YtdTUbUS5BpgWlxiZ3r6QJVn2X8whttEqTU9L/8tICQ==
X-Received: by 2002:a50:d61b:0:b0:413:373c:5206 with SMTP id x27-20020a50d61b000000b00413373c5206mr6785546edi.289.1645789759949;
        Fri, 25 Feb 2022 03:49:19 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id y25-20020a170906519900b006cced3e4b94sm892760ejk.138.2022.02.25.03.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 03:49:19 -0800 (PST)
Message-ID: <0d4d70ca-a17f-b8de-53f7-a85a59304d36@redhat.com>
Date:   Fri, 25 Feb 2022 12:49:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [rafael-pm:bleeding-edge 59/73]
 arch/x86/include/asm/pci_x86.h:133:19: error: expected ';' after top level
 declarator
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        kernel test robot <lkp@intel.com>
References: <202202250758.oDiHyXAy-lkp@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <202202250758.oDiHyXAy-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On 2/25/22 00:24, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
> head:   8276cbee5a52543c614a1e1bc2624188d5970848
> commit: 62fabd56faafe033eb0be3ba24000b8db13d4c17 [59/73] x86/PCI: Disable exclusion of E820 reserved addresses in some cases
> config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220225/202202250758.oDiHyXAy-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=62fabd56faafe033eb0be3ba24000b8db13d4c17
>         git remote add rafael-pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
>         git fetch --no-tags rafael-pm bleeding-edge
>         git checkout 62fabd56faafe033eb0be3ba24000b8db13d4c17
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/x86/kernel/resource.c:4:
>    arch/x86/include/asm/pci_x86.h:97:8: error: unknown type name 'raw_spinlock_t'
>    extern raw_spinlock_t pci_config_lock;
>           ^
>>> arch/x86/include/asm/pci_x86.h:133:19: error: expected ';' after top level declarator
>    extern void __init dmi_check_pciprobe(void);
>                      ^
>                      ;
>    arch/x86/include/asm/pci_x86.h:134:19: error: expected ';' after top level declarator
>    extern void __init dmi_check_skip_isa_align(void);
>                      ^
>                      ;

So the problem here seems to be that arch/x86/include/asm/pci_x86.h does not include
all the headers which it relies on. Instead it release on the files which include it
to include those headers before hand.

This should fix the errors reported here:

--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -5,7 +5,9 @@
  *	(c) 1999 Martin Mares <mj@ucw.cz>
  */
 
+#include <linux/init.h>
 #include <linux/ioport.h>
+#include <linux/spinlock.h>
 
 #undef DEBUG

I believe this is best squashed into the original commit, but let me know if
you want me to send this out as a proper follow up patch; or if you want a
new version of the troublesome commit to replace the original one.

Regards,

Hans


 




>>> arch/x86/include/asm/pci_x86.h:138:12: error: redeclaration of '__init' with a different type: 'int' vs 'void'
>    extern int __init pci_acpi_init(void);
>               ^
>    arch/x86/include/asm/pci_x86.h:134:13: note: previous declaration is here
>    extern void __init dmi_check_skip_isa_align(void);
>                ^
>    arch/x86/include/asm/pci_x86.h:138:18: error: expected ';' after top level declarator
>    extern int __init pci_acpi_init(void);
>                     ^
>                     ;
>    arch/x86/include/asm/pci_x86.h:145:19: error: expected ';' after top level declarator
>    extern void __init pcibios_irq_init(void);
>                      ^
>                      ;
>    arch/x86/include/asm/pci_x86.h:146:12: error: redeclaration of '__init' with a different type: 'int' vs 'void'
>    extern int __init pcibios_init(void);
>               ^
>    arch/x86/include/asm/pci_x86.h:145:13: note: previous declaration is here
>    extern void __init pcibios_irq_init(void);
>                ^
>    arch/x86/include/asm/pci_x86.h:146:18: error: expected ';' after top level declarator
>    extern int __init pcibios_init(void);
>                     ^
>                     ;
>    arch/x86/include/asm/pci_x86.h:166:12: error: redeclaration of '__init' with a different type: 'int' vs 'void'
>    extern int __init pci_mmcfg_arch_init(void);
>               ^
>    arch/x86/include/asm/pci_x86.h:145:13: note: previous declaration is here
>    extern void __init pcibios_irq_init(void);
>                ^
>    arch/x86/include/asm/pci_x86.h:166:18: error: expected ';' after top level declarator
>    extern int __init pci_mmcfg_arch_init(void);
>                     ^
>                     ;
>    arch/x86/include/asm/pci_x86.h:167:19: error: expected ';' after top level declarator
>    extern void __init pci_mmcfg_arch_free(void);
>                      ^
>                      ;
>>> arch/x86/include/asm/pci_x86.h:174:33: error: redeclaration of '__init' with a different type: 'struct pci_mmcfg_region *' vs 'void'
>    extern struct pci_mmcfg_region *__init pci_mmconfig_add(int segment, int start,
>                                    ^
>    arch/x86/include/asm/pci_x86.h:167:13: note: previous declaration is here
>    extern void __init pci_mmcfg_arch_free(void);
>                ^
>    arch/x86/include/asm/pci_x86.h:174:39: error: expected ';' after top level declarator
>    extern struct pci_mmcfg_region *__init pci_mmconfig_add(int segment, int start,
>                                          ^
>                                          ;
>    13 errors generated.
> 
> 
> vim +133 arch/x86/include/asm/pci_x86.h
> 
> ^1da177e4c3f41 arch/i386/pci/pci.h            Linus Torvalds     2005-04-16   96  
> d19f61f098ae93 arch/x86/include/asm/pci_x86.h Thomas Gleixner    2010-02-17  @97  extern raw_spinlock_t pci_config_lock;
> ^1da177e4c3f41 arch/i386/pci/pci.h            Linus Torvalds     2005-04-16   98  
> ^1da177e4c3f41 arch/i386/pci/pci.h            Linus Torvalds     2005-04-16   99  extern int (*pcibios_enable_irq)(struct pci_dev *dev);
> 87bec66b969152 arch/i386/pci/pci.h            David Shaohua Li   2005-07-27  100  extern void (*pcibios_disable_irq)(struct pci_dev *dev);
> 928cf8c6276334 arch/i386/pci/pci.h            Andi Kleen         2005-12-12  101  
> 6c777e8799a93e arch/x86/include/asm/pci_x86.h Bjorn Helgaas      2016-02-17  102  extern bool mp_should_keep_irq(struct device *dev);
> 6c777e8799a93e arch/x86/include/asm/pci_x86.h Bjorn Helgaas      2016-02-17  103  
> b6ce068a1285a2 arch/x86/pci/pci.h             Matthew Wilcox     2008-02-10  104  struct pci_raw_ops {
> b6ce068a1285a2 arch/x86/pci/pci.h             Matthew Wilcox     2008-02-10  105  	int (*read)(unsigned int domain, unsigned int bus, unsigned int devfn,
> b6ce068a1285a2 arch/x86/pci/pci.h             Matthew Wilcox     2008-02-10  106  						int reg, int len, u32 *val);
> b6ce068a1285a2 arch/x86/pci/pci.h             Matthew Wilcox     2008-02-10  107  	int (*write)(unsigned int domain, unsigned int bus, unsigned int devfn,
> b6ce068a1285a2 arch/x86/pci/pci.h             Matthew Wilcox     2008-02-10  108  						int reg, int len, u32 val);
> b6ce068a1285a2 arch/x86/pci/pci.h             Matthew Wilcox     2008-02-10  109  };
> b6ce068a1285a2 arch/x86/pci/pci.h             Matthew Wilcox     2008-02-10  110  
> 72da0b07b1b497 arch/x86/include/asm/pci_x86.h Jan Beulich        2011-09-15  111  extern const struct pci_raw_ops *raw_pci_ops;
> 72da0b07b1b497 arch/x86/include/asm/pci_x86.h Jan Beulich        2011-09-15  112  extern const struct pci_raw_ops *raw_pci_ext_ops;
> b6ce068a1285a2 arch/x86/pci/pci.h             Matthew Wilcox     2008-02-10  113  
> c0fa40784cce9c arch/x86/include/asm/pci_x86.h Jiang Liu          2012-06-22  114  extern const struct pci_raw_ops pci_mmcfg;
> 72da0b07b1b497 arch/x86/include/asm/pci_x86.h Jan Beulich        2011-09-15  115  extern const struct pci_raw_ops pci_direct_conf1;
> 14d7ca5c575853 arch/x86/pci/pci.h             H. Peter Anvin     2008-11-11  116  extern bool port_cf9_safe;
> 928cf8c6276334 arch/i386/pci/pci.h            Andi Kleen         2005-12-12  117  
> 8dd779b19ce597 arch/x86/pci/pci.h             Robert Richter     2008-07-02  118  /* arch_initcall level */
> 445d3595ab290b arch/x86/include/asm/pci_x86.h Thomas Gleixner    2020-08-26  119  #ifdef CONFIG_PCI_DIRECT
> 5e544d618f0fb2 arch/i386/pci/pci.h            Andi Kleen         2006-09-26  120  extern int pci_direct_probe(void);
> 5e544d618f0fb2 arch/i386/pci/pci.h            Andi Kleen         2006-09-26  121  extern void pci_direct_init(int type);
> 445d3595ab290b arch/x86/include/asm/pci_x86.h Thomas Gleixner    2020-08-26  122  #else
> 445d3595ab290b arch/x86/include/asm/pci_x86.h Thomas Gleixner    2020-08-26  123  static inline int pci_direct_probe(void) { return -1; }
> 445d3595ab290b arch/x86/include/asm/pci_x86.h Thomas Gleixner    2020-08-26  124  static inline  void pci_direct_init(int type) { }
> 445d3595ab290b arch/x86/include/asm/pci_x86.h Thomas Gleixner    2020-08-26  125  #endif
> 445d3595ab290b arch/x86/include/asm/pci_x86.h Thomas Gleixner    2020-08-26  126  
> 445d3595ab290b arch/x86/include/asm/pci_x86.h Thomas Gleixner    2020-08-26  127  #ifdef CONFIG_PCI_BIOS
> 92c05fc1a32e5c arch/i386/pci/pci.h            Andi Kleen         2006-03-23  128  extern void pci_pcbios_init(void);
> 445d3595ab290b arch/x86/include/asm/pci_x86.h Thomas Gleixner    2020-08-26  129  #else
> 445d3595ab290b arch/x86/include/asm/pci_x86.h Thomas Gleixner    2020-08-26  130  static inline void pci_pcbios_init(void) { }
> 445d3595ab290b arch/x86/include/asm/pci_x86.h Thomas Gleixner    2020-08-26  131  #endif
> 445d3595ab290b arch/x86/include/asm/pci_x86.h Thomas Gleixner    2020-08-26  132  
> 8dd779b19ce597 arch/x86/pci/pci.h             Robert Richter     2008-07-02 @133  extern void __init dmi_check_pciprobe(void);
> 8dd779b19ce597 arch/x86/pci/pci.h             Robert Richter     2008-07-02  134  extern void __init dmi_check_skip_isa_align(void);
> 8dd779b19ce597 arch/x86/pci/pci.h             Robert Richter     2008-07-02  135  
> 8dd779b19ce597 arch/x86/pci/pci.h             Robert Richter     2008-07-02  136  /* some common used subsys_initcalls */
> 5d32a66541c468 arch/x86/include/asm/pci_x86.h Sinan Kaya         2018-12-19  137  #ifdef CONFIG_PCI
> 8dd779b19ce597 arch/x86/pci/pci.h             Robert Richter     2008-07-02 @138  extern int __init pci_acpi_init(void);
> 5d32a66541c468 arch/x86/include/asm/pci_x86.h Sinan Kaya         2018-12-19  139  #else
> 5d32a66541c468 arch/x86/include/asm/pci_x86.h Sinan Kaya         2018-12-19  140  static inline int  __init pci_acpi_init(void)
> 5d32a66541c468 arch/x86/include/asm/pci_x86.h Sinan Kaya         2018-12-19  141  {
> 5d32a66541c468 arch/x86/include/asm/pci_x86.h Sinan Kaya         2018-12-19  142  	return -EINVAL;
> 5d32a66541c468 arch/x86/include/asm/pci_x86.h Sinan Kaya         2018-12-19  143  }
> 5d32a66541c468 arch/x86/include/asm/pci_x86.h Sinan Kaya         2018-12-19  144  #endif
> ab3b37937e8f4f arch/x86/include/asm/pci_x86.h Thomas Gleixner    2009-08-29  145  extern void __init pcibios_irq_init(void);
> 8dd779b19ce597 arch/x86/pci/pci.h             Robert Richter     2008-07-02  146  extern int __init pcibios_init(void);
> b72d0db9dd41da arch/x86/include/asm/pci_x86.h Thomas Gleixner    2009-08-29  147  extern int pci_legacy_init(void);
> 9325a28ce2fa7c arch/x86/include/asm/pci_x86.h Thomas Gleixner    2009-08-29  148  extern void pcibios_fixup_irqs(void);
> 5e544d618f0fb2 arch/i386/pci/pci.h            Andi Kleen         2006-09-26  149  
> b78673944b22b6 arch/i386/pci/pci.h            Olivier Galibert   2007-02-13  150  /* pci-mmconfig.c */
> b78673944b22b6 arch/i386/pci/pci.h            Olivier Galibert   2007-02-13  151  
> 56ddf4d3cf04e8 arch/x86/include/asm/pci_x86.h Bjorn Helgaas      2009-11-13  152  /* "PCI MMCONFIG %04x [bus %02x-%02x]" */
> 56ddf4d3cf04e8 arch/x86/include/asm/pci_x86.h Bjorn Helgaas      2009-11-13  153  #define PCI_MMCFG_RESOURCE_NAME_LEN (22 + 4 + 2 + 2)
> 56ddf4d3cf04e8 arch/x86/include/asm/pci_x86.h Bjorn Helgaas      2009-11-13  154  
> d215a9c8b46e55 arch/x86/include/asm/pci_x86.h Bjorn Helgaas      2009-11-13  155  struct pci_mmcfg_region {
> ff097ddd4aeac7 arch/x86/include/asm/pci_x86.h Bjorn Helgaas      2009-11-13  156  	struct list_head list;
> 56ddf4d3cf04e8 arch/x86/include/asm/pci_x86.h Bjorn Helgaas      2009-11-13  157  	struct resource res;
> d215a9c8b46e55 arch/x86/include/asm/pci_x86.h Bjorn Helgaas      2009-11-13  158  	u64 address;
> 3f0f5503926f74 arch/x86/include/asm/pci_x86.h Bjorn Helgaas      2009-11-13  159  	char __iomem *virt;
> d7e6b66fe87c9f arch/x86/include/asm/pci_x86.h Bjorn Helgaas      2009-11-13  160  	u16 segment;
> d7e6b66fe87c9f arch/x86/include/asm/pci_x86.h Bjorn Helgaas      2009-11-13  161  	u8 start_bus;
> d7e6b66fe87c9f arch/x86/include/asm/pci_x86.h Bjorn Helgaas      2009-11-13  162  	u8 end_bus;
> 56ddf4d3cf04e8 arch/x86/include/asm/pci_x86.h Bjorn Helgaas      2009-11-13  163  	char name[PCI_MMCFG_RESOURCE_NAME_LEN];
> d215a9c8b46e55 arch/x86/include/asm/pci_x86.h Bjorn Helgaas      2009-11-13  164  };
> d215a9c8b46e55 arch/x86/include/asm/pci_x86.h Bjorn Helgaas      2009-11-13  165  
> 429d512e532ec9 arch/i386/pci/pci.h            OGAWA Hirofumi     2007-02-13 @166  extern int __init pci_mmcfg_arch_init(void);
> 0b64ad7123eb01 arch/x86/pci/pci.h             Yinghai Lu         2008-02-15  167  extern void __init pci_mmcfg_arch_free(void);
> a18e3690a52790 arch/x86/include/asm/pci_x86.h Greg Kroah-Hartman 2012-12-21  168  extern int pci_mmcfg_arch_map(struct pci_mmcfg_region *cfg);
> 9cf0105da5a315 arch/x86/include/asm/pci_x86.h Jiang Liu          2012-06-22  169  extern void pci_mmcfg_arch_unmap(struct pci_mmcfg_region *cfg);
> a18e3690a52790 arch/x86/include/asm/pci_x86.h Greg Kroah-Hartman 2012-12-21  170  extern int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
> a18e3690a52790 arch/x86/include/asm/pci_x86.h Greg Kroah-Hartman 2012-12-21  171  			       phys_addr_t addr);
> 9c95111b330d2d arch/x86/include/asm/pci_x86.h Jiang Liu          2012-06-22  172  extern int pci_mmconfig_delete(u16 seg, u8 start, u8 end);
> f6e1d8cc38b377 arch/x86/include/asm/pci_x86.h Bjorn Helgaas      2009-11-13  173  extern struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus);
> 6fa4a94e150be2 arch/x86/include/asm/pci_x86.h Otavio Pontes      2018-03-07 @174  extern struct pci_mmcfg_region *__init pci_mmconfig_add(int segment, int start,
> 6fa4a94e150be2 arch/x86/include/asm/pci_x86.h Otavio Pontes      2018-03-07  175  							int end, u64 addr);
> 3320ad994afb2c arch/i386/pci/pci.h            dean gaudet        2007-08-10  176  
> 
> :::::: The code at line 133 was first introduced by commit
> :::::: 8dd779b19ce5972072ad2372a86c8acbae4da768 x86/pci: removing subsys_initcall ordering dependencies
> 
> :::::: TO: Robert Richter <robert.richter@amd.com>
> :::::: CC: Ingo Molnar <mingo@elte.hu>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

