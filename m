Return-Path: <linux-acpi+bounces-20538-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNowGVkScmksawAAu9opvQ
	(envelope-from <linux-acpi+bounces-20538-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 13:04:41 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D36CB66600
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 13:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD9BC904587
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 11:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B2E389DF1;
	Thu, 22 Jan 2026 11:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bNeHNrWk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFB2DDAB;
	Thu, 22 Jan 2026 11:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769081789; cv=none; b=GK/OwNsOXRscT1SchHtG+JIx73uDzLztz8uoqyHClZaQS89QtDH6pzwpEjYK41WuwmblVW53zUAz2S3GMyYnQ0VITT/zj6Bh0kHpjc7PTYngP9tqiFDKIpDm5Hmg0veiHk6yh9IbsW/HMCLw6x80MKwErtrOr2+6P+jehvQPeYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769081789; c=relaxed/simple;
	bh=b9jTnButXpXC+V6mVsyaBCvW1IHIWA7Q8ghL/cWlDcs=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=qEserHumZ0av90Ssjk337hLEuT+61rO5r6HrKhNz8pI71fxNFcDkRMaNXxp57ac9HHaeCZSQAxOuXrs8zILxwuft9XL60v0xihS9z1qIiIrvxJvf4ajZz7CiIiCKk9wvrj2Tqt/LiJg6T7FzCNuttaIQBUjvJdzgowb01sOE+78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bNeHNrWk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60M1E5A8006450;
	Thu, 22 Jan 2026 11:36:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=q3EXed
	7K8rvu7xvas8gGiCcUJZd+guvgxFAEElzrCuw=; b=bNeHNrWkN8bPOY9l/JM1qC
	vnvcSWhBWorSPwykLjkJ243EA3Guik8sEe9i0xHTP+nMBQw2oi4Ht1e4tNQ7NHMk
	r+xGs7J+qBcXW4RxcR2jQbPOI+KoXGBfJ1MeWxcLKJwFNIUjWgtiY9EMeUa+9dV0
	KDwpdSlQ8g4dETAcl7fUMR/Pdfz62vzZDkeGG0faelNcJ09p990ikHVTjiihk45x
	B6F5/52FLAtFEZaoqAWvoLLuxHD3VoqEFV0IprHulvv5JVeEBcKrBW7Ued329C96
	MG/8KRHGc030PRsnk9V1hegnQnwYQEjTiu+cYDlvWv4bsQHBI3ou6PM+hyACqwTQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23s9gxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 11:36:21 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60MBaLFP004546;
	Thu, 22 Jan 2026 11:36:21 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23s9gxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 11:36:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60MAWQVR027382;
	Thu, 22 Jan 2026 11:36:20 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brnrn9ufa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 11:36:20 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60MBaJL514090930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 11:36:19 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E45658055;
	Thu, 22 Jan 2026 11:36:19 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24DEE58043;
	Thu, 22 Jan 2026 11:36:18 +0000 (GMT)
Received: from [9.87.140.98] (unknown [9.87.140.98])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Jan 2026 11:36:17 +0000 (GMT)
Message-ID: <82b50e37070e617786dccf84056183e70c7cb538.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] PCI: Initialize RCB from pci_configure_device
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
        =?ISO-8859-1?Q?H=E5kon?= Bugge
	 <haakon.bugge@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Johannes Thumshirn	
 <morbidrsa@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Alex Williamson
 <alex@shazbot.org>
