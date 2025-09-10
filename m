Return-Path: <linux-acpi+bounces-16573-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B141B51611
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 13:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE841C842AC
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 11:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E605128750C;
	Wed, 10 Sep 2025 11:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O9gURqIr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B4D284B4C
	for <linux-acpi@vger.kernel.org>; Wed, 10 Sep 2025 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757504871; cv=none; b=GhRPCnRSxCxUqe9siutii2ogdOw5v5JzSS4pT/wsbVM+s2UdFCELXf6BcWKEtUplkNTXPMZxV5k1T7eBnorHzvmkg4phoVgJ4bfe6ON5sN2vgseoC2phVUrRmZavwDUjb+m+mS1xSbYju/SDZHxSVxJmwvCNXJKEuvqVNGrcOVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757504871; c=relaxed/simple;
	bh=WbEtV0CPIKyH7FQXM3VCsQudJJTxDRA8dDx1E0cAO8k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=A4wO86h/wkBiLDkKpALLNaWqAj8GHL9LzMY0B44PJUMwE6ENrCK4EyFglMAKvrH+7KQwndixF58eT5T5S+J5eiTEq1Oj5UaoDuPQ/OSe2KSkJoVgLL8R1ngPw3pV5/nabR7RuBDiuq9b8O8XqcOD1t6YHUU7t5NS46CnQi2VuLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O9gURqIr; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3e537dc30c7so5108828f8f.3
        for <linux-acpi@vger.kernel.org>; Wed, 10 Sep 2025 04:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757504867; x=1758109667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wg2Ph+PhoATIteAbw+PWkWD/06VwBl1ynTVTQY5RYgk=;
        b=O9gURqIr9IXa2PiraV3ZG7m/kA7qet5iK0WosCDX5sreMI53xvu9CX5pcAKsHD6lss
         IhfW0/1izzHtY72t1Bakxg5sr0satsgbo2Zx1JJALWxvbRuUcj3niVR954LQZxrioBAI
         K5AD3d8tH0DNixG6vQ1LT8hUmCtMONWUtbbEQF9j4bitVo3mo/hEJIQlubqB4Jbm0umu
         onyV8Buze+gqHxcl4qABdDLoa5zsxboHn8O74UUk7G7FpELaIYDoNlcG2tUzfe7145fB
         6seaVpf0EUW6i5c523mYuFUwUQb46rKiCARkFu/uSZyn5zXU09/93xiq4MD43ART4Luk
         hTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757504867; x=1758109667;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wg2Ph+PhoATIteAbw+PWkWD/06VwBl1ynTVTQY5RYgk=;
        b=pAL4tKQlrg/1Ug9hJzc0htRm05FdpUjxP5109Z0Qu6eDZNoag3AdFwSA/+MI/dp5xA
         9LyCMaVpSVYMYlmLs0HP1k+lX/QNmxuNBuGTij2BhVc8GaHhH7uSkv+J+QMaTqri7QTl
         qJJoPP6bEPYApPbQ4JDdkj0O/VOUezthva+fb2qnYv9Z0T+K3yJolEGOoiU7YjLiG9ea
         8MF5c2dn3tr63XUFc9APBC12KSZIsO+iIORPVEcxirtG67jk1HXH65GesZ3Eu2+uytRK
         GwS71jGYTTn7Adpe3QwUiKT7hyH4Usz8/Zwu0vEwT8Q5PuBJJVfhNAimj+y4Py7ckEYw
         n5fA==
X-Forwarded-Encrypted: i=1; AJvYcCWo2ClVcQMQGF68/ueprvnYDMrvk4YAfsOhQmKgdraDUMlCL8Goeg5kL1pRRcYnh2BUFQuogbWO1Xbp@vger.kernel.org
X-Gm-Message-State: AOJu0YzvD3QflJnlTsjxGdBRzn7ycuTKHqY1Y5fTdwiQ9f4PX0W2Dlyb
	9WnsoQ4p15kCLXfemBVM13JAQnaH3EM/HFh1zZ6iXancL9STbOkdoXbYkVXNwVSMa/U=
