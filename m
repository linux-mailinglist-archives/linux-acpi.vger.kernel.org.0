Return-Path: <linux-acpi+bounces-17024-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C63DAB59C47
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 17:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4948B7B5597
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 15:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AA435AAA5;
	Tue, 16 Sep 2025 15:38:44 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE0F22689C;
	Tue, 16 Sep 2025 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758037124; cv=none; b=sablU0iargURazhOlFJa4OeUnfMs/w4SMXGl20POtAIaes1SjZPIChAwpfyAuvJ8JymEzMrcTLu6Gfust0JVfoDdXAP7axaghAvO0ld5BM5qEot+ZRDq15REcE6h/9vHdltdsWf04d+pNsYMuoas61jqYrxMTFqR53L57U8mJUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758037124; c=relaxed/simple;
	bh=olLEWoU8xXNIWQksINaCPJN3u78iS+CoZuFDPinOIn8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YP6aK38XLoZ/HInTQdSsQweMRqSXV3mOoyPRtl8TDfvASQxJxzeKBt+tLqgwFwlcqocGlM0ZpPy+SdJQ+fT31KSf6NlHYbsG4DWmfpzR+tUbTbe1HbKx1ngMRTFvfi0QiI4TD4Sz+XQV3myKbPem+XNcBfwfE4ZaTEofBOob/jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cR5Zx1tSCz6K9Kp;
	Tue, 16 Sep 2025 23:35:53 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 864E9140517;
	Tue, 16 Sep 2025 23:38:40 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 16 Sep
 2025 17:38:39 +0200
Date: Tue, 16 Sep 2025 16:38:38 +0100
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
Subject: Re: [PATCH v2 11/25] genirq: Kill handle_percpu_devid_fasteoi_nmi()
Message-ID: <20250916163838.00003791@huawei.com>
In-Reply-To: <20250915085702.519996-12-maz@kernel.org>
References: <20250915085702.519996-1-maz@kernel.org>
	<20250915085702.519996-12-maz@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 15 Sep 2025 09:56:48 +0100
Marc Zyngier <maz@kernel.org> wrote:

> There is no in-tree user of this flow handler anymore, so simply
> remove it.
> 
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---

> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 0d0276378c707..869068ec6ac91 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -892,7 +892,8 @@ void handle_percpu_irq(struct irq_desc *desc)
>   *
>   * action->percpu_dev_id is a pointer to percpu variables which
>   * contain the real device id for the cpu on which this handler is
> - * called
> + * called. This is also used for per-CPU NMIs, so special care is
> + * required.

Probably belongs in previous patch as not really related to removing
the unused code, but meh.

>   */


