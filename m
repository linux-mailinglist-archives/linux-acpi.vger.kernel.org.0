Return-Path: <linux-acpi+bounces-19544-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25151CB46F7
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Dec 2025 02:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1DF23025A77
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Dec 2025 01:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F4322E3E7;
	Thu, 11 Dec 2025 01:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="i9e+v1JQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B926B22D792;
	Thu, 11 Dec 2025 01:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765416932; cv=none; b=PAGiSDkP86Tzi82pVD3Wnsw4mxFWYiZInCSL+8kQU4u0aPSbzJUwTOoP8zyAbCnU6UUm9QsbKbm4IEI9S8ZRZ1wPGi6pQOQZQUpa13v/FoLDCEL5g9ID+e4fhsKNdJWdVnfnoJyrkP+9GcPkGc6jKWWXP87R2T1Jx5d2uTyPEMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765416932; c=relaxed/simple;
	bh=iDzJjmi7VSCWNO6XJmZ1MjuDB/M8HCe6BHsMSCtleQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qt/JMYYlzot/RCw1O/kGesB29zenTpodC3nJhhQM0MJGhGBnrdFeg7/VWFw5kfwLsD4JEmD/BWlwP6BySOs0mUSnaW2nS4oB8T1Vb6BDZooyWHb4KCyHLtFUTIU8u5GUpyOu9Orrf0DFKmagm8WStr6HSzGg0AzY1Z4OzLeE5Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=i9e+v1JQ; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=iDzJjmi7VSCWNO6XJmZ1MjuDB/M8HCe6BHsMSCtleQM=;
	b=i9e+v1JQYWSsZ7om5TtbARi7AgfilW/53sGPedrqOu3rjPrnC28iZn2qtlOIyyztYowfIKzGY
	i4KAVbKFi7WQtAbPO7cMy1LonLSU3cNEH/5QBuYxS60PNxVKWgAQ/8L817SB1HVq5HahRmfjttN
	kpm3oq0Wab0PV971Vadq53c=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dRZps5LsCznTVZ;
	Thu, 11 Dec 2025 09:33:09 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id D12FA140295;
	Thu, 11 Dec 2025 09:35:26 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 11 Dec 2025 09:35:26 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 11 Dec
 2025 09:35:25 +0800
Message-ID: <a8caaea8-7c47-4b3c-a80c-2a9b144ffd98@huawei.com>
Date: Thu, 11 Dec 2025 09:35:24 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: PCC: Fix race condition by removing static
 qualifier
To: Sudeep Holla <sudeep.holla@arm.com>, Pengjie Zhang
	<zhangpengjie2@huawei.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <yubowen8@huawei.com>, <linhongye@h-partners.com>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>, <wangzhi12@huawei.com>
References: <20251210132634.2050033-1-zhangpengjie2@huawei.com>
 <20251210-valiant-watchful-guillemot-2bb5be@sudeepholla>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20251210-valiant-watchful-guillemot-2bb5be@sudeepholla>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/12/10 22:54, Sudeep Holla 写道:
> On Wed, Dec 10, 2025 at 09:26:34PM +0800, Pengjie Zhang wrote:
>> The variable 'ret' in acpi_pcc_address_space_setup() is currently
>> declared with the 'static' storage specifier. This can lead to race
>> conditions in a multithreaded environment.
>>
>> Remove the 'static' qualifier to ensure 'ret' is allocated directly
>> on the stack as a local variable.
>>
> Ah, my mistake. I’m not sure how that slipped in other than a simple typo or
> copy/paste error. Thanks for catching it. Let me know if you spotted it
> because something broke or just from reading the code.
>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: lihuisong@huawei.com
>