X-Gm-Gg: ASbGnct405TQMnb2dSBqTsvzaPY8dKtNf2g82r8e2StSPjVwH7z1wqJ+yhMniwcjP9O
	JfSfHgMP6tfEbyv013w6BBw5cPzs/wqP+tv7CLyKTtgF7CfY/nemICInQQtfUsrSl/K0veLfuos
	3pPHAFr0BjSyusGwtaHEE7ByFh5HpjOO9cqFPZfzaDmJFD2V7Sni8K1CJzLVTM3q7X7QVldg1XU
	J4NKTrpTRk2VFhSgnxYkhcbSug2jvxyG+ARv9GAvGbfbFOToLvMfxi5zdAd/IWj8Y7RQ4/QYnTA
	7hHqcIAUtDwTJLqIfZwGezZ7Upbe4VKDVfQQ338np/IzMkVCCParbB5nLaGOxT6bzQWk4JMvGZI
	ZP1ZUsvLFV3yVO/lMUK9MY0rENBc=
X-Google-Smtp-Source: AGHT+IHpMaxaSaJ4cnLK/bK8wa1YrfXhxVJLuuDTkuh1vmaIEZ84Pcyd9YYbH8IfZoLQCxj9xtJuUA==
X-Received: by 2002:adf:b350:0:b0:3e7:41ac:45f8 with SMTP id ffacd0b85a97d-3e741ac4939mr7821201f8f.55.1757504867368;
        Wed, 10 Sep 2025 04:47:47 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3e7521bfe00sm6893713f8f.5.2025.09.10.04.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 04:47:46 -0700 (PDT)
Date: Wed, 10 Sep 2025 14:47:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, GuangFei Luo <luogf2025@163.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	luogf2025@163.com
Subject: Re: [PATCH] ACPI: battery: prevent sysfs_add_battery re-entry on
 rapid events
Message-ID: <202509101620.yI0HZ5gT-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250907035154.223983-1-luogf2025@163.com>

