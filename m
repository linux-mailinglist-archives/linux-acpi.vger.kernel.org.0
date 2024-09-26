Return-Path: <linux-acpi+bounces-8420-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E46A7986B1C
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 04:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219191C2165C
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 02:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1892F175D57;
	Thu, 26 Sep 2024 02:59:26 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6DB4C91;
	Thu, 26 Sep 2024 02:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727319566; cv=none; b=JTS0+Kjlp3jTiU+/mB8gs7wJZqXpuiKXbqfROmHgYEOHNlRP8umRwPttxdb1VK5dE3d0sLTn3JdN2KZJw4T6P+F6FhHizKjqvBWinciuDurl0vodtEsrg5CyO4Z6r8yQafN6lR1Dql2x7qP7wN45YY++lCOklRDmK7Kh3+6m+Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727319566; c=relaxed/simple;
	bh=nZKdrlUOwQUzYtSTN5B3RovX/4TbWEZWAYG6U8lPE4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MK6PQ8enGVJV/EHF2UXz4gK3p3o8KdwmCvvZ1G0PPi8AQBz39oYsLOrKahNgeJCuDr3RobAMxEq4yQrBFzLmwParTqOtYHmZd8eIER29KvrsU9CeqnAMeHmGcsoC83EA4trfK8gUeqRVQfVkP3WCI5yPTCDi7hHbiM6ZqYTlLb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XDdbQ012zzFqsn;
	Thu, 26 Sep 2024 10:58:57 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (unknown [7.185.36.137])
	by mail.maildlp.com (Postfix) with ESMTPS id 424541800CF;
	Thu, 26 Sep 2024 10:59:20 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 26 Sep
 2024 10:59:19 +0800
Message-ID: <0797a6ca-4377-6da9-76f5-40c8343324bf@hisilicon.com>
Date: Thu, 26 Sep 2024 10:59:19 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v3 2/2] cppc_cpufreq: Remove HiSilicon CPPC workaround
To: Xiongfeng Wang <wangxiongfeng2@huawei.com>, <ionela.voinescu@arm.com>,
	<beata.michalska@arm.com>, <viresh.kumar@linaro.org>, <rafael@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <wanghuiqiang@huawei.com>,
	<zhenglifeng1@huawei.com>, <lihuisong@huawei.com>, <yangyicong@huawei.com>,
	<liaochang1@huawei.com>, <zengheng4@huawei.com>
References: <20240919084552.3591400-1-zhanjie9@hisilicon.com>
 <20240919084552.3591400-3-zhanjie9@hisilicon.com>
 <6305475a-3fbd-780d-e341-716fecf4b769@huawei.com>
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <6305475a-3fbd-780d-e341-716fecf4b769@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500019.china.huawei.com (7.185.36.137)



On 25/09/2024 14:30, Xiongfeng Wang wrote:
> Reviewed-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> 

Thanks, will pick it up.

