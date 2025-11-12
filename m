Return-Path: <linux-acpi+bounces-18824-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E236C53E1B
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 19:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F2D44E23A4
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 18:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DCD34A789;
	Wed, 12 Nov 2025 18:09:30 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AA232861B;
	Wed, 12 Nov 2025 18:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762970970; cv=none; b=QM5bZuYItjsGTqEbCSYdnFklhnitAERMuuc1v3HfZZTr1O6rw9OPyQY4C6F2E2Z0R1PFWZUaDljSc0mhTAs/1jI4xv8J+wotwiQvBst5fwz95eEzohIAEzZFff2hooeBEu1jMF8vMqmHXa0EeZwo2sVCkAgrBBcHr3CjBqrqpjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762970970; c=relaxed/simple;
	bh=Yfg8I48UK8fl+JKYhUm/LEEHyFpxh/rKdPhlgx187fU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uInoAxow/saCOfc7KsSBEE6skAcSjFxcRBk6kb5E7TWjS6C+AK99UP9L3WyIyStmIFi9qxoHcJUVQ5Wi9EqjiFYFTpBnAWkDGf5GKJPX6jm/TzWVxXHip4a5Po2rY+bM6XKCZ1Sgy17L32yR/JlNcEMxjhG4Ke4VgtysLsB2OXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d6BHP5PF7zHnGhy;
	Thu, 13 Nov 2025 02:09:05 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 413931402FB;
	Thu, 13 Nov 2025 02:09:25 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 12 Nov
 2025 18:09:24 +0000
Date: Wed, 12 Nov 2025 18:09:20 +0000
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
Subject: Re: [PATCH v4 12/26] genirq: Merge
 irqaction::{dev_id,percpu_dev_id}
Message-ID: <20251112180920.00005312@huawei.com>
In-Reply-To: <20251020122944.3074811-13-maz@kernel.org>
References: <20251020122944.3074811-1-maz@kernel.org>
	<20251020122944.3074811-13-maz@kernel.org>
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

On Mon, 20 Oct 2025 13:29:29 +0100
Marc Zyngier <maz@kernel.org> wrote:

> When irqaction::percpu_dev_id was introduced, it was hoped that it
> could be part of an anonymous union with dev_id, as the two fields
> are mutually exclusive.
> 
> However, toolchains used at the time were often showing terrible
> support for anonymous unions, breaking the build on a number of
> architectures. It was therefore decided to keep the two fields separate
> and address this down the line.
> 
> 14 years later, the compiler dark age is over, and there is universal
> support for anonymous unions. Let's get a whole pointer back that can
> immediately be spent on something else.
> 
> Tested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
I'm glad I either never saw that anon union problem or have blanked it from
my mind.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

