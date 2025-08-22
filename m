Return-Path: <linux-acpi+bounces-15982-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2EEB322AD
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 21:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEC8C5E82C2
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 19:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AC32248B3;
	Fri, 22 Aug 2025 19:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="PDJbRQMz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2F42C15B7;
	Fri, 22 Aug 2025 19:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755890141; cv=none; b=GRBuctWEnNjnDlok1JGpYJoru1QJsIgsH9VRFSwtZsH0qgmXuJKdTXWrP2Q130If4ZYTB8R6KW7XYOeqHeD/whcLaeNMI9rz1RqVbA/3PqDS9UFh+w+z2GxkeeKGAgZbvfXSmKN8T793w95zpnTM1/82JvAqeTdb5efeQ3cv5HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755890141; c=relaxed/simple;
	bh=uxpeiAazDI0f8ao/OxEu/KeyUxZ/SOb6X6qF1C4FJW0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=nFjM+KkSegCbz6SnjlfFcEQ6WwylkQQhS+NGKzgWL0qRI0tppFg+Fu7OEzT6k4ykF9v6693g1dePw+C1jeX/O94e1+zqaEsV4BMMhrMuKVTWFsIk7M7xv8RvHvRoxNjAGcKoEFQgym3BO8BgkC5jSjLad1qYwwEZAihgHllfj7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=PDJbRQMz; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1755890123; x=1756494923; i=markus.elfring@web.de;
	bh=Rnl52sZYdBbgsSvrkBq1CTK28EFsPK8j5FtHrpp2EFY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PDJbRQMzQlbabzd/BNKASE7EPgTj7wAHr8J5gOihO/sEuitGuZLID5hWb2fPi32t
	 Xt+hf+t2t7EXXJfsEZmFZKnO3x6LH8Ah3T6X3H6KmJ+bLluTtrmcwRp+9zB954mk2
	 TcF6GfMAUardbmFnA5ZZ2xSxrmuDUHcxIL6Lacn7hcWgv8vWRXXxJixQk8c/EAVsu
	 4SWgYID5m2dPh45EPyHyoMnvOcDiSBm0i4eXJhCA+4Njjol/64FbkYD/pVzw4VZNO
	 gWDR7j1ZjOJl0hCKJ82NDzXqPgmEJqaAHVehgQvGibQBZZl8REc7I78jjfS7bcCA8
	 CK+YCmm4bZ1NJweUjg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.186]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mvslx-1uZewO00md-00sDYF; Fri, 22
 Aug 2025 21:15:23 +0200
Message-ID: <3942e5f8-7497-4d23-90e2-1b2db49a48c2@web.de>
Date: Fri, 22 Aug 2025 21:15:12 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: James Morse <james.morse@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Baisheng Gao <baisheng.gao@unisoc.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, bobo.shaobowang@huawei.com,
 Carl Worth <carl@os.amperecomputing.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley
 <conor+dt@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Dave Martin <Dave.Martin@arm.com>, David Hildenbrand <david@redhat.com>,
 Drew Fustini <dfustini@baylibre.com>,
 D Scott Phillips <scott@os.amperecomputing.com>,
 Fenghua Yu <fenghuay@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hanjun Guo <guohanjun@huawei.com>, Jamie Iles <quic_jiles@quicinc.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Koba Ko <kobak@nvidia.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Len Brown <lenb@kernel.org>,
 Linu Cherian <lcherian@marvell.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Peter Newman <peternewman@google.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rex Nie <rex.nie@jaguarmicro.com>,
 Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Shaopeng Tan <tan.shaopeng@fujitsu.com>, Sudeep Holla
 <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>,
 Xin Hao <xhao@linux.alibaba.com>
References: <20250822153048.2287-11-james.morse@arm.com>
Subject: Re: [PATCH 10/33] arm_mpam: Add probe/remove for mpam msc driver and
 kbuild boiler plate
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250822153048.2287-11-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hoQ3uAImWH8VSgZ1RgWRxu2FqA3GXrx/YAXCnvTINJsQBzX+JDo
 CogsL3gWSVlBmkbrYadrhTp+h2YWcwQ2n5MvZqRnk4D5zYq0bdngm6/lTvl84By/zSGD/iO
 cySshlCmtHzEIlc8vwW/uedsvjUenxD74JI/2xW2jqOnF7greHbNZy8KF7sGlbYxJzTaYj0
 Neqq1wgVF73gHmEqx0OJA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tN6MdJ/xjG4=;+DWRRy4UfjdRNZlWo1G3Y0/zMgG
 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
 Zv9OpY+4OVoTVgXg3a2Ca+DS/XNF

=E2=80=A6
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -0,0 +1,336 @@
=E2=80=A6
> +static void mpam_msc_drv_remove(struct platform_device *pdev)
> +{
=E2=80=A6
> +	mutex_lock(&mpam_list_lock);
> +	mpam_num_msc--;
=E2=80=A6
> +	devm_kfree(&pdev->dev, msc);
> +	mutex_unlock(&mpam_list_lock);
> +}
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(mutex)(&mpam_list_lock);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.17-rc2/source/include/linux/mutex.h#L2=
28

Regards,
Markus

