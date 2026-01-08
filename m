Return-Path: <linux-acpi+bounces-20045-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02ED5D02E1E
	for <lists+linux-acpi@lfdr.de>; Thu, 08 Jan 2026 14:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 734F5308B724
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jan 2026 12:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCE53D3D17;
	Thu,  8 Jan 2026 09:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="kXCcqa1a"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53563D3D04;
	Thu,  8 Jan 2026 09:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767865629; cv=none; b=uj1A1OMmn2wNPrNUUHmf1LMTa/t2VXnpQ0jfHGNWCPccLNY+M6pfTsCOpJq5zMCu7M5n2mlZPyu8dUsl61aN+Kg8FxQ+rhXpKb5Ic+v9iXIwLcXPVRv26+Y2KknmcroxggqdLK2MsTsE/opvRS2Chu+PY1Ka73iuJmsi9jnodto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767865629; c=relaxed/simple;
	bh=MMAEjVJ1nuvpkBkKFxIeYnp0JLeVOcAcNiBh5oHkviY=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Poq8JzrB53WPF9M3AnKBuRm0fwHFZw5KCdeqa2pCqGk4AQYuu1lMCyLBnjRU7HcGj/55JNZCRG+TWiPN5DFyXqLwdrHvN7fojTYpcY/0OekN4Hj0sGPjGwPNT90cqYoE0grKYXLIxcbLFNDc92R0IkQ2jo62AXJr44XctkiodWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=kXCcqa1a; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=zLV/N1gRfyoSdsigI63286V9LuEqtSqemwzMJs1gXA0=;
	b=kXCcqa1aHctqT4euMXdIU0ORE41iPNxE1HNSVDkNSCv/pJpgWKNBxIJ34Md/7DjKifQcmA4XL
	lveQxHh/SeqzLeYynesfQtI8Jb5bGnGU/HTlXbbTzWf6LZWKvHTiUdZiYmB/cMuVEkfE3iTjokf
	UcAGgsZLyiV9AA+YlP8Jrqc=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dn0My53wCzLlXJ;
	Thu,  8 Jan 2026 17:43:42 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 135A8402AB;
	Thu,  8 Jan 2026 17:46:58 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 8 Jan 2026 17:46:57 +0800
Subject: Re: [PATCH v6] ACPI: AGDI: Add interrupt signaling mode support
To: Kazuhiro Abe <fj1078ii@aa.jp.fujitsu.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Will Deacon <will@kernel.org>, Sudeep Holla
	<sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, Catalin
 Marinas <catalin.marinas@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Koichi Okuno <fj2767dz@aa.jp.fujitsu.com>
References: <20260108075636.524722-1-fj1078ii@aa.jp.fujitsu.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <fc3fec3c-651a-f64e-e62a-3a49c2d22c9d@huawei.com>
Date: Thu, 8 Jan 2026 17:46:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260108075636.524722-1-fj1078ii@aa.jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2026/1/8 15:56, Kazuhiro Abe wrote:
> AGDI has two types of signaling modes: SDEI and interrupt.
> Currently, the AGDI driver only supports SDEI.
> Therefore, add support for interrupt signaling mode.
> The interrupt vector is retrieved from the AGDI table, and call panic
> function when an interrupt occurs.
> 
> Acked-by: Hanjun Guo <guohanjun@huawei.com>
> Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> Signed-off-by: Kazuhiro Abe <fj1078ii@aa.jp.fujitsu.com>
> 
> ---
> This patch (v6) has been rebased to align with the 6.19-rc4 release.
> There are no functional changes since v4.
> It has been tested and confirmed to work without issues.
> Please let us know if you have any questions or concerns.
> Thank you, Will, for taking care of the mistake in v5.
> 
> v5->v6
>   - Rebase to 6.19-rc4.
>   - Correct the mistake in v5.

Take a review again, and the mistake is gone.

Thanks
Hanjun

