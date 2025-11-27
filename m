Return-Path: <linux-acpi+bounces-19303-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C93C8CA35
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 03:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B5E0A4E1962
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 02:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDD724290D;
	Thu, 27 Nov 2025 02:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="I19Kz/uP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0250720A5E5;
	Thu, 27 Nov 2025 02:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764209394; cv=none; b=kLKvv2AxTRMnn9fDA/p1sZqDmi7iri6yrz+Jb1Vq8MTETSXjNwQwUvAe20SWAEs4wppGMub8DcHDdP3ZIMuv4Mu1KNzloY5uKqA3wKpp+q6loTPnS03+FAHKvDVe0/puhJ5LCNshwSef6/p96GZ2P1kR7zjU1yd3x8elKnQz6Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764209394; c=relaxed/simple;
	bh=xDs508urDQVseAJA2kSJdcyIzJ7PCzIxzYucRzfxfeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=p+4IpCKyDZbstwKtMNfFCsa2KZWNBIIqB5Gzl3x+I9fn59slmqTw8F8dXnTmvK65V3+cWD/nwKdpm7eYu6YUs2gWZDKn3X7ciWqMnjgakaHie+EM+ThwbWQ4O/WWN7VtxaXjntPjzKx4E8oAxnjlzU2VeV2wwV2vxLyrlmMmkWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=I19Kz/uP; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qZrw3MGbOgIujlX664VzCx3x+2aqMoYiHH9ABOjCtUY=;
	b=I19Kz/uPG+6CWhjWxuHW59Fu9jeJ6plLrcxIhT6Jrcsb+chI+VYBb9mY6677ktPkLAodXSblU
	iNeq8za6N7vMlk7Ua36oi+gR/NDoM28e6Ssd8FVY7dAkQDD/YfmHy8fEu4bQ0D2bHrgEyufIp6T
	YfDA96vxU9A1N74QvowSbls=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4dH0FY2hr6z1K96g;
	Thu, 27 Nov 2025 10:08:01 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 235BE1A0188;
	Thu, 27 Nov 2025 10:09:48 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 27 Nov 2025 10:09:47 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 27 Nov
 2025 10:09:47 +0800
Message-ID: <1ea445d0-0949-4a28-9f76-325861a3c57f@huawei.com>
Date: Thu, 27 Nov 2025 10:09:46 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Urgent ACPI support fix for v6.18
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM
	<linux-pm@vger.kernel.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, <lihuisong@huawei.com>
References: <CAJZ5v0g6c1HNbxxh088xh_nTgD-SE6c2qtDr81AgD1+by-jnKA@mail.gmail.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0g6c1HNbxxh088xh_nTgD-SE6c2qtDr81AgD1+by-jnKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemn100009.china.huawei.com (7.202.194.112)

Hello Rafael,

在 2025/11/26 20:54, Rafael J. Wysocki 写道:
> Hi Linus,
>
> Please pull from the tag
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>   acpi-6.18-rc8
>
> with top-most commit 43ff36c4a5a574ee83b4b0d3f3d74f09a3a8c2d3
>
>   Revert "ACPI: processor: idle: Optimize ACPI idle driver registration"
>
> on top of commit ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d
>
>   Linux 6.18-rc7
>
> to receive an urgent ACPI support fix for 6.18.
>
> This reverts a commit that attempted to make the code in the ACPI
> processor driver more straightforward, but it turned out to cause
> the kernel to crash on at least one system, along with some further
> cleanups on top of it.
I just found that "ACPI: processor: idle: Optimize ACPI idle driver 
registration" depends on the change
about cpuhp_setup_state in the commit [1]. Or many CPUs don't create 
cpuidle directory.
What is the crash? Do you have releated trace?

[1] 
https://lore.kernel.org/all/20240529133446.28446-2-Jonathan.Cameron@huawei.com/ 

>
>
> ---------------
>
> Rafael J. Wysocki (5):
>        Revert "ACPI: processor: Do not expose global variable acpi_idle_driver"
>        Revert "ACPI: processor: idle: Redefine two functions as void"
>        Revert "ACPI: processor: idle: Rearrange declarations in header file"
>        Revert "ACPI: processor: Remove unused empty stubs of some functions"
>        Revert "ACPI: processor: idle: Optimize ACPI idle driver registration"
>
> ---------------
>
>   drivers/acpi/processor_driver.c |   6 +--
>   drivers/acpi/processor_idle.c   | 115 ++++++++++++++++------------------------
>   include/acpi/processor.h        |  34 +++++++++---
>   3 files changed, 76 insertions(+), 79 deletions(-)
>

