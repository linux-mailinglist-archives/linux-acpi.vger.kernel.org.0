Return-Path: <linux-acpi+bounces-15987-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D4BB32847
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Aug 2025 12:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98A445651F7
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Aug 2025 10:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160EC242D8D;
	Sat, 23 Aug 2025 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="wjVuZr0K"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ECD23C8D5;
	Sat, 23 Aug 2025 10:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755946611; cv=none; b=rm5dg864FrzNG9kl49HptH/l/0W+MZiGpa+155B9nh0Xy0z/PSsfHNsb01krHH+cB1fvq5gBEluXX8umoMlrHzNSXs0ErRIaB26eyAEat7ebqCEZMlTifnCLu1LqAUqo07oDF5poRzZwr9mf1NfD784ANN37Yb8ktOtiV3CNEO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755946611; c=relaxed/simple;
	bh=hZl+1tNEOoRPEhI2xrI391HNINjWwowc78BLsjJyiCs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=SLRlQSJqiAP+29q42Sh8OC2fyD87EE6YN68NBtiIfpCdO4G3zguAsBMcwgsColsCzUneos9i4kwaK8Q9svUFACtNIiETpZRbxQRZqzevhpSX+evxun8ecwzEdfXu3fgiShAz/ItYh9AVb8bN0jQ0qVNZCEjERKwMs1nkypKxHLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=wjVuZr0K; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1755946550; x=1756551350; i=markus.elfring@web.de;
	bh=E+Pbs1Suid1Z61nzIdWL9+X/91Z0qNxBPgsINl8X1ig=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=wjVuZr0KoKzfYrd4jSyb7A3tS3kv+JUHWy0ImLnZJVvpZaC9P343FclMj9QGc7nL
	 sjjetxtYKqBDVJ3+TJrVwmw03Wnt3S0VGTe2q7DKs1AeoYzBijorQhGvxaozjneHy
	 DgMxXqgbtZvEdh87j89T9WNPSQ5pMLQJ0KZyB7BCuhJvm6xRxR5uRYsq7CVN+kN20
	 jfNIi36XmTsxdurheGhAHrN3bQiSx9iFEuh5ZpcEEWMgE3bMO/UKvFcaV/k6cGC04
	 PyokxtGLcquk9854y075hL40gGv3Wn6eGCrnpp8VYdC6fFTa0HGw02cxMuZrKhbPh
	 HfiZuy3fWZCRBVei5g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.194]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTfkd-1uxHtz1ROv-00UfTp; Sat, 23
 Aug 2025 12:55:50 +0200
Message-ID: <60b72fd4-0a63-44ff-9850-1848d3fe9559@web.de>
Date: Sat, 23 Aug 2025 12:55:40 +0200
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
 Shameer Kolothum <shameerkolothum@gmail.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Shaopeng Tan <tan.shaopeng@fujitsu.com>, Sudeep Holla
 <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>,
 Xin Hao <xhao@linux.alibaba.com>
References: <20250822153048.2287-9-james.morse@arm.com>
Subject: Re: [PATCH 08/33] ACPI / MPAM: Parse the MPAM table
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250822153048.2287-9-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3DzY45z1U1H8WkZoFv0BMtQ1aSNdAklJaG20FL5xddOG8jtC9IE
 oJqCi0d+ZCWs7QzJCH6BNyHIw7jycKNpx/I3SCaIo8Uptx4icbucWBP5ovyp6FT5K3FP6DH
 sn+qtcpKbUGKG/OF3tw3sGEsAXa/br/vnaPlnqnLHFJwz1q1gNmXFFhEqcp9KTW5XhZqM2o
 JWeRhQY75mGVqKE6YJF+w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oJc8AXaJPxk=;6mSbWw8EkvUmV1k0IREVAPKgwJH
 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
 834RNf8=

=E2=80=A6
> +++ b/drivers/acpi/arm64/mpam.c
> @@ -0,0 +1,331 @@
=E2=80=A6
> +static int __init acpi_mpam_parse(void)
> +{
> +        struct acpi_table_header *table __free(acpi_table) =3D acpi_get=
_table_ret(ACPI_SIG_MPAM, 0);
> +	char *table_end, *table_offset =3D (char *)(table + 1);
=E2=80=A6

Please replace eight space characters by a tab character here.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.17-rc2#n18

Are further source code places similarly improvable?

Regards,
Markus

