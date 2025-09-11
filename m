Return-Path: <linux-acpi+bounces-16689-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9A9B53953
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 18:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD293A2593
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 16:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF27E322536;
	Thu, 11 Sep 2025 16:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="HhPoqF0l"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370DB329F05;
	Thu, 11 Sep 2025 16:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757608317; cv=none; b=CLQyVef4BgT7zCwbI/n/aQv2Y8mLbE8PtZVKCPvQjZZ1AXhzgziHJBqpppCDA1fUsVkSD1DdlQM4w1hBiWIHXhuGoDyiGnYd5Qy0ZiY6SA3P7y3EeN2LJ6Yqi/CAsCL568e9lE9rev2FUtMWnaAn7EDiXXAPqZHHiCgLe9CXb5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757608317; c=relaxed/simple;
	bh=kJMKOcM64Wbxh2cL0OAks+/FwxmS44I1i+3WVc+xfo8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Gji241pMg65iz5GYnX/mNogWn2pNZc/zK3JxK1DSi5R+/o47ADI1nhiVdos9HoAfAc435ecQTpKNikYm2bW5hjuGMxTP/smBTm4rrtJVq2j4jkKihIwp2x8A7bTlLU4N/Nhlokic6zxpitqhXURIXuDrtmnhh7ftmgXqe34m6gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=HhPoqF0l; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757608267; x=1758213067; i=markus.elfring@web.de;
	bh=Dz8R7dtejEqkQKX6bHmLWbcVWZv/E+BPhgwcdwOzGTI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HhPoqF0lk4fiVCKrEWCaNv3U0y4e647ts5mDYudJJ2IBzuFVWF7N7nHxTXxYBayU
	 xRsu2fuA2o9CGMhw7WzsujmrE6BiVDq4mKXtKuhcioHsxrgOanjaNhh/Mr5DCL0sn
	 07Dfye62XU7tYFFu69gBdt7yec6EbFF1eDwwb+BtWALHm14tlT9YsQ7IsKNfld6PT
	 EFhe0d7ji8XAv1a8L2SldO6RfsAch3NIEra71gUx28TNHuT4ZMHv1G+uiOmXUun2d
	 hgO5Z2Dms1mnFuLA9fKxPsimu+DkV6mfAk+kh/tGM7HclHvhCGSls4FlGN2B/XnIe
	 Agvyh4cH7xqqzL6iNQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.247]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUU68-1unqEU3geW-00IHKV; Thu, 11
 Sep 2025 18:31:07 +0200
Message-ID: <5a80cb91-6095-4f44-b576-53badc4575f5@web.de>
Date: Thu, 11 Sep 2025 18:30:57 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: James Morse <james.morse@arm.com>, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Baisheng Gao <baisheng.gao@unisoc.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Ben Horgan
 <ben.horgan@arm.com>, Carl Worth <carl@os.amperecomputing.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 D Scott Phillips <scott@os.amperecomputing.com>,
 Danilo Krummrich <dakr@kernel.org>, Dave Martin <Dave.Martin@arm.com>,
 David Hildenbrand <david@redhat.com>, Drew Fustini <dfustini@baylibre.com>,
 Fenghua Yu <fenghuay@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hanjun Guo <guohanjun@huawei.com>, Jamie Iles <quic_jiles@quicinc.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Koba Ko <kobak@nvidia.com>,
 Len Brown <lenb@kernel.org>, Linu Cherian <lcherian@marvell.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Peter Newman <peternewman@google.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 Rohit Mathew <rohit.mathew@arm.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Sudeep Holla <sudeep.holla@arm.com>, Shaopeng Tan
 <tan.shaopeng@fujitsu.com>, Wang ShaoBo <bobo.shaobowang@huawei.com>,
 Will Deacon <will@kernel.org>, Xin Hao <xhao@linux.alibaba.com>
References: <20250910204309.20751-9-james.morse@arm.com>
Subject: Re: [PATCH v2 08/29] arm_mpam: Add the class and component structures
 for firmware described ris
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250910204309.20751-9-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aXo+jzHYTT7qDJctek+y3Ta/pop7BCbIYZ9toJqeO0SvaQ3Lhvh
 pY+hU0t3B7Gzx/G43YaOOz0zHj0IFIK9AGktiapQhGBXUsyIY6WN+AEPmOE8t2kxHZj1w0M
 o6N9KwDHUFG2YSe8IRHOl2mOey/UNXt6xsXMeSf9RhapdzTjSrdJhl7QiYVKU+5AhXzgCNm
 9Xc/9dE3S/Ui2/SS7Qsow==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:b4fPkTA0T3M=;JLLaSxtMBxjJufgrQb08zEQUw6g
 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
 FvTfNJhrUnkbpDhmzLL+BVEVyZWD+wtmyBR4x

=E2=80=A6
> +++ b/drivers/resctrl/mpam_devices.c
=E2=80=A6
> > +int mpam_ris_create(struct mpam_msc *msc, u8 ris_idx,
> +		    enum mpam_class_types type, u8 class_id, int component_id)
> +{
> +	int err;
> +
> +	mutex_lock(&mpam_list_lock);
> +	err =3D mpam_ris_create_locked(msc, ris_idx, type, class_id,
> +				     component_id);
> +	mutex_unlock(&mpam_list_lock);
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(mutex)(&mpam_list_lock);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.17-rc5/source/include/linux/mutex.h#L2=
28

Regards,
Markus

