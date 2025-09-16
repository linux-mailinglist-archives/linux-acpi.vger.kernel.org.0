Return-Path: <linux-acpi+bounces-17042-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A179BB59D3D
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 18:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E583AB490
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 16:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27976235362;
	Tue, 16 Sep 2025 16:13:06 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF7D328586;
	Tue, 16 Sep 2025 16:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758039186; cv=none; b=Uqx8t7YyHTVcVFYWy4S/A8DZCl16/OBfSog+FOpX3oYOKWHvt8cvJuzF7C/jvaRBO8QtdjE7bTbPLf/WZA2luqzw4gihTpW9ckkI42ruAgBRvOhM9nZpip4Z14Sz5rLW06PDbePEfZ226K2WPvi+SeAWvC49u9+zN48IZHeMZ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758039186; c=relaxed/simple;
	bh=/FFuZ+jwoUlxNcXEMJw+BzPghSyuSxR5lk48pQ33lp4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RuYma8XAvXG4M69P9Y2SIFO+JWtpYIboR05kEk+qnqmUTLUOdwjhYVxDB2n6GIfNXaiNBs2INfNP++udEZ7YmLQGcZ0FXF70Pa6lGqUEmJG8+vzEruQUQ34j24M5Wc4wlQGhmDSteX/L9CPKGMu2izrkPT+k5U+S9gnGafQNtkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cR6LY5b0Tz6K9Hp;
	Wed, 17 Sep 2025 00:10:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1C65D1402F1;
	Wed, 17 Sep 2025 00:13:01 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 16 Sep
 2025 18:13:00 +0200
Date: Tue, 16 Sep 2025 17:12:59 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Marc Zyngier <maz@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Mark
 Rutland" <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, "Saravana
 Kannan" <saravanak@google.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sven Peter <sven@kernel.org>, Janne Grunau
	<j@jannau.net>, Suzuki K Poulose <suzuki.poulose@arm.com>, James Clark
	<james.clark@linaro.org>
Subject: Re: [PATCH v2 13/25] genirq: Factor-in percpu irqaction creation
Message-ID: <20250916171259.000070d2@huawei.com>
In-Reply-To: <20250915085702.519996-14-maz@kernel.org>
References: <20250915085702.519996-1-maz@kernel.org>
	<20250915085702.519996-14-maz@kernel.org>
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
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 15 Sep 2025 09:56:50 +0100
Marc Zyngier <maz@kernel.org> wrote:

> Move the code creating a per-cpu irqaction into its own helper, so that
> future changes to this code can be kept localised.
> 
> At the same time, fix the documentation which appears to say the wrong
> thing when it comes to interrupts being automatically enabled
> (percpu_devid interrupts never are).
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

