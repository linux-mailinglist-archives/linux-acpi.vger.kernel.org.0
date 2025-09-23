Return-Path: <linux-acpi+bounces-17226-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0102B959B2
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Sep 2025 13:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2809544622A
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Sep 2025 11:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D3B32144A;
	Tue, 23 Sep 2025 11:17:33 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2034321290;
	Tue, 23 Sep 2025 11:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626253; cv=none; b=e++Cynyx1rmRWI0Skq1ja2zEongw49IE07xvvFmYL0jRwA5mC7QXzpQ5uT3fr59QJM7W2jayQImIHxqnOvGF5ENSSFKmf+b/Fa/qN8DDCSvJ044MKCWmaHkSaAk1mK3tPFnzfAEAAFDuUVerkJo4br7iAGDkG88v3Oc2rBamxes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626253; c=relaxed/simple;
	bh=ceh1tWVSLZfLNc2Nygj2F1jFgZ011ILHPflx2Pn+gDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pD24EoKLEHJYeczTxWRAf3CY/dKCxija/9CXASFWdp6NUE9NSnhxH1XnJ9+6EN1NQIGiAeTCSxCh0/IGcTi6I4uS8EWM4ObkdxOyUo4bU/7Fuivl/VfSvnjIAUh4xwt7pv7+4/Pvgn20qnskLRV3tYXb3IGIHoKFXrOyNx41nlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8576497;
	Tue, 23 Sep 2025 04:17:22 -0700 (PDT)
Received: from [10.57.6.128] (unknown [10.57.6.128])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59E223F66E;
	Tue, 23 Sep 2025 04:17:28 -0700 (PDT)
Message-ID: <0339c5cc-20e7-4bfd-829f-6fc91f2c1669@arm.com>
Date: Tue, 23 Sep 2025 12:17:26 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/26] coresight: trbe: Convert to new IRQ affinity
 retrieval API
Content-Language: en-GB
To: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Mark Rutland
 <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sven Peter
 <sven@kernel.org>, Janne Grunau <j@jannau.net>,
 James Clark <james.clark@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20250922082833.2038905-1-maz@kernel.org>
 <20250922082833.2038905-8-maz@kernel.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250922082833.2038905-8-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/09/2025 09:28, Marc Zyngier wrote:
> Now that the relevant interrupt controllers are equipped with
> a callback returning the affinity of per-CPU interrupts, switch
> the TRBE driver over to this new method.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>


