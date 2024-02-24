Return-Path: <linux-acpi+bounces-3931-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3530486247D
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Feb 2024 12:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D205B1F22AF7
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Feb 2024 11:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DD6250EB;
	Sat, 24 Feb 2024 11:28:52 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0011B59B
	for <linux-acpi@vger.kernel.org>; Sat, 24 Feb 2024 11:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708774132; cv=none; b=GPZ5uzdhFfC4ImD1Gdf7QKqcfR5YnGEVOoJNgzz6sT35q0K9VqcplyRyJ28wnPEQplLC7gDWzbfFbcv/E3bV2axkZUQ/YMIqIU+R+Pf3FvDsgNaZQebonTF673/lGuEdtuv02tdpDRsTJuNYQJutpDpyMdaTE+MiQE2UHTUAcOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708774132; c=relaxed/simple;
	bh=7ESe9o2MUsaPjzyzPXpSc0k6trM/Jfk3bGlcpKYAnXE=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FN9POIcxFrPpW9J7NKgR+vIBog9TwYAWlGsKPYK/xfLkuqML9sM7s+ap3WG+sqCuKmiiuLBr1gFZF9/kaHKd1AB6ejbNheC013XzODxRaT/mToZ7EjJ+WsEGaiU1lvGgyN8dI3Pouosnzdn+KIZYVk139FHzvU7svm0VyBIVkV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Thl443xdFzqhdB;
	Sat, 24 Feb 2024 19:28:04 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (unknown [7.185.36.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 0D915140381;
	Sat, 24 Feb 2024 19:28:40 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 24 Feb 2024 19:28:39 +0800
Subject: Re: [PATCH 2/7] ACPI: AGDI: Convert to platform remove callback
 returning void
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>, Sudeep Holla
	<sudeep.holla@arm.com>, Len Brown <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kernel@pengutronix.de>
References: <cover.1708627599.git.u.kleine-koenig@pengutronix.de>
 <c41853160b8947e865357f99171cfbdbb4b4804e.1708627599.git.u.kleine-koenig@pengutronix.de>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <23789259-f11a-dea0-6dae-f45bcdccbf12@huawei.com>
Date: Sat, 24 Feb 2024 19:28:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c41853160b8947e865357f99171cfbdbb4b4804e.1708627599.git.u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)

On 2024/2/23 2:52, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/acpi/arm64/agdi.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)

Looks good to me,

Acked-by: Hanjun Guo <guohanjun@huawei.com>

