Return-Path: <linux-acpi+bounces-20591-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJTOKEnEc2kpygAAu9opvQ
	(envelope-from <linux-acpi+bounces-20591-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 19:56:09 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F4C79E2C
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 19:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC55E303099E
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 18:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D0F23182D;
	Fri, 23 Jan 2026 18:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M1BkxyX1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064E21DDC33;
	Fri, 23 Jan 2026 18:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194518; cv=none; b=KAzomOHRby2ie6XQUup0EN9tzEmu9sERnA9YNp7sCQsdOcUFlIQGOqKWGoJLLqdnCOxME2/QIogEqQfQ2AlH2/Tj3h60V+OoyddZTXR7clFvNeMDg/lY2DGg/iW0dNGKvxPvVcGBOpKR8sIq8o+T6c13g2mOyNBzizzT+urFubs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194518; c=relaxed/simple;
	bh=o5xNr6DtUx8g9odO1lXJfdA9nzh3i3zBHAPOqy5nfdo=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=VcVNKN9eufjWIGm8j9RsQQg57Y0dml9ilEurPruw8++bm99YYI3TOJaZ4u1VyD+Q/AFatDHdfPW+KbBU18Pvvdu92mw3PgEt8sQZog0R5//izDA191RhhpIDUVmExki0xTo46Y+nikiIEe8IZHtenqt8WE0Fgh1qzvPyomUITUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M1BkxyX1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60NBlRrv028543;
	Fri, 23 Jan 2026 18:55:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XsoRmR
	D1ZiJ61+EUd/GE/HQkcbtuQiouB6T8ovUbc2w=; b=M1BkxyX13xyqTERQ/y6EZo
	rIImfZnDX7hxhA8DC8itfS5zkA9J1IoOYJRLgU96QJxKNFLatxXeRWZTWGszL7jK
	+sEEmuU2qeU75F2rCSSUi3HPY1RkskbPQXJKUjbAn+CF9jS0pfzKV6MBzhQKGHAb
	AEIbC3IRBveD21gfHz2opwOv6j2ShijKjxyBXhiEfdoQ0Wbyr8Xmj2aVc15dfJpd
	CTBlbYxzKByQYjFhKZwFpfobwf/0Dw4y0364JLHhNcCyqJsZfzo3rrAGsxPmxOyb
	7LEkjaerFfVPyeAQGFv6iWPisHV/jb8ceWgpOQVAvFCwAZrNAlyCSI/3vlV2vr2Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt60f5evd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 18:55:12 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60NIfu7U009250;
	Fri, 23 Jan 2026 18:55:11 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt60f5ev6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 18:55:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60NGuVx2024614;
	Fri, 23 Jan 2026 18:55:10 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brxas93y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 18:55:10 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60NIt96N19792494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 18:55:10 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D04165805D;
	Fri, 23 Jan 2026 18:55:09 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4521158053;
	Fri, 23 Jan 2026 18:55:08 +0000 (GMT)
Received: from [9.111.3.186] (unknown [9.111.3.186])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Jan 2026 18:55:08 +0000 (GMT)
Message-ID: <ae149906c5e27513235c7f347b8b1dfed82b8dd1.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/2] PCI: Initialize RCB from pci_configure_device
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Haakon Bugge <haakon.bugge@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Alex Williamson
 <alex@shazbot.org>,
        Johannes Thumshirn	 <morbidrsa@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org"	 <linux-acpi@vger.kernel.org>
In-Reply-To: <7E4D523D-5105-4173-AC1A-8B7898DC48A8@oracle.com>
References: <20260122130957.68757-1-haakon.bugge@oracle.com>
	 <20260122130957.68757-2-haakon.bugge@oracle.com>
	 <a91e38085a9458455adccbaa18a0d80dd6797dcb.camel@linux.ibm.com>
	 <7E4D523D-5105-4173-AC1A-8B7898DC48A8@oracle.com>
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
Date: Fri, 23 Jan 2026 19:54:07 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=WMdyn3sR c=1 sm=1 tr=0 ts=6973c410 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=XVAkkidG5e-XMzfJVfoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: gOArTxeUhKHB_FVyWMEsWRBOdCQdoiFU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDE0MyBTYWx0ZWRfXxhDNLfX/BSpy
 ZW3qrlSGyyFpGsbJSERHIxJDXicujXCPwdKYyeoAq5yx4fHmUQOmoIerAaI+z8RcCKvx3voS3L8
 /PGyOThmHlmLSQTW5rK8PZZRIAvkLiNk0xeq8lb2xbcLBNP2j9we3FfNzc0CrOGjr2Ch2iDbjXw
 A1+DIrERxtnsNhW6F7INJRJ0genge1uV0pqk54LlLB3F+k527GsM69Q/E5yAeINMCLGLumL4cmZ
 vFqzX8jfPZbEZbIT5y1eghIOlQGIpcQnZPcG/rHcAy54tZ3iJFZid9r3xUWBJ9Frn12HgEOp97x
 wlsIpDWf8+aONXenExs7ctdvG2I1Y6JeHne4ltqL9WgFrlcm6TSt0WBIMlY11GOhFPzTp04rw0X
 t+/+vx8ZP7Zxl5OxkZrADYyAImQawVMVJ8PBRaAvxxb6f4scN2vUaZjUGl5zUQ4wfVg0/F/jKgL
 eYExJpLn03nAFln9ecw==
