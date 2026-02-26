Return-Path: <linux-acpi+bounces-21179-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mI8dH+Lrn2nYewQAu9opvQ
	(envelope-from <linux-acpi+bounces-21179-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 07:44:50 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 144771A1689
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 07:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BE1F304C09D
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 06:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A7638BF61;
	Thu, 26 Feb 2026 06:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LXyqSEwC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tgzt9bo8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C4338B7CD
	for <linux-acpi@vger.kernel.org>; Thu, 26 Feb 2026 06:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772088281; cv=pass; b=ZIlox9VEgPBvf4C0tvDrXJa0QrO0gBOV/lZlGKu1I9s2fx4NODrGbHphqwLOojEhu5gwpYU+oKeaKZ9Iezr9rjqMd4Hry8Tka4hBGGLRfyrD/+8v3CIwYMoZYKVC6T1VSPeTos6KMo2xLgWqxERnlHc3jSpObC9hOojgg0vGKFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772088281; c=relaxed/simple;
	bh=pAU3JAU84JmGKm87jtWoCRvQvPPVCrmccbK+z53wNO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sO3Edr+Qh78xQPqsrV5tpBRQ66D9OgB2pGAFNA8EauT8xSpKnZdBOzj0lwWngMoBd79hVBlwBlvVgFiqu+LtSFw5YTtdLfy4peq8qQm+zptMR3MawbaAohDG7wJrcK4Z7c3UyflRF8dwUbyahQEXFZZPnbPBcxPcp7J5K+Mni4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LXyqSEwC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Tgzt9bo8; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q4VRr4576511
	for <linux-acpi@vger.kernel.org>; Thu, 26 Feb 2026 06:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	feLzlxQHC4cwWCidFRZFj0vPLV0yL+/3P9Ho77Du94Q=; b=LXyqSEwCxTLss82O
	KGTevmugKHsamOfer4V1RKk1N+rnb8x4W4EpbCeyBwJo059YXIxwKS9h9vPsme3z
	35pbJiCgB5E3GBpsjjmwXzXmbX6E3h2+JKAPgk38ATFgaa1GYqztgV1XMe6OjNkX
	VHFwUFtgzR/SfB4KyIPNNeO8V0cpEoL9bHtP+XGlC87iM0H+m8yNA+WKF7YPgbm/
	REetkHs/b2ZQUJu+FGGR2C4a/sWgZqmVR8K6+pBjzJyBBOazfgPz7MGjcPwOOi3u
	8CUfSLEdsPoXWRGL8c8QMNt8TRoLv2OnZKoe6DcGMXLoAvTjKIjjWKWTWxxwraz1
	HBXEQA==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cj350jj0r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 26 Feb 2026 06:44:39 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7d4c7afa9e0so7600981a34.0
        for <linux-acpi@vger.kernel.org>; Wed, 25 Feb 2026 22:44:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772088278; cv=none;
        d=google.com; s=arc-20240605;
        b=DkIdhpvwU1G8vWPdMwqs34Pr3BM2Y2kaO7NPmYb9pujcA2zwXuN7C+2dFcawLKogpw
         PS5/cucgnJokfGPUQS6iSTMcWwZ4qDdGBep3DThrWyhF+9rhROe+IKNFWLXKAqwcDdTF
         F2I3EjmWK2QHrD8V/p/exp/eQIGQ8ZyaehrLZ2JsjMrDtl3W8xA8HG03KvyCaLlaHsPd
         wC+Mrt+L+L93e7xhGKdNarrVwswl3rRVM3JYyWgNsJ3RayjL8CXvmc3d5qX7r+NflmxU
         4l7pu4nudGxkFkJwT7ZU61JQI8nMmAASSad5UD950xpCaU37zeS0zSVgUk1T+FpLeN+Q
         y44g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=feLzlxQHC4cwWCidFRZFj0vPLV0yL+/3P9Ho77Du94Q=;
        fh=VWBq9vKAj8vXAhGaWjj3XY3ES9YDkp+3YRME2MV/Fc4=;
        b=BKASmfasfA4CCcOFXjK7f7l0hMqeCRGzUVrVGrHJioU+DAa1cfPDEDBnPgSbQmaXiH
         EGTphUmx8xIoY6eKFDcoYhiE6AesM3xlatUxOFkKWo5O17nm2Rz26ZEPDXSAAYq0mxMs
         gCXQd1OSJYDrYmf/1f3JIA96HR6ItPIp+4r0zNrmGGbwwVwGj3z5vxiYoKfjUkhZhLrs
         IBDwQ8poIQ/l2vCMcw8UjYKXv6qyxIXJIabEQh+uA9Lw6XzAfyHNhtDkUH883Fcvill7
         ticlvjgvOpdOoyWUukK/ZraeYASVQ7YXJbXbxt6tRXMgkJJtKd8y8/Er7yDds1IH3wMi
         hgFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772088278; x=1772693078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feLzlxQHC4cwWCidFRZFj0vPLV0yL+/3P9Ho77Du94Q=;
        b=Tgzt9bo87XPUdl0Ue9MvM40TudIZ0Wl2yBiWGD60JxnOhX0+JarV81wsyIOjLjaTgn
         jeRGDAGkPYWinj9oRN4HltE2hR/BZziErUzs75dgqif/C0D2VPyyphqE4NSQn5WZMYhe
         wfHX1VMnFyDxK8zIx6ifZTim2ZbCGtG7ruWi8ET2wNTv5ILx0qPScS7/UMzx3u44LI1Q
         ixEVNbz4gVz2kfyEKbtSpQ6CrIev/GFOdtjx/ue8c0JHt8Ssq6qV3HltDQoUf3o+9Z48
         B1+znb8VFxbSKFl3hfCLwQsU3tvsYEAdl0R+UZdzjbFH3Q3TF7Q5aAbQ7VQtAf2LqOX3
         T2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772088278; x=1772693078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=feLzlxQHC4cwWCidFRZFj0vPLV0yL+/3P9Ho77Du94Q=;
        b=LZs3+y9y84Z8swBvypFkApHnrD7+qoY/v1MDQpt17izwvwraR/MtMWx7I4i0LlCEx+
         vNdOSyxqwq/Ddy3zqJdobzTwX3RrD7eApDH1vb69oWHH7t+FIYMYDgKy3Ie9ruiTisiI
         jA3YBMMdJZG5IxC8UaOQwTmvShwlazdHi2YHH/JLwb/w+sUkCOmxY0S+tVrlK1Czt/mA
         5ufskEH3O/60DfYEUJooLRdUMdhHrGz2heXHDN4fW5bA7LZ9pDS6VYi/BfUmAQu+/Br6
         1vh0GPz/AoW38DECQUbQCQKHg59E5/rtY0L5y96i3XKoC1Xu7U3cA4VkAvihw8dLFjTm
         VNSg==
X-Forwarded-Encrypted: i=1; AJvYcCUA5EwQSU8X2eLvI9fs4jVnEu6zUsGTeKJq9tnM+gXqFALOCNZg5pV/HvVNHg0SaX27apZiD0gxLdyA@vger.kernel.org
X-Gm-Message-State: AOJu0YwsNa8QHLKyneBB5hoAlpIjQmbiJkv308QVRh49h+8ts6JlduAj
	vb+qmueRvz0wsR6BCZOSSOIOcbJ7WD9lZ64TLDsim4kGqt90nTl6dyCF+kz/cw0KUtCbayXbzoy
	efYmLmnsl8KwTDXiBpw0OfaJ7NyR4Yx3h05tF6w/Z+C1pT/qwr3n/sh3Us4xHXIIiIzM7VFWBfi
	Taz7OW8uPHd8G18TGyLjzNPDYkPmupAwBzZ9n5x/E=
X-Gm-Gg: ATEYQzwroT+SbH/+z0UKy+oq/xY0sSSjNHWDGyiuC+jGV7dQhyjNQk7wsg5i4V1EZit
	JSHKtisPu2t3OeTdRFN9pBPd98x3ZOxubHrkVuw4l9s3VxPve8vE+xlUM+rpVf0UYgRUwwYFzAb
	FYdF3AuhGg50a8+9d++Uyh+E8pr+CrDBTDJfYO6JPGEVYqXN8QV98x/0Vbcy3gMBp1x2iO264f7
	x0+IVE=
X-Received: by 2002:a05:6830:2a17:b0:7cf:d819:a2d2 with SMTP id 46e09a7af769-7d52bf512camr11500516a34.31.1772088278229;
        Wed, 25 Feb 2026 22:44:38 -0800 (PST)
X-Received: by 2002:a05:6830:2a17:b0:7cf:d819:a2d2 with SMTP id
 46e09a7af769-7d52bf512camr11500510a34.31.1772088277848; Wed, 25 Feb 2026
 22:44:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-0-347fa2d7351b@arm.com>
 <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-1-347fa2d7351b@arm.com>
In-Reply-To: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-1-347fa2d7351b@arm.com>
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Date: Thu, 26 Feb 2026 12:14:26 +0530
X-Gm-Features: AaiRm51ZQEVzQPuSNRCFd13Five9fB0P9HahXQ78_EQWjVuCiTnlrkcRyhMOVfQ
Message-ID: <CA+Ht8=a9a-zB_kEt1ZHFeTWSYGn4o3MRuHdXY9FDWWNZ=gc-Yg@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] ACPI: APEI: GHES: share macros via a private header
To: Ahmed Tiba <ahmed.tiba@arm.com>
Cc: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dmitry.Lamerov@arm.com, catalin.marinas@arm.com, bp@alien8.de,
        robh@kernel.org, rafael@kernel.org, will@kernel.org, conor@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        krzk+dt@kernel.org, Michael.Zhao2@arm.com, tony.luck@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: VSHiIBCODFotkGjuPS9X9kcKOLTEMa5g
