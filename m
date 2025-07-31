Return-Path: <linux-acpi+bounces-15448-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE103B1721A
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Jul 2025 15:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66F68188B635
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Jul 2025 13:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63CB2C08DF;
	Thu, 31 Jul 2025 13:33:53 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA71223719
	for <linux-acpi@vger.kernel.org>; Thu, 31 Jul 2025 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753968833; cv=none; b=HckAv95vxnUKS4T4Rcy3h6Vq7TtwFWR6E5Nxflva/ZSxTLTx4pnYdEvoIMoHN0x91pBbV1n4ZIh1gCjxvNvJUrOZNM5xwhzB2ikFdGAjumTZ9A8LRNZ13NSSxBZmmwjOX5I+6V42hj8fqhzT+FjL4Tn5TaDy2e5YINX80/S01Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753968833; c=relaxed/simple;
	bh=TCBYcGux1ZrwgIlapWivHM3uIpSvPLbks0AXZicIV2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Id2OBHjo742norkIoI+TgXw/tXOkr5N9/UpcD8NbkrvAHn64GXxI5jgUIDuLVepSxp69VQrdV1FAMFchxncpHHq/vlwe7G0mp0Kp3Sr9KlTRnzQPT8Ktlhy8GAnyXd+tektLgxORXO5JVvGNL1j1CZIpUCQ/te+bK5tjgEUBJf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id D26FF5854F0;
	Thu, 31 Jul 2025 13:13:35 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 510B4443F0;
	Thu, 31 Jul 2025 13:13:25 +0000 (UTC)
Message-ID: <84a22949-88e7-4a6c-b14e-e8448724b034@ghiti.fr>
Date: Thu, 31 Jul 2025 15:13:24 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ACPI: support BGRT table on RISC-V
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, kernel@vger.kernel.org,
 Yunhui Cui <cuiyunhui@bytedance.com>, linux-acpi@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-riscv@lists.infradead.org,
 Len Brown <lenb@kernel.org>
References: <20250729131535.522205-1-heinrich.schuchardt@canonical.com>
 <20250729131535.522205-3-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250729131535.522205-3-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddtledtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpedthfelfeejgeehveegleejleelgfevhfekieffkeeujeetfedvvefhledvgeegieenucfkphepvdgrtdegmegtvggttdemuddtjeefmegslegsgeemjegvtgekmeehhegutdemgehfvddvmeeigedvkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtgeemtggvtgdtmedutdejfeemsgelsgegmeejvggtkeemheehugdtmeegfhdvvdemieegvdekpdhhvghloheplgfkrfggieemvdgrtdegmegtvggttdemuddtjeefmegslegsgeemjegvtgekmeehhegutdemgehfvddvmeeigedvkegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepudefpdhrtghpthhtohephhgvihhnrhhitghhrdhstghhuhgthhgrrhguthestggrnhhonhhitggrlhdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopehprghulhdrfigrl
 hhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtoheprhihrghnrdhrohgsvghrthhssegrrhhmrdgtohhmpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtrghtrghlihhnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhrtghpthhtohepkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: alex@ghiti.fr

Hi Heinrich,

On 7/29/25 15:15, Heinrich Schuchardt wrote:
> The BGRT table is used to display a vendor logo in the boot process.
> There is no good reason why RISC-V should not support it.
>
> Remove the architecture constraint.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>   drivers/acpi/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 7bc40c2735ac0..2b83c91bb1a78 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -460,7 +460,7 @@ config ACPI_HED
>   
>   config ACPI_BGRT
>   	bool "Boottime Graphics Resource Table support"
> -	depends on EFI && (X86 || ARM64 || LOONGARCH)
> +	depends on EFI
>   	help
>   	  This driver adds support for exposing the ACPI Boottime Graphics
>   	  Resource Table, which allows the operating system to obtain


@Rafael: If you ack this patch, I can merge that for 6.17 as I haven't 
sent my PR yet, just let me know!

Thanks,

Alex


