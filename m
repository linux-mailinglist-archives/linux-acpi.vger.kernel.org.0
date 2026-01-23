Return-Path: <linux-acpi+bounces-20584-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOq+D0hyc2lNvwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20584-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 14:06:16 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D684876218
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 14:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32ACE300A73D
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 13:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED8F2E5B09;
	Fri, 23 Jan 2026 13:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Eoc3mZdB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D15F261573;
	Fri, 23 Jan 2026 13:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769173571; cv=none; b=JZKV+tJpkeOKWe73RVn++6GHeeQC+9adzvfxRFIUubdV9AQuoOeegu0yMgYozcPazEgX6fa9tpCOVdDwyMK/o12APi6ylFsoOUmE/NKy37tViuwkUJ+qkzopZo5KATH77/fh+3gIveQO1JIUSx1S4Rqyht2ft2HKLSwShIFQ7eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769173571; c=relaxed/simple;
	bh=GjyNzYOyykyWYm5jpVE/NKa9raYK0xK2J9RvUiz9IB0=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=iVGEokEiRJQh4BiSYKtka4OVCh8fxz9LQUoLqUnj5HidsYGvThAUzLtEeigkR5ReZtCsZtpauyaQgdgDIBfGQQZGlNMGbySdCAYiF1LJhzpOVlhDo3oAFejkbvgsFHSNjBRwg5FUoihw7yeiJSgR4cRC6mlkhHrXlhyxbtZUugI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Eoc3mZdB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60NAmgBX009017;
	Fri, 23 Jan 2026 13:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cEr8HY
	WF5+T4yoBwO3/xxOnXIsLd2iM5qZQfVVjWgNo=; b=Eoc3mZdBYfA/LqB16t0s5D
	dH7ZYtWNt/tZ9TZV8cw/i6tmMO6Qm41R3ewsYz5jWejsAC1ZqR2h38R8lPOZsx8E
	IZlwKKsMXuG4HjD+VSQv3xNDs4TP+cyhLhrhvTq6ZJfSodUQgbHuX5qoDVy0RBhA
	7P2p5VP4PgdIXkfJkQ9Xe+i/DzUTjbnREqY7shtHJAPD+xzd5gf5df+mbwV/2Wk3
	/SVidCSNe+ZQdZbx8B3IfZ/TkqDjRjktjIhVd/lcLEIKzVhnV6/Z62UebjwYMyu7
	xsIyBzMxrcTUH5jxyHpHeA8ojpEX/8r3Rd+SIuXdml2pfyoF48+SieqV9wR0DkPw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bqyukpeay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 13:06:06 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60ND655N003855;
	Fri, 23 Jan 2026 13:06:06 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bqyukpeau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 13:06:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60N9wsPZ016679;
	Fri, 23 Jan 2026 13:06:05 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brn4yha3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 13:06:05 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60ND64cB38732472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 13:06:05 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 926D95805A;
	Fri, 23 Jan 2026 13:06:04 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 415FE5805E;
	Fri, 23 Jan 2026 13:06:03 +0000 (GMT)
Received: from [9.52.215.169] (unknown [9.52.215.169])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Jan 2026 13:06:03 +0000 (GMT)
Message-ID: <a91e38085a9458455adccbaa18a0d80dd6797dcb.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/2] PCI: Initialize RCB from pci_configure_device
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: =?ISO-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>,
        Bjorn Helgaas
	 <bhelgaas@google.com>
Cc: Alex Williamson <alex@shazbot.org>,
        Johannes Thumshirn
 <morbidrsa@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
In-Reply-To: <20260122130957.68757-2-haakon.bugge@oracle.com>
References: <20260122130957.68757-1-haakon.bugge@oracle.com>
	 <20260122130957.68757-2-haakon.bugge@oracle.com>
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
Date: Fri, 23 Jan 2026 14:05:01 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDEwNSBTYWx0ZWRfX+hMpjhCAuklo
 UXPmF81lsO8wiX8qsTzCywOMoIJcBFhzbwdmmThwrrvHUqdwAjBICiLBdeKZOGUAbaJsWnwunCm
 f5rQUwapLbLbVVdEpo/tr2BVY04Tov6Y1YiRZhBr5rMTlP6xrALRhgoBoo+0fdVypsVK1Uud06P
 Hsur2bt9LXxanIlGaHiNIomls3yES3aKDv3Ve+6F7jzziGqJ2VJokheg2Jk+GAxI9/6zAG0u8jw
 e+B8FV94S098HPDaHVrOrtk+GaSgznkltCDiOOwxo/nU/AwWtR3O4SwJ0YOSUxJ4W2NNXQD+Ieh
 YX/jim0m+C2m5ZvSNY2tM0I+s3VQG4viZhZpxA9XvvF6NA70r2P0a3Uy1m5SmM2EuFK4PXzsPno
 YaJcW75XvgNp0gHWu1RTTf9r7AsIO4rpaPDO6CnwDfyqdDczGjkOhXLJRM4gg4qxr3JTsIzPOsZ
 mMprzTkZS1fpvE+PzFw==