In-Reply-To: <20260122103655.GA1239220@bhelgaas>
References: <20260122103655.GA1239220@bhelgaas>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=mQINBGHm3M8BEAC+MIQkfoPIAKdjjk84OSQ8erd2OICj98+GdhMQpIjHXn/RJdCZLa58k
 /ay5x0xIHkWzx1JJOm4Lki7WEzRbYDexQEJP0xUia0U+4Yg7PJL4Dg/W4Ho28dRBROoJjgJSLSHwc
 3/1pjpNlSaX/qg3ZM8+/EiSGc7uEPklLYu3gRGxcWV/944HdUyLcnjrZwCn2+gg9ncVJjsimS0ro/
 2wU2RPE4ju6NMBn5Go26sAj1owdYQQv9t0d71CmZS9Bh+2+cLjC7HvyTHKFxVGOznUL+j1a45VrVS
 XQ+nhTVjvgvXR84z10bOvLiwxJZ/00pwNi7uCdSYnZFLQ4S/JGMs4lhOiCGJhJ/9FR7JVw/1t1G9a
 UlqVp23AXwzbcoV2fxyE/CsVpHcyOWGDahGLcH7QeitN6cjltf9ymw2spBzpRnfFn80nVxgSYVG1d
 w75ksBAuQ/3e+oTQk4GAa2ShoNVsvR9GYn7rnsDN5pVILDhdPO3J2PGIXa5ipQnvwb3EHvPXyzakY
 tK50fBUPKk3XnkRwRYEbbPEB7YT+ccF/HioCryqDPWUivXF8qf6Jw5T1mhwukUV1i+QyJzJxGPh19
 /N2/GK7/yS5wrt0Lwxzevc5g+jX8RyjzywOZGHTVu9KIQiG8Pqx33UxZvykjaqTMjo7kaAdGEkrHZ
 dVHqoPZwhCsgQARAQABtChOaWtsYXMgU2NobmVsbGUgPHNjaG5lbGxlQGxpbnV4LmlibS5jb20+iQ
 JXBBMBCABBAhsBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAhkBFiEEnbAAstJ1IDCl9y3cr+Q/Fej
 CYJAFAmesutgFCQenEYkACgkQr+Q/FejCYJDIzA//W5h3t+anRaztihE8ID1c6ifS7lNUtXr0wEKx
 Qm6EpDQKqFNP+n3R4A5w4gFqKv2JpYQ6UJAAlaXIRTeT/9XdqxQlHlA20QWI7yrJmoYaF74ZI9s/C
 8aAxEzQZ64NjHrmrZ/N9q8JCTlyhk5ZEV1Py12I2UH7moLFgBFZsPlPWAjK2NO/ns5UJREAJ04pR9
 XQFSBm55gsqkPp028cdoFUD+IajGtW7jMIsx/AZfYMZAd30LfmSIpaPAi9EzgxWz5habO1ZM2++9e
 W6tSJ7KHO0ZkWkwLKicrqpPvA928eNPxYtjkLB2XipdVltw5ydH9SLq0Oftsc4+wDR8TqhmaUi8qD
 Fa2I/0NGwIF8hjwSZXtgJQqOTdQA5/6voIPheQIi0NBfUr0MwboUIVZp7Nm3w0QF9SSyTISrYJH6X
 qLp17NwnGQ9KJSlDYCMCBJ+JGVmlcMqzosnLli6JszAcRmZ1+sd/f/k47Fxy1i6o14z9Aexhq/UgI
 5InZ4NUYhf5pWflV41KNupkS281NhBEpChoukw25iZk0AsrukpJ74x69MJQQO+/7PpMXFkt0Pexds
 XQrtsXYxLDQk8mgjlgsvWl0xlk7k7rddN1+O/alcv0yBOdvlruirtnxDhbjBqYNl8PCbfVwJZnyQ4
 SAX2S9XiGeNtWfZ5s2qGReyAcd2nBna0KU5pa2xhcyBTY2huZWxsZSA8bmlrbGFzLnNjaG5lbGxlQ
 GlibS5jb20+iQJUBBMBCAA+AhsBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEnbAAstJ1IDCl9y
 3cr+Q/FejCYJAFAmesuuEFCQenEYkACgkQr+Q/FejCYJCosA/9GCtbN8lLQkW71n/CHR58BAA5ct1
 KRYiZNPnNNAiAzjvSb0ezuRVt9H0bk/tnj6pPj0zdyU2bUj9Ok3lgocWhsF2WieWbG4dox5/L1K28
 qRf3p+vdPfu7fKkA1yLE5GXffYG3OJnqR7OZmxTnoutj81u/tXO95JBuCSJn5oc5xMQvUUFzLQSbh
 prIWxcnzQa8AHJ+7nAbSiIft/+64EyEhFqncksmzI5jiJ5edABiriV7bcNkK2d8KviUPWKQzVlQ3p
 LjRJcJJHUAFzsZlrsgsXyZLztAM7HpIA44yo+AVVmcOlmgPMUy+A9n+0GTAf9W3y36JYjTS+ZcfHU
 KP+y1TRGRzPrFgDKWXtsl1N7sR4tRXrEuNhbsCJJMvcFgHsfni/f4pilabXO1c5Pf8fiXndCz04V8
 ngKuz0aG4EdLQGwZ2MFnZdyf3QbG3vjvx7XDlrdzH0wUgExhd2fHQ2EegnNS4gNHjq82uLPU0hfcr
 obuI1D74nV0BPDtr7PKd2ryb3JgjUHKRKwok6IvlF2ZHMMXDxYoEvWlDpM1Y7g81NcKoY0BQ3ClXi
 a7vCaqAAuyD0zeFVGcWkfvxYKGqpj8qaI/mA8G5iRMTWUUUROy7rKJp/y2ioINrCul4NUJUujfx4k
 7wFU11/YNAzRhQG4MwoO5e+VY66XnAd+XPyBIlvy0K05pa2xhcyBTY2huZWxsZSA8bmlrbGFzLnNj
 aG5lbGxlQGdtYWlsLmNvbT6JAlQEEwEIAD4CGwEFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQSds
 ACy0nUgMKX3Ldyv5D8V6MJgkAUCZ6y64QUJB6cRiQAKCRCv5D8V6MJgkEr/D/9iaYSYYwlmTJELv+
 +EjsIxXtneKYpjXEgNnPwpKEXNIpuU/9dcVDcJ10MfvWBPi3sFbIzO9ETIRyZSgrjQxCGSIhlbom4
 D8jVzTA698tl9id0FJKAi6T0AnBF7CxyqofPUzAEMSj9ynEJI/Qu8pHWkVp97FdJcbsho6HNMthBl
 +Qgj9l7/Gm1UW3ZPvGYgU75uB/mkaYtEv0vYrSZ+7fC2Sr/O5SM2SrNk+uInnkMBahVzCHcoAI+6O
 Enbag+hHIeFbqVuUJquziiB/J4Z2yT/3Ps/xrWAvDvDgdAEr7Kn697LLMRWBhGbdsxdHZ4ReAhc8M
 8DOcSWX7UwjzUYq7pFFil1KPhIkHctpHj2Wvdnt+u1F9fN4e3C6lckUGfTVd7faZ2uDoCCkJAgpWR
 10V1Q1Cgl09VVaoi6LcGFPnLZfmPrGYiDhM4gyDDQJvTmkB+eMEH8u8V1X30nCFP2dVvOpevmV5Uk
 onTsTwIuiAkoTNW4+lRCFfJskuTOQqz1F8xVae8KaLrUt2524anQ9x0fauJkl3XdsVcNt2wYTAQ/V
 nKUNgSuQozzfXLf+cOEbV+FBso/1qtXNdmAuHe76ptwjEfBhfg8L+9gMUthoCR94V0y2+GEzR5nlD
 5kfu8ivV/gZvij+Xq3KijIxnOF6pd0QzliKadaFNgGw4FoUeZo0rQhTmlrbGFzIFNjaG5lbGxlIDx
 uaWtzQGtlcm5lbC5vcmc+iQJUBBMBCAA+AhsBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEnbAA
 stJ1IDCl9y3cr+Q/FejCYJAFAmesuuEFCQenEYkACgkQr+Q/FejCYJC6yxAAiQQ5NAbWYKpkxxjP/
 AajXheMUW8EtK7EMJEKxyemj40laEs0wz9owu8ZDfQl4SPqjjtcRzUW6vE6JvfEiyCLd8gUFXIDMS
 l2hzuNot3sEMlER9kyVIvemtV9r8Sw1NHvvCjxOMReBmrtg9ooeboFL6rUqbXHW+yb4GK+1z7dy+Q
 9DMlkOmwHFDzqvsP7eGJN0xD8MGJmf0L5LkR9LBc+jR78L+2ZpKA6P4jL53rL8zO2mtNQkoUO+4J6
 0YTknHtZrqX3SitKEmXE2Is0Efz8JaDRW41M43cE9b+VJnNXYCKFzjiqt/rnqrhLIYuoWCNzSJ49W
 vt4hxfqh/v2OUcQCIzuzcvHvASmt049ZyGmLvEz/+7vF/Y2080nOuzE2lcxXF1Qr0gAuI+wGoN4gG
 lSQz9pBrxISX9jQyt3ztXHmH7EHr1B5oPus3l/zkc2Ajf5bQ0SE7XMlo7Pl0Xa1mi6BX6I98CuvPK
 SA1sQPmo+1dQYCWmdQ+OIovHP9Nx8NP1RB2eELP5MoEW9eBXoiVQTsS6g6OD3rH7xIRxRmuu42Z5e
 0EtzF51BjzRPWrKSq/mXIbl5nVW/wD+nJ7U7elW9BoJQVky03G0DhEF6fMJs08DGG3XoKw/CpGtMe
 2V1z/FRotP5Fkf5VD3IQGtkxSnO/awtxjlhytigylgrZ4wDpSE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Jan 2026 12:35:17 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MWeCPdM5RGVDMwo3kW2uQutGthQYVS7R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA4MiBTYWx0ZWRfXwAH4phcDoQVv
 LuLRpss/Br7Ccpc1NrhhORRsS49mtgnzi3S+a9ZBt3AkCAdkMeTNDy3pCmK61mUcTNEjaM8skEW
 /4jdjNmLDjhJKyACLpYEIMjo7g4W9RM/VAxiDJrVEMshNQj7QJWL3DVr0RI5PXWhPNFe6HQPO1c
 NyFV9G2XO+OrBcTHzvluy+mOT38C9pHSruGkAKR4d1W6z2HZ/TkLsK0LkdJ3YJPeKe5vidBaIMm
 ZxtmZFAC7pEEmRcURhjYTSjHOLG7n9FVXwgY4MAeTTtWa6mFdxPXWdBjIuSxxievZSI0MJEN10L
 r7P5oT6MmbHUyxfZdyll/ZMsVAspmacSCbNzCMgV482tZdMtXOHCrFmLDwrFbj6lBF9dwQS/Bvx
 Dm8I7lqC61LGgJzAsS/Bn1etCAH2WsOv6ljRTjzlT2JSkJ+DbWSek+a7psc7Ik2EXS0jixXRRWH
 MZDxINcI/It9PkuT6UQ==
