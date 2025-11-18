Return-Path: <linux-acpi+bounces-19000-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F542C680A4
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 08:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id EC2EA2A36C
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 07:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE42292938;
	Tue, 18 Nov 2025 07:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="0Ulmbrwf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965682773C3;
	Tue, 18 Nov 2025 07:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763451969; cv=none; b=qQM4kfecouVVgD7YSZdzNAExwr8UA40izx8o0UdC02BzzOh3+RLi//83vD3qr/AaVaO9waue/tFjYXlPG75/vw981A3HpYcMLPh+2TupcNCqQN7zWX2RpTVB2OQhzEg5qX8d9RjOLQ0YzS4FAypCV/GLKojnapWSdEFve12P84c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763451969; c=relaxed/simple;
	bh=ZEuzorQQ3pw82G8dEEzbvyg/olGISYGz0PvuUR64dOk=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FhHlWwt7cXL1Ji4Q+3SHg/r+0tz8JwBgel3D0nDYYkecGXaNjoleFejjxszl5WEqV/7UrC/Hv8T6gWrAg7ITZsgTCal7uyKa4LVfucz+rtfmqDE6FCNhbsEQSG8Qw0Hf4KOcaFKeHNUQ0Johu42zMUhJnjF66MQCnSNu/b91UtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=0Ulmbrwf; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=N2fsmjCyj5PlsmRzsHsyA47rqLxKpcCRyXd+Ba8Kin4=;
	b=0UlmbrwfWMXWMvaFTkci861M3lDtpKiJH0DpEM/3cfC9dQmyppm8t+Gy6VCWODuUMaJiZb1N1
	j6JLkgf0oiE97iQEWYQSGtT7obMuPNISKgYw/MrTQc8FmCjxQ/MnzSh+DTLGV1UqdkbKMbR07fk
	ID/A+iFBCntRUDxy9F3wR24=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4d9c7l13dhzRhTc;
	Tue, 18 Nov 2025 15:44:19 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id D7629140142;
	Tue, 18 Nov 2025 15:46:01 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Nov 2025 15:45:59 +0800
Subject: Re: [PATCH v5 00/34] arm_mpam: Add basic mpam driver
To: Ben Horgan <ben.horgan@arm.com>, <james.morse@arm.com>
CC: <amitsinght@marvell.com>, <baisheng.gao@unisoc.com>,
	<baolin.wang@linux.alibaba.com>, <bobo.shaobowang@huawei.com>,
	<carl@os.amperecomputing.com>, <catalin.marinas@arm.com>, <dakr@kernel.org>,
	<dave.martin@arm.com>, <david@redhat.com>, <dfustini@baylibre.com>,
	<fenghuay@nvidia.com>, <gregkh@linuxfoundation.org>, <gshan@redhat.com>,
	<jeremy.linton@arm.com>, <jonathan.cameron@huawei.com>, <kobak@nvidia.com>,
	<lcherian@marvell.com>, <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lpieralisi@kernel.org>, <peternewman@google.com>, <quic_jiles@quicinc.com>,
	<rafael@kernel.org>, <robh@kernel.org>, <rohit.mathew@arm.com>,
	<scott@os.amperecomputing.com>, <sdonthineni@nvidia.com>,
	<sudeep.holla@arm.com>, <tan.shaopeng@fujitsu.com>, <will@kernel.org>,
	<xhao@linux.alibaba.com>
References: <20251117170014.4113754-1-ben.horgan@arm.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <4b4cdb73-21f5-0e21-0f31-520caaaff715@huawei.com>
Date: Tue, 18 Nov 2025 15:45:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251117170014.4113754-1-ben.horgan@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/11/18 0:59, Ben Horgan wrote:
> Hi all,
> 
> Not much substantial changed in this iteration. Some rework relating to
> acpi_pptt_cache and a related proposed fix in acpica. Lots of little tidy ups
> here and there.
> 
> Thanks for all the reviews and testing so far. As I mentioned before, it would be
> great to get this taken up quickly. There are lots more patches to come before
> we have a working MPAM story and this driver is hidden behind the expert
> config. See patches for changelogs and below for branches.

Tested on ARM64 Kunpeng server with MPAM devices test suite, works
as expected.

Tested-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun

