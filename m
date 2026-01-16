Return-Path: <linux-acpi+bounces-20404-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7B8D329DA
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jan 2026 15:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D695309D9DC
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jan 2026 14:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6E72FFFB8;
	Fri, 16 Jan 2026 14:28:14 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6576D2701DC;
	Fri, 16 Jan 2026 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573694; cv=none; b=qGCZ4qdsP9wBreWwdmC+A7vG8qeBlyslwiwmC/SiT9DQprdNBDepQ0Lwh9RChD1jCWarnUPZRDycOVDV3SZ/03gmQMttsDsgvZat0kaQGKicifD0kDic1Jvmkk3afk/SljoW0iZi2dzP1HWHWKEGchnd92bc0qpdNS5N654PKtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573694; c=relaxed/simple;
	bh=pNhce/7/buAT1zkkwUASoAWgKqm1NwfnOHHMs0XbNl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssAElEop7YjIj2M/dtqbrczPtO1Cz1MWcUwQqE2BzGM7Ju8+bM7iJnhf/K20dRe68dRzbtLPV4HQDEtzSWuD6gOI00H7l7faaT4Fax2ivUNcShX2YCma3kBAxyrMP+v/fgWyWVAJ04tGkksIApVHScwcMqQU/90puP3yIwlH5fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2C641515;
	Fri, 16 Jan 2026 06:28:05 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.197.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C06843F632;
	Fri, 16 Jan 2026 06:28:11 -0800 (PST)
Date: Fri, 16 Jan 2026 14:28:09 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Jassi Brar <jassisinghbrar@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Aishwarya TCV <Aishwarya.TCV@arm.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mailbox: pcc: Remove spurious IRQF_ONESHOT usage
Message-ID: <aWpK-dMK3t0VVqFY@bogus>
References: <20260116-mailbox-pcc-non-threaded-irq-v1-1-916b093329cd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116-mailbox-pcc-non-threaded-irq-v1-1-916b093329cd@kernel.org>

On Fri, Jan 16, 2026 at 02:07:40PM +0000, Mark Brown wrote:
> The PCC code currently specifies IRQF_ONESHOT if the interrupt could
> potentially be shared but doesn't actually use request_threaded_irq() and
> the interrupt handler does not use IRQ_WAKE_THREAD so IRQF_ONESHOT is
> never relevant. Since commit aef30c8d569c ("genirq: Warn about using
> IRQF_ONESHOT without a threaded handler") specifying it has resulted in a
> WARN_ON(), fix this by removing IRQF_ONESHOT.
>

Looking back, can't think of any reason why we retained IRQF_ONESHOT
when we added IRQF_SHARED. Thanks for spotting and fixing it.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