X-Authority-Analysis: v=2.4 cv=bsBBxUai c=1 sm=1 tr=0 ts=6973723e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=YbI6f_p0tAElbzXwulcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: tHNgYm2wYqfrQxVR77aKRSWl3iGUeMe6
X-Proofpoint-GUID: HJkgL1UdeGuk9G4TlIXlTdo_ltoikgfl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601230105
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[shazbot.org,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20584-lists,linux-acpi=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schnelle@linux.ibm.com,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.992];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D684876218
X-Rspamd-Action: no action

On Thu, 2026-01-22 at 14:09 +0100, H=C3=A5kon Bugge wrote:
> Commit e42010d8207f ("PCI: Set Read Completion Boundary to 128 iff
> Root Port supports it (_HPX)") fixed a bogus _HPX type 2 record, which
> instructed program_hpx_type2() to set the RCB in an endpoint,
> although it's RC did not have the RCB bit set.
>=20
--- snip ---
> =20
> +static bool pcie_read_root_rcb(struct pci_dev *dev, bool *rcb)
> +{
> +	struct pci_dev *rp =3D pcie_find_root_port(dev);
> +	u16 lnkctl;
> +
> +	if (!rp)
> +		return false;
> +
> +	pcie_capability_read_word(rp, PCI_EXP_LNKCTL, &lnkctl);
> +
> +	*rcb =3D !!(lnkctl & PCI_EXP_LNKCTL_RCB);
> +	return true;
> +}

In principle this is one of these things where platforms like s390
where the root port is hidden (only s390?) might want a hook to use
firmware supplied information to determine if the hidden root port
supports the setting. I wonder if this would make sense as a __weak
pcibios_read_rcb_supported() function. Not saying we need this now,
just thinking out loud.

> +
> +static void pci_configure_rcb(struct pci_dev *dev)
> +{
> +	u16 lnkctl;
> +	bool rcb;
> +
> +	/*
> +	 * Per PCIe r7.0, sec 7.5.3.7, RCB is only meaningful in Root
> +	 * Ports (where it is read-only), Endpoints, and Bridges.  It
> +	 * may only be set for Endpoints and Bridges if it is set in
> +	 * the Root Port. For Endpoints, it is 'RsvdP' for Virtual
> +	 * Functions. If the Root Port's RCB cannot be determined, we
> +	 * bail out.
> +	 */
> +	if (!pci_is_pcie(dev) ||
> +	    pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_ROOT_PORT ||
> +	    pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_UPSTREAM ||
> +	    pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_DOWNSTREAM ||
> +	    pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_RC_EC ||
> +	    dev->is_virtfn || !pcie_read_root_rcb(dev, &rcb))
> +		return;

This solves the concern Bjorn had for hidden root ports in VMs and I
confirmed that the check correctly bails on s390 even for PFs. Thanks!

> +
> +	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnkctl);
> +	if (rcb) {
> +		if (lnkctl & PCI_EXP_LNKCTL_RCB)
> +			return;
> +
> +		lnkctl |=3D PCI_EXP_LNKCTL_RCB;
> +	} else {
> +		if (!(lnkctl & PCI_EXP_LNKCTL_RCB))
> +			return;
> +
> +		pci_info(dev, FW_INFO "clearing RCB (RCB not set in Root Port)\n");

The FW_INFO in here seems to be a remnant from ACPI code. As far as I
know this isn't usually used in core PCI code and seems conceptually
misleading to me since this doesn't come out of ACPI or other firmware
code.

> +		lnkctl &=3D ~PCI_EXP_LNKCTL_RCB;
> +	}
> +
> +	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, lnkctl);

I do see Ilpo's point about pcie_capability_clear_and_set_word() and
agree that it would look cleaner. For good measure I tested with that
variant too and do prefer it, especially since it also gets rid of the
lnkctl variable. On ther other hand the message might help identify
weird firmware behavior. So no strong preference from my side.

> +}
> +
>  static void pci_configure_device(struct pci_dev *dev)
>  {
>  	pci_configure_mps(dev);
> @@ -2419,6 +2471,7 @@ static void pci_configure_device(struct pci_dev *de=
v)
>  	pci_configure_aspm_l1ss(dev);
>  	pci_configure_eetlp_prefix(dev);
>  	pci_configure_serr(dev);
> +	pci_configure_rcb(dev);
> =20
>  	pci_acpi_program_hp_params(dev);
>  }

I tested that this patch series does not create problems on s390 and
would leave the RCB setting as is if our firmware set it. Since the
second patch doesn't touch code that is build on s390 I think the
Tested-by only makes sense for this one.

So feel free to add my:

Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>

Furthermore with either the FW_INFO dropped or Ilpo's suggestion
incorporated feel free to also add:

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>

