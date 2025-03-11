Return-Path: <linux-acpi+bounces-12090-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1E5A5C144
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 13:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A20169515
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 12:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD55D253F05;
	Tue, 11 Mar 2025 12:31:30 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334BF1805A;
	Tue, 11 Mar 2025 12:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696290; cv=none; b=SUEIAktwKc724KaoMj3n3i6GqXjY9zNs6xxYQKS4MIcWsBQxlLXSndVHpkUxkA/fixqv+AWQSqohXSaNFu++OoAKPqO5drIz5x/X/Av+TqGa609VgmX7Ua3Y3Oi4eBKI54DLdW6dTu50O3KPBBcSaIP3u+PieKOafBVF6X/arpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696290; c=relaxed/simple;
	bh=AvRtiOlegSSa9TyXUOXoAHLiXwfGOYuwbDDzo69MbPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Y5fxfd7LZz0oupRcmq6pF3R+HHLu0htsFanWI+auXQdXI57y/ufkaVUWUVRITgKXA17rQMLsHIIIojYCJwhHPmoMq51wJskIYDF8ctwkGuJ37bFMCOka+lNexyLjBaF5lZ8Hhl9lmEg26KU/F8wG/LuTJ60t/y//15vaE1tWXc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4ZBtRz5TYDz27gHK;
	Tue, 11 Mar 2025 20:31:59 +0800 (CST)
Received: from dggemv711-chm.china.huawei.com (unknown [10.1.198.66])
	by mail.maildlp.com (Postfix) with ESMTPS id E9A601402C4;
	Tue, 11 Mar 2025 20:31:24 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Mar 2025 20:31:24 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 11 Mar
 2025 20:31:24 +0800
Message-ID: <d2bf35ea-487d-b940-fb3e-093e14441735@huawei.com>
Date: Tue, 11 Mar 2025 20:31:23 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 07/13] mailbox: pcc: Always map the shared memory
 communication address
To: Sudeep Holla <sudeep.holla@arm.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jassi Brar
	<jassisinghbrar@gmail.com>, Adam Young <admiyo@os.amperecomputing.com>,
	Robbie King <robbiek@xsightlabs.com>
References: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
 <20250305-pcc_fixes_updates-v2-7-1b1822bc8746@arm.com>
 <0552e10d-acde-33cd-7f9c-5d7b28fee735@huawei.com> <Z9AlCkgrnlka36SJ@bogus>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <Z9AlCkgrnlka36SJ@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/3/11 19:56, Sudeep Holla 写道:
> On Tue, Mar 11, 2025 at 07:32:34PM +0800, lihuisong (C) wrote:
>> 在 2025/3/6 0:38, Sudeep Holla 写道:
>>> Currently the shared memory communication address was mapped by the
>>> mailbox client drivers leading to all sorts of inconsistencies.
>>>
>>> It also has resulted in the inconsistent attributes used while mapping
>>> the shared memory regions.
>>>
>>> In order to remove/eliminate any issues, let us ensures the shared
>>> memory address is always mapped and unmapped when the PCC channels are
>>> requested and release.
>>>
>>> We need to map them as the ACPI PCCT associates these shared memory
>>> with each channel subspace and may need use the status or the flags in
>>> the headers of those shared memory communication address regions to
>>> manage the transport/channel.
>>>
>>> Since there are no users of pcc_chan_ioremap() and also it is mapped
>>> by default, we can stop exporting it and merge the functionality into
>>> pcc_mbox_request_channel().
>> There are two ioremap for the existing mbox client driver after this patch.
>> The existing mbox client driver would not use this variable, and no one else
>> uses it. So it is safe, right?
> IIUC yes, it should be fine.
>
>> Do we need to make a statement that the two iommaps have no impact on the
>> existing mbox client drivers?
> We can add one, but again it will be become obsolete once we change driver
> to use this new mapping. That's why I didn't add it. We can merge all the
> changes together if that is the concern. I am fine either way.
>
I also tested the case with this patch and no modification of driver.
I didn't find any other issue.
IMO, we should make a statement for this anyway.

/Huisong
>

