Return-Path: <linux-acpi+bounces-18999-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5072CC68011
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 08:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D0565380289
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 07:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15D42FDC3B;
	Tue, 18 Nov 2025 07:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="5hcM+WWE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536922FD1B2;
	Tue, 18 Nov 2025 07:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763450966; cv=none; b=gWRr4pQutcgvCLT8hGkJTLlasucypsP6qcbEnyv9UZl580TY8PBihFM4aLh2XnqVlFZPrIN/n5vF76T+fe3QowD6y08GmLAWWAVMhaHhH5rqBsw7STbbTGFSFE7wGcITkRiuAvEr6SL78xxw/GrPKkTUo9XLhDxAQERo2JXlOxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763450966; c=relaxed/simple;
	bh=8iNgO2epxixxspcFE91xNqLbYL8u7m7fonmcSEy9F9E=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=AE3RksAfqtZmDY66NFjH4dchuDjkSN/G7MyHdam2ycDzFeiCbanXfS9dkfFUi6/SwgEvHqcqVyTkhwXtLVi+gsXC8HDMI0DD10Rpad6gY+Fk0pyQTn/9YW+Xb2kTBBFjdZGUCdR92h//iyHSAv5ycIfgiRB4IkBdzFrwHQLYqMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=5hcM+WWE; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=5gIGnGRcLf8t2W8efWudyJsLJCWbakw7lPbWiXe7B4s=;
	b=5hcM+WWE3m/Diy8jP98F4LRZXomcwK6Rwve/19aNLAwOJtPnBiwf7JqAEragFLju796XVGh5U
	J5GbyxNPT8QN2DT6zjRY5oMBa/zUZ+eHVVRvzVxzQyIESlMUGGwix955YEmtcivjkvdSHm48BSl
	FDxm5v4gPZiYn5vM+wDHp/w=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4d9bmW0wRpz1K96c;
	Tue, 18 Nov 2025 15:27:39 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 92B7C1A0188;
	Tue, 18 Nov 2025 15:29:20 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Nov 2025 15:29:19 +0800
Subject: Re: [PATCH v4] ACPI: AGDI: Add interrupt signaling mode support
To: Will Deacon <will@kernel.org>, Kazuhiro Abe <fj1078ii@aa.jp.fujitsu.com>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>, Sudeep Holla
	<sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Ilkka
 Koskinen <ilkka@os.amperecomputing.com>, Catalin Marinas
	<catalin.marinas@arm.com>
References: <20251017073935.1746365-1-fj1078ii@aa.jp.fujitsu.com>
 <a93e845a-b084-a680-7158-68363c492b75@huawei.com>
 <aQokdBkjFqw9ZGRt@willie-the-truck>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <6b14156b-9734-f0e0-5954-57cc76576a37@huawei.com>
Date: Tue, 18 Nov 2025 15:29:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aQokdBkjFqw9ZGRt@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/11/5 0:06, Will Deacon wrote:
> On Mon, Oct 20, 2025 at 09:23:05PM +0800, Hanjun Guo wrote:
>> On 2025/10/17 15:39, Kazuhiro Abe wrote:
>>> AGDI has two types of signaling modes: SDEI and interrupt.
>>> Currently, the AGDI driver only supports SDEI.
>>> Therefore, add support for interrupt signaling mode
>>> The interrupt vector is retrieved from the AGDI table, and call panic
>>> function when an interrupt occurs.
>>>
>>> Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>>> Signed-off-by: Kazuhiro Abe <fj1078ii@aa.jp.fujitsu.com>
>>> ---
>>> Hanjun, I have addressed all your comments.
>>> Please review them.
>>>
>>> v3->v4
>>>    - Add a comment to the flags member.
>>>    - Fix agdi_interrupt_probe.
>>>    - Fix agdi_interrupt_remove.
>>>    - Add space in struct initializsation.
>>>    - Delete curly braces.
>>
>> Looks good to me,
>>
>> Acked-by: Hanjun Guo <guohanjun@huawei.com>
> 
> I wasn't cc'd on the original patch but I couldn't figure out why it
> uses IRQF_NO_AUTOEN when requesting the irq given that the first thing
> it does is enable it.

Sorry for the late reply, seems this comment was addressed.

But when I go back to read the latest AGDI spec [0], I see
the signaling mode can be SDEI *and* interrupt:

Flags node structures 1 36 Bits [1:0]: Signaling mode:

2: Both SDEI and Interrupt-based signaling is
supported. While an SDEI event handler is
registered, the platform is allowed to not
generate the wired interrupt

So which means we need to support both SDEI and interrupt when the
signaling mode is 2, but for now, the code is

+	if (agdi_table->flags & ACPI_AGDI_SIGNALING_MODE)
+		pdata.gsiv = agdi_table->gsiv;
+	else
+		pdata.sdei_event = agdi_table->sdei_event;

Kazuhiro, could you take a look again?

Thanks
Hanjun

[0]: https://developer.arm.com/documentation/den0093/latest/

