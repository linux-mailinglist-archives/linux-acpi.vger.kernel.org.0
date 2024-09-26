Return-Path: <linux-acpi+bounces-8421-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 745EF986B1D
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 05:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FFC41F22CF4
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 03:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458A113C3D3;
	Thu, 26 Sep 2024 03:00:04 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C161B960;
	Thu, 26 Sep 2024 03:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727319604; cv=none; b=gSlmRifPxJEl7oqRe/XZB4RUqtyC6quD0qzmMh4MTTHerUvxSMzZDN9uef/c5ttSwpTV0nb3JbnLDP83hxx2l0xHRPg/v4yFBw7ta3ShTz28xc3pubjulyF33cHrQX0Jtd8OPfwd14bBnW7Ba/VU5q+Z6bKQ+TxqoPbfEcrnLRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727319604; c=relaxed/simple;
	bh=GhISuCKRlFKxOEjaVsoixEdLZGTTfuejqM68zZIUYHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fh2UwjYwvgf/t81UhozfS0QUFlU9U6bryAH/o3cedbAv3NYCRZDu1mSp2q5I2t5r9zBJ3UFI/EP4kGGIPnASpSfuKoM0o5Rp9KHe4+CGsKtdnn1f6ravkoaPmszNp2U6l2GU+kdumksrfpCIlJ05j9M4YqpYTTD1QW18pDz6T8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XDdZr6Zv9z1T819;
	Thu, 26 Sep 2024 10:58:28 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (unknown [7.185.36.137])
	by mail.maildlp.com (Postfix) with ESMTPS id C674F14037E;
	Thu, 26 Sep 2024 10:59:54 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 26 Sep
 2024 10:59:54 +0800
Message-ID: <6cda3a5a-7d9c-aa37-882c-38c192dc27db@hisilicon.com>
Date: Thu, 26 Sep 2024 10:59:54 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v3 2/2] cppc_cpufreq: Remove HiSilicon CPPC workaround
To: "lihuisong (C)" <lihuisong@huawei.com>, <ionela.voinescu@arm.com>,
	<beata.michalska@arm.com>, <wangxiongfeng2@huawei.com>,
	<viresh.kumar@linaro.org>, <rafael@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <wanghuiqiang@huawei.com>,
	<zhenglifeng1@huawei.com>, <yangyicong@huawei.com>, <liaochang1@huawei.com>,
	<zengheng4@huawei.com>
References: <20240919084552.3591400-1-zhanjie9@hisilicon.com>
 <20240919084552.3591400-3-zhanjie9@hisilicon.com>
 <82f4fa82-ee37-5328-4792-3143a2f0ac6f@huawei.com>
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <82f4fa82-ee37-5328-4792-3143a2f0ac6f@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500019.china.huawei.com (7.185.36.137)



On 25/09/2024 17:36, lihuisong (C) wrote:
> LGTM,
> 
> Reviewed-by: Huisong Li <lihuisong@huawei.com>

Thanks, will pick it up.

