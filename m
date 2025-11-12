Return-Path: <linux-acpi+bounces-18816-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 09371C53C58
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 18:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BC214EFFA9
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 16:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3CD31C59B;
	Wed, 12 Nov 2025 16:59:03 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFA2315789;
	Wed, 12 Nov 2025 16:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762966743; cv=none; b=HdYfeu0ZXeSXhqSJwaUCqUipmNIt8tzyvjL84Wr2mbLl1qZMqRVnnPw0h92zfPtBIyAkEn8SN156h891E3kk7By89OxqM6gL2s+nG3qAp53rV/m7cHO/9DPOi/F/SvumuE32gSKbXFGn8JD990dYGZx+ITSiN/AnaeWR0B+ycuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762966743; c=relaxed/simple;
	bh=sbbd8CFKuEBDDP+nuDi+i7pI+QjeJV1pEo6mSOxlUmc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sC+spOPCdLqoyTAusFEf90QoiycJ5E831ViLndyClSa6u/ufkIqi94GzLlJvAN4mfSDwriXpw22ptO5U82mDq/D3PpXIwxrLl6mVBKLuEPufUwAGb5UeXpwhqMNf2wEVfpQLGd89skE7rT2QYyqS32M3FHcoLoL3DqTw7lH1Fng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d68jt0mkVzJ46D8;
	Thu, 13 Nov 2025 00:58:26 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id D167A1400D9;
	Thu, 13 Nov 2025 00:58:58 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 12 Nov
 2025 16:58:57 +0000
Date: Wed, 12 Nov 2025 16:58:56 +0000
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
Subject: Re: [PATCH v4 07/26] coresight: trbe: Convert to new IRQ affinity
 retrieval API
Message-ID: <20251112165856.00000384@huawei.com>
In-Reply-To: <20251020122944.3074811-8-maz@kernel.org>
References: <20251020122944.3074811-1-maz@kernel.org>
	<20251020122944.3074811-8-maz@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 20 Oct 2025 13:29:24 +0100
Marc Zyngier <maz@kernel.org> wrote:

> Now that the relevant interrupt controllers are equipped with
> a callback returning the affinity of per-CPU interrupts, switch
> the TRBE driver over to this new method.
> 
> Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Tested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