X-Authority-Analysis: v=2.4 cv=Zs/g6t7G c=1 sm=1 tr=0 ts=699febd7 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=7CQSdrXTAAAA:8 a=el1Gr4cE1T2VXIUlPsIA:9
 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA1OCBTYWx0ZWRfX7tuxsvXcAuUM
 Pct4voC0ptkAaozzBWc756Em5A5mvvhVGOfspEaZuEx1+gkTZxM7iuE4gOiVXqesAftUvRVUpSJ
 ZqGk+zAOxDtiOeLMFS3Jv2A6l2oIp6ej4oQvN2c0cQzsuwB6v0dqsTYpSj8aTYCJ+IdVJ4Go6v9
 ErFzDKiXemR5ESisJovjs/3TcyzOhOpb2i4k9zVa1yR/XhHDiF8UsfSk5rI2XCX0CpKNYkDrJl7
 3PXgLUjsaAQgdZFxmyt+mnOqrIZM2f+0YYMR/uWqq+UZ3JreJxUe6teRrtnX5Bc3TnQtmlSm3Wk
 /PmD8dAaARNH/7zyxHGKo4L5tpVdgsfkqeQD4F6yXjDPDBhBllsYmxnRuWG80LjrvdVHX1tBjZ/
 tDcONRJwQf83WdFOLEMQHd+Xunfa+PYVSBl2TunTdI7q2Zr7DenKnmTHvUAKu58U6ptaQoSvWnz
 5NNAWNnyZqoNOIXvQ7Q==
