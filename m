Return-Path: <linux-acpi+bounces-18822-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BB0C53DE5
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 19:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D36913A22FA
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 18:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E13C3446D7;
	Wed, 12 Nov 2025 18:07:00 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBCC344025;
	Wed, 12 Nov 2025 18:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762970820; cv=none; b=ktIArdsbUS3fzjWJyKLRQE2vrSsbV2xhlfPCzFgUBuyWHnOV1JTn7d/eUaujLHHybwuxhfgXJoRL8l/PzSxWSOmmFZ1Nhz/TWKfbhfnB9/+jDVT0BL0YrKNejdfLKuRW7bTFoH6xIjLUT0zjdoVR0XezjcytWpSs/BfQzCeoklU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762970820; c=relaxed/simple;
	bh=Z3v4U+Htx9d06oTcBm//zvYPXdfYm7Sm0oXUefaEoy0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdMe9xeoaDLHqIvP8vvvVIxGNZlV6OUHtMWuoXyLg3tUrNTRXLvENM6BmIGwvimfDrSmAGBphFCqJtx2+E6BGfk78FjqkdEV4gO4mGxOHKMpBkooDwFf1OZkN2MjdJ58we/8qeeyFiqD2QR+f+uu0mo3JDONp0QllVkg69L9pMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d6BDX3GTfzHnH52;
	Thu, 13 Nov 2025 02:06:36 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id EB4841402F1;
	Thu, 13 Nov 2025 02:06:55 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 12 Nov
 2025 18:06:55 +0000
Date: Wed, 12 Nov 2025 18:06:53 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Marc Zyngier <maz@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Mark
 Rutland" <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, "Saravana
 Kannan" <saravanak@google.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sven Peter <sven@kernel.org>, Janne Grunau
	<j@jannau.net>, Suzuki K Poulose <suzuki.poulose@arm.com>, James Clark
	<james.clark@linaro.org>, Jinjie Ruan <ruanjinjie@huawei.com>, "Alexandru
 Elisei" <alexandru.elisei@arm.com>
Subject: Re: [PATCH v4 10/26] irqchip/gic-v3: Switch high priority PPIs over
 to handle_percpu_devid_irq()
Message-ID: <20251112180653.00004e6c@huawei.com>
In-Reply-To: <20251020122944.3074811-11-maz@kernel.org>
References: <20251020122944.3074811-1-maz@kernel.org>
	<20251020122944.3074811-11-maz@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 20 Oct 2025 13:29:27 +0100
Marc Zyngier <maz@kernel.org> wrote:

> It so appears that handle_percpu_devid_irq() is extremely similar to
> handle_percpu_devid_fasteoi_nmi(), and that the differences do no
> justify the horrid machinery we have in the GICv3 driver to handle
> the flow handler switch.
> 
> Let's stick with the standard flow handler, even for NMIs.
> 
> Suggested-by: Will Deacon <will@kernel.org>
> Tested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
LGTM and who doesn't like those diff stats ;)
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
>  drivers/irqchip/irq-gic-v3.c | 54 ++----------------------------------
>  1 file changed, 2 insertions(+), 52 deletions(-)


