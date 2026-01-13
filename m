Return-Path: <linux-acpi+bounces-20222-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AC1D17590
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jan 2026 09:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 924BD3013952
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jan 2026 08:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BD63806C6;
	Tue, 13 Jan 2026 08:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oCRv0Yc7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XYHweU2r"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72ED350A0C
	for <linux-acpi@vger.kernel.org>; Tue, 13 Jan 2026 08:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768293730; cv=none; b=gtw2Q/OEWMOslf5BcYeiSlocxFVIttyCd5ipktTfLe4SxjKFPlhHGX2lI6yJr2UfkzOa2G+VLIimO78hhHHX0/9sRo43NNRwwTwdqRjSbuDoCkorgog/pifINbmHpUzOZEw+FlRKMr2zQIEhHxkUpc1TTrHJGeyvveqOflVYFQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768293730; c=relaxed/simple;
	bh=5RecTGm365RUoJMEkqeB/sqOi4xLmrfY6YTWJNvhWmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ihmm1tVYn4C/rHAo3iBgSFkiu9QJCKhfRPtrUVhI1LMTpmQpo+cX8M6EMJGqJNeTZCsDJyh57SG1cb00uOn+AbkjuOxfC/0w21rz7jGIC/ZAC//780O+01BR5Y+V4ux30m1j/N1S07aHV72BKyV+Ou8pi/a5BaOAp7rOX8mZi94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oCRv0Yc7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XYHweU2r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D1tciE2751721
	for <linux-acpi@vger.kernel.org>; Tue, 13 Jan 2026 08:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=gMMQfkmso6EqTlKeQEIEJn6dTWYUS6uAjenTpc28WAg=; b=oC
	Rv0Yc7voplOJZGPIG+HGVNrv1yJUbGTtAr/0T90J5xBbbGRXbHTsT4PZQDK187Sd
	5dq9JJmBcFMqj3K9w8ns7D1vIt4EUn9Q5BeStCe3AMyVdBx40d+owdeDUjE2fQIS
	WW40/Ja0zGgBx4fJ0SEkTlPOP96lOPK18PN1K6X3yiJgzKGTqgiShP5DM/i6rFOV
	BV2v28SOxRuzDuFigKIM4g8VRfwYsR1QVOds9J3iz3J8pCv0ebYmNfbbQ/4lfCbd
	rp7jdJgfzwr1gMGL9LMgDeCsO0YPajQYgtx8WdlXch7AuxXggLFxLdM3VZ8GleRH
	QbsEJ6SWkMi0tkd0UcGQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bnctjs1yp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 13 Jan 2026 08:42:06 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-88a2cc5b548so153066666d6.0
        for <linux-acpi@vger.kernel.org>; Tue, 13 Jan 2026 00:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768293726; x=1768898526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gMMQfkmso6EqTlKeQEIEJn6dTWYUS6uAjenTpc28WAg=;
        b=XYHweU2rYrFhUsRdcRuRg68Fg9qhukLxGg6VyA0Sq7XUVN84sanBBYcK+7T91Gs+Xk
         ljJD/OrlGJPzs+4eHBeH/Tmz76t7nPxKigId6Tn8UOdOEpnFGC152/LCb6tZ5dxR3LZ9
         5zyqV3TMbO0SNxVruD+WL/nDtDhK6uM5qFJ3/tZDhhirUczjflDLsUEOSuy3luB6+44l
         N8Ff6R2kzV+1IN2FyI6027r/nYk/0oT2agbAJhri4bocjP4x8oJTamP146pwnA8QA3EE
         TylxyTmrTgv4bbltaMH8quWJTG5axHXb2p/rd3Jdl8ViyEF8flgH0aojybq9zROai4cR
         uRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768293726; x=1768898526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gMMQfkmso6EqTlKeQEIEJn6dTWYUS6uAjenTpc28WAg=;
        b=olGmMIVWU+s+6WbLWZeO4kcNLZ+arT8aia/XCdJwFyUaHpLzp9atFjAydnyQXYIxfa
         PGdArA2Gg9taz7iq4AFV8WU0Gf5N5jCOgF/wn0zFPfVOXeOCDpXtKfiXmG6TM+DrRweH
         p8WQBKJQv8CKdT9kamT8jZpRzrqtfOTPd/Cciw52nofegut/AEWXFBtfZM0oQan6H65K
         EXFSiRjMSh2BD3v/hy7MDX6g1sOL9hHOUGCAuD1lgmVAOVtk3Lesr6g01gTEkfcwbHED
         By2KHMGj1puHQY0HwEODkePV1GfymOJ2nDcMEK3nbypUqi+651sh7MMjpcuh3IP3WDin
         sv8g==