X-Proofpoint-ORIG-GUID: VSHiIBCODFotkGjuPS9X9kcKOLTEMa5g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260058
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21179-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[himanshu.chauhan@oss.qualcomm.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,mail.gmail.com:mid,arm.com:email]
X-Rspamd-Queue-Id: 144771A1689
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 7:13=E2=80=AFPM Ahmed Tiba <ahmed.tiba@arm.com> wro=
te:
>
> Carve the CPER helper macros out of ghes.c and place them in a private
> header so they can be shared with upcoming helper files. This is a
> mechanical include change with no functional differences.
>
> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
> ---
>  drivers/acpi/apei/ghes.c | 60 +-----------------------------
>  include/acpi/ghes_cper.h | 95 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 96 insertions(+), 59 deletions(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index f96aede5d9a3..07b70bcb8342 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -49,6 +49,7 @@
>
>  #include <acpi/actbl1.h>
>  #include <acpi/ghes.h>
> +#include <acpi/ghes_cper.h>
>  #include <acpi/apei.h>
>  #include <asm/fixmap.h>
>  #include <asm/tlbflush.h>
> @@ -57,40 +58,6 @@
>
>  #include "apei-internal.h"
>
> -#define GHES_PFX       "GHES: "
> -
> -#define GHES_ESTATUS_MAX_SIZE          65536
> -#define GHES_ESOURCE_PREALLOC_MAX_SIZE 65536
> -
> -#define GHES_ESTATUS_POOL_MIN_ALLOC_ORDER 3
> -
> -/* This is just an estimation for memory pool allocation */
> -#define GHES_ESTATUS_CACHE_AVG_SIZE    512
> -
> -#define GHES_ESTATUS_CACHES_SIZE       4
> -
> -#define GHES_ESTATUS_IN_CACHE_MAX_NSEC 10000000000ULL
> -/* Prevent too many caches are allocated because of RCU */
> -#define GHES_ESTATUS_CACHE_ALLOCED_MAX (GHES_ESTATUS_CACHES_SIZE * 3 / 2=
)
> -
> -#define GHES_ESTATUS_CACHE_LEN(estatus_len)                    \
> -       (sizeof(struct ghes_estatus_cache) + (estatus_len))
> -#define GHES_ESTATUS_FROM_CACHE(estatus_cache)                 \
> -       ((struct acpi_hest_generic_status *)                            \
> -        ((struct ghes_estatus_cache *)(estatus_cache) + 1))
> -
> -#define GHES_ESTATUS_NODE_LEN(estatus_len)                     \
> -       (sizeof(struct ghes_estatus_node) + (estatus_len))
> -#define GHES_ESTATUS_FROM_NODE(estatus_node)                   \
> -       ((struct acpi_hest_generic_status *)                            \
> -        ((struct ghes_estatus_node *)(estatus_node) + 1))
> -
> -#define GHES_VENDOR_ENTRY_LEN(gdata_len)                               \
> -       (sizeof(struct ghes_vendor_record_entry) + (gdata_len))
> -#define GHES_GDATA_FROM_VENDOR_ENTRY(vendor_entry)                     \
> -       ((struct acpi_hest_generic_data *)                              \
> -       ((struct ghes_vendor_record_entry *)(vendor_entry) + 1))
> -
>  /*
>   *  NMI-like notifications vary by architecture, before the compiler can=
 prune
>   *  unused static functions it needs a value for these enums.
> @@ -102,25 +69,6 @@
>
>  static ATOMIC_NOTIFIER_HEAD(ghes_report_chain);
>
> -static inline bool is_hest_type_generic_v2(struct ghes *ghes)
> -{
> -       return ghes->generic->header.type =3D=3D ACPI_HEST_TYPE_GENERIC_E=
RROR_V2;
> -}
> -
> -/*
> - * A platform may describe one error source for the handling of synchron=
ous
> - * errors (e.g. MCE or SEA), or for handling asynchronous errors (e.g. S=
CI
> - * or External Interrupt). On x86, the HEST notifications are always
> - * asynchronous, so only SEA on ARM is delivered as a synchronous
> - * notification.
> - */
> -static inline bool is_hest_sync_notify(struct ghes *ghes)
> -{
> -       u8 notify_type =3D ghes->generic->notify.type;
> -
> -       return notify_type =3D=3D ACPI_HEST_NOTIFY_SEA;
> -}

