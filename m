Return-Path: <linux-acpi+bounces-19643-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A856CCCA782
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 07:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E5E93062E5D
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 06:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE0A321442;
	Thu, 18 Dec 2025 06:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="oj4V7Kti"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB072264AA;
	Thu, 18 Dec 2025 06:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766039337; cv=none; b=SqSzWbhefOuLTdX8jjyP2/kVlZbE414JjR+x29a+cExNziE4PaHYrayq9+tfdH3UWs1ronQW7BOp2A/KRYFcWoifOeOLZDxx2yhTd/MO0K7YPJqHm7XxqmbC6h4w8yIr2UWFtig2QnMy0FOKcJsS091hIwkICXxcvVBal2AZrE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766039337; c=relaxed/simple;
	bh=Y7BagkDVPUE7ngwlpWuPkyJIEsl6jUcK8Z6okUG1v64=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DiOtl7UZxCXGs3agDJjqtMHVL/k7sqD9scjBUUYj3yr7qUn5+jseITFrZg7zWRUzKmhQjVpKz4rHsF3r9C0019QdO2GQpsUOI+WoHIq0dgr/kvhtctiApVvU2vYy+8sPEZhzK1mUrPeVGrA9FPRKC0eIvHzCMsJAEdNXd/qPEqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=oj4V7Kti; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Y7BagkDVPUE7ngwlpWuPkyJIEsl6jUcK8Z6okUG1v64=;
	b=oj4V7KtikxVzf+ADrttqJgV04/7/HWkFboZpsWBCiy7tHw1QqkselKjfzYhHP/tRyu8PJK4Tv
	AlnxpwgqIn6cFfqiSDaTS/HGdw2XXMhcHHLE3rPohODPahGwD0F5w3C4/y+GCf3biJJkEBsRHGR
	QJYfhYChWwgU1Qhw2lba6I0=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dX10G1bFMz12LDy;
	Thu, 18 Dec 2025 14:26:38 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 742811402C1;
	Thu, 18 Dec 2025 14:28:51 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 18 Dec 2025 14:28:44 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 18 Dec
 2025 14:28:43 +0800
Message-ID: <74dbd0d1-e888-4a1b-8f21-a44a015047e7@huawei.com>
Date: Thu, 18 Dec 2025 14:28:43 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] ACPI: scan: Register platform devices for thermal
 zones
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI
	<linux-acpi@vger.kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
	Armin Wolf <w_armin@gmx.de>, Hans de Goede <hansg@kernel.org>,
	<lihuisong@huawei.com>
References: <6222428.lOV4Wx5bFT@rafael.j.wysocki>
 <4701463.LvFx2qVVIh@rafael.j.wysocki>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <4701463.LvFx2qVVIh@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/12/10 22:42, Rafael J. Wysocki 写道:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Currently, platform devices are not registered for ACPI thermal zones
> because they are not represented as device objects in the ACPI namespace.
> Instead, they are represented as thermal zone objects, so in particular
> the platform_id flag is not set for them during enumeration because it
> is only set for objects of type ACPI_BUS_TYPE_DEVICE, but otherwise they
> are handled similarly at the ACPI core level.
>
> To facilitate converting the ACPI thermal zone driver into a platform
> one, modify acpi_set_pnp_ids() to set the platform_id flag for thermal
> zones in analogy with device objects to cause platform devices to be
> registered for them.
>
> No intentional functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: lihuisong@huawei.com
>
>
>

