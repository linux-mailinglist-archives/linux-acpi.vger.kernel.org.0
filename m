Return-Path: <linux-acpi+bounces-15168-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B75C1B061B4
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Jul 2025 16:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E690E189D055
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Jul 2025 14:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EA91E7C1B;
	Tue, 15 Jul 2025 14:41:37 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6EE2AE8E;
	Tue, 15 Jul 2025 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590497; cv=none; b=qleiTw/AgnF/3AM9QJ2gcTP+bFuKDjrhIXbxGZ+i0n85YRXBfcgsQb0PWDeWa25qOgeXra5Liz+gGbE1Z5hybLaFsZrH4eGCTN5U+cn0FxBZdtUywIhdf6JR+7ylC2teE/bhle5Unzuf8lrW2M+/UpXbMRH5dRs6VREPP7clR14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590497; c=relaxed/simple;
	bh=HqGFg4SANcbYOi3xVkEVkOC2NHkznbBn5xdWEpv50To=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MW1422KuATkmODRqwfkBNi6aHeuFN1ThCzZoFf0F0J5drJToFFRyGQNP+sSyoy1vnFX5zRx700Ij1zfUxxny3O15S6BHOQ4U3bAXYXmT3xEpWNt+Mu32Sg2IPgPlOsKnv6sGMogGisa77Cq+8dnp72Ak4CKijE6DwimhkezX4GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bhMGV526Yz2CfbG;
	Tue, 15 Jul 2025 22:37:22 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 59A9F14022E;
	Tue, 15 Jul 2025 22:41:29 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 15 Jul 2025 22:41:28 +0800
Subject: Re: [PATCH v1] ACPI: APEI: MAINTAINERS: Update reviewers for APEI
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI
	<linux-acpi@vger.kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Len
 Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, James Morse
	<james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai Xue
	<xueshuai@linux.alibaba.com>
References: <12722151.O9o76ZdvQC@rjwysocki.net>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <b22f7a80-3219-00ce-8773-c3137fe6404f@huawei.com>
Date: Tue, 15 Jul 2025 22:41:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <12722151.O9o76ZdvQC@rjwysocki.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/7/15 21:20, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Update the ACPI APEI entry in MAINTAINERS by dropping the reviewers
> who have not been responsive for over a year and adding a list of
> new reviewers.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> The new people in the new APEI reviewers list, please send your ACKs for this
> change, thanks!
> 
> ---
>   MAINTAINERS |    5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -306,10 +306,11 @@
>   
>   ACPI APEI
>   M:	"Rafael J. Wysocki" <rafael@kernel.org>
> -R:	Len Brown <lenb@kernel.org>
> -R:	James Morse <james.morse@arm.com>
>   R:	Tony Luck <tony.luck@intel.com>
>   R:	Borislav Petkov <bp@alien8.de>
> +R:	Hanjun Guo <guohanjun@huawei.com>
> +R:	Mauro Carvalho Chehab <mchehab@kernel.org>
> +R:	Shuai Xue <xueshuai@linux.alibaba.com>
>   L:	linux-acpi@vger.kernel.org
>   F:	drivers/acpi/apei/

Acked-by: Hanjun Guo <guohanjun@huawei.com>

Thank you!
Hanjun