All this has nothing to do with CPER which is defined in UEFI. All of
this is part of the GHES structure defined in ACPI. Why are these
being moved to ghes_cper.h.
It is blurring out the demacations. If you are caving out CPER
helpers, please don't move GHES helpers. The better place to move
these helpers is ghes.h otherwise they are good where they are.

> -
>  /*
>   * This driver isn't really modular, however for the time being,
>   * continuing to use module_param is the easiest way to remain
> @@ -165,12 +113,6 @@ static DEFINE_MUTEX(ghes_devs_mutex);
>   */
>  static DEFINE_SPINLOCK(ghes_notify_lock_irq);
>
> -struct ghes_vendor_record_entry {
> -       struct work_struct work;
> -       int error_severity;
> -       char vendor_record[];
> -};
> -
>  static struct gen_pool *ghes_estatus_pool;
>
>  static struct ghes_estatus_cache __rcu *ghes_estatus_caches[GHES_ESTATUS=
_CACHES_SIZE];
> diff --git a/include/acpi/ghes_cper.h b/include/acpi/ghes_cper.h
> new file mode 100644
> index 000000000000..2597fbadc4f3
> --- /dev/null
> +++ b/include/acpi/ghes_cper.h
> @@ -0,0 +1,95 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * APEI Generic Hardware Error Source: CPER Helper
> + *
> + * Copyright (C) 2026 ARM Ltd.
> + * Author: Ahmed Tiba <ahmed.tiba@arm.com>
> + * Based on ACPI APEI GHES driver.
> + *
> + */
> +
> +#ifndef ACPI_APEI_GHES_CPER_H
> +#define ACPI_APEI_GHES_CPER_H
> +
> +#include <linux/workqueue.h>
> +
> +#include <acpi/ghes.h>
> +
> +#define GHES_PFX       "GHES: "
> +
> +#define GHES_ESTATUS_MAX_SIZE          65536
> +#define GHES_ESOURCE_PREALLOC_MAX_SIZE 65536
> +
> +#define GHES_ESTATUS_POOL_MIN_ALLOC_ORDER 3
> +
> +/* This is just an estimation for memory pool allocation */
> +#define GHES_ESTATUS_CACHE_AVG_SIZE    512
> +
> +#define GHES_ESTATUS_CACHES_SIZE       4
> +
> +#define GHES_ESTATUS_IN_CACHE_MAX_NSEC 10000000000ULL
> +/* Prevent too many caches are allocated because of RCU */
> +#define GHES_ESTATUS_CACHE_ALLOCED_MAX (GHES_ESTATUS_CACHES_SIZE * 3 / 2=
)
> +
> +#define GHES_ESTATUS_CACHE_LEN(estatus_len)                    \
> +       (sizeof(struct ghes_estatus_cache) + (estatus_len))
> +#define GHES_ESTATUS_FROM_CACHE(estatus_cache)                 \
> +       ((struct acpi_hest_generic_status *)                            \
> +        ((struct ghes_estatus_cache *)(estatus_cache) + 1))
> +
> +#define GHES_ESTATUS_NODE_LEN(estatus_len)                     \
> +       (sizeof(struct ghes_estatus_node) + (estatus_len))
> +#define GHES_ESTATUS_FROM_NODE(estatus_node)                   \
> +       ((struct acpi_hest_generic_status *)                            \
> +        ((struct ghes_estatus_node *)(estatus_node) + 1))
> +
> +#define GHES_VENDOR_ENTRY_LEN(gdata_len)                               \
> +       (sizeof(struct ghes_vendor_record_entry) + (gdata_len))
> +#define GHES_GDATA_FROM_VENDOR_ENTRY(vendor_entry)                     \
> +       ((struct acpi_hest_generic_data *)                              \
> +       ((struct ghes_vendor_record_entry *)(vendor_entry) + 1))
> +
> +static inline bool is_hest_type_generic_v2(struct ghes *ghes)
> +{
> +       return ghes->generic->header.type =3D=3D ACPI_HEST_TYPE_GENERIC_E=
RROR_V2;
> +}
> +
> +/*
> + * A platform may describe one error source for the handling of synchron=
ous
> + * errors (e.g. MCE or SEA), or for handling asynchronous errors (e.g. S=
CI
> + * or External Interrupt). On x86, the HEST notifications are always
> + * asynchronous, so only SEA on ARM is delivered as a synchronous
> + * notification.
> + */
> +static inline bool is_hest_sync_notify(struct ghes *ghes)
> +{
> +       u8 notify_type =3D ghes->generic->notify.type;
> +
> +       return notify_type =3D=3D ACPI_HEST_NOTIFY_SEA;
> +}
> +
> +struct ghes_vendor_record_entry {
> +       struct work_struct work;
> +       int error_severity;
> +       char vendor_record[];
> +};
> +
> +static struct ghes *ghes_new(struct acpi_hest_generic *generic);
> +static void ghes_fini(struct ghes *ghes);
> +
> +static int ghes_read_estatus(struct ghes *ghes,
> +                     struct acpi_hest_generic_status *estatus,
> +                     u64 *buf_paddr, enum fixed_addresses fixmap_idx);
> +static void ghes_clear_estatus(struct ghes *ghes,
> +                       struct acpi_hest_generic_status *estatus,
> +                       u64 buf_paddr, enum fixed_addresses fixmap_idx);
> +static int __ghes_peek_estatus(struct ghes *ghes,
> +                       struct acpi_hest_generic_status *estatus,
> +                       u64 *buf_paddr, enum fixed_addresses fixmap_idx);
> +static int __ghes_check_estatus(struct ghes *ghes,
> +                        struct acpi_hest_generic_status *estatus);
> +static int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
> +                       u64 buf_paddr, enum fixed_addresses fixmap_idx,
> +                       size_t buf_len);
> +
> +#endif /* ACPI_APEI_GHES_CPER_H */
>
> --
> 2.43.0
>
>

