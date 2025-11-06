Return-Path: <linux-acpi+bounces-18601-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CBCC3CF10
	for <lists+linux-acpi@lfdr.de>; Thu, 06 Nov 2025 18:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9B8D634C9AC
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Nov 2025 17:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A61257829;
	Thu,  6 Nov 2025 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="vJ38XdJm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D881EDA2C;
	Thu,  6 Nov 2025 17:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762451308; cv=none; b=R0kjj6XrJw4VrrhX+jtQgYrPrEmZPKbxvcsT57wmK9ehV+RF9z5aBRgTNHFm8CPj9hOVCKJPiiTsKRyIbOx5/yGHIh9836Jq3DN67pkoZj2Mur03zRcGkDPMPC71MbyO1GJf9FeCuXHmGWAcT13fLr1+PGpTAXNsVl6idaBBZHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762451308; c=relaxed/simple;
	bh=zNSsxgXigWiEAnR4M7no4Rbg/vonQmB0pbgym4dacxg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=OIK7x5aFirk1SHMjXFxUQWrWj+EM0vCyVBkvj3Q2Hm+cKQO0bjhURTDsKGmzjDeQYBjjOMrJIW84QUYPOYiGVfG8EEiEVqac+0Ul4LkOw+JWPCJRYC38Bw2JQ030qRCX8BEY20r0ru6n8+NGRoyWkRgoMBwKup7jx9atsHiRzXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=vJ38XdJm; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762451298; x=1763056098; i=markus.elfring@web.de;
	bh=GYymi4qsQorp87m7QZxxG+uNIq9fdtoa5eZ4GXZu+Wk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=vJ38XdJmEdZHb47PdHPG+LnaL0/68Ikprox+alSUzFVeaJ2yeqFwcti1Gd0gBQWj
	 ZhxoXgz8M32HS2FAU9GH3PC/F/BhiFsp8FtcJvgaJpg2JeoYGsQD9LU1qYPoIPYWY
	 oRCVcsERl5Xv5Zkm0NT6MLJPTCnDxBY0rYPwJxQlLacO7i/JupjzVr6EnJfMhvjrb
	 25QK9XWRnrVFkCR1JtO+2KKk7sb/Ma6SEGSgCa5a8ZUeh58bG4o+ESuSPC7/x3peH
	 gD+4pSj8+m3rQma/5bxDIewPO1XtcKXTB3MRNgyaKmYtCgG/mi8EkVWDKE37mNVdv
	 MrVV66nj5ZPqMSW+4A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.214]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MxpiO-1w9H153dQE-00xlw7; Thu, 06
 Nov 2025 18:48:17 +0100
Message-ID: <63b2c31c-6759-42aa-b54b-08764d88c57a@web.de>
Date: Thu, 6 Nov 2025 18:48:10 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: James Morse <james.morse@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org
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
 Will Deacon <will@kernel.org>, Xin Hao <xhao@linux.alibaba.com>
References: <20251017185645.26604-8-james.morse@arm.com>
Subject: Re: [PATCH v3 07/29] arm_mpam: Add probe/remove for mpam msc driver
 and kbuild boiler plate
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251017185645.26604-8-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2M5NBJTY9qrxZSgRFO7lIxVOhnbvV+6itZHyEdOZHaQwPHvOkUe
 3oNdxjduRlDInYC1LiEePjN2TreXmEhRG7Q5/GeYC5HDHE7Bj/bkX4DmPfLNkkHBQZfHXwk
 tdZhASHHXweKc1gFBAQaxCvefs4WsYdCOG2e/Wj4MEADZSw24UoZ+Oli9+UuwT9abHc/x1Q
 qlTj0RMf/GAXuIpo7IRHg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NsKbs2tULMg=;ZnZ8qq+2ftII2hqQ0M2y0lti+yh
 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

=E2=80=A6
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -0,0 +1,190 @@
=E2=80=A6
> +static void mpam_msc_drv_remove(struct platform_device *pdev)
> +{
=E2=80=A6
> +	mutex_lock(&mpam_list_lock);
> +	mpam_msc_destroy(msc);
> +	mutex_unlock(&mpam_list_lock);
> +
> +	synchronize_srcu(&mpam_srcu);
> +}
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(mutex)(&mpam_list_lock);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.18-rc4/source/include/linux/mutex.h#L2=
28

Regards,
Markus

