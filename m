Return-Path: <linux-acpi+bounces-15681-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B182B267FA
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 15:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2980FA269DB
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 13:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20AB2FD1B5;
	Thu, 14 Aug 2025 13:40:35 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4303D2EBDDD;
	Thu, 14 Aug 2025 13:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178835; cv=none; b=WGF2yTDJmryjjeKDZjlqFx068epngVtdyarFH+Gemroq7blSIlh3hVVCcK9cKvOoGC0g0VZIf2EUijF7AV7+JMpekWzwUBcsh4Mll1DN1NMDCVn/Du1w5liJT8mVCpQjphXfY+KMYdZ1YsTXDHE6FXJ8qlurs+yaMqY3ElMkZQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178835; c=relaxed/simple;
	bh=a9wg0UP8JrKxjxd2s0z1uMBMZ4NfkO5OQeHNtFGGyNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E9TRXDERdUcGk1MZQkRcJeuaI7gcNkWOc3BEQ9FIM0vuAd6qktgEKYA1ltAxt1m2H/BSUzxHMUzQMjwnyZL57A9JZPp2A0B7v+BxYsAv2sxR5WqbkJEpU4x5Fp/mFW7Hb97P578WjdkRggc/vrzqcQE2k2UJv/A56ePytmEjcoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c2mV20QHTz2CgC6;
	Thu, 14 Aug 2025 21:36:10 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 36C08140144;
	Thu, 14 Aug 2025 21:40:30 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 Aug 2025 21:40:30 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 14 Aug
 2025 21:40:27 +0800
Message-ID: <5bfa7bef-483f-42c4-9517-198d0fa3f343@huawei.com>
Date: Thu, 14 Aug 2025 21:40:21 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI: processor: idle: Eliminate static variable
 flat_state_cnt
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI
	<linux-acpi@vger.kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>, Artem Bityutskiy
	<artem.bityutskiy@linux.intel.com>, <lihuisong@huawei.com>
References: <10715991.nUPlyArG6x@rafael.j.wysocki>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <10715991.nUPlyArG6x@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/8/13 18:38, Rafael J. Wysocki 写道:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Instead of using static variable flat_state_cnt to pass data between
> functions involved in the _LPI information processing, pass the current
> number of "flattened" idle states to flatten_lpi_states() and make it
> return the updated number of those states.  At the same time, use a
> local variable called state_count to store the number of "flattened"
> idle states found so far in acpi_processor_get_lpi_info().
>
> No intentional functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   
LGTM,
Acked-by: lihuisong@huawei.com
>
>
>

