Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802B879E716
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Sep 2023 13:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240449AbjIMLrN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Sep 2023 07:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbjIMLrK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Sep 2023 07:47:10 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD901989
        for <linux-acpi@vger.kernel.org>; Wed, 13 Sep 2023 04:46:44 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d2e1a72fcca58-68fac346f6aso3491150b3a.3
        for <linux-acpi@vger.kernel.org>; Wed, 13 Sep 2023 04:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694605604; x=1695210404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nITPxVDnC41/6mqrOtoGNiOb/yuzadv3G0v6KlC07k=;
        b=e10G3CcsM+tsqLRo77+uBRn4SQGzB2pc+6TcoR3xqGDaXoxSJv+TPWWUKl8GeKsrhX
         Bcbi+W8O7GMSFhrUnWPUpa4Ox+UPAX1m1K9E76o5J5pj/zDSH2LFoiOZy/X+rv7j3/xi
         bFFgFqL6Lc9O3HdoJjgh9jp1/MGPa2Q/5b9TDJz9wI6KW2w43xVOcAAQYwOLnDvXBmKu
         XqrfvTpx2jrCm2epmOdX3hkvScfc7dps96TkA/2IzaDsxA+AVe6axOfH4n0DZsFTDXgE
         +hoKVGpL/z5n43MZSrG5+L8kqKacKsRr/iyf3ofJfWy7NbJszkrGmAGke2AtYtJm4SZ/
         WajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694605604; x=1695210404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nITPxVDnC41/6mqrOtoGNiOb/yuzadv3G0v6KlC07k=;
        b=vxRSQZyM8h2mV2ERuvwbspKRnkI4/lLnJs0etYJc5zhJyCOVYg1Q7zkqZWLKlLooy/
         ekInk0oYtsvdyoP5LIZLOjJBIhQiapOvpZfbMIBiR2SP0O0ELaFBGA7OmuE3E5oPntHX
         ZShujBLtR6fruFfVpE3pHCzkDWqFRTEbBH4EyUvTtcDA8IayM0xv6VtLl+Ax7YMKLbqz
         MMGT6f9QR4SI+Ik+0lwgpdnXnj//VMtXQriDTEp/Q6a4hY2nBu+4nL+5Ci5L7QTO3yBH
         NAjrB/jNYiKzrSeNxNcp69oX2+rExuha8AYbCawXnqWm8gBldyd2b7aPMV9FO/Jx/ewF
         5wKg==
X-Gm-Message-State: AOJu0YxVnB6cgoYjtuswOBiMqZqPER5U8Et4BWt8SHEJxWg6jSeA1kbq
        WAP0a7Ful26jsUSZbBdlxoTniA==
X-Google-Smtp-Source: AGHT+IF5VM5hzkBEO13mv1Q/VU2jY3YJ+ax2K89xqvIKqKVeOhgZo4a5+WbdKRLdhkgdM/NeHs6qXg==
X-Received: by 2002:a05:6a21:3e09:b0:14e:b4d5:782e with SMTP id bk9-20020a056a213e0900b0014eb4d5782emr2104693pzc.29.1694605603948;
        Wed, 13 Sep 2023 04:46:43 -0700 (PDT)
Received: from PF2LML5M-SMJ.bytedance.net ([220.243.131.6])
        by smtp.gmail.com with ESMTPSA id iz2-20020a170902ef8200b001b5656b0bf9sm10246025plb.286.2023.09.13.04.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 04:46:43 -0700 (PDT)
From:   Jinhui Guo <guojinhui.liam@bytedance.com>
To:     lkp@intel.com
Cc:     gregkh@linuxfoundation.org, guojinhui.liam@bytedance.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, lizefan.x@bytedance.com,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        rafael@kernel.org
Subject: Re: [PATCH] driver core: platform: set numa_node before platform_add_device()
Date:   Wed, 13 Sep 2023 19:46:31 +0800
Message-Id: <20230913114631.2966-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <202309131848.CgiiHpZu-lkp@intel.com>
References: <202309131848.CgiiHpZu-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> Hi guojinhui.liam,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v6.6-rc1 next-20230913]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/guojinhui-liam/driver-core-platform-set-numa_node-before-platform_add_device/20230912-151119
> base:   linus/master
> patch link:    https://lore.kernel.org/r/20230912070900.1862-1-guojinhui.liam%40bytedance.com
> patch subject: [PATCH] driver core: platform: set numa_node before platform_add_device()
> config: um-allyesconfig (https://download.01.org/0day-ci/archive/20230913/202309131848.CgiiHpZu-lkp@intel.com/config)
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230913/202309131848.CgiiHpZu-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202309131848.CgiiHpZu-lkp@intel.com/
> ...

Is there anyone known how to stop this test for my first patch? I have sent a new one to review, which fixes the compile bug.

thanks,

Jinhui Guo