X-Authority-Analysis: v=2.4 cv=J9SnLQnS c=1 sm=1 tr=0 ts=69720bb6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=0y7d-dTh7VtyGsCgoZEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: mJ2PtFjboj_cmN8PN2DxUpCuOeqUGBBf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601220082
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	DMARC_POLICY_ALLOW(0.00)[ibm.com,none];
	FREEMAIL_CC(0.00)[google.com,gmail.com,vger.kernel.org,shazbot.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20538-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-acpi];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schnelle@linux.ibm.com,linux-acpi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[13];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,linux.ibm.com:mid]
X-Rspamd-Queue-Id: D36CB66600
X-Rspamd-Action: no action

On Thu, 2026-01-22 at 04:36 -0600, Bjorn Helgaas wrote:
> [+cc Alex, Niklas]
>=20
> On Wed, Jan 21, 2026 at 04:40:10PM -0600, Bjorn Helgaas wrote:
> > On Wed, Jan 21, 2026 at 12:35:40PM +0100, H=C3=A5kon Bugge wrote:
> > > Commit e42010d8207f ("PCI: Set Read Completion Boundary to 128 iff
> > > Root Port supports it (_HPX)") fixed a bogus _HPX type 2 record, whic=
h
> > > instructed program_hpx_type2() to set the RCB in an endpoint,
> > > although it's RC did not have the RCB bit set.
> > >=20
> > > e42010d8207f fixed that by qualifying the setting of the RCB in the
> > > endpoint with the RC supporting an 128 byte RCB.
> > >=20
> > > In retrospect, the program_hpx_type2() should only modify the AER
> > > bits, and stay away from fiddling with the Link Control Register.
> > >=20
> > > Hence, we explicitly program the RCB from pci_configure_device(). RCB
> > > is RO in Root Ports, and in VFs, the bit is RsvdP, so for these two
> > > cases we skip programming it. Then, if the Root Port has RCB set and
> > > it is not set in the EP, we set it.
> > >=20
> > > Fixes: Commit e42010d8207f ("PCI: Set Read Completion Boundary to 128=
 iff Root Port supports it (_HPX)")
> > > Signed-off-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
> > >=20
> > > ---
> > >=20
> > > Note, that the current duplication of pcie_root_rcb_set() will be
> > > removed in the next commit.
> > > ---
> > >  drivers/pci/probe.c | 36 ++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 36 insertions(+)
> > >=20
> > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > index 41183aed8f5d9..347af29868124 100644
> > > --- a/drivers/pci/probe.c
> > > +++ b/drivers/pci/probe.c
> > > @@ -2410,6 +2410,41 @@ static void pci_configure_serr(struct pci_dev =
*dev)
> > >  	}
> > >  }
> > > =20
> > > +static bool pcie_root_rcb_set(struct pci_dev *dev)
> > > +{
> > > +	struct pci_dev *rp =3D pcie_find_root_port(dev);
> > > +	u16 lnkctl;
> > > +
> > > +	if (!rp)
> > > +		return false;
> > > +
> > > +	pcie_capability_read_word(rp, PCI_EXP_LNKCTL, &lnkctl);
> > > +
> > > +	return !!(lnkctl & PCI_EXP_LNKCTL_RCB);
> > > +}
> > > +
> > > +static void pci_configure_rcb(struct pci_dev *dev)
> > > +{
> > >=20
--- snip ---
> >=20
> >         pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnkctl);
> >         if (rcb) {
> >                 if (lnkctl & PCI_EXP_LNKCTL_RCB)
> >                         return;
> >=20
> >                 lnkctl |=3D PCI_EXP_LNKCTL_RCB;
> >         } else {
> >                 if (!(lnkctl & PCI_EXP_LNKCTL_RCB))
> >                         return;
> >=20
> >                 pci_info(FW_INFO "clearing RCB (RCB not set in Root Por=
t)\n");
> >                 lnkctl &=3D ~PCI_EXP_LNKCTL_RCB;
>=20
> On second thought, I think this is too aggressive.  I think VM guests
> will often see endpoints but not the Root Port.  In that case,
> pcie_root_rcb_set() would return false because it couldn't find the
> RP, but the RP might actually have RCB set.  Then we would clear the
> endpoint RCB unnecessarily, which should be safe but would reduce
> performance and will result in annoying misleading warnings.
>=20
> Could either ignore this case (as in your original patch) or bring
> pcie_root_rcb_set() inline here and return early if we can't find the
> RP.
> >=20

Thanks Bjorn for looping me in. If I'm reading later comments correctly
we're already in agreement that if the root port isn't found the
function should bail and leave the setting as is which sounds good to
me. Still, feel free to directly add me in To on the next version and
I'll be happy to test it and take a look at the code.

Nevertheless I'd like to confirm that yes on s390 we definitely have
the case where PFs are passed-through to guests without the guest
having access to / seeing the root port as a PCIe device. This is true
on both our machine hypervisor guests (LPARs) and in KVM guests. And
yes I think this would potentially incorrectly clear the RCB which
could have been set by firmware or platform PCI code based on its
knowledge of the actual root port. That said from a quick look we
currently seem to keep the RCB at 64 bytes in endpoints.

Thanks,
Niklas

