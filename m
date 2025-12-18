Return-Path: <linux-acpi+bounces-19645-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F38CCA812
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 07:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 294783019899
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 06:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF3C32ED3B;
	Thu, 18 Dec 2025 06:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="YGMZ7O4X"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA26032E745;
	Thu, 18 Dec 2025 06:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766039973; cv=none; b=MAW3mlrKgvPiMl7IyFU6EVo3vTvOHhAJp7i1ezDckMBUSI7z3WslayYhDNP7nPYK6tFW01BtMHltLzvQO/3p3XTfc0ZwKeov9HWVXRnKIGmPzwyiOOlIFyQu9oYPsxs4c/9iPYexkpUOD5KM89mD8PqHwzSKAqBwjrKWWXSDvPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766039973; c=relaxed/simple;
	bh=w0kVqDf1nTGPgJrfxKMmJSXO6f0z3KBximApjZgCc2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=owYF+ej4wEujjoOryPGufpu1zg1b2o0brNtgKNn3ZT2op3KbkjYABisa2m46yRfIcBImjPLZsUc5pdJyXvMCoOlffDiyn0jU7R/tIHw3U05xMVUAmUHmwgAq0JlQXulwjsQY22O0dcsX8qDigjky8a2pD2ASiUn7zai7JxYlpg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=YGMZ7O4X; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=w0kVqDf1nTGPgJrfxKMmJSXO6f0z3KBximApjZgCc2o=;
	b=YGMZ7O4XgUKnWIgVcq7+USpcrs8+nD+2/5FPO7b9dKc8Zd7wJ+pubviiWcQjB/miwskrosOGD
	ZC5it3zyT2wzcpRLtjD1BZqrNICg5b7ApEIaprqI7oUc0R68F/+2GM8sllFexUcS8SJAKy4ibnV
	Liq/TaZHsvtBE4KCYuxvINk=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4dX1CV6bKczmV6t;
	Thu, 18 Dec 2025 14:36:22 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id BD50A14013B;
	Thu, 18 Dec 2025 14:39:26 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 18 Dec 2025 14:39:26 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 18 Dec
 2025 14:39:25 +0800
Message-ID: <98caf0d0-92f6-4842-bb49-a1979aed2283@huawei.com>
Date: Thu, 18 Dec 2025 14:39:25 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] ACPI: thermal: Convert the driver to a platform
 one
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI
	<linux-acpi@vger.kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
	Armin Wolf <w_armin@gmx.de>, Hans de Goede <hansg@kernel.org>,
	<lihuisong@huawei.com>
References: <6222428.lOV4Wx5bFT@rafael.j.wysocki>
 <2249483.irdbgypaU6@rafael.j.wysocki>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <2249483.irdbgypaU6@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/12/10 22:43, Rafael J. Wysocki 写道:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> While binding drivers directly to struct acpi_device objects allows
> basic functionality to be provided, at least in the majority of cases,
> there are some problems with it, related to general consistency, sysfs
> layout, power management operation ordering, and code cleanliness.
>
> Overall, it is better to bind drivers to platform devices than to their
> ACPI companions, so convert the ACPI thermal zone driver to a platform
> one.
>
> While this is not expected to alter functionality, it changes sysfs
> layout and so it will be visible to user space.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
I tested this series on my platform.
Yeah, there are some changes, such as a 'wakeup' directory.
But the function is ok. And this change is also ok to 'sensors' tool.

Tested-by: lihuisong@huawei.com

>
>
>

