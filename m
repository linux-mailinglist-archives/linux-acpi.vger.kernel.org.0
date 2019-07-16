Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 537726A729
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jul 2019 13:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387553AbfGPLQb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Jul 2019 07:16:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733200AbfGPLQa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 16 Jul 2019 07:16:30 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 914DA2173B;
        Tue, 16 Jul 2019 11:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563275789;
        bh=cN2YWLRC4s7HqVcjkwb1qbS93xC53QlrYyzApl46WQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fN2ZJSMKqcmdmKc0QGJ3lMxe98jrFW3RcAvT1o8V3Zx6VySokBYxZyqlAJHyVHMTr
         P4h8cQBkE2b7uR2KHP5b/MA7uto9Mm/CRyNivfEx+3f6kMERI8JSzOkGe3oU/SC7pE
         6CA3s19YptajttSQaXKI1OvrCZj7xRo6mrsVrKTM=
Date:   Tue, 16 Jul 2019 07:16:28 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Sinan Kaya <Okaya@kernel.org>
Cc:     marc.zyngier@arm.com, will.deacon@arm.com, julien.thierry@arm.com,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linux-kernel@microsoft.com, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@kernel.org
Subject: Re: [PATCH] ARM64/irqchip: Make ACPI_IORT depend on PCI again
Message-ID: <20190716111628.GB1943@sasha-vm>
References: <20190716040441.12101-1-sashal@kernel.org>
 <a688793b-f7e8-18a4-3eb2-877f1522d8f3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a688793b-f7e8-18a4-3eb2-877f1522d8f3@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jul 16, 2019 at 12:13:23AM -0400, Sinan Kaya wrote:
>On 7/16/2019 12:04 AM, Sasha Levin wrote:
>> ACPI_IORT lost it's explicit dependency on PCI in c6bb8f89fa6df
>> ("ARM64/irqchip: Update ACPI_IORT symbol selection logic") where the
>> author has relied on the general dependency of ACPI on PCI.
>>
>> However, that dependency was finally removed in 5d32a66541c4 ("PCI/ACPI:
>> Allow ACPI to be built without CONFIG_PCI set") and now ACPI_IORT breaks
>> when we try and build it without PCI support.
>>
>> This patch brings back the explicit dependency of ACPI_IORT on PCI.
>>
>> Fixes: 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
>> Cc: stable@kernel.org
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>Do you have more detail on what really is broken without this patch?
>
>It should be possible to build IORT table without PCI.

For the record, the errors look like this:

	drivers/acpi/arm64/iort.o: In function `acpi_iort_init':
	iort.c:(.init.text+0x47c): undefined reference to `pci_request_acs'

Sinan pointed me to an earlier patch he wrote that would fix it
(https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/acpi/arm64/iort.c?id=43554cebba50e709b9207c55ceca6bc281748586).

Please disregard this patch.

--
Thanks,
Sasha
