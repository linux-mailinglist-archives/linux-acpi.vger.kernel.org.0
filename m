Return-Path: <linux-acpi+bounces-11696-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04611A4B7CA
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 07:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC8B3A2496
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 06:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27141DE2DE;
	Mon,  3 Mar 2025 06:07:12 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427E21D516A;
	Mon,  3 Mar 2025 06:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740982032; cv=none; b=cQskA+AFSDqy4uYe6lmMxJrYUY5XPL04xb0jNM6Xzh82b2LYhE1aNSqE8KVgUNyxJL8K4XrveAlwe2rc4B+IjRAxsld4IkvMqv0HjoRtex0/bsG/lLV8WHFihr6jlTcPetezBwlEtK0HgQF3YyV60iuSqMR3YZp279xyM27jSuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740982032; c=relaxed/simple;
	bh=YKdWFnuz2nveCfHhNMPHE3QSFWRjZwDk6X98TyyAIYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O26qakecJpCkHNrZDCysA9j4ogNjKbiV80b/TIXzdX9WmQiyXDJVJR+L3v92KXoeVeARZhzh9Fz33S2uP4C303aOE6AP8ffxCLkw2A4Z+vNF/Dh3Av0WLP+lnkwqZh8c8mtU9X7h4hBzsZCt2V5/7SankrBAqQ7uGxqZdz7eFak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Z5pBn5cL6z1ltZg;
	Mon,  3 Mar 2025 14:02:57 +0800 (CST)
Received: from dggemv704-chm.china.huawei.com (unknown [10.3.19.47])
	by mail.maildlp.com (Postfix) with ESMTPS id 73E0F1402E0;
	Mon,  3 Mar 2025 14:07:07 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Mar 2025 14:07:07 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 3 Mar
 2025 14:07:06 +0800
Message-ID: <ab9f011f-970a-73b1-37cb-158654d0e1db@huawei.com>
Date: Mon, 3 Mar 2025 14:07:05 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] mailbox: pcc: Fix can't clear level interrupt of type3 in
 cornor case
To: Sudeep Holla <sudeep.holla@arm.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jassisinghbrar@gmail.com>, <liuyonglong@huawei.com>
References: <20250227072341.28693-1-lihuisong@huawei.com>
 <Z8HlHDAUWqQOjrCH@bogus> <05e7a220-7886-77ad-af58-7847c679579a@huawei.com>
 <20250302144744.h6ybi4sstxduesvh@bogus>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20250302144744.h6ybi4sstxduesvh@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/3/2 22:47, Sudeep Holla 写道:
> On Sun, Mar 02, 2025 at 03:30:01PM +0800, lihuisong (C) wrote:
>> 在 2025/3/1 0:32, Sudeep Holla 写道:
> [...]
>
>>> This may be correct way of fixing the issue here, but I am questioning the
>>> existence of this flag now. I have some rework on this file. I will pick
>> This flag is for shared interrupt case on type3. please see:
>> 3db174e478cb ("mailbox: pcc: Support shared interrupt for multiple
>> subspaces")
>>
> Yes, I looked at all the history of this patch and I saw I had suggested
> it. So it took a while to recall why it is a must. I was reworking some
> of the recent change added which I couldn't review and got merged. I was
I konw and understand.
> convinced for a short period this flag is not needed but I was wrong.
>
> I will repost the patch with minor updated to the commit message as part
> of my series soon to avoid any conflicts.
>
ok, looking forward to your series.
> .

