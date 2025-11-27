Return-Path: <linux-acpi+bounces-19332-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AF8C8FDF7
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 19:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DCBA4E1EBB
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 18:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6345C2FDC4B;
	Thu, 27 Nov 2025 18:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jc29asDp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3242A2FDC37
	for <linux-acpi@vger.kernel.org>; Thu, 27 Nov 2025 18:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764267003; cv=none; b=GakKxkzUN7dnOZvIbFM7tne4XCCTvCEcCzEKLJehnw9mzlhCuiKtMGWOebxdrMPiCA1oIt0KVyQF2r0yJ6cdbkNxHX3oS+l5wYyHfXrcolXXy3Sf7eSapC1SNoZxmCil4C5qV1MaxKHtyNbwVSrGQ8YMIYcGVnPR0tczG4QISHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764267003; c=relaxed/simple;
	bh=mjIImdNaHtUFvvXlOK6pE8V72hbYBHg+Voc9qEUtsbk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KN5h9Z4uaQ+Ky3o4J+zLj1bRdROMWaPaijkDa8yQWu9IwgN1LS/HnPPhQ5S8AjoU9DGWY0MR2dhismoO07IO3VabGy/uCu4YB5z8LEQtxhLo43lWJH3yYgaVUSIKyaKqE4NJmqWK6vSWPo+6QIZYaCYxFYYuQyySHnILyraV54U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jc29asDp; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-429c4c65485so1070395f8f.0
        for <linux-acpi@vger.kernel.org>; Thu, 27 Nov 2025 10:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764266999; x=1764871799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dx7dLWF3fYt4YAydLoSYihtQG3rPcHN7URxJi8Fj67U=;
        b=jc29asDpPv8WUCKJh0v1fwH6vWRcnJtBs2rhxoiz71kvBglPjQFIRitrBRG/m5HK0e
         qPhbefY2zjcxWVAgwG6Lhtq+lRzlNHed3citUuo1tzTGD9u55HfffGeVxiil0b52C6mo
         Xh09WG5a01KaWQfG4b7U/newcNAx2RvFNffWbMZGsh8FTGq7qdQgFPZ0Erk80BVxztYu
         MMZz9Tsp+Ng3mS1SzCVcCpRzz5lCvkzZH/v1/eo7wNZHWkRlmwm+kkzZrvf3nsSw7ypr
         MyG1PzImUEnK04g0lG5uME7iycHzmbpxnmnMhfGdbbgzIHerQxgdf6XWUt/42Dh516JC
         jfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764266999; x=1764871799;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dx7dLWF3fYt4YAydLoSYihtQG3rPcHN7URxJi8Fj67U=;
        b=GSldrwracDC2qAkcpzICXxgzaM91H/fMpj681cH1BjCEDgCCEt/vShQw+jnAJH1b/v
         8Ohq7u+apXftYOvr83Yf1SN62znAvN4sG0/LN8uzHlOV8oJKqwiAQ6lPRfs1DJNa3xMr
         LsbMlcVOiE4+DaZjNAGgzfFV/69E5UrdoHj48l0yakFz0k7i6zBEKWb+Y9X9Ua1XI3Ct
         lfZTmyE458JW0zi3sXCKyQ5gUBDqFpdAm7Bmnen3EpUWM8FSS2c4Sz1QD4p9EybYlHCC
         SrkRL9JA7dUA3avm9xjH/cBcq2YM4q3bVWse+dwvbXPzsAIFh0A7E1mYoCtpxBLgp1PZ
         JIIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrczzy4n5Sf7m8r0DBfec3oOPrSlVg6FR2FP7JZn05fWaq2B6QOMuVM30si4Qera5mxRLRb5F2ehPT@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzk6oQHG3ZKQ8IvjPe2Nn3P0gcqBxhf7aLfPf53mR2CKYn+0Np
	LZ+TsHrwUkKm/Lh+36WKoAC9soar5chCqRrGBLuvNTekwtqPQc03AXf2Wr8JXh7tHGY=
