Return-Path: <linux-acpi+bounces-13301-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6B1A9D62A
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Apr 2025 01:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D01DB4E24ED
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Apr 2025 23:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D902973C9;
	Fri, 25 Apr 2025 23:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="XYn164VA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDDA218821;
	Fri, 25 Apr 2025 23:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745623260; cv=none; b=euFzCm+xgb/oWABwh7ymxHo/Z1YFSTAh2tasphiTC2f9czT5BomVtYopQAQSf5gOKcB9wqt6kY/UnMRNT0za/MKeBsbgbt/Lu6+UD7FbV/NTLwxqeCMbHOs8mqN54PANxmsKPVhARuLOrHqDLFDBNiKChIs7+ixAuonQvOU/5es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745623260; c=relaxed/simple;
	bh=xSYAAT+aFsRKZGNWlJ2yH4lpvvFENq25qn7+CXZjB6Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nTtYSSBaAZAQA42G4voaVkeIZQP4iMSTdUdz/oH9KiHcnsL9O3l5AeBV9VvvSChAVfIQ4n8prnHqpIkw/XvvLnko83mItwtciUk+JsrG7pKIOvbdX3YhyWQBKdj9oJ1Vz4H6+Y2LsKTH/G9Mm7DNpNY30HwwOUhDoSKBXe1t4sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=XYn164VA; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1745623249; x=1746228049; i=w_armin@gmx.de;
	bh=k8gOcHPxV7xb4stvNjQSQk/7YUe23M/FGIBpVn3IEBQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XYn164VAuMIModHboKCEDpIMzB1WSy1Oushaslu39qRrzSP/J2ba+kNTSwaNNO4T
	 0pvFFfCVVCmIexqdqES+KDhgraTCSvpPI1Kt9Ght1tc5WomB3Hyo/VSO0jxyqwjji
	 iuZ5/SZbunVw1aAfiH7/iVooi+qOTK2ZnoIwiiCceh33UeONJLYG7Ilw7+p7HvjcJ
	 EUH8qc/pTyc757Va/Nw/OTotk3mP18rGrVjzqFz4oydS4kKzanUNO5EcQG0zh7xIJ
	 s9GnKWXNcwWQrjw3N+a+rPML9F52NPftkngMmFtkYmjhe4WWsLm9+UcA27Mks78qR
	 cMJAFUmbyyQHc3MPFw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0XCw-1v2kGC3h9I-012x05; Sat, 26
 Apr 2025 01:20:49 +0200
Message-ID: <91ea8aed-5f98-4e4e-b3ee-fdc86d54f787@gmx.de>
Date: Sat, 26 Apr 2025 01:20:47 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ACPI: thermal: Properly support the _SCP control
 method
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org, rui.zhang@intel.com
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250410165456.4173-1-W_Armin@gmx.de>
Content-Language: en-US, de-DE
In-Reply-To: <20250410165456.4173-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Xt4hxXY40jqwRfd/4FQJV4+/UbuoZd1DVFKqlRscOCQbAox3fgY
 fZiApw18eCkCweOC+7zwVzU1zLnreaxyl8HwtSBQQ1OIrhB94O12a79Wm2Eia0QvGi3lQ68
 kMWcQ/PlbOgN/oDVpmZVWSyQ1uG1733xxPFbrPmbHYxxXwlYbxwzH4rmPV6zHjApI1BQfg9
 1UWEHLloXzyWzXu71Zilg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8iNm1FqJlqk=;m0Bfz1VXkrZQLWHP0pqQZK/8DwH
 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
 dEKWISTuX3VSasqEN4EQvM=

Am 10.04.25 um 18:54 schrieb Armin Wolf:

> The ACPI specification defines an interface for the operating system
> to change the preferred cooling mode of a given ACPI thermal zone.
> This interface takes the form of a special ACPI control method called
> _SCP (see section 11.4.13 for details) and is already supported by the
> ACPI thermal driver.
>
> However this support as many issues:
>
>   - the kernel advertises support for the "3.0 _SCP Extensions" yet the
>     ACPI thermal driver does not support those extensions. This may
>     confuse the ACPI firmware.
>
>   - the execution of the _SCP control method happens after the driver
>     retrieved the trip point values. This conflicts with the ACPI
>     specification:
>
> 	"OSPM will automatically evaluate _ACx and _PSV objects after
> 	 executing _SCP."
>
>   - the cooling mode is hardcoded to active cooling and cannot be
>     changed by the user.
>
> Those issues are fixed in this patch series. In the end the user
> will be able to tell the ACPI firmware wether he prefers active or
> passive cooling. This setting will also be interesting for
> applications like TLP (https://linrunner.de/tlp/index.html).
>
> The whole series was tested on various devices supporting the _SCP
> control method and on a device without the _SCP control method and
> appears to work flawlessly.

Any updates on this? I can proof that the new interface for setting the cooling mode
works. Additionally the first two patches fix two issues inside the underlying code
itself, so having them inside the mainline tree would be beneficial to users.

Thanks,
Armin Wolf

>
> Armin Wolf (3):
>    ACPI: OSI: Stop advertising support for "3.0 _SCP Extensions"
>    ACPI: thermal: Execute _SCP before reading trip points
>    ACPI: thermal: Allow userspace applications to change the cooling mode
>
>   .../ABI/testing/sysfs-driver-thermal          |  14 ++
>   MAINTAINERS                                   |   1 +
>   drivers/acpi/osi.c                            |   1 -
>   drivers/acpi/thermal.c                        | 129 ++++++++++++++++--
>   4 files changed, 133 insertions(+), 12 deletions(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-driver-thermal
>
> --
> 2.39.5
>
>

