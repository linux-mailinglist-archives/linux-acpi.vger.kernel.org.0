Return-Path: <linux-acpi+bounces-18004-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A06EBF1858
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 15:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AD4C189A782
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 13:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A523164AF;
	Mon, 20 Oct 2025 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="q0esaEKR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812193043B2;
	Mon, 20 Oct 2025 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760966591; cv=none; b=iXmjvQeqTgPVv8vxa0rQqJaEfIMxO+1KVZbDRQQHyfWjeOiatMbwdYWwwtubNr8KyKZ+bnYn7FAWxYnHPHckBy2a1S8981PA4vC8xE7Im3LCj29jpJtshsz/pMB4hUNvqX1mXqKV1tl47sBwmAZRLzaBzwHMTx4Lgpj3YKwENsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760966591; c=relaxed/simple;
	bh=SURrorlpKK042jse7CSvgXqPnvcIIlPNTlkrxpLT6JU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kkdhq7GjsNeZ8FFnmggBDDXVHwLX2R16mWXlK6fes4SDmBIKWLhRckdQ/4gDAAYHUKLf6gtLuZGXxulDH7iOAIi8nsepeBXSNz6g8Tizgb1lEzD14lIojHixYVjLTozWkrXSAFmD/uKkOAUUL6KhcIbtydaIIrrmptZBHT7+QMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=q0esaEKR; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=twNLkyeYrri2OQLBbsN6MguTa49g239UQ7T7I0pqboU=;
	b=q0esaEKRzsgQyVtjbId7vCmivLssOJarA7Lwm00G4h7svBRHJQI11IcqQ/LO6irUo79QoNVgc
	D30hKwakE6+ZLkMCOIqaf6x2ELJKOeeOZTZaG4whpCxgazv794kVWrHRWhOBNeEVop1OCNUx1+u
	AXcu4waFqByuNzzyhZSOl+A=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4cqx1b39hyz1prLM;
	Mon, 20 Oct 2025 21:22:43 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 485761402DA;
	Mon, 20 Oct 2025 21:23:07 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Oct 2025 21:23:06 +0800
Subject: Re: [PATCH v4] ACPI: AGDI: Add interrupt signaling mode support
To: Kazuhiro Abe <fj1078ii@aa.jp.fujitsu.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Ilkka Koskinen <ilkka@os.amperecomputing.com>, Will Deacon
	<will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>
References: <20251017073935.1746365-1-fj1078ii@aa.jp.fujitsu.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <a93e845a-b084-a680-7158-68363c492b75@huawei.com>
Date: Mon, 20 Oct 2025 21:23:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251017073935.1746365-1-fj1078ii@aa.jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/10/17 15:39, Kazuhiro Abe wrote:
> AGDI has two types of signaling modes: SDEI and interrupt.
> Currently, the AGDI driver only supports SDEI.
> Therefore, add support for interrupt signaling mode
> The interrupt vector is retrieved from the AGDI table, and call panic
> function when an interrupt occurs.
> 
> Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> Signed-off-by: Kazuhiro Abe <fj1078ii@aa.jp.fujitsu.com>
> ---
> Hanjun, I have addressed all your comments.
> Please review them.
> 
> v3->v4
>   - Add a comment to the flags member.
>   - Fix agdi_interrupt_probe.
>   - Fix agdi_interrupt_remove.
>   - Add space in struct initializsation.
>   - Delete curly braces.

Looks good to me,

Acked-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun

