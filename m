Return-Path: <linux-acpi+bounces-20114-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B946D0A606
	for <lists+linux-acpi@lfdr.de>; Fri, 09 Jan 2026 14:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B409B300B9ED
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Jan 2026 13:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5961D35BDDC;
	Fri,  9 Jan 2026 13:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WXhEiw/2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PLDwYgBf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFDD35BDDB
	for <linux-acpi@vger.kernel.org>; Fri,  9 Jan 2026 13:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767964910; cv=none; b=V0YyYn60TSPrKfCIx47oFKrK5dxMg9pFrZ6UxbbhCPQQV906VjRgB24OnGkZ9edIRPJgMrlVtCIhmv/nlHCn/Fa71D7HxnZFmfLNH88fV+RyqJ7w8qlcVs04b5voVwHECNICbiTHqVcJLpYtNhQANrKSY3LryTRHggRaoCrBRQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767964910; c=relaxed/simple;
	bh=eVCQ0zFZa3LMWhX4okqjj1sUXYynRau7Uwu2NGHlf4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ijsOAERzXDzfBR8T+L9hmbrRQDbXtZTx0ixkAcyczfYPdleb5Hz/jHTLmfawiFQTQeTWmE+u+vYBGifCc3aOL5JetTQjho68RQnZIUq+8sn5krogwnUYO30xcbKxFhxtYbx0XKJitbyCdiqnnJkl9TUHGby0Vqj+oSLMDWb/U5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WXhEiw/2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PLDwYgBf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 609D2WTb3019314
	for <linux-acpi@vger.kernel.org>; Fri, 9 Jan 2026 13:21:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=BJpvv9CAxjxya3vDiC3pvKGJRe500UKGEV+RGwaO2ls=; b=WX
	hEiw/2oKmYNFFdOqfMrcNoWZvCEqAypOl56bXLBwan+58yVJepe2ID5MXdOKx5Th
	svf0Hvm2K9pBhc5BaFMmbV6+ixlWG/qY7PUoPmPj6UQYkiYUSi1Zuexh9iym6On5
	OtOrOgO6976pOqwrSe+Pg1b0qq+rI01wWSmKgB5bvPUyRzdO2lOhYsJH4zOV81X8
	DUTESvIyxrLj3UaUcVWBd0d3oos4IN6JqirVx+/x8K+UbCXvzSVRKIvmIj9AQs/k
	5jmls5NVpKBnrJ95uT0v5OdFluZW1/o2jTQ+LwUCHoHai+/gdC6Eqm58vy/Idl0+
	zrDP8C+Rq+GjnXW6RD/w==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjjk3jubn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 09 Jan 2026 13:21:47 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88a360b8096so109091386d6.0
        for <linux-acpi@vger.kernel.org>; Fri, 09 Jan 2026 05:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767964907; x=1768569707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BJpvv9CAxjxya3vDiC3pvKGJRe500UKGEV+RGwaO2ls=;
        b=PLDwYgBfb6/gx+HbOVd6uXCw2Wa6epKfNL9Jlv3DmHZQPbldi2r2V2/HfrhEBTAW39
         eWM6KTGdoI6nnIYHfUy7n5HKTxF+U7zP8xMUMdSOSX6WysZ5aROYiU158wAfCYtpZVM4
         21jHFW80mZ+pepbVgiq9KK+8F1WlFSjYfCMOfnQPjHeNei+0XyHzYgXyogqpwvXQERZi
         SP32tNUVoH8KIvfXJ2ULAh6o74f71RU6Va5HNHnRpQ0rAfBA19lapRSzdimOS023cqLg
         o6jwt+noOLCx0h2Us74BSqHprVm3EQU3BLP5jjJq7aUyAuMCRbDITRS9SpMykunH+3BK
         dRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767964907; x=1768569707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BJpvv9CAxjxya3vDiC3pvKGJRe500UKGEV+RGwaO2ls=;
        b=TR0zOFMg5G2SybL4gHVWdVVYdPPNxr/Vzbw23L2qUaj4+9VhWPksvKmgV/gy4vK0Kx
         mC7PmOfpHg4YE+/+ZU/ZCeg+3BZIOUDbPGVbnMHPIlaFYxQmF2DJUiVouvGW/7CCYYr6
         p2uqVGzuDWtG1VVuN2JGLVswcWoib3vctNaga4LTKNVyllKHOLRpDPx9G6Jvzi8I77K/
         yOC5UxfE/FXtcSRUuKWZjhx4f31Wb03gzWHMul6Tw2bu3DU4SSQPAzRtCuQlmC8b2IIS
         mG9NvfbmASD2ykUP0Ji3cXpBBJwWK7wOQ4zz6ZgknIOzwQ8DGMW0YyQhubrtt5+JYxba
         4p+g==
