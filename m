Return-Path: <linux-acpi+bounces-7001-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA2E9389E6
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Jul 2024 09:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99BE01F217F6
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Jul 2024 07:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5081B27D;
	Mon, 22 Jul 2024 07:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="chPfJ5gE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF1D1803D;
	Mon, 22 Jul 2024 07:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721632600; cv=none; b=cHHbcvGiyEAJGzG8bT5/Ur3KPOe7jRj8EQJ1H8CRp7fa+VB4ruQ00ZRhI3SPXS7DsaDF+qnha6dZ9iwJNDXEvIrUfMNucN6288gxAt++pI89WZuTZNIb0qIeMPDGiM7LJTarn7HAefi69arceG7elBd7wvhYmoKZ5QrsMJY+Rbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721632600; c=relaxed/simple;
	bh=YFLDcKIC9Uv+Lpa4xHklsR0hcUKSD5CTzcyTHP2K3cg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=pAeiTYYueGt8PPJ8AjNI75pfet1yoOb7L9msesyJsNMYuJdcoNvTdtSNiRA6DHeg5J5ouJEliUNKTEtkwq3wFKm30P8lQ6U3JEzUc3zbg8p3m6DYcynH/smaLUY4KAs/KVSr/kBZfq3oVOF3jx7GE8B2EpYTrauIZUO6nWKXDK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=chPfJ5gE; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721632549; x=1722237349; i=markus.elfring@web.de;
	bh=YFLDcKIC9Uv+Lpa4xHklsR0hcUKSD5CTzcyTHP2K3cg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=chPfJ5gED78UP1PqTnS3A5EvhZm66glsEl179SG9fF3bYUYn9hrH+SvhFzSjfviF
	 dmw9E9bRufBnGCAKR7QiiLKdkcjcj2GgonDp8J8g0Ta9kFfup8fkB5dCBQLn/JlM0
	 WOfmc2GoUZHsEunOZseDovcV4FC7imZiZtXeUTyvGNseV4jPwWkhHsTvtPTp0Z/CJ
	 D0ZAdW2bOJkvplk00RVrAMMIFTmK1W/F27kBdW/k41ebAVLORlOFYyBKDAC9dsTYL
	 JxfNEGunqg1BovEZSa9oHGPNqo+mERdOJ7KP3qonlNDUUljMf2qDhSckuj/Q8Tbzn
	 PQUDNNlHxbOH8gvH4g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mvbik-1sCkHj1MIQ-014vrz; Mon, 22
 Jul 2024 09:15:49 +0200
Message-ID: <73b3e14a-c1c3-4f7b-aea8-2108912e21ca@web.de>
Date: Mon, 22 Jul 2024 09:15:26 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-hwmon@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-acpi@vger.kernel.org, netdev@vger.kernel.org,
 Andreas Kemnade <andreas@kemnade.info>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?B?R8O8bnRlciBSw7Zjaw==?= <linux@roeck-us.net>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee@kernel.org>,
 Marcin Wojtas <marcin.s.wojtas@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20240721-device_for_each_child_node-available-v2-1-f33748fd8b2d@gmail.com>
Subject: Re: [PATCH v2 1/6] device property: document
 device_for_each_child_node macro
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240721-device_for_each_child_node-available-v2-1-f33748fd8b2d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xrBbMiLw9ljoQaybd5Se9hN78cCxX8gDvnFpicc5JDnMeWgJvPk
 I9c1qD+hb5e2+8SYdeOWSoirnR5QykLuGUfqKU19dYt+OFOkUCbHbLvk8uZJwIVOsEhA45r
 bmuq0ILq/mW+lUo7jhu/zAHi3b4m7iMpuTipe4yCUzmsGvCimtPrY6s+9G396RYaV89DxEp
 jqghjWTIaFtL7/Mi4dFRA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zMXmFfshu/w=;jAInkgB3vloWqW9kgqI8uWOuokM
 n5IXptcGeplXc/NaEZxVWLFa/Io9spgPH3TH2rzipw06aXs3s4jLjf8OdtwNUg3FjAhRA3Hql
 DwBz+TKODiNo8fLGqR6eT+RKe1fOWVw7n7M36LjzBOqI9yBTMPJTsaoz9nKAMZYO1YW2vPT1D
 Ijp7TUQbDQKs38m5li9TRE8vNg3/ncd/TRO+svPdwVNSK4sd8rH0o5JApRiCsMLQjt1pIwbqW
 YMXWDphWozW0ZAsch2EBNC2g6oyN2Jfmf40LjUEmste+oeuxLkDaLDfrgM1aw0Pq/oy0K9wEo
 339RvtJ4EbCF0j7wXp+saUmj14wfnd4AILUNn4X50XyzhkMepw5BFqE5CFrCPMbRdatCnQWX0
 8zNTWLMhx0GRNz6Dv6Ev5THZjS4SpmDN+XmfOFeridUqaF0PDe1Jzkf8fRrTj8SFHgoHMkuAr
 p1brIA/TFz8FsNK1FCQjrj/cTGlcX6CuNQln1AE4LbluuAul6BaLb7jpPnD1ywRFIPO/UO0rW
 TmW/SicScUoXAnQ6rj/S6t2RPfI0hJNmg8w8m0wZjwH/n+G/lYTATCSRXy8w8xcu4OtBV8rzs
 yiPg+aJpgaMs22MOv+XLlQuQ7Icot43zQ/MT/qp5WIpGDqZ8Xas+1b96QAjhINwkqRG10k8kV
 76dR8pUGfLUk/+/tlXvDzLRtkoGkoWrpMk+14HDfMa8pzQ/TDNREQ3xcwSZkB78JSL9iygLRK
 wUQ0CGFNDAHufOB/UEJNuef3c7g5bD6IGNikxvOrEjXiA52fFGiyM5sHRpM8ys0dOL7nLU0YE
 egEY/c+H7mNDTsMF0eKES1PA==

=E2=80=A6
> + * Unavailable nodes are skipped i.e. this macro is implicitly _availab=
le_.
=E2=80=A6

How good does presented information fit together in this comment line?

Regards,
Markus

