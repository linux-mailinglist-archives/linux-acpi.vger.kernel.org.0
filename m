Return-Path: <linux-acpi+bounces-12077-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4F7A5BF0E
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 12:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94CF5175DBE
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 11:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F3B22B59D;
	Tue, 11 Mar 2025 11:32:42 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03625227E8F;
	Tue, 11 Mar 2025 11:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741692762; cv=none; b=icfZxq5yv/ROM9M4ShE9BGVjVH1CYDeuw1TfcnEyoZsaPxF3GngvfwkkLtuOdGvJJj8Z5lBRzafD00KfRw27uXbnIRJIcNSDKs+ChofZWIANSSBGdEeRb/D1VeiWv9aIO4HUctELQeSxMrfPyaBZQ8YJ0VUx5UytyHFT6UXuJ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741692762; c=relaxed/simple;
	bh=buuc6ecEs8yssWAHtrxKJlX8ai8izcXi/ld/leYgkTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZhNu3tCiAAuedutyL7cMwU4/i4QAsWCdih2jNh6RRJ4+ThtM5CQ+V3JqfTr+gESYIu8h3T5hVVBqqF4bJv8Upce0R0sh0SMKrUaCXMDD60HyLA1wnQLJlqUcAOQ1Ed2C5oCCzJ4ASraodzInoK2DBNaIccgPTjiBJW/cSjvDLmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZBs3M4Hl3zCs7B;
	Tue, 11 Mar 2025 19:29:03 +0800 (CST)
Received: from dggemv704-chm.china.huawei.com (unknown [10.3.19.47])
	by mail.maildlp.com (Postfix) with ESMTPS id 01FC81403D1;
	Tue, 11 Mar 2025 19:32:36 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Mar 2025 19:32:35 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 11 Mar
 2025 19:32:35 +0800
Message-ID: <0552e10d-acde-33cd-7f9c-5d7b28fee735@huawei.com>
Date: Tue, 11 Mar 2025 19:32:34 +0800
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
To: Sudeep Holla <sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Jassi Brar <jassisinghbrar@gmail.com>, Adam Young
	<admiyo@os.amperecomputing.com>, Robbie King <robbiek@xsightlabs.com>
References: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
 <20250305-pcc_fixes_updates-v2-7-1b1822bc8746@arm.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20250305-pcc_fixes_updates-v2-7-1b1822bc8746@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/3/6 0:38, Sudeep Holla 写道:
> Currently the shared memory communication address was mapped by the
> mailbox client drivers leading to all sorts of inconsistencies.
>
> It also has resulted in the inconsistent attributes used while mapping
> the shared memory regions.
>
> In order to remove/eliminate any issues, let us ensures the shared
> memory address is always mapped and unmapped when the PCC channels are
> requested and release.
>
> We need to map them as the ACPI PCCT associates these shared memory
> with each channel subspace and may need use the status or the flags in
> the headers of those shared memory communication address regions to
> manage the transport/channel.
>
> Since there are no users of pcc_chan_ioremap() and also it is mapped
> by default, we can stop exporting it and merge the functionality into
> pcc_mbox_request_channel().
There are two ioremap for the existing mbox client driver after this patch.
The existing mbox client driver would not use this variable, and no one 
else uses it. So it is safe, right?
Do we need to make a statement that the two iommaps have no impact on 
the existing mbox client drivers?
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
Acked-by: Huisong Li <lihuisong@huawei.com>
Tested-by: Huisong Li <lihuisong@huawei.com>
>

