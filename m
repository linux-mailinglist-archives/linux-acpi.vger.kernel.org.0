Return-Path: <linux-acpi+bounces-15454-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC445B183F5
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Aug 2025 16:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE7851719B2
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Aug 2025 14:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2683926C386;
	Fri,  1 Aug 2025 14:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="NmO6MXy0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E4424A076;
	Fri,  1 Aug 2025 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754058959; cv=none; b=cGguRZN+H1b8oUfpKCNc5/C9gjDFeFesCWWABtc4nLvUZetp8jLHg8BII0FJFmB/dLUMZm5jHas6l82Gg2p11XIVSdo6YB2vl9MobWodByUm7Dv/t8g2nPfuipp+Bh1rFE87NtVJ6EANW0I6RA91/FyCkL4sxJM3fnGNQZhgYac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754058959; c=relaxed/simple;
	bh=g6m2jbm65MBrZ5g+L05KT79qCKQTBK8haBjYhOKBGKk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=GF2p0cbXGdNT2jOy0UCCVcEY0KW0q8VtRGmiHSGjQW/H5EdrbZppy0KuMujdqNnzTojiSBsDcMPXMOcN4rjl3zYxDasOHTiaAcjSDKrE/XIffWbgDRQWsGhY5ja19zO7MnQqbuDqFw8yNjDccTeeerf/uK/kVEFDPDAn5aOdk8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=NmO6MXy0; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754058949; x=1754663749; i=markus.elfring@web.de;
	bh=7eRDLl/W59iQ/iiSZive7iNGHCs54NrjItQ26fqmRX0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NmO6MXy0v4SRhKHQ6EbObCAKOQY1XYy299K+sH0JHyUEL+qcj3HdNgpjinpHrxxt
	 xmEMfjGL2eITC8IW7IR0qPvYHZPE98FIjurEsfZZqLg9/JfJ87ZQbGqZhVfENGm0x
	 22KJlhcQzS47CUI4VXl1OmWo0B9R2gqAOkSgPOszU5o4RQ4K618cMe5Hb1R125C9E
	 elONo+xnBgOOvu22z6XgLXHUlOTiPmsNbujdQ3F1pLHym1e1EFGaq+uXsUaL8l9ze
	 h22/9KDPUs2fAXVBjsXI09pWZFazPw7ouF4W2vr44+FW3tYcWpNbzZETypko95szD
	 vQqPL0VHyriVDSumLQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.221]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MAtwr-1uolp62cq9-005OfW; Fri, 01
 Aug 2025 16:35:49 +0200
Message-ID: <7160bd86-3061-4549-abf0-074b84f4872c@web.de>
Date: Fri, 1 Aug 2025 16:35:47 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhen Ni <zhen.ni@easystack.cn>, linux-acpi@vger.kernel.org,
 Jassi Brar <jassisinghbrar@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <20250730124508.939257-1-zhen.ni@easystack.cn>
Subject: Re: [PATCH] mailbox: pcc: Add missed acpi_put_table() to fix memory
 leak
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250730124508.939257-1-zhen.ni@easystack.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZJ3sCxff2AGvJKbxFUk2i1qTkbhdKzvIER2yePnCpaTSsyhK9Dv
 xhbVRlKCR3TnSJo56ZmEsXgwaBlSPPHoekxvb7HoEBJOkwYGzS5ueDi/RZHEBZNd8TRvlSP
 J73ZoE/1KpG8aHzJCUax3dUQ0Yfsgshr8Uvn9E5aCZTHrH4GdBjKkBDKSy0FqUkrpzpntlV
 GfebPSxwSBNOkJUne4TQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lO4MKiLO2g8=;makkuCL/MS2GitpDyra0g7AJO9q
 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
 F24NS4tR08BJUr0UhCueB20=

> In pcc_mbox_probe(), the PCCT table acquired via acpi_get_table()
> is only released in error paths but not in the success path. This
> leads to a permanent ACPI memory leak when the driver successfully
> initializes.

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.16#n145


> The label name 'err' is no longer accurate because it handles both:
> 1. Error cases
> 2. Success case

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.16#n94


=E2=80=A6
> +++ b/drivers/mailbox/pcc.c
> @@ -763,19 +763,19 @@ static int pcc_mbox_probe(struct platform_device *=
pdev)
>  					 GFP_KERNEL);
>  	if (!pcc_mbox_channels) {
>  		rc =3D -ENOMEM;
> -		goto err;
> +		goto out_put_pcct;
>  	}
> =20
>  	chan_info =3D devm_kcalloc(dev, count, sizeof(*chan_info), GFP_KERNEL)=
;
>  	if (!chan_info) {
>  		rc =3D -ENOMEM;
> -		goto err;
> +		goto out_put_pcct;
>  	}
> =20
>  	pcc_mbox_ctrl =3D devm_kzalloc(dev, sizeof(*pcc_mbox_ctrl), GFP_KERNEL=
);
>  	if (!pcc_mbox_ctrl) {
>  		rc =3D -ENOMEM;
> -		goto err;
> +		goto out_put_pcct;
>  	}
=E2=80=A6

Can such exception handling be shared by using another jump target like =
=E2=80=9Ce_nomem=E2=80=9D?

Regards,
Markus