X-Gm-Gg: ASbGncuvtauXqqfX+D4ZqgtY+Nmp9ThKEgHwuwnR64BqznkjIziLoJbClAKIjqSHwCB
	Dw+h2v+W0KJfy8ulNJfKkHQ1KuzYkVX1v8nh46yrH9ckBZWQ8qHh8pyR+Lxi8CVChHOmBlL9yS7
	2fqF+f9pB1RlFfLSKIjgvggswDDJc4mQIHDeyE+ZXmbqvgwNZhTyzWDMGrAGINv3FwvZmgebnc7
	xH3PfdY9H3teXZBdKbxjMD3D2cdnXrrrX4SpWsa1fbn4loTDliK+MQ2SUVXFNnICYR/54VpJgzc
	n3d/FBeIt6BNYU9IcFbfucOm+YKeZliWjpsMsUMPqNCB70BRbPW4n8+jI0qvHBv3H8RBzSxW8pr
	MO0xiRtyRsM4wJu9cTpV1lTjyGuyxMsJFHBuz8jSGaqOBFzKpKaxKTN3Yuc0YB5N60d3k78I2Ud
	6MUfmdXbZ/FMtLpJQs
X-Google-Smtp-Source: AGHT+IFj2t3yKW6pPDsFDhEyOjjtQDUGWqwY1Td1Uo8FE8nnLGME1TAIOSoCs2nLoFBFrgBCNM5nDQ==
X-Received: by 2002:a05:6000:208a:b0:42b:3bd2:b2f8 with SMTP id ffacd0b85a97d-42cc1d3543dmr25867134f8f.46.1764266999388;
        Thu, 27 Nov 2025 10:09:59 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42e1c5e3857sm5371663f8f.19.2025.11.27.10.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 10:09:58 -0800 (PST)
Date: Thu, 27 Nov 2025 21:09:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Huisong Li <lihuisong@huawei.com>,
	rafael@kernel.org, lenb@kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sudeep.Holla@arm.com, linuxarm@huawei.com,
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com,
	zhenglifeng1@huawei.com, yubowen8@huawei.com, lihuisong@huawei.com
Subject: Re: [PATCH 3/3] ACPI: processor: idle: Update idle states from
 avaiable power information
Message-ID: <202511272353.nOqEau6n-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125072933.3706006-4-lihuisong@huawei.com>

