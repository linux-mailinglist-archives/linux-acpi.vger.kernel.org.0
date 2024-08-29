Return-Path: <linux-acpi+bounces-7969-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5EF964B79
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 18:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6DC1B27D67
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 16:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A66F1B5337;
	Thu, 29 Aug 2024 16:17:51 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765691922FE;
	Thu, 29 Aug 2024 16:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948271; cv=none; b=Vf6DziHk4qX7Cmxq3bduxAaJXlMXJclZWi8AVd5VoB3MorO8I7KArN+RWcedA1jhd2d0Q9wN/eqrV2Y41d2zBkpCWrmgkGJcflVgvGdKW9MsOm/XD9quzteqV7v5Ahnu4wAF5yMvGxj+2grFdabDO6+8JO4ZpzGcGosKqrWL4gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948271; c=relaxed/simple;
	bh=jjnFKvczBENKiZiDjjEQLKForEKb+4c2ND9lOv0yeHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GY1U1v+haN2QbA0C1lRMFrA2hqSlP0JJbVW2QvURt+35sTkDe8cbmQfdgNfZ900tFaC7De6xDoZqxu2cK16UtSfaRfvLuLb0ftmbrWOBtNLsDYXY928IjPRcXcI7TywK8K/n4dQLVFtQnLLy5V+6b2YEi6UdpMUFBQGfr1bNjnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E2DEDA7;
	Thu, 29 Aug 2024 09:18:14 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.198.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3ED83F762;
	Thu, 29 Aug 2024 09:17:46 -0700 (PDT)
Date: Thu, 29 Aug 2024 17:17:44 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Fu Wei <fu.wei@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	<linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: Re: [PATCH] acpi/arm64: Adjust error handling procedure in
 gtdt_parse_timer_block()
Message-ID: <ZtCfKEIfJW7X8UWg@bogus>
References: <20240827101239.22020-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240827101239.22020-1-amishin@t-argos.ru>

On Tue, Aug 27, 2024 at 01:12:39PM +0300, Aleksandr Mishin wrote:
> In case of error in gtdt_parse_timer_block() invalid 'gtdt_frame'
> will be used in 'do {} while (i-- >= 0 && gtdt_frame--);' statement block
> because do{} block will be executed even if 'i == 0'.
> 
> Adjust error handling procedure by replacing 'i-- >= 0' with 'i-- > 0'.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>

(For some reason I don't see the original email in my inbox, might have
got blocked 🙁). Anyways LGTM,

Acked-by: Aleksandr Mishin <amishin@t-argos.ru>

-- 
Regards,
Sudeep

