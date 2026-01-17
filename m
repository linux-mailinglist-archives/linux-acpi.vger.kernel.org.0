Return-Path: <linux-acpi+bounces-20413-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 385FAD38B7E
	for <lists+linux-acpi@lfdr.de>; Sat, 17 Jan 2026 03:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B16A2300C61E
	for <lists+linux-acpi@lfdr.de>; Sat, 17 Jan 2026 02:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8BB299924;
	Sat, 17 Jan 2026 02:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="pXluhKyt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F1A24501B;
	Sat, 17 Jan 2026 02:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768615944; cv=none; b=UxnywMSPJgXOGieJ/0I6UNVRS0Cf9nNiqgSyJ3F2BeMQSRHEUuUGm/svjO+T/KUbWufEQrayA7+W7CS/2BJDzbsv3Sptkyfj6z5gE8ckgpIRkz3wehFpzCc6cZ4CIugZ5UgP85HyeB4skrzbGvDHhflxhiqscxB2U8KtYy0PXm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768615944; c=relaxed/simple;
	bh=PI0mHuKSdy6ZYMg04sf7teJ60aXmjiCT2hLzHA6Nurs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q637Ue712pjFgBd/jSlQGhenKxpKAmmk/uk4CA9dCYtqsLHyJ8y4/71JmRonpg/KFpmpo9Z3Q6++s73VHwtDVEeI34v/59TMO724sftKsSs8XwshtcqE1Aww56sjVci90pr7m2eQtt8dtSNMgYxnFPyMFy/X5AIMXxZI06OVpUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=pXluhKyt; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=PI0mHuKSdy6ZYMg04sf7teJ60aXmjiCT2hLzHA6Nurs=;
	b=pXluhKytHrXU8PvdK7djOPITeTumB/RXb6QIGYHeE2ZmueD89BvOSz8+E3czSviqhIzaGG0eG
	Dpyr/7qyOC1fwk66+kiXV1mS7aym+cehk6xsf2dLF6lIXXJiEw8nyZWpafnXy2qnJWRLUXWcgza
	QlKeFvBb3VK3aksaMz8P9/o=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dtKrz2rtMzRhS9;
	Sat, 17 Jan 2026 10:08:51 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id D6DD540538;
	Sat, 17 Jan 2026 10:12:12 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 17 Jan 2026 10:12:12 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Sat, 17 Jan
 2026 10:12:12 +0800
Message-ID: <9111d052-ea4f-443b-ba94-126b9c4262f5@huawei.com>
Date: Sat, 17 Jan 2026 10:12:11 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailbox: pcc: Remove spurious IRQF_ONESHOT usage
To: Sudeep Holla <sudeep.holla@arm.com>, Mark Brown <broonie@kernel.org>
CC: Jassi Brar <jassisinghbrar@gmail.com>, Aishwarya TCV
	<Aishwarya.TCV@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260116-mailbox-pcc-non-threaded-irq-v1-1-916b093329cd@kernel.org>
 <aWpK-dMK3t0VVqFY@bogus>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <aWpK-dMK3t0VVqFY@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemn100009.china.huawei.com (7.202.194.112)


On 1/16/2026 10:28 PM, Sudeep Holla wrote:
> On Fri, Jan 16, 2026 at 02:07:40PM +0000, Mark Brown wrote:
>> The PCC code currently specifies IRQF_ONESHOT if the interrupt could
>> potentially be shared but doesn't actually use request_threaded_irq() and
>> the interrupt handler does not use IRQ_WAKE_THREAD so IRQF_ONESHOT is
>> never relevant. Since commit aef30c8d569c ("genirq: Warn about using
>> IRQF_ONESHOT without a threaded handler") specifying it has resulted in a
>> WARN_ON(), fix this by removing IRQF_ONESHOT.
>>
> Looking back, can't think of any reason why we retained IRQF_ONESHOT
> when we added IRQF_SHARED. Thanks for spotting and fixing it.
>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
The interrupt status of channel is cleared by bit first in pcc_mbox_irq.
And it is a hard irq handler.
Rmoving IRQF_ONESHOT looks good to me. Thanks for fixing it.

Acked-by: lihuisong@huawei.com
>