Hi Huisong,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Huisong-Li/cpuidle-Add-enable_cpuidle-interface/20251125-153615
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20251125072933.3706006-4-lihuisong%40huawei.com
patch subject: [PATCH 3/3] ACPI: processor: idle: Update idle states from avaiable power information
config: i386-randconfig-141-20251126 (https://download.01.org/0day-ci/archive/20251127/202511272353.nOqEau6n-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202511272353.nOqEau6n-lkp@intel.com/

smatch warnings:
drivers/acpi/processor_idle.c:1339 acpi_processor_power_state_has_changed() error: we previously assumed '_pr' could be null (see line 1339)

vim +/_pr +1339 drivers/acpi/processor_idle.c

a36a7fecfe6071 Sudeep Holla              2016-07-21  1294  int acpi_processor_power_state_has_changed(struct acpi_processor *pr)
46bcfad7a819bd Deepthi Dharwar           2011-10-28  1295  {
46bcfad7a819bd Deepthi Dharwar           2011-10-28  1296  	int cpu;
46bcfad7a819bd Deepthi Dharwar           2011-10-28  1297  	struct acpi_processor *_pr;
3d339dcbb56d8d Daniel Lezcano            2012-09-17  1298  	struct cpuidle_device *dev;
ffff9603ddf90a Huisong Li                2025-11-25  1299  	int ret = 0;
46bcfad7a819bd Deepthi Dharwar           2011-10-28  1300  
46bcfad7a819bd Deepthi Dharwar           2011-10-28  1301  	if (disabled_by_idle_boot_param())
46bcfad7a819bd Deepthi Dharwar           2011-10-28  1302  		return 0;
46bcfad7a819bd Deepthi Dharwar           2011-10-28  1303  
46bcfad7a819bd Deepthi Dharwar           2011-10-28  1304  	if (!pr->flags.power_setup_done)
46bcfad7a819bd Deepthi Dharwar           2011-10-28  1305  		return -ENODEV;
46bcfad7a819bd Deepthi Dharwar           2011-10-28  1306  
46bcfad7a819bd Deepthi Dharwar           2011-10-28  1307  	/*
46bcfad7a819bd Deepthi Dharwar           2011-10-28  1308  	 * FIXME:  Design the ACPI notification to make it once per
46bcfad7a819bd Deepthi Dharwar           2011-10-28  1309  	 * system instead of once per-cpu.  This condition is a hack
46bcfad7a819bd Deepthi Dharwar           2011-10-28  1310  	 * to make the code that updates C-States be called once.
46bcfad7a819bd Deepthi Dharwar           2011-10-28  1311  	 */
46bcfad7a819bd Deepthi Dharwar           2011-10-28  1312  
9505626d7bfeb5 Paul E. McKenney          2012-02-28  1313  	if (pr->id == 0 && cpuidle_get_driver() == &acpi_idle_driver) {
46bcfad7a819bd Deepthi Dharwar           2011-10-28  1314  
46bcfad7a819bd Deepthi Dharwar           2011-10-28  1315  		/* Protect against cpu-hotplug */
95ac706744de78 Sebastian Andrzej Siewior 2021-08-03  1316  		cpus_read_lock();
6726655dfdd2dc Jiri Kosina               2014-09-03  1317  		cpuidle_pause_and_lock();
46bcfad7a819bd Deepthi Dharwar           2011-10-28  1318  
46bcfad7a819bd Deepthi Dharwar           2011-10-28  1319  		/* Disable all cpuidle devices */
46bcfad7a819bd Deepthi Dharwar           2011-10-28  1320  		for_each_online_cpu(cpu) {
46bcfad7a819bd Deepthi Dharwar           2011-10-28  1321  			_pr = per_cpu(processors, cpu);
46bcfad7a819bd Deepthi Dharwar           2011-10-28  1322  			if (!_pr || !_pr->flags.power_setup_done)
46bcfad7a819bd Deepthi Dharwar           2011-10-28  1323  				continue;
3d339dcbb56d8d Daniel Lezcano            2012-09-17  1324  			dev = per_cpu(acpi_cpuidle_device, cpu);
3d339dcbb56d8d Daniel Lezcano            2012-09-17  1325  			cpuidle_disable_device(dev);
46bcfad7a819bd Deepthi Dharwar           2011-10-28  1326  		}
46bcfad7a819bd Deepthi Dharwar           2011-10-28  1327  
ffff9603ddf90a Huisong Li                2025-11-25  1328  		/*
ffff9603ddf90a Huisong Li                2025-11-25  1329  		 * Update C-state information based on new power information.
ffff9603ddf90a Huisong Li                2025-11-25  1330  		 *
ffff9603ddf90a Huisong Li                2025-11-25  1331  		 * The same idle state is used for all CPUs.
ffff9603ddf90a Huisong Li                2025-11-25  1332  		 * The old idle state may not be usable anymore if fail to get
092a52b5417fd4 Huisong Li                2025-11-25  1333  		 * available ACPI power information from any online CPU.
ffff9603ddf90a Huisong Li                2025-11-25  1334  		 * The cpuidle of all CPUs should be disabled.
ffff9603ddf90a Huisong Li                2025-11-25  1335  		 */
092a52b5417fd4 Huisong Li                2025-11-25  1336  		ret = -ENODEV;
092a52b5417fd4 Huisong Li                2025-11-25  1337  		for_each_online_cpu(cpu) {
092a52b5417fd4 Huisong Li                2025-11-25  1338  			_pr = per_cpu(processors, cpu);
092a52b5417fd4 Huisong Li                2025-11-25 @1339  			if (!_pr && !_pr->flags.power_setup_done)
                                                                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
if _pr is NULL this will crash.  s/&&/||/

092a52b5417fd4 Huisong Li                2025-11-25  1340  				continue;
092a52b5417fd4 Huisong Li                2025-11-25  1341  			ret = acpi_processor_get_power_info(_pr);
092a52b5417fd4 Huisong Li                2025-11-25  1342  			if (!ret) {
092a52b5417fd4 Huisong Li                2025-11-25  1343  				acpi_processor_setup_cpuidle_states(_pr);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