X-Forwarded-Encrypted: i=1; AJvYcCUYDWAEIMYL5sOS3UYW9nrX62liup5omxDaYxo5Jk6NBxYbNW3K8EjlHBK/4gXhK0ZZM5hSZ3Sxioga@vger.kernel.org
X-Gm-Message-State: AOJu0YwXMHjytU4A0y3sCy1OdDT0ZfEpamj0bzLOqMKkWGPqJQXL6v2w
	y0YAdkcMHgyLK+SEGFHapzEn1QwOZegujKm9Bzcuu42Szcfr+aqoaiJfs6iKFK/PZXVkh8EnvYq
	nzLKrsirCDFl6vHpfXdN/4GycjiQFFzEmWNtwMDw5xnVdP5tlmQtOZQRK0Od6PVKO9TZYIMIjmH
	/YifSZgJziTweO7hTrv4Co6Az45u1byfLfkWwfqEk=
X-Gm-Gg: AY/fxX4BvWeB/lsgjs/HRz9+YhSqIbS4/uWYhrP5i+OMwsbmkbT6oYAFqpXnxXihqDh
	8x2T0KHjFHlBWwMtSr8get995ywY4nApPdFTjFE4FzbJHdJbDBRHT61x3JgSAHscF7iFE9EFGex
	KmW3vjdFWl7u6qpdlSRUkOGhRtGklrYtWSqmK9kOXXaYYaNgBZL6EqMj4+YUQdQzgRxg==
X-Received: by 2002:a0c:e017:0:b0:880:4272:9a4e with SMTP id 6a1803df08f44-892661a78a8mr25805606d6.10.1768293725690;
        Tue, 13 Jan 2026 00:42:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJYJUOMDvWx4l8hA/velk17KC5jXEUWmnRlBHDEYXsu1TKZmLa9YbgjQfnsevRZSrydtA0WA9PnjG8rM9/N9s=
X-Received: by 2002:a0c:e017:0:b0:880:4272:9a4e with SMTP id
 6a1803df08f44-892661a78a8mr25805426d6.10.1768293725320; Tue, 13 Jan 2026
 00:42:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109090224.3105465-1-himanshu.chauhan@oss.qualcomm.com> <20260109090224.3105465-8-himanshu.chauhan@oss.qualcomm.com>
In-Reply-To: <20260109090224.3105465-8-himanshu.chauhan@oss.qualcomm.com>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 14:11:54 +0530
X-Gm-Features: AZwV_Qh9cMywaFsFi6xL1Dz9DO_-xJHelf2IMNiJrFuansm4cMH8oxrnVD1xemI
Message-ID: <CAB19ukFj7BiyikY7Bmnu5uWidZcBhL7Vg+Yhc8exstKj_UnRhg@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] riscv: Add RISC-V entries in processor type and
 ISA strings
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA3MiBTYWx0ZWRfX6mUjwLeWGCxl
 JyRHcMXERGXC/E9oaTEyQ+OjXS0T3zkqHrQ4aYUc4uCv8QPMWe3M41oOGw1/Fb1R2gd0O4h4w67
 hWxlUdWxfI7vNM6i1wJ/U5U5ItzrVwhNlF4b+EbjPYMBXSrc0wvbtYghK+/8gBCAE0iTd9bAkpp
 0PNqqJJdHMS2irU8ozTpRq9mebG4dkpvkcIMBzZyGtt2SZKn9j277FDF37PEgLtMnuEIjrcDrBZ
 z/siNmx6iAuTy96yd2ZhEhJqKy112sXLcuxgnPchnX+NiR3VhO+xFQxA2938KXbG8/iFczhuLJO
 SDR9RLhi9QlonPd+auiCY1HeejBXB4rjxlpWGa9YSclIqXW+xdVemkt8ZbIMLVOlTjXfSz1gnEx
 Bh/UX0CHHRSdPFJhF4olOeI80kdEpJOETvmuoZnMoDB88sW2tDaK1MM3kDQlpuzM23pPM0shYEU
 ZGowD4TkTI3gyjI/CRA==
X-Authority-Analysis: v=2.4 cv=Ls2fC3dc c=1 sm=1 tr=0 ts=6966055e cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=xWNtRwkhHlcOdG438WIA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: eYpkxT21P8hR788TXT5_TWZhYV53sUcI
X-Proofpoint-GUID: eYpkxT21P8hR788TXT5_TWZhYV53sUcI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601130072

Hi Himanshu,

On Fri, Jan 9, 2026 at 2:33=E2=80=AFPM Himanshu Chauhan
<himanshu.chauhan@oss.qualcomm.com> wrote:
>
> Add RISCV and RISCV32/64 strings in the in processor type and ISA strings
> respectively. These are defined for cper records.
>
I think it is better to add the reference to the ECR in the commit message.

> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> ---
>  drivers/firmware/efi/cper.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 0232bd040f61..9d591a294327 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -170,6 +170,7 @@ static const char * const proc_type_strs[] =3D {
>         "IA32/X64",
>         "IA64",
>         "ARM",
> +       "RISCV",

This should be "RISC-V" as per the ECR.

>  };
>
>  static const char * const proc_isa_strs[] =3D {
> @@ -178,6 +179,8 @@ static const char * const proc_isa_strs[] =3D {
>         "X64",
>         "ARM A32/T32",
>         "ARM A64",
> +       "RISCV32",
> +       "RISCV64",

This should be "RV32/RV32E" and "RV64" as per the ECR approved.

Thanks,
Sunil

