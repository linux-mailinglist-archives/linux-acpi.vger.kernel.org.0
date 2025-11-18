Return-Path: <linux-acpi+bounces-19015-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1BFC6913C
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 12:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 886B22AC71
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 11:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA6C355030;
	Tue, 18 Nov 2025 11:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="d0f+4Mns"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449553546F6;
	Tue, 18 Nov 2025 11:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763465321; cv=none; b=koQWNQp7fE2p8VnKxXXgK6/QljPzNxDLHXWI72sca3dyz+KzPKro4JtBi3WW/s/q6q6HGZ/VmQJ46mr9AfN7bi4BgyEI+fP3z0dfCA6Q1CoDXeukJWGpY9MCeAJgggyOSxmI2+tBlbEm1yoN668U4gxyYHhbefoc7+6FHrZOSec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763465321; c=relaxed/simple;
	bh=+ggvSAejC7jefX6QdGQ66QmABVyX1r24+2xcLvocJIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jyzq7wagGMbleur/FDgwAPALgY4bNGyN+kxDoAbi4t1S64GddQu1FoTpC7UULmZhNx+LSh1l+DbY5Mrhr159tFAW+NbAl0X6xqV/UfDeCP0NQkDcdjBBfhsh4B/sxPtJsws7wNiBiQm1j2c/68hTgnBhTMukaO4w0NGaZMEu1yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=d0f+4Mns; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1763465297; x=1764070097; i=markus.elfring@web.de;
	bh=+ggvSAejC7jefX6QdGQ66QmABVyX1r24+2xcLvocJIY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=d0f+4MnsryNGR0lmzmXKJRIVMt2X8YTmUWN4xE8GerFH0rxOaFfQEHPP1/7XYXMl
	 WFmST2IMSx2YRdgixOapxc1/fsJiE/e0fNZgXu+I5PMLt0qjHAU8O/T3RBYIt2Fpq
	 Gb4HmiE6mBcutwEFPnxFhFYaiKCL9zi5YqzSi2jd40NJcErk7llBFKwsGopoxuD/J
	 GI/UC1QHcfDHe9yhIUEuNqaArkVzUegr7LQwZTqrVmOvlogTkBsJYqejxU7IGR+V+
	 SB+O6dXVpOiSFerXiZ96okFo8ZvMdhjHP5LIe/5irWJBfmyDqLTqjEptTFeRnsbTc
	 cwDMJKQqQzBJRFF3Hw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.234]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N6Jxd-1wEfaz3n1F-00ruEN; Tue, 18
 Nov 2025 12:28:17 +0100
Message-ID: <a567c3f9-f4b2-44bd-ad3c-326a1fd7bdd5@web.de>
Date: Tue, 18 Nov 2025 12:28:09 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 10/34] arm_mpam: Add probe/remove for mpam msc driver and
 kbuild boiler plate
To: Ben Horgan <ben.horgan@arm.com>, James Morse <james.morse@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Baisheng Gao <baisheng.gao@unisoc.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Carl Worth <carl@os.amperecomputing.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 D Scott Phillips <scott@os.amperecomputing.com>,
 Danilo Krummrich <dakr@kernel.org>, Dave Martin <Dave.Martin@arm.com>,
 David Hildenbrand <david@redhat.com>, Drew Fustini <dfustini@baylibre.com>,
 Fenghua Yu <fenghuay@nvidia.com>, Gavin Shan <gshan@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hanjun Guo <guohanjun@huawei.com>, Jamie Iles <quic_jiles@quicinc.com>,
 Jeremy Linton <jeremy.linton@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Koba Ko <kobak@nvidia.com>,
 Len Brown <lenb@kernel.org>, Linu Cherian <lcherian@marvell.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Peter Newman <peternewman@google.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 Rohit Mathew <rohit.mathew@arm.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Shaopeng Tan <tan.shaopeng@fujitsu.com>, Sudeep Holla
 <sudeep.holla@arm.com>, Wang ShaoBo <bobo.shaobowang@huawei.com>,
 Will Deacon <will@kernel.org>, Xin Hao <xhao@linux.alibaba.com>,
 Zeng Heng <zengheng4@huawei.com>
References: <20251117170014.4113754-11-ben.horgan@arm.com>
 <a5306f5a-92b0-437d-b384-40863fbed6d8@web.de>
 <3d2b7980-db26-423f-9525-5d18eade8344@arm.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <3d2b7980-db26-423f-9525-5d18eade8344@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rygVljDGVVqtgA8x3usHvjs2LHnOLGLDdQ2fnUBW7xet98i6OiQ
 yY6hi6v09g6NiumlXOXePB+J+1YWvV9dDAzqtsAgzjeHg452auvK/7sHuIAFeE5tkTlkOTe
 N+Q7moHBDupEp7OoKpZ+dJXrPxA5NJpWn6vJUVteyJWGseDINyn6u6z/gYlyk0LhT5DN+5X
 i7luKXo7PnRi8kewUCztg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UinZgRhNFPQ=;XRnzin1zFVcRYoR3ih1PyBebjYy
 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

>> Does anything hinder you to integrate statements like =E2=80=9Cguard(mu=
tex)(&mpam_list_lock);=E2=80=9D here?
>> https://elixir.bootlin.com/linux/v6.18-rc6/source/include/linux/mutex.h=
#L228
>=20
> The mpam_list_lock needs to be dropped before the end of the scope as it
> is also taken in mpam_msc_drv_remove().

Would you eventually prefer to use scoped_guard() calls at any more source=
 code places?
https://elixir.bootlin.com/linux/v6.18-rc6/source/include/linux/cleanup.h#=
L316-L319

Regards,
Markus