X-Forwarded-Encrypted: i=1; AJvYcCVRNnZLGmpIgiTTjCSWTdHm0r7vIMOHJNgB/m7azmotMZedGtn8R8MVaU6BdMla/YP47bU3ns0+tqND@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ+C3jRgHp6mQHLksRsDNEvLVtv3brZSAlQHWGZ/QjMu8GEFQ3
	fAGV02c2g3sfL7mO/BQTzKh/bI/DMaiZCBIWMUZkDl2BOWqAAnoziQBTEHxU0/1GgDedhnM53h8
	yvPx8MZ5pxqaHYZryj8rrXKlaHrgbKDI4ASbZqN/HE52w3YjRp2uEOUU/jAMwtc16o81T+K2Dvq
	VH5Mu6lCJmMGCeLNSXpuVXDDskKSxcabfkA/vrr/S+ANVk36RwwQ==
X-Gm-Gg: AY/fxX7Wa2FAcev1D5pwdTfYec0+msCHs5ljgDrEeRb0ccbVpGrtxNbG80adB4+QBM0
	zq4qXkPQ5Oqb/glWTkBUFQy6cOuX8Xw+WLNPwumIVG/0wQAoiB+qhq2GqkYZ5PodDggOoAOCpDU
	u74hRk+mNnO2dV65Y4+LR7/qWmV8XomVD7oNL+VM4AyhgwI0sjQBsBsVAlpNF7XgNALMw=
X-Received: by 2002:a05:622a:14c8:b0:4ee:61f8:68d6 with SMTP id d75a77b69052e-4ffb485404emr127525381cf.6.1767964906822;
        Fri, 09 Jan 2026 05:21:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECkusQZQQHBVt2A44gSkXhBbZXUvr9pmoh9OZwBivjqjivaJRNE2lJCJ8geRdznbFg0XMQMJzEHdBSKjeUGqY=
X-Received: by 2002:a05:622a:14c8:b0:4ee:61f8:68d6 with SMTP id
 d75a77b69052e-4ffb485404emr127525011cf.6.1767964906406; Fri, 09 Jan 2026
 05:21:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109090224.3105465-1-himanshu.chauhan@oss.qualcomm.com> <20260109090224.3105465-4-himanshu.chauhan@oss.qualcomm.com>
In-Reply-To: <20260109090224.3105465-4-himanshu.chauhan@oss.qualcomm.com>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Fri, 9 Jan 2026 18:51:35 +0530
X-Gm-Features: AZwV_QjUVwGXO2R47NOUKBNVW8AqeLgnl_83gTKQ6qB3PBktNV8dMcQ64Qr-7zI
Message-ID: <CAB19ukG+_a+q8htOMxXnQRByprAmfPjCfNeHBh-3GqVeQbNMMg@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] acpi: Introduce SSE in HEST notification types
To: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com,
        anup.patel@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 0Jjft61ghgqynFAOfp1ztW7oxgt5jKui
X-Authority-Analysis: v=2.4 cv=EazFgfmC c=1 sm=1 tr=0 ts=696100ec cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=h0uksLzaAAAA:8
 a=a1NblK7KE1KWh-jXdIsA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=MSi_79tMYmZZG2gvAgS0:22
X-Proofpoint-GUID: 0Jjft61ghgqynFAOfp1ztW7oxgt5jKui
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA5OSBTYWx0ZWRfXxADoLWb4dswY
 lq0YB80aov8nJVXKSErMi6XEcUE94mjg9c4/D9jKLK3hOGWBQAiQA/lu5q60kiY2k46guw3uAxc
 CrDFJFGUCrzIGfKKd0pJHDOy7V7+yjzqUHMMbMQdxRIYf+7FmEmj5wN8pU9J9MiZ5KeUTFyoQsG
 9Sl8K2VRbc8PI7UILBrQg13XVsB+5GZMjDi26vv9yUB2p8WnglGYA3Fhj+7NEeCPYvCvNmMG1Ln
 zTAxffDCouaBq/dD4fK3P4wKFWVfzJ8sHKFRPWqq1QHCieslw0+rOn9DJBJdcTeIqZ8rNLhs+9+
 knIV7A4USRtI+eBDS8uDjCPVy9+eSXHT1/1wDKj6kgDhqavMddEkWyJ0ST4ZRhF1m5vJWIDvFIM
 Qzdoy3c9OBwjrNvePW48J3ZjwPtu4eQpP6AygT2ZUQF31YxDEhfnRutv4coz6MqKuZu6vZCBQ0R
 sy7hqyUWrEL9KFtyDKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_04,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090099

Hi Himanshu,

On Fri, Jan 9, 2026 at 2:32=E2=80=AFPM Himanshu Chauhan
<himanshu.chauhan@oss.qualcomm.com> wrote:
>
> Introduce a new HEST notification type for RISC-V SSE events.
> The GHES entry's notification structure contains the notification
> to be used for a given error source. For error sources delivering
> events over SSE, it should contain the new SSE notification type.
>
> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> Reviewed-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> ---
>  include/acpi/actbl1.h | 3 ++-
This is an ACPICA change. Please submit a PR to the ACPICA repo first.

Regards,
Sunil

