Return-Path: <linux-acpi+bounces-8862-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C089A4BDA
	for <lists+linux-acpi@lfdr.de>; Sat, 19 Oct 2024 09:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088991F230A0
	for <lists+linux-acpi@lfdr.de>; Sat, 19 Oct 2024 07:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A03D1D356C;
	Sat, 19 Oct 2024 07:35:21 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD781CC890;
	Sat, 19 Oct 2024 07:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729323321; cv=none; b=AvQOq3dDLyZ+qz32YMkipY/EdQHMEUt05pnecQaGOUbiXFz3Pyc7JmXGrxZoBMCAI5yqNawkUfwb4guMRJBrdMiJOuOZ6S9QVSNav4trppwPvKiR2dsSPEI89GaGugOgE38r3BC7MayvIowd/Kg3sMtlBAfa2gJIEBUsAjobPxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729323321; c=relaxed/simple;
	bh=l42ub1ifaXNW+eMZdGn+KTBSPRYAIUn7ijrbKKYoq0o=;
	h=Subject:From:To:CC:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fiY13+ygFtrMkzapyeAKH7MtOfWl46hKMMlVHEmDoFs7jg/BunPd9zZhPbigvnNlOX2uvWfncH0JQb5vAhGmB3FOHzg1jPyilBtMDJpJVWDYcbFSObQzcFiG/u0poPYHR24jxMDAMXq8bbH+TSbg/f1fwJ+vGJHt/mzkRV8YXwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XVtbv691vzySKF;
	Sat, 19 Oct 2024 15:33:47 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id DED6F18009B;
	Sat, 19 Oct 2024 15:35:14 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 19 Oct 2024 15:35:14 +0800
Subject: Re: [PATCH v4] ACPI: GTDT: Tighten the check for the array of
 platform timer structures
From: Hanjun Guo <guohanjun@huawei.com>
To: Zheng Zengkai <zhengzengkai@huawei.com>, <lpieralisi@kernel.org>,
	<sudeep.holla@arm.com>, <mark.rutland@arm.com>, <maz@kernel.org>,
	<rafael@kernel.org>, <lenb@kernel.org>
CC: <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20241016095458.34126-1-zhengzengkai@huawei.com>
 <c1b7159e-3bd1-ff2d-da94-fcf5a48220d2@huawei.com>
Message-ID: <48e969ca-d43f-6d48-1b7e-7377086f8881@huawei.com>
Date: Sat, 19 Oct 2024 15:35:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c1b7159e-3bd1-ff2d-da94-fcf5a48220d2@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2024/10/19 14:41, Hanjun Guo wrote:
> On 2024/10/16 17:54, Zheng Zengkai wrote:
>> As suggested by Marc and Lorenzo, first we need to check whether the
>> platform_timer entry pointer is within gtdt bounds (< gtdt_end) before
>> de-referencing what it points at to detect the length of the platform
>> timer struct and then check that the length of current platform_timer
>> struct is also valid, i.e. the length is not zero and within gtdt_end.
>> Now next_platform_timer() only checks against gtdt_end for the entry of
>> subsequent platform timer without checking the length of it and will
>> not report error if the check failed and the existing check in function
>> acpi_gtdt_init() is also not enough.
>>
>> Modify the for_each_platform_timer() iterator and use it combined with
>> a dedicated check function platform_timer_valid() to do the check
>> against table length (gtdt_end) for each element of platform timer
>> array in function acpi_gtdt_init(), making sure that both their entry
>> and length actually fit in the table.
>>
>> Suggested-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
>> Co-developed-by: Marc Zyngier <maz@kernel.org>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
> 
> Nit: since there is a "Co-developed-by:" for Marc, the
> "Signed-off-by:" can be removed.

Forget about this comment, the guide from submit patches needs
the Signed-off-by:, sorry for the noise.

Thanks
Hanjun

