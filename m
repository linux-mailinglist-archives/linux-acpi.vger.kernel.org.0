Return-Path: <linux-acpi+bounces-1737-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1216F7F4654
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 13:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43E081C20837
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 12:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A521C2D60D
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 12:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hDATLdm7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257B2D49
	for <linux-acpi@vger.kernel.org>; Wed, 22 Nov 2023 02:42:50 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40842752c6eso33511925e9.1
        for <linux-acpi@vger.kernel.org>; Wed, 22 Nov 2023 02:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700649768; x=1701254568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rurRnFBbtA8r5xBB9XdMEov5qrYkrbGrKu11nLThWAg=;
        b=hDATLdm76jmntW5Uy3TVWYzAl2pAronH2wqQV+RujEavcyT+F1ZF4t1kU5Ht1bAA/4
         rL73J3iTSr/k2Cozi5vedAlmWKWeWqKPDbhAw1H88sMQIMSDaWiyzi8dribsgHDvjJbp
         jJ33Xr5EEZlN8k12SJuVb6O2Kp0AFTXvSGVfpBZSD952tHHpCAYgWjvn8I9N0Stoog66
         wCZeP5FLKU5M0m9akOeozhkSfNMkz/ZGB1B6Q0xt4qHr4zKRgfpw1oUwAbqMm8RI7HLe
         I7/2FHD1tT4u/Rn7jAcUUKcsznKaI/PkE+4jd7y9UjLKWJXMjVGEyzlc8+CM4+ZYOVet
         g79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700649768; x=1701254568;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rurRnFBbtA8r5xBB9XdMEov5qrYkrbGrKu11nLThWAg=;
        b=OHTrFigFP9CJL/AtA6eZ4X7cN7bV7S4rmxNtqJMRJRuGXdU0BWWrbbpIaj6m57Bo6R
         +Pz0BHxYzmwSkhGTolF/We3NagPwrMYYdClo4w7xz6kzKcDGAh7T2DkHyGc1x2/ejY1j
         PmVI4dvJbuAKotzNpXSMWUmsMbw/Z6q5mB4C9HbywwaCzrFh1tBuLhSm6WwKVopyRr6s
         Sks5auG5KJs6ClCZ5jh2Q3XqYR4E7XSKXSHLOrw9YROXjRGJxrsjBCbatgmAr4meS8gT
         RS+dmTvFhDLXzs1or9djWRS2YLhg+Rss3rI2QdQc9oAcvMRtcPzDea/dHvIJqfeGsdSX
         QE8A==
X-Gm-Message-State: AOJu0Yy/WmavAGO2IMXP82gSESgCQ8UOjrroSfZauCP55PzQKPLG3gDu
	0Mzjx0goo7rAeqyyWMOyoH36/g==
X-Google-Smtp-Source: AGHT+IFZjLI1RN+qmEZ+XlbiqgLBb55GOp+qtgAUNp2iNwKVeATclqjSDDfovff2tf+Kv7dOVUhy+w==
X-Received: by 2002:a05:600c:45d2:b0:40b:29f2:968f with SMTP id s18-20020a05600c45d200b0040b29f2968fmr1291689wmo.26.1700649768415;
        Wed, 22 Nov 2023 02:42:48 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id z5-20020adff745000000b0032d829e10c0sm16752245wrp.28.2023.11.22.02.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 02:42:47 -0800 (PST)
From: Dan Carpenter <dan.carpenter@linaro.org>
X-Google-Original-From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 22 Nov 2023 05:42:44 -0500
To: oe-kbuild@lists.linux.dev, shiju.jose@huawei.com,
	linux-cxl@vger.kernel.org, linux-mm@kvack.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	david@redhat.com, Vilas.Sridharan@amd.com, leo.duran@amd.com,
	Yazen.Ghannam@amd.com, rientjes@google.com, jiaqiyan@google.com,
	tony.luck@intel.com, Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
	rafael@kernel.org, lenb@kernel.org, naoya.horiguchi@nec.com,
	james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
	mike.malvestuto@intel.com
Subject: Re: [PATCH v2 06/10] memory: scrub: Add scrub driver supports
 configuring memory scrubbers in the system
Message-ID: <416c6883-7eaf-469a-9f5f-1829f729b78e@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121101844.1161-7-shiju.jose@huawei.com>

Hi,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/shiju-jose-huawei-com/cxl-mbox-Add-GET_SUPPORTED_FEATURES-mailbox-command/20231121-182247
base:   linus/master
patch link:    https://lore.kernel.org/r/20231121101844.1161-7-shiju.jose%40huawei.com
patch subject: [PATCH v2 06/10] memory: scrub: Add scrub driver supports configuring memory scrubbers in the system
config: powerpc-randconfig-r071-20231122 (https://download.01.org/0day-ci/archive/20231122/202311221028.fsptP2bp-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231122/202311221028.fsptP2bp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202311221028.fsptP2bp-lkp@intel.com/

smatch warnings:
drivers/memory/scrub/memory-scrub.c:71 scrub_dev_attr_is_visible() warn: this array is probably non-NULL. 'scrub_dev->name'

vim +71 drivers/memory/scrub/memory-scrub.c

248ee451a36346 Shiju Jose 2023-11-21  65  static umode_t scrub_dev_attr_is_visible(struct kobject *kobj,
248ee451a36346 Shiju Jose 2023-11-21  66  					    struct attribute *attr, int n)
248ee451a36346 Shiju Jose 2023-11-21  67  {
248ee451a36346 Shiju Jose 2023-11-21  68  	struct device *dev = kobj_to_dev(kobj);
248ee451a36346 Shiju Jose 2023-11-21  69  	struct scrub_device *scrub_dev = to_scrub_device(dev);
248ee451a36346 Shiju Jose 2023-11-21  70  
248ee451a36346 Shiju Jose 2023-11-21 @71  	if (attr == &dev_attr_name.attr && scrub_dev->name == NULL)

I wrote this check 12 years ago and it's crap.  scrub_dev->name is the
first struct member so it's the same as same as "scrub_dev".  However
to_scrub_device() can't return NULL so this check is dead code.

248ee451a36346 Shiju Jose 2023-11-21  72  		return 0;
248ee451a36346 Shiju Jose 2023-11-21  73  
248ee451a36346 Shiju Jose 2023-11-21  74  	return attr->mode;
248ee451a36346 Shiju Jose 2023-11-21  75  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


