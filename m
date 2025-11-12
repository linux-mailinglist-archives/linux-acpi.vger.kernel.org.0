Return-Path: <linux-acpi+bounces-18827-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 588BAC53ECC
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 19:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E0ABE3467ED
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 18:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B6B352F8A;
	Wed, 12 Nov 2025 18:25:29 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8025F35293A;
	Wed, 12 Nov 2025 18:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971929; cv=none; b=Mw1HxeREJGFC/dbt2WiNkn/LQrMFzE/tWs+EJRD4SLB+R5OjIqtpA3PeqhgC8d8ZCyfWovdzN+bYw3dkIrJI9B9LBrVlcKQpfCpq9xvgoQBi4YwwmmNh0dChj7wLCioJ4IIUvtHfIPA58G2WaUfVZvzV1cs17k0/6EM/vuxAh3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971929; c=relaxed/simple;
	bh=lizdUnDeduoQiKv5+ThT5MsgZaSyS7YSf7d07ugaIXY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OBjiCLxwniSQuyevLc7AIyJZJSH5tjLo0K2wgNZX7IJRw17T+pgjSAd24C1eQCE47GfwOcyvOYkpvIg/DR2ZS8WOrsFJdqR4C8okBo8gJzABeQSoyPLqDKifqgccLG3uncsS6WmANIiZ6gDW4InZox5KW8JOCag1bj634bcv4iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d6BdZ5JZczJ46DR;
	Thu, 13 Nov 2025 02:24:50 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C3491402F1;
	Thu, 13 Nov 2025 02:25:23 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 12 Nov
 2025 18:25:22 +0000
Date: Wed, 12 Nov 2025 18:25:21 +0000
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
Subject: Re: [PATCH v4 16/26] genirq: Allow per-cpu interrupt sharing for
 non-overlapping affinities
Message-ID: <20251112182521.000027ad@huawei.com>
In-Reply-To: <20251020122944.3074811-17-maz@kernel.org>
References: <20251020122944.3074811-1-maz@kernel.org>
	<20251020122944.3074811-17-maz@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 20 Oct 2025 13:29:33 +0100
Marc Zyngier <maz@kernel.org> wrote:

> Interrupt sharing for percpu-devid interrupts is forbidden, and
> for good reasons. These are interrupts generated *from* a CPU and
> handled by itself (timer, for example). Nobody in their right mind
> would put two devices on the same pin (and if they have, they get to
> keep the pieces...).
> 
> But this also prevents more benign cases, where devices are connected
> to groups of CPUs, and for which the affinities are not overlapping.
> Effectively, the only thing they share is the interrupt number, and
> nothing else.
> 
> Let's tweak the definition of IRQF_SHARED applied to percpu_devid
> interrupts to allow this particular case. This results in extra
> validation at the point of the interrupt being setup and freed,
> as well as a tiny bit of extra complexity for interrupts at handling
> time (to pick the correct irqaction).
> 
> Tested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