X-Proofpoint-ORIG-GUID: 8v8pkL0KXRsnmOwqyHN5H-1hVKq5o9XS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601230143
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[google.com,shazbot.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-20591-lists,linux-acpi=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schnelle@linux.ibm.com,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.993];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 30F4C79E2C
X-Rspamd-Action: no action

On Fri, 2026-01-23 at 17:38 +0000, Haakon Bugge wrote:
> > > On Thu, 2026-01-22 at 14:09 +0100, H=C3=A5kon Bugge wrote:
> > > Commit e42010d8207f ("PCI: Set Read Completion Boundary to 128 iff
> > > Root Port supports it (_HPX)") fixed a bogus _HPX type 2 record, whic=
h
> > > instructed program_hpx_type2() to set the RCB in an endpoint,
> > > although it's RC did not have the RCB bit set.
> > >=20
> > > --- snip ---
> > >=20
> > > +static bool pcie_read_root_rcb(struct pci_dev *dev, bool *rcb)
> > > +{
> > > +	struct pci_dev *rp =3D pcie_find_root_port(dev);
> > > +	u16 lnkctl;
> > > +
> > > +	if (!rp)
> > > +		return false;
> > > +
> > > +	pcie_capability_read_word(rp, PCI_EXP_LNKCTL, &lnkctl);
> > > +
> > > +	*rcb =3D !!(lnkctl & PCI_EXP_LNKCTL_RCB);
> > > +	return true;
> > > +}
> >=20
> > In principle this is one of these things where platforms like s390
> > where the root port is hidden (only s390?) might want a hook to use
> > firmware supplied information to determine if the hidden root port
> > supports the setting. I wonder if this would make sense as a __weak
> > pcibios_read_rcb_supported() function. Not saying we need this now,
> > just thinking out loud.
>=20
> That may be a good idea. But I am not quite sure how we can find the Root=
 Port from an "orphan" bridge or endpoint through the pci_bios_read set of =
interfaces.

I only meant to have it as a function in a similar manner to e.g.
pcibios_enable_device() that we could override. But I don't think that
needs or even should be part of this patch as there wouldn't be a user
of the override yet.

>=20
> > > +
> > > +static void pci_configure_rcb(struct pci_dev *dev)
>=20
--- snip ---
> > > +
> > > +	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnkctl);
> > > +	if (rcb) {
> > > +		if (lnkctl & PCI_EXP_LNKCTL_RCB)
> > > +			return;
> > > +
> > > +		lnkctl |=3D PCI_EXP_LNKCTL_RCB;
> > > +	} else {
> > > +		if (!(lnkctl & PCI_EXP_LNKCTL_RCB))
> > > +			return;
> > > +
> > > +		pci_info(dev, FW_INFO "clearing RCB (RCB not set in Root Port)\n")=
;
> >=20
> > The FW_INFO in here seems to be a remnant from ACPI code. As far as I
> > know this isn't usually used in core PCI code and seems conceptually
> > misleading to me since this doesn't come out of ACPI or other firmware
> > code.
>=20
> I humbly disagree. As per PCIe r7.0, sec 7.5.3.7: "Default value of this =
bit is 0b". So, if we find it set, and it is not set in the Root Port, to m=
e, it must be a firmware bug. And that is exactly what FW_INFO is intended =
for: "Introduce FW_BUG, FW_WARN and FW_INFO to consistenly tell users about=
 BIOS bugs" (commit a0ad05c75aa3).

Ah thanks for the pointer, I wasn't aware of this explicit "for
reporting FW issues" use. Reading commit a0ad05c75aa3 ("Introduce
FW_BUG, FW_WARN and FW_INFO to consistenly tell users about BIOS bugs")
now I agree this makes sense after all.

>=20
> > > +		lnkctl &=3D ~PCI_EXP_LNKCTL_RCB;
> > > +	}
> > > +
> > > +	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, lnkctl);
> >=20
--- snip ---
> >=20
> > I tested that this patch series does not create problems on s390 and
> > would leave the RCB setting as is if our firmware set it. Since the
> > second patch doesn't touch code that is build on s390 I think the
> > Tested-by only makes sense for this one.
> >=20
> > So feel free to add my:
> >=20
> > Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
>=20
> Thanks a lot for the testing!
>=20
> > Furthermore with either the FW_INFO dropped or Ilpo's suggestion
> > incorporated feel free to also add:
> >=20
> > Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
>=20
> Thanks for the conditional r-b. I'll like Bjorn to chime in here, as he i=
ntroduced FW_INFO and did not object to the existing (non Ilpo variant).

As stated above with the additional explanation this makes sense to me
now so no need for the conditional anymore either ;)

Thanks,
Niklas

