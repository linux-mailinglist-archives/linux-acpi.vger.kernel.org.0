Return-Path: <linux-acpi+bounces-17167-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4E0B8EA95
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 03:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 414F3176988
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 01:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E3D1482E8;
	Mon, 22 Sep 2025 01:18:02 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3F72AF1D;
	Mon, 22 Sep 2025 01:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758503881; cv=none; b=WTs8y6FPJzDBjHi500LMzDMwrTtM3NRdcNLfHtoAPDstXtWL2i1JgzkffLJI0Bx4j7LZEyhI6pDVv17uZ9iRTYxl69i+1RmW7G71D+yYUifLMUlQFZ21oeCi9csPacma1b+pVe+oQ207i4mGwqBTUH8Sq76LAb+evRyYovkWkwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758503881; c=relaxed/simple;
	bh=eO1Sg5HDN5GgzHXOHyIjJ/6SJEr+B8g7zZyYSzaz55Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n6yMLu+QAwJ8/hAtSg6/xD3OU9pyRWYn7KvZEQwvEbQiDu/oviEQQFH1dOEdtrjATSWGh0lsZqqmOVbJ19C2p/vKkSTT1XJNVqlNxZrAO5bHyzSCwNhMaz1lq8AjOYlHFju5NI4Gotex7aqcWKepnL88SHrJ+b+tEMWiTeuj+tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cVQ8n2Zr9zJsWt;
	Mon, 22 Sep 2025 09:13:13 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 18DB51800B2;
	Mon, 22 Sep 2025 09:17:51 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 22 Sep 2025 09:17:49 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 22 Sep
 2025 09:17:49 +0800
Message-ID: <3eee9fb5-0561-4dae-93e8-8f4b742863a0@huawei.com>
Date: Mon, 22 Sep 2025 09:17:48 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] ACPI: processor: idle: Redefine two functions as
 void
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI
	<linux-acpi@vger.kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>, "Shenoy, Gautham Ranjal"
	<gautham.shenoy@amd.com>
References: <5926523.DvuYhMxLoT@rafael.j.wysocki>
 <2385759.ElGaqSPkdT@rafael.j.wysocki>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <2385759.ElGaqSPkdT@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/9/19 5:10, Rafael J. Wysocki 写道:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Notice that acpi_processor_power_init() and acpi_processor_power_exit()
> don't need to return any values because their callers don't check them
> anyway, so redefine those functions as void.
>
> While at it, rearrange the code in acpi_processor_power_init() to
> reduce the indentation level, get rid of a redundant local variable
> in that function, and rephrase a code comment in it.
>
> No intentional functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
LGTM,
Acked-by: lihuisong@huawei.com
>
>
>

