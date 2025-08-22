Return-Path: <linux-acpi+bounces-15985-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F0FB3233F
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 21:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D768BA0863D
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 19:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F372D6604;
	Fri, 22 Aug 2025 19:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="D1M5WypC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE12299A90;
	Fri, 22 Aug 2025 19:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755892594; cv=none; b=kxn63pp+b/z5j5Fbh4dkyLveHm/dJSGKC7XXUydyG7Nb6kx+qMM8jb+YPCXCpg2/J9U41set4GAT5HoJ6VmjHg1LzpnvauILxL01rwoQAxmtXp563O0AIm6aATlJmARQeJpr3zeCX+cwT+WbqlV2hc2JpPzG/RG6aZU9CMhxFh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755892594; c=relaxed/simple;
	bh=+gGFenl5qbWnej679aGz3jtzF2cagkDfISVUDy5x1Mo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=LK6jYCM8Ty924xTSGHZKAXnEdt9b2lRNr1cZ7gS8NgBndrwqrwENIlwQfwWDb4J63bStXkXpm1+LoLdGnGcaVa/+o5qrrfgwoHwT37kikhrbe8KmTXga5UMm7Bu82Ds/6dLa4ou3Gb8PVO2s8RMzI53IP1xTwXPlUmM0/gcxkZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=D1M5WypC; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1755892541; x=1756497341; i=markus.elfring@web.de;
	bh=LS3Ele/wBJBTio0wE+5jrEKVPysPETrbzOiislodM30=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=D1M5WypCleYHN8jbGmwuNa+9TQKlAtmpwYVCMARqNRl80PimZTX710WbOHkTVPXu
	 RyS8xdysQVKKS+nb7ZJboRc+HP0A9Bvz9dwdfyup+6bAl+xuDqB9oX8KWcNgW8UHX
	 yORL6fTNLTMUNtuo2MClZe0H2UVO7u1/ieWX/M+VrbIesfGIKvabhKqaHkjQKQ8sL
	 MzbY3mFcxj6ziBbd/7Y1h0NvllJlBdGDWuTqaLTkNpWPAXVG3LFObH6rS+kdQR7Br
	 Mx4dm/pjFN1ZB1+A214oRlHDrMBsqzNjkflOP3oHVFZTNr5qriO5TvOVU0A79+lH0
	 8TKLAcITDHexD6Hr4A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.186]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MeUXu-1uHJZR2vVk-00pKUu; Fri, 22
 Aug 2025 21:55:41 +0200
Message-ID: <00053767-352d-4185-8542-687da0fb5e57@web.de>
Date: Fri, 22 Aug 2025 21:55:33 +0200
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
X-Provags-ID: V03:K1:3bnLm6wpwcglDmvDQYBu0YEFbR+NDToz8YzlLOKPNxkeaVnmf8E
 fjM4zfdwb2ljQ6OLbhvVQ6MISpI9++eqoRxEqGME/Vu2lI4hrDgNRsXYJzDuDvRjLgkjKPj
 /p1dhddxhpUWmRlDvx+NICk86QoNhzqEXnbx/uVMI7GCMTvwqXWEo3Arf9SHmsdXgn0+kVP
 ng4dYQgAtgQ8JTIu26FNA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hioVME57Pbc=;EQOv6/5ns07Y/SiEESXYjGK9gC6
 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
 lh3drTIrBGXDrILtYGiWsRRmhBdT

=E2=80=A6
=E2=80=A6
> +static int mpam_msc_drv_probe(struct platform_device *pdev)
> +{
=E2=80=A6
> +	} while (0);
> +	mutex_unlock(&mpam_list_lock);
> +
> +	if (!err) {
> +		/* Create RIS entries described by firmware */
> +		if (!acpi_disabled)
> +			err =3D acpi_mpam_parse_resources(msc, plat_data);
> +		else
> +			err =3D mpam_dt_parse_resources(msc, plat_data);
> +	}
> +
> +	if (!err && fw_num_msc =3D=3D mpam_num_msc)
> +		mpam_discovery_complete();
> +
> +	if (err && msc)
> +		mpam_msc_drv_remove(pdev);
> +
> +	return err;
> +}
=E2=80=A6

* Would you like to integrate anything from the following source code vari=
ant?

	if (!err)
		/* Create RIS entries described by firmware */
		err =3D acpi_disabled
		      ? mpam_dt_parse_resources(msc, plat_data)
		      : acpi_mpam_parse_resources(msc, plat_data);

	if (err) {
		if (msc)
			mpam_msc_drv_remove(pdev);
	} else {
		if (fw_num_msc =3D=3D mpam_num_msc)
			mpam_discovery_complete();
	}

* How do you think about to increase the application of scope-based resour=
ce management
  at further places?


Regards,
Markus

