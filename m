Return-Path: <linux-acpi+bounces-18828-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4A6C53F5C
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 19:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 23E50348D56
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 18:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14746359FB8;
	Wed, 12 Nov 2025 18:27:42 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0951834DB7F;
	Wed, 12 Nov 2025 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762972062; cv=none; b=KWQihmptsr210TxGrbct/0DOK027ukTSw4ButmFjm8u39cFHsBYSFKMGAXicQ6hl7dZ0zzAQo8EzAUj7whtFtz3kyfqYo9bI/ziijua8ovTguDWv8XF5lCjYhz2d72I/BITYYVAn9nXGmtOlxfbGqUh2rIWNHzn2nhuFlYfPHRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762972062; c=relaxed/simple;
	bh=lvk/smEJNeQBj0VHoIfrwk0u+PsEGYCtIbgwF2adYTQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RYMU7JqbAbm97HU6VSn/ez3gFMARHr6hJNuhBWPk0+zEYfqxswfyYlk8OD3G030QOYSysuT4T88Ap4i4UT8srcLIOblZ6RThugJMD4Q9iz0l1oyZdZGRK5Ptt+k3OjxDK+Qn63UXAkdzoHN7MvoGDOAsA2Xite40FCXs5zWZQn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d6BhP52h0zHnH4q;
	Thu, 13 Nov 2025 02:27:17 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 3B7011402FB;
	Thu, 13 Nov 2025 02:27:37 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 12 Nov
 2025 18:27:36 +0000
Date: Wed, 12 Nov 2025 18:27:35 +0000
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
Subject: Re: [PATCH v4 17/26] genirq: Add request_percpu_irq_affinity()
 helper
Message-ID: <20251112182735.00001363@huawei.com>
In-Reply-To: <20251020122944.3074811-18-maz@kernel.org>
References: <20251020122944.3074811-1-maz@kernel.org>
	<20251020122944.3074811-18-maz@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 20 Oct 2025 13:29:34 +0100
Marc Zyngier <maz@kernel.org> wrote:

> While it would be nice to simply make request_percpu_irq() take
> an affinity mask, the churn is likely to be on the irritating side
> given that most drivers do not give a damn about affinities.

Only 37 instances. I'd have been tempted to do it anyway :)

> 
> So take the more innocuous path to provide a helper that parallels
> request_percpu_irq(), with an affinity as a bonus argument.
> 
> Yes, request_percpu_irq_affinity() is a bit of a mouthful.
> 
> Tested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

