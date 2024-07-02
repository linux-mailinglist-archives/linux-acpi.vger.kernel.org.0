Return-Path: <linux-acpi+bounces-6724-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF7691ED79
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 05:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6801F227F8
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 03:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211F01758E;
	Tue,  2 Jul 2024 03:34:58 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4CE33999;
	Tue,  2 Jul 2024 03:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719891298; cv=none; b=hJDJF537KlUSAs3EtDRL3nAR4y1zpY40MXIu06fKeUmJJ+BCh56AO+v4y2c3gvy5r9mVW/v/vNKEYdpL9DfaivQLuOlN5/gGeaoQNo9yhwLee8GyIrtXNd6tt0huzhZ3XaSwAeIOFTuOFQPfz4MPNkA8XnCPm2V7ERJnwDWPQJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719891298; c=relaxed/simple;
	bh=c5AkcvKWxB+VaeblOPWvKnHaTfV+bapdvdk6en6EoaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=faZgDt6HPLJrF/0wQQYqUfzucubf1IOLErXcusA06/B5c/qeoRhdFauDbhL48rCh94xXcQhHTsxs2qN0ttUkW/HYxmI/pkIyvxslTlhl5zlyPCdHdUwgCdcWrn/FUeLQSKaX9oTplkfTKpS35/k1tN1y76YjF6/KEx3phWXsJVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WCpQg2KbJz1xtBh;
	Tue,  2 Jul 2024 11:33:15 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (unknown [7.185.36.111])
	by mail.maildlp.com (Postfix) with ESMTPS id 667B41402D0;
	Tue,  2 Jul 2024 11:34:47 +0800 (CST)
Received: from [10.174.178.96] (10.174.178.96) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 11:34:46 +0800
Message-ID: <abde16ee-9a95-4bfe-930f-f4714c751c18@huawei.com>
Date: Tue, 2 Jul 2024 11:34:46 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq/cppc: fix perf_to_khz/khz_to_perf conversion
 exception
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <Pierre.Gondois@arm.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liwei391@huawei.com>
References: <20240506075816.1325303-1-liwei728@huawei.com>
 <20240520072513.vtlqwjbmxugvuppj@vireshk-i7>
From: "liwei (JK)" <liwei728@huawei.com>
In-Reply-To: <20240520072513.vtlqwjbmxugvuppj@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500018.china.huawei.com (7.185.36.111)

kindly ping

在 2024/5/20 15:25, Viresh Kumar 写道:
> On 06-05-24, 15:58, liwei wrote:
>> When the nominal_freq recorded by the kernel is equal to the lowest_freq,
>> and the frequency adjustment operation is triggered externally, there is
>> a logic error in cppc_perf_to_khz()/cppc_khz_to_perf(), resulting in perf
>> and khz conversion errors.
>>
>> Fix this by adding the branch processing logic when nominal_freq is equal
>> to lowest_freq.
>>
>> Fixes: ec1c7ad47664 ("cpufreq: CPPC: Fix performance/frequency conversion")
>> Signed-off-by: liwei <liwei728@huawei.com>
>> ---
>> v2:
>>      - Fix similar issue in cppc_khz_to_perf()
>>
>>   drivers/acpi/cppc_acpi.c | 22 +++++++++++++++++-----
>>   1 file changed, 17 insertions(+), 5 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