Hi GuangFei,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/GuangFei-Luo/ACPI-battery-prevent-sysfs_add_battery-re-entry-on-rapid-events/20250907-115505
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20250907035154.223983-1-luogf2025%40163.com
patch subject: [PATCH] ACPI: battery: prevent sysfs_add_battery re-entry on rapid events
config: x86_64-randconfig-161-20250909 (https://download.01.org/0day-ci/archive/20250910/202509101620.yI0HZ5gT-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202509101620.yI0HZ5gT-lkp@intel.com/

smatch warnings:
drivers/acpi/battery.c:1046 acpi_battery_update() warn: inconsistent returns '&battery->sysfs_lock'.

vim +1046 drivers/acpi/battery.c

9e50bc14a7f58b5 Lan Tianyu              2014-05-04  1001  static int acpi_battery_update(struct acpi_battery *battery, bool resume)
508df92d1f8d192 Andrey Borzenkov        2007-10-28  1002  {
82f2d30570b7ecd Lucas Rangit Magasweran 2018-07-14  1003  	int result = acpi_battery_get_status(battery);
82f2d30570b7ecd Lucas Rangit Magasweran 2018-07-14  1004  
508df92d1f8d192 Andrey Borzenkov        2007-10-28  1005  	if (result)
508df92d1f8d192 Andrey Borzenkov        2007-10-28  1006  		return result;
82f2d30570b7ecd Lucas Rangit Magasweran 2018-07-14  1007  
508df92d1f8d192 Andrey Borzenkov        2007-10-28  1008  	if (!acpi_battery_present(battery)) {
508df92d1f8d192 Andrey Borzenkov        2007-10-28  1009  		sysfs_remove_battery(battery);
97749cd9adbb298 Alexey Starikovskiy     2008-01-01  1010  		battery->update_time = 0;
508df92d1f8d192 Andrey Borzenkov        2007-10-28  1011  		return 0;
508df92d1f8d192 Andrey Borzenkov        2007-10-28  1012  	}
9e50bc14a7f58b5 Lan Tianyu              2014-05-04  1013  
9e50bc14a7f58b5 Lan Tianyu              2014-05-04  1014  	if (resume)
9e50bc14a7f58b5 Lan Tianyu              2014-05-04  1015  		return 0;
9e50bc14a7f58b5 Lan Tianyu              2014-05-04  1016  
82f2d30570b7ecd Lucas Rangit Magasweran 2018-07-14  1017  	if (!battery->update_time) {
97749cd9adbb298 Alexey Starikovskiy     2008-01-01  1018  		result = acpi_battery_get_info(battery);
97749cd9adbb298 Alexey Starikovskiy     2008-01-01  1019  		if (result)
97749cd9adbb298 Alexey Starikovskiy     2008-01-01  1020  			return result;
97749cd9adbb298 Alexey Starikovskiy     2008-01-01  1021  		acpi_battery_init_alarm(battery);
97749cd9adbb298 Alexey Starikovskiy     2008-01-01  1022  	}
12c78ca2ab5e64b Carlos Garnacho         2016-08-10  1023  
12c78ca2ab5e64b Carlos Garnacho         2016-08-10  1024  	result = acpi_battery_get_state(battery);
12c78ca2ab5e64b Carlos Garnacho         2016-08-10  1025  	if (result)
12c78ca2ab5e64b Carlos Garnacho         2016-08-10  1026  		return result;
12c78ca2ab5e64b Carlos Garnacho         2016-08-10  1027  	acpi_battery_quirks(battery);
12c78ca2ab5e64b Carlos Garnacho         2016-08-10  1028  
ce5e61beaad5c5a GuangFei Luo            2025-09-07  1029  	mutex_lock(&battery->sysfs_lock);
297d716f6260cc9 Krzysztof Kozlowski     2015-03-12  1030  	if (!battery->bat) {
eb03cb02b74df6d Stefan Hajnoczi         2011-07-12  1031  		result = sysfs_add_battery(battery);
eb03cb02b74df6d Stefan Hajnoczi         2011-07-12  1032  		if (result)
eb03cb02b74df6d Stefan Hajnoczi         2011-07-12  1033  			return result;

mutex_unlock(&battery->sysfs_lock) before returning.

eb03cb02b74df6d Stefan Hajnoczi         2011-07-12  1034  	}
ce5e61beaad5c5a GuangFei Luo            2025-09-07  1035  	mutex_unlock(&battery->sysfs_lock);
e0d1f09e311fafa Zhang Rui               2014-05-28  1036  
e0d1f09e311fafa Zhang Rui               2014-05-28  1037  	/*
e0d1f09e311fafa Zhang Rui               2014-05-28  1038  	 * Wakeup the system if battery is critical low
e0d1f09e311fafa Zhang Rui               2014-05-28  1039  	 * or lower than the alarm level
e0d1f09e311fafa Zhang Rui               2014-05-28  1040  	 */
e0d1f09e311fafa Zhang Rui               2014-05-28  1041  	if ((battery->state & ACPI_BATTERY_STATE_CRITICAL) ||
e0d1f09e311fafa Zhang Rui               2014-05-28  1042  	    (test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags) &&
e0d1f09e311fafa Zhang Rui               2014-05-28  1043  	     (battery->capacity_now <= battery->alarm)))
33e4f80ee69b516 Rafael J. Wysocki       2017-06-12  1044  		acpi_pm_wakeup_event(&battery->device->dev);
e0d1f09e311fafa Zhang Rui               2014-05-28  1045  
557d58687dcdee6 Zhang Rui               2010-10-22 @1046  	return result;
4bd35cdb1e2d1a1 Vladimir Lebedev        2007-02-10  1047  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


